Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6374FC54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 12:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8CF83721;
	Tue, 27 May 2025 14:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YEXOCJyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3259583759; Tue, 27 May 2025 14:41:08 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575D1836C8
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 14:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-86135ad7b4cso68389539f.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748349662; x=1748954462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZA3P/pUZFubmXieAOVrpByVxRzplq7opaut1N//emno=;
 b=YEXOCJyNZLGYy7/CMkhZY+ASs8xGnPy4VbzC8DmvcsdlCVAE1rjBgPoGBli41Vw8T6
 /xm33pQBgzZP+02f0Qy0zDX19VszytS2BnxXnUNXr10OLEH2QOZIhkvsHqtMgYH+15M3
 AbP/HckamolqeU9vOmURd9Y13IoddkkVTuOvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748349662; x=1748954462;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZA3P/pUZFubmXieAOVrpByVxRzplq7opaut1N//emno=;
 b=Y7cwdzA4V7ji8C5IgCafZuo5/RUKnJ1hdkDV5Ij3ckJ8PlRtKjO7talM+aaiqNghP8
 eL1xhH5jLa3i69FhGSc3umeMCkn6tnd04tEjG9y1pZYBni92IUSBPuSARQZVpUjT2EzF
 pkNexbQuwkFUUL3TzhCAbQDYQBLv8PFRGAyAGKuaEoqCKas5Mf7UgudZpxpbC/GIpTt9
 DPu9qCKAeuk0rMhBc+AqTVsITfGpqF054HklW0RORcabMAmK0UJdsp2r+x4+H6TAXlag
 2iMouP2lTeHbA5w9qb60NQ3LWxVSmi9tQ/+6AMvzuUhGIjJN0QbjAVYHoPNf+uxKj/z2
 0YTg==
X-Gm-Message-State: AOJu0Ywk2nig+hWDXU9Npa5becitpmGmUK56M0PBov/1SCuG1ERFYOIK
 pPT8aaGANSFhhjV9/ogB25ca6YtZHnTIAPRyR+U7Hh0UZFPj1Z0fwkPyknpxriHlTihRMDPaBY+
 Mi11VkVkj
X-Gm-Gg: ASbGncvCYU4yV2FiGGUBHYFIKSITx2JQmfYDtuRZkKSpTL61d9zNxKn0ZyKGGF646iT
 q44fJWC/FbIThlekioAvL3SLNJRDftdFN4344XfyV6EESUC18tDMIC8NTNYHNf8JH/zTm6X0rQr
 X1y2Ecf0vfa2aVa4moyxcMyuCho4Qt7zaSHxi+5A8pl9KdW71Ufb0js3BFu1RO38LDotNDS+Ule
 Hm2tv2xOu48ajN/63SUmmxyyFwS2iX1YGTKFQiNSeA+KvlLew0oI8//ajFwtAR0rYNpg7OIxBm9
 iRz6rcJ51ymFFoXrtiU5TFzgBrRmbrIT3YxEuJ0T7uoK2AXA15dneure6+ROHgLO16uZgwBMoGt
 Zngx1+hgGsoZ2
X-Google-Smtp-Source: AGHT+IHufr9BiL/QHi/EhWVRvXjGsixJYN9BfnZtN+lqRBHF1Wu1C9Bm8ZSfWFf2/UuUSw8Ua7lznw==
X-Received: by 2002:a05:6602:4c0f:b0:85b:3677:fa8b with SMTP id
 ca18e2360f4ac-86cbb8b0274mr1391431539f.13.1748349662200; 
 Tue, 27 May 2025 05:41:02 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdadebd440sm266176173.50.2025.05.27.05.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 05:41:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Huan Wang <alison.wang@nxp.com>, Janne Grunau <j@jannau.net>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rick Chen <rick@andestech.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Thomas Chou <thomas@wytron.com.tw>,
 Tom Rini <trini@konsulko.com>, uboot-snps-arc@synopsys.com
Subject: [PATCH 1/2] bootm: Shorten BOOTM_STATE_
Date: Tue, 27 May 2025 06:40:34 -0600
Message-ID: <20250527124038.3633270-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

This is quite long at present. Rename it so that fixes better with the
bootstd naming.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arc/lib/bootm.c        |  8 ++--
 arch/arm/lib/bootm.c        | 10 ++---
 arch/m68k/lib/bootm.c       |  4 +-
 arch/microblaze/lib/bootm.c |  8 ++--
 arch/mips/lib/bootm.c       | 10 ++---
 arch/nios2/lib/bootm.c      |  4 +-
 arch/powerpc/lib/bootm.c    |  6 +--
 arch/riscv/lib/bootm.c      |  8 ++--
 arch/sandbox/lib/bootm.c    |  4 +-
 arch/sh/lib/bootm.c         |  4 +-
 arch/x86/lib/bootm.c        |  6 +--
 arch/xtensa/lib/bootm.c     |  4 +-
 boot/bootm.c                | 82 ++++++++++++++++++-------------------
 boot/bootm_os.c             | 26 ++++++------
 cmd/booti.c                 | 14 +++----
 cmd/bootm.c                 | 34 +++++++--------
 include/bootm.h             |  8 ++--
 include/image.h             | 26 ++++++------
 18 files changed, 133 insertions(+), 133 deletions(-)

