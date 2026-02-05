Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67D6ECD9AF
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 22:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1F4483AA4;
	Thu,  5 Feb 2026 23:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fLwOTGqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244E58341A; Thu,  5 Feb 2026 22:13:40 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63C2183A64
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 22:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d18f80b5c2so1125246a34.3
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 13:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770326016; x=1770930816;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cQ6bL3c/yQxHOK9yZQSATHFK/k7FhLBO/jYkt1rlhvA=;
 b=fLwOTGqX+S3ZIjwB6YkhPSqPv7KnNsiyWFteMZislOkpreF2lYQnUjUbXTa3hJA/Ry
 jHRF99CUSYCBecsxhQJ0b4Tk+phEE0WUUetgppOJZyXeG8e0blI5W7p44bu4pnqyHxwZ
 kxLRhrEz2+qKilrjNjTLl3WnT+W6XBuGBZ98jkusEZFXfF1DgySNRjaBCOHvs1VmbilM
 ZbbYG/aAqg6lpibZQtY8ECU210JWm0sbhYJ74drcZweK2LkvvMn/RrUyWslGDjbdNkqE
 LoxIRIfCOTsAGQR+8blk35ckCyFSBF+wychwQVf536xb83SxVG2qtDo0G2J+hkmYdDc0
 nIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770326016; x=1770930816;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQ6bL3c/yQxHOK9yZQSATHFK/k7FhLBO/jYkt1rlhvA=;
 b=stKGkaL2R4eaCIFTRu58eSQ6cUQrOkvQmaK8rxY9ArI2AjtG6coiqy7Uy/yYLz8SDj
 druGbnSmsmpTJQpPdkW6EyUQzyn6g6/dgh4Rncx9PxKkoqDKoAV1lIqFx4itQgmlqcHW
 512zKHpeHIkrM4nl3N1obE3RmGkxFNwcqmWn1tqjqSkSHEXDU42d3/4gKKNRt9aTPK8D
 6PKtaX+q9Y8y5kFtpzWoPdFgtVh0W2r6Vf5KyfTgW+EYBEpAUqBIlQr/Q7QVr48ox1yX
 e4eBVTyQsGKiSM9Y+omYEAGP5mJRs6Oo/qozfUA0g7T5U6eb6hoerFFLPBHqCZ/ajWRp
 747w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH6fkPdkRQ3a5SawQXl93+prAFirPDrpCcTyT62n5SCFReNFmYHicFZUpBpxyUyWWMVWWBL90=@lists.denx.de
X-Gm-Message-State: AOJu0YxJfodZj3nwQewvyH58TY03G/s9Blb+f8raFEAFK5RWKKZR9jfl
 Ew5c1Xvjfcv/ehDkjv3wWnRIyfC6k0jhIt/C/a1dHNeEAb2OX5kAEVhl5ZUB3TfTyuQ=
X-Gm-Gg: AZuq6aK2v8oRcskUixB+hyF1Jqc21XwletykFH8tq55ra7dhL5IJew5e7y8nVETLKMJ
 98XN8Kce93uP+OTUqkyp3YxoMGE3qTQ5Pagv3zKHCd1FGq0ELNZxXMcUBcCPKGsHqY99QqAjOnU
 7jnjSu5WQnMuttEZTPay9vXFafGqvyM5QFo3iGdR0q+gVdR5FPbbVzRbmjsdLFn51kGQ7lNk44O
 nDEvfErpCBaZEwXrkegBz0MFGdJV46ziozqkc6HOi7RU6BUteZbhlEtjADYtGTSbAKz8Uny4Too
 +qo48PXvZOoyUG6cdQHgICgn9wD2u9tp43c7N2PgfaGaTg0ijB/a0Pmfbb8zl/ye7heAEo48gE4
 i4vTpiAzW9Q4TLx97qYAvlY7mkVZNBzxl9G1f4Z3DIS2wuxuIX6wY/ZZG7xpKNsd1hq2r/wiU47
 65KOUlgZYG0xTNs6k=
X-Received: by 2002:a05:6830:67c9:b0:7cf:d819:a2d2 with SMTP id
 46e09a7af769-7d46469b002mr180347a34.31.1770326015897; 
 Thu, 05 Feb 2026 13:13:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4647ab1cesm164313a34.31.2026.02.05.13.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 13:13:35 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/7] clk: mediatek: new mt8189 driver
