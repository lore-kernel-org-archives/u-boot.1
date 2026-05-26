Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C1BCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F219E8487C;
	Tue, 26 May 2026 15:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nivKZ6M3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F6B84886; Tue, 26 May 2026 15:10:16 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 562158487C
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-69d7e72b052so2826230eaf.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779801013; x=1780405813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8ztdgNaE9CcOtWVgkrEblSIUvpfE9msuf53H1fACNY=;
 b=nivKZ6M3GJSlsBuLC7fSIMmOIHK8SEWyeXs918Tv/Ag5HywCwk79Jh6t0zsN4si1fi
 Zp2vJgLwPPv9Vc4bedJLunO0MkRTZ5znno4hzdPVk5qjSPmLc88ZlJDWL8/YXjECaih4
 wDwv3EfaqTzwtvQPzxAsYmnPoEorr34CijEQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801013; x=1780405813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n8ztdgNaE9CcOtWVgkrEblSIUvpfE9msuf53H1fACNY=;
 b=hFPpZafd+hAleVDOslMZaGhsZjIxM6Kn4Qm4kYEIciYPxfwEL0C8ocq6AxqktOkJGE
 CqExqcqRiN+tK8yOsM2/SxYQpXj9CJGLtrSQtlSOjb/bNTSY3SyP+iJnRM5Lx2wY2qB/
 optdH2ki2cVbehZTYwniwXYYDuZMJlaqjGkMEcnUHqOKbys1ECqLpdr1oQHQcuptdDmN
 VlTvR6SE587S4Fv9+/vQlXlWYdJe0RaBLPpf5Lwbe3DRg19Q7OcW8pCFTkubAwmYhau+
 EMH3ylJ8HnqISNemG7Y2gRHxIvIu1DAb9O5RzrGVhVgTE7lXkvekZAxkW/lDB2EEEPZ2
 69SQ==
X-Gm-Message-State: AOJu0YywY4fZXn/byszkL95H8KIfU1sO86uie8qDsab7+jOn7GMlrJuC
 BUvaOV7pDOkf0NrBEIequgs6atINWkCuAQSTDx/fOfTYfq7wt6fCF04u1L3qWtaxABC8W1vVIjW
 A2PKNvYVErow=
X-Gm-Gg: Acq92OEnH/Q8mYdoc/TJbQ2vXS2P/3KqLSq6ajw8RF2YoZvY8yvMWPcVURW4chtHAlb
 ATmp7h4ZFQC1L/FU3Lz1RGGqBEZr3Sz4kEa9MojKn2RVyFYKgniQItgSTBUietNu9UlTOMq5xbG
 R/XmI1K0ACK82/ChtIv/dG4q1SO4ALEK2G0R+Uqo4vS7Ex4tgUjYdbyf2L2ulbmSgXjhF6NARUw
 matwSad2hjFgH0tzEaCd8kYATctObMnkvprNB8HSgJqxrJPcJVA0FSSsLg/M03nD0syRx7fy3Lh
 sms5qAr5//rm32NHpv9tn9Qfbuvh06Wq78oMyhTmtALhbFkq4LsLlCBxtcY6hdCnM+kQ6oLMv2o
 GOTRlSg5Une9CHr3tM1okhb1ucNNH4HOqPDZy/lXA/LD3dLWX7HQsTg0OmZZ53BNBGP5eBgJSU9
 ORDSB0LnLzI7L/gFKiwWOV6cPEAYIw
X-Received: by 2002:a05:6820:1995:b0:67b:b8d0:a7d5 with SMTP id
 006d021491bc7-69d7ecb113emr10495666eaf.53.1779801012985; 
 Tue, 26 May 2026 06:10:12 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83aafca2sm6974601eaf.15.2026.05.26.06.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:10:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH 5/9] x86: Rename state to bmi
Date: Tue, 26 May 2026 07:09:11 -0600
Message-ID: <20260526130931.2103552-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526130931.2103552-1-sjg@chromium.org>
References: <20260526130931.2103552-1-sjg@chromium.org>
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

Use the common name for the struct, in preparation for passing it around
between functions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/include/asm/zimage.h |  2 +-
 arch/x86/lib/zimage.c         | 48 +++++++++++++++++------------------
 cmd/x86/zboot.c               |  4 +--
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index 13a08850dfb..b592057e58b 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -42,7 +42,7 @@ enum {
 	ZBOOT_STATE_COUNT	= 5,
 };
 
-extern struct bootm_info state;
+extern struct bootm_info bmi;
 
 /**
  * zboot_load() - Load a zimage
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index cba0039f713..965fcb1c38a 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -53,7 +53,7 @@
 #define COMMAND_LINE_SIZE	2048
 
 /* Current state of the boot */