diff --git a/arch/arc/lib/bootm.c b/arch/arc/lib/bootm.c
index b143392ee6c..14f1d7fa2d1 100644
--- a/arch/arc/lib/bootm.c
+++ b/arch/arc/lib/bootm.c
@@ -53,7 +53,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 {
 	ulong kernel_entry;
 	unsigned int r0, r2;
-	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
+	int fake = (flag & BOOTMS_OS_FAKE_GO);
 
 	kernel_entry = images->ep;
 
@@ -84,13 +84,13 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	struct bootm_headers *images = bmi->images;
 
 	/* No need for those on ARC */
-	if ((flag & BOOTM_STATE_OS_BD_T) || (flag & BOOTM_STATE_OS_CMDLINE))
+	if ((flag & BOOTMS_OS_BD_T) || (flag & BOOTMS_OS_CMDLINE))
 		return -1;
 
-	if (flag & BOOTM_STATE_OS_PREP)
+	if (flag & BOOTMS_OS_PREP)
 		return boot_prep_linux(images);
 
-	if (flag & (BOOTM_STATE_OS_GO | BOOTM_STATE_OS_FAKE_GO)) {
+	if (flag & (BOOTMS_OS_GO | BOOTMS_OS_FAKE_GO)) {
 		boot_jump_linux(images, flag);
 		return 0;
 	}
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 688c2f3f29b..41c971f9f00 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -295,7 +295,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 #ifdef CONFIG_ARM64
 	void (*kernel_entry)(void *fdt_addr, void *res0, void *res1,
 			void *res2);
-	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
+	int fake = (flag & BOOTMS_OS_FAKE_GO);
 
 	kernel_entry = (void (*)(void *fdt_addr, void *res0, void *res1,
 				void *res2))images->ep;
@@ -335,7 +335,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	char *s;
 	void (*kernel_entry)(int zero, int arch, uint params);
 	unsigned long r2;
-	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
+	int fake = (flag & BOOTMS_OS_FAKE_GO);
 
 	kernel_entry = (void (*)(int, int, uint))images->ep;
 #ifdef CONFIG_CPU_V7M
@@ -385,15 +385,15 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	struct bootm_headers *images = bmi->images;
 
 	/* No need for those on ARM */
-	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
+	if (flag & BOOTMS_OS_BD_T || flag & BOOTMS_OS_CMDLINE)
 		return -1;
 
-	if (flag & BOOTM_STATE_OS_PREP) {
+	if (flag & BOOTMS_OS_PREP) {
 		boot_prep_linux(images);
 		return 0;
 	}
 
-	if (flag & (BOOTM_STATE_OS_GO | BOOTM_STATE_OS_FAKE_GO)) {
+	if (flag & (BOOTMS_OS_GO | BOOTMS_OS_FAKE_GO)) {
 		boot_jump_linux(images, flag);
 		return 0;
 	}
diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index 1fa112f8dbf..5c233e490af 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -35,10 +35,10 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	/*
 	 * allow the PREP bootm subcommand, it is required for bootm to work
 	 */
-	if (flag & BOOTM_STATE_OS_PREP)
+	if (flag & BOOTMS_OS_PREP)
 		return 0;
 
-	if ((flag != 0) && (flag != BOOTM_STATE_OS_GO))
+	if (flag && flag != BOOTMS_OS_GO)
 		return 1;
 
 	/* allocate space for kernel copy of board info */
diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
index 4879a41aab3..d1d82d52ad9 100644
--- a/arch/microblaze/lib/bootm.c
+++ b/arch/microblaze/lib/bootm.c
@@ -29,7 +29,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	ulong dt = (ulong)images->ft_addr;
 	ulong rd_start = images->initrd_start;
 	ulong cmdline = images->cmdline_start;
-	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
+	int fake = (flag & BOOTMS_OS_FAKE_GO);
 
 	thekernel = (void (*)(char *, ulong, ulong))images->ep;
 
@@ -75,15 +75,15 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	images->cmdline_start = (ulong)env_get("bootargs");
 
 	/* cmdline init is the part of 'prep' and nothing to do for 'bdt' */
-	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
+	if (flag & BOOTMS_OS_BD_T || flag & BOOTMS_OS_CMDLINE)
 		return -1;
 
-	if (flag & BOOTM_STATE_OS_PREP) {
+	if (flag & BOOTMS_OS_PREP) {
 		boot_prep_linux(images);
 		return 0;
 	}
 
-	if (flag & (BOOTM_STATE_OS_GO | BOOTM_STATE_OS_FAKE_GO)) {
+	if (flag & (BOOTMS_OS_GO | BOOTMS_OS_FAKE_GO)) {
 		boot_jump_linux(images, flag);
 		return 0;
 	}
diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index 87195100023..065679e99a4 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -204,7 +204,7 @@ static int boot_reloc_fdt(struct bootm_headers *images)
 	 * In case of legacy uImage's, relocation of FDT is already done
 	 * by bootm_run_states() and should not repeated in 'bootm prep'.
 	 */
-	if (images->state & BOOTM_STATE_FDT) {
+	if (images->state & BOOTMS_FDT) {
 		debug("## FDT already relocated\n");
 		return 0;
 	}
@@ -290,7 +290,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	struct bootm_headers *images = bmi->images;
 
 	/* No need for those on MIPS */
-	if (flag & BOOTM_STATE_OS_BD_T)
+	if (flag & BOOTMS_OS_BD_T)
 		return -1;
 
 	/*
@@ -298,15 +298,15 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	 * done after relocation of ramdisk to always pass correct values
 	 * for rd_start and rd_size to Linux kernel.
 	 */
-	if (flag & BOOTM_STATE_OS_CMDLINE)
+	if (flag & BOOTMS_OS_CMDLINE)
 		return 0;
 
-	if (flag & BOOTM_STATE_OS_PREP) {
+	if (flag & BOOTMS_OS_PREP) {
 		boot_prep_linux(images);
 		return 0;
 	}
 
-	if (flag & (BOOTM_STATE_OS_GO | BOOTM_STATE_OS_FAKE_GO)) {
+	if (flag & (BOOTMS_OS_GO | BOOTMS_OS_FAKE_GO)) {
 		boot_jump_linux(images);
 		return 0;
 	}
diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
index 71319839ba2..03d00dbf29b 100644
--- a/arch/nios2/lib/bootm.c
+++ b/arch/nios2/lib/bootm.c
@@ -38,10 +38,10 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	/*
 	 * allow the PREP bootm subcommand, it is required for bootm to work
 	 */
-	if (flag & BOOTM_STATE_OS_PREP)
+	if (flag & BOOTMS_OS_PREP)
 		return 0;
 
-	if ((flag != 0) && (flag != BOOTM_STATE_OS_GO))
+	if (flag && flag != BOOTMS_OS_GO)
 		return 1;
 
 	/* flushes data and instruction caches before calling the kernel */
diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index dc44bf3ab3a..02651053588 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -185,17 +185,17 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	struct bootm_headers *images = bmi->images;
 	int	ret;
 
-	if (flag & BOOTM_STATE_OS_CMDLINE) {
+	if (flag & BOOTMS_OS_CMDLINE) {
 		boot_cmdline_linux(images);
 		return 0;
 	}
 
-	if (flag & BOOTM_STATE_OS_BD_T) {
+	if (flag & BOOTMS_OS_BD_T) {
 		boot_bd_t_linux(images);
 		return 0;
 	}
 
-	if (flag & BOOTM_STATE_OS_PREP) {
+	if (flag & BOOTMS_OS_PREP) {
 		boot_prep_linux(images);
 		return 0;
 	}
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 76c610bcee0..6a444675394 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -79,7 +79,7 @@ static void boot_prep_linux(struct bootm_headers *images)
 static void boot_jump_linux(struct bootm_headers *images, int flag)
 {
 	void (*kernel)(ulong hart, void *dtb);
-	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
+	int fake = (flag & BOOTMS_OS_FAKE_GO);
 #ifdef CONFIG_SMP
 	int ret;
 #endif
@@ -111,15 +111,15 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	struct bootm_headers *images = bmi->images;
 
 	/* No need for those on RISC-V */
-	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
+	if (flag & BOOTMS_OS_BD_T || flag & BOOTMS_OS_CMDLINE)
 		return -1;
 
-	if (flag & BOOTM_STATE_OS_PREP) {
+	if (flag & BOOTMS_OS_PREP) {
 		boot_prep_linux(images);
 		return 0;
 	}
 
-	if (flag & (BOOTM_STATE_OS_GO | BOOTM_STATE_OS_FAKE_GO)) {
+	if (flag & (BOOTMS_OS_GO | BOOTMS_OS_FAKE_GO)) {
 		boot_jump_linux(images, flag);
 		return 0;
 	}
diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index 8ed923750f4..af0bba2692f 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -68,10 +68,10 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
 	struct bootm_headers *images = bmi->images;
 
-	if (flag & BOOTM_STATE_OS_PREP)
+	if (flag & BOOTMS_OS_PREP)
 		return boot_prep_linux(images);
 
-	if (flag & (BOOTM_STATE_OS_GO | BOOTM_STATE_OS_FAKE_GO)) {
+	if (flag & (BOOTMS_OS_GO | BOOTMS_OS_FAKE_GO)) {
 		bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 		printf("## Transferring control to Linux (at address %08lx)...\n",
 		       images->ep);
diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
index bb0f59e0aa2..911d019740c 100644
--- a/arch/sh/lib/bootm.c
+++ b/arch/sh/lib/bootm.c
@@ -58,10 +58,10 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	/*
 	 * allow the PREP bootm subcommand, it is required for bootm to work
 	 */
-	if (flag & BOOTM_STATE_OS_PREP)
+	if (flag & BOOTMS_OS_PREP)
 		return 0;
 
-	if ((flag != 0) && (flag != BOOTM_STATE_OS_GO))
+	if (flag && flag != BOOTMS_OS_GO)
 		return 1;
 
 	/* Clear zero page */
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 3c420b00936..5860d355c6a 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -269,13 +269,13 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	struct bootm_headers *images = bmi->images;
 
 	/* No need for those on x86 */
-	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
+	if (flag & BOOTMS_OS_BD_T || flag & BOOTMS_OS_CMDLINE)
 		return -1;
 
-	if (flag & BOOTM_STATE_OS_PREP)
+	if (flag & BOOTMS_OS_PREP)
 		return boot_prep_linux(images);
 
-	if (flag & BOOTM_STATE_OS_GO)
+	if (flag & BOOTMS_OS_GO)
 		return boot_jump_linux(images);
 
 	return boot_jump_linux(images);
diff --git a/arch/xtensa/lib/bootm.c b/arch/xtensa/lib/bootm.c
index 2958f207397..121e3b66848 100644
--- a/arch/xtensa/lib/bootm.c
+++ b/arch/xtensa/lib/bootm.c
@@ -141,7 +141,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	ulong initrd_start, initrd_end;
 	char *commandline = env_get("bootargs");
 
-	if (!(flag & (BOOTM_STATE_OS_GO | BOOTM_STATE_OS_FAKE_GO)))
+	if (!(flag & (BOOTMS_OS_GO | BOOTMS_OS_FAKE_GO)))
 		return 0;
 
 	show_boot_progress(15);
@@ -180,7 +180,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	flush_dcache_range((unsigned long)params_start, (unsigned long)params);
 
-	if (flag & BOOTM_STATE_OS_FAKE_GO)
+	if (flag & BOOTMS_OS_FAKE_GO)
 		return 0;
 
 	/*
diff --git a/boot/bootm.c b/boot/bootm.c
index 5fcf1eec583..f7891abceb1 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -253,7 +253,7 @@ static int bootm_start(void)
 	images.verify = env_get_yesno("verify");
 
 	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_START, "bootm_start");
-	images.state = BOOTM_STATE_START;
+	images.state = BOOTMS_START;
 
 	return 0;
 }
@@ -760,7 +760,7 @@ static int bootm_load_os(struct bootm_info *bmi, int boot_progress)
 			return BOOTM_ERR_RESET;
 		}
 
-		/* Handle BOOTM_STATE_LOADOS */
+		/* Handle BOOTMS_LOADOS */
 		if (relocated_addr != load) {
 			printf("Moving Image from 0x%lx to 0x%lx, end=0x%lx\n",
 			       load, relocated_addr,
@@ -1052,16 +1052,16 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	 * Work through the states and see how far we get. We stop on
 	 * any error.
 	 */
-	if (states & BOOTM_STATE_START)
+	if (states & BOOTMS_START)
 		ret = bootm_start();
 
-	if (!ret && (states & BOOTM_STATE_PRE_LOAD))
+	if (!ret && (states & BOOTMS_PRE_LOAD))
 		ret = bootm_pre_load(bmi->addr_img);
 
-	if (!ret && (states & BOOTM_STATE_FINDOS))
+	if (!ret && (states & BOOTMS_FINDOS))
 		ret = bootm_find_os(bmi->cmd_name, bmi->addr_img);
 
-	if (!ret && (states & BOOTM_STATE_FINDOTHER)) {
+	if (!ret && (states & BOOTMS_FINDOTHER)) {
 		ulong img_addr;
 
 		img_addr = bmi->addr_img ? hextoul(bmi->addr_img, NULL)
@@ -1071,11 +1071,11 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	}
 
 	if (IS_ENABLED(CONFIG_MEASURED_BOOT) && !ret &&
-	    (states & BOOTM_STATE_MEASURE))
+	    (states & BOOTMS_MEASURE))
 		bootm_measure(images);
 
 	/* Load the OS */
-	if (!ret && (states & BOOTM_STATE_LOADOS)) {
+	if (!ret && (states & BOOTMS_LOADOS)) {
 		iflag = bootm_disable_interrupts();
 		board_fixup_os(&images->os);
 		ret = bootm_load_os(bmi, 0);
@@ -1087,7 +1087,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 
 	/* Relocate the ramdisk */
 #ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
-	if (!ret && (states & BOOTM_STATE_RAMDISK)) {
+	if (!ret && (states & BOOTMS_RAMDISK)) {
 		ulong rd_len = images->rd_end - images->rd_start;
 
 		ret = boot_ramdisk_high(images->rd_start, rd_len,
@@ -1100,7 +1100,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	}
 #endif
 #if CONFIG_IS_ENABLED(OF_LIBFDT) && CONFIG_IS_ENABLED(LMB)
-	if (!ret && (states & BOOTM_STATE_FDT)) {
+	if (!ret && (states & BOOTMS_FDT)) {
 		boot_fdt_add_mem_rsv_regions(images->ft_addr);
 		ret = boot_relocate_fdt(&images->ft_addr, &images->ft_len);
 	}
@@ -1110,9 +1110,9 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	if (ret)
 		return ret;
 	boot_fn = bootm_os_get_boot_func(images->os.os);
-	need_boot_fn = states & (BOOTM_STATE_OS_CMDLINE |
-			BOOTM_STATE_OS_BD_T | BOOTM_STATE_OS_PREP |
-			BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO);
+	need_boot_fn = states & (BOOTMS_OS_CMDLINE |
+			BOOTMS_OS_BD_T | BOOTMS_OS_PREP |
+			BOOTMS_OS_FAKE_GO | BOOTMS_OS_GO);
 	if (boot_fn == NULL && need_boot_fn) {
 		if (iflag)
 			enable_interrupts();
@@ -1123,11 +1123,11 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	}
 
 	/* Call various other states that are not generally used */
-	if (!ret && (states & BOOTM_STATE_OS_CMDLINE))
-		ret = boot_fn(BOOTM_STATE_OS_CMDLINE, bmi);
-	if (!ret && (states & BOOTM_STATE_OS_BD_T))
-		ret = boot_fn(BOOTM_STATE_OS_BD_T, bmi);
-	if (!ret && (states & BOOTM_STATE_OS_PREP)) {
+	if (!ret && (states & BOOTMS_OS_CMDLINE))
+		ret = boot_fn(BOOTMS_OS_CMDLINE, bmi);
+	if (!ret && (states & BOOTMS_OS_BD_T))
+		ret = boot_fn(BOOTMS_OS_BD_T, bmi);
+	if (!ret && (states & BOOTMS_OS_PREP)) {
 		int flags = 0;
 		/* For Linux OS do all substitutions at console processing */
 		if (images->os.os == IH_OS_LINUX)
@@ -1138,15 +1138,15 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 			ret = CMD_RET_FAILURE;
 			goto err;
 		}
-		ret = boot_fn(BOOTM_STATE_OS_PREP, bmi);
+		ret = boot_fn(BOOTMS_OS_PREP, bmi);
 	}
 
 #ifdef CONFIG_TRACE
 	/* Pretend to run the OS, then run a user command */
-	if (!ret && (states & BOOTM_STATE_OS_FAKE_GO)) {
+	if (!ret && (states & BOOTMS_OS_FAKE_GO)) {
 		char *cmd_list = env_get("fakegocmd");
 
-		ret = boot_selected_os(BOOTM_STATE_OS_FAKE_GO, bmi, boot_fn);
+		ret = boot_selected_os(BOOTMS_OS_FAKE_GO, bmi, boot_fn);
 		if (!ret && cmd_list)
 			ret = run_command_list(cmd_list, -1, 0);
 	}
@@ -1159,8 +1159,8 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	}
 
 	/* Now run the OS! We hope this doesn't return */
-	if (!ret && (states & BOOTM_STATE_OS_GO))
-		ret = boot_selected_os(BOOTM_STATE_OS_GO, bmi, boot_fn);
+	if (!ret && (states & BOOTMS_OS_GO))
+		ret = boot_selected_os(BOOTMS_OS_GO, bmi, boot_fn);
 
 	/* Deal with any fallout */
 err:
@@ -1182,10 +1182,10 @@ int boot_run(struct bootm_info *bmi, const char *cmd, int extra_states)
 	int states;
 
 	bmi->cmd_name = cmd;
-	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
-		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
+	states = BOOTMS_MEASURE | BOOTMS_OS_PREP |
+		BOOTMS_OS_FAKE_GO | BOOTMS_OS_GO;
 	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
-		states |= BOOTM_STATE_RAMDISK;
+		states |= BOOTMS_RAMDISK;
 	states |= extra_states;
 
 	log_debug("cmd '%s' states %x addr_img '%s' conf_ramdisk '%s' conf_fdt '%s' images %p\n",
@@ -1197,9 +1197,9 @@ int boot_run(struct bootm_info *bmi, const char *cmd, int extra_states)
 
 int bootm_run(struct bootm_info *bmi)
 {
-	return boot_run(bmi, "bootm", BOOTM_STATE_START | BOOTM_STATE_FINDOS |
-			BOOTM_STATE_PRE_LOAD | BOOTM_STATE_FINDOTHER |
-			BOOTM_STATE_LOADOS);
+	return boot_run(bmi, "bootm", BOOTMS_START | BOOTMS_FINDOS |
+			BOOTMS_PRE_LOAD | BOOTMS_FINDOTHER |
+			BOOTMS_LOADOS);
 }
 
 int bootz_run(struct bootm_info *bmi)
@@ -1208,7 +1208,7 @@ int bootz_run(struct bootm_info *bmi)
 	ulong zi_start, zi_end;
 	int ret;
 
-	ret = bootm_run_states(bmi, BOOTM_STATE_START);
+	ret = bootm_run_states(bmi, BOOTMS_START);
 	if (ret)
 		return ret;
 
@@ -1222,7 +1222,7 @@ int bootz_run(struct bootm_info *bmi)
 	lmb_reserve(images->ep, zi_end - zi_start);
 
 	/*
-	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
+	 * Handle the BOOTMS_FINDOTHER state ourselves as we do not
 	 * have a header that provide this informaiton.
 	 */
 	if (bootm_find_images(images->ep, bmi->conf_ramdisk, bmi->conf_fdt,
@@ -1230,7 +1230,7 @@ int bootz_run(struct bootm_info *bmi)
 		return -EINVAL;
 
 	/*
-	 * We are doing the BOOTM_STATE_LOADOS state ourselves, so must
+	 * We are doing the BOOTMS_LOADOS state ourselves, so must
 	 * disable interrupts ourselves
 	 */
 	bootm_disable_interrupts();
@@ -1244,9 +1244,9 @@ int booti_run(struct bootm_info *bmi)
 {
 	bmi->ignore_bootm_len = true;
 
-	return boot_run(bmi, "booti", BOOTM_STATE_START | BOOTM_STATE_FINDOS |
-			BOOTM_STATE_PRE_LOAD | BOOTM_STATE_FINDOTHER |
-			BOOTM_STATE_LOADOS);
+	return boot_run(bmi, "booti", BOOTMS_START | BOOTMS_FINDOS |
+			BOOTMS_PRE_LOAD | BOOTMS_FINDOTHER |
+			BOOTMS_LOADOS);
 }
 
 int bootm_boot_start(ulong addr, const char *cmdline)
@@ -1256,14 +1256,14 @@ int bootm_boot_start(ulong addr, const char *cmdline)
 	int states;
 	int ret;
 
-	states = BOOTM_STATE_START | BOOTM_STATE_FINDOS | BOOTM_STATE_PRE_LOAD |
-		BOOTM_STATE_FINDOTHER | BOOTM_STATE_LOADOS |
-		BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
-		BOOTM_STATE_OS_GO;
+	states = BOOTMS_START | BOOTMS_FINDOS | BOOTMS_PRE_LOAD |
+		BOOTMS_FINDOTHER | BOOTMS_LOADOS |
+		BOOTMS_OS_PREP | BOOTMS_OS_FAKE_GO |
+		BOOTMS_OS_GO;
 	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
-		states |= BOOTM_STATE_RAMDISK;
+		states |= BOOTMS_RAMDISK;
 	if (IS_ENABLED(CONFIG_PPC) || IS_ENABLED(CONFIG_MIPS))
-		states |= BOOTM_STATE_OS_CMDLINE;
+		states |= BOOTMS_OS_CMDLINE;
 	images.state |= states;
 
 	snprintf(addr_str, sizeof(addr_str), "%lx", addr);
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 35a32f8c912..ede7eec23b8 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -73,7 +73,7 @@ static int do_bootm_netbsd(int flag, struct bootm_info *bmi)
 	ulong kernel_data, kernel_len;
 	char *cmdline;
 
-	if (flag != BOOTM_STATE_OS_GO)
+	if (flag != BOOTMS_OS_GO)
 		return 0;
 
 #if defined(CONFIG_FIT)
@@ -142,7 +142,7 @@ static int do_bootm_rtems(int flag, struct bootm_info *bmi)
 	struct bootm_headers *images = bmi->images;
 	void (*entry_point)(struct bd_info *);
 
-	if (flag != BOOTM_STATE_OS_GO)
+	if (flag != BOOTMS_OS_GO)
 		return 0;
 
 #if defined(CONFIG_FIT)
@@ -175,7 +175,7 @@ static int do_bootm_ose(int flag, struct bootm_info *bmi)
 	struct bootm_headers *images = bmi->images;
 	void (*entry_point)(void);
 
-	if (flag != BOOTM_STATE_OS_GO)
+	if (flag != BOOTMS_OS_GO)
 		return 0;
 
 #if defined(CONFIG_FIT)
@@ -209,7 +209,7 @@ static int do_bootm_plan9(int flag, struct bootm_info *bmi)
 	void (*entry_point)(void);
 	char *s;
 
-	if (flag != BOOTM_STATE_OS_GO)
+	if (flag != BOOTMS_OS_GO)
 		return 0;
 
 #if defined(CONFIG_FIT)
@@ -314,7 +314,7 @@ static int do_bootm_vxworks_legacy(int flag, struct bootm_info *bmi)
 {
 	struct bootm_headers *images = bmi->images;
 
-	if (flag != BOOTM_STATE_OS_GO)
+	if (flag != BOOTMS_OS_GO)
 		return 0;
 
 	do_bootvx_fdt(images);
@@ -345,11 +345,11 @@ int do_bootm_vxworks(int flag, struct bootm_info *bmi)
 	}
 
 	if (std_dtb) {
-		if (flag & BOOTM_STATE_OS_PREP)
+		if (flag & BOOTMS_OS_PREP)
 			printf("   Using standard DTB\n");
 		return do_bootm_linux(flag, bmi);
 	} else {
-		if (flag & BOOTM_STATE_OS_PREP)
+		if (flag & BOOTMS_OS_PREP)
 			printf("   !!! WARNING !!! Using legacy DTB\n");
 		return do_bootm_vxworks_legacy(flag, bmi);
 	}
@@ -364,7 +364,7 @@ static int do_bootm_qnxelf(int flag, struct bootm_info *bmi)
 	char str[16];
 	int dcache;
 
-	if (flag != BOOTM_STATE_OS_GO)
+	if (flag != BOOTMS_OS_GO)
 		return 0;
 
 #if defined(CONFIG_FIT)
@@ -399,7 +399,7 @@ static int do_bootm_elf(int flag, struct bootm_info *bmi)
 {
 	Bootelf_flags flags = { .autostart = 1 };
 
-	if (flag != BOOTM_STATE_OS_GO)
+	if (flag != BOOTMS_OS_GO)
 		return 0;
 
 	bootelf(bmi->images->ep, flags, 0, NULL);
@@ -414,7 +414,7 @@ static int do_bootm_integrity(int flag, struct bootm_info *bmi)
 	struct bootm_headers *images = bmi->images;
 	void (*entry_point)(void);
 
-	if (flag != BOOTM_STATE_OS_GO)
+	if (flag != BOOTMS_OS_GO)
 		return 0;
 
 #if defined(CONFIG_FIT)
@@ -447,7 +447,7 @@ static int do_bootm_openrtos(int flag, struct bootm_info *bmi)
 	struct bootm_headers *images = bmi->images;
 	void (*entry_point)(void);
 
-	if (flag != BOOTM_STATE_OS_GO)
+	if (flag != BOOTMS_OS_GO)
 		return 0;
 
 	entry_point = (void (*)(void))images->ep;
@@ -492,7 +492,7 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
 	int ret;
 	void *image_buf;
 
-	if (flag != BOOTM_STATE_OS_GO)
+	if (flag != BOOTMS_OS_GO)
 		return 0;
 
 	/* We expect to return */
@@ -578,7 +578,7 @@ int boot_selected_os(int state, struct bootm_info *bmi, boot_os_fn *boot_fn)
 	/* Stand-alone may return when 'autostart' is 'no' */
 	if (bmi->images->os.type == IH_TYPE_STANDALONE ||
 	    IS_ENABLED(CONFIG_SANDBOX) ||
-	    state == BOOTM_STATE_OS_FAKE_GO) /* We expect to return */
+	    state == BOOTMS_OS_FAKE_GO) /* We expect to return */
 		return 0;
 	bootstage_error(BOOTSTAGE_ID_BOOT_OS_RETURNED);
 	debug("\n## Control returned to monitor - resetting...\n");
diff --git a/cmd/booti.c b/cmd/booti.c
index f4f782da056..b24c1e877d0 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -33,7 +33,7 @@ static int booti_start(struct bootm_info *bmi)
 	unsigned long decomp_len;
 	int ctype;
 
-	ret = bootm_run_states(bmi, BOOTM_STATE_START);
+	ret = bootm_run_states(bmi, BOOTMS_START);
 
 	/* Setup Linux kernel Image entry point */
 	if (!bmi->addr_img) {
@@ -76,7 +76,7 @@ static int booti_start(struct bootm_info *bmi)
 	if (ret)
 		return 1;
 
-	/* Handle BOOTM_STATE_LOADOS */
+	/* Handle BOOTMS_LOADOS */
 	if (relocated_addr != ld) {
 		printf("Moving Image from 0x%lx to 0x%lx, end=0x%lx\n", ld,
 		       relocated_addr, relocated_addr + image_size);
@@ -90,7 +90,7 @@ static int booti_start(struct bootm_info *bmi)
 	lmb_reserve(images->ep, le32_to_cpu(image_size));
 
 	/*
-	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
+	 * Handle the BOOTMS_FINDOTHER state ourselves as we do not
 	 * have a header that provide this informaiton.
 	 */
 	if (bootm_find_images(image_load_addr, bmi->conf_ramdisk, bmi->conf_fdt,
@@ -125,7 +125,7 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return 1;
 
 	/*
-	 * We are doing the BOOTM_STATE_LOADOS state ourselves, so must
+	 * We are doing the BOOTMS_LOADOS state ourselves, so must
 	 * disable interrupts ourselves
 	 */
 	bootm_disable_interrupts();
@@ -136,10 +136,10 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	else if (IS_ENABLED(CONFIG_ARM64))
 		images.os.arch = IH_ARCH_ARM64;
 
-	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
-		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
+	states = BOOTMS_MEASURE | BOOTMS_OS_PREP |
+		BOOTMS_OS_FAKE_GO | BOOTMS_OS_GO;
 	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
-		states |= BOOTM_STATE_RAMDISK;
+		states |= BOOTMS_RAMDISK;
 
 	ret = bootm_run_states(&bmi, states);
 
diff --git a/cmd/bootm.c b/cmd/bootm.c
index bee683d0580..abe2c68fe1b 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -40,22 +40,22 @@ static int do_imls(struct cmd_tbl *cmdtp, int flag, int argc,
 /* we overload the cmd field with our state machine info instead of a
  * function pointer */
 static struct cmd_tbl cmd_bootm_sub[] = {
-	U_BOOT_CMD_MKENT(start, 0, 1, (void *)BOOTM_STATE_START, "", ""),
-	U_BOOT_CMD_MKENT(loados, 0, 1, (void *)BOOTM_STATE_LOADOS, "", ""),
+	U_BOOT_CMD_MKENT(start, 0, 1, (void *)BOOTMS_START, "", ""),
+	U_BOOT_CMD_MKENT(loados, 0, 1, (void *)BOOTMS_LOADOS, "", ""),
 #ifdef CONFIG_CMD_BOOTM_PRE_LOAD
-	U_BOOT_CMD_MKENT(preload, 0, 1, (void *)BOOTM_STATE_PRE_LOAD, "", ""),
+	U_BOOT_CMD_MKENT(preload, 0, 1, (void *)BOOTMS_PRE_LOAD, "", ""),
 #endif
 #ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
-	U_BOOT_CMD_MKENT(ramdisk, 0, 1, (void *)BOOTM_STATE_RAMDISK, "", ""),
+	U_BOOT_CMD_MKENT(ramdisk, 0, 1, (void *)BOOTMS_RAMDISK, "", ""),
 #endif
 #ifdef CONFIG_OF_LIBFDT
-	U_BOOT_CMD_MKENT(fdt, 0, 1, (void *)BOOTM_STATE_FDT, "", ""),
+	U_BOOT_CMD_MKENT(fdt, 0, 1, (void *)BOOTMS_FDT, "", ""),
 #endif
-	U_BOOT_CMD_MKENT(cmdline, 0, 1, (void *)BOOTM_STATE_OS_CMDLINE, "", ""),
-	U_BOOT_CMD_MKENT(bdt, 0, 1, (void *)BOOTM_STATE_OS_BD_T, "", ""),
-	U_BOOT_CMD_MKENT(prep, 0, 1, (void *)BOOTM_STATE_OS_PREP, "", ""),
-	U_BOOT_CMD_MKENT(fake, 0, 1, (void *)BOOTM_STATE_OS_FAKE_GO, "", ""),
-	U_BOOT_CMD_MKENT(go, 0, 1, (void *)BOOTM_STATE_OS_GO, "", ""),
+	U_BOOT_CMD_MKENT(cmdline, 0, 1, (void *)BOOTMS_OS_CMDLINE, "", ""),
+	U_BOOT_CMD_MKENT(bdt, 0, 1, (void *)BOOTMS_OS_BD_T, "", ""),
+	U_BOOT_CMD_MKENT(prep, 0, 1, (void *)BOOTMS_OS_PREP, "", ""),
+	U_BOOT_CMD_MKENT(fake, 0, 1, (void *)BOOTMS_OS_FAKE_GO, "", ""),
+	U_BOOT_CMD_MKENT(go, 0, 1, (void *)BOOTMS_OS_GO, "", ""),
 };
 
 #if defined(CONFIG_CMD_BOOTM_PRE_LOAD)
@@ -85,19 +85,19 @@ static int do_bootm_subcommand(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (c) {
 		state = (long)c->cmd;
-		if (state == BOOTM_STATE_START)
-			state |= BOOTM_STATE_PRE_LOAD | BOOTM_STATE_FINDOS |
-				 BOOTM_STATE_FINDOTHER;
+		if (state == BOOTMS_START)
+			state |= BOOTMS_PRE_LOAD | BOOTMS_FINDOS |
+				 BOOTMS_FINDOTHER;
 #if defined(CONFIG_CMD_BOOTM_PRE_LOAD)
-		if (state == BOOTM_STATE_PRE_LOAD)
-			state |= BOOTM_STATE_START;
+		if (state == BOOTMS_PRE_LOAD)
+			state |= BOOTMS_START;
 #endif
 	} else {
 		/* Unrecognized command */
 		return CMD_RET_USAGE;
 	}
 
-	if (((state & BOOTM_STATE_START) != BOOTM_STATE_START) &&
+	if (((state & BOOTMS_START) != BOOTMS_START) &&
 	    images.state >= state) {
 		printf("Trying to execute a command out of order\n");
 		return CMD_RET_USAGE;
@@ -120,7 +120,7 @@ static int do_bootm_subcommand(struct cmd_tbl *cmdtp, int flag, int argc,
 	ret = bootm_run_states(&bmi, state);
 
 #if defined(CONFIG_CMD_BOOTM_PRE_LOAD)
-	if (!ret && (state & BOOTM_STATE_PRE_LOAD))
+	if (!ret && (state & BOOTMS_PRE_LOAD))
 		env_set_hex("loadaddr_verified",
 			    bootm_get_addr(argc, argv) + image_load_offset);
 #endif
diff --git a/include/bootm.h b/include/bootm.h
index 97f77bc1ded..78fbea29f6d 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -119,7 +119,7 @@ void bootm_init(struct bootm_info *bmi);
  *  - loaded (first part of) image to header load address,
  *  - disabled interrupts.
  *
- * @flag: Flags indicating what to do (BOOTM_STATE_...)
+ * @flag: Flags indicating what to do (BOOTMS_...)
  * @bmi: Bootm information
  * Return: 1 on error. On success the OS boots so this function does
  * not return.
@@ -180,7 +180,7 @@ int bootm_measure(struct bootm_headers *images);
  * bootm_run_states() - Execute selected states of the bootm command.
  *
  * Note that if states contains more than one flag it MUST contain
- * BOOTM_STATE_START, since this handles the addr_fit, conf_ramdisk and conf_fit
+ * BOOTMS_START, since this handles the addr_fit, conf_ramdisk and conf_fit
  * members of @bmi
  *
  * Also note that aside from boot_os_fn functions and bootm_load_os, no other
@@ -188,9 +188,9 @@ int bootm_measure(struct bootm_headers *images);
  * value, without special handling.
  *
  * @bmi: bootm information
- * @states	Mask containing states to run (BOOTM_STATE_...)
+ * @states	Mask containing states to run (BOOTMS_...)
  * Return: 0 if ok, something else on error. Some errors will cause this
- *	function to perform a reboot! If states contains BOOTM_STATE_OS_GO
+ *	function to perform a reboot! If states contains BOOTMS_OS_GO
  *	then the intent is to boot an OS, so this function will not return
  *	unless the image type is standalone.
  */
diff --git a/include/image.h b/include/image.h
index 2455baa6667..44bc8fb9fa0 100644
--- a/include/image.h
+++ b/include/image.h
@@ -398,19 +398,19 @@ struct bootm_headers {
 
 	int		verify;		/* env_get("verify")[0] != 'n' */
 
-#define BOOTM_STATE_START	0x00000001
-#define BOOTM_STATE_FINDOS	0x00000002
-#define BOOTM_STATE_FINDOTHER	0x00000004
-#define BOOTM_STATE_LOADOS	0x00000008
-#define BOOTM_STATE_RAMDISK	0x00000010
-#define BOOTM_STATE_FDT		0x00000020
-#define BOOTM_STATE_OS_CMDLINE	0x00000040
-#define BOOTM_STATE_OS_BD_T	0x00000080
-#define BOOTM_STATE_OS_PREP	0x00000100
-#define BOOTM_STATE_OS_FAKE_GO	0x00000200	/* 'Almost' run the OS */
-#define BOOTM_STATE_OS_GO	0x00000400
-#define BOOTM_STATE_PRE_LOAD	0x00000800
-#define BOOTM_STATE_MEASURE	0x00001000
+#define BOOTMS_START	0x00000001
+#define BOOTMS_FINDOS	0x00000002
+#define BOOTMS_FINDOTHER	0x00000004
+#define BOOTMS_LOADOS	0x00000008
+#define BOOTMS_RAMDISK	0x00000010
+#define BOOTMS_FDT		0x00000020
+#define BOOTMS_OS_CMDLINE	0x00000040
+#define BOOTMS_OS_BD_T	0x00000080
+#define BOOTMS_OS_PREP	0x00000100
+#define BOOTMS_OS_FAKE_GO	0x00000200	/* 'Almost' run the OS */
+#define BOOTMS_OS_GO	0x00000400
+#define BOOTMS_PRE_LOAD	0x00000800
+#define BOOTMS_MEASURE	0x00001000
 	int		state;
 };
 
-- 
2.43.0

base-commit: 36c8798ae6013c8fb784eec1dacf1652e91aecfb
branch: booa
