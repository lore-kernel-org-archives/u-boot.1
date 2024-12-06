Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F159E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A7E089701;
	Fri,  6 Dec 2024 03:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Iyz+yef0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D2028973E; Fri,  6 Dec 2024 03:37:20 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 136F18918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a7a46ca756so5314265ab.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452636; x=1734057436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rRTXL9GcLV1F1SIaLR2PzzjW2LkE254wbWhdTlU5K0=;
 b=Iyz+yef0esxn/M6irev1IOFsAKUy01GC0nldSEuFlCwppAto6uYTcvu+NqYYtH26MG
 FrMBUj9XLP4IYBNKlXsIXvWbI0MmVwrEXzR5xmizERx5bV+IIt3KCjLreqEGbgKCBf71
 l8mqr5lcNqYcrg8ejLnWB/KSE6HL7ycEnSjMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452636; x=1734057436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rRTXL9GcLV1F1SIaLR2PzzjW2LkE254wbWhdTlU5K0=;
 b=Stx86DaSjVMY4zOW5nVXyZMyJvQmVT3wCmbWXHS7vTY2eqo7ArSaHNmzxc1+gTYxBh
 S8JsGKiMmSFkEDnHs9N0QPiX6zVhruNEdrEuDn/ykVDaOUA4QPOXCMG8ykoeEzKY1pta
 a2htfQSmLj5bPTDCBVAft+A+X3ukrYYUotPty1xbCi+nbC/syGUgA6Wz1bACrvN8ibE/
 Ot7KJh4M/OQ1toVMyyDQlaIEZpfQnbAYjzIFw/AVnI0N4XoysSY7oyCftzSdPAxjxcb3
 0lbsEHqyzrjT1o88r+EDCYpg4OWXsnhhxSC54amaqBOWByBUpMO6N6NT7kaJ/Rty0COW
 u+UQ==
X-Gm-Message-State: AOJu0YwYGsjssjToLxeVdGQBn9hCWjEX98+IX8ns5roq4i5fDfwjB+FF
 tt+HJHV3Z8KRQEpi34zRRFtB5nJuEqtgCP2ZWeqxdihhmQ8EWSEi9zuCoWVWkDiVEOeVkd1v2AY
 =
X-Gm-Gg: ASbGnct30skFSj5ndSkS2RmEvK77kk+FgpRFFEzCCeIXMIx4i1IowNGzvVWW6X0+TFO
 cY+fI39IOTrxXXsMnfI6HMiN/QPA/07pkL5BUzz1YbyfFhZ/kciXqzx896DESh2sdGvF5ZODn3q
 tT3JOR6N7vPLjGkSdyZvgX9lk5SNh/FdRstYJiBgmaJuAW2DDt5UpF8KwlPi9DT4YT7h9b0J8Wq
 k6wbvCJoS4dU4Q3ZeYuOOVUM9RZ/WWwKbrvr6nw+ID4WQdiiKZPZcYuwKscJj1yvVmfqxWizIyx
 HqjbNr2QStk=
X-Google-Smtp-Source: AGHT+IGOU+ptQaqQRiqJjhPjliflOtuQNeU8Qa7g8nI9mUt5Yj0A3x/YGDrGg68n2tEFQjKL1mZELg==
X-Received: by 2002:a05:6e02:12c2:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3a811d776fbmr22406295ab.1.1733452636286; 
 Thu, 05 Dec 2024 18:37:16 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 17/46] boot: Support compressed booti images in bootm
Date: Thu,  5 Dec 2024 19:35:56 -0700
Message-Id: <20241206023626.2456858-18-sjg@chromium.org>
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

A compressed booti image relies on the compression-format's header at
the start to indicate which compression algorithm is used.

We don't support this elsewhere in U-Boot, so assume that a compressed
file is always a booti file. Once it is compressed, a check is made to
make sure that it actually is.

Simplify the implementation by adding a new function which returns the
booti image-type if compression is detected.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to support compressed booti images in bootm

 boot/bootm.c       | 36 +++++++++++++++++++++++++++++-------
 boot/image-board.c | 13 ++++++++++++-
 include/image.h    | 11 +++++++++++
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 6fafa354732..7f0a74b9e24 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -146,7 +146,7 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 	/* check image type, for FIT images get FIT kernel node */
 	*os_data = *os_len = 0;
 	buf = map_sysmem(img_addr, 0);
