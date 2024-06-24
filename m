Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D04AC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 080E7885BF;
	Mon, 24 Jun 2024 23:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 203D5883B1; Mon, 24 Jun 2024 21:28:29 +0200 (CEST)
Received: from EXCEDGE01.prodrive.nl (mail.prodrive-technologies.com
 [212.61.153.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382A3883D2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 21:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=paul.geurts@prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by webmail.prodrive.nl
 (192.168.102.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 24 Jun
 2024 21:28:05 +0200
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 21:28:05 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Mon, 24 Jun 2024 21:28:05 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.94.2)
 (envelope-from <paul.geurts@prodrive-technologies.com>)
 id 1sLpMD-006Ehd-2q; Mon, 24 Jun 2024 21:28:05 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <sbabic@denx.de>, <festevam@gmail.com>, <uboot-imx@nxp.com>,
 <trini@konsulko.com>, <peng.fan@nxp.com>, <ye.li@nxp.com>,
 <eduard@lionizers.com>, <marex@denx.de>, <fedor.ross@ifm.com>,
 <rasmus.villemoes@prevas.dk>, <xypron.glpk@gmx.de>, <elena.popa@nxp.com>,
 <tharvey@gateworks.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>
CC: <martijn.de.gouw@prodrive-technologies.com>, Paul Geurts
 <paul.geurts@prodrive-technologies.com>
Subject: [PATCH v2 1/2] imx: hab: rename imx_sec_config_fuse_t to imx_fuse_t
Date: Mon, 24 Jun 2024 21:28:02 +0200
Message-ID: <20240624192803.1484398-2-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240624192803.1484398-1-paul.geurts@prodrive-technologies.com>
References: <20240624192803.1484398-1-paul.geurts@prodrive-technologies.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 24 Jun 2024 23:05:18 +0200
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

The imx_sec_config_fuse_t structure is not specific to the sec_config
fuse, but can be used for all fuse words.

Rename the structure to a more generic name to be reused for other
fuses.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
---
 arch/arm/include/asm/mach-imx/hab.h | 4 ++--
 arch/arm/mach-imx/hab.c             | 4 ++--
 arch/arm/mach-imx/imx8m/soc.c       | 2 +-
 arch/arm/mach-imx/mx6/soc.c         | 2 +-
 arch/arm/mach-imx/mx7/soc.c         | 2 +-
 arch/arm/mach-imx/mx7ulp/soc.c      | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/hab.h b/arch/arm/include/asm/mach-imx/hab.h
index 2abf28ea45bc..52cd8aff87e1 100644
--- a/arch/arm/include/asm/mach-imx/hab.h
+++ b/arch/arm/include/asm/mach-imx/hab.h
@@ -132,13 +132,13 @@ enum hab_target {
 	HAB_TGT_ANY		= 0x55,
 };
 
-struct imx_sec_config_fuse_t {
+struct imx_fuse_t {
 	int bank;
 	int word;
 };
 
 #if defined(CONFIG_IMX_HAB)
-extern struct imx_sec_config_fuse_t const imx_sec_config_fuse;
+extern struct imx_fuse_t const imx_sec_config_fuse;
 #endif
 
 /*Function prototype description*/
diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c
index 27e053ef701c..1de0b648efdb 100644
--- a/arch/arm/mach-imx/hab.c
+++ b/arch/arm/mach-imx/hab.c
@@ -871,8 +871,8 @@ static int validate_ivt(struct ivt *ivt_initial)
 
 bool imx_hab_is_enabled(void)
 {
-	struct imx_sec_config_fuse_t *fuse =
-		(struct imx_sec_config_fuse_t *)&imx_sec_config_fuse;
+	struct imx_fuse_t *fuse =
+		(struct imx_fuse_t *)&imx_sec_config_fuse;
 	uint32_t reg;
 	int ret;
 
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 0c49fb9cd488..89e77236f024 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -36,7 +36,7 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 #if defined(CONFIG_IMX_HAB)
-struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
+struct imx_fuse_t const imx_sec_config_fuse = {
 	.bank = 1,
 	.word = 3,
 };
diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index c2875e727c94..703f2b3093dc 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -52,7 +52,7 @@ U_BOOT_DRVINFO(imx6_thermal) = {
 #endif
 
 #if defined(CONFIG_IMX_HAB)
-struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
+struct imx_fuse_t const imx_sec_config_fuse = {
 	.bank = 0,
 	.word = 6,
 };
diff --git a/arch/arm/mach-imx/mx7/soc.c b/arch/arm/mach-imx/mx7/soc.c
index 689dbefe8ee0..f95c7845cf06 100644
--- a/arch/arm/mach-imx/mx7/soc.c
+++ b/arch/arm/mach-imx/mx7/soc.c
@@ -128,7 +128,7 @@ static void isolate_resource(void)
 #endif
 
 #if defined(CONFIG_IMX_HAB)
-struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
+struct imx_fuse_t const imx_sec_config_fuse = {
 	.bank = 1,
 	.word = 3,
 };
diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-imx/mx7ulp/soc.c
index 217b7c45867d..e0b17e1b4ff1 100644
--- a/arch/arm/mach-imx/mx7ulp/soc.c
+++ b/arch/arm/mach-imx/mx7ulp/soc.c
@@ -38,7 +38,7 @@
 static char *get_reset_cause(char *);
 
 #if defined(CONFIG_IMX_HAB)
-struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
+struct imx_fuse_t const imx_sec_config_fuse = {
 	.bank = 29,
 	.word = 6,
 };
-- 
2.30.2

