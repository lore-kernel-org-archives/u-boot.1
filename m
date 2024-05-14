Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8516C25B75
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 13:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CB6C88315;
	Tue, 14 May 2024 15:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mKinfgUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE5B88223; Tue, 14 May 2024 15:37:33 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AC488262
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 15:37:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42016c8db2aso14560065e9.0
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715693851; x=1716298651;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3RY15Jz0BxpmQJWPxOWqSvpbafFaMusC1sczkg23O2w=;
 b=mKinfgUhXYTdFnUZtZykD2i7C4PZliBA1xjg1zDyGHK4O/9IV5sqoCZhP/WFNuMxtn
 9tsIQYOuZP0qxQdfRjp+n28vE4jg60JB4PutwzFtEely0IhWCQNFCXbw50tiDXpfRxTk
 QHBMDiO0A3YNTnijhT2FNf2cVn95SymrWaZdaKegDir41KxNZMKPgjoyi9ylvRXtuJZA
 7udeNvK9uMB5Jq9ERrvMEyNkBk64yrk3zi9ro+/sjULckCPA6vfA6zXFtqMSRHo2AlRx
 c6nDwCcl0NNqZIjElsndxcM7XBOmpmPXnbPgm2OKfiOdoc40NCE1QWd2M9t39h4xlCRk
 SytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715693851; x=1716298651;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3RY15Jz0BxpmQJWPxOWqSvpbafFaMusC1sczkg23O2w=;
 b=MPZ1xCQSp8itDwR/8jKfVzWiBJFXDhwuR8FPN/RxgQRnmqc9V2HGGmwq2j5QQoR+Cm
 +7azOA1HnR0TNrBk1N3fhGtPFbKmBcif+TAX6ggD6c6KrWruXcm65rviKxCtls0PHsZO
 8psV08BdoD/9VzEi/hAe9Vkd1QFJzlmG1S1a0gaucC8lCCAjylzeGMDQDK5/5VzmNraV
 iNF7Ny6W37cKwop+4sSPkzniV8TjOjsasbETHx0L+TLz9s9u4aKRipqr7dHJP4Vg60EA
 NCyVssBV4J8QZbTyAvDHZaVHb5MKHzK7rHHOHUJLebvTplycvf9mybfTTutrLZ6aOw8P
 2q1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2YS3NUfJcW/H3f1zup5WpayRSb3FHfLxZRLSBFb9w3tcd1P2NesYYmg3dTA/f+f2qKXXsRptNSDupWkhjPgfOjcYAlA==
X-Gm-Message-State: AOJu0YxBhw6gQLf8B7iUG03FZE2RI9kZ9NmHPZfVa8qo9WsjEdKkfWbb
 oAZo5NuV2J1UlApCycACPhfOymfFzNvCzMK5nMrxBfWoPiZLWvpsXPK7k9h5lbhJYLRhDA+fXPi
 r1a8=
X-Google-Smtp-Source: AGHT+IGrfcny7nVruo/8DGymaMmItMn+CFSOaFHcVTRB6WAs7p4sJ6mv7I4LSAWoIzFaNbbcoed9qw==
X-Received: by 2002:a05:600c:5605:b0:41c:7ac7:17f5 with SMTP id
 5b1f17b1804b1-41feab42b76mr94685585e9.24.1715693850861; 
 Tue, 14 May 2024 06:37:30 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42010940845sm113834015e9.35.2024.05.14.06.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 06:37:30 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 0/2] MAINTAINERS: updates for fastboot and usb gadget
Date: Tue, 14 May 2024 15:37:23 +0200
Message-Id: <20240514-gadget-maintainer-v1-0-b170f291dc00@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABNpQ2YC/x2MQQqAIBAAvyJ7TlDZLn0lOpiutocsVCIQ/550m
 MMcZhoUykwFFtEg08OFrzRETwLcYVMkyX44GGVQzRpltD5SlaflVAeUpQuoggtmtzvC6O5Mgd/
 /uW69f9fjMoBjAAAA
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.13.1-dev-5d32f
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

I've noticed that I'm missing quite some usb gadget patches such as [1]
since I'm not always cc'ed.

With Marek, we agreed on the following split:
- I take care of usb gadget side
- Marek handles the rest

Update the maintainers file to make sure I get included on gadget
related patches.

While at it, also update FASTBOOT entry to point towards the u-boot-dfu
tree.

[1] https://lore.kernel.org/all/20240412202611.3565052-1-alexander.sverdlin@siemens.com/

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Mattijs Korpershoek (2):
      MAINTAINERS: add tree link for fastboot
      MAINTAINERS: add usb gadget regex to u-boot-dfu tree

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)
---
base-commit: c8ffd1356d42223cbb8c86280a083cc3c93e6426
change-id: 20240514-gadget-maintainer-cf40fcf2bab4

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

