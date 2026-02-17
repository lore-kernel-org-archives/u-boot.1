Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A92DE9A03B
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 23:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E1E83DDD;
	Wed, 18 Feb 2026 00:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WY2Un7bS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A4D83CB9; Wed, 18 Feb 2026 00:31:16 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D1683C67
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 00:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4c4b494fcso2721379a34.3
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 15:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771371071; x=1771975871;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AuEk/EkOMYmJtnIVdxKHCddK6NMpZLsbbHGSFTmNN1M=;
 b=WY2Un7bSXPsRYXXQ4clnFJXmvjnXqrMqmVzyLCyl6X47f/2jsqgzkf3UbgSChCECYV
 9bpEoORKaBWbcTrNCaxaBVkyZP4HLYXwU1Dsa8aJdEt6a/Icb3CIVU81IK6HfuFYUxmx
 CA9ScrFDVZ/pp8YNn0pi4rdTJ1fYD5FWWySyiPpmJqbhEh/0noK8jTZkJlF3Uv/Wnesa
 WpfRIGm1oM7+BRL45s9nPzAMQKbUBBtEK6XfSEpKlFtfnRQbYS+MCxvs0sqSGmFtiH8+
 Ax+Ww/bwDEUtJCea5GEiUbzi5COmphw24Uek4L2vrKkIKxSl7hzyGdhHpUoFuy7kgaXU
 QOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771371071; x=1771975871;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AuEk/EkOMYmJtnIVdxKHCddK6NMpZLsbbHGSFTmNN1M=;
 b=d/hHeezj/sdA6zxaGtPGLTWfdLrNJz9O5E6lv6xJu6DzdF+gjYm6qZ8haY6Od492vo
 c4oX1aP4lzPi80oiOzk02x7eVGJzsAiFi7SL9c8zwHoSiOok7BFDFpFGaUHGJtSi4zVW
 /ARuxY7XzZSceaI/XCRnYor4oq6v+ptzCvZUFOJjXwnyPznbliyh0D3p4iC7zHOosbE0
 /ovHMUmK0KMzmSIJl5kGKxkBW+4Gx4qRy0gae85I4wLDjaYEiwoGini+ELfDMuFGKt9J
 L6ozCrQGnWEiFUk+GOZrikaUUVAavPz/buL5/FpvT5Znhth3fO1YdMEJMU68UeybNdMn
 xngQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5VNFnK++kkENb6TyDmNF3nF2LzO2skOgtceccWmdEShL/yk/rQ/6SvCxJKth/3PRkZNmMCZI=@lists.denx.de
X-Gm-Message-State: AOJu0YxzREKLGIaR0UhHVEjnBV7sqLPocXyBjTVRHz0da4CqWTxK5oWS
 vV9bSxHiJ0JvwPNCn6gYThUfkckbgK4UXYF+aygtkguzCuqJwC+A/cn429EdNjwjhsI=
X-Gm-Gg: AZuq6aIKEGbo2JnKtHPdipY1D+1y2DBIWxo6kvlUjPfawwDONqk7soCSgTZBPGSS8qr
 sab2m5RoywDPC6Xq+sTgPJ0L34UBMmbc/Mm3Aau5GF7wDFIIY/4H6R7m8wmgJu+rloN8/BdH+oA
 WEHUIc7GgEsRQRyCgFoAHuKMknCHVtqg64z9dUJ1GhAM9jnrkPt3yU7hcbAhp7VGXJD8U9Z6bnF
 K6YOZMAeh2qmKk6EAMxakzdYI7OzI2pre6NoBjLciIK2+Uv0Q41thzkL7o6i3icQOD8BJi17DrI
 9m0lOsTgYL/yviMthFev3ihyhYzS0T2XXLRyFnPl9VJshRKEnYv1ofnP8AQIXjBaV3no1okBJzu
 rUfiBEmX5WqyjpIFADvaWpAExfSp1ynT9EAPuOz4NPnVynwSXkhgCmhEYM4FqB28WpMIHzBDJuz
 NO3h8rpZrNwgmb+sItiGYEpTbalA==
X-Received: by 2002:a05:6830:6d07:b0:7c7:565c:4ce0 with SMTP id
 46e09a7af769-7d4d0a935bfmr6575315a34.1.1771371071492; 
 Tue, 17 Feb 2026 15:31:11 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8c6:5b3:8109:1f08])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4c7288d34sm11122198a34.18.2026.02.17.15.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 15:31:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/7] clk: mediatek: new mt8189 driver
Date: Tue, 17 Feb 2026 17:30:07 -0600
Message-Id: <20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22PQW7DIBBFr2KxLi0mODJWVOUeURYDTBOUYFyGW
 I0i370EZ1Opi1n8kea9+Q9GmDwSG5oHSzh78nEsQb41zJ5hPCH3rmQmhdwKKRQP+VKmb3vN7TX
 aC3FotUMhFajesXI3JfzyP5V5OK454fetoPO6ZAGJoKKHZvciSw7OVbLuVjKn2zTFlPnccsE7J
 zZKd1Jtjd4buF+9SfhuY/h8Og0Q8hKCz0MTkz/58SMAZUzs+cLZU47pXlvObf3hpe3+KVR9xoB
 VQm+klfDHx47LsvwCjmrHTzgBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=GOSbO0t+fAH889qqa/0/w16kBNaqu41d4TYSSbITGII=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBplPoIHE2unqCQvaW5xF6G3hbf9haQdRMBdcEKR
 KoouyhloteJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZT6CBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AmRoH+wT+L1Pf1+ugcnKf8jRhcvG++MchfjhqPVlX/zk
 moGEr25SCCPUYz970DY1tOG7NfeyygeCF97nipDnFhYgqY/mDelua4Qc6cunlj3k7mUDDDqcCLF
 wrBIb7OAO7yiysiV5B/FVrWcX46eTZgc+XDry+KR89L5ypQMfldPs7s+5WqZCon9Og0NCQ7bIk5
 HSoeaF0SSfKRRsAeytC8+WjMKp2m5uGeEJ+kX50wVSpW6aNbWeyHdzgYIhyZ9dqCIqVOxqlY8BL
 Uoq6Sc+GENUZozoyzhfqThHwWz3NysOKc6DejfNp22zUwiq63JQ6qrkresiV6Iek/CDPuuKC/Lv
 ynvU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
Changes in v2:
- Fixed CONFIG_TARGET_MT8189 in the last patch.
- Link to v1: https://lore.kernel.org/r/20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com

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
base-commit: 8666b16015d4212facacc514e2eb626f3630dcf0
change-id: 20260204-mtk-mt8189-clocks-a19de024a48d
prerequisite-message-id: <20260202-add-mt8195-clock-support-v1-0-5d03495246b9@baylibre.com>
prerequisite-patch-id: 5dbe4461fa3456f3c7d80a7fa5a60d52bc719f65
prerequisite-patch-id: fac65a0526e9c15e8a4b3f81d85e61d1947dfe16
prerequisite-patch-id: 0d12fae50ce6da8dc7b0d978e4640431038d5904

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

