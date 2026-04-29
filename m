Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80050FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 12:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02EC7847C7;
	Wed, 29 Apr 2026 14:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="PlA5dgDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CABF84715; Wed, 29 Apr 2026 11:17:25 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED60B84705
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso137875915e9.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777454242; x=1778059042;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ENGbL8+38ymJ3/p15yqlnVRqhXdPfl6TLJQfZ50ZJUs=;
 b=PlA5dgDVD2Lbb4s9wFT07SMJrJug4u30yovRjV8EPsJtEB8OwZlyAxMZvEsFJ/CDJ6
 V56lSa71UapP3fz7ge+O1tu+wYwdr6+AHEFrY4tzms4M4mHSc1sWBkTeYSJzTq5q/CR7
 4GLlCiJFqpNM+bHJKC64Hh7ZIEAbSU2saa+o/SbZ38TZljlMMZsuu6LhcMk7EMCtUDUW
 17Kpou6b8J+/SJ1XGKIcjX0Zglna3SFwpkv42vx5z7YHFWdnRI6ygV0uQf9SrJy0fOzd
 LpqX/ELVp3I0Ow5Ljifs5Kdo7ipd3pGOBz6k+fcx5UhJPCFN9dGtAoIs6Q4evSVhY1K8
 xLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777454242; x=1778059042;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENGbL8+38ymJ3/p15yqlnVRqhXdPfl6TLJQfZ50ZJUs=;
 b=tD7rIvQSt4NljR2076lkV01vRGIc/s2q0JvPzmx8B44Uh1cLlWmQnMYBAJbFcO5rfv
 eVgX2+keWYc4Cg54w4OnoWSr2D6fYNSa3Gjnasu6aEExtb3TUleHHutWQEgWGd2djdqX
 uCKfU3LZlU3coZGvYQ7bHdhoFTSP0SjJHwqhPMCxbvJmMt61Yfz4w4R7J+oTyspyeYWt
 cYXvQtCwlEsFCziolV/FIDOnkgLEvwpSIRi+Q0TTbFm6VH07bb1afK3+apK4dMqWnmLG
 bpjgS3qdyBZJv1aOpjbgoc7LvK3tVvJDLvX1Zp/cKrE5lnOa97cILgxXL/+dyFzAI8GV
 cfig==
X-Gm-Message-State: AOJu0YxzUOkuvSkOGqQptKEQ53B0oLvwemTEdpIR/jkvB4LvJorGB6Lg
 UhV8srwfp23iWcVSEPdLGCy6ldxOJD39YA+PKZ8+G1JZzAgrlg9GR98eHOwkIt3tLqg=
X-Gm-Gg: AeBDievI5qoxiMLpUVTh0Et2GwyYcMvABvsYF7iOH6kguTQ7e+yk7FtewhQ4Htp5IMH
 jLYnyJlLcQ0Dt3vP3f+fqW++kuyjp1sikZjK+45FrJkUYona2pvQ5OYwAA+dMsjPRz84siAtJup
 FimOo2p2ueq6gbxq6jPUluvtDs/PXSthqgRZMosO0MGzXZdTPVlOQzpsy7Ek4nlhTEbYQitsbgX
 irAzyl+knh/mvXis0xFii/CK3QwztibEwXbRUDi5G4IGjHu8vp1IT1mmcglmCg8gALbiceD3O2l
 IahIpd+GnZ3LiCe9XKVZNNdlcP5/FZKs9KEYAd5vBEJ1fmSb/OLWsCzfIu8C+BZ1V2xz6NBjolZ
 W9pBKjtWZgUXCv9pfuQ5PxkUxRaCbv+iKThNJ5K93WKNPsui7R5zrU9EFFFw59gq4V6b/TbnZRj
 mmGDISwbtVqXQXol2RG4kiPXZiNkzoFf5MZ4nE3mA7iJhqMpO41nJLK4voSZzL+PPf4TRih9u7i
 02ogh90gHT1sgevUL65bHTpOvFn9RW6Dd6Ub18AuyVCbJ/xNn9BPCmIa/JfOnt5q9hBjAZb3wiO
 q22fxT9DOSQRWhVV
X-Received: by 2002:a05:600c:b90:b0:489:1e8a:90b4 with SMTP id
 5b1f17b1804b1-48a7b53ca8fmr51080605e9.21.1777454241942; 
 Wed, 29 Apr 2026 02:17:21 -0700 (PDT)
Received: from [192.168.1.64]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b9dee18sm44478375e9.0.2026.04.29.02.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 02:17:21 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v3 0/9] Add ethernet support for genio 520/720 EVK boards
Date: Wed, 29 Apr 2026 11:17:08 +0200
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v3-0-1f65e18d4f54@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NsQ6CMBRFf4V09pm2VKhO/odxKPQVmiglbW0kh
 H+3EAfjxHCHc4dzZhLQWwzkUszEY7LBuiFDeShI26uhQ7A6M+GUV1SwCpTWgLFHP2CE8BpH5yM
 Y56HDwTo4cQp1HkUuSqNQlLUiWTZ6NPa9hW73zL0N0flp6ya2vt8EL/cmEgMKom7VmUmklNXXR
 k0P23g8tu5J1kriv2a528yz+dwabqiUotHyz7wsywfKH/QgOQEAAA==
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
X-Mailman-Approved-At: Wed, 29 Apr 2026 14:40:47 +0200
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

