Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F74FFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4462E80087;
	Sat, 25 Apr 2026 20:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="KOTMY6hS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6ED784353; Sat, 25 Apr 2026 20:05:58 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A9784441
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-38ccde812ecso87867471fa.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777140355; x=1777745155;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/e2QtbKV8GmVvlOWLTLUl/R2JKl30hUDbgqT1pVpXuk=;
 b=KOTMY6hSOYVdX6HnyralABN3w9OtxyW5zxGpNry92vJvqOy95YN033LBCBfGG06OsV
 zA1dMswFgpxHPPQiCHt2eWG3uFMR/4fQBr9+jmMkR/+vM3Sp77arxT9xVOoO7LZeZovz
 Nvhv7o4D1xEI2Rh6hg1AQb+Lrv7wUaPpbRz3C1uMozqr2JCqrZHc211LONbOuOb/QV1C
 mwIZy6ieRG8teZfoT1V9iBl5TBIE3DQaRJkp/rcUsMA4B7VEXyIkSldKXmeidN+EFYVh
 pfZOfI5jL54lqeIs/xl079NvIgKz5SJwOiVmxZuS1U2LCW/vfInzZKVv1I2I1A7FUeaG
 Au9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777140355; x=1777745155;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/e2QtbKV8GmVvlOWLTLUl/R2JKl30hUDbgqT1pVpXuk=;
 b=Jj8ak7bM/ZePfyNKja/CGmLaT7ZC3868vbh+luV0zYMnw65JqytWkA2KInO8cXQTtO
 wopXQlBX07Ysz2bManwtQ3DtSGGojQHFX4VpDE4KQryCWmkWX6XOssPFynHUOfWfFdtI
 zxWr5s2HrDea/Se9NgQ6zfWsa9+UZmir+YoSp6zt74OI/q9MQsmCMoA3EdVdmHZ+eRZv
 gIAp0A+gD+06zQrvUBdQQQi154o8gy7Q/ie22ZHi5b75+u1dRHwYv5N1Cl+kKlee7MXh
 qZ4evGn27CaNaVMf3xQ68FuOsW7hvMlcoB1DrJqUFmyeHEwEmmCaIQ3rcAvmOcJeYb6R
 WUDw==
X-Gm-Message-State: AOJu0Yw8EyTV2boriaGf4A7ujfQkcWMqyYpaEU9IQjqMIFE799lga0ov
 H7bJ2EaVmo8ScPdNMqszIzUMe3naXE7/8o3noydM1XuwSAbqi6yyszEqetwtAzwdQ7/faUt7qeB
 ZpZUherE=
X-Gm-Gg: AeBDiet/oxCLE7wWN75kz4Si/FPzzP0jcy7Dt9mDQAHkxXxClr+Oy+JvpoRVSeE3q3g
 ADWHh92ekwHVArCtFD/qVK64hrxByCCqdvfrOQBd37HmakX7afyVeH6TNKon74Hci5i9aHXZtbO
 y8wGwlHqp4sogzEOgjNppWLZpJCDMBttTKauJKMED9dMZFdA6PJ3Zop6pTYo7/4Tfokm5Houvym
 Y9l3czYktkM4d3wquuUooH05pIppgpwadWcmqA83XAL8UxQmrUDj9Zp2UiQWu+BhkpgqdFbPNi+
 klsfDZaS+HDgH8d6gktLTHYMiqQ6LK03yePpn7PM8ZX1JTquszSheUs34HkPCcTalRJ6e1Gb3U9
 3pk7IK2v0hRTtoCUZgFkUgWwueln7dH9slL8lmJ11dye4IOs7JEj0vB+nOdLf2cTgUDW6WdNCIj
 3r569P9WkQg8GLsuAisBuQi8FrxJOKgh3E1pw5BeVFgaKrJGuk9SD+54zreE0UtBs1HjrD1f8WL
 MzfRmHuyAx9igO7wr+XxvLOFCxDPdRwNvrNT8QAFfy9p152Xm8gM34MAygKKL6w/UUlHNBywW++
 huOLjlH+hf2sgP4Ujg==
