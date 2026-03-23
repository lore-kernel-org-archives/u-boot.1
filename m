Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE55F483F7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 20:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 924F383FA7;
	Mon, 23 Mar 2026 21:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n6LfsLeU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EED08405B; Mon, 23 Mar 2026 21:18:06 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EAC783BE1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 21:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40946982a78so1409594fac.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 13:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774297082; x=1774901882;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V+VjZWS0p4FnqCe6zlupJYiEbXWSbU7a2IS2hrQHL84=;
 b=n6LfsLeUx3MlFj2H164Q/beq1zirxoMdpT8HzzxIhdW58bJvmNqKMezGaC0cWTManI
 z/A9MKWRv/0Zde0mNyQ78iW17x690BzLNq+kkglw2JhCMBTLgwBrFhPhhzG+pvZ94x0b
 5YFKYC2+fCBSEfS7xuhUL96WgWU2cNNrTbTjDtQuoS5IHRoVj9WoqLMNiO2mKHzBWFYA
 /uXDefrG8+waJ1eWwv4a2BPSXIC8MXYqionHIbOBOXnQPOay2FZ8NhsoxennKz5zvT8O
 JoXS5VXkAzxY7FXZBRjRP5rLX+LZK1622AQsgKl3O2G5dSdkcoGi7XzzcQBPXmY1s8wP
 FNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774297082; x=1774901882;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+VjZWS0p4FnqCe6zlupJYiEbXWSbU7a2IS2hrQHL84=;
 b=nQCou3gWILtFBRmLwC/6Rp61BOCUQaDYggdwZVvdYY69oNQ5UUFWUunuf2cBMNEWwh
 n8UMBaswamUadPWuKM0yJtqwvT42IrFOCVH9mhgYVSwlkp/FH51or4OHRqEoAAjpNGBW
 pjKUUGQHDOO2t7AbN4Qu5DkNzByHV2Tta3Gpr6nhfBIK8pNLtpfy0oVICxguhiH8Fe9R
 ssW20/GELGGT7Jjnncr2os9uf7dSKieofbLA5ADERsHLgym5Y5JkXT1sIuI4dMaSgi4C
 PdcIiIq22QWXNpgHeEY1ntfCzmmyLKk59cHlr7+3KraShgI24MTEP7jFC39svY6AhLmz
 rF1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2jCjZODlkIu8TSbdIJRH14xQkvNoBqqeEND5W34td/Ma+PsLVJNViKYb+88oCZPVmzVeYDUk=@lists.denx.de
X-Gm-Message-State: AOJu0YwFyr8adGtR/bldhP4xITUqxR41szLs4ZSAV/cpxiBhwaTJlR7M
 8jTCA3apPif0boFcHBveavC7L9ZXujDqQ8MNAbZ4N+y7WzcfBq04NH0U4EK/jssPCKXpZHL/El/
 es7MQ
X-Gm-Gg: ATEYQzxyBuX9SG2rbKgCBYWkBmCLDterebDBap1tcHqgeotMTsIAKQhR74gBUb04lhn
 pEwOp6QsCgzGy4qgdwDdeVZOhDA8H5QMr7zUZNeizXYN6vVWiYygObyWBJwqkQkOgEoo6Jlo8c9
 Esi3hCFTBcZjeiJZiGyCl1WjSfgF04Z2pqI4EUomsGFcslFye7zJyE10L3J04gT/ByQdq8Yoz0t
 vfb2hYr37+NEycFEvD4sRjWZ7q00YNQpwCBvpYQMFZPpp/fkDO6xnh6mnfh0u4XjiZff7bI4Gzo
 eSOFjh8xaGvuIx6NUzayygJi+dRR5HhrnV5S8x2tV6T120x1MepF9Y9onR22mrArWnEcUwzFLO0
 nvBPJgi1Xp87F1j5ZzaMT8RbPsOEI8KcBQzkULUKftkl8bxe85F9LiuitavOC8ZpXy38R7bjc66
 CrqgqPiwLtql0vSwXim9ToxAPkIRIBujy5/uXPRQ==
X-Received: by 2002:a05:6870:a79f:b0:41c:6bf0:6747 with SMTP id
 586e51a60fabf-41c6bf074f4mr2705371fac.25.1774297082212; 
 Mon, 23 Mar 2026 13:18:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:964:f712:dbc7:4119])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c148a5ca4sm11077540fac.3.2026.03.23.13.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:18:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/6] boards: mediatek: initial support for Genio 720 EVK
