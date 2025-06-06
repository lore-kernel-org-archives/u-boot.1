Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11512C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 22:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57AF982AA7;
	Sat,  7 Jun 2025 00:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C851D82B44; Sat,  7 Jun 2025 00:47:18 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1E3E82A9E
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 00:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8B016B4C3D2F;
 Sat,  7 Jun 2025 00:47:15 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v1 7/7] include: use lowercase hex prefix style
Date: Fri,  6 Jun 2025 15:45:02 -0700
Message-ID: <20250606224558.1117422-8-e@freeshell.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606224558.1117422-1-e@freeshell.de>
References: <20250606224558.1117422-1-e@freeshell.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use consistent lowercase hex prefix style in include/*

Signed-off-by: E Shattow <e@freeshell.de>
---
 include/fsl_esdhc.h     | 2 +-
 include/fsl_esdhc_imx.h | 2 +-
 include/mc13892.h       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/fsl_esdhc.h b/include/fsl_esdhc.h
index 7ab1460abc6..d1f441e19b5 100644
--- a/include/fsl_esdhc.h
+++ b/include/fsl_esdhc.h
@@ -88,7 +88,7 @@
 #define PRSSTAT_CINS		(0x00010000)
 #define PRSSTAT_BREN		(0x00000800)
 #define PRSSTAT_BWEN		(0x00000400)
-#define PRSSTAT_SDSTB		(0X00000008)
+#define PRSSTAT_SDSTB		(0x00000008)
 #define PRSSTAT_DLA		(0x00000004)
 #define PRSSTAT_CICHB		(0x00000002)
 #define PRSSTAT_CIDHB		(0x00000001)
diff --git a/include/fsl_esdhc_imx.h b/include/fsl_esdhc_imx.h
index 8612b56609e..cd8ed833771 100644
--- a/include/fsl_esdhc_imx.h
+++ b/include/fsl_esdhc_imx.h
@@ -97,7 +97,7 @@
 #define PRSSTAT_BREN		(0x00000800)
 #define PRSSTAT_BWEN		(0x00000400)
 #define PRSSTAT_SDOFF		(0x00000080)
-#define PRSSTAT_SDSTB		(0X00000008)
+#define PRSSTAT_SDSTB		(0x00000008)
 #define PRSSTAT_DLA		(0x00000004)
 #define PRSSTAT_CICHB		(0x00000002)
 #define PRSSTAT_CIDHB		(0x00000001)
diff --git a/include/mc13892.h b/include/mc13892.h
index d9ef53b1e48..a044a4c606d 100644
--- a/include/mc13892.h
+++ b/include/mc13892.h
@@ -161,7 +161,7 @@
 /* SWx Output Volts */
 #define SWX_OUT_MASK	0x1F
 #define SWX_OUT_1_25	0x1A
-#define SWX_OUT_1_30    0X1C
+#define SWX_OUT_1_30    0x1C
 
 /* Buck Switchers (SW1,2,3,4) Output Voltage */
 /*
-- 
2.49.0

