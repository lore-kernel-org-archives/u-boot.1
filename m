Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC4CCD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E47C849EF;
	Thu, 11 Jun 2026 04:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ObMkxPyy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B7B8486B; Wed, 10 Jun 2026 22:29:58 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88EDA84852
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 22:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e615efd7d7so6594181a34.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781123395; x=1781728195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDny1MLSj2rUXVg2mRNqYLzG6qJCFEIie8IuDiYLD14=;
 b=ObMkxPyyfiw48ap7Wmaw8x95GI/2Jh+pzQzeZgbWo02eq28ui75qK+otcg3JEcRoKk
 8MP3lOA9jHTZ3FPJiSCGz4txSaWlNNlj30UwvDOws4VanIGERhYJhyJaf4AlTgylm23e
 VvATW6PWSI2LVAP0PhezVINZBWBySrQ/zXbrlldAsemyy4rWnKSsOKoXkfPmknNFlPSe
 7m7gZkHrZN9N1DuzvPcuktgoXrZg7UXlNRg+MaVm/y90Zp1cwYg0KbA45zng9ZvNZOxD
 mFXI1+b8wxuIw5i8lo4R3W18saAXmW1uoD2Nexv6vhMO+ALIjZMb9J1F9fZoFeQQ0EvQ
 WAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781123395; x=1781728195;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gDny1MLSj2rUXVg2mRNqYLzG6qJCFEIie8IuDiYLD14=;
 b=egGddkfHsv1OBFXYaQvCugE55XOJFfrbEhQrNh78nin3dMCp3OZKOYZ1SKdzfmCU6K
 Vb726RRMclf4oQjz3tNVXOkOIsQM+mCc5CLlrS0i7toYyBnXnQG5thp9t6dlvlRRXzcl
 ++u+VAf+YNfI5nKQqPTkqedomp5NWbjCe8V08yhN6IZDKsng3pw1y2g+hQKcHEs8iZqB
 RplLSrxXhuHfzVsT1swwdY536oYkHgep4sELrAfDJV1gb3EUEk2x3+v+5stbGqI1hMx+
 WpOXCEoWRD5lIF7XHaq9lS1AhF+bvunkuX/utfnH694UhJsWpWLYPBKlDQy6o5EPHFm3
 t9ag==
X-Gm-Message-State: AOJu0YypgWjCQXJkbGXmc2d2NfPHnYPc2WKZf9nJsZTs/PNTXcVYCEfA
 HIML6rbQBj/xrOuD3Eb4FiX82QphgM8eNvcO6FzlSVEsygm1ywfg7bOCcwFUl4OWoNQ=
X-Gm-Gg: Acq92OGB/3cN8VSl2wdT367plHWYvwWT64LGSxNInTAGX19Hv28DqMZ8kYNHDvt5HMa
 q9nrl6CsuwzqQOVZb1yg2iiwormrCK7P242/hWClKAPBgvfdoBc8kylQWWmrYPmBM8FwO2DvunT
 Jh72HEbJQ7M3bSwJ3GWBGQfgsB5F6geBAxl4cALnUFI5PHy2HVDNrO6dERGLbMG7WrvVKrWagtD
 RZ3jqSKNVI0DRhMwqUkZm8djM/hBUCIu/JjNQgPTZ81Sg5x9Bt8raGM3U3l7WbsmRPNZBvrOosN
 q10vCV5wSZ+V7VEFuIOuuh45xHg9evmPkQPsj1xlbgynWdyZpwZqFuYYgp+hhBTrNNnHwIkb30c
 3COB55CT7nAZT3ly2yfQCyM71GV6BTPILjlUsTVVLVMG4x2Ka3ealcmgmpNti06DXYrN0XL9z9T
 rYr26Hpk56UR9hpwmX7oqHAxgppp06J7ewQRLyfA==
X-Received: by 2002:a05:6830:3741:b0:7df:5fc:3fd5 with SMTP id
 46e09a7af769-7e70c5c1843mr20040561a34.1.1781123395085; 
 Wed, 10 Jun 2026 13:29:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d338:698:e403:61a2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75c5495sm17060551a34.10.2026.06.10.13.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:29:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Tommy Shih <tommy.shih@airoha.com>, 
 Kevin-KW Huang <kevin-kw.huang@airoha.com>, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
Subject: Re: [PATCH v4 0/9] Add ethernet support for genio 520/720 EVK boards
Message-Id: <178112330124.41254.12758901387556603723.b4-ty@b4>
Date: Wed, 10 Jun 2026 15:28:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=CMHFhVV013bvGE8Y5Rs3JRTFYWxQZVR0XE9NBosaqjQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqKck4/vl8JiW7k3lJpSAi0CNOb3gpid2Ncm+bQ
 Mr5ZBQazZeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCainJOBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AD5IIAJrpTqBT57J80x/r1n33aLzc3ZEN1/2GhqhVFqt
 AmWy47hWfzx7Sj9qboPFhVDWvVN6qrZtVU2+oyfbfmf+Qe8/nQ4jRpyLeaJ7RT8R0oUW7t2fGtv
 lxsJ/7rT1BHonHPrci8KtaLEhTTv9Gb1j/obNbJivcbu8Vv8X+MtvMlBMqWvFyCvRC0c+DtrUFH
 b30uQxHKjpBwqgCs/qX4Bd3e3EldicgppgYTZUlFS5hULwG6ETBBodPqTn1q8vEpgApcjU6k7Kd
 R80kBU0ozeqBAkXEesLUbbptxKWc2nIRjMBnUDRgpEoeS4T1gx4cdIYro19Y0zhXWWh9LrU9VJD
 yXfo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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

On Wed, 29 Apr 2026 15:58:53 +0200, Julien Stephan wrote:
> Add ethernet support for genio 520/720 EVK boards
> 
> This series adds ethernet support for genio 520/720 boards.
> 
> Particularly, it adds the following components:
> - PHY driver for Airoha AN8801 (air_an8801.c).
> - Synopsys DWC Ethernet QOS device support for MediaTek SoCs
> 
> [...]

There was a little bit of fuzz a fixed when applying, so please do double-check
that I didn't mess it up. And I also tweaked the s/tristate/bool/ in the Kconfig
when applying.

Applied to mediatek-for-next, thanks!

[1/9] MAINTAINERS: remove trailing colons from section titles
      commit: 45eec051ceff771cc79b17a34ddb2253d7bb87af
[2/9] MAINTAINERS: add maintainer entry for air_en8811 driver
      commit: 57b382e6093c1dea0d2c2a41053b0fa333b8896f
[3/9] net: Fix alphabetical ordering in drivers/net/Makefile
      commit: 379e9ab2d08328b81ed949b95aea244a823fe4ff
[4/9] net: Fix alphabetical ordering in drivers/net/Kconfig
      commit: 2287b573dffe86e26171352c819dc562c976d6b9
[5/9] net: phy: air_phy_lib: Factorize BuckPBus register
      commit: 751af7d98f0182f679cd1682c4b34421f94eb8c5
[6/9] net: phy: Add airoha AN8801 ethernet phy driver
      commit: 227243b67e6ff65afd7b1a16d9baed4f17689c0a
[7/9] net: dwc_eth_qos: Add mediatek support
      commit: 44f7d5945b324ba67dc0162a6eabc13f8f8d73ea
[8/9] arm: dts: mt8189: Add ethernet support for Genio 520/720 boards
      commit: 6a0804c87e6d214beb72a4e90d96a1ef23a3e44a
[9/9] configs: mt8189: Enable ethernet support
      commit: b581ec125a9f97404d38b2b85aeb1065fcaa2539

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