Date: Mon, 23 Mar 2026 15:16:51 -0500
Message-Id: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43S3W6DIBQH8FdpvN7ZQBSwWZa9x7ILvmxJFR2ga
 dP03YfYdNmyNI3RcLz4/YFzzkUw3ppQbDfnwpvZBju4VJCnTaH2wu0MWJ3qokQlRekDfTykl5M
 Gg3U2WtFBmMZx8BG4UlozihvMZZGA0ZvWHjP+8bnW3nxNKSOuP4vehCByxnbzmiMIZqC6Q46Zn
 G1P0E9HGIU3LgaYCSAQFaOorSUSHL1Lceqs9OZZDf3bEvoPiUjmFpYTWoP2wwi9GGHGkB7Wcqw
 Iq8vmQa657TBdBOZ8Bc0xegExrVQ3qENYdATUmIpVRPCK1g/pGN309dSpNMJN49WjmNVK8JYS9
 phHYLRORd9lMzVk3XVz9RDTmrBWm/88KYKBVPQ2bjeDtzvrXlw6aLG0c29DHPwpj86Mcz+vU9L
 cm5IcK0siZKORbKT6FZvlufzRlgu5p5VJw1pxWuqa16T8o10ul2+gtU+M5AIAAA==
X-Change-ID: 20260202-mtk-mt8391-initial-support-8ccdd761918b
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Cathy Xu <ot_cathy.xu@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5837; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=PSVIFfecyLqMPK/6mQqoLDD7Wtwhk6EwSQ+DJtYFo+8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwZ/JrvQCHLNEzOgxp6lLypz2qguoHst5RzLtm
 PCLYRsP+jiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacGfyRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A3woH/3zdBBjrGeUZHLhG0Md9l5oPWrURp+uVt7I8Eb2
 Yg87Af0wugdg3Mo4DLyLLoSJhHkYsIJsqFMGtlLOIWhx0ZU93xR9gV67YvSsLLtztjciA2vbOKN
 5CaWRjbc38zYwjN8Fx40k7cp4d85E93QRMq8FuGhUfMRg2iUhNYjMSS9X2xP3cnzy3W3EuTC3iM
 HMVCSsYZfDeMu8Lwd4UE82QCSilZq9u/3C6MkOMcRHwV3nQP4bs+VpuCaN1FCOKdgevm+49cwFM
 SX98O5PhdNc6c1tXQbpn6CyGBd4LiuVzRtdCBzGP4mLZsT0Sv6ur20D9uyYQ7IqCbVv9Jjh1QvX
 /m7Q=
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

These patches along with the listed prerequisites are enough to get the
MediaTek Genio 720 EVK board to boot into Linux from the eMMC (with a
bit of extra config that isn't included here because it isn't generic.)

This is currently being upstreamed in Linux as well, so we just have
some minimal devicetree files here to hold us over for a while until we
can switch to the upstream ones.

This depends on the pinctrl and all MediaTek clock patches from be
currently under review.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v3:
- Adapt clock patch to changes in dependency.
- Fix bugs found in init.c.
- Fix typo in commit message.
- Link to v2: https://patch.msgid.link/20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com

Changes in v2:
- New clock driver patch to add required clocks for PMIC.
- Added pinctrl nodes to both dts patches.
- Added "mediatek,mt8189-vlpckgen" clock controller node.
- Added "mt6359.dtsi" include and associated regulator changes.
- New patch with macros to support the change above.
- Fixed wrong CONFIG_PINCTRL_MT8391 in defconfig.
- Added defconfig and dts for virtually identical Genio 520 EVK.
- Enabled more config options for things that have already been merged.
- Link to v1: https://lore.kernel.org/r/20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com

---
Cathy Xu (1):
      arm: dts: mediatek: mt8189: Add pinmux macro header file

Chris-QJ Chen (4):
      arm: mediatek: add support of MT8189 SoC family
      arm: dts: mediatek: Add MediaTek MT8189 dtsi file
      arm: dts: mediatek: Add MediaTek Genio 520/720 EVK DTS
      board: mediatek: Add Genio 520/720 EVK defconfigs

David Lechner (1):
      clk: mediatek: mt8189: add some VLP clocks

 arch/arm/dts/Makefile                  |    2 +
 arch/arm/dts/mt8189-pinfunc.h          | 1125 ++++++++++++++++++++++++++++++++
 arch/arm/dts/mt8189.dtsi               |  301 +++++++++
 arch/arm/dts/mt8371-genio-520-evk.dts  |   11 +
 arch/arm/dts/mt8371-genio-common.dtsi  |  176 +++++
 arch/arm/dts/mt8391-genio-720-evk.dts  |   11 +
 arch/arm/mach-mediatek/Kconfig         |   11 +-
 arch/arm/mach-mediatek/Makefile        |    1 +
 arch/arm/mach-mediatek/mt8189/Makefile |    3 +
 arch/arm/mach-mediatek/mt8189/init.c   |   41 ++
 board/mediatek/MAINTAINERS             |    7 +
 configs/mt8189.config                  |   34 +
 configs/mt8371_genio_520_evk_defconfig |    4 +
 configs/mt8391_genio_720_evk_defconfig |    4 +
 drivers/clk/mediatek/clk-mt8189.c      |  289 ++++++++
 15 files changed, 2019 insertions(+), 1 deletion(-)
