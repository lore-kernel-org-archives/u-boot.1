Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B929C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538E0881E7;
	Thu,  8 Aug 2024 00:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PU/QAQ09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 357EC88A2A; Thu,  8 Aug 2024 00:48:11 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93338888CF
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39b04f0b486so1517405ab.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070887; x=1723675687; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5o0SLxja5/t3iIKqd0HcEF/u0rSX0ti7xTVj0cPafTk=;
 b=PU/QAQ0989qlJOZS12ux5imyTw5sGQYBCH986Jtf/JHbJ3iZIFrR0/25eBrUSNfoK5
 tpDkEkhg7TdzDLJGk63/vLDs7L5uFTWWwTwAPpYXOHxlGgMwigFvaTP79mke1kOkJcVE
 cXfOJ8jVntdHgeBZHFIEhpgcGXz4f0osZm0bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070887; x=1723675687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5o0SLxja5/t3iIKqd0HcEF/u0rSX0ti7xTVj0cPafTk=;
 b=G9iKlfY6vTnF2LFyzCeUmy7zwE4vMzawLytaUf9K6zfD/WQDYfosl/WhX4+XlrE6RX
 LpY+3hQxkRGJBzUlT+/AM4M2yuNFQuSXrU3AqO5TC1AANH9FLckl4QTX9AO0px/MlNB2
 wJVrpX9eD741iWl2vpJaikwj1lQpLpbi4UnOn6vQlvyILah6tPCiZvOOgjX2VmLz1OA0
 F9RJbcNvX1U3KABQzjs2Y1BgyDmXpSBhpy/f33FCWhbDPS3tPKmd+joPofSpoT7i/Pqi
 JxwLJaZttrDuHnrWOEeBzpQFYK8SsckpBGMORcumpuE6r1+Dl3eoAhOc6hmPfQhlFtcq
 cy2w==
X-Gm-Message-State: AOJu0YwG7jF03kL3/YIVU18KH/tEfHTY011EkBb1j7DfKgdkavRUqSGr
 lsmVah5uuabtjPOBrkCxOaH4Ij3OtlNPeYBq6nxcSdWOpzAaFAhaWHgPB2q5g3/0WEbqzIVm+dc
 =
X-Google-Smtp-Source: AGHT+IEEYgbUCrvCS7dzyGq4oXIiZgTpf87gLA+JgeEc214xrWu4avU0R8dzFUlOOLRN41M3yGXgig==
X-Received: by 2002:a05:6e02:13af:b0:375:a3d8:97be with SMTP id
 e9e14a558f8ab-39b5ec851d3mr989235ab.9.1723070887239; 
 Wed, 07 Aug 2024 15:48:07 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 03/21] test: Move some SPL-loading test-code into sandbox
 common
Date: Wed,  7 Aug 2024 16:47:21 -0600
Message-Id: <20240807224739.3858517-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

(no changes since v3)

Changes in v3:
- Use -errno instead of inventing a new error
- Use a block size of 1 if !CONFIG_SPL_LOAD_BLOCK
- Use longer error messages
- Use sizeof(*header) instead of 512

 arch/sandbox/cpu/spl.c         | 73 ++++++++++++++++++++++++++++++++++
 arch/sandbox/include/asm/spl.h | 14 +++++++
 test/image/spl_load_os.c       | 53 +-----------------------
 3 files changed, 88 insertions(+), 52 deletions(-)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 9ad9da686c6..49abe02f322 100644
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
@@ -179,3 +180,75 @@ int handoff_arch_save(struct spl_handoff *ho)
 
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
+		return log_msg_ret("lse", -errno);
+	}
+
+	res = os_read(load_ctx->fd, buf, size);
+	if (res < 0) {
+		printf("Failed to read %lx bytes, got %ld (errno=%d)\n",
+		       size, res, errno);
+		return log_msg_ret("osr", -errno);
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
+	spl_set_bl_len(&load, IS_ENABLED(CONFIG_SPL_LOAD_BLOCK) ? 512 : 1);
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
+	if (fd < 0) {
+		printf("Failed to open '%s'\n", fname);
+		return log_msg_ret("ope", -errno);
+	}
+	ret = os_read(fd, header, sizeof(*header));
+	if (ret != sizeof(*header)) {
+		printf("Failed to read %lx bytes, got %ld (errno=%d)\n",
+		       sizeof(*header), ret, -errno);
+		return log_msg_ret("rea", -errno);
+	}
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

