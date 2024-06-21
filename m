Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE48C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 13:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A1B88405;
	Fri, 21 Jun 2024 15:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3824A884FF; Fri, 21 Jun 2024 15:06:49 +0200 (CEST)
Received: from EXCEDGE01.prodrive.nl (mail.prodrive-technologies.com
 [212.61.153.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F4A87D46
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 15:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=paul.geurts@prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by webmail.prodrive.nl
 (192.168.102.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 15:06:46 +0200
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Jun
 2024 15:06:46 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Fri, 21 Jun 2024 15:06:46 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.94.2)
 (envelope-from <paul.geurts@prodrive-technologies.com>)
 id 1sKdyY-0034Zq-0q; Fri, 21 Jun 2024 15:06:46 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <sbabic@denx.de>, <festevam@gmail.com>, <uboot-imx@nxp.com>,
 <trini@konsulko.com>, <peng.fan@nxp.com>, <ye.li@nxp.com>,
 <eduard@lionizers.com>, <marex@denx.de>, <fedor.ross@ifm.com>,
 <rasmus.villemoes@prevas.dk>, <xypron.glpk@gmx.de>, <elena.popa@nxp.com>,
 <tharvey@gateworks.com>, <sjg@chromium.org>, <vitor.soares@toradex.com>,
 <u-boot@lists.denx.de>, <martijn.de.gouw@prodrive-technologies.com>
CC: Paul Geurts <paul.geurts@prodrive-technologies.com>
Subject: [PATCH] imx: hab: Make imx_hab_is_enabled dependent on FIELD_RETURN
Date: Fri, 21 Jun 2024 15:06:26 +0200
Message-ID: <20240621130626.729666-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 21 Jun 2024 15:33:01 +0200
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

The decision on whether HAB is enabled is solely based on the SEC_CONFIG
fuse. The HAB FIELD_RETURN feature is able to permanently disable HAB on
a CPU, after which it is able to boot unsigned firmware. U-Boot however
does not take into account the FIELD_RETURN mode, and refuses to boot
unsigned software when the feature is enabled.

Also take the FIELD_RETURN fuse into account when deciding whether HAB
is enabled. When The FIELD_RETURN fuse is blown, HAB is not enabled.

Tested on i.MX8M Mini, i.MX8M Plus, i.MX8M Nano and i.MX6ULL

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
---
 arch/arm/include/asm/mach-imx/hab.h |  5 +++--
 arch/arm/mach-imx/hab.c             | 21 +++++++++++++++++----
 arch/arm/mach-imx/imx8m/soc.c       |  7 ++++++-
 arch/arm/mach-imx/mx6/soc.c         |  7 ++++++-
 arch/arm/mach-imx/mx7/soc.c         |  7 ++++++-
 arch/arm/mach-imx/mx7ulp/soc.c      |  7 ++++++-
 6 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/hab.h b/arch/arm/include/asm/mach-imx/hab.h
index 2abf28ea45bc..d70e8eac1358 100644
--- a/arch/arm/include/asm/mach-imx/hab.h
+++ b/arch/arm/include/asm/mach-imx/hab.h
@@ -132,13 +132,14 @@ enum hab_target {
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
+extern struct imx_fuse_t const imx_field_return_fuse;
 #endif
 
 /*Function prototype description*/
diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c
index 27e053ef701c..03d827e6c1eb 100644
--- a/arch/arm/mach-imx/hab.c
+++ b/arch/arm/mach-imx/hab.c
@@ -27,6 +27,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define IS_HAB_ENABLED_BIT \
 	(is_soc_type(MXC_SOC_MX7ULP) ? 0x80000000 :	\
 	 ((is_soc_type(MXC_SOC_MX7) || is_soc_type(MXC_SOC_IMX8M)) ? 0x2000000 : 0x2))
+#define IS_FIELD_RETURN_BIT 0x00000001
 
 #ifdef CONFIG_MX7ULP
 #define HAB_M4_PERSISTENT_START	((soc_rev() >= CHIP_REV_2_0) ? 0x20008040 : \
@@ -871,18 +872,30 @@ static int validate_ivt(struct ivt *ivt_initial)
 
 bool imx_hab_is_enabled(void)
 {
-	struct imx_sec_config_fuse_t *fuse =
-		(struct imx_sec_config_fuse_t *)&imx_sec_config_fuse;
+	struct imx_fuse_t *sec_config =
+		(struct imx_fuse_t *)&imx_sec_config_fuse;
+	struct imx_fuse_t *field_return =
+		(struct imx_fuse_t *)&imx_field_return_fuse;
 	uint32_t reg;
+	bool is_enabled;
 	int ret;
 
-	ret = fuse_read(fuse->bank, fuse->word, &reg);
+	ret = fuse_read(sec_config->bank, sec_config->word, &reg);
 	if (ret) {
 		puts("\nSecure boot fuse read error\n");
 		return ret;
 	}
+	is_enabled = (reg & IS_HAB_ENABLED_BIT) == IS_HAB_ENABLED_BIT;
+	if (is_enabled) {
+		ret = fuse_read(field_return->bank, field_return->word, &reg);
+		if (ret) {
+			puts("\nField return fuse read error\n");
+			return ret;
+		}
+		is_enabled = !(reg & IS_FIELD_RETURN_BIT);
+	}
 
-	return (reg & IS_HAB_ENABLED_BIT) == IS_HAB_ENABLED_BIT;
+	return is_enabled;
 }
 
 int imx_hab_authenticate_image(uint32_t ddr_start, uint32_t image_size,
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 0c49fb9cd488..af0844946378 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -36,10 +36,15 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 #if defined(CONFIG_IMX_HAB)
-struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
+struct imx_fuse_t const imx_sec_config_fuse = {
 	.bank = 1,
 	.word = 3,
 };
+
+struct imx_fuse_t const imx_field_return_fuse = {
+	.bank = 8,
+	.word = 3,
+};
 #endif
 
 int timer_init(void)
diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index c2875e727c94..02179b02b8d2 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -52,10 +52,15 @@ U_BOOT_DRVINFO(imx6_thermal) = {
 #endif
 
 #if defined(CONFIG_IMX_HAB)
-struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
+struct imx_fuse_t const imx_sec_config_fuse = {
 	.bank = 0,
 	.word = 6,
 };
+
+struct imx_fuse_t const imx_field_return_fuse = {
+	.bank = 5,
+	.word = 6,
+};
 #endif
 
 u32 get_nr_cpus(void)
diff --git a/arch/arm/mach-imx/mx7/soc.c b/arch/arm/mach-imx/mx7/soc.c
index 689dbefe8ee0..3369696e4614 100644
--- a/arch/arm/mach-imx/mx7/soc.c
+++ b/arch/arm/mach-imx/mx7/soc.c
@@ -128,10 +128,15 @@ static void isolate_resource(void)
 #endif
 
 #if defined(CONFIG_IMX_HAB)
-struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
+struct imx_fuse_t const imx_sec_config_fuse = {
 	.bank = 1,
 	.word = 3,
 };
+
+struct imx_fuse_t const imx_field_return_fuse = {
+	.bank = 8,
+	.word = 3,
+};
 #endif
 
 static bool is_mx7d(void)
diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-imx/mx7ulp/soc.c
index 217b7c45867d..d11204cb2479 100644
--- a/arch/arm/mach-imx/mx7ulp/soc.c
+++ b/arch/arm/mach-imx/mx7ulp/soc.c
@@ -38,10 +38,15 @@
 static char *get_reset_cause(char *);
 
 #if defined(CONFIG_IMX_HAB)
-struct imx_sec_config_fuse_t const imx_sec_config_fuse = {
+struct imx_fuse_t const imx_sec_config_fuse = {
 	.bank = 29,
 	.word = 6,
 };
+
+struct imx_fuse_t const imx_field_return_fuse = {
+	.bank = 9,
+	.word = 6,
+};
 #endif
 
 #define ROM_VERSION_ADDR 0x80
-- 
2.30.2

