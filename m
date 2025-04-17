Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F88C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E3982F5A;
	Thu, 17 Apr 2025 20:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Km2fIeqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB918304C; Thu, 17 Apr 2025 20:16:52 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5837E830B4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85b43b60b6bso33722439f.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913808; x=1745518608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=561Gq/bwn5yLEmetplQh2yBW3A704hHKLIrosAG6FPI=;
 b=Km2fIeqh5Zwm5PVRYX6NappLTAjuDL7rTdyVpolZXchSvCBfT/su8VpkqJ7AYn4KYO
 pk5xIlkrDUN/ZpfIa+lz3lNsgXFE6ATjadvR2LSjq4jSjCmby4Bw3MMl1k56f8hKYGP+
 HtcvOdKYnWkbmjLzNQ6MLvMg9CLiUk/bmP6Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913808; x=1745518608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=561Gq/bwn5yLEmetplQh2yBW3A704hHKLIrosAG6FPI=;
 b=uu+wdZ3dKMmh7I9cNzetokD1ao7OK/2kggkHM0xYm15Apd3Krgp3O2XoGujq8TCCxL
 Am9UZmigBTww8Btcv1Z9ct0gsPpYGUKG023v3nYSb7T3iZi37XDkf6K9kLQf8KTc2nnB
 dR/95shs0Yq8nXRsjGuOTN0bfHNIsDBvjII8JKvGhpANGBpNJMinfjSkbWJtGNZlhysq
 KX/RHO5slbNiOZQZhWCFWtUde3NjKCSFrM8bTxfFrRnBHqxNHN6+sGHH6YqFE1pvwHSO
 7x1r5gE5fkj85t+f5xNiq9RMDhy7o2U/9DBhhbpK2KUrj+XJOcyAbRIR4EzZgYvgCWEH
 eYEw==
X-Gm-Message-State: AOJu0YzQY9XWORW81sMF/A5HZzY7X27IOh63D2XroWU7UwSZ4j4fA6RB
 VG3CYqqbyNNrJgW/I17YeptIeO88mAOiET61YOsP5ag6HFKLduWIAyOJXd/QRfIOrK2yTwUr0rc
 =
X-Gm-Gg: ASbGncsV2pLyaK72yyIZ/xb/EZsnJ+b8d+mxKHy5rdT73xgObwgJFiBQj9vog9U+ecI
 3dVVtWA7VPOBamv1lJI7Z3cyJslWPa7+XNFRDG/eQR1vp+tW4+CnKbRpLZ2cNbMNecX1rqOsEmQ
 FAEv6mcERMr/W2CN6ocLFQuQYD7dV7wlNQbw8+gtVqxwMv7mZ78MD4t7iSjyQnSauTjpnDdlQdN
 CAIl6O+NW1aYw2whoIkaz5RnS/Q4QV/YSAGaCxSrbb1VbTiuRa5xInksany0bPiIdY0phbsDys3
 KLbA43tpJWQVEb59KoI1u4DZWbYtB0trBUp1JgSb6CsbBN7bbpm0tmBjTGfJXZQNLJDcWaSXuoS
 XMkGR0yT9mByf
X-Google-Smtp-Source: AGHT+IHZvCncIu5BaWVzQ8Cu5W3f4pYQGDm+Fh23NzRsFS5RnHev5HOtLtti0tOfg3JZKMPpUUeI8w==
X-Received: by 2002:a05:6602:276f:b0:85e:73da:c56a with SMTP id
 ca18e2360f4ac-861d89ce3acmr110703939f.3.1744913808539; 
 Thu, 17 Apr 2025 11:16:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:16:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Jason Liu <jason.hui.liu@nxp.com>,
 Leo <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rick Chen <rick@andestech.com>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>
Subject: [PATCH v3 05/22] spl: Rename jump_to_image_no_args()
Date: Thu, 17 Apr 2025 12:15:47 -0600
Message-ID: <20250417121601.v3.5.Ieb1fd7a5478ba1dfe3a58666ed586e83b0641590@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

This is about to become a misnomer since with standard passage we need to
pass arguments to U-Boot. Rename the function.

Also rename the local variable to 'jumper' to avoid a conflict.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Split the jump_to_image_no_args() change into its own patch

 arch/arm/mach-imx/imx8ulp/soc.c             |  2 +-
 arch/arm/mach-imx/spl.c                     |  2 +-
 arch/arm/mach-omap2/boot-common.c           |  2 +-
 arch/arm/mach-tegra/spl.c                   |  2 +-
 arch/mips/lib/spl.c                         |  2 +-
 arch/riscv/lib/spl.c                        |  2 +-
 arch/sandbox/cpu/spl.c                      |  4 ++--
 arch/x86/lib/spl.c                          |  2 +-
 arch/x86/lib/tpl.c                          |  2 +-
 board/freescale/common/fsl_chain_of_trust.c |  2 +-
 board/renesas/common/rcar64-spl.c           |  2 +-
 common/spl/spl.c                            | 16 ++++++++--------
 drivers/usb/gadget/f_sdp.c                  |  2 +-
 include/spl.h                               |  2 +-
 14 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index b5dc45296d1..2b042300103 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -806,7 +806,7 @@ int imx8ulp_dm_post_init(void)
 EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx8ulp_dm_post_init);
 
 #if defined(CONFIG_XPL_BUILD)
