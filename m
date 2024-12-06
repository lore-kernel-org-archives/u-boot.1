Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE6CE77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 512808973F;
	Fri,  6 Dec 2024 03:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FLRvTXEs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 846538973E; Fri,  6 Dec 2024 03:37:28 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5046C8918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-841acc8151aso101401839f.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452644; x=1734057444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Jmy5A8G1dN4sDl+c/Au1MUDiB7/oS6Wa+0WizabxbI=;
 b=FLRvTXEsCQ4ttDFKjZyHseea0i58EQOITv7ICO+8Pikj7BGVvIIH18Sz3O0UqswlHJ
 K5s3QIKvkNke9egwe24PI3P1JejkWAe6xkqB3+J0cawpLemgD0wLBpnJqhyl8G0a/FGy
 Bvn51Tvq5wdvUU121rkQGfSAOG9oIPoKu2Mx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452644; x=1734057444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Jmy5A8G1dN4sDl+c/Au1MUDiB7/oS6Wa+0WizabxbI=;
 b=ZW1HfN60o7ECgFuQxdz0SCAMSqmv6+fQeO3q1gr6matMm0ScxhoHxN25V9P6/R4KAL
 WgUcKw+VDMFRiValc/48Ec+v5/GBhFgdBC6nFkhddf8US/C/iVW2Y233GBfbQb0znljc
 oXtLCenWGr0gsJRg3DEThZgAqjuIxJDJpBzXj/LNGnQUqYeIKyEgXADBFUVKxVD0kjfH
 81xHJF/hCf3alIIqvlbjcvMKQHfm5tBU6z98EXGonrrHIDTKK/NpM9aDr6ebUBOO+5bO
 84Shkxr/N+j2ieyvgYk56W6vQmphl8b4l0MPnIO53X24rdjSoo+RnvixvEIJqdp8/SYG
 FT4w==
X-Gm-Message-State: AOJu0YyOxLGgctU0KfAWrlM1qgmq98VYYyD5DtHahBUeTfPtFZ5G7J82
 w0QSS45WElToSeCCx79KSJ6MO4AX78pupu8mvdqTrhmbVmWHFoqPk27M0nPLFgn1aH5n79A90KI
 =
X-Gm-Gg: ASbGnctrtwYRMRQ+T4wbcAvBqgoed4tK5Ub2YC6Fv2vELpFCkguFAg3Q+EbuYTPKJRT
 ph61la/fypXEK007ZZsmoiWZ9ctDkNt78uxd55gPqBY3Ho2mAkhY4/rs//gleIP2PoM3D25Lenp
 fMbW8efio2/AP05TUP8gWaPP9IoXowiXM7hzi8Cs/iyDkeRth8qo3NrAQiUPWGLPQAk7ByDvxC3
 VpLOJWd3i9V1MDRgSfh+CVOdbJMSmxWFUH3edg4w+BKZB+bfEcbG4SOIGO4pjxqmaZFtoUFrxos
 mXJXgSBqmAk=
X-Google-Smtp-Source: AGHT+IGbEpf6yy+hm9hdRcqPhrequ5Ts/38I5vEEth2hsX1m/qoyGL6ep5YNXzLY+CzeO/ij7ddFLw==
X-Received: by 2002:a05:6602:6b10:b0:83e:418c:8a28 with SMTP id
 ca18e2360f4ac-8447e23adaemr224165039f.7.1733452644418; 
 Thu, 05 Dec 2024 18:37:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 20/46] boot: pxe: Refactor label_run_boot() to avoid cmdline
Date: Thu,  5 Dec 2024 19:35:59 -0700
Message-Id: <20241206023626.2456858-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

(no changes since v1)

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
index 37306f37009..a91372407eb 100644
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
@@ -642,7 +639,7 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
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

