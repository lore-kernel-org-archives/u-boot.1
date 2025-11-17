Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E228CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 09:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 671EF83A3D;
	Mon, 17 Nov 2025 10:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="ljLMW6d7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 862D683B0A; Mon, 17 Nov 2025 10:40:04 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EBBC8398C
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso2285198a12.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 01:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1763372401; x=1763977201; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OWGkSzLQ9uaLnyrc25IcjQ1MJa20tGhmvdOG4AJ3mHI=;
 b=ljLMW6d7cNvHXPuZmc04ZedBqIcCWEbLtvm5BKAd6BusDTaUSltZxVVHE4syIJxHEP
 FeEAW4GdZOk0WZLMGvdsrPDhQqqtkCyK737RrKTePz3wZCJI3bJnCX5ZlTOczL82DRiV
 6bdD5LXvn3n9ENa8hWY13j/btluqIdt7pBOT0W+enXa1MAOKVOMM8fqUj/jbk7DblfYz
 /sY1EamT4ibTLgMSM+uQgzizAilcwu9zziseUkB6F3XfsoBiwqaRhp6X7eXSYtjGhpE3
 UY/HdhGxt0UbLBFp/jiLxwg9cjzu6NtWyKzH4AirDRTI4UpMNApeiydi8DYs+Yf+kNzp
 hi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763372401; x=1763977201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWGkSzLQ9uaLnyrc25IcjQ1MJa20tGhmvdOG4AJ3mHI=;
 b=DSFokKMDe/TFXcs/j2sxEeCDYcW32WRqs1YHfVXMj5vktWlg59P8h5faFDuyAWH9PB
 RykvYNXOgroid1Lz6qPFnH+cEJ56OAZq/FGamnZtv/hr6kyj2ThMckVZO/8ipeTH+rvL
 EjkMm+PlsQQWUacQ+SccPeDsNlOVGm/sbSDfHJn1QtrevfJKIk/If2x03ZrzPQ+7rE9u
 0r3z+bjlJIGr9Rp9TRpzxgWBLrzDY7l+d/TCFIamM/Lz9WPo38a9NX9uoOaqmKSeHsSn
 nMRBWkT4r1fsaLCaIn6EXaHU1VYIUTUrnG4wmrq0xB4Jh/w2Rjut+vVKi/azZf+YWVDY
 JaRQ==
X-Gm-Message-State: AOJu0YwGHhkXuFWIOLCWjPJF9j0xWmc88pwGBGa3bEGEwIt5NcKF4g0I
 lSyfkxvf8j37wWSqw8ORD9ay+6kGQ70nBSB4NTsYypwioQp/zGZSke6gPZufew==
X-Gm-Gg: ASbGnctxFfo762HtALzKTJiqLKktXCuhzBG5wKu0HKzMFweA1+zzA0viF2Vk2LPQ4/V
 BGKtL5QAfPAEqODA00cpnzP3lHqxnXh7DIoiepFtEnJ6OK1HLnyXExWMEI7KEEXq3zYwA1wSxID
 EapHW2WZuyjpZ2ptFH4faMUjnKfkBmpqWy0uRjBHTMC4zgOtkdTVhOiavDIQXb5PDWfukdypW3p
 gjwDF4Ktb1r+zYC4Vzc8kz4m9KZqFkWtCRFVLepaISfImFJo7FscGHpteZZSEy83hSHPHHFH7Iy
 /yweg2EEAsQzU275uvhdIljJ+Xuch/u5sm+68qrPBVIuQ6aNxV2MFFE26oEjIM4au5R3me0NH2X
 ro+74+7Cux+ZFc959lUvCLRtv7wDFWQPxY/TJtkTBjYkXSUygOnbIWMx+QLj1zIaPnbwF32PTf1
 wDK05AhcSr9mFof0x94iyYYw/WFcqcSkUwjhuINpgLw73vr1N0LEZ+qCzL2U7cIGAdRBw=
X-Google-Smtp-Source: AGHT+IGzCo37H6NtsebsQd7URj2l6ErXPcSwXSDbFSSPYuJTlJfTkULSKCeG03fvtpDcy+EkuFhxdQ==
X-Received: by 2002:a05:6402:51cf:b0:640:cf58:47f9 with SMTP id
 4fb4d7f45d1cf-6434f86acafmr12271726a12.9.1763372401275; 
 Mon, 17 Nov 2025 01:40:01 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6433a4ce83dsm9740877a12.34.2025.11.17.01.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 01:40:00 -0800 (PST)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] bus: ti-sysc: select CLK_TI_CTRL driver
Date: Mon, 17 Nov 2025 10:39:54 +0100
Message-Id: <20251117093954.1580394-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

The TI System Controller (TI_SYSC) driver utilizes clock management
functions provided by the TI Clock Controller (CLK_TI_CTRL) driver.

Specifically, the TI_SYSC driver relies on the 'ti,syscon' support,
which is used to access system registers for tasks like reset control
and power management. These operations often involve manipulating
clock-gating or reset signals managed by the underlying clock hardware.

Therefore, to ensure that the necessary register access and clock
manipulation functions are available for the System Controller
operations, CLK_TI_CTRL must be selected when TI_SYSC is enabled.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/bus/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index a786fe430e4..05492c63bf0 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -15,6 +15,7 @@ config TI_SYSC
 	bool "TI sysc interconnect target module driver"
 	depends on DM && ARCH_OMAP2PLUS
 	select CLK
+	select CLK_TI_CTRL
 	help
 	  Generic driver for Texas Instruments interconnect target module
 	  found on many TI SoCs.
-- 
2.34.1