Date: Thu, 05 Feb 2026 15:12:35 -0600
Message-Id: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3NwQ6CMAyA4VchO1sdcxhGjPE9jIfBqjYyhus0G
 uO7O8FDD3+Tfn0LxkjIoineIuKDmMKQo1wUorvY4YxALrdQUm2kkhp8uuapy9pA14fuymBL41A
 qbXXtRL4bI57oOZmH49wRb/dMp3kpPDLbiW6K7V9WYJ2bZFPNMvB9HENM8ChBQuXkWptK6U1r9
 q199dRGXHbB734/W8sIOTylpgiRzjSsvOWEURw/ny9UAyYA5gAAAA==
X-Change-ID: 20260204-mtk-mt8189-clocks-a19de024a48d
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Irving-CH Lin <irving-ch.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=DIIhcvokhkjXYa/7ks2sh32DrDgbWlEwP5D7+IcK9sA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphQfJZ3g3C/eqnRQUB/rfBq16EcBMuBWGfK0nk
 w0kh+qsgEmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYUHyRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A9ycIAIRhtCWVvo3oEiweZAps3c6ZZczytqEJIhcHVuR
 C3KWAOt4hQKYeUSljIRf+RfZaDY6UlQUTaGZtZaI6/9fxvvOSMNAqywLLn7HCwmj2Lysd6cNaeu
 WIfskXxZv3HjW/pg2ands32vkPQLH1fXBbHfak/aJqW/TWItmNVgYw1QR6YMXFPfmSAB0oi+ViT
 3f+r2NMN75GFU9gJStX3DZ+e1ON9hH9kc9aoOAwXUtB6Jf07h1e4IKpOmTtdk52bBevFqerxAvK
 TQ8LTvA6Dgrw2r3aZuNskicTwdLWa3ggchvfImachtDNrJaRoBAyEv1c6jAAsZcjHxIJdTX33Yq
 T6q8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 05 Feb 2026 23:06:53 +0100
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

This series adds a new clock driver for MediaTek MT8189 and similar
SoCs. This one has some unique characteristics compared to other
MediaTek clock drivers, so there are a number of preparatory changes
first in the series. And, as mentioned in a note on the dt-bindings
patch, this is simultaneously being upstreamed to the Linux kernel so
it will be a while before we can use the upstream devicetree sources.
In the meantime, we add a copy of the dt-bindings header file for the
clock IDs.

This series has been marked as depending on [1] to get the GATE_FLAGS()
macro and to avoid merge conflict with a Makefile.

[1]: https://lore.kernel.org/u-boot/20260202-add-mt8195-clock-support-v1-0-5d03495246b9@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Chris Chen (1):
      clk: mediatek: add clock driver for MT8189

David Lechner (5):
      clk: mediatek: use correct struct type for infrasys clocks
      clk: mediatek: refactor parent rate lookup functions
      clk: mediatek: add mtk_clk_id_is_* helper functions
      clk: mediatek: add CLK_PARENT_EXT
      clk: mediatek: add MUX_MIXED_CLR_SET_UPD_FLAGS() macro

Irving-CH Lin (1):
      dt-bindings: clock: Add MediaTek MT8189 clock

 drivers/clk/mediatek/Makefile                   |    1 +
 drivers/clk/mediatek/clk-mt8189.c               | 1738 +++++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                  |  260 ++--
 drivers/clk/mediatek/clk-mtk.h                  |   26 +-
 include/dt-bindings/clock/mediatek,mt8189-clk.h |  580 ++++++++
 5 files changed, 2477 insertions(+), 128 deletions(-)
---
base-commit: b5213bbfdcb1812be510427857827ee8becb9f8f
change-id: 20260204-mtk-mt8189-clocks-a19de024a48d
prerequisite-message-id: <20260202-add-mt8195-clock-support-v1-0-5d03495246b9@baylibre.com>
prerequisite-patch-id: 5dbe4461fa3456f3c7d80a7fa5a60d52bc719f65
prerequisite-patch-id: fac65a0526e9c15e8a4b3f81d85e61d1947dfe16
prerequisite-patch-id: 0d12fae50ce6da8dc7b0d978e4640431038d5904

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

