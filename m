Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D41C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D10EF80D4F;
	Tue, 25 Aug 2026 16:03:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FEcdNktS88Vi; Tue, 25 Aug 2026 16:03:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673829;
	bh=ltfii8QNTdEkzLEYT1Tw0/y1NjZcJbQcEmm4QMw+tpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TV8VYLur+HqAKLv3e/niNtUQFiNEAn9sc+iLKqpLArVhSBxZnzU3Wl1Wu0AqazcVV
	 pKH/DzPu+z0YSI3jD3EQ8gyFw8N0L1Mv+9O4vFNPsZMkupvYmhoPvc/ZnAVHh+AlQX
	 LVibl6xZ0l6YUeOMIPV4wrm244ZtqBnBz1dyJ+3lTkwSCRslCh+YGiN3QEo2n7bFJ6
	 jdVKVB8idqacPGS2hyzVWKXiMSNNYejsKgiEaPfAS4WMI7W4cI6TpaiPnnaeLa3Am8
	 5k6/ggCl5e5VaWawPeZ+UHmpuarcwQVK+fwhSvY7V2yIJcTAvpEnzU9/bhjd1TUK2Z
	 IGnscXG00Dt2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D865380D99;
	Tue, 25 Aug 2026 16:03:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 27AC535E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DDC680C68
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XJ5Cz-uGs8dH for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 14:20:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PW9DSuoe
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03DD080C79
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:14 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4998e0916faso28495615e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667612; x=1788272412;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ltfii8QNTdEkzLEYT1Tw0/y1NjZcJbQcEmm4QMw+tpw=;
 b=PW9DSuoe6aUHbBH0UwBhmghhJyuQ5ynlwvmF1XWr32b5YXpfNRohA7TTRJ222NOkud
 KdTRH98wEZ94cHHs/lOkRk17AocGQA7RbK5HCuC0l3zW8RZqwvRuo607t2P57n8uGyDM
 e98OYbd3Zfh+pmNjlKpVEpnPhUwZoOm73E0IRNVB/G0hAQl+GvOyPUv6pHE4ejlQUhQR
 LHNWmhTgq+sITjYgDQQbzy/1o8NzfzHMii1Lpv63unkIqMAwKHwiTIelbEHL81cAYnrH
 RQSiUarl1SudArZVfD6dL4irQAGfr2ci03hSDPgqctviRiNGJ90wIQrOcyQYIpnY6VdJ
 A6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667612; x=1788272412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ltfii8QNTdEkzLEYT1Tw0/y1NjZcJbQcEmm4QMw+tpw=;
 b=I1c2EKXK03EhivYLe7l1UqDkbM+qYUGVYzaO1JthtjZB6gmtBKeCuKSqJ13tLyjYPl
 sTtzEiFYnTKRCKoqtphAPkH3OCwwPzpcXoFYa5m97pnPPHk5bbBFnTWAdZk8NWXPlaQy
 mGy5ecCOIaRv3PrGLm7eQy48p3D20Sjjapz6pMKL7Vp9nvOm8UiDNgO+yvZhkIc0sJoT
 2TLn4cVOHX/iMp6Q7a3Ug6a2ATXftAyR/cpBipxc3HhRYBhl64qiwcGJtUm9ioet5tmv
 16QcIQe8os0/ovK6IlsgdLY7V5pLIQO0tp4qV7xewt/O7ynL/l1gxHygVOzxp3h1fBNU
 eANw==
X-Gm-Message-State: AFuF++mER13MMHnlo9UZIknS4Na3d1LK9rdfmiwYVKup7Qj9mljgIpj+
 DtwjVg6pdnrhmvAxKTC1KW7FelZXEx0Vh9I3wLNoHH3yrucTp4rQuwsPsnrLhkJBLsc=
