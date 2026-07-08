Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D44C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50067849F0;
	Wed,  8 Jul 2026 19:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="XBpX0Dfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC9984A04; Wed,  8 Jul 2026 15:07:04 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8718849F0
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 15:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493e8d4f4dcso1420985e9.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783516021; x=1784120821; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QLK42WOXbhwWhEaDyigxROqmKOM60cA56zyk3CSL9s4=;
 b=XBpX0DfcePHZBibJT2C2oK67qbqfHkqs+ve6mcAj/veq/HzSaDI1qxTqKKDRNRUI+S
 /FPqLW0ZyK1JBvIsTGTfE+utsFC6NSvKcWNReY39yPUByem4UYzzXY8elJKEyemgEG8j
 n3u4dvuGbttME3wq6SaAMMXpG1AfI9yHAnR+2FKDjifJ8e3VuqezLU69Z5PoU8IY691W
 Wj+oRSTCWKiqBJ6EpSPCuDS2+itj0LD4HBOr16413P0fXjwPeCccV3LavObrHB+nzibD
 WnduzXzckLDH/2Q0CH7kLAkM8PdatuoPkvPtWIdvDY8A6lR5FrCRw5EHjJPw6AWg+TFU
 8AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783516021; x=1784120821;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QLK42WOXbhwWhEaDyigxROqmKOM60cA56zyk3CSL9s4=;
 b=H5rR9X+KWVZa0t6keR47sJ3dKy4Kf5W0RpHOZ42w0PjG9Bzac6TEQsVzFvHcy6Cb2O
 ZiUypnlA7VGTDbX9n4MlQ6gWiHCcENLmYvHuJcYNBktB94xCEkTSSDea7Zhagq4/VfTI
 muZO38CM+hqNkjxY9/voLYkd7dv92BnZC5GswtvlwCWu11c91fykN8QNG03bJ8/4hpOs
 5yOCLuO2RSeuWas8EebH5w7fOmycRvOaqEbUbsOsfEdlwNIphbdXWQFt3+wLQpo57L5O
 YwMO7MGsRB/oAmuHzfPhlb3gQGNEcfj0Tqyf1zLTygCxdYouwnjbAFbzx7jMDClxIhzn
 c8iw==
X-Gm-Message-State: AOJu0Ywj/EV9sjRpymHebvKRDhg5vepsTInTmA4Rh1tPo+I0y/o9ZN2H
 RuzVt03xGGLWLml+jibOMLjSA9BgT1qvFm1LwT88s6eZ9B8y4Gmy3jsyX4xAJBg8LoQ=
X-Gm-Gg: AfdE7cle1tt506xdUStarDffYhiQPFYwhRxsASMlyrhL4Xdl4XsBscs8O5JA4pAbTL7
 8PkkuPSuUeGq11JKTvcFP57cvVSMW041h0eva7rR3qp1bIOkceZmh8OPpHpwbLsA5zEZuYH8Lx/
 tKOr47Nvm7PEHdSIPZcpI8msJ52rj/1y4YkMxqWXHBqarv2RUZDOZ4gWz+U/m0wreY/FzZZUlow
 RVXnr7vj0PlSShdcG619Cs3AB7FQLYozv9GasXHSIgyFk/Kt2dRHlDggG8OIWzsBOfT5luxH+n0
 z3Sks/NASZBalttkLgNGIZGAcTLoWwqJVWcZrLmYG8QYEgyQVM8EexXIzzU+3HkZ0OUYVKtgCjY
 AwaY3cqbCZqNhB4HWJdzUz9wHU2L/rWwee1BddeGlErykpzIy0PX8y4ggKe4TSc6pTxL1eo30GE
 vV/vjZAsB3SvtF4i5j9/74JgwQue1mZtx7i7EJyVyRHvafbCgReMtUkp7Eg2cs9FoIq93gftyUG
 yS8MIp+jLHsQOznwsM1lvEeZLlk/6uQRN+UDV+F4pqN87vdGPR29Jzh
X-Received: by 2002:a05:600c:34d1:b0:493:a5f9:d33d with SMTP id
 5b1f17b1804b1-493e6891cfcmr25299345e9.18.1783516021091; 
 Wed, 08 Jul 2026 06:07:01 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm49000664f8f.17.2026.07.08.06.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:07:00 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 00/12] power: domain: mediatek: refactor driver and add
 MT8188 support
Date: Wed, 08 Jul 2026 15:07:06 +0200
Message-Id: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWP3W7CMAxGX6XK9TzFoRtpr3iPiYv8uJ0Habqkw
 CbEu88UJl8d6fPn46uqVJiq6purKnTmynkSwJdGhU83jQQchZXR5l1vtYG0WLQWXIww5wsViDk
 5nqC1dtDBROcoKtmeCw38szZ/7B9cT/6LwnKveyYKfZ/k5PKIKe8qQcgp8dI3FjVSNG/tFu/pR
 LW6VadvnjL4LxOOh1Uoca08jcI5HECkZnkuDCO4DGcEmQ3qzmPXmdbuvPs9si/0KhfV/nb7A+Z
 Es1UMAQAA
X-Change-ID: 20260702-mt8188-add-power-domain-488f0c2daaed
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sam Shih <sam.shih@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 08 Jul 2026 19:36:37 +0200
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

This series adds power domain support for the MediaTek MT8188 SoC, used
by the Genio 510 (mt8370) and Genio 700 (mt8390) EVKs.

The existing MediaTek scpsys power domain driver is a single file
driver, that supports MT7622/MT7623/MT7629 SoCs.
MT8188 is much more complex and adding it to the current driver will
make it really big and difficult to maintain.

