Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E76D5A6EC
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E047689BEB;
	Tue, 26 Nov 2024 09:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="krDmG5yI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA4B89C43; Tue, 26 Nov 2024 09:06:59 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C6E689649
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-382433611d0so4442169f8f.3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608417; x=1733213217;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vtbTU7FLjCl8orbIaLhCYTw3PmzNbPP9nFpN4ROC+FU=;
 b=krDmG5yIgPS2CFAFLdD8OOtYvKHNp7IeS2W2tAkMjJGrWSb+Eb6lT2+MCqfbApTtRq
 5fhJXkcQ/uULMpRl9sMWHgvHTploGltOxN+1cWcwBhAqVwYfw5RK+loD3WWF+OxT1eHN
 EXcMxmISG3tzWWvj7rHoDRUhQy21MJdwJq0lWwXM5WumushvlFLmUWCWhCx4/li7198c
 QSndPrM5vB83RuEIUArKxJ+8GbJ5AGJiUdDIqaC6qn1G2DGGXXQmjgcG5CZaTfKbt7e8
 fAe4gd6zF55jUzLbgkCY4CeJFFXFR6sJBjhjzAZ9fFKiDZIPNb1SqiKeBVpsR37cbTxF
 rL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732608417; x=1733213217;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtbTU7FLjCl8orbIaLhCYTw3PmzNbPP9nFpN4ROC+FU=;
 b=LpviH/StKuUyWkiQvx6jV/hGGyDI2xZtT13fWVbfEMyx+0vj9o9UzKF1zVI1csryD1
 Np4SdhJbI8KV1IuFX8f6s/X3R8558r5kUzUOudQeB02BZgHsVUDz4jooVmBsvK7aTYnI
 UZf2Zh5B4Kp8KZljpz9XHBWeI97fDK9c5+eIIRdYijXfdy0ydrTw2z5bHZwBvM8Ck/ob
 yWqpB3aXeDghSGMvsMgti0QKPBITIxyFLb/KQd3zAJfejhc2kfMPERvm7uKtJHNX2Paj
 33R2gwZBgLS8thU8nXREbupmw1cPkTnkNvOLgA9ekmHEiLgbnstb22BZ/67v+p0IhYt/
 xYzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxsYudzlJ8GLECauvQbouITlKKbGn+rFQLNLX8kyc4kF79qqz1xSNILnQLbMJJL1hTdl/X9hU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzv+5VDSwVv0DrXrGxpqXf8OqB6jPqOUOVRKuPQbjb68MDZMz4x
 3C40hhC5W1PwRHmoggkPtlE785n0HQb5IzjuZdIBtdwuUfaiRE99iSKUPp4xav+xDvO40c8W9en
 3vFw=
X-Gm-Gg: ASbGncsPA28SuIf2mrMsDNqt3t/aUiSkpp8rcSX5h2SDIj5HJ4tIhG9onJvPIJc7Irc
 FFYMovuNmtj/X1ZKS+1dqW/nSJtI2GQc4hr1pQaZCEQDuCCX02JkXw8gYzwx52JtR1EEkFN0San
 fy/MHdjZsLQe9tqqkuZmHsF/TOhyvSd3mNrqT9tcYjJXExULtQr0YvqnpI2Jr9ArAgEoBgpjIDE
 k9nexFF5ZbGjcqI9/Q3x0Jf7Ac1If45JNVaoXxZ53AGcqdA8WjJoA==
X-Google-Smtp-Source: AGHT+IGGCUrzf17PZz8FvrrlS6GRm2xpWOjx25ikD5MOBGExUqHCX9jt+Lw2U7MybbLanKN9LUqA7A==
X-Received: by 2002:a5d:64a9:0:b0:382:4fa4:e544 with SMTP id
 ffacd0b85a97d-38260b3caf5mr15899023f8f.6.1732608416715; 
 Tue, 26 Nov 2024 00:06:56 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:86be:4d54:1784:8cf7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb36612sm12513102f8f.59.2024.11.26.00.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 00:06:56 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 26 Nov 2024 09:06:09 +0100
Subject: [PATCH v4 1/5] bootstd: android: add support of bootimage v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-adnroidv2-v4-1-11636106dc69@baylibre.com>
References: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
In-Reply-To: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

Android bootmeth only support boot image v3/4.

Add support of Android Boot Image version 2 [1].
Vendor boot image is only supported in version 3 and 4 so don't try to
read it when header version is less than 3.

[1] https://source.android.com/docs/core/architecture/bootloader/boot-image-header#header-v2

Tested-by: Julien Masson <jmasson@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 boot/bootmeth_android.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 19b1f2c377b9..2e7f85e4a708 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -259,16 +259,12 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		goto free_priv;
 	}
 
-	if (priv->header_version != 4) {
-		log_debug("only boot.img v4 is supported %u\n", priv->header_version);
-		ret = -EINVAL;
-		goto free_priv;
-	}
-
-	ret = scan_vendor_boot_part(bflow->blk, priv);
-	if (ret < 0) {
-		log_debug("scan vendor_boot failed: err=%d\n", ret);
-		goto free_priv;
+	if (priv->header_version >= 3) {
+		ret = scan_vendor_boot_part(bflow->blk, priv);
+		if (ret < 0) {
+			log_debug("scan vendor_boot failed: err=%d\n", ret);
+			goto free_priv;
+		}
 	}
 
 	/*
@@ -476,12 +472,13 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read boot", ret);
 
-	ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
-	if (ret < 0)
-		return log_msg_ret("read vendor_boot", ret);
-
+	if (priv->header_version >= 3) {
+		ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
+		if (ret < 0)
+			return log_msg_ret("read vendor_boot", ret);
+		set_avendor_bootimg_addr(vloadaddr);
+	}
 	set_abootimg_addr(loadaddr);
-	set_avendor_bootimg_addr(vloadaddr);
 
 	ret = bootm_boot_start(loadaddr, bflow->cmdline);
 

-- 
2.34.1

