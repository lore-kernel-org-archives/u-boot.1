Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22258C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B9EB8657C;
	Thu, 24 Aug 2023 05:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EniJerrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A74833DB; Thu, 24 Aug 2023 05:11:26 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46F9286565
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O3BAWQ097621;
 Wed, 23 Aug 2023 22:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692846670;
 bh=CkcGmaSCgTooRcma+6FxQMtNCRTaMATplAHwm6wUC54=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EniJerrZuxMNdeggMADqC3xQXn/dWtHqOC//PsgIS4VGFrnB9bk97BiyAn3DnVXtv
 uTLPvAzn7RG8lJ0uYdT2e1hu9wlwMMU/yOuwEtEGHiETAEjdYHKgJiwUJpGHbxz/YU
 2Vo0MnPl+ucDTRJeSvdvFOOvIydYvao54Cy7q+2o=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O3BAcR030877
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 22:11:10 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 22:11:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 22:11:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O3BAYf006633;
 Wed, 23 Aug 2023 22:11:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V5 08/17] include: env: ti: ti_common: Add a generic findfdt
Date: Wed, 23 Aug 2023 22:10:52 -0500
Message-ID: <20230824031101.3460411-9-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230824031101.3460411-1-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
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

ti_mmc bootmethod uses a findfdt routine that is expected to be
implemented by all platforms.

Define a default findfdt based on configured DEFAULT_DEVICE_TREE option
for u-boot. This saves duplication across multiple boards and handles
architecture folder location changes centrally.

TI ARMV7 platforms will need to override default_device_tree_subarch
in the env file to point to the appropriate platform. Note: default
"omap" is used to cater to "most common" default.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
New patch (part of bootstd transition)

 include/env/ti/ti_common.env | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index e87a41a6590b..322f849a5560 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -32,3 +32,15 @@ bootcmd_ti_mmc=
 	else;
 		run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern;
 	fi;
+default_device_tree=CONFIG_DEFAULT_DEVICE_TREE
+default_device_tree_arch=ti
+#ifdef CONFIG_ARM64
+findfdt=
+	setenv name_fdt ${default_device_tree_arch}/${default_device_tree}.dtb;
+	setenv fdtfile ${name_fdt}
+#else
+default_device_tree_subarch=omap
+findfdt=
+	setenv name_fdt ${default_device_tree_arch}/${default_device_tree_subarch}/${default_device_tree}.dtb;
+	setenv fdtfile ${name_fdt}
+#endif
-- 
2.40.0