---
base-commit: eb00c710508d09b2a3b9aca75dd18280f1304703
change-id: 20260202-mtk-mt8391-initial-support-8ccdd761918b
prerequisite-message-id: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
prerequisite-patch-id: eaacb54acebe803c95a4416f9839632caa8bbe36
prerequisite-patch-id: 291f87bf8033440b0c79a03055cec7e1317216e2
prerequisite-patch-id: d3ff487de22ca508a65613bebf8cbe0e61005a31
prerequisite-patch-id: edb2b9a5644e0deb0b846cb6365957e8cdd9e9d8
prerequisite-patch-id: 14723a8815ed459c3995ba2682344f8c6813da74
prerequisite-patch-id: 5c528aa9c92e9d79fe406bca97192624f0267db9
prerequisite-patch-id: c5a12abe7b61f253d13966fc6b257995f085c7b0
prerequisite-patch-id: b4f5a8dafda57305a07cfc3783d7154558f515a6
prerequisite-patch-id: 9a33fdfe476f6dc0e9e314755073d308c6a61a1e
prerequisite-patch-id: 2daeb61c75b459c5c790266c329439a0fec5f50c
prerequisite-patch-id: 29f06542d7c519b8995bcebd04b800508cf32d1d
prerequisite-patch-id: 2d8a751c3012596e64b93e5361c7a50c8ac0a303
prerequisite-patch-id: 85f6c9b692293d482d04bb3661fb51dfb5533ef0
prerequisite-patch-id: 0700411359ab89ebd24c4c3d17a5864e41289547
prerequisite-patch-id: 688b2021a1585ae037c15081cf43e62d95e7c286
prerequisite-patch-id: 10f08bad47e8a2e6953c59540264dfa9ba433c1f
prerequisite-message-id: <20260303-mtk-clk-8365-drop-map-v1-1-17f81c375290@baylibre.com>
prerequisite-patch-id: 625ea8b616208d1c8a412ae514d8e94a3c13a6ff
prerequisite-message-id: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-0-6ee4743a8465@baylibre.com>
prerequisite-patch-id: 63670888fcc3abb762a182a7354216e2700a201a
prerequisite-patch-id: d8e4fd450697687889673ea835578739387d612a
prerequisite-message-id: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
prerequisite-patch-id: 7d34eacfb07b05743fdb6bc7f2e9eaf9412652ef
prerequisite-patch-id: 4e840545a5c629bb437265dadc3278ec7896af31
prerequisite-patch-id: c8207aef95f4fe0e7035f2b568243c2897b47d5a
prerequisite-patch-id: d15f4c079134f0e0c8d7521473553f55ddbf6dd8
prerequisite-patch-id: 8c3bac0b04e5662fda9520bb1c5903973e383c66
prerequisite-patch-id: 09064d21f1d8db557f5cb42dd309a71d540ec16d
prerequisite-patch-id: c4353fb375d509fc658dae60611dd2058d2c50c1
prerequisite-patch-id: 5a8dbab74fc01b66fa5e644603a7026d7b6fb392
prerequisite-patch-id: c918d85e92db8e23718728d9f1c236bbf6dd4624
prerequisite-patch-id: 640dad8f1295f5705873dd1727d819dbd69a590d
prerequisite-patch-id: 053e35bb1e211602195bebe16a5995d42513d904
prerequisite-patch-id: da039a34a16a3aa95c8dd06d9af08034f04bdf5e
prerequisite-patch-id: f143e3daade6b31a725f4001a22cde49511ced90
prerequisite-patch-id: 5c229cbb3c52f65cdcee9c49182461ad70c81156
prerequisite-patch-id: 81df2ad9f9ee0f14b2d286cba72e863a9f7bfbeb
prerequisite-patch-id: 979df31ce215fedc030fed831060a07a15e672d8
prerequisite-message-id: <20260313-pinctrl-mtk-fix-mt8189-v1-0-607dd37fde37@baylibre.com>
prerequisite-patch-id: 7c53e753d42d5c9bc0c804e448f44a38da849133
prerequisite-patch-id: 6ab8dac0c634a91d74a3cc470caa5310e0796e2c
prerequisite-patch-id: aed7fb93e30e9eb9037a13777026d2bf134a582d
prerequisite-patch-id: e5471470a7ca7c30b62189a59c2a79a7d45a7db8

Best regards,
--  
David Lechner <dlechner@baylibre.com>