X-Gm-Gg: AR+sD10U/QUQoaOZ/6cHkvjESZSiF+wHIKVCmAvNPZZASPKeb5iQF58EmYEugOVkhiX
 QZwhoGg47dPQhJcq7QeysBvb6Gui5woCYSHboC2sryjBkTkqN5CmMWMrgiEPMPf0qUA7hzgarEM
 o+OOuJy+4y4jxqTnaoWYhnOZqfjRRdRNAwhn8HBTudNWMg+2yaIElC3qYTryw27pPMGGoVzXQqP
 e5gULyMsE7ShgymE3+7OUobGgSNQqW2jzljbz4U0t3meCNcpdhrZbZvVz1xFRa5rXGQ9oKQSIwJ
 /mTZynEQbsQDxBBR4Envy4p3ZlxyUZtA1oc44x/XuLrSnnsa+qUek0fGxDyjfF4ETW0V2R486tz
 SxOEqMqqlNV5NYc1b4K4MGrUsk1ousvAvDKMtr6QoGPZAW473ve/1kJbpDUQmrHChCvTH42o0ui
 LDj880+0gzd/IdgSeP1ERPQ0GtD+Q2+h6rfck2jULQPeW7iqijcCxYFEyNenQ4iqrY8e5hCcG92
 zOJmpIArE7zJeBIPB/1s2q7dFs6hsk3+y0/L0f9bTFw10cCpE1YNqhYxlmEDfpyfifQul1SesQ6
 2M9G1x7k0LvALdLTX99gD/87
X-Received: by 2002:a05:600d:844a:20b0:499:ad2e:f7bc with SMTP id
 5b1f17b1804b1-499c19d7372mr251920505e9.10.1787667612211; 
 Tue, 25 Aug 2026 07:20:12 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b69d7dsm11745871f8f.4.2026.08.25.07.20.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Aug 2026 07:20:11 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, philippe.reynes@softathome.com,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v2 5/5] test: boot: add regression tests for the FIT cipher
 bounds checks
Date: Tue, 25 Aug 2026 15:19:53 +0100
Message-ID: <20260825141953.9534-6-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260825141953.9534-1-pranavkasthuri@gmail.com>
References: <20260815220754.11724-1-pranavkasthuri@gmail.com>
 <20260825141953.9534-1-pranavkasthuri@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 16:03:37 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add a fit_cipher unit test suite, gated on CONFIG_FIT_CIPHER like the
code it exercises, covering the three defects fixed in this series:

 - image_aes_decrypt() rejects a cipher_len that is not a whole number
   of AES blocks
 - image_aes_decrypt() rejects an unciphered size larger than the
   ciphertext, and accepts the boundary case where they are equal
 - fit_image_get_data_size_unciphered() rejects a 'data-size-unciphered'
   property that is not exactly one fdt32_t long, built via a minimal
   FIT constructed with libfdt, and accepts a correctly sized one

Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
---
v2:
- New in v2, per Simon's request for regression tests on this series.

 test/boot/Makefile     |   1 +
 test/boot/fit_cipher.c | 113 +++++++++++++++++++++++++++++++++++++++++
 test/cmd_ut.c          |   2 +
 3 files changed, 116 insertions(+)
 create mode 100644 test/boot/fit_cipher.c

diff --git a/test/boot/Makefile b/test/boot/Makefile
index 59a87028704..cef2a236d9b 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -18,6 +18,7 @@ ifdef CONFIG_UT_DM
 obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += image_fdt.o
 endif
 endif
+obj-$(CONFIG_$(PHASE_)FIT_CIPHER) += fit_cipher.o
 obj-$(CONFIG_$(PHASE_)FIT_VERITY) += fit_verity.o
 obj-$(CONFIG_MEASURED_BOOT) += measurement.o
 
