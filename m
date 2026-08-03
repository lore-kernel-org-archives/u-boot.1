Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2939BC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 23:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD39540656;
	Mon,  3 Aug 2026 23:21:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sQImlGs49Cvi; Mon,  3 Aug 2026 23:21:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD3DE40602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785799294;
	bh=dpER06LmWah9O8QQS+peMud1Y5IKrrv0tdI2FYeTn64=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sLjPNfbEBgd4EIr2YLsqaYzjlNStISHDRI+UI2J4f2ygdnGkT6EBLro3yMDmeMm1c
	 +qsNHVZJnliRXeYZvX6u1qV/nTiQibg9FToNB+mUu8BUHixl1PUsbDEOf7+NN4ZRhY
	 Kj8Y4YDdnCzy/GyzdUZwRIzRZBuQ7qS6Y/zUet9uSSpfHuXI6V8XCjxMR5+YY1XlfE
	 RgCezbwLM4r6IX4E8ZFnnhJmeeRTUmNEBL583y4vHCJ4mRHKCnEyOJ6TXJL1IUMbXF
	 6ybRl54w5659atWQDf9RNDOyzfuYJIe3az4aDmH2cv38TLzrxc7zHmh2kgnGcyKC+p
	 y3FlBFnwGIizw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD3DE40602;
	Mon,  3 Aug 2026 23:21:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D69D23F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F250606B0
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EZUeOncsGQ2g for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 23:21:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 05D1D606AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05D1D606AE
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05D1D606AE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:30 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6ae409c13d5so1751945eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 16:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785799290; x=1786404090;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dpER06LmWah9O8QQS+peMud1Y5IKrrv0tdI2FYeTn64=;
 b=V6H7oJa3Cj5LYTOPYBpU/rdO8qA1O+QEDkgRxcCyMnJbb0z6zEuovCy37tKGiMMxCN
 +bYeEHxznFTrSltQ2pnXJpMHy5VCUcT5fIJHaVkUP3Kzk88CPzFB4JMLjAQK2IWRMhlI
 6j258XM22YrWaz+ariQxSR1dJm47eUPNHtQuplTLHmXnMNqq4XTbelLWcGQzvPIx6WhU
 H/Q+8icX0s1XCgkLMicyFefhhHXX6wFMBM2ArPZR8ZogbKt3uOoJuPGIdDldyj2bBBJ/
 jUFEf4V2ZtOTQy6cJP0J++vJi/0cj5ka45h0LIUhMj9hGQ6vlhgLbIMcvBm8Y31Ru1KH
 oc9A==
X-Gm-Message-State: AOJu0YwaPkwy+xyJG7mgn5dgSdWpL14XT1vnPbo5UV6UQJbHeLbdKUJK
 RO3qvtGQb/7eqQl36H+7ZCqVsHrY9qwRDT7xmL0sqhyNvOQT1gEcQZzYhEbnJdh78XoweG04VNl
 cmtQ5kw4=
X-Gm-Gg: AR+sD13O21MJJUQKcD3wUBT/b2szMwk2dHCHns+LU/lW4iKsgYDO8exvCx25W48TUpQ
 OzbwdBFOI/z8CkicVia/C7iCnyipulsFYJWrRUeWAQl0fHH8WM3iD4DeLRzw00HqMoHi523As12
 727KbKkNIUfsiiLcYxtC4Qt5iBf1249KYWL44y2zSh0d6leEplhr6wDeCEJ5wLr0Q5AhF4JOwBO
 tWXnZCHbd3SNcsjey49OuFGIDGF8B/+2hpPW+MOvWFHQZfNABLBEbxKt1FjUH4JczO8bx27omgR
 PHaSef7K6DlcynK0tYZ6x3jn3BGJevloqGbMPkZclRB2n/Q9mNcsuD6RNn8BWFyYvSsZvEFoBxP
 UNe44Ft7c98Fker5yYA7PbglHqOy1rW7WqqN9ze0RqWnhDGEtudFxE6CR2sDdAMhAz6vJJO/R4m
 N2EW8mGKy5qFYPyDcHCMrF0jpgYAarPEkdWksGYqzPTOwr4ZcipYIKk3GESvj5WFM=
X-Received: by 2002:a05:6820:4df1:b0:6ae:33fb:4546 with SMTP id
 006d021491bc7-6ae432828e6mr18226681eaf.9.1785799289851; 
 Mon, 03 Aug 2026 16:21:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458f60df63fsm9440852fac.6.2026.08.03.16.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 16:21:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/6] arm: mediatek: Genio 360 EVK bringup
