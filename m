Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88242C5DF74
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 22:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 175606069D;
	Sat, 15 Aug 2026 22:48:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iYZrsMkEfFl1; Sat, 15 Aug 2026 22:48:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59ADB60698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786834131;
	bh=8LqNoCv1UuZ2iqESdbkavEnG87u6fEaH5tyRIhjiiRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FM6dK+pEBqwXgLK/sdT/Vt91pZBcPL9D7ep2mvMHwmY/Qc8om20xmJPm4JTFd87ip
	 DOcbl6uyUn1p2h/qXJAdq4+B8u3lv+dixOuoUsHCapQnZnCRQuOqlufGVkFUpW3KXV
	 l8QzgPCeAATCz+ufTC3qQkkHPRJvcVmk7+dIdhHcFEAtBAYh14son3m5TAznJd4CMI
	 zO0H3xferkGtYrK654mruSzuF/VDziRKrzIOn+zCGc+lZmvlgMgpD4jO8xEr5BHsLH
	 NXGFwHtKDqM6Sd3XQtLORQH1UErT/zCKTk+dCwfQ06Wd/t5sLmi8ANt1feYS+v+Tb1
	 Twy9Ws1eS7HnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59ADB60698;
	Sat, 15 Aug 2026 22:48:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B2772BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D52D400E2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 22jOo2osM7jb for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 22:08:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 169EB400D1
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 169EB400D1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=GQmf/qis
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 169EB400D1
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:03 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-495590dde14so28246615e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786831682; x=1787436482;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8LqNoCv1UuZ2iqESdbkavEnG87u6fEaH5tyRIhjiiRY=;
 b=GQmf/qisSC2fqwEMwVf9t68bKGdgvP+KXV3vjxXcn6EpeqDyXqaf9XQf4OCtXIYC4E
 hvrtIv3/zHjh+kABulf/S18ICDCC5NjUo48/Qrt643qH4CabaLDsYJUo39r9a8Pr/8V3
 fTk0+sI6gtMZEXExBCYR6BztYMWgjgOYRPyN73rG+Os/TtshaZZeLq4uhSzqvppB40OA
 zTVqqaxKAwNcpNL4XuS05YfvgJNrcwDBXlKuWIdJU6fUgyVj0Pb1oaq4PzZZSlKuUISr
 jBZMgyTpO1QCxP/U7WXpQkihYpGR9bv+dOM16oztZAvry8wP2BerTle+SaT6XY0A3uZd
 GmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786831682; x=1787436482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8LqNoCv1UuZ2iqESdbkavEnG87u6fEaH5tyRIhjiiRY=;
 b=iohILDUPMuSYDudpYSvA/qiE+aVVJAktArbBNWnrqK234rixdtBUX2it34hL/GEwvc
 POLxHnvuBphBX4X22HamijvTXcX4rkZwRP6CyrgtqmHjWK/0NalAPcnywIlR5v10y3sE
 3D1+RyZE1WWH5kAa5R5HnLb6xGNIQM0Od4v6cYl3X3BmO0sQv+2ZAfToXPP9QpElm6BD
 Y3AbtCk40KPiW4omaw+HQQqdOCl/xE+sk6OqSyvnlq1cRxHzDwv+BQjknDZSnOdQMCPy
 zMBrENDYnzISV246hJW1Lo2jT/yaHFc3+tvqyOoJvhhJu+FlwEebsBjFsNX6N6V0d7zi
 sIcA==
X-Gm-Message-State: AOJu0YyLCE56tVAyB03ss6Bh9JHCqXyJVUgEkccumWYhTV+hBtwl1EPq
 vQ3jm2ZE/WZdJam1mLIluhxk/vfDos7ZQuq5aeB/Wtav6+vp79xbYG4eQC+0p8/nXH8=
X-Gm-Gg: AR+sD13C2f1ycUL4fdi4XxpS4/elI4p2Rx2TnO9Xk4n4zYAkVTFDSnpbgZGUDLPq9YH
 efSlB79AISvRtgazW5WstW6+jv33xaGhkPrIKsI4t0Y6vBfitpuufXlfVAFTrEhTOHskPazIVez
 ImixXUs1Uq7xDR7kxzGCaXrcjdaxS8FgG9t4VaqMjXsohlfHpQ1FSiNFjxlJni/SiWR/ZZe1J5s
 KaM8tLU3nJzPf2fm5fC7nQyLWvRxKlsgkZLQAAsiXDoihOIK/lXDtr93q4deOZVzU5c3zlL80oZ
 mZOipbb088EQTQZeMWdSLY6hF56wHpSo+EUTiXDR8ZyWubCkiPUPmku/O6PI/8Wj0Ar9dSUkxQ2
 vVbeR+rfpX1K4UdTuS28yl8p2H03yaZneGmKFQQCTen1pQNXbaiSC5Na0cgyuivoTPzgrulyE9g
 L1E8r6McU23rNPRxNMec8cC58Dq62/Po0P+oOFlokJGWl3e16UXlt+rcYK3Egx+I+qrOZcyjujw
 WBh3iHs4l2mr4pifyXQ9ZwAYV/2/qGL5FGMKswf0cHYold/54+K+jbiRgEeXb0iEWx2pnxwA2Hf
 RQ37WUjolHI7BRL0vC5GyU2o
X-Received: by 2002:a05:600c:c163:b0:499:8174:9f39 with SMTP id
 5b1f17b1804b1-499878e02cdmr283996475e9.0.1786831681899; 
 Sat, 15 Aug 2026 15:08:01 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d33asm179598285e9.10.2026.08.15.15.08.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 15 Aug 2026 15:08:01 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: philippe.reynes@softathome.com, trini@konsulko.com,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v1 1/3] lib: aes: reject a ciphertext length that is not a
 whole number of blocks
Date: Sat, 15 Aug 2026 23:07:52 +0100
Message-ID: <20260815220754.11724-2-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260815220754.11724-1-pranavkasthuri@gmail.com>
References: <20260815220754.11724-1-pranavkasthuri@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 15 Aug 2026 22:48:45 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
---
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

