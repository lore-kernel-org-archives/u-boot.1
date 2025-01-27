Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFE7C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB8A98128D;
	Mon, 27 Jan 2025 14:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ecSw03yY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A1688128B; Mon, 27 Jan 2025 14:41:14 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F7C81265
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 14:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38637614567so2095913f8f.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737985272; x=1738590072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ufvy3mF3xP5QvoI8bbkmKRvEZeesdZRM9S7AQRb0Ww0=;
 b=ecSw03yYZO1iracIs0PlxqH08o4FOlpBbnZDS3FU9UPa0a11D/YHJPnYlo7p5twJZK
 w9Jrf7iHk2YMb0Dtljcbahia9b5Mvo2bjLyVGeKoHsBej9SKz//71I2k079T2k0nSpTJ
 +BdXEgJ8WdsQKiR00ym4ukSERIP4RmZXwJgOlWgLNvgE2SuTrxHM/8hmA3IDkyurk9yd
 yqjvWxcKCgPrk9EB/vQo2trqRLJ/uJInxGQMAmKw7cIRf4qx+sLCQAdJw8NrQLZoyMIC
 6vqTf4HB1P3CtwooWPRqJlBwe22Kt8j+6PWEiUXbi/hXNKw9aArXn6pjqtPoVEO4w6ai
 xI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737985272; x=1738590072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ufvy3mF3xP5QvoI8bbkmKRvEZeesdZRM9S7AQRb0Ww0=;
 b=cYL7eJ8+u408DqLAOMd1ZdWMg4bMtpe0jbQJOXxe04UCFWin5wzO1aOdHa0E15ModM
 gdSmTr/SgFS5WLNoBKpobS+xWqazo3r5Azn3KrXVIYBTk8mJs9MfqbiaCX5cU1CgqLi9
 EmO8ZFfOjJ5Jte2OpXJ5sxFXkbTPtrusVTB+OuDuUyY/2qOA2RsIu9biDDF+vCu6YPvY
 rg0o9LYPRayQYzU16YnuhwfiZFN2AscxZvc6mS5bIuHkWWRTpzxCtike7fbSVktjvdYe
 /VBeURQAToHpH7JO4+BAa1ghJhCEjnALvevwILAiaSRwgZUaRcj8+fSw4hRctV9u6KFX
 ewYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDqY0oJ60JadNbe7KdIdV6kRAry6r6z1+pbr+KeVnJFbYVyYMFBW/5t6eJ+IYo+VcqK+mw7q4=@lists.denx.de
X-Gm-Message-State: AOJu0YwQZRN+gQ85m+zw1gkpv/F3omVq8g6BanFcizmOj4LfejqFnvU+
 0wNycJmS1IBz6+xgwZPIDwLvD88EODU0815D8eErJ7t/BD2BQ/JJ
X-Gm-Gg: ASbGncukWBjGP2PtrD84vPDcrFO4DBfuKebr2jTtCfI7R/BAeRJjQ+PMZnYk5Uc0Z+8
 i9tLyKmnYiSAeUZHPAzv8qlEGKyoerdzoBcWzwn6vryFZS64DAzw1DW8fdQL4LtLdMFlPSvxWwp
 s1AYgj0TjNpkzWg7244Sfk3GTYSQSWCpS1B/JZXeG2wAzXJaCRvVlcWypShreOFluzkFYr+2gpg
 HE9RCauuU/EF4yD/Z7qGq9xAPKidyEsVK7y2wC8ub1AYRSLFizvYUGwxqbB9z+aVu1u9S6AdJvF
 8O3MJ12JDwrzwAGnYfR+hFMtE+HaLlQCI7Dyw6kB6JwEGyhbGg==
X-Google-Smtp-Source: AGHT+IEjXzIa9VadoudWodFKtp8SZxJIUKqtSCtNrdnzjx6TZ3huMQj0Tdo8/LK+LrEKGyDdf8c7dw==
X-Received: by 2002:a05:6000:1863:b0:385:e17a:ce61 with SMTP id
 ffacd0b85a97d-38bf57c9b17mr35441005f8f.53.1737985271428; 
 Mon, 27 Jan 2025 05:41:11 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4199sm10873900f8f.89.2025.01.27.05.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 05:41:11 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 John Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 0/8] mediatek: final preparation for OF_UPSTREAM support
Date: Mon, 27 Jan 2025 14:40:37 +0100
Message-ID: <20250127134046.26345-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
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

This is the last batch of part to push actual support of
OF_UPSTREAM for the mediatek SoC.

The plan is to make the current downstream DTS on part with
upstream implementation so we can permit a gradual transition to
it while we don't cause any regression to any user.

This is to have the same node downstream and upstream.
Mediatek is working hard upstream to also push all the remaining
nodes.

All patch are the final changes after the pinctrl patch
merged previously.

All patch pass CI tests tested in this PR [0]

[0] https://github.com/u-boot/u-boot/pull/731

Christian Marangi (7):
  pinctrl: mediatek: mt7981: rename reg-names to upstream linux format
  pinctrl: mediatek: mt7986: rename reg-names to upstream linux format
  mediatek: mt7986: move gpio-controller up and rename pinctrl to pio
  pinctrl: mediatek: mt7988: rename reg-names to upstream linux format
  mediatek: mt7988: move gpio-controller up and rename pinctrl to pio
  mediatek: mt7981: move gpio-controller up and rename pinctrl to pio
  arm: dts: mediatek: add PCIe node for MT7981

John Crispin (1):
  arm: dts: mediatek: add USB nodes for MT7981

 arch/arm/dts/mt7981-emmc-rfb.dts          |  4 +-
 arch/arm/dts/mt7981-rfb.dts               |  4 +-
 arch/arm/dts/mt7981-sd-rfb.dts            |  4 +-
 arch/arm/dts/mt7981.dtsi                  | 97 +++++++++++++++++++++--
 arch/arm/dts/mt7986.dtsi                  | 14 ++--
 arch/arm/dts/mt7986a-bpi-r3-sd.dts        | 12 +--
 arch/arm/dts/mt7986a-rfb.dts              |  4 +-
 arch/arm/dts/mt7986a-sd-rfb.dts           |  4 +-
 arch/arm/dts/mt7986b-rfb.dts              |  4 +-
 arch/arm/dts/mt7986b-sd-rfb.dts           |  4 +-
 arch/arm/dts/mt7988-rfb.dts               |  2 +-
 arch/arm/dts/mt7988-sd-rfb.dts            |  2 +-
 arch/arm/dts/mt7988.dtsi                  | 12 ++-
 drivers/pinctrl/mediatek/pinctrl-mt7981.c |  5 +-
 14 files changed, 125 insertions(+), 47 deletions(-)

-- 
2.47.1

