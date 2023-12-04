Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACF4C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8324B8771E;
	Mon,  4 Dec 2023 01:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZbkPfc8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C0A8876E0; Mon,  4 Dec 2023 01:27:29 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A7AB876C4
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ce33234fd7so242517b3a.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649643; x=1702254443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ak7kyqDJhuQ1fPclCPNXNCCd4w/CAZ5XJJJwTbbCKnA=;
 b=ZbkPfc8fRy7ih9iKtVlulpauPVbA4Lk9dHFSpxQGiN6410SVW3UyUFmvx7y1WE3Ltp
 AM2vGUQ9fT0ftB47xv1ejtzfvOwvjlJsNebi2nASyKfHE/BkS4iMfe85Okw+vEh7gim3
 Bkhr5E6oK+67DRC+GuvPflJJkGtuvhW8tfxGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649643; x=1702254443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ak7kyqDJhuQ1fPclCPNXNCCd4w/CAZ5XJJJwTbbCKnA=;
 b=oWMQyHJTQMn47qwENg2jS05GJstCrAM3Eue1qaBb2MVaPl256vwwpRZiAOZlmiL2fe
 t8EeId48DgrEHIxnAlOl3tk+5m3WnFewBeh4aelWbTM8Rlt/1Rk27ju4fX82FbLWts2B
 /kolJlWzoeBGUa7nGuOdxBYsTkK5eGxaoxuMR7WqdF81Ph52toHW2wOIWlKT1edbaWYg
 rcaulzO8S4TKdlXB4/xPaMpxb1WO9cPmrq2B0yBw8dxbTrrhZqtwySNVTVqyMefIJIbC
 iJSjRJUYaxMbjWz8bai+cbyoKRddDPpe9eJ7+dUYYLTSlo1UVWLWQuMDchxEGctqmeDn
 MDhw==
X-Gm-Message-State: AOJu0YxMev+b7XyK8aEvT+J4oTvyminoKBDjExcia75t6ZwSBcCHX3TK
 rjBKtBwgA5e+WB5Cecm4IV9aynMQgnlwGy4tFXjP4A==
X-Google-Smtp-Source: AGHT+IHKL5fBRfwWwkaGBlujDpEb7GpqzEvSLgpqMBStBHFly855XrKUc28N9ojw9GjisOFsh/LQsw==
X-Received: by 2002:a05:6a20:a41e:b0:18f:97c:5bad with SMTP id
 z30-20020a056a20a41e00b0018f097c5badmr493571pzk.123.1701649643107; 
 Sun, 03 Dec 2023 16:27:23 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Huan Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Rick Chen <rick@andestech.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Thomas Chou <thomas@wytron.com.tw>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 05/18] treewide: bootm: Drop command-line args to boot_os_fn
Date: Sun,  3 Dec 2023 17:26:21 -0700
Message-ID: <20231203172622.5.Id5671bc2d663f968a6f9da1c7d248525a794a4ba@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002642.895926-1-sjg@chromium.org>
References: <20231204002642.895926-1-sjg@chromium.org>
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

These arguments are not used now. They cannot be provided when there is
no bootm command invoked to provide arguments. Drop the argc and argv
parameters.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arc/lib/bootm.c        |  2 +-
 arch/arm/lib/bootm.c        |  3 +--
 arch/m68k/lib/bootm.c       |  3 +--
 arch/microblaze/lib/bootm.c |  3 +--
 arch/mips/lib/bootm.c       |  3 +--
 arch/nios2/lib/bootm.c      |  3 +--
 arch/powerpc/lib/bootm.c    |  3 +--
 arch/riscv/lib/bootm.c      |  5 ++--
 arch/sandbox/lib/bootm.c    |  2 +-
 arch/sh/lib/bootm.c         |  3 +--
 arch/x86/lib/bootm.c        |  3 +--
 arch/xtensa/lib/bootm.c     |  2 +-
 boot/bootm.c                |  6 ++---
 boot/bootm_os.c             | 46 ++++++++++++++-----------------------
 include/bootm.h             |  7 +-----
 15 files changed, 34 insertions(+), 60 deletions(-)

diff --git a/arch/arc/lib/bootm.c b/arch/arc/lib/bootm.c
index 44ec5864a1c6..0ae7a21b24b6 100644
--- a/arch/arc/lib/bootm.c
+++ b/arch/arc/lib/bootm.c
@@ -78,7 +78,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 		board_jump_and_run(kernel_entry, r0, 0, r2);
 }
 
