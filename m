Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570A7D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B893883D13;
	Fri, 28 Nov 2025 23:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aIYFH3BK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 095C483B91; Fri, 28 Nov 2025 21:47:41 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E70583B85
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 21:47:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so24860425e9.2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764362858; x=1764967658;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oYL4jR+w28Cb5q0Mo2220zK0kuXR702JZsZc14t4/Ww=;
 b=aIYFH3BKr+w+xYyrApf+5ykkQJwwTaZoE/ydxYxPGPEUIfPrqtyomy0GvkRCfp3TTg
 F+l7JsTF4zlBWhOgf+mH2o0UTstLLGXoQVGEOTJ7DgN0wiZjzL+BCQ/jIHUpvCY6Pkxy
 WNXAkNthGrWyRcW4MJKURJP95fSMMLz4ufAu3WkfIj/d4C2d90sLfU2xzhgwiauTliv6
 INeq3nX98I8RimrT1n/QbPpoLNg7tA2y+U1A/oJii+mjaTzNx5fnC2k7zllyCcjf/z7i
 yc1qZZHGqm0472E4oGtr+9bOKUsYKrlcVp2NURqPKTZO2IMtWnrzHnY5PHV8WftFZgm/
 7I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764362858; x=1764967658;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oYL4jR+w28Cb5q0Mo2220zK0kuXR702JZsZc14t4/Ww=;
 b=spGoPWethYUGthpPL0C7bKClx7ULrrSTAlCLvVuIp6i5bBKXEOmjIvM1MOgUQwlgDp
 ChItmyaRNHVBUdnEIcYWNUkdRN+wb8KWAZJS+DQwTZtahahu2HCGNCeOpPaT5mhV8pwZ
 +1qmpM7cfJbnlIW0VLA96pY0ovbFY3kQNT88MwoPsch/QhX3kg7OE0zIPW29+0to58oy
 EhQ6YmRJbuLRhprfK1o/ZGagi7nLR/4CVHz8NwFqOCY70PvTRNlfwhJAQOFVI4KJJE/m
 rGW1ovxbASQwUz0IU/8w+iWjHIKwTu9pI84Q3xofvKWoC0YLwfWwyb4BGFddGBXPxDAe
 vnGA==
X-Gm-Message-State: AOJu0YxatZLW32rI7NtdkjQwTkSCE6qH6pJ0fjbKe9s9A5bJ9XCLZUPj
 pTSMyvH7FGRvOnpYncPBpvCHYDUiTblIjvnwUoIxjWCbLw+aaFFA4TijTvPsEim2ums=
X-Gm-Gg: ASbGncuYB4KaLMXXOAASHw6hpbZ4+eTnvPjiCcPWYHGNMfLy9WxSZbUZKyJ492wixJY
 zY+uP0L0fQ1kyegm2rUIPxI3JNz/tTyDoaytYIoQSl2dChyEAi13/RYQXhFVNUd4sAwIYcVeuFI
 uIF21F6bvUffvnehrr4kEUIRLSUslZvWSaAGl+DF4F/6Dzh0YgHFwaTuA5kftSUmcNwq2zNG/4s
 2wiK6EUDa2KNpLPxdCID+KuI8mVBqAzVBdt0fbXr2zWL40V88nN+zD9kHmbQWh2sMAkKxocQPmh
 uOdzd994v5jSzpRnVgWFpAYS3lVeBdbeNiQTtyS1LZnGk9Bk0RovK3R8v8NIl7RLEyz3YjjjuQ/
 fpGIdIxQTVjfu3ow1W+7jyPtYNnwcdJOza7DFM7pEDVFD4PZ5W1zw4tM5C9Z+NxQLE3g8MuCDOP
 aC7h9IbH0=
X-Google-Smtp-Source: AGHT+IFPaeE8WqA7ky+tj+BGnER/NNbqw+28R7jGnprRWbmwQABHFR3a9sQDxFBdt5/fq9fhd6pzgg==
X-Received: by 2002:a05:6000:2210:b0:429:d170:b3ac with SMTP id
 ffacd0b85a97d-42e0f21e7a9mr18211242f8f.13.1764362858526; 
 Fri, 28 Nov 2025 12:47:38 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1ca1a3e4sm12002582f8f.25.2025.11.28.12.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 12:47:38 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 21:46:33 +0100
Subject: [PATCH v2 3/7] include: configs: am335x_evm: Enable vidconsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-evm-oftree-v2026-01-v2-3-42a863304498@baylibre.com>
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
In-Reply-To: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=743; i=msp@baylibre.com;
 h=from:subject:message-id; bh=cT7ZxUfQ3PGewyfnzL80Vd4q7ehW1heDWqdDYmhXayQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwtLodMlTlmVfo8CQ7fw1N4YnT+hkyrSXrdEtvyVTDjY
 O+2aW0dpSwMYlwMsmKKLJ2JoWn/5XceS160bDPMHFYmkCEMXJwCMBFlEYb/mUtm3rq9e1mwU8Rd
 o63JZxz0FU6LsxzvcSnVinh168y9WkaGSfFnVBLuBTu6G/3vtrb7Wuas7ObILSvd7nFF7oQI9xM
 2AA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 23:32:55 +0100
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

Enable vidconsole for the am335x-evm board.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 include/configs/am335x_evm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/configs/am335x_evm.h b/include/configs/am335x_evm.h
index d2164b41d6d6e74c7da0554b966ad5ee1f78e8b2..babf065bc3ea8c63f562ecfb07080f471b489fcb 100644
--- a/include/configs/am335x_evm.h
+++ b/include/configs/am335x_evm.h
@@ -83,6 +83,8 @@
 	"fdtfile=undefined\0" \
 	"finduuid=part uuid mmc 0:2 uuid\0" \
 	"console=ttyO0,115200n8\0" \
+	"stdout=serial,vidconsole\0" \
+	"stderr=serial,vidconsole\0" \
 	"partitions=" \
 		"uuid_disk=${uuid_gpt_disk};" \
 		"name=bootloader,start=384K,size=1792K," \

-- 
2.51.0

