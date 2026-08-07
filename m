Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D46C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1968810CD;
	Fri,  7 Aug 2026 16:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZJhrCA_BHlLP; Fri,  7 Aug 2026 16:13:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AE7180E2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119213;
	bh=aN1BFEqt9oIFX3EdQcb0WqAhl4LjErOpsWJfCgWi6Ek=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cCUAWCnf2iH7dLxrFyxnTmBQPOYERYP7Dt8eXn/eCzsvs116qZNOOHGsT4oj9F+wC
	 otpxzckkZ3RuPFIA1oaVo7DuVEJ2lZCOQKY7+4VCX+75WBn13rJymrrWV3bws+WhL1
	 6k7scHbt+Kuw4EbxGG/UQBYqBWARBnFZE/2aZPLDiyIfynFaEz5vuhFpIJQgCxtEjH
	 yYeWMCeVwA/zsyFvn7RGoywG14lVDDf8BYTHJmJLjP6p9F19nG7Ms3TqTuHYOW691a
	 vBACn6aZG/aaqi1vdvsSmRtBO8JvrPFTeuj1aNhoUiqbIVaJGws5pixBalQDjpNZi0
	 UjiitkFb4a9+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AE7180E2E;
	Fri,  7 Aug 2026 16:13:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FD93D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9F9B607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V58f9XmOkKo9 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:13:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7F06F60684
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F06F60684
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F06F60684
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:30 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9fc3de7ceso1807575a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119209; x=1786724009;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aN1BFEqt9oIFX3EdQcb0WqAhl4LjErOpsWJfCgWi6Ek=;
 b=IogHOUbaWApoxwl1f2pxe3vMLWqdJSgqoLt+XzFnEeWsvvMXjlbGVFR6Wlzxp5wqop
 cDFq0DBlRnEV+aU12WBPjcb0Qta4yuM+UKoKjiJRhuhz0s2Xq+vZ5Pg73iewI2YdVkBe
 p4BneOdm2Gkplo0dgtXB2PK8n23Qs883sTeyWXo8gSY6q8wUI60iY5lwHIDpBjoKNYr3
 u36cbn+Zi/A5MGbV3lMMpkpx7Jv6ZGTJ/GAi0uoW8+gHGak+RnaMFbAQ3zm/xn+P6vz1
 OC0D31W9OkR7V87ULGpARgrVwO1T4GNqB+Yi0GlYixuFcSJPwxQy3caf47jRaVs3eeto
 jeqg==
X-Gm-Message-State: AOJu0YwNkfQMmG9Ht1BkOSK0aBhY5dow9s3FrI07Ib3iEJuy7a6rJFKO
 LSNlFkr8N9ThHEmRY29GrmY9fklFcuhGNn9PTiavKVXcOViKrSXgHFC88d8AJmhRFZs=
X-Gm-Gg: AR+sD1186fK7AeED+d7cFSB9iRCygz/wVpSGS07jUrn2AQcnqp2QpJg5v1Arjm9yxK+
 SVJ4ZW0YXZtpTCUK3oIprJfVp0v9bVspSr3GwoiMxCtWu1iWGkj+Cii/1xKbGoSKk0GQkmbbfIp
 wt2irxe+2rJ3ogkY2H5nM9IroW4EPLSr0AbNbM2s/snr1E/Imk88hwwDVcOLNpGL8HwG8QP6itF
 CpQf3T2ev6CYK0NMLo0hYbHMbc4O9EP0OQZhrRqIBw820piUB2rb3Is/JFICpSXtvGlHJi8tA2u
 i3HkzB0oXFCR/vTB/XmwkQmcVfKRjfwm2/bBJX8hQlyDC+XL3lXYrr/9UDLiQyykdSntnySJbU8
 wK2lDr4rl4l0E0utObOhrPXLLFdVksm29O+32EdBXHiRF+1YxvKm6gzR7K8vK+LvhzRZM9AhJhn
 3DN6YncufzUcppIUC5lAqqMVSh/sppRiG7Vw9r+P//IVNoPgioRTulWZSsZRAqmvSU
X-Received: by 2002:a05:6830:448d:b0:7e6:d54e:8fe3 with SMTP id
 46e09a7af769-7f36930b186mr756060a34.9.1786119208989; 
 Fri, 07 Aug 2026 09:13:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b7b9678sm1537878a34.21.2026.08.07.09.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:13:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/4] arm: mediatek: Genio 360 EVK bringup
Date: Fri, 07 Aug 2026 11:12:50 -0500
Message-Id: <20260807-mtk-genio-360-bringup-v2-0-7c3830297d97@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOwQ6CMBBEf8Xs2TWlSBVP/ofhQMsKq9KSFoiE8
 O8WOHt8ycy8mSGQZwpwO8zgaeTAzkaQxwOYprQ1IVeRQQqpxEXm2PZvrMmyw1QJ1J5tPXRYUaq
 pMpJMfobY7Tw9+bvtPoqdw6BfZPp1bE00HHrnp008Jmtud1xF+scxJihQCUUUn2SZzu66nD6sP
 Z2Ma6FYluUHDDUph88AAAA=
