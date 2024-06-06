Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D66C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB338845E;
	Thu,  6 Jun 2024 14:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ThpXG3ml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70AB88844F; Thu,  6 Jun 2024 14:24:21 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46C868823C
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 14:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2eaa80cb4d3so12959401fa.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 05:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717676658; x=1718281458;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PlQwmH1Upls1Y6TGR7R5sIQ/wWND7uPjjhpH9DrNCpU=;
 b=ThpXG3mlj8ZBhsC4MJFXXJy/3ScgMkl7YC5we5zfwDq+JTYhPg99JkEFuCtZD/t/Ms
 Yl4sKZR5NvCwEdgfiNxthaLRe/tftxETOthIKnjd5kMzbgrxCrN+WbdCgsZ3mreM6xOl
 ux9Ku6tgoIsmFnawMxMu8CDbtaGT4t4l6haJRySeFAEmASbyyPifL0DczS16A79qPK8x
 qOfpPeCFQTsXAvzuDh6ZnYO7BZBTQtKRo/byYAA5Rbx5RTebCQ7xbsQmv0iB+j5nW+yA
 wi9q8+ApcAZk0QOoVaiR2qRnRoqjPC5WOep91/MMBQiayL7pK9IKUHSk1ygWk2/UP1c5
 dMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676658; x=1718281458;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PlQwmH1Upls1Y6TGR7R5sIQ/wWND7uPjjhpH9DrNCpU=;
 b=T73PTIq5PRLIRZClv086ENhi6u+uEmZ+ZGsIG4qIP4BWa25Xghc+9Cy3PpWEhbcAJD
 8t+jEb0+H1ZAHidBRwqReoPu3bhnsgCNEC60oCBM/3UKGBENoVp9H6ojGdGzeWTSMrWo
 lbwgCwolHJ5L+rSnovvO/CTF17KEnKEm5MhT17FdLlS0MYPSy7+fkg5U2DXqmc99tL2u
 drzq+KZzeIWOA2KBoRrAqXUbUXJ2RORlDDzUSYCNkyY8+XZ45jYTBR1Ik3veWYgJDbcm
 1kncSn6Y/pIDwZZS8m9iK1QFYk7RW1OEvsNMsgCjoj3Groqt4Wj2KaWQtEIPnDmaoZkW
 yftg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJOAXTjh9e+VF2VrPbpEvd6wcJkBbLBodTMLHudsMntKIQ4B2u9RUSeUjFsI3hFobTkzw5otYvpuIuW7kOUVqVY4zjJw==
X-Gm-Message-State: AOJu0Yz2+JI1JLUev2F3kGpKe3HBxuzo8FJHyp9HDOqvKYwt2BQoQh1l
 fZL1PFZaSfUdmrMmVPlsuGXYJVq5V20qmwz/8wcZ0YmPtEHxlY2oOsC7y5lNbDc=
X-Google-Smtp-Source: AGHT+IFbwnohQxk92lLU07dlsBz60A5E7g0KzcMN9+4IlaaKpkLGNyatdmYsymy64wAkzVJz2ylkbQ==
X-Received: by 2002:a2e:8081:0:b0:2e9:87f8:7fd7 with SMTP id
 38308e7fff4ca-2eac7a801a3mr38232521fa.45.1717676658488; 
 Thu, 06 Jun 2024 05:24:18 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d66d01sm1432828f8f.50.2024.06.06.05.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 05:24:18 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 06 Jun 2024 14:23:55 +0200
Subject: [PATCH 3/6] bootstd: Add bootflow_iter_check_mmc() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-bootmeth-android-v1-3-0c69d4457cc5@baylibre.com>
References: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
In-Reply-To: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
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
2.45.0

