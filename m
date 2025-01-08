Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4CFE7719A
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 14:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD8780601;
	Wed,  8 Jan 2025 15:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eUf+8NTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82498001F; Wed,  8 Jan 2025 15:38:56 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4388036B
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso6245495e9.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 06:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736347134; x=1736951934;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7Lw94X5+nAaAuwULL3PYA3IMAy6ir4IIif6gRnwgPU4=;
 b=eUf+8NTcGpMyVY0eUPdkmzE7dWvRL0cSCCNcH7WunzwiQWFAR+JOa5LxNuVYc3w4Ff
 BIGlsC/6inkSefgH+VmFJuXUDhhYnrR9xSM0n7Mz07eUlyY0RqdYNZm0FnKk5lSwMSU8
 YXGR/mrUNNpsSr6nmLb6bU542S6jWm8mLigjiNxGdwil9VK9WJPJegivah0Bv8vAWKWZ
 JrNowLdX2ghKUP5Vffmrfb9gc8lMkaqSmqC0Gm7mr/5BYeTlHd/euQHsRA10FtDvCp4Y
 Nn3m0VLLiRbxpS5hh5yEypNfIkMDxuwurV2RzfDwi44lG2TxYMfQZTXb5/L7H3GGy8N/
 t7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736347134; x=1736951934;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Lw94X5+nAaAuwULL3PYA3IMAy6ir4IIif6gRnwgPU4=;
 b=lmyKp+FE47Kkm/jQQYpzgXJLaqP/EOQGLJetycsgAeDtP92t4M76evacMgERglyvB/
 KONxsg6af52pyfv5fNYnwy9EkF7op4IwSJ6ZyRzsShtcdawts3JLAKSfLZniVYtJYuFf
 aBNHHGzoXag6GCmrtn73pp/yDUXh06dta4gW/fb6XuPj7IiizjNoMyHNj/ZGNd6cfQwu
 znSK1NGEcqvbq0JBU40j7at/Bzy3ceLYx3Hoi7Hp1+agbEMoU/3qG0WPLb/5za6c4sht
 PvznizODnXBq5aCcUVhyRDPBoluGupT2QuVIj2ZLqBB0HvhI3dDNV2r81ufF5KxIm3zH
 1qKQ==
X-Gm-Message-State: AOJu0YzURZ8I4GIHFLS+qksZ0sIZoWpoJroDlh8Z9MYp6XbOru4AfMme
 gjGmvl5HCyEdXhTzFUVVaBcRV42Np3pgYYcBEUr1hR2OTTQwJnvSL+FHXcmBeD4=
X-Gm-Gg: ASbGncsqA4FJdlqh/mEWhfwTExiiULsHBtaizU3pXx5izp02icovSvOTAPg1OUzrSRm
 F8oPqnCCmb9b3co5xATmuIS3n52NOwEf87C/9EOeNcWwR8VAuvfhByRlpVcW5ihuwQPDaKJ9oGm
 4QxI91/0Q9DhYiGuXSxP+2h+4jWZpTYhfp0cOWyl1HxrNEx2thgqzpmoLgyb+/9SY27lkTRv7+c
 KW641pZWrYmOC/Mrfe1wXv0NiarNIrxV4ynlJ1iwNAKcAyfHJyDZ9VCKo4HpoAFuRLY0i0q
X-Google-Smtp-Source: AGHT+IGSDuyYkRHyuoT5pZzTpKTtQ/tga/Td5n8u2yVeKKJbjMrNUb7FmoMTzPrzUb2HFcBt+hJH3Q==
X-Received: by 2002:a05:600c:5252:b0:436:e3ea:64dd with SMTP id
 5b1f17b1804b1-436e3ea65a1mr19737205e9.11.1736347134031; 
 Wed, 08 Jan 2025 06:38:54 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e3e779sm22796565e9.43.2025.01.08.06.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 06:38:53 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 08 Jan 2025 15:38:41 +0100
Subject: [PATCH v2 1/2] bootstd: android: Add missing NULL in the avb
 partition list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-avb-disable-verif-v2-1-ba7d3b0d5b6a@baylibre.com>
References: <20250108-avb-disable-verif-v2-0-ba7d3b0d5b6a@baylibre.com>
In-Reply-To: <20250108-avb-disable-verif-v2-0-ba7d3b0d5b6a@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.3-dev-86319
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

When booting an Android build with AVB enabled, it's still possible to
deactivate the check for development purposes if the bootloader state is
UNLOCKED.

This is very useful for development and can be done at flashing time via:
$ fastboot flash --disable-verity --disable-verification vbmeta vbmeta.img

However, with bootmeth_android, we cannot boot this way:

    Scanning bootdev 'mmc@fa10000.bootdev':
      0  android      ready   mmc          0  mmc@fa10000.bootdev.whole
    ** Booting bootflow 'mmc@fa10000.bootdev.whole' with android
    avb_vbmeta_image.c:188: ERROR: Hash does not match!
    avb_slot_verify.c:732: ERROR: vbmeta_a: Error verifying vbmeta image: HASH_MISMATCH
    get_partition: can't find partition '_a'
    avb_slot_verify.c:496: ERROR: _a: Error determining partition size.
    Verification failed, reason: I/O error occurred while trying to load data
    Boot failed (err=-5)
    No more bootdevs

From the logs we can see that avb tries to read a partition named '_a'.
It's doing so because the last element of requested_partitions implicitly is
'\0', but the doc explicitly request it to be NULL instead.

Add NULL as last element to requested_partitions to avoid this problem.

Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 boot/bootmeth_android.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 19b1f2c377b9a51ff1683259085e1d636c939413..2cd167f80280801618a317a65e93a10e70a0d9ee 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -380,7 +380,7 @@ static int run_avb_verification(struct bootflow *bflow)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
 	struct android_priv *priv = bflow->bootmeth_priv;
-	const char * const requested_partitions[] = {"boot", "vendor_boot"};
+	const char * const requested_partitions[] = {"boot", "vendor_boot", NULL};
 	struct AvbOps *avb_ops;
 	AvbSlotVerifyResult result;
 	AvbSlotVerifyData *out_data;

-- 
2.47.1

