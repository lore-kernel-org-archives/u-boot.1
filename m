Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B26C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2A088549;
	Sat, 13 Jul 2024 09:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nlCedfIZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 122F0887CB; Sat, 13 Jul 2024 09:03:47 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F005888789
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2eeb2d60efbso32087921fa.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854224; x=1721459024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0MhsBTdd+aNSUI/Uq1hgEo/XJuq87IDbejk2c66vDU=;
 b=nlCedfIZqDmpakcunOOlxyuyPm4zaRKLK2nxx9TKQZaB+qf+mUSlfpF6sC29/PdcUa
 /LjqUIfZ4S5eLRq0uDlY3im7o1p8vyV8xMFqKfLGS70TzaL9bPCstTvj28b1hPyiJLvk
 7IRM5sBOjCQd/gbJaW72ALad/Qi5ePfti7+Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854224; x=1721459024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0MhsBTdd+aNSUI/Uq1hgEo/XJuq87IDbejk2c66vDU=;
 b=P9eoL6rQ4C3pb1L2Cfyw11J2QnCmm91fwHWZj96zpH6dJzEVTKl744ZEj9BN9fQtcM
 j+isSUO/DF5dZu/fMcnsRe0dgoJpxkLh7DYDTr4sVu4557ZOJaa0iBs72ReLfu36je1f
 Hj+BxjFSmktTxH+Y5E5THys2xYwlJt15BqQvS13fLxHnGopUwL1IInvj1oXpx8bKL4CV
 cVTNs4AMUYS0/J4NssWPKS+6Hd5basjUPdTxj6CzHTttTAofiVK1qE7owTDBQz+sde28
 D5BYwY0BxMrWG5Fo+HXmPPf0kwEdEZxSG5d2mak/ceQoM2uhMCRpGfVu9i8Omt3Xro1M
 v4Vw==
X-Gm-Message-State: AOJu0Yz3WfzvQsrwAFg0gvBkLXf+aKXQbR2TVlMR+V1fzvdnP6KEZ2Eo
 mrkXWijsKUTH2KZ3qaUZO5mnlk07B3NhFqbDBl4r9c+EeKHSxhTGPxeMgU1O6SMauvsbv8Jlb6o
 =
X-Google-Smtp-Source: AGHT+IHl8LMyPxUu/0SzbyI9weyw/xhFE7BX5sEEaPd3izJoRlrQIn7VDraH0RshXD8a3nztcMSXFQ==
X-Received: by 2002:a2e:9cda:0:b0:2ee:bc9a:9d7d with SMTP id
 38308e7fff4ca-2eebc9a9f96mr71966181fa.37.1720854224051; 
 Sat, 13 Jul 2024 00:03:44 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/21] test: Move some SPL-loading test-code into sandbox
 common
Date: Sat, 13 Jul 2024 08:00:37 +0100
Message-Id: <20240713070055.2172883-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

This code is useful for loading an image in sandbox_spl so move it into
a place where it can be called as needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/spl.c         | 67 ++++++++++++++++++++++++++++++++++
 arch/sandbox/include/asm/spl.h | 14 +++++++
 test/image/spl_load_os.c       | 53 +--------------------------
 3 files changed, 82 insertions(+), 52 deletions(-)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 9ad9da686c6..caa8e0b3b01 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <hang.h>
 #include <handoff.h>
+#include <image.h>
 #include <init.h>
 #include <log.h>
 #include <os.h>
@@ -179,3 +180,69 @@ int handoff_arch_save(struct spl_handoff *ho)
 
 	return 0;
 }