-int do_bootm_linux(int flag, int argc, char *argv[], struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_headers *images)
 {
 	/* No need for those on ARC */
 	if ((flag & BOOTM_STATE_OS_BD_T) || (flag & BOOTM_STATE_OS_CMDLINE))
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index c56285738a26..ebaac029e094 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -378,8 +378,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
  * DIFFERENCE: Instead of calling prep and go at the end
  * they are called if subcommand is equal 0.
  */
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_headers *images)
 {
 	/* No need for those on ARM */
 	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index 79d8b34c0d56..0720861ae9cc 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -34,8 +34,7 @@ void arch_lmb_reserve(struct lmb *lmb)
 	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 1024);
 }
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_headers *images)
 {
 	int ret;
 	struct bd_info  *kbd;
diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
index f3ec4b741b88..93cdf62e18cf 100644
--- a/arch/microblaze/lib/bootm.c
+++ b/arch/microblaze/lib/bootm.c
@@ -81,8 +81,7 @@ static void boot_prep_linux(struct bootm_headers *images)
 	}
 }
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_headers *images)
 {
 	images->cmdline_start = (ulong)env_get("bootargs");
 
diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index d6d2f7d9d031..05dbe6131728 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -300,8 +300,7 @@ static void boot_jump_linux(struct bootm_headers *images)
 			linux_extra);
 }
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_headers *images)
 {
 	/* No need for those on MIPS */
 	if (flag & BOOTM_STATE_OS_BD_T)
diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
index 823d524c9a2d..040a806bc75e 100644
--- a/arch/nios2/lib/bootm.c
+++ b/arch/nios2/lib/bootm.c
@@ -16,8 +16,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define NIOS_MAGIC 0x534f494e /* enable command line and initrd passing */
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_headers *images)
 {
 	void (*kernel)(int, int, int, char *) = (void *)images->ep;
 	char *commandline = env_get("bootargs");
diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index 910121ec9c85..4d248cb13b5f 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -223,8 +223,7 @@ static int boot_body_linux(struct bootm_headers *images)
 	return 0;
 }
 
