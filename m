Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E40D0D16C
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C6484088;
	Wed,  7 Jan 2026 21:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C8F4yQ+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD57C84047; Wed,  7 Jan 2026 20:59:17 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 876F8839A5
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 20:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7ce0ef9d4eeso1042653a34.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767815954; x=1768420754;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YAHuBlpE54f0b+0n8NtqmyZBeclNPKtvarohXVbiWT0=;
 b=C8F4yQ+VJ7QCKarXxNF5IlDaSx6J0ZZe/3EU9KpIb+7LbtEnXAnCyU622kiNf4nqY1
 F1tsc343sPSuryBYCxcEH2K15HCGPU+p71rzg39TmAk5voaWsPz5g9FG5WmlqPUFKUdT
 m6fK898FrS9bdx07V+sVzKAJCO5yLOdVNVamkzP/CW211GJKdxytX7zuFC6foH2ViGvy
 grSqN2mHxDCRjPvM6/KwYvZRUMHJsf6AvJzh4Qmewv2k7OmlAtCNdu3wHuNh4kBYce6x
 AmAZ3EQ3h38CeKWN/wDoK7OMRm2uLJKwkAL2fJZsl+Ore05uMQcI7ZaZ07l1ZZsk2eWm
 f4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767815954; x=1768420754;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAHuBlpE54f0b+0n8NtqmyZBeclNPKtvarohXVbiWT0=;
 b=k4Yo3LzuySm8K9jnlrJL8gd8cISfQSrgE6XHMNoqjEiMBIPXEB5d6SbXMs9cH6gKiW
 cScnycWzOKWVZsjPONOJ4tN5r0ZM5kd6YuClR9pfLRqx0J+Y3pXAsH+152QxT/JOG+7L
 IxkBFzNfVHBoWPtTHUrJxapfPJrZjxshWG+m5kgaecfP64/aNFddd5tq5XriWYO7uQw1
 jZvOiu6UfLzqIXj02BDXFMq4/DHzyRtyma0ltRjjwJrRw0h17+6EDUrjbbDl24B/rv4z
 1dfOyMyIwiGxjicv92WgtRL8dzeWnJr3MPvISOYGfQa6ZL+byT5esrADeoS/ZxzCBkFa
 eVCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMjwrRdZzlfaLmwWAFVVmc7Rr9I6sfV6OLg/45hZgSXLicAqLDAiiqpLL9EYXv1POtS/lp1ok=@lists.denx.de
X-Gm-Message-State: AOJu0YyzIaRP0e3FCsTEenUk+r2c8xbTgUCrZyR0LgK3Xg3qQSCV2Z47
 42T8z+g6CXSoeA7f7lbnVAWcFZzJ9iaMCrGinxdRrK85kO6ufxmWeBrntiMNe3Q/jh4=
X-Gm-Gg: AY/fxX6L2PkrVa4/wxpmDljzPREHX6muGcSgeLytOHpA/QeOIr03NspJcEW/pOjv72F
 9pekO0x9CH2ROKrOtIWashTv911Nyenb4ChtkceYU7TPjOUxb0mspjkEagMI91OCgkK+ZjORvay
 Q05hrmqPpvvJlgiaqIZWShp44/0MecRpnjYzbQiBPp0BRurUGaIn3ee3SGBdLwtMPeMCrgchg8X
 SbWkd5KAFKDGhnescV9OnQI6w7Z7Z3Y3V07IM0DfhaWdPkQSp/Prkz7O6cI/lNo3LfYx8AwUDdt
 N5EIlZJt1kpn+LZH61dijYLN4UVGXs64SWvcyT4pK387aXv9xl2uW2p6X1VQpUTNRBTPc6Wtohp
 kujqUD79f3j3WGqvga9o6z9wuNuX2p94FsT5Mp+18q6jmuJjepoFNuzjhzCNnm2FkFhPxPhOiRv
 I6uTQpqFkoLc7l42A=
X-Google-Smtp-Source: AGHT+IEYn1yqDw6mG5Q0Y0HCDZQAGh6QnfoYjdXL6tsxfabGD3+QPkCQnGtm7MqGFZh0W1M7eMZt6Q==
X-Received: by 2002:a05:6830:45aa:b0:7c7:63b6:89d3 with SMTP id
 46e09a7af769-7ce50bcb16cmr1349227a34.19.1767815954217; 
 Wed, 07 Jan 2026 11:59:14 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478ede38sm3900797a34.26.2026.01.07.11.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 11:59:13 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 13:58:58 -0600
Subject: [PATCH] configs: mt8365: remove empty header file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-mtk-mt8365-remove-empty-config-header-v1-1-f1c25b637fdc@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQqDMBAFf0X23IXE0lj7K6UHSV50KUlkI9Ii/
 ntDD3OYy8xBFSqo9OgOUuxSpeQm9tKRX6Y8gyU0p970zlgzcNrejfvV3ViRyg5GWrcv+5KjzLx
 gClC2Y/A+RhcHM1JrrYoon//n+TrPHzpT4KF3AAAA
X-Change-ID: 20260107-mtk-mt8365-remove-empty-config-header-19dccff6f709
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=kUD3Oik6HcZ9bxEJCxpoYB9J61FWMubj1gJGQylvERo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXrsJ95EVSasss+ZBfwFuxSG/w/HIIXmaUYXie
 vTw0MkBjb+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV67CRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABUkH+wVkBIrSZihsKi2GumLEHHi9ibGTumBcQP6kIiu
 TvzVVsodlw3csWStbWxXsHkYFt+EX7Dp+ERL7vrGJKlStygIPtxyQ990vQBn0BPpo10Wjizvtml
 YsKbJkSQG6tgbDzhglddY66R0kosYqhhM+WljFkjSOn45SYNANLamRYIGybRGhgySWUO7WsOHhc
 fXaC40bdb6maQa/X7aDvAx2KzlpldRH7uSgre4LhK4b8I8roIkf9fo8eS69UoeY/CnQEgCtTI1x
 lXJ9w2WxzxxDmoDg/KdPjsR4xjj6Yw+6xwWDePmsEJ7tFAZFe5D+7c43J0IO1kD7NF6xTucT+yF
 uP0M=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 21:19:27 +0100
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

Remove the empty include/configs/mt8365.h header file as it is not
needed. The Kconfig entry that referenced it is also removed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig |  1 -
 include/configs/mt8365.h       | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index f7ef17e0203..d1d2605b2cc 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -158,7 +158,6 @@ config SYS_CONFIG_NAME
 	default "mt7987" if TARGET_MT7987
 	default "mt7988" if TARGET_MT7988
 	default "mt8183" if TARGET_MT8183
-	default "mt8365" if TARGET_MT8365
 	default "mt8512" if TARGET_MT8512
 	default "mt8516" if TARGET_MT8516
 	default "mt8518" if TARGET_MT8518
diff --git a/include/configs/mt8365.h b/include/configs/mt8365.h
deleted file mode 100644
index e8aacf8c5df..00000000000
--- a/include/configs/mt8365.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Configuration for MT8365 based boards
- *
- * Copyright (C) 2023 BayLibre, SAS
- * Author: Julien Masson <jmasson@baylibre.com>
- */
-
-#ifndef __MT8365_H
-#define __MT8365_H
-
-#endif

---
base-commit: 53c0d5b387956bb4070a943b61991898373a20e2
change-id: 20260107-mtk-mt8365-remove-empty-config-header-19dccff6f709

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

