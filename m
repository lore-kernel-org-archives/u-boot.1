Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278C4103E2E4
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 22:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 211AF83F9A;
	Wed, 11 Mar 2026 23:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FycQ1wBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AE7183FA4; Wed, 11 Mar 2026 23:02:14 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C810683952
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 23:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4673790ab85so272479b6e.3
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773266530; x=1773871330;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/4t8KnvUh5qt9QoqSklvNewf4Lm9BdjMSl8W1SNDcH8=;
 b=FycQ1wBZ0COXdk7R7wySfBlV7hLlsEdX7okF70RJ2wOazp8wDQKAo4qATubOXJGSm4
 DbIvd61OqDz4H56lqdExEln/+EJoBbB1RgVVaVLXXSg59b1m4NM01IKdRaPa0PvDDfcX
 AKRAENVssOYrJ8NyEqeKB+8SSRv/hF7i5hDdAz7AuizEKK39twkIDphIdAnzwB2br0t2
 thn/5jCkLYbu2nOSlHkhywJp8GPCjSSnP5QDeI6kEF8vcBZhuFeJUMG7nLUyIKwFu19w
 9Xo+Z09W1aMhLE1zGldJ8SwzSDJN2gnvLIYG7KUjAN4pd40lpf8InbAZtxlB2iGFJTOd
 Sehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773266530; x=1773871330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4t8KnvUh5qt9QoqSklvNewf4Lm9BdjMSl8W1SNDcH8=;
 b=APg6QXnuZFySaetrlS1EYAUnapDFR5c91luQl85U/BAY891BFJ2fld7ibcM163R4aB
 yGw/4YHUfEVBGeMwCZxye7knPhREiJdGQpnJDZ7cmXTxyq4e0gb4/kdqpVVr9dXpMi0Q
 C0RojweEZORZMolEzgKtmOFgqU4kx768UsdReKMo7YbqBKvdJ2BzD5q+3HbzqN6FxzNJ
 ORyvLRLBk+6uwPbA0EpAQMFlDTWg26cYUEDq/QsmgjR8a8YVcwNIFmJCpX6CtYc7ylDP
 yxQyxGoUyqFG7r6UAwazqMxGYaxcifMgCqVO/KIe2OHFXOGGx2i5hm4Ad/RtB1sdxapA
 C/eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN6NLOt52VXnh+QO5WClyQ16k9BE157K/EzfLhFbcPvpbMbXJr3/xt60IutqVgSQljd3T7Vso=@lists.denx.de
X-Gm-Message-State: AOJu0YxQpzstFpLEC6fVDZan/EcR05aRTjoIgolJGc2ES2+iwzjzcxMv
 zk4neXSCn4mng5x3qUyg0WTJFaq0WL+kcW3ES+f9AjvG4Jz4ogr2lDRhxWad6rONWAI=
X-Gm-Gg: ATEYQzzJHWxZofYpDsMhwY9oXNUWlIlw9XulgmBm0zMrw17kPuK48Nixk5Q1+JoVPCP
 MHW7whwPxVQJryx3u5DNwqosxvKwM5G5nuNVtKBZKUDiUejEYAbWvhZJFXLg+RuKcvMQDEG8mv/
 P7rc5waeBFHmsEYwh+F+7VgukUgmNkg0zL9b+GrjtsA5IZ4KGeB9h3vPV1Zvf47npbRT1M7raR1
 cv42hKbc6wKliAlpFTdDgEFq1DEDpbnuZdLCsB1ZALSiK/C2WOzuQwp9J66ZD4V2YJApsW+1ius
 1Hvkk9Yl0tzLxqndV+nJhNiaN/uhLGrMBYrxmcOeYo80u/zxYj4NRM+osFpGGvW3F0HO0z+QdB0
 tpKGQo0G9k1pxV5i8C6dvPrbHHl0wYr1jSZUJ86L/4x3KszndA1hA15A/Q8nr/PCYIXSllzlfMx
 DmpHF6qB5SRerWxk2gH3agXGT1Og==
X-Received: by 2002:a05:6808:23c8:b0:467:26b9:d990 with SMTP id
 5614622812f47-4673355e749mr2192537b6e.47.1773266530131; 
 Wed, 11 Mar 2026 15:02:10 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:82ac:f3fe:2e5f:ec03])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-46734340842sm1963830b6e.18.2026.03.11.15.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 15:02:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.denx.de,
 Julien Stephan <jstephan@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-next-2026-03-11
Date: Wed, 11 Mar 2026 17:01:12 -0500
Message-ID: <20260311220131.2526133-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
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

The following changes since commit c0ca147ac6228949a6d6497531c9f2f4a0dc6c67:

  Merge tag 'u-boot-imx-next-20260228' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next (2026-03-02 13:44:46 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-03-11

for you to fetch changes up to 05677fedd6fc7716a9b2366b3f19d32c80bfbfd5:

  pinctrl: mediatek: add support for mt8189 (2026-03-11 10:44:27 -0500)

----------------------------------------------------------------
A fix:
* Fixing compiling MT8195 due to some independent changes that were applied
  around the same time as MT8195 support was merged. (CI would not have caught
  this since we didn't have a defconfig until now).

And few small features:
* New defconfig for MT8395/Genio 1200 EVK.
* pinctrl support for MT8189-compatible SoCs.

----------------------------------------------------------------
Bo-Chen Chen (1):
      pinctrl: mediatek: add support for mt8189

David Lechner (2):
      pinctl: mediatek: add bounds check on number of base addresses
      pinctl: mediatek: increase max number of base addresses

Julien Stephan (2):
      arm: mediatek: MT8195 fix mem_map
      board: mediatek: add MT8395 EVK board support

 arch/arm/mach-mediatek/Kconfig                |    2 +-
 arch/arm/mach-mediatek/mt8195/init.c          |   21 -
 board/mediatek/MAINTAINERS                    |    5 +
 configs/mt8395_evk_defconfig                  |   26 +
 drivers/pinctrl/mediatek/Kconfig              |    4 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8189.c     | 1276 +++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    3 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |    2 +-
 9 files changed, 1317 insertions(+), 23 deletions(-)
 create mode 100644 configs/mt8395_evk_defconfig
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8189.c
