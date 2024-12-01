Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C5AD49775
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D769789428;
	Sun,  1 Dec 2024 16:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lk1h8xEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 360E689428; Sun,  1 Dec 2024 16:07:34 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE31088D36
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53e0844ee50so236420e87.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733065651; x=1733670451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55/XRxyBKljg6iz7/3C2zM1nzU2A3rLFYIWJYNtmWBY=;
 b=Lk1h8xEitBg0C5E2V1PGJBZVYwHVHIJFCc6g9+g2MaGIiPPiG7hZwuJbaiU1j13LtX
 rx5nJLP2j43HkoBmZMQ/O5j8hLc3nEIopqmZJ1toz9DTtW5bHDf0tN4b0O5aaPdYh2UA
 t3QFSKsqjQgeeG1aS0a8ZNYMjeVt/eMZDIghDzK6w3XlMKzeEDR5lEELi1HNno0AICJm
 pllyPJ/GJknW/EtpamFcvv5xxLRGz+xPyxbdoPLYaJ0o5fumLcgsekveuRrPGshkVztJ
 +1HrE1sW06NXUbHskEYC8cQjZelcCyLsjNojsP7S2uFzEtGEo+05b8627H5gDZOZvOqF
 25fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065651; x=1733670451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55/XRxyBKljg6iz7/3C2zM1nzU2A3rLFYIWJYNtmWBY=;
 b=ZIFxBCAbuH/k5QHdi2quXH5UpLtsrm2P6YcH/oWBEbPclNTTQNu87jNMzLl+IxvVtb
 lOTn08MqSRgHkTGM5cBLp5x7QBvYWgur0MWj/O27tPn9zl5MlnGsMTkOgqRr3Bhvr520
 6wDfbTiw+Xjwp8SUn0l3NbWOxZWjn9qw15uw00/CHxWVEVA9BklNrb13iWVzG0h/tdD3
 NpE243KCO8rX9Y4le1FB3yQe3duL/OZ6E6/x8vJ+hwn2pyUFugrgT/PkPJID5txIzziN
 HWrEFpGr/M15Fi0EHpmF0TM2fe2W+0uPD33Wt4hj9MbFdyFwvSxwlTBdQ97FaWU2DJBS
 qb8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoF2s78nelbzn9Jx1QGp+mI13wJZ0k+xO86iG8wZDStAdLIiitNY15cIHwy3/4A1io/Y0glR8=@lists.denx.de
X-Gm-Message-State: AOJu0YykT7P1KdxnPrRJ2IpmKuK6kU6RlyaCS3C74j60Bi423ZjIzu+F
 EPm+KDwHwi30bUaNwXKSVMXFxkgqlVPE3pbJejRwjk6YiaT3s9D3
X-Gm-Gg: ASbGncsIjLQNMd1eiKZzWkb7N5ZXyI1eWjwyPmaiPEmJoYZ9vDl4abpR4q6MRKPJBjo
 fIR4wOkypoTJuOTwz+Hu8PRBKtoqVoHxsaxGT/pO+gLU884Ku4degOAQp8Xgjy5+OZmFVXbx9Jl
 8mGd510nUVK2Iv6QIoD2NiAnbQioZ4mxat3lCLxQfgbtVAEp7s19/zDE+AlfiV8B1e9nnraqJET
 fkj07h6/hjk9amVQ4Hyge4ewNNY13XfLqYoLaXeHEhV5ZkmYBBbpJzQWSDSOSafQZ7pT/7X
X-Google-Smtp-Source: AGHT+IECqXRFhBD/Ih10hLoswku/pOX1O2lVCy4aGe1u4lEvM4w8V3lJ+j5DBvS/97AWdefR6fLHBQ==
X-Received: by 2002:a05:6512:3a87:b0:53d:dd09:124a with SMTP id
 2adb3069b0e04-53df00a9835mr10894062e87.8.1733065650999; 
 Sun, 01 Dec 2024 07:07:30 -0800 (PST)
Received: from wpc.. (host-93-124-60-94.dsl.sura.ru. [93.124.60.94])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53df646f1a7sm1101120e87.165.2024.12.01.07.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:07:30 -0800 (PST)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: [PATCH v1 3/3] configs: th1520_lpi4a: enable mmc controller support
Date: Sun,  1 Dec 2024 18:06:56 +0300
Message-ID: <20241201150704.44462-4-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201150704.44462-1-bigunclemax@gmail.com>
References: <20241201150704.44462-1-bigunclemax@gmail.com>
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

From: Maksim Kiselev <bigunclemax@gmail.com>

Enable driver for DesignWare MSHC. TH1520 supports all
speed modes up to HS400ES and UHS SDR105.

Also enable ADMA and mmc command.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 configs/th1520_lpi4a_defconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index 3b6ff62ee1..d13c97463a 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -54,6 +54,8 @@ CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADB is not set
 # CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_MMC_SPEED_MODE_SET=y
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
@@ -66,7 +68,14 @@ CONFIG_NO_NET=y
 CONFIG_DWAPB_GPIO=y
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
-# CONFIG_DM_MMC is not set
+CONFIG_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_SNPS=y
 # CONFIG_MTD is not set
 # CONFIG_POWER is not set
 CONFIG_SYS_NS16550=y
-- 
2.45.2