-	switch (genimg_get_format(buf)) {
+	switch (genimg_get_format_comp(buf)) {
 #if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
 	case IMAGE_FORMAT_LEGACY:
 		printf("## Booting kernel from Legacy Image at %08lx ...\n",
@@ -228,11 +228,8 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 	}
 #endif
 	case IMAGE_FORMAT_BOOTI:
-		if (IS_ENABLED(CONFIG_CMD_BOOTI)) {
-			*os_data = img_addr;
-			break;
-		}
-		fallthrough;
+		*os_data = img_addr;
+		break;
 	default:
 		bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
 		return -EPROTOTYPE;
@@ -306,6 +303,16 @@ static int found_booti_os(enum image_comp_t comp)
 	log_debug("load %lx start %lx len %lx ep %lx os %x comp %x\n",
 		  images.os.load, images.os.image_start, images.os.image_len,
 		  images.ep, images.os.os, images.os.comp);
+	if (comp != IH_COMP_NONE) {
+		images.os.load = env_get_hex("kernel_comp_addr_r", 0);
+		images.os.image_len = env_get_ulong("kernel_comp_size", 16, 0);
+		if (!images.os.load || !images.os.image_len) {
+			puts("kernel_comp_addr_r or kernel_comp_size is not provided!\n");
+			return -ENOTSUPP;
+		}
+		if (lmb_reserve(images.os.load, images.os.image_len) < 0)
+			return -EXDEV;
+	}
 
 	return 0;
 }
@@ -423,6 +430,19 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
 		}
 		fallthrough;
 	default:
+		/* any compressed image is probably a booti image */
+		if (IS_ENABLED(CONFIG_CMD_BOOTI)) {
+			int comp;
+
+			comp = image_decomp_type(os_hdr, 2);
+			if (comp != IH_COMP_NONE) {
+				if (found_booti_os(comp))
+					return 1;
+				ep_found = true;
+			}
+			break;
+		}
+
 		puts("ERROR: unknown image format type!\n");
 		return 1;
 	}
@@ -1165,7 +1185,9 @@ int bootz_run(struct bootm_info *bmi)
 
 int booti_run(struct bootm_info *bmi)
 {
-	return boot_run(bmi, "booti", 0);
+	return boot_run(bmi, "booti", BOOTM_STATE_START | BOOTM_STATE_FINDOS |
+			BOOTM_STATE_PRE_LOAD | BOOTM_STATE_FINDOTHER |
+			BOOTM_STATE_LOADOS);
 }
 
 int bootm_boot_start(ulong addr, const char *cmdline)
diff --git a/boot/image-board.c b/boot/image-board.c
index e096dc49eef..d018d790a49 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -257,6 +257,17 @@ enum image_fmt_t genimg_get_format(const void *img_addr)
 	return IMAGE_FORMAT_INVALID;
 }
 
+enum image_fmt_t genimg_get_format_comp(const void *img_addr)
+{
+	enum image_fmt_t fmt = genimg_get_format(img_addr);
+
+	if (IS_ENABLED(CONFIG_CMD_BOOTI) && fmt == IMAGE_FORMAT_INVALID &&
+	    image_decomp_type(img_addr, 2) != IH_COMP_NONE)
+		fmt = IMAGE_FORMAT_BOOTI;
+
+	return fmt;
+}
+
 /**
  * fit_has_config - check if there is a valid FIT configuration
  * @images: pointer to the bootm command headers structure
@@ -353,7 +364,7 @@ static int select_ramdisk(struct bootm_headers *images, const char *select, u8 a
 	 * check image type, for FIT images get FIT node.
 	 */
 	buf = map_sysmem(rd_addr, 0);
-	switch (genimg_get_format(buf)) {
+	switch (genimg_get_format_comp(buf)) {
 	case IMAGE_FORMAT_LEGACY:
 		if (CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)) {
 			const struct legacy_img_hdr *rd_hdr;
diff --git a/include/image.h b/include/image.h
index 6dd7373c7ba..de44dc09d07 100644
--- a/include/image.h
+++ b/include/image.h
@@ -647,6 +647,17 @@ ulong genimg_get_kernel_addr(char * const img_addr);
  */
 enum image_fmt_t genimg_get_format(const void *img_addr);
 
+/**
+ * genimg_get_format_comp() - Like genimg_get_format() but adds compressed booti
+ *
+ * If a compressed file is detected (with image_decomp_type()) and
+ * CONFIG_CMD_BOOTI is enabled, then this returns IMAGE_FORMAT_BOOTI
+ *
+ * @img_addr: image start address
+ * Return: image format type or IMAGE_FORMAT_INVALID if no image is present
+ */
+enum image_fmt_t genimg_get_format_comp(const void *img_addr);
+
 int genimg_has_config(struct bootm_headers *images);
 
 /**
-- 
2.34.1