X-Received: by 2002:a05:600c:a410:b0:48a:5821:6006 with SMTP id
 5b1f17b1804b1-48a5821692dmr126439875e9.4.1776950755770; 
 Thu, 23 Apr 2026 06:25:55 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-56a2-efb9-07f1-cf08.rev.sfr.net.
 [2a02:842a:d52e:6101:56a2:efb9:7f1:cf08])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm500300885e9.14.2026.04.23.06.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:25:55 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/9] Add ethernet support for genio 520/720 EVK boards
Date: Thu, 23 Apr 2026 15:25:51 +0200
Message-Id: <20260423-add-ethernet-support-for-genio-520-720-v1-0-47ca918e0017@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQqDMBAFf0X23IUYUwV/RXoIzYvuJQmbtAjiv
 zf0MIe5zFxUoYJK63CR4itVcuoyPgZ6Hz7tYAndyRo7GzfO7ENgtAOa0Lh+SsnaOGblHUkyP63
 hpWNg3RQ93LR46rGiiHL+R9vrvn+lknTmeAAAAA==
X-Change-ID: 20260416-add-ethernet-support-for-genio-520-720-0e243fae437a
To: u-boot@lists.denx.de
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
 David Lechner <dlechner@baylibre.com>, 
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
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:10:03 +0200
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

This series adds ethernet support for genio 520/720 boards.

Particularly, it adds the following components:
- PHY driver for Airoha AN8801 (air_an8801.c).
- Synopsys DWC Ethernet QOS device support for MediaTek SoCs

This has been tested with a genio-520 evk board with the following
commands:

=> dhcp
DHCP client bound to address 192.168.1.44 (2246 ms)
=> ping 8.8.8.8
Using ethernet@1101a000 device
host 8.8.8.8 is alive

The series also add a new entry in MAINTAINERS file for
drivers/net/phy/airoha/ drivers.

I also took the opportunity to do some cleanup on MAINTAINERS
drivers/net/Makefile and drivers/net/Kconfig files

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (9):
      MAINTAINERS: remove trailing colons from section titles
      MAINTAINERS: add maintainer entry for air_en8811 driver
      net: Fix alphabetical ordering in drivers/net/Makefile
      net: Fix alphabetical ordering in drivers/net/Kconfig
      net: phy: air_phy_lib: Factorize BuckPBus register
      net: phy: Add airoha AN8801 ethernet phy driver
      net: dwc_eth_qos: Add mediatek support
      arm: dts: mt8189: Add ethernet support for Genio 520/720 boards
      configs: mt8189: Enable ethernet support

 MAINTAINERS                           |  13 +-
 arch/arm/dts/mt8189.dtsi              |  77 +++++
 arch/arm/dts/mt8371-genio-common.dtsi |  83 +++++
 configs/mt8189.config                 |   5 +
 drivers/net/Kconfig                   |  35 +-
 drivers/net/Makefile                  |  11 +-
 drivers/net/dwc_eth_qos.c             |   6 +
 drivers/net/dwc_eth_qos.h             |   2 +
 drivers/net/dwc_eth_qos_mtk.c         | 447 +++++++++++++++++++++++++
 drivers/net/phy/airoha/Kconfig        |  13 +
 drivers/net/phy/airoha/Makefile       |   2 +
 drivers/net/phy/airoha/air_an8801.c   | 614 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/airoha/air_en8811.c   | 276 +++------------
 drivers/net/phy/airoha/air_phy_lib.c  | 221 ++++++++++++
 drivers/net/phy/airoha/air_phy_lib.h  |  39 +++
 15 files changed, 1598 insertions(+), 246 deletions(-)
---
base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
change-id: 20260416-add-ethernet-support-for-genio-520-720-0e243fae437a

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

