Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FABC5DF6D
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 22:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D734140834;
	Sat, 15 Aug 2026 22:48:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hQTOpV6lW5Aa; Sat, 15 Aug 2026 22:48:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24C5D40802
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786834134;
	bh=679cthYkc4CCb0tL4TMtzFFTEHEwp9rG5QOgZSSYz3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=auIURu7X0+w8SEXAYsma/trUaOGGNIJJgnBP4ZAx+1wc2EgxGjC+AjZwS1vHgkAPc
	 b83vcEL2RR4CiMVRWC1OLFlYmCx1Yj+5DZIla2cEBrFn+9GJat8BeaecDk9e4++/oB
	 pVgAozM2+0pnjV5hXuFeI7246Ew8l8inVWpbKlTaTTliX3ItbXsgTe4EQ6CbKxZP3A
	 uuLEWwJUJomjBX/7LDinT1RQUN6PMJoPVsplTJqRR2yuUcXAJlw0W13Vl5YEN5eeL/
	 jS5TJxDmy7oYm56FuStpR5BvF5drHkBJvnKsutuA7+XVGmy8WvpnaGU477SKvcbN2C
	 wUXZ3GSaJ5wuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24C5D40802;
	Sat, 15 Aug 2026 22:48:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 96DC8337
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94E196063F
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 15l6KOMAw3gO for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 22:08:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B908360633
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B908360633
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Cp9IAJow
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B908360633
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:09 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49557167508so21313335e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 15:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786831688; x=1787436488;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=679cthYkc4CCb0tL4TMtzFFTEHEwp9rG5QOgZSSYz3A=;
 b=Cp9IAJow0m2s/X5S5wqdsLGo4lzlRh4yqPSo5aiarKK8uPI6qG3giXnOLfL9lMW+n+
 sKOvuV7ZAv2QUOgasihvDQ+fJ7U9AWVUmdw5XAyVPIAGz/u9RZ6+l5sB3NafxCqpuoDo
 FIZD0feldFJVleDhm0rLsdud7VP1ptz/CmpSlHrCiUuvaYNa1+Yc3bS/ZAtVpjwDwef6
 +7mXYyFXZllhVbXorY9SRlrdGYPwD1H5Gl90uEC9XvSScI1hieNfhdRlRaSwbE6UxkU1
 w6iFKDWAXKdwB+Y5abilrUdSND51HOLBoDAp0Pm0gcrDHTuYUoMuckR7aQZXYKGczx9u
 KtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786831688; x=1787436488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=679cthYkc4CCb0tL4TMtzFFTEHEwp9rG5QOgZSSYz3A=;
 b=bFPDkoA63ychL0CLYsWoftTCN+M9SulGZVzarBYusKQfZMHTD9HKmYwzfY9Vg9htH7
 K9sLCG4reNPu5VFCG9+TrpunuHgjOKG4jI6TvpwIVUD7gbhBYiELn1R2K6Qmlf1Ehrrg
 juilsO1k2r4VEWZYOkfolxYubIuwDOSSeoZw3Syzt4cijy6JgPS58djK7gWFwIeauL2B
 8/CLkXthzs1M9KehOb1YMMcqK7pk7blCfpP/WPgA/assGy8UKXRDVe4OEkzGSpqfntsH
 z/4ztopOWNri62HVRK30fjYgdCnVz8LRyGVXdxBqzlNT7WUdo6z/LlU6GEdFHf/HGVH/
 VbZQ==
X-Gm-Message-State: AOJu0Yw6bxFBZRI8MUrKYrzEMoQQ2tGPBHw6U/xrggXDNn/pqnS5jb/q
 wVYtP3gTUddQT9w+BLHQm+YOFzm3xe3sKxYdHV1/b2tQN0X2eQrp+d6s5pQlN8HXmKc=
X-Gm-Gg: AR+sD11UbeSo0JGlC+1MnodFxSWOWJj6xkOtikCklk24DPOkOlXg2XzOHeuw2pdkDWC
 AKFmkAYQN7Npy5o7Zq5GCRElbwfWd3uxPQvF4kC0JkPE/ae26GtfZiCe3Xu/HCZfRKxB4DmO6pl
 fdZGI0SebN++2yvfqD2IF0fh7c2KnMASjJ3v6JJphF4ihtBVYe0AaYmRRvNKxqusjyB75IfFAuI
 RclF4AdCYm2IZdukYl0yqiF45I7hRy6ui0M63SeZLNPNHWQ9gdjEBVffNqNsDmaFOve+dR6OLTD
 fueCUEHvt9VMS4AmITQwH+p5cyPlUtYHnfLysU8wNsyhaQpEWC3wNNn64m7AzEvY+/ha/KO9L93
 3lmiyJ7PO5i4dJ3+uKv7+9JBokRGjDRuuTiuJmMS5pL+bKELnfNTe06KFXKnMowtvAqeeeLqjC9
 YrYLUx2DYAvfCsAq445HXZOFz23dttiSY7oGOpqYemJNe6ovvQS0gk7yXoJHSKrRlTA03CLGXNL
 rDdCN54uCoNaDpMGxYgj6QOn1q3ts53aSUikZdQSfvvPl6BL2jKOektrYzMlL9ji79WYC/sg9Fu
 9pPHjAC2IZm1Uppyt3t2OP9T1oOFUi5Qggw=
X-Received: by 2002:a05:600c:870c:b0:499:8a3a:fd3a with SMTP id
 5b1f17b1804b1-49991099160mr97665255e9.5.1786831687726; 
 Sat, 15 Aug 2026 15:08:07 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d33asm179598285e9.10.2026.08.15.15.08.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 15 Aug 2026 15:08:07 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: philippe.reynes@softathome.com, trini@konsulko.com,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v1 3/3] lib: aes: reject an unciphered size larger than the
 ciphertext
Date: Sat, 15 Aug 2026 23:07:54 +0100
Message-ID: <20260815220754.11724-4-pranavkasthuri@gmail.com>
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

image_aes_decrypt() allocates cipher_len bytes, decrypts into them, and
then reports the plaintext length to its caller as
info->size_unciphered, without relating the two. size_unciphered comes
from the image's 'data-size-unciphered' property, so an image can claim
a plaintext larger than the buffer that was allocated for it.

fit_image_uncipher() propagates that length as the image size, and
everything downstream - the load, the copy to the entry point - works
from it, reading up to 4 GiB past the end of the decrypted buffer.

Unlike the image data itself, 'data-size-unciphered' is not covered by
the per-image hash or signature, so this is reachable on a signed FIT
whose signature still verifies.

Decryption produces exactly cipher_len bytes, so require the claimed
size to fit within that.

Fixes: 4df3578119b0 ("u-boot: fit: add support to decrypt fit with aes")
Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
---
 lib/aes/aes-decrypt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
index 85773a9c4f6..5d616983082 100644
--- a/lib/aes/aes-decrypt.c
+++ b/lib/aes/aes-decrypt.c
@@ -27,6 +27,15 @@ int image_aes_decrypt(struct image_cipher_info *info,
 		return -EINVAL;
 	}
 
+	/*
+	 * Decryption produces exactly cipher_len bytes, so the unciphered
+	 * size the image claims cannot be larger than that.
+	 */
+	if (info->size_unciphered > cipher_len) {
+		printf("Invalid unciphered size\n");
+		return -EINVAL;
+	}
+
 	*data = malloc(cipher_len);
 	if (!*data) {
 		printf("Can't allocate memory to decrypt\n");
-- 
2.50.1 (Apple Git-155)

