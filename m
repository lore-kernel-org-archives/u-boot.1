Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21435C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03A8A88549;
	Thu, 27 Jun 2024 10:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CB+EjQoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A308857E; Thu, 27 Jun 2024 10:30:02 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 235A788571
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3608e6d14b6so4836456f8f.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719476999; x=1720081799; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJXFsCW6LCl1bXkmZ8sKbXEiUPqgjCbPoT+lGmHDHLY=;
 b=CB+EjQoB1TIeKbJnL8RsaqmpL/7irKONX2hoxaN5EW7K8IoJWbBZamzNUP2xuw9o9c
 i2a6iOsUwapbeSoF1HyNBg5VjoBOneO2RI7m63/jZ9wRYz0YRd4EcuWBcnd7Dc1nk7VK
 MKijJTeUY9A7zNmXZrDT06AeCGADKbrze7DN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719476999; x=1720081799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJXFsCW6LCl1bXkmZ8sKbXEiUPqgjCbPoT+lGmHDHLY=;
 b=DxyVJEzc4nb8SLphhP5oIsg0Li3MOUsyUvQv7PZZT4dM7hNuuGUzmBrT6+KpkG0rx1
 qtSUJglfn1b1GTDH/2/5+ycQSkYs/I6pfa7UZMBPn+xF93KOx0lvREcVb2EmtM/6+RUZ
 f99H4178Gpc4cNZxjT9OL9Gd2EngTxFj6sL9zQ2lArUd9RZI65XX59179ABgv3R26BoK
 +Uo0uwOS2J0XfoC+jpk8/ywGrg2W39s7A86QEmY4Xf6oisfrsK6LbUXUlfRdqINIBufW
 pU9MeMK+vXAQbpiXgy7Y+cgH6ogEmnh9tzkAdsG5XmeFnnY9oFIjFhmfiVpc5GQjfcd2
 2wFA==
X-Gm-Message-State: AOJu0YyewHd8olhQpz0sPzPz9h4Wf+BK0IGfUIOBTMWaNVAHDDRg59oF
 Eu3x36AvouIOAXPtAzR9xlRINb59Of8RNrgsl9AricE/EThxATsPmBQCoKOPszGbiEBYNddcl/M
 4EA==
X-Google-Smtp-Source: AGHT+IF1VfVA9eDx6CcbP0rSI0s7wPAKb6qhcl8Y5o1CcJqvtvXlse3T9r7lgtQPJ0sH5Scl5j8MCQ==
X-Received: by 2002:adf:e507:0:b0:367:4165:ad4 with SMTP id
 ffacd0b85a97d-36741650be0mr965508f8f.16.1719476999479; 
 Thu, 27 Jun 2024 01:29:59 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c1c8sm1106534f8f.9.2024.06.27.01.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 01:29:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v6 5/8] power: regulator: Handle autoset in
 regulators_enable_boot_on()
Date: Thu, 27 Jun 2024 09:29:46 +0100
Message-Id: <20240627082949.357089-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627082949.357089-1-sjg@chromium.org>
References: <20240627082949.357089-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

With a recent change, regulators_enable_boot_on() returns an error if a
regulator is already set. Check for and handle this situation.

Fixes: d99fb64a98a power: regulator: Only run autoset once for each regulator
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/power/regulator/regulator-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 77d101f262e..d9e1fb68295 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -518,7 +518,7 @@ int regulators_enable_boot_on(bool verbose)
 	     dev;
 	     uclass_next_device(&dev)) {
 		ret = regulator_autoset(dev);
-		if (ret == -EMEDIUMTYPE) {
+		if (ret == -EMEDIUMTYPE || ret == -EALREADY) {
 			ret = 0;
 			continue;
 		}
-- 
2.34.1

