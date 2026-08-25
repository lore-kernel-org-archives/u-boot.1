Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB98C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 23:32:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BB1F40311;
	Tue, 25 Aug 2026 23:32:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mp48_t2AyWZG; Tue, 25 Aug 2026 23:32:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787700752;
	bh=EOUBAkwYq4bxAZSfHjZmaKmo9dnNTAnvYWPJ10do9zw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nHj1Mg/UCSuO632FIQ+vGpgx9S5kZppqxxBkpy4Qu+ol2f+g24PCn7x9U+AIagXFD
	 UbGOoROS3VMc/mhdBSj/L7m7aOSA7oHs4ZPMJqA4HS9xyQzRcvjMxCuOJYOQaTKwqP
	 wZ7OHVqli9yHCuPd6GavqzbX0eNUb6HHvu2hYg1hZBkytxyT+0MohQJg87DJpV8OVF
	 Lrk3M12koI1ldkOw1hOxmZD/8JnJyJSTShAs3a0zdTnvO+FAR7jum/Mte5ROWRiXKC
	 P7erLmrtd6GJ+rN4K/E8w19apWIVa9Y95rX37NukGCJt0xpLu5NgsaQwXDYsqcSitH
	 dQok6ZACr7c6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29200403F8;
	Tue, 25 Aug 2026 23:32:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 748853C3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F2CB40311
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eFcGyFn20Huk for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 23:32:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=HZqCHCs7
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7023B40401
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:32:26 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4a45b3f0becso377796b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787700745; x=1788305545;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EOUBAkwYq4bxAZSfHjZmaKmo9dnNTAnvYWPJ10do9zw=;
 b=HZqCHCs7Uk7zv/LLsT5erZU/NUweekEjRC3cgPDx/f5YpSUibzZWB8Yq9gTgPMIhrr
 73rbNTgODqA5OeirIQ9BvgyTod+GDWsyC+8o1wD0l8ErLj7cHd+bt+/jdkcTjf4VzFE1
 9sM22BIN3T/Ve0bL9BOb+m4wbnZMJMGP0kI5M2iyv5JgIfmd58c/Rdn3xXrQKdToiQ3d
 ZWILMiAQZccN5LnnEpkLV1bsmgmib1ln/uJ7w+Tww+cYzeMi4cyN4mEjcWO1LaafD/RT
 Y26paxq2luDVIt+Ja0V2e2HvnDGi4RJvEUnFwB4sJNafdjhXk6NBRNg6gcde+xqyZDrq
 PSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787700745; x=1788305545;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EOUBAkwYq4bxAZSfHjZmaKmo9dnNTAnvYWPJ10do9zw=;
 b=XC2ia5TgXaJ8LdqkjenLtvANna9PDpmfZkOF4I46TvNcQKymWdVevmY8zF2SIloJU8
 XglVKKz/8Uivhvtk0tLZ6eXtzCVBSJGp4C0EDjAIxVk5Cm+OuhdDNBqKc1PHqrL38Xxd
 vahVimhoKmjB8LoCPeOFwO7zbujNbyJzOWeoiUoqnH4TS8QFCuYzoK8mEiHeQGDloG8w
 tupCWQfOP3NkTCH8Zkt1OKeDVoDxxFxpTzhRVSLV0nCn9rbrlrYTW8uuQuHyRJojHLQZ
 NxbaSSHhfSYRuDJTkJH4Kul8GzrElNP2oix2d4YjR03plHDbOlhGvwSkf0NGB9Lp88Xa
 mPwA==
X-Gm-Message-State: AFuF++mUdbmewMmbY4vpVmybuIo0olTWrd2Xn9G8ZbUo4KNu8CNZpftE
 SnAnFTucY2XuSk6W4jX2OtoNWRPxCpy656L3eozGBPogc5r+7Vzw+Zwk0e51t7Bppc0=
X-Gm-Gg: AR+sD10jeEN6RedvxDWS+X3PGJOmCU9wPsOrsXYZXvBh49WJf/svxzsOtTeh0ZHQDx1
 mNytNvcN/gf5A0iHpcF6XGXHKXLWpNEmMdEzNrSPtZj2LPaDsy4Ez89FfC9MxbhDpWJnh5rAYjh
 jNoG2TS+MrFBH0HbdQg/ECYj23k6VWe6ruoFv3XFk8h/C3shDLw81YAjynWungdp/8XHnY4W9XL
 dvDMlvXs1iGPApkpk89k243uXo5jzmmkcN6CfkSY6HJTP6i2jhkHP+FXe0fWe0ybF0E0IJOECb+
 qEau1yHLFOIxQ9YBcrP0C/F40K7jBT0/pyCt0W2/OWvkGj5zr3W7VZRid0R0sxKGrON4tG2xfkh
 TnkozKfXWmXz5ZkhijtQQTxFtfJxvK9G/OmRoXpcSrAaL4lM88318ZbWs3pQgGGd2PsexsxBXQW
 ixDCPHTarDXz7MDqLYWWIMVwK8U7OKKxx8mmke8h4Q/N5pEn5UrZuzlnrvl0X2RVCy