-struct bootm_info state;
+struct bootm_info bmi;
 
 static void build_command_line(char *command_line, int auto_boot)
 {
@@ -371,26 +371,26 @@ int zboot_load(void)
 	struct boot_params *base_ptr;
 	int ret;
 
-	if (state.base_ptr) {
-		struct boot_params *from = (struct boot_params *)state.base_ptr;
+	if (bmi.base_ptr) {
+		struct boot_params *from = (struct boot_params *)bmi.base_ptr;
 
 		base_ptr = (struct boot_params *)DEFAULT_SETUP_BASE;
 		log_debug("Building boot_params at %lx\n", (ulong)base_ptr);
 		memset(base_ptr, '\0', sizeof(*base_ptr));
 		base_ptr->hdr = from->hdr;
 	} else {
-		base_ptr = load_zimage((void *)state.bzimage_addr, state.bzimage_size,
-				       &state.load_address);
+		base_ptr = load_zimage((void *)bmi.bzimage_addr, bmi.bzimage_size,
+				       &bmi.load_address);
 		if (!base_ptr) {
 			puts("## Kernel loading failed ...\n");
 			return -EINVAL;
 		}
 	}
-	state.base_ptr = base_ptr;
+	bmi.base_ptr = base_ptr;
 
-	ret = env_set_hex("zbootbase", map_to_sysmem(state.base_ptr));
+	ret = env_set_hex("zbootbase", map_to_sysmem(bmi.base_ptr));
 	if (!ret)
-		ret = env_set_hex("zbootaddr", state.load_address);
+		ret = env_set_hex("zbootaddr", bmi.load_address);
 	if (ret)
 		return ret;
 
@@ -399,12 +399,12 @@ int zboot_load(void)
 
 int zboot_setup(void)
 {
-	struct boot_params *base_ptr = state.base_ptr;
+	struct boot_params *base_ptr = bmi.base_ptr;
 	int ret;
 
 	ret = setup_zimage(base_ptr, (char *)base_ptr + COMMAND_LINE_OFFSET,
-			   0, state.initrd_addr, state.initrd_size,
-			   (ulong)state.cmdline);
+			   0, bmi.initrd_addr, bmi.initrd_size,
+			   (ulong)bmi.cmdline);
 	if (ret)
 		return -EINVAL;
 
@@ -413,7 +413,7 @@ int zboot_setup(void)
 
 int zboot_go(void)
 {
-	struct boot_params *params = state.base_ptr;
+	struct boot_params *params = bmi.base_ptr;
 	struct setup_header *hdr = &params->hdr;
 	bool image_64bit;
 	ulong entry;
@@ -421,7 +421,7 @@ int zboot_go(void)
 
 	disable_interrupts();
 
-	entry = state.load_address;
+	entry = bmi.load_address;
 	image_64bit = false;
 	if (IS_ENABLED(CONFIG_X86_64) &&
 	    (hdr->xloadflags & XLF_KERNEL_64)) {
@@ -429,7 +429,7 @@ int zboot_go(void)
 	}
 
 	/* we assume that the kernel is in place */
-	ret = boot_linux_kernel((ulong)state.base_ptr, entry, image_64bit);
+	ret = boot_linux_kernel((ulong)bmi.base_ptr, entry, image_64bit);
 
 	return ret;
 }
@@ -577,7 +577,7 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 	print_num("Start sys seg", hdr->start_sys_seg);
 	print_num("Kernel version", hdr->kernel_version);
 	version = zimage_get_kernel_version(base_ptr,
-					    (void *)state.bzimage_addr);
+					    (void *)bmi.bzimage_addr);
 	if (version)
 		printf("   @%p: %s\n", version, version);
 	print_num("Type of loader", hdr->type_of_loader);
@@ -623,22 +623,22 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 void zboot_start(ulong bzimage_addr, ulong bzimage_size, ulong initrd_addr,
 		 ulong initrd_size, ulong base_addr, const char *cmdline)
 {
-	bootm_init(&state);
+	bootm_init(&bmi);
 
-	state.bzimage_size = bzimage_size;
-	state.initrd_addr = initrd_addr;
-	state.initrd_size = initrd_size;
+	bmi.bzimage_size = bzimage_size;
+	bmi.initrd_addr = initrd_addr;
+	bmi.initrd_size = initrd_size;
 	if (base_addr) {
-		state.base_ptr = map_sysmem(base_addr, 0);
-		state.load_address = bzimage_addr;
+		bmi.base_ptr = map_sysmem(base_addr, 0);
+		bmi.load_address = bzimage_addr;
 	} else {
-		state.bzimage_addr = bzimage_addr;
+		bmi.bzimage_addr = bzimage_addr;
 	}
-	state.cmdline = cmdline;
+	bmi.cmdline = cmdline;
 }
 
 void zboot_info(void)
 {
 	printf("Kernel loaded at %08lx, setup_base=%p\n",
-	       state.load_address, state.base_ptr);
+	       bmi.load_address, bmi.base_ptr);
 }
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 103b40a603c..bcb93f5fd3f 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -58,7 +58,7 @@ static int do_zboot_load(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
-	if (!state.base_ptr) {
+	if (!bmi.base_ptr) {
 		printf("base is not set: use 'zboot load' first\n");
 		return CMD_RET_FAILURE;
 	}
@@ -98,7 +98,7 @@ static int do_zboot_go(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_zboot_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
-	struct boot_params *base_ptr = state.base_ptr;
+	struct boot_params *base_ptr = bmi.base_ptr;
 
 	if (argc > 1)
 		base_ptr = (void *)hextoul(argv[1], NULL);
-- 
2.43.0

