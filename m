Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8109FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 21:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E645984868;
	Wed, 29 Apr 2026 23:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="hWLZvf8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25D068485D; Wed, 29 Apr 2026 15:59:11 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B42C184832
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so9020829f8f.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777471148; x=1778075948;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zotNIFmN8B+vmR/7+z7d7PxLFTI4SFkLCdgte/voq9A=;
 b=hWLZvf8wQGU8jPh3JyZ7pvyRVPWWEP5bMzt5nK8mOQv+3fSiGyl7xZfyO52EuQ15E+
 dC5IwnuLfnihFaVohxkrQPVV+kV4/D40bOlEakDYX1w65PD9KE3UBoj0pe6gjow/P47U
 /k4E0Qm2+/VtQZKABu30RZmcNuivm4EK3IDGNY1LV3mWB07bBAp6ChXogay6hVpU0zKj
 jcFDexJTcivKXnKULgQqf6D+Nlt5TJkum8Sx0bq8UcgGE2H3Q3BaOa0wzUP7sXXETUSY
 q4P4SPDPR4obPfTYf8ds0jyIWrcdqGsf2b56mfbbuZRbMQD/ciygJBAsi5RSLpuxsi6f
 XgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471148; x=1778075948;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zotNIFmN8B+vmR/7+z7d7PxLFTI4SFkLCdgte/voq9A=;
 b=SFAgMuszXOlw932sO839zrDUWzjEz8SdOaZTv+s4jqjjDUS/GzPRCMOalIOHkRCzjz
 4hl+IwKsVrOtDB/NgJlLdfljKgPgNRWOIQ3Uz53yn6hBDwscau3T5siNG0pObNF7uY3R
 h+fNTPnecYGkx5CmUb3X1aPDKeYYy6qUjsGnls4Nc/N4KAcuJdR+NDulA+C8StDtebSf
 sdclVZ3wHTYspAN6LOafa6C8e22DLR/QCGRf4cIXBoDQME9v6xGcs14f4NvZjGStgIb1
 6bjwNDlVjptx/aiKozONVrjjMRmWoJFqUF26U0UcuXY7fUkpEhNsFGLjExGDF1xC71uU
 PzSQ==
X-Gm-Message-State: AOJu0YxIvZ6koj6DfWA9UbkT/BozaG0DqWSLkJSVm81DsVk6E8YDQmDF
 GVdi38EneMbLNfMc8hC4J7mYlp9IzmjW4v/cK+j9hxQj7x7SIpBS6PaVyS/HE8YKnPs=
X-Gm-Gg: AeBDievYeXmc8ZhDHXRSdYTwvVmYqU+pmLsVnnX+VDzqGJ7V5qnJujTFI/Gv0tzkOGw
 W9b84ia8sgmsR0OvJVUOn7d0CDPJYGalWHOrwkALl8+GMg0iW3KwU6cwq2UbreFPEmimlkE8E72
 YfSxyMqs62AKH3fOagpgqBoOAINT+UTNZPm+qxTfbsJYwLQT/Zodu2lN/zGH9kVhjhQ41SnihMO
 DpTee7juc9UNpfC6BGM2j8oAKJaxRyIDMdsjAq+IeVAEIQqameXa9eTtMuSgvxPmtzvhppraonk
 CBo0fhrsxTtT5C6SMIeziXW8rZR14QN1zTyOdtKlgOWHeUp04xtoafTv+W87RAw0S8uqgPJW+1F
 gY634MtCN7gWlc4CFd5N7dNaHwoQElnFVZ/FHJOiOIt1G5cUaPamXJP1zG/COVkk9VN9HP95JUh
 /qIpS4KAXmVQ1UCRY809v2Rp8TrI0e2/Mcr0RdAiisA3duzPu21o+8zCQlmuxi0CU9uvZD5KT0p
 XaUsnk1R4ia0fhKLPfnQ86+4fO9BbqTdvrzsy8kDSDi1fYEI1+lue6f6Tmo3KK5CVCUp/4pXBmb
 qVSiMW88I6eAZ4pb96E=
X-Received: by 2002:a05:6000:2088:b0:43d:714:34e5 with SMTP id
 ffacd0b85a97d-44790473b34mr6992070f8f.24.1777471147940; 
 Wed, 29 Apr 2026 06:59:07 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca64ffsm6289675f8f.37.2026.04.29.06.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:59:07 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v4 0/9] Add ethernet support for genio 520/720 EVK boards
Date: Wed, 29 Apr 2026 15:58:53 +0200
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NvQ6CMBSG4VshnT2mf0Bx8j6MQ6Gn0EQpaSuRG
 O7dahyMcWA4w3eG532QiMFhJIfiQQLOLjo/5iF3BekGPfYIzuRNOOUVlawCbQxgGjCMmCDepsm
 HBNYH6HF0HkpOoc5HkUthNUpRa5KxKaB193fodM57cDH5sLy7M3t9PwkutiZmBhRk3emGKaSU1
 cdWLxfXBtx3/kpelZl/y2qzzLPcdJZbqpRsjfoji2+52SyLLDNblciUkbaUP/K6rk/sJDJtkwE
 AAA==
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
 Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 29 Apr 2026 23:15:47 +0200
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
Changes in v4:
- Fix missing typo in  config name PHY_AIROHA_PHYLIB  in
  drivers/net/phy/airoha/Makefile
- Link to v3: https://lore.kernel.org/r/20260429-add-ethernet-support-for-genio-520-720-v3-0-1f65e18d4f54@baylibre.com

Changes in v3:
- Rebased on mediatek-for-master to fix conflicts
- Fix possible uninitialized use of tx_delay_ps and rx_delay_ps.
- Fix typo in  config name PHY_AIROHA_PHYLIB
- Use consistent dev_err isntead of mixed dev_err/pr_err
- Replace calloc(1, ...) by malloc()
- Update error message and return value for syscon_node_to_regmap()
- Update some variable name to save useless comments
- Link to v2: https://lore.kernel.org/r/20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com

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
 drivers/net/dwc_eth_qos_mtk.c         | 442 +++++++++++++++++++++++++
 drivers/net/phy/airoha/Kconfig        |  13 +
 drivers/net/phy/airoha/Makefile       |   2 +
 drivers/net/phy/airoha/air_an8801.c   | 594 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/airoha/air_en8811.c   | 304 ++++-------------
 drivers/net/phy/airoha/air_phy_lib.c  | 216 +++++++++++++
 drivers/net/phy/airoha/air_phy_lib.h  |  39 +++
 15 files changed, 1582 insertions(+), 260 deletions(-)
---
base-commit: 6c881e9980594a468e9f875187e5e4d30a22bcbd
change-id: 20260416-add-ethernet-support-for-genio-520-720-0e243fae437a

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