diff --git a/test/boot/fit_cipher.c b/test/boot/fit_cipher.c
new file mode 100644
index 00000000000..b98c69fcb0b
--- /dev/null
+++ b/test/boot/fit_cipher.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Regression tests for the FIT cipher bounds checks in
+ * image_aes_decrypt() and fit_image_get_data_size_unciphered().
+ *
+ * Copyright 2026 Pranav Rajendran <pranavkasthuri@gmail.com>
+ */
+
+#include <errno.h>
+#include <image.h>
+#include <uboot_aes.h>
+#include <u-boot/aes.h>
+#include <linux/libfdt.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#define FIT_CIPHER_TEST(_name, _flags)	UNIT_TEST(_name, _flags, fit_cipher)
+
+/* A cipher_len that is not a whole number of AES blocks must be rejected */
+static int fit_cipher_test_unaligned_len(struct unit_test_state *uts)
+{
+	struct image_cipher_info info;
+	unsigned char key[AES128_KEY_LENGTH] = { 0 };
+	unsigned char iv[AES_BLOCK_LENGTH] = { 0 };
+	unsigned char cipher[AES_BLOCK_LENGTH + 1] = { 0 };
+	void *data = NULL;
+	size_t size = 0;
+	int ret;
+
+	memset(&info, 0, sizeof(info));
+	info.cipher = image_get_cipher_algo("aes128");
+	ut_assertnonnull(info.cipher);
+	info.key = key;
+	info.iv = iv;
+
+	ret = image_aes_decrypt(&info, cipher, sizeof(cipher), &data, &size);
+	ut_asserteq(-EINVAL, ret);
+	ut_assertnull(data);
+
+	return 0;
+}
+FIT_CIPHER_TEST(fit_cipher_test_unaligned_len, 0);
+
+/*
+ * An unciphered size larger than the ciphertext must be rejected; a size
+ * exactly equal to the ciphertext length is the valid boundary case.
+ */
+static int fit_cipher_test_oversized_unciphered_size(struct unit_test_state *uts)
+{
+	struct image_cipher_info info;
+	unsigned char key[AES128_KEY_LENGTH] = { 0 };
+	unsigned char iv[AES_BLOCK_LENGTH] = { 0 };
+	unsigned char cipher[AES_BLOCK_LENGTH * 2] = { 0 };
+	void *data = NULL;
+	size_t size = 0;
+	int ret;
+
+	memset(&info, 0, sizeof(info));
+	info.cipher = image_get_cipher_algo("aes128");
+	ut_assertnonnull(info.cipher);
+	info.key = key;
+	info.iv = iv;
+
+	info.size_unciphered = sizeof(cipher) + 1;
+	ret = image_aes_decrypt(&info, cipher, sizeof(cipher), &data, &size);
+	ut_asserteq(-EINVAL, ret);
+	ut_assertnull(data);
+
+	/* the boundary itself, size_unciphered == cipher_len, is valid */
+	info.size_unciphered = sizeof(cipher);
+	ut_assertok(image_aes_decrypt(&info, cipher, sizeof(cipher), &data,
+				      &size));
+	ut_assertnonnull(data);
+	ut_asserteq(sizeof(cipher), size);
+	free(data);
+
+	return 0;
+}
+FIT_CIPHER_TEST(fit_cipher_test_oversized_unciphered_size, 0);
+
+/*
+ * A 'data-size-unciphered' property that is not exactly one fdt32_t long
+ * must be rejected rather than read out of bounds.
+ */
+static int fit_cipher_test_data_size_unciphered_len(struct unit_test_state *uts)
+{
+	char fit[512];
+	int images, img, ret;
+	u16 truncated = 0x1234;
+	fdt32_t valid = cpu_to_fdt32(0x100);
+	size_t data_size = 0;
+
+	ut_assertok(fdt_create_empty_tree(fit, sizeof(fit)));
+	images = fdt_add_subnode(fit, 0, "images");
+	ut_assert(images >= 0);
+
+	img = fdt_add_subnode(fit, images, "kernel");
+	ut_assert(img >= 0);
+	ut_assertok(fdt_setprop(fit, img, "data-size-unciphered",
+				&truncated, sizeof(truncated)));
+
+	ret = fit_image_get_data_size_unciphered(fit, img, &data_size);
+	ut_asserteq(-EINVAL, ret);
+
+	/* a correctly sized property still works */
+	ut_assertok(fdt_setprop(fit, img, "data-size-unciphered",
+				&valid, sizeof(valid)));
+	ut_assertok(fit_image_get_data_size_unciphered(fit, img, &data_size));
+	ut_asserteq(0x100, data_size);
+
+	return 0;
+}
+FIT_CIPHER_TEST(fit_cipher_test_data_size_unciphered_len, 0);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 4328670d0d6..95e86f7dcf6 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -59,6 +59,7 @@ SUITE_DECL(env);
 SUITE_DECL(exit);
 SUITE_DECL(fdt);
 SUITE_DECL(fdt_overlay);
+SUITE_DECL(fit_cipher);
 SUITE_DECL(fit_verity);
 SUITE_DECL(font);
 SUITE_DECL(hush);
@@ -88,6 +89,7 @@ static struct suite suites[] = {
 	SUITE(exit, "shell exit and variables"),
 	SUITE(fdt, "fdt command"),
 	SUITE(fdt_overlay, "device tree overlays"),
+	SUITE(fit_cipher, "FIT cipher bounds checks"),
 	SUITE(fit_verity, "FIT dm-verity cmdline generation"),
 	SUITE(font, "font command"),
 	SUITE(hush, "hush behaviour"),
-- 
2.50.1 (Apple Git-155)

