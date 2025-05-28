Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E39C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5387B83A43;
	Wed, 28 May 2025 14:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YxfFdSM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB6B83A41; Wed, 28 May 2025 14:33:31 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989088397A
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-86cdb330b48so158727939f.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435607; x=1749040407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7MV62SqOOGwTNIEtbEz+BpMbjl52mtemsEd0H+q5no=;
 b=YxfFdSM6sJXTdFAiqH7Fmh/dNmkI4BtjrI1Kz5Wib6jbNnhwLgohntscog20zCF0k9
 l0hRgdM+5XpxUromgjWdbe7cBcUddp8l0fuB8Uq0HpT/W/9xYzeIMBI+tyyyMS946OoJ
 /wtzPYNYMGPFVzDuTi9Hff2FEo9v8sqvvLLBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435607; x=1749040407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7MV62SqOOGwTNIEtbEz+BpMbjl52mtemsEd0H+q5no=;
 b=oXx1jlOt42BCf1H5K48ks78x/fszoET2Wc566Zs7USrvAiJqncpP6ecNSRyBuO4Ntm
 jrNin+1iaB5oU8f9OnSvBEcvmW/Zz7BkHGrPc0KrKHXUpyy+K5EQOItrzarNNzbrpsWL
 PXXuMDXa3FXhdEBqTBcWMk3d+aAZMiGJ/j68ODG2DtjITpi4VvFvvrhMh87Yx1cPNvzV
 06hYEq3PLW40fLokF3LLvrh1kXBGiyvQ1ybuNhIBrJ32AQpt9NT+bFBlnPsEy6B8OLsa
 f468apQ+uvFpnIuznPnEXk7CG5keZHjdGnkFu30sCbsNQzflUvjBSGcWUJLopH836+uj
 q61Q==
X-Gm-Message-State: AOJu0YxEjJ8buOFv1cOUyfOl6yyDIjG6QFTf2MYpKcXoYd+wRhkA1q9+
 fKY1nxmb8rSQPoUjuj0mW+Bz3ctrH0GCTI4a7LYk6Vtgm7Nz54w+7F4uS2Dky28XcvaJD6IGadk
 0Wdh/mMfB
X-Gm-Gg: ASbGncuS89nF/ijBwmrqMPhEfv2SISsM5LkJM7yZDj1X0OeVwh9czN5zO63VbkHiX+I
 pfkpAvA7+BwU2lcZKe8LeWn/dMuzV7sb3YOz4T1j59uFXdTjFyWcoCrbU2DS7owBaoJvCnK6o/b
 6/M8JmnsGGwkJyFe5OJyCCbVoEBs1r0Qxsyy9kr25tOAc5N3SV/ni6Luwh6K55BuY+sb5uvtmEm
 AEQcL8IqD+ZTmiLbvEUNTo16lMkoh92UljPD9YdpYA7LZ9y0BYqDBwTsWQ5eRVp3VmB8zCQWrjD
 x/wx+BDLUDlsnt0payPxZCTP/b7Afocc4HjvyHL4ZCziGcK/ukUrDtoEbQpyBYTElf9UX4hbWle
 U2osDjCCF0bfj
X-Google-Smtp-Source: AGHT+IFR5Zifuy/AVTG8CRrdkHPvVDj76wslMGjZ6pdwIzf/J7UBzLemkrsrxTUe+LMSi+4qVCfrog==
X-Received: by 2002:a05:6602:4898:b0:867:8ef:69e8 with SMTP id
 ca18e2360f4ac-86cea24a31bmr218730839f.3.1748435606578; 
 Wed, 28 May 2025 05:33:26 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Leo <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rick Chen <rick@andestech.com>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>
Subject: [PATCH v5 06/25] spl: Rename jump_to_image_no_args()
Date: Wed, 28 May 2025 06:32:08 -0600
Message-ID: <20250528063224.v5.6.Ieb1fd7a5478ba1dfe3a58666ed586e83b0641590@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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
index 6a6cad310bc..01ff034d665 100644
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

