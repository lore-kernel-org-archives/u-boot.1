Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E49BC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:05:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F064486ACC;
	Fri, 25 Aug 2023 20:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K+iv5kkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 901DB86AD8; Fri, 25 Aug 2023 20:03:24 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9763486AE2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PI36d8111940;
 Fri, 25 Aug 2023 13:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692986586;
 bh=+4gNje2LeF7zYUu8gc6ASvyA+sNFCP4/PnmPe1R3iO4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=K+iv5kkTr+fzbv2iYlSOAL3jSXoghrD36nqKwCbqQ22xjCpnvzFFvUUjuSdMHKxUY
 81ev5pRgscBWgnx9BfQwdSLvInl6WGsom8rLCOAeXX+YGDHaDLPsXSKmCviaboD8aj
 gPEqfzMg7Ub0ispSONTnQYhY/uQZ/zf1UhTHsMp8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PI36tA085964
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 13:03:06 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 13:03:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 13:03:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PI36LG038401;
 Fri, 25 Aug 2023 13:03:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 05/20] include: configs: am62x_evm: Wrap distroboot with
 CONFIG_DISTRO_DEFAULTS
Date: Fri, 25 Aug 2023 13:02:50 -0500
Message-ID: <20230825180305.69515-6-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230825180305.69515-1-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Wrap the distro_boot options with CONFIG_DISTRO_DEFAULTS.

This is an intermediate step for us to switch over to
CONFIG_BOOTSTD_DEFAULTS and drop this section in follow on patches.

Reviewed-by: Tom Rini <trini@konsulko.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
No change other than picking up reviews, tested tags along the way.

V5: https://lore.kernel.org/r/20230824031101.3460411-4-nm@ti.com

 include/configs/am62x_evm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/configs/am62x_evm.h b/include/configs/am62x_evm.h
index 379e0c13a395..81d7658cdb0d 100644
--- a/include/configs/am62x_evm.h
+++ b/include/configs/am62x_evm.h
@@ -9,8 +9,10 @@
 #ifndef __CONFIG_AM625_EVM_H
 #define __CONFIG_AM625_EVM_H
 
+#ifdef CONFIG_DISTRO_DEFAULTS
 #include <config_distro_bootcmd.h>
 #include <env/ti/mmc.h>
+#endif
 
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
-- 
2.40.0

