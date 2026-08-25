Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA94C61DC2
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED3E84062A;
	Tue, 25 Aug 2026 16:03:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MlkTh-QA_7RP; Tue, 25 Aug 2026 16:03:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673826;
	bh=H8D9LSIRl9ReoSh3H6GkykQ6bCPPE7Wul4qZLZ+JPbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qQwIw/ZUOW9i+5pvcd1rUl2zaWqneRgxpLdonol8K8/S5pwnPCy0tbcgM5GsmZeZo
	 2ERVSJmE4j/+4Fr2RZ7AbhlWBrfPmLNZ9n5ENenbeMdhCF+poR37nWZ8PIUrJiJQyt
	 yhdQdr1DTmLb3tPuGOvtkpHhM6ZxZSSZzurhoQY+sFZpYbGe4oN5X88w8ebWM3YOFg
	 /2jLizNMy78ilrBy+y/BUFcsFKNJqnD42Yy9ivxRseWV/0Gj1W3VVvm/iaVSJ42Kl5
	 buxtG/ZM7UPcI/T+i7s+BLyCvSV3v2rPp/xLL4XkavVJcpEDJRYiwr5uWC2jzdxF0l
	 wvNhQIPQyF+CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4684F4062F;
	Tue, 25 Aug 2026 16:03:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8286835E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 696D5400F9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHxLoToKvwdP for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 14:20:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mHLI8ljt
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B7E440092
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:07 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso2113608f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667605; x=1788272405;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H8D9LSIRl9ReoSh3H6GkykQ6bCPPE7Wul4qZLZ+JPbU=;
 b=mHLI8ljtByoYGM5GSLslb2X655YA4v5Nk40kurY9kikOkJEHJvhBZcDhQwe2TIhBU9
 XkFivwqnzi2pxU8lqhV9qGTUdjTQHd8vsngHXyruWgr82Qd4egZZgcNvMfAvhGf5dW25
 Mtz+xo1RLHQPRzk1fCWcdnvVuRw/vGPIt58XbCf1bO3k3Mxt6k0r0IxlAPUOWIFwtzHn
 lmmGrbYfAKnBV/VUspH8P89vQUUKkV1NGaGJatGYydUlce5+meuMekh6LcOSgZfcnCjM
 xdHdj6OTVK385IUAwHpGOo+sOOtxZRZgWu9QsTtMwVy8GHSlfaG+FBZI9mx8TiFdTSuL
 ZV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667605; x=1788272405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H8D9LSIRl9ReoSh3H6GkykQ6bCPPE7Wul4qZLZ+JPbU=;
 b=c5CIVvYfRC9YOIMP2QRLuXtqP8b3gLK0SNO9TV7TAIJgJQ5yE5JHp3gE1aK75NqHAD
 lT2pk4ztvnnF0YUhBgc4s4oWcaGmnirVSffyuk7gJ1vaHpXqW9SnKpvjQNwPSdDmcE4l
 FhaS45Ti5cLmalEPObe4a0giFnvCq9/xV81tj86bwH7wBxUHGOKFJ/06TTdHnHk1TZKU
 5T1OF3aIC8jB47yr77MojMhPqBZnbBhKQMd4Ck1pSY32j0WuhCy5OtYbxHS77haPkwKw
 jkkm34EpHUY4AOHDV7hng8SXNGE3NFwhlru+8XFxK4i9DPtfqWbfzfs6Ko3prtq1ay1j
 1okw==
X-Gm-Message-State: AFuF++nCiaQTVxbzYtm0bH9suoLH4BwPt8a9/MdjT17tkg1yDQFKtkdN
 uHLbLS7rgvr0YZiUnbObhj56900pobDnYBGz09HYtM1VLLSgSPurjYevfISjBl9ZDS4=
X-Gm-Gg: AR+sD11T+kQ0diQn3gSakMaISqHGu/A/Th8WHrb93N5Hp72yGKzSaKFTdDCoyAfmB5U
 enSkopC15WAXxN6FRruN22McArIVYnZlNuou5Wr9BaeuZyCE42gVlh6kug6TGJVqleDccOUQKxD
 rTQCdE4vJ4yVCHo/3OgVERisFNQqrG0DA9dnP/SbtCRiaYdyDE7kCaN3x0KYrcNYkb1c9aNDNdU
 natCOAkJh7M43EK9GSQhBukBPhC4jcNjt8wV4C7kjQ2XoAAQn7OvdIvRvbKufZZuX3ZudDC7NWE
 NktSbtc6lfipCC7sLfHQh/Gy31I/KQ7KVdvEefu5C2dvgztoUUuQTjsOC4gpEBJbzzAHo6bvge1
 SDXZ0oUFRjfUdfC9omsdT2UZKBucivfsHTuk/PtV8zDNRUK+PiKTB6AMaDB1xKvsBZArMmsylit
 iYKhI8TBQ9b7mOy9Tdxi042QpHupo05kzEFg4INIF2kCC8Vy1Qv5XJYtDypRBcqMDkxV8v77YTJ
 gu8y89jRQ6nwkyBZRjyhq0rXZz1sRF03XaleJ/OQu9U7eurByJvajjQjEgwBjDZEA3DcL7fLMKP
 FEprT174NjGF15WCqY9ciLS7
X-Received: by 2002:a05:6000:22c6:b0:47e:81aa:3832 with SMTP id
 ffacd0b85a97d-482c0b93991mr38955617f8f.16.1787667604809; 
 Tue, 25 Aug 2026 07:20:04 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b69d7dsm11745871f8f.4.2026.08.25.07.20.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Aug 2026 07:20:04 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, philippe.reynes@softathome.com,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v2 3/5] lib: aes: reject an unciphered size larger than the
 ciphertext
Date: Tue, 25 Aug 2026 15:19:51 +0100
Message-ID: <20260825141953.9534-4-pranavkasthuri@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v1)

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

