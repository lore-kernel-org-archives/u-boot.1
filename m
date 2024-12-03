Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E94BE77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CC8D896D3;
	Wed,  4 Dec 2024 00:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PY/9UheX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C2B8967C; Wed,  4 Dec 2024 00:47:06 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A9689688
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-84198253240so225999139f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269616; x=1733874416; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Jmy5A8G1dN4sDl+c/Au1MUDiB7/oS6Wa+0WizabxbI=;
 b=PY/9UheXz8Co1k0cvmXaKpR3rxWSt4tGZOv0RkKRUv6Yt/I8TlncullqrxI0NL2VkP
 Sd9iF0+DvZo2TdC0uMrEzgZMN8c7XdY7dToAG4v969bLE4v+ZMyn7OGdVNmmNIzFoSWP
 dq4dSa3Mrf7mXwBdQeYDEuZwpgBhkQh9q52CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269616; x=1733874416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Jmy5A8G1dN4sDl+c/Au1MUDiB7/oS6Wa+0WizabxbI=;
 b=bsFUGXWR/bq0jjZJ1VgQQgOn9CP//vKPFHIgvQ6VuZuLn2oLsSZKJTb8pXCufd2u8v
 4nKLb9hKKtqE5vas+aDE9Pn6N/sVlz+OAFF66GzmMv2Iy1Gv/i9CBSKcwsHE/V+I9zxR
 OzSVOinnaeroFaxzbdtKU59lnhzAvfpXcGFDxtnNv3dpOnHls/FJ3gJje0FC9ZasPqdL
 M7uJtyXiCBrld+9m5Db2cvZSMx2SJEYC4+ejskOTOwO77/8BBcFHvwJOUW2w4n2n7/6T
 8XtyBT8PyWbHjLoj1yvfsTKBA/w9bUT5KnI/OE5/h5HT+3VwzxeOF1kOLQlv9Hd8t1Hn
 Y2sg==
X-Gm-Message-State: AOJu0Yz849pF6RHCscN1vGnOUpW9jVFwDuAHzzhKgukGd1E8bKr+SE1j
 Ge+4AgT/NvcAo4ISSBSoWVwmse+/RJUU61omX9isxFowpiWzI/0BQOOEQy7+/CwTWIq3RrjiqyY
 =
X-Gm-Gg: ASbGncs6aflObexJ5B0c0qVZ9t7N3NhDPmwJzE1fT/MfvPHnxOlQ71E8KpcMa96+gwd
 1lHEDR1uII7eKuIwM+TERa89nQCtCPakb6yc2JPFz6pmcJNaW7pELhdtJpRRPkRp/y6MktXj5Jz
 UhI3DNgiejp/K7oX7+q1rwJIh8N46aBWGBlKhJiI69ds07bmfaTO4kzHJbRgJ/DWm2lRon7qzpA
 g3hDft/OPI1s6xYmd9mUWi6+ofDm/Tawrclo/wdEnH06ZI8R4Q+XO5KF6dPa6G2cwHPnIx4mG2I
 tTuMgIweI1s=
X-Google-Smtp-Source: AGHT+IEWpfBcz3t8SkwObIMUiowB8q9BI43N0vx5x8FJjD6bXBP7ZVvfUoQnRW7h/jHS9Rlh3p0iFw==
X-Received: by 2002:a05:6602:160b:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-8445b5e5949mr698950439f.14.1733269616209; 
 Tue, 03 Dec 2024 15:46:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 16/41] boot: pxe: Refactor label_run_boot() to avoid cmdline
Date: Tue,  3 Dec 2024 16:45:34 -0700
Message-Id: <20241203234559.2938192-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