-__weak void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+__weak void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	debug("image entry point: 0x%lx\n", spl_image->entry_point);
 
diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c
index bc291dcd129..518d9cb1262 100644
--- a/arch/arm/mach-imx/spl.c
+++ b/arch/arm/mach-imx/spl.c
@@ -276,7 +276,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
  * +------------+ + CSF_PAD_SIZE
  */
 
-__weak void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+__weak void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	typedef void __noreturn (*image_entry_noargs_t)(void);
 	uint32_t offset;
diff --git a/arch/arm/mach-omap2/boot-common.c b/arch/arm/mach-omap2/boot-common.c
index ddd7eeaf052..95b44c8b1e5 100644
--- a/arch/arm/mach-omap2/boot-common.c
+++ b/arch/arm/mach-omap2/boot-common.c
@@ -291,7 +291,7 @@ void spl_soc_init(void)
 		spl_boot_ipu();
 }
 
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	typedef void __noreturn (*image_entry_noargs_t)(u32 *);
 	image_entry_noargs_t image_entry =
diff --git a/arch/arm/mach-tegra/spl.c b/arch/arm/mach-tegra/spl.c
index 5df0eb28c96..b3a039217c2 100644
--- a/arch/arm/mach-tegra/spl.c
+++ b/arch/arm/mach-tegra/spl.c
@@ -43,7 +43,7 @@ u32 spl_boot_device(void)
 	return BOOT_DEVICE_RAM;
 }
 
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	debug("image entry point: 0x%lX\n", spl_image->entry_point);
 
diff --git a/arch/mips/lib/spl.c b/arch/mips/lib/spl.c
index b4087546dd1..4949b17bd59 100644
--- a/arch/mips/lib/spl.c
+++ b/arch/mips/lib/spl.c
@@ -7,7 +7,7 @@
 #include <log.h>
 #include <spl.h>
 
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	typedef void __noreturn (*image_entry_noargs_t)(void);
 	image_entry_noargs_t image_entry =
diff --git a/arch/riscv/lib/spl.c b/arch/riscv/lib/spl.c
index 9a7a4f6ac8d..38a5ab27dd8 100644
--- a/arch/riscv/lib/spl.c
+++ b/arch/riscv/lib/spl.c
@@ -36,7 +36,7 @@ __weak void board_init_f(ulong dummy)
 		panic("spl_board_init_f() failed: %d\n", ret);
 }
 
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	typedef void __noreturn (*image_entry_riscv_t)(ulong hart, void *dtb);
 	void *fdt_blob;
diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index ecc03785463..514da305404 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -74,7 +74,7 @@ static int spl_board_load_file(struct spl_image_info *spl_image,
 	}
 
 	/*
-	 * Set up spl_image to boot from jump_to_image_no_args(). Allocate this
+	 * Set up spl_image to boot from jump_to_image(). Allocate this
 	 * outsdide the RAM buffer (i.e. don't use strdup()).
 	 */
 	spl_image->arg = os_malloc(strlen(fname) + 1);
@@ -159,7 +159,7 @@ void spl_board_init(void)
 	}
 }
 
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	switch (spl_image->flags) {
 	case SPL_SANDBOXF_ARG_IS_FNAME: {
diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 0a6a761987e..a9abc045ca2 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -277,7 +277,7 @@ int spl_spi_load_image(void)
 }
 
 #ifdef CONFIG_X86_RUN_64BIT
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	int ret;
 
diff --git a/arch/x86/lib/tpl.c b/arch/x86/lib/tpl.c
index f7df7e03621..06c9e4d02c1 100644
--- a/arch/x86/lib/tpl.c
+++ b/arch/x86/lib/tpl.c
@@ -101,7 +101,7 @@ int spl_spi_load_image(void)
 	return -EPERM;
 }
 
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	debug("Jumping to %s at %lx\n", xpl_name(xpl_next_phase()),
 	      (ulong)spl_image->entry_point);
