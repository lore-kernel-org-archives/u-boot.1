Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12AAC61DBC
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56E2160733;
	Tue, 25 Aug 2026 16:03:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TjM_He3t3W93; Tue, 25 Aug 2026 16:03:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673822;
	bh=+L1x+nWBzI01sEG6F9wc7H7Wat2TGhi98WE1KekL8+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lKVh3FNh7PpS9oFriIYOle153iSoW2CS1WQRJvyaAv9C1rAWhg7AWap8vIX31zidX
	 rb4/G1i/yqov3FyYXdskX23oE0EQ6MOM2whKV7iqKf93+zh0BGolUBZSIsVK8sMg3k
	 UKxttTIElVPipCPfe27EyZOmpQkIA1CI0NXFPH0+7OT9IKTOBmP1JuilaICMGQOQeo
	 iQMb3UCxnCosXiBukcrWOKKjh5UsiZG8jXm3W4zpfjgiDs/CYsEDJv/hLyQg/WFcrl
	 rsaS1vP+aJezFno2lhfdvce5utmGRuV90J2N1nRptVAoVQwlwCwys/RJGM0pDUQ1WD
	 q9CtYydGwQ7Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 856CD606F6;
	Tue, 25 Aug 2026 16:03:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D0BA81465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B728E400F9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NewUVpebYpMu for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 14:20:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HRwBUQ7L
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD7D640092
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:02 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-482dbc9a00bso389656f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667600; x=1788272400;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+L1x+nWBzI01sEG6F9wc7H7Wat2TGhi98WE1KekL8+o=;
 b=HRwBUQ7LlqQonPaabQfwGVxs7dPPTKznAgQfzg9p7bVQiZF4ezpY9ouxJi8nNlWTLz
 XxQ/cgjawkdnSgnD5VclQwNNwwBpCZk8zMUxgK/b/KTUb06kMf0TAJ0qOgIQ3fu0hDLP
 0H6H7EGWvjnY7rVxo3RXinagczhd+weu0go0XmmcRnLdbeWl/IREAhT/nDlSEWWKz/Od
 ulvXelNon8OQMhKFM3fSyi28Vg9MCZbeALDwbpiR0lhHEqrVB4j/nxwcCvzc9ZVZnKuN
 IELwdk/vZZeHC0XCL5katL6Q3ldZPOmLfrGhpWb7AkpLnxh0WZIN0Z4W2iw5Gvx75OYM
 RtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667600; x=1788272400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+L1x+nWBzI01sEG6F9wc7H7Wat2TGhi98WE1KekL8+o=;
 b=AqALTUbS2yxe1GQgU/uJS8KpONQpAKM1rz+BuvIEDZdyipYIoj2XJ/hfBCVebsb0oz
 +QQOU8qoAhoRe7EBMuwbB3QZY5izLgMiEr6ZOSHOpj1AALQiIZTpCm8oB7mDHQv1Ioc6
 WpvkUSNywB1AhR3ITqX0pTVtuDSQ8tq30dDfVOSSOIHFe+pIXQbb7jNiDkfGVCaRtgpr
 WN59cao1KBgZKVQsi44gYhsPr3vLmRLrNVxm9bL0hoFEpwa8Af8+J2x4XPE8GtxqdCHN
 sJy0l0C51po7Vb/W0pDrZ5dx/6Pd4NQU5NV+kXGlulVt3vhWsyA3ijnSflkOFO36r/Dn
 3YFQ==
X-Gm-Message-State: AFuF++kU4gc9j6k0xG+Tp6zpB1mzXTBI8ddif4IMG1og4zV70eF6J0B9
 nae1b1eBEInUNerdslJh3JD5kmfEuAaioUU+wMcSWqN+IJxWQmbHxdV4+FIL1khuLDo=