X-Received: by 2002:a05:6808:c410:b0:486:8a11:6e8b with SMTP id
 5614622812f47-4b3666adaacmr3393814b6e.2.1787700745554; 
 Tue, 25 Aug 2026 16:32:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e96b:b637:f05:5bfd])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36ab734ddsm238211b6e.14.2026.08.25.16.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 16:32:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/4] arm: mediatek: Genio 360 EVK bringup
Date: Tue, 25 Aug 2026 18:31:45 -0500
Message-Id: <20260825-mtk-genio-360-bringup-v3-0-8e79e93882ad@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOzQ6CMBAGX8X0bE1phYIn38N4oO0Kq/KTFhoJ4
 d1t4WJMOE7y7czOxIFFcORymIkFjw67NoA4Hoiuy7YCiiYw4YxnTPKCNsOLVtBiR0XGqLLYVmN
 PDQgFRnPQxZmE297CAz+r93bf2I3qCXqIsrio0Q2dndawT+Jua+RM7DR8QhnNWAYQPklTlV5VO
 b1RWTjpriEx4/mvSO6JeBBJLXLBeCFNIf9Ey7J8AWQdsfgYAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2972; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Mc9XcqewUzRgYiEmfIDF8fT0Jhj6uMr1rHLStZbj7r0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqjiXl/d6FS6kVqVE6sXvERGJeVWrClZQNr0Td7
 reFGHAZVL2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCao4l5RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ad7oH/R0plUKwF9K1EQODAqEO3Mon8gWgEEwULDYxHF0
 xQFGcNKKs9ikggQNqwvTiMaXlkiH4OOQ13f9YdT24PsapRlQ/WTIBPacu0os8d6hnZP18+LTCrP
 ZkYL/EhyIMcXZ17eZ0XfL1nXT9XMAoFJPTO3B+Z8FsXfpNqdhhzLm+ftASBdaCtJGX3RGPYDnjn
 1dzESMaHRIFA+wKO6Lerojp+SjtyCjn6a8dv8ZFRCxBp1pU+/6KNT7hAI8DcO3JDEs6BLJ4guZQ
 unD6WVnLp1c3nbko767DNK0QWDhAAMtE1tjbKmdbfqpCTkwS9ST5HWfijWa7qgLjl8VYvZWpyxi
 zuIo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
Changes in v3:
- Dropped unused/unverified nodes: cpus, i2c and spi.
- Aligned bindings with upstream where possible.
- Added power domain, display and PWM nodes.
- Enabled power domains and dm command in defconfig.
- Link to v2: https://patch.msgid.link/20260807-mtk-genio-360-bringup-v2-0-7c3830297d97@baylibre.com

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

 arch/arm/dts/Makefile                              |   1 +
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi      | 512 ++++++++++++
 arch/arm/dts/mt8366-genio-360-evk.dts              |  14 +
 arch/arm/dts/mt8366.dtsi                           | 784 +++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                     |  12 +-
 arch/arm/mach-mediatek/Makefile                    |   1 +
 arch/arm/mach-mediatek/cpu.c                       |   3 +-
 arch/arm/mach-mediatek/mt8366/Makefile             |   3 +
 arch/arm/mach-mediatek/mt8366/init.c               |  58 ++
 board/mediatek/MAINTAINERS                         |   8 +
 configs/mt8366_genio_360_evk_defconfig             |  62 ++
 include/dt-bindings/gce/mt8366-gce.h               | 859 +++++++++++++++++++++
 .../memory/mediatek,mt8366-memory-port.h           | 263 +++++++
 13 files changed, 2578 insertions(+), 2 deletions(-)
---
base-commit: d8d8282337056483bcec9755abe6ff0de49efadf
change-id: 20260729-mtk-genio-360-bringup-de3bedc2ec94

Best regards,
--  
David Lechner <dlechner@baylibre.com>