Date: Mon, 03 Aug 2026 18:20:39 -0500
Message-Id: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJLQaCVzEuaPtTBkIhbTEmh
 Ltbdfkt3jsoIQoS3auDIl6SZA0F10tFduyDB4srJq10o1rd8ZJn9giyct0oNlGC3zd2qA2c1bD
 djUq7RQzy/n0fz7/TbibY/J3ReX4Am+2KeHkAAAA=
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
 Irving-CH Lin <irving-ch.lin@mediatek.com>, 
 Deep Pani <deep.pani@mediatek.com>, Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3S+Ey2F1MSIFrh7wZ1vVbe6T3Q4xCbIi3BRPFywG7GQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcSJJgrxKZXb/+EpGBgmBQdSO9DWUP17PrPdY/
 03B8rJqo9KJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanEiSRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/APmkH/jGL3d3YNG5mZQkoiPHXTLaYUINjARTU9eO3N2Q
 gvfPAD5hcKfQ13gpoO1uku4eHw3/ElXA/ma6n/2EuX58VPGdpksmgCAoH/H/sqJmoR0/8R+vqja
 pPudcTZtSzsil2iS+JuDd04nXxZ8SFkT+vEiVK6wnr54e7HNh2U2TB8FiWriEk8mlSJNonvm609
 EALi9lBn0JB3Q639PkrjAmlm7wD9gYQ/XoBnxGmL9SLE42kHIf5DSTAVQY6v3QPsriM2yGBwCqv
 I3pWMkcZgHKlbOAzCnZ8Z5YQsbeplOnOnFDf7SD46KqcZsZ08Tu67PYHoX/IkmkzSg2MLcbTbYQ
 N1wY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785799290; x=1786404090;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dpER06LmWah9O8QQS+peMud1Y5IKrrv0tdI2FYeTn64=;
 b=PtTkU4hKL2pDWKfnpa+2Qv7Ouoh6RXTHpjE03lOl7e2q1QQJhos24bK+uV+olD4Vdf
 5ZyU58JhupRYGeDMe7HAh/++uOPmAeM1BeBOc5NweGsI1bLcEKsSp84dfj228Uh7yaQz
 h85L+PImCCe6McTunt7LeTabXtf+qCJUoyE3p/LJT2hTRutdpUIpqT1fn0wJ/RVVeHEf
 OtYrmWctt7Y9fvBMDsaous5ndMsoGlBkrKi8kqv9rM7EJDbrxfZphnH+jDzT+z1Ccjgb
 3SEOLsG4uM3GFsEHXoOEJAtidiVZ7s21XNGxGS6vvulwdrJAr3V3OHseXieXUJYw9wZU
 OkYg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PtTkU4hK
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
that is added as well. Clock and pinctrl drivers were sent as
standalone patches.

There isn't an upstream devicetree at this point, so most of this is
picking up the downstream devicetree along with a little init code
and a defconfig.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Chris Chen (1):
      arm: mediatek: add MT8366 application processor

Deep Pani (1):
      dt-bindings: pinctrl: add MT8366 pin function header

Irving-CH Lin (1):
      dt-bindings: clock: add MT8366 clock header

Macpaul Lin (3):
      arm: dts: add MT8366 application processor
      arm: dts: mediatek: add Genio 360 EVK
      board: mediatek: add Genio 360 EVK defconfig

 arch/arm/dts/Makefile                              |    1 +
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi      |  405 ++++++++
 arch/arm/dts/mt8366-genio-360-evk.dts              |   14 +
 arch/arm/dts/mt8366.dtsi                           |  662 ++++++++++++
 arch/arm/mach-mediatek/Kconfig                     |   12 +-
 arch/arm/mach-mediatek/Makefile                    |    1 +
 arch/arm/mach-mediatek/cpu.c                       |    3 +-
 arch/arm/mach-mediatek/mt8366/Makefile             |    3 +
 arch/arm/mach-mediatek/mt8366/init.c               |   58 ++
 board/mediatek/MAINTAINERS                         |    8 +
 configs/mt8366_genio_360_evk_defconfig             |   25 +
 include/dt-bindings/clock/mt8366-clk.h             |  342 +++++++
 .../dt-bindings/pinctrl/mediatek,mt8366-pinfunc.h  | 1069 ++++++++++++++++++++
 13 files changed, 2601 insertions(+), 2 deletions(-)
---
base-commit: 54930fd153a443a67fe56b89df16541048132513
change-id: 20260729-mtk-genio-360-bringup-de3bedc2ec94

Best regards,
--  
David Lechner <dlechner@baylibre.com>