X-Gm-Gg: AR+sD13Gwqhyo9b9t8fTNmvu73IZEV/Aj5yaHEYdU1JCcr+JawvFCJ8daAGlIXOHTVk
 SerW1bdhnShSr23nLE3qVPWAU/LKO30hRAzl71RY8c+GsL83DISfFlJUtX/mq/1uHGYQLjCXNaF
 9J9R038nwbMXpDqHsuZhGyh1SVpSz0JsGWGJeC3fUMMU5sxsLyeSHWoWtf/VdZYK0nr/p5Jetzi
 0GCSEvCebot7uG5TyT3fmNwwFtfBYeCTSZUTQ2oY3ZPUzYZSsJ5Sv7iON9aR5IB06r7wrCHoGWR
 s3nhlfi1qiCCtwVfdGG3hKSKx1FaMlCHNqDM1L7G7b3N/nMf+7+Qpn6EDwi0+yl7ytj4zO0w+NF
 6A+Jcj82h1wxlO2TOa12foMa3so7fnvaRxps+quwVZk8J+Ydg5jAlNz41rllcREIBtdqQKwJ+vx
 yFj4tQ8hkS/RMYTNrt/2HFTZMIXEGIXXB6iKh7GPfMUkBrpugbBeupo6iLQFPFrT3Wel8m+A0lN
 /w4ca1hr729x64OwoTf1W3h5w3ZjlODXgltVriZ62G5vv/NbJA1xk1mkaz0tC2UVjdJtk1gBQXg
 2cN932pSlOc9yiMkWm8bqX6B
X-Received: by 2002:a05:6000:4183:b0:46b:70db:2113 with SMTP id
 ffacd0b85a97d-482d98c94d0mr9068599f8f.0.1787667600195; 
 Tue, 25 Aug 2026 07:20:00 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b69d7dsm11745871f8f.4.2026.08.25.07.19.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Aug 2026 07:19:59 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, philippe.reynes@softathome.com,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v2 1/5] lib: aes: reject a ciphertext length that is not a
 whole number of blocks
Date: Tue, 25 Aug 2026 15:19:49 +0100
Message-ID: <20260825141953.9534-2-pranavkasthuri@gmail.com>
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

image_aes_decrypt() allocates cipher_len bytes for the plaintext but
then asks aes_cbc_decrypt_blocks() to write
DIV_ROUND_UP(cipher_len, AES_BLOCK_LENGTH) blocks into it. For a
cipher_len that is not a multiple of AES_BLOCK_LENGTH the rounding up
adds one block, so the last block is written up to AES_BLOCK_LENGTH - 1
bytes past the end of the allocation, and read the same distance past
the end of the ciphertext.

cipher_len is the size of the image data in the FIT, so an image with a
'data' property whose length is not block aligned is enough to reach
this. The overflowing bytes are decryption output, i.e. they depend on
the key, but the length itself is not covered by anything that would
stop the image from being parsed this far.

A CBC ciphertext is a whole number of blocks by construction, so treat
anything else as a malformed image and reject it before allocating.
With that established, compute the block count with a plain division so
the buffer size and the write length cannot drift apart again.

Fixes: 4df3578119b0 ("u-boot: fit: add support to decrypt fit with aes")
Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v1)

 lib/aes/aes-decrypt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
index 741102a4723..85773a9c4f6 100644
--- a/lib/aes/aes-decrypt.c
+++ b/lib/aes/aes-decrypt.c
@@ -17,6 +17,16 @@ int image_aes_decrypt(struct image_cipher_info *info,
 	unsigned char key_exp[AES256_EXPAND_KEY_LENGTH];
 	unsigned int aes_blocks, key_len = info->cipher->key_len;
 
+	/*
+	 * The ciphertext is a whole number of AES blocks by construction, and
+	 * the decryption below writes one full block at a time, so anything
+	 * else would overflow the output buffer.
+	 */
+	if (!cipher_len || cipher_len % AES_BLOCK_LENGTH) {
+		printf("Invalid ciphertext length\n");
+		return -EINVAL;
+	}
+
 	*data = malloc(cipher_len);
 	if (!*data) {
 		printf("Can't allocate memory to decrypt\n");
@@ -30,7 +40,7 @@ int image_aes_decrypt(struct image_cipher_info *info,
 	aes_expand_key((u8 *)info->key, key_len, key_exp);
 
 	/* Calculate the number of AES blocks to encrypt. */
-	aes_blocks = DIV_ROUND_UP(cipher_len, AES_BLOCK_LENGTH);
+	aes_blocks = cipher_len / AES_BLOCK_LENGTH;
 
 	aes_cbc_decrypt_blocks(key_len, key_exp, (u8 *)info->iv,
 			       (u8 *)cipher, *data, aes_blocks);
-- 
2.50.1 (Apple Git-155)

