Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FADC46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D990E877DE;
	Tue, 19 Dec 2023 12:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VeMwjPRD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C8F871B1; Tue, 19 Dec 2023 11:13:35 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C70AD86FBD
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJADPwk051518;
 Tue, 19 Dec 2023 04:13:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702980805;
 bh=7S0ky+qLUv4mYZcZdN8bCTtgfz7kZfz83qDX7Rh0ot0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=VeMwjPRDfPHv0J/i6tRAkSl2z/eGDDJ0ESjCaAPHYKySqIMULbpynLB5cv4S4oFDG
 2RHf8N33bZ/mb3Ds7RHaCL8/ulLECUW5zykHoA3knPhqyLkQ3vBEeGV3+uupNNXvEA
 X4eR/Db85HJxJGB/jygwjpuMuUochSn9c7A/TVSU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJADPtj031792
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 04:13:25 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 04:13:25 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 04:13:25 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJADPYF089694;
 Tue, 19 Dec 2023 04:13:25 -0600
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3BJADOOn018974;
 Tue, 19 Dec 2023 04:13:24 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 14/16] tools/fdtgrep: Include __symbols__ table
Date: Tue, 19 Dec 2023 15:42:21 +0530
Message-ID: <20231219101225.3443978-29-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219101225.3443978-1-danishanwar@ti.com>
References: <20231219101225.3443978-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 19 Dec 2023 12:33:18 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This is required for overlays to work at SPL.

Loading of symbol table depends on DT Overlay support in SPL
so make it compile-time dependent. Without this SPL fails to
boot some platforms where this feature is not enabled
(e.g. dra71-evm.)

Without including the <linux/kconfig.h> file, the symbol
CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY will not be visible and
we will never include the symbol table.

So include <linux/kconfig.h>

Due to some reason it needs to be included after
[#include "fdt_host.h"] otherwise it causes a build error.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 tools/fdtgrep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index 7eabcab439..706b4a35f4 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -22,6 +22,8 @@
 #include "fdt_host.h"
 #include "libfdt_internal.h"
 
+#include <linux/kconfig.h>
+
 /* Define DEBUG to get some debugging output on stderr */
 #ifdef DEBUG
 #define debug(a, b...) fprintf(stderr, a, ## b)
@@ -1234,6 +1236,12 @@ int main(int argc, char *argv[])
 		disp.fout = stdout;
 	}
 
+	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY)) {
+		/* include symbol table */
+		if (value_add(&disp, &disp.value_head, FDT_IS_NODE, 1, "/__symbols__"))
+			usage("Cannot add __symbols__ value");
+	}
+
 	/* Run the grep and output the results */
 	ret = do_fdtgrep(&disp, filename);
 	if (disp.output_fname)
-- 
2.34.1

