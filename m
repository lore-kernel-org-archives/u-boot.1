Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0657E6B255
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 12:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10A0C891E2;
	Fri,  1 Nov 2024 13:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15FF788DF4; Fri,  1 Nov 2024 09:49:28 +0100 (CET)
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com
 [212.61.153.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C44C89045
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 09:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=paul.geurts@prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 1 Nov 2024
 09:49:24 +0100
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Fri, 1 Nov 2024 09:49:24 +0100
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.94.2)
 (envelope-from <paul.geurts@prodrive-technologies.com>)
 id 1t6nLP-00HNyP-MG; Fri, 01 Nov 2024 09:49:23 +0100
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <sbabic@denx.de>, <festevam@gmail.com>, <uboot-imx@nxp.com>,
 <trini@konsulko.com>, <peng.fan@nxp.com>, <ye.li@nxp.com>,
 <eduard@lionizers.com>, <marex@denx.de>, <fedor.ross@ifm.com>,
 <rasmus.villemoes@prevas.dk>, <xypron.glpk@gmx.de>, <elena.popa@nxp.com>,
 <tharvey@gateworks.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>
CC: <martijn.de.gouw@prodrive-technologies.com>, Paul Geurts
 <paul.geurts@prodrive-technologies.com>
Subject: [PATCH v4 1/2] imx: hab: rename imx_sec_config_fuse_t to imx_fuse
Date: Fri, 1 Nov 2024 09:49:20 +0100
Message-ID: <20241101084921.4134231-2-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241101084921.4134231-1-paul.geurts@prodrive-technologies.com>
References: <20241101084921.4134231-1-paul.geurts@prodrive-technologies.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 01 Nov 2024 13:56:15 +0100
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
index 2abf28ea45bc..9410f30eef2e 100644
--- a/arch/arm/include/asm/mach-imx/hab.h
+++ b/arch/arm/include/asm/mach-imx/hab.h
@@ -132,13 +132,13 @@ enum hab_target {
 	HAB_TGT_ANY		= 0x55,
 };
 
-struct imx_sec_config_fuse_t {
+struct imx_fuse {
 	int bank;
 	int word;
 };
 
 #if defined(CONFIG_IMX_HAB)
-extern struct imx_sec_config_fuse_t const imx_sec_config_fuse;
+extern struct imx_fuse const imx_sec_config_fuse;
 #endif
 
 /*Function prototype description*/
diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c
index a8107f46ae5e..7e4eaa4b14fb 100644
--- a/arch/arm/mach-imx/hab.c
+++ b/arch/arm/mach-imx/hab.c
@@ -870,8 +870,8 @@ static int validate_ivt(struct ivt *ivt_initial)
 
 bool imx_hab_is_enabled(void)
 {
-	struct imx_sec_config_fuse_t *fuse =
-		(struct imx_sec_config_fuse_t *)&imx_sec_config_fuse;
+	struct imx_fuse *fuse =
+		(struct imx_fuse *)&imx_sec_config_fuse;
 	uint32_t reg;
 	int ret;
 
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index a72329ea919d..e6c00e85412b 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -37,7 +37,7 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 #if defined(CONFIG_IMX_HAB)
-struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
+struct imx_fuse const imx_sec_config_fuse = {
 	.bank = 1,
 	.word = 3,
 };
diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index 9b40fe9235a4..e9dd33845635 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -51,7 +51,7 @@ U_BOOT_DRVINFO(imx6_thermal) = {
 #endif
 
 #if defined(CONFIG_IMX_HAB)
-struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
+struct imx_fuse const imx_sec_config_fuse = {
 	.bank = 0,
 	.word = 6,
 };
diff --git a/arch/arm/mach-imx/mx7/soc.c b/arch/arm/mach-imx/mx7/soc.c
index 1b891a2db3d4..11e8ac066086 100644
--- a/arch/arm/mach-imx/mx7/soc.c
+++ b/arch/arm/mach-imx/mx7/soc.c
@@ -127,7 +127,7 @@ static void isolate_resource(void)
 #endif
 
 #if defined(CONFIG_IMX_HAB)
-struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
+struct imx_fuse const imx_sec_config_fuse = {
 	.bank = 1,
 	.word = 3,
 };
diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-imx/mx7ulp/soc.c
index 980e02261563..b50ad1cfa195 100644
--- a/arch/arm/mach-imx/mx7ulp/soc.c
+++ b/arch/arm/mach-imx/mx7ulp/soc.c
@@ -38,7 +38,7 @@
 static char *get_reset_cause(char *);
 
 #if defined(CONFIG_IMX_HAB)
-struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
+struct imx_fuse const imx_sec_config_fuse = {
 	.bank = 29,
 	.word = 6,
 };
-- 
2.30.2