diff --git a/board/freescale/common/fsl_chain_of_trust.c b/board/freescale/common/fsl_chain_of_trust.c
index 194a0907e72..3d44357caf7 100644
--- a/board/freescale/common/fsl_chain_of_trust.c
+++ b/board/freescale/common/fsl_chain_of_trust.c
@@ -134,7 +134,7 @@ void spl_validate_uboot(uint32_t hdr_addr, uintptr_t img_addr)
 /* Override weak funtion defined in SPL framework to enable validation
  * of main u-boot image before jumping to u-boot image.
  */
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	typedef void __noreturn (*image_entry_noargs_t)(void);
 	uint32_t hdr_addr;
diff --git a/board/renesas/common/rcar64-spl.c b/board/renesas/common/rcar64-spl.c
index 76f2bde924e..d8f05d2ffbe 100644
--- a/board/renesas/common/rcar64-spl.c
+++ b/board/renesas/common/rcar64-spl.c
@@ -6,7 +6,7 @@
 #include <image.h>
 #include <spl.h>
 
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	debug("image entry point: 0x%lx\n", spl_image->entry_point);
 	if (spl_image->os == IH_OS_ARM_TRUSTED_FIRMWARE) {
diff --git a/common/spl/spl.c b/common/spl/spl.c
index abbca9acde0..f14c68c46a5 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -391,7 +391,7 @@ int spl_load(struct spl_image_info *spl_image,
 }
 #endif
 
-__weak void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+__weak void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
 	typedef void __noreturn (*image_entry_noargs_t)(void);
 
@@ -688,7 +688,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		BOOT_DEVICE_NONE,
 		BOOT_DEVICE_NONE,
 	};
-	spl_jump_to_image_t jump_to_image = &jump_to_image_no_args;
+	spl_jump_to_image_t jumper = &jump_to_image;
 	struct spl_image_info spl_image;
 	int ret, os;
 
@@ -782,20 +782,20 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	} else if (CONFIG_IS_ENABLED(ATF) && os == IH_OS_ARM_TRUSTED_FIRMWARE) {
 		debug("Jumping to U-Boot via ARM Trusted Firmware\n");
 		spl_fixup_fdt(spl_image_fdt_addr(&spl_image));
-		jump_to_image = &spl_invoke_atf;
+		jumper = &spl_invoke_atf;
 	} else if (CONFIG_IS_ENABLED(OPTEE_IMAGE) && os == IH_OS_TEE) {
 		debug("Jumping to U-Boot via OP-TEE\n");
 		spl_board_prepare_for_optee(spl_image_fdt_addr(&spl_image));
-		jump_to_image = &jump_to_image_optee;
+		jumper = &jump_to_image_optee;
 	} else if (CONFIG_IS_ENABLED(OPENSBI) && os == IH_OS_OPENSBI) {
 		debug("Jumping to U-Boot via RISC-V OpenSBI\n");
-		jump_to_image = &spl_invoke_opensbi;
+		jumper = &spl_invoke_opensbi;
 	} else if (CONFIG_IS_ENABLED(OS_BOOT) && os == IH_OS_LINUX) {
 		debug("Jumping to Linux\n");
 		if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
 			spl_fixup_fdt((void *)SPL_PAYLOAD_ARGS_ADDR);
 		spl_board_prepare_for_linux();
-		jump_to_image = &jump_to_image_linux;
+		jumper = &jump_to_image_linux;
 	} else {
 		debug("Unsupported OS image.. Jumping nevertheless..\n");
 	}
@@ -847,7 +847,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	if (CONFIG_IS_ENABLED(RELOC_LOADER)) {
 		int ret;
 
-		ret = spl_reloc_jump(&spl_image, jump_to_image);
+		ret = spl_reloc_jump(&spl_image, jumper);
 		if (ret) {
 			if (xpl_phase() == PHASE_VPL)
 				printf("jump failed %d\n", ret);
@@ -855,7 +855,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		}
 	}
 
-	jump_to_image(&spl_image);
+	jumper(&spl_image);
 }
 
 /*
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 36934b1bcf7..647001d8dd0 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -863,7 +863,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 			struct spl_boot_device bootdev = {};
 			spl_parse_image_header(&spl_image, &bootdev, header);
 			spl_board_prepare_for_boot();
-			jump_to_image_no_args(&spl_image);
+			jump_to_image(&spl_image);
 #else
 			/* In U-Boot, allow jumps to scripts */
 			cmd_source_script(sdp_func->jmp_address, NULL, NULL);
diff --git a/include/spl.h b/include/spl.h
index 850c64d4b19..7c10c7f792e 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -865,7 +865,7 @@ int spl_load_image_fat_os(struct spl_image_info *spl_image,
 			  struct spl_boot_device *bootdev,
 			  struct blk_desc *block_dev, int partition);
 
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image);
+void __noreturn jump_to_image(struct spl_image_info *spl_image);
 
 /* SPL EXT image functions */
 int spl_load_image_ext(struct spl_image_info *spl_image,
-- 
2.43.0

