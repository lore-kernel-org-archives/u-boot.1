Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2ABD44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD97889555;
	Tue, 19 Nov 2024 14:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H4KMo7Cx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5590B895BA; Tue, 19 Nov 2024 14:19:31 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215A08954F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a77fe30b0dso1087425ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022367; x=1732627167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcCErSn5ouQjP5zs76s5VtT8pPCR60dcScAs3ombcfM=;
 b=H4KMo7CxDUY+uC0wTlpWuhjtAF09ph/hMTBy0OdpHzz9Z2A8DoIPB/cnrWRUT3TRjA
 rq78HmpFu0DMgi/Ui/v5A11CMEalHl0yP/M5FyHca+M/GH/IshPqAviOK1RDSVa0Xgsi
 pKBuWBNFukavShoC/p31l5M7dD+MW9L7I7ZDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022367; x=1732627167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcCErSn5ouQjP5zs76s5VtT8pPCR60dcScAs3ombcfM=;
 b=PINc4yIUH7R9KK0jpBAzNG3xX4b9fOeDICDbtXlO9InGTKfkNxPqsghUtDemm9GQHL
 +qayiwWzKqGlxpTmFTK8Rn4S7FQF9bU+DmDxn57EQfdgpCkL9JwZBguBZ1PLGIghwx1o
 RbMWTUU1t+egu8m+IYve4Zn/EjAelmIq8CBQR/zEzpQKVoDQPqS+tbAylM1nC3iPLuY0
 Yj5Z0tJ6DK7qo0DYBiT1LOrkn8l1R6WHWfklvDy1dJUwqCQIH/Ee38DkT/bx7ymiSkac
 vT0Kd7xMI178PbZOK8KgubGQ/LEJPNfRusH+qRckv9/onSkkIrFjUxkkFekku3/CDI6e
 QJNw==
X-Gm-Message-State: AOJu0Ywbu3Un6f3STYL6yYv1dZOyMFK239pKeiSvGeGGBA7zBwNaKP1T
 pRivM3wpW4CGk30t6K4V+PD628wapiReJKp/XJtcWKag/tZBq9aOpNRPYpZNOerKeJk9I+EdsXU
 =
X-Google-Smtp-Source: AGHT+IGef9XgnGd+GT2HgT9ID7mwyR/3yFrxPJ06NS2utZjaTZfK31VWNcQPwEtY8QjRu1kLIZGPUg==
X-Received: by 2002:a05:6e02:1848:b0:3a7:7ad4:ff00 with SMTP id
 e9e14a558f8ab-3a77ad500ffmr20302815ab.19.1732022367350; 
 Tue, 19 Nov 2024 05:19:27 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 14/39] boot: pxe: Refactor label_run_boot() to avoid cmdline
Date: Tue, 19 Nov 2024 06:18:19 -0700
Message-Id: <20241119131844.4078144-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

Adjust the remaining call in this function to use the bootm API. This
will allow PXE to work without the command line.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/zimage.c | 27 +++++++++++++++++++--------
 boot/pxe_utils.c      | 13 +++++--------
 include/bootm.h       |  9 +++++++++
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 4dfcde68060..26d623711bc 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -433,27 +433,38 @@ int zboot_go(struct bootm_info *bmi)
 	return ret;
 }
 
-int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-		   ulong base, char *cmdline)
+int zboot_run(struct bootm_info *bmi)
 {
-	struct bootm_info bmi;
 	int ret;
 
-	bootm_init(&bmi);
-	zboot_start(&bmi, addr, size, initrd, initrd_size, base, cmdline);
-	ret = zboot_load(&bmi);
+	ret = zboot_load(bmi);
 	if (ret)
 		return log_msg_ret("ld", ret);
-	ret = zboot_setup(&bmi);
+	ret = zboot_setup(bmi);
 	if (ret)
 		return log_msg_ret("set", ret);
-	ret = zboot_go(&bmi);
+	ret = zboot_go(bmi);
 	if (ret)
 		return log_msg_ret("go", ret);
 
 	return -EFAULT;
 }
 
+int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
+		   ulong base, char *cmdline)
+{
+	struct bootm_info bmi;
+	int ret;
+
+	bootm_init(&bmi);
+	zboot_start(&bmi, addr, size, initrd, initrd_size, base, cmdline);
+	ret = zboot_run(&bmi);
+	if (ret)
+		return log_msg_ret("zra", ret);
+
+	return 0;
+}
+
 static void print_num(const char *name, ulong value)
 {
 	printf("%-20s: %lx\n", name, value);
diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 2517999d408..73d3114813d 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -585,10 +585,8 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 			  char *kernel_addr, char *initrd_addr_str,
 			  char *initrd_filesize, char *initrd_str)
 {
-	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
 	struct bootm_info bmi;
 	ulong kernel_addr_r;
-	int zboot_argc = 3;
 	void *buf;
 	int ret;
 
@@ -601,14 +599,13 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 		return ret;
 
 	bmi.addr_img = kernel_addr;
-	zboot_argv[1] = kernel_addr;
+	bootm_x86_set(&bmi, bzimage_addr, hextoul(kernel_addr, NULL));
 
 	if (initrd_addr_str) {
 		bmi.conf_ramdisk = initrd_str;
-
-		zboot_argv[3] = initrd_addr_str;
-		zboot_argv[4] = initrd_filesize;
-		zboot_argc = 5;
+		bootm_x86_set(&bmi, initrd_addr, hextoul(kernel_addr, NULL));
+		bootm_x86_set(&bmi, initrd_size,
+			      hextoul(initrd_filesize, NULL));
 	}
 
 	if (!bmi.conf_fdt) {
@@ -648,7 +645,7 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	/* Try booting an x86_64 Linux kernel image */
 	} else if (IS_ENABLED(CONFIG_CMD_ZBOOT)) {
 		log_debug("using zboot\n");
-		do_zboot_parent(ctx->cmdtp, 0, zboot_argc, zboot_argv, NULL);
+		ret = zboot_run(&bmi);
 	}
 
 	unmap_sysmem(buf);
diff --git a/include/bootm.h b/include/bootm.h
index d174f18ac18..465577a66f5 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -315,6 +315,15 @@ int bootm_process_cmdline(char *buf, int maxlen, int flags);
  */
 int bootm_process_cmdline_env(int flags);
 
+/**
+ * zboot_run() - Run through the various steps to boot a zimage
+ *
+ * @bmi: Bootm information, with bzimage_size, initrd_addr, initrd_size and
+ * cmdline set up. If base_ptr is 0, then bzimage_addr must be set to the start
+ * of the bzImage. Otherwise base_ptr and load_address must be provided.
+ */
+int zboot_run(struct bootm_info *bmi);
+
 /**
  * zboot_run_args() - Run through the various steps to boot a zimage
  *
-- 
2.34.1