+
+/* Context used to hold file descriptor */
+struct load_ctx {
+	int fd;
+};
+
+static ulong read_fit_image(struct spl_load_info *load, ulong offset,
+			    ulong size, void *buf)
+{
+	struct load_ctx *load_ctx = load->priv;
+	off_t ret;
+	ssize_t res;
+
+	ret = os_lseek(load_ctx->fd, offset, OS_SEEK_SET);
+	if (ret < 0) {
+		printf("Failed to seek to %zx, got %zx (errno=%d)\n", offset,
+		       ret, errno);
+		return log_msg_ret("lse", ret);
+	}
+
+	res = os_read(load_ctx->fd, buf, size);
+	if (res < 0) {
+		printf("Failed to read %lx bytes, got %ld (errno=%d)\n",
+		       size, res, errno);
+		return log_msg_ret("osr", res);
+	}
+
+	return size;
+}
+
+int sandbox_spl_load_fit(char *fname, int maxlen, struct spl_image_info *image)
+{
+	struct legacy_img_hdr *header;
+	struct load_ctx load_ctx;
+	struct spl_load_info load;
+	int ret;
+	int fd;
+
+	memset(&load, '\0', sizeof(load));
+	spl_set_bl_len(&load, 512);
+	load.read = read_fit_image;
+
+	ret = sandbox_find_next_phase(fname, maxlen, true);
+	if (ret) {
+		printf("%s not found, error %d\n", fname, ret);
+		return log_msg_ret("nph", ret);
+	}
+
+	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
+
+	log_debug("reading from %s\n", fname);
+	fd = os_open(fname, OS_O_RDONLY);
+	if (fd < 0)
+		return log_msg_ret("ope", -ENOENT);
+	if (os_read(fd, header, 512) != 512)
+		return log_msg_ret("rea", -EIO);
+	load_ctx.fd = fd;
+
+	load.priv = &load_ctx;
+
+	ret = spl_load_simple_fit(image, &load, 0, header);
+	if (ret)
+		return log_msg_ret("slf", ret);
+
+	return 0;
+}
diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
index 4fab24cd156..d50d9ad6b48 100644
--- a/arch/sandbox/include/asm/spl.h
+++ b/arch/sandbox/include/asm/spl.h
@@ -6,6 +6,8 @@
 #ifndef __asm_spl_h
 #define __asm_spl_h
 
+struct spl_image_info;
+
 enum {
 	BOOT_DEVICE_MMC1,
 	BOOT_DEVICE_MMC2,
@@ -31,4 +33,16 @@ enum {
  */
 int sandbox_find_next_phase(char *fname, int maxlen, bool use_img);
 
+/**
+ * sandbox_spl_load_fit() - Load the next phase from a FIT
+ *
+ * Loads a FIT containing the next phase and sets it up for booting
+ *
+ * @fname: Returns filename loaded
+ * @maxlen: Maximum length for @fname including \0
+ * @image: Place to put SPL-image information
+ * Return: 0 if OK, -ve on error
+ */
+int sandbox_spl_load_fit(char *fname, int maxlen, struct spl_image_info *image);
+
 #endif
diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
index 7d5fb9b07e0..56105a59236 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -10,63 +10,12 @@
 #include <test/spl.h>
 #include <test/ut.h>
 
-/* Context used for this test */
-struct text_ctx {
-	int fd;
-};
-
-static ulong read_fit_image(struct spl_load_info *load, ulong offset,
-			    ulong size, void *buf)
-{
-	struct text_ctx *text_ctx = load->priv;
-	off_t ret;
-	ssize_t res;
-
-	ret = os_lseek(text_ctx->fd, offset, OS_SEEK_SET);
-	if (ret != offset) {
-		printf("Failed to seek to %zx, got %zx (errno=%d)\n", offset,
-		       ret, errno);
-		return 0;
-	}
-
-	res = os_read(text_ctx->fd, buf, size);
-	if (res == -1) {
-		printf("Failed to read %lx bytes, got %ld (errno=%d)\n",
-		       size, res, errno);
-		return 0;
-	}
-
-	return size;
-}
-
 static int spl_test_load(struct unit_test_state *uts)
 {
 	struct spl_image_info image;
-	struct legacy_img_hdr *header;
-	struct text_ctx text_ctx;
-	struct spl_load_info load;
 	char fname[256];
-	int ret;
-	int fd;
-
-	memset(&load, '\0', sizeof(load));
-	spl_set_bl_len(&load, 512);
-	load.read = read_fit_image;
-
-	ret = sandbox_find_next_phase(fname, sizeof(fname), true);
-	if (ret)
-		ut_assertf(0, "%s not found, error %d\n", fname, ret);
-
-	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
-
-	fd = os_open(fname, OS_O_RDONLY);
-	ut_assert(fd >= 0);
-	ut_asserteq(512, os_read(fd, header, 512));
-	text_ctx.fd = fd;
-
-	load.priv = &text_ctx;
 
-	ut_assertok(spl_load_simple_fit(&image, &load, 0, header));
+	ut_assertok(sandbox_spl_load_fit(fname, sizeof(fname), &image));
 
 	return 0;
 }
-- 
2.34.1