X-Change-ID: 20260729-mtk-genio-360-bringup-de3bedc2ec94
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2462; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=gyhkFbE/OXNQaYPLRR3F0Hslv/1PYL8/FO8AFPl0nQ8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdgQGRlDUKV0SGd6hmavSNSNmqFRBo4Ja7cWfp
 AaYnN6Ko0OJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYEBhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A/u8IAIIygx5X5WaJUHdgZbJC2R/NlYLDYoc7sXUN+5y
 HDUA98yZ7Vf4bU+kDdbbA+/ZAIHhX9lSoHWz0IgyRzI7PeRVegZMzPRZ9o8NGqx2UhGOGHOCPLx
 HHTn6agfFDkwll5zS834dbgFmkdkFFTGzZyfWVF3cxtoK0d5LFU5cqCDrU+u2PHNwiPMj7j09QV
 KQ6bGUk27UQ6nbguPXt6eR6HqSK1v2Dka7buPBCnQ5tNEyLullG7g0mRx5+9VULtu9Cb0lxgTaM
 9uNlTnu7EM6P4zV10jAjzY23ptEehlLf0xrUWCiHQwbPrcg+0J1hSLYKv3G/S2XmLu+MWBndEFY
 gybs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786119209; x=1786724009;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aN1BFEqt9oIFX3EdQcb0WqAhl4LjErOpsWJfCgWi6Ek=;
 b=FB84skiRCj8+EEcexWvdHzOKDyJymQIllXUMz/IIxGLoaV+OVDB9vsDMm69eDJAGkE
 jHM4YWmJ6eUMdR1oXp5TCD5bQC5EpqbbjF1QPArHv0eA/zXf6WktU+3Kl9W+CPnn2ifW
 8qoKJCjaGwvOBFsrtssdNp4AShQpThjhjl12fZRL4BHOQsxZqPj6PwV2JcHfk9wtVh/a
 Ccr9z4zYLnWTw7kqisS04K4yi3Ky4iR2Ak7K+LU6ys/L1wpFY2nRm5amonJj7W0mpj3d
 Eb4skbxvEH3pkHwGg9UDGCIUV/WSNKr5RHDEQSPFxBCKlVG9h1yt8vaIwBF5G+R4rGKY
 5L3A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FB84skiR
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series is doing a basic bringup of the MediaTek Genio 360
Evaluation Kit board. This contains a new application processor
(MT8366) that hasn't been seen in U-Boot yet, so basic support for
that is added as well. Clock, pinctrl, net, phy, spi, power drivers
to add support for any missing compatibles were sent as standalone
patches.

There isn't an upstream devicetree at this point, so most of this is
picking up the downstream devicetree along with a little init code
and a defconfig.

This has been tested on Genio 360 EVK booting to eMMC, microSD card,
and USB storage and booting from eMMC and SPI NOR flash as well as
testing that networking is working.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Updated devicetrees to align better with know similar upstream bindings.
- Added nodes for mm1, pmic/pwrap, snor.
- Added more options in defconfig to enable gpios, regulators, phy, net,
  snor, usb.
- Dropped clock dt-binding header patch (will merge the one from v1 with
  the clock driver patch if we don't need a v2 of the clock driver patch).
- Dropped the pinctrl dt-binding header patch (will send with pinctrl
  driver patch v2 instead).
- Link to v1: https://patch.msgid.link/20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com

---
Chris Chen (1):
      arm: mediatek: add MT8366 application processor

Macpaul Lin (3):
      arm: dts: add MT8366 application processor
      arm: dts: mediatek: add Genio 360 EVK
      board: mediatek: add Genio 360 EVK defconfig

 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi | 564 +++++++++++++++++++++
 arch/arm/dts/mt8366-genio-360-evk.dts         |  14 +
 arch/arm/dts/mt8366.dtsi                      | 698 ++++++++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                |  12 +-
 arch/arm/mach-mediatek/Makefile               |   1 +
 arch/arm/mach-mediatek/cpu.c                  |   3 +-
 arch/arm/mach-mediatek/mt8366/Makefile        |   3 +
 arch/arm/mach-mediatek/mt8366/init.c          |  58 +++
 board/mediatek/MAINTAINERS                    |   8 +
 configs/mt8366_genio_360_evk_defconfig        |  59 +++
 11 files changed, 1419 insertions(+), 2 deletions(-)
---
base-commit: 97fdb6113084797d6e5640fc7c60f4349460fb5e
change-id: 20260729-mtk-genio-360-bringup-de3bedc2ec94

Best regards,
--  
David Lechner <dlechner@baylibre.com>

