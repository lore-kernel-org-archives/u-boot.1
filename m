Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321A4C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 10:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3230D888EF;
	Thu, 13 Jun 2024 12:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LNAlMpCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3028888E2; Thu, 13 Jun 2024 12:13:36 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89D7888E2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 12:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35f188e09a8so690581f8f.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718273613; x=1718878413;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pRQvsZ0Ors9/qwlPi3O7OFLnn3bRqWMAveHYmhda0g0=;
 b=LNAlMpCGN23+bME0Jn0LmlboytQVF8oszGEThJ7mGMSWemypAVagwSh8298wJ4fDtN
 AZ7wzbMQplAo6cmlmi4OMW8USyuYyHzHYD5xsPffzTXsA04CBVpevnxteSIkUxlwATki
 FzHN0V7Q1YHAsZNmGhTSrnD7c9vsoEzhu6kZDqUzbOtB8hk9Ifefgv02XbzgtHF+YYc5
 86u+oFrbJaOL+KtKGjNpYsDeGB7KyBd//Xc7eo33bx3h6rG5QEr2hlT0+hIqW+pQK2Lb
 bnwJ390TErdwR3Ggn9gLBnLo/VgvmFFXFv6PDLK82DeCZC8hyhKrmUUvRkm62KTbqF2W
 wldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718273613; x=1718878413;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRQvsZ0Ors9/qwlPi3O7OFLnn3bRqWMAveHYmhda0g0=;
 b=E2xQwhbn5aPWlqyttsZLSL+Rw4k3RpULXjnkDzMRjNZAJI+3o+TZUrYgU0tJXq/fpQ
 svBnRtSzA9AanltbrtlHpY7jCKz/VEdTgL3RMiRHe3PUQ/r+Iu2LAuIEzmtCkFVhpST6
 /ZHxpYY5kGupEt7ogWK0jS03vc9bsbZmpzyqpoA3xXVtw81kJ7b3BNNKXBXXp+3qesTq
 /gU682SfMUm/VTcCfftQauk9m2vXxJ+41SUHpiLsyDAAsIJbupQ4cR+8wPx+PH/TUQGm
 2DnQL/Z3YGHrvZNCCOS5pkS+15OM5KZWXKD7OcqCday8sdxbfpJ0oP+ksz+v/ndlFjXd
 sMkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwVPXKKjmySXWQNCdRAM0vwNCRRnCvoGC2sBlUg+8cjtybg8z1xqUQkbQrM03OseqEdCey6Bbd9BGPy3NF5PvZuEdIcA==
X-Gm-Message-State: AOJu0Yxo2JFZLHb5c9aRDHNuNy1fO2M7PzT6i2TFG41p8gzmU0sJn7fE
 VVzccle/d/4RaxQPkrLMHm6f8xjGUDZYE4pgpR3liNmJHgmHCN2tRkafj+WF0SE=
X-Google-Smtp-Source: AGHT+IFtHw3Y4hAsDMeT39a9+eC3hzW16vRGW5gpuy00/gkByQAyhRSLk1JlwZSDZNgQtZYqzP/eDQ==
X-Received: by 2002:a05:6000:18e:b0:35f:d70:6193 with SMTP id
 ffacd0b85a97d-35fdf7adcc7mr3120507f8f.41.1718273613323; 
 Thu, 13 Jun 2024 03:13:33 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f2295sm1251573f8f.82.2024.06.13.03.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 03:13:32 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 13 Jun 2024 12:13:09 +0200
Subject: [PATCH v2 2/5] bootstd: Add bootflow_iter_check_mmc() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-bootmeth-android-v2-2-397f6e66eb29@baylibre.com>
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
In-Reply-To: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14-dev-d4707
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
index 080ee8501225..6058ddd89b16 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -407,6 +407,15 @@ void bootflow_remove(struct bootflow *bflow);
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