The series is organised as follows:

 - First, some cleanup:
   - drop CONFIG_MTK_POWER_DOMAIN from the defconfigs whose device
     trees have no matching scpsys node. It builds only dead code.
   - remove the enum-based per-SoC dispatch, keeping the per-SoC
     information in the match data.
   - keep the Makefile and Kconfig sorted,

 - Then preparatory refactoring with no functional change:
   - prefix the power_domain_ops callbacks with mtk_,
   - split the monolithic driver into per-SoC drivers
     sharing a common core (selected through a hidden MTK_POWER_DOMAIN
     symbol), and wrap each SoC's domain table in a struct scp_soc_data
     that also carries its size.

 - Extend core driver:
   - rename the flat probe to mtk_scpsys_probe
   - add support for the power-controller model, i.e. per-domain power
     status register offsets, ordered bus-protection steps, per-domain
     clocks and parent domains, and a probe that walks the controller's
     subnodes to build the domain tree.

 - Add the MT8188 power domain driver and enable it on the Genio 510 and
   Genio 700 EVKs.

The existing MT7622/MT7623/MT7629 drivers are functionally unchanged.

Tested on Genio 700 board.

Note: when booting the following warnings are displayed:

  mt8188_power_domain power-controller: power-domain@22: failed to get subsys clk at index 0: -19
  mt8188_power_domain power-controller: failed to add child domain: power-domain@22
  mt8188_power_domain power-controller: power-domain@30: failed to get subsys clk at index 0: -19
  mt8188_power_domain power-controller: failed to add child domain: power-domain@30
  mt8188_power_domain power-controller: power-domain@24: failed to get subsys clk at index 0: -19
  mt8188_power_domain power-controller: failed to add child domain: power-domain@24
  mt8188_power_domain power-controller: power-domain@21: failed to get subsys clk at index 0: -19
  mt8188_power_domain power-controller: failed to add child domain: power-domain@21
  mt8188_power_domain power-controller: power-domain@13: failed to get clk at index 2: -19
  mt8188_power_domain power-controller: failed to add child domain: power-domain@13

Theses warnings are harmless. They exist because the clock driver is
missing some clock definitions, such as audio. These clock definition can
be added later, when needed.

This series depends on [1] to fix a pericfg-ao clock.

The new files added by this series are not listed in MAINTAINERS: they
will be covered by the pending "MAINTAINERS: Replace Mediatek with N:"
patch from Marek [2].

[2]: https://lore.kernel.org/all/20260617024105.152655-1-marek.vasut%2Brenesas@mailbox.org/

[1]: https://lore.kernel.org/all/20260701-mt8188-clk-add-missing-clock-in-pericfg-ao-v1-1-13109b199248@baylibre.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (12):
      power: domain: keep Makefile and Kconfig sorted
      configs: mediatek: drop unused CONFIG_MTK_POWER_DOMAIN
      power: domain: mediatek: remove enum scp_domain_type
      power: domain: mediatek: prefix internal identifiers with mtk_
      power: domain: mediatek: constify scp_domain_data instances
      power: domain: mediatek: split into per-SoC drivers
      power: domain: mediatek: wrap domain tables in struct scp_soc_data
      power: domain: mediatek: rename mtk_power_domain_probe to mtk_scpsys_probe
      power: domain: mediatek: rename struct mtk_scp_domain to mtk_scpsys
      power: domain: mediatek: add support for the power-controller model
      power: domain: mediatek: add MT8188 power domain driver
      configs: mediatek: enable MT8188 power domain

 MAINTAINERS                                |   1 +
 configs/mt7622_rfb_defconfig               |   2 +-
 configs/mt7623a_unielec_u7623_02_defconfig |   2 +-
 configs/mt7623n_bpir2_defconfig            |   2 +-
 configs/mt7629_rfb_defconfig               |   2 +-
 configs/mt7981_emmc_rfb_defconfig          |   2 -
 configs/mt7981_rfb_defconfig               |   2 -
 configs/mt7981_sd_rfb_defconfig            |   2 -
 configs/mt7986_rfb_defconfig               |   2 -
 configs/mt7986a_bpir3_emmc_defconfig       |   2 -
 configs/mt7986a_bpir3_sd_defconfig         |   2 -
 configs/mt7987_emmc_rfb_defconfig          |   2 -
 configs/mt7987_rfb_defconfig               |   2 -
 configs/mt7987_sd_rfb_defconfig            |   2 -
 configs/mt7988_rfb_defconfig               |   2 -
 configs/mt7988_sd_rfb_defconfig            |   2 -
 configs/mt8188.config                      |   2 +
 drivers/power/domain/Kconfig               |  89 ++--
 drivers/power/domain/Makefile              |  15 +-
 drivers/power/domain/mt7623-power-domain.c |  85 ++++
 drivers/power/domain/mt7629-power-domain.c |  60 +++
 drivers/power/domain/mt8188-power-domain.c | 665 +++++++++++++++++++++++++++++
 drivers/power/domain/mtk-power-domain.c    | 576 ++++++++++++++-----------
 drivers/power/domain/mtk-power-domain.h    | 131 ++++++
 24 files changed, 1352 insertions(+), 302 deletions(-)
---
base-commit: 8101ed2547180109903e9c7a2ecc8e0679c7ec35
change-id: 20260702-mt8188-add-power-domain-488f0c2daaed
prerequisite-message-id: 20260701-mt8188-clk-add-missing-clock-in-pericfg-ao-v1-1-13109b199248@baylibre.com
prerequisite-patch-id: be920ef2f5c93fb8111072d8fb30411d227a52de

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