-noinline int do_bootm_linux(int flag, int argc, char *const argv[],
-			    struct bootm_headers *images)
+noinline int do_bootm_linux(int flag, struct bootm_headers *images)
 {
 	int	ret;
 
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index f9e1e18ae026..d90f26091530 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -105,8 +105,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	}
 }
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_headers *images)
 {
 	/* No need for those on RISC-V */
 	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
@@ -130,7 +129,7 @@ int do_bootm_linux(int flag, int argc, char *const argv[],
 int do_bootm_vxworks(int flag, int argc, char *const argv[],
 		     struct bootm_headers *images)
 {
-	return do_bootm_linux(flag, argc, argv, images);
+	return do_bootm_linux(flag, images);
 }
 
 static ulong get_sp(void)
diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index dc8b8e46cb41..d2b514d3f0ca 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -64,7 +64,7 @@ static int boot_prep_linux(struct bootm_headers *images)
 	return 0;
 }
 
-int do_bootm_linux(int flag, int argc, char *argv[], struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_headers *images)
 {
 	if (flag & BOOTM_STATE_OS_PREP)
 		return boot_prep_linux(images);
diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
index b205e5e3db1b..d0284582ae0e 100644
--- a/arch/sh/lib/bootm.c
+++ b/arch/sh/lib/bootm.c
@@ -39,8 +39,7 @@ static unsigned long sh_check_cmd_arg(char *cmdline, char *key, int base)
 	return val;
 }
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_headers *images)
 {
 	/* Linux kernel load address */
 	void (*kernel) (void) = (void (*)(void))images->ep;
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 3196f9ddc2c8..34d5c585a55a 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -237,8 +237,7 @@ static int boot_jump_linux(struct bootm_headers *images)
 				 images->os.arch == IH_ARCH_X86_64);
 }
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_headers *images)
 {
 	/* No need for those on x86 */
 	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
diff --git a/arch/xtensa/lib/bootm.c b/arch/xtensa/lib/bootm.c
index fee339281502..5e8e14021ab3 100644
--- a/arch/xtensa/lib/bootm.c
+++ b/arch/xtensa/lib/bootm.c
@@ -134,7 +134,7 @@ static struct bp_tag *setup_fdt_tag(struct bp_tag *params, void *fdt_start)
  * Boot Linux.
  */
 
-int do_bootm_linux(int flag, int argc, char *argv[], struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_headers *images)
 {
 	struct bp_tag *params, *params_start;
 	ulong initrd_start, initrd_end;
diff --git a/boot/bootm.c b/boot/bootm.c
index 301cfded05cb..c343f313e80a 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1099,9 +1099,9 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* Call various other states that are not generally used */
 	if (!ret && (states & BOOTM_STATE_OS_CMDLINE))
-		ret = boot_fn(BOOTM_STATE_OS_CMDLINE, argc, argv, images);
+		ret = boot_fn(BOOTM_STATE_OS_CMDLINE, images);
 	if (!ret && (states & BOOTM_STATE_OS_BD_T))
-		ret = boot_fn(BOOTM_STATE_OS_BD_T, argc, argv, images);
+		ret = boot_fn(BOOTM_STATE_OS_BD_T, images);
 	if (!ret && (states & BOOTM_STATE_OS_PREP)) {
 		ret = bootm_process_cmdline_env(images->os.os == IH_OS_LINUX);
 		if (ret) {
@@ -1109,7 +1109,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 			ret = CMD_RET_FAILURE;
 			goto err;
 		}
-		ret = boot_fn(BOOTM_STATE_OS_PREP, argc, argv, images);
+		ret = boot_fn(BOOTM_STATE_OS_PREP, images);
 	}
 
 #ifdef CONFIG_TRACE
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 598671e576c6..df1aab4b3e4d 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -23,8 +23,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static int do_bootm_standalone(int flag, int argc, char *const argv[],
-			       struct bootm_headers *images)
+static int do_bootm_standalone(int flag, struct bootm_headers *images)
 {
 	int (*appl)(int, char *const[]);
 
@@ -33,7 +32,7 @@ static int do_bootm_standalone(int flag, int argc, char *const argv[],
 		return 0;
 	}
 	appl = (int (*)(int, char * const []))images->ep;
-	appl(argc, argv);
+	appl(0, NULL);
 	return 0;
 }
 
@@ -50,8 +49,7 @@ static void __maybe_unused fit_unsupported_reset(const char *msg)
 }
 
 #ifdef CONFIG_BOOTM_NETBSD
-static int do_bootm_netbsd(int flag, int argc, char *const argv[],
-			   struct bootm_headers *images)
+static int do_bootm_netbsd(int flag, struct bootm_headers *images)
 {
 	void (*loader)(struct bd_info *bd, struct legacy_img_hdr *hdr,
 		       char *console, char *cmdline);
@@ -113,8 +111,7 @@ static int do_bootm_netbsd(int flag, int argc, char *const argv[],
 #endif /* CONFIG_BOOTM_NETBSD*/
 
 #ifdef CONFIG_BOOTM_RTEMS
-static int do_bootm_rtems(int flag, int argc, char *const argv[],
-			  struct bootm_headers *images)
+static int do_bootm_rtems(int flag, struct bootm_headers *images)
 {
 	void (*entry_point)(struct bd_info *);
 
@@ -146,8 +143,7 @@ static int do_bootm_rtems(int flag, int argc, char *const argv[],
 #endif /* CONFIG_BOOTM_RTEMS */
 
 #if defined(CONFIG_BOOTM_OSE)
-static int do_bootm_ose(int flag, int argc, char *const argv[],
-			struct bootm_headers *images)
+static int do_bootm_ose(int flag, struct bootm_headers *images)
 {
 	void (*entry_point)(void);
 
@@ -179,8 +175,7 @@ static int do_bootm_ose(int flag, int argc, char *const argv[],
 #endif /* CONFIG_BOOTM_OSE */
 
 #if defined(CONFIG_BOOTM_PLAN9)
-static int do_bootm_plan9(int flag, int argc, char *const argv[],
-			  struct bootm_headers *images)
+static int do_bootm_plan9(int flag, struct bootm_headers *images)
 {
 	void (*entry_point)(void);
 	char *s;
@@ -283,8 +278,7 @@ static void do_bootvx_fdt(struct bootm_headers *images)
 	puts("## vxWorks terminated\n");
 }
 
-static int do_bootm_vxworks_legacy(int flag, int argc, char *const argv[],
-				   struct bootm_headers *images)
+static int do_bootm_vxworks_legacy(int flag, struct bootm_headers *images)
 {
 	if (flag != BOOTM_STATE_OS_GO)
 		return 0;
@@ -294,8 +288,7 @@ static int do_bootm_vxworks_legacy(int flag, int argc, char *const argv[],
 	return 1;
 }
 
-int do_bootm_vxworks(int flag, int argc, char *const argv[],
-		     struct bootm_headers *images)
+int do_bootm_vxworks(int flag, struct bootm_headers *images)
 {
 	char *bootargs;
 	int pos;
@@ -320,18 +313,17 @@ int do_bootm_vxworks(int flag, int argc, char *const argv[],
 	if (std_dtb) {
 		if (flag & BOOTM_STATE_OS_PREP)
 			printf("   Using standard DTB\n");
-		return do_bootm_linux(flag, argc, argv, images);
+		return do_bootm_linux(flag, images);
 	} else {
 		if (flag & BOOTM_STATE_OS_PREP)
 			printf("   !!! WARNING !!! Using legacy DTB\n");
-		return do_bootm_vxworks_legacy(flag, argc, argv, images);
+		return do_bootm_vxworks_legacy(flag, images);
 	}
 }
 #endif
 
 #if defined(CONFIG_CMD_ELF)
-static int do_bootm_qnxelf(int flag, int argc, char *const argv[],
-			   struct bootm_headers *images)
+static int do_bootm_qnxelf(int flag, struct bootm_headers *images)
 {
 	char *local_args[3];
 	char str[16];
@@ -369,8 +361,7 @@ static int do_bootm_qnxelf(int flag, int argc, char *const argv[],
 #endif
 
 #ifdef CONFIG_INTEGRITY
-static int do_bootm_integrity(int flag, int argc, char *const argv[],
-			      struct bootm_headers *images)
+static int do_bootm_integrity(int flag, struct bootm_headers *images)
 {
 	void (*entry_point)(void);
 
@@ -402,8 +393,7 @@ static int do_bootm_integrity(int flag, int argc, char *const argv[],
 #endif
 
 #ifdef CONFIG_BOOTM_OPENRTOS
-static int do_bootm_openrtos(int flag, int argc, char *const argv[],
-			     struct bootm_headers *images)
+static int do_bootm_openrtos(int flag, struct bootm_headers *images)
 {
 	void (*entry_point)(void);
 
@@ -428,8 +418,7 @@ static int do_bootm_openrtos(int flag, int argc, char *const argv[],
 #endif
 
 #ifdef CONFIG_BOOTM_OPTEE
-static int do_bootm_tee(int flag, int argc, char *const argv[],
-			struct bootm_headers *images)
+static int do_bootm_tee(int flag, struct bootm_headers *images)
 {
 	int ret;
 
@@ -441,13 +430,12 @@ static int do_bootm_tee(int flag, int argc, char *const argv[],
 		return ret;
 
 	/* From here we can run the regular linux boot path */
-	return do_bootm_linux(flag, argc, argv, images);
+	return do_bootm_linux(flag, images);
 }
 #endif
 
 #ifdef CONFIG_BOOTM_EFI
-static int do_bootm_efi(int flag, int argc, char *const argv[],
-			struct bootm_headers *images)
+static int do_bootm_efi(int flag, struct bootm_headers *images)
 {
 	efi_status_t efi_ret;
 	void *image_buf;
@@ -544,7 +532,7 @@ int boot_selected_os(int argc, char *const argv[], int state,
 {
 	arch_preboot_os();
 	board_preboot_os();
-	boot_fn(state, argc, argv, images);
+	boot_fn(state, images);
 
 	/* Stand-alone may return when 'autostart' is 'no' */
 	if (images->os.type == IH_TYPE_STANDALONE ||
diff --git a/include/bootm.h b/include/bootm.h
index f5229ea90b33..0e4662485006 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -25,16 +25,11 @@ struct cmd_tbl;
  *  - disabled interrupts.
  *
  * @flag: Flags indicating what to do (BOOTM_STATE_...)
- * @argc: Number of arguments. Note that the arguments are shifted down
- *	 so that 0 is the first argument not processed by U-Boot, and
- *	 argc is adjusted accordingly. This avoids confusion as to how
- *	 many arguments are available for the OS.
  * @images: Pointers to os/initrd/fdt
  * Return: 1 on error. On success the OS boots so this function does
  * not return.
  */
-typedef int boot_os_fn(int flag, int argc, char *const argv[],
-			struct bootm_headers *images);
+typedef int boot_os_fn(int flag, struct bootm_headers *images);
 
 extern boot_os_fn do_bootm_linux;
 extern boot_os_fn do_bootm_vxworks;
-- 
2.43.0.rc2.451.g8631bc7472-goog

