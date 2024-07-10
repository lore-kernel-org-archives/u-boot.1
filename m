Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79624C3DA45
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 08:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00DA388700;
	Wed, 10 Jul 2024 10:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q8PHdOI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA6788718; Wed, 10 Jul 2024 10:40:21 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69295886EE
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 10:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52ea33671ffso5587030e87.3
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 01:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720600818; x=1721205618;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gw6aK6Falt5Ba1LKFtxWPL6TOlHJswqdDEHUNBIvXQE=;
 b=Q8PHdOI4sahN4UGfNrl0rW/jnkkDoBiAJu11Klp5c46SMmTPPgOgBADQold/iDz9mK
 qJmz1bPJ8YDAjduzy6YnrJJsZc2NB1fgY308DSXvIcUH1iST/hMdUTORhBFwV5+zpAs1
 +HRyrgJ2HOm8Sal6Fl/0Qd6MzuE2/w6Cr2nsQwtGMj2na4lHYONSVtOjtd8dLXDH2gGR
 URP7WDK80Y6m96jL6IhhqYItItitS+48HPhWKe/zc+UvToRV/ydacBZelAShDP5IxW/E
 ww+FSfIiy1PCMvB1+jdtoLSaDCA7trLL90pi/Zje1WG17x+kOgSY8zjaPuLEGE8wZ3BD
 m17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720600818; x=1721205618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gw6aK6Falt5Ba1LKFtxWPL6TOlHJswqdDEHUNBIvXQE=;
 b=RAic/rlDuKkf0LQFQoiszW05khZGo8vBB8P+sAbC8rpDykwaaIJKmx2B+T5pLCNbud
 C742tK5IyzRLsvzeg3Ex4W0LYQI2ekz+Ng/4cFq8Il3xBbta8m/GWmYLkPxQx1WsSbkB
 adsLy7w6fTIsLT5ohOFOIElzORU/lPIVEf3YJqhZAA4Jbk9jvsgSj/IHPrlhlG6aILnC
 b7C5yKtDLi2AArm80U5cj3JP+dGHnnf5QyUPADmn/PHk2/q0vm+BXYL/1L4j1bHL7+nv
 L9NE+lFfP1fPJArLBde6zT639sAOTVq31PebDsPrVzDkouuEGOjoONdNZu9/8Nx/B8Z7
 IG8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz1WX9Cfk6r7BQTapJCVrT6mUtdP/klj4pg2VznmJqpPJ3q01Ld/9r6SxSNU+3tjZ5RnP1ctYAFWFIZXHRduFVAuCdcg==
X-Gm-Message-State: AOJu0YxwosgreYirjl2pu6QcWYuXLjc+ArJrc2NW6GbmYa7ke8v4sfR/
 XzLvYWzs7yhdyJdP8IbRHJ33KpuF2/a7PBIdyGZw0IQ/Lny1vOtTOaMdmKhFjM64HE4Ebb+wl2C
 T
X-Google-Smtp-Source: AGHT+IF58od1HGXn33e0lb9ED0onmE1/yoSaMrlthH3ixLP5q4QorCXMt85teAoEsByc6oZhL6dqPw==
X-Received: by 2002:ac2:4c56:0:b0:52e:be49:9d32 with SMTP id
 2adb3069b0e04-52ebe499f4amr1338388e87.47.1720600817502; 
 Wed, 10 Jul 2024 01:40:17 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427270238a6sm39994945e9.20.2024.07.10.01.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 01:40:17 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 10 Jul 2024 10:40:03 +0200
Subject: [PATCH v3 2/5] bootstd: Add bootflow_iter_check_mmc() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-bootmeth-android-v3-2-b99406e22da3@baylibre.com>
References: <20240710-bootmeth-android-v3-0-b99406e22da3@baylibre.com>
In-Reply-To: <20240710-bootmeth-android-v3-0-b99406e22da3@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
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

Some bootflows might be able to only boot from MMC devices.

Add a helper function these bootflows can use.

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
Reviewed-by: Julien Masson <jmasson@baylibre.com>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 boot/bootflow.c    | 12 ++++++++++++
 include/bootflow.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 9aa3179c3881..59d77d2385f4 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -575,6 +575,18 @@ int bootflow_iter_check_blk(const struct bootflow_iter *iter)
 	return -ENOTSUPP;
 }
 
+int bootflow_iter_check_mmc(const struct bootflow_iter *iter)
+{
+	const struct udevice *media = dev_get_parent(iter->dev);
+	enum uclass_id id = device_get_uclass_id(media);
+
+	log_debug("uclass %d: %s\n", id, uclass_get_name(id));
+	if (id == UCLASS_MMC)
+		return 0;
+
+	return -ENOTSUPP;
+}
+
 int bootflow_iter_check_sf(const struct bootflow_iter *iter)
 {
 	const struct udevice *media = dev_get_parent(iter->dev);
diff --git a/include/bootflow.h b/include/bootflow.h
index 6affc5e1a4f3..4d2fc7b69b57 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -408,6 +408,15 @@ void bootflow_remove(struct bootflow *bflow);
  */
 int bootflow_iter_check_blk(const struct bootflow_iter *iter);
 
+/**
+ * bootflow_iter_check_mmc() - Check that a bootflow uses a MMC device
+ *
+ * This checks the bootdev in the bootflow to make sure it uses a mmc device
+ *
+ * Return: 0 if OK, -ENOTSUPP if some other device is used (e.g. ethernet)
+ */
+int bootflow_iter_check_mmc(const struct bootflow_iter *iter);
+
 /**
  * bootflow_iter_check_sf() - Check that a bootflow uses SPI FLASH
  *

-- 
2.45.2

