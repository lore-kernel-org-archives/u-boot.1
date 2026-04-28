Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7360FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E42783A91;
	Tue, 28 Apr 2026 17:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="aUG/WkIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF09084119; Tue, 28 Apr 2026 15:17:17 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E3C984150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 15:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso7979671f8f.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777382235; x=1777987035;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8UBIm7//4h/hFrqbl61MPT/2yqapNSa0c4sFhwqfFMo=;
 b=aUG/WkIxWwVgOB7C1Ff1xfi3V/Xp1WSGJH0hy3Ed5HKhSGKrpCHkNrqIIAQjU5IySN
 fy2P4CKtMRZ4TFZEUCDNV3VK1vPrMzCuYlVta9MawR2MFjfqyff21lvH8SQdPeBOS4pU
 eJiuuy0ghO9drQpxIVN6tyCQQQgZV21Fx204w1Jgssam3rCBz/mDDbGrJYrGpDK5Xk+n
 7oZCQKzDvkT5bzjEbozAplBwsWCWnz0Hmy6Ciw04+d07DJcP+nb0yzwgAnvUb1VzNvAi
 2JyXw0xfW0S2mc8jlbEWsdFWfmZy9pAoldDAqOyPhG0/r6jL80Z2JrNfbiuzsllACuHj
 NcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777382235; x=1777987035;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UBIm7//4h/hFrqbl61MPT/2yqapNSa0c4sFhwqfFMo=;
 b=h72/es1lm3/NW4GxeuBnZ0S/eTjsOjgYoSsNpn2cNY/WVD8ttbmbmW2Pu/Bazeq2RA
 iSTxTuK92OJFKc/Ji7TF6L9lNnjhUUH/vqUxMtl7tllpqwimBaitENewZFJvinPRZwDk
 Io2xs3F9n++PBjfHV3RZKDRw4AAoCd1ZzXFwkRYMnvjlUStahooZ32vv/NMKrV5FoGqq
 mvhN7Mhq3B9Jg2lkmu4vpaNPGnS6t1ZqTyB71AULVAcilsVvjORqHAk6khRPiIbxZ8Mo
 fWDiPtaXy/XmPyzL7/Ty6EG61oq7MHSkV1NzOFk4VJqXAWXfF5A07eZq8iiLQzmnngkf
 Om9w==
X-Gm-Message-State: AOJu0YxhXpDNrC9sFk4iBipBB4MEQMzfQhYzLs+KXWbkhPFsXmPlYI1m
 e6v+WsrPvi4YqNTewk3soFw8+rCTAHhzsVovotWCLY33FUb/AA//MIAbYku3+4kPvQQ=
X-Gm-Gg: AeBDieuBRKm6gq4K4ncLd5Os+O8+tNeW9/6iGXi1ol/WlsWD+OLiAhX2ynBmMpc1vTT
 md9wcF5q/kX6KvhrUfbr+W8oFEM4rc3mDMDssozaLdQmCq4yT1cAQGXzJ9qaXfynD9xT6CLjeCp
 ScBo8ObCtNGnpBmVvyICEwNaXhxnReKruYnhHyCDuTIBH/J9pd0v44cu+mvDEP8c5LMtMJnMOYC
 WjqS/5LDvHAN0EEdHeNcrMgAy2HEvh1ZbKFt68CRqH0gfFd9HZkpPBKNdBb2DhUCgTFAUK9xxbo
 6ht4NiXI6JEMbfO9/uEolBnHBwafcMMwGFS7ZL2BjQcDg2qhqpsWPpkQUPbmbtuG1XlDkNnfPiH
 jKkLIJpIVdB7wM9fSt+WostmrtBWW37Tew7EvXTE24o87x3O2AP8y/hhs+ucIkPGor0gaRUbl1C
 akTlsII5695nQo2x/dVEnNTvpkM2WOY2V6tWoacrvWdkH25RnP2qxKp6Ti4jtl0KUuxQF0YV3O7
 rvZxnoUx2Ec5lpakMo5lDkYv0TyQ/y7RkeCpYzWi0hpZdAbTbS9js1OkTHTMci8+hhchOtLswiD
 q5vz0PYv2UbqLjog2g==
X-Received: by 2002:a05:6000:230e:b0:43d:7a97:78a2 with SMTP id
 ffacd0b85a97d-4464aced4b6mr6224312f8f.28.1777382234381; 
 Tue, 28 Apr 2026 06:17:14 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d5ee9ecsm7139599f8f.16.2026.04.28.06.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:17:14 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/9] Add ethernet support for genio 520/720 EVK boards
Date: Tue, 28 Apr 2026 15:17:07 +0200
Message-Id: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQ6CMBCF4auQrh3TlkrVlfcwLAoMMIm2ZFqJh
 HB3K/EALmbxz+J9q4jIhFFci1UwzhQp+Bz6UIh2dH5AoC630FJX0qgKXNcBphHZY4L4mqbACfr
 AMKCnACctweaTqE3ZOzSldSKPTYw9vXfoXuceKabAy+7O6vv9Ebr8l5gVSDC2dRd1RimVvTVue
 VDDeGzDU9Tbtn0ALXgxBd8AAAA=
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
X-Mailman-Approved-At: Tue, 28 Apr 2026 17:00:38 +0200
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
Changes in v2:
- various code cleanup as requested by David in v1 such as: tempalte
  name, removed unnecessary defines, properly propagate error codes, fix
  indentation.. No functional changes introduced.
- Link to v1: https://lore.kernel.org/r/20260423-add-ethernet-support-for-genio-520-720-v1-0-47ca918e0017@baylibre.com

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
 drivers/net/dwc_eth_qos_mtk.c         | 444 +++++++++++++++++++++++++
 drivers/net/phy/airoha/Kconfig        |  13 +
 drivers/net/phy/airoha/Makefile       |   2 +
 drivers/net/phy/airoha/air_an8801.c   | 595 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/airoha/air_en8811.c   | 304 ++++-------------
 drivers/net/phy/airoha/air_phy_lib.c  | 216 ++++++++++++
 drivers/net/phy/airoha/air_phy_lib.h  |  39 +++
 15 files changed, 1585 insertions(+), 260 deletions(-)
---
base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
change-id: 20260416-add-ethernet-support-for-genio-520-720-0e243fae437a

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

