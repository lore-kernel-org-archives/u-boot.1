Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FC0C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD0F871CE;
	Tue, 12 Dec 2023 17:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VOeLBIA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D710A86FF7; Tue, 12 Dec 2023 17:20:56 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D8B2871CE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d2eea4af93so9822725ad.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702398052; x=1703002852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=71CicIzXruYhHqVXtV+UMJrTp9zqoZHpwyPC68+WRW8=;
 b=VOeLBIA8zFXpipna5DQcvtSx07hcWCM2sNc/EV6bf+flvTW4KdQwvtPaXrRQX7Fkbn
 qcrD4roZUkGqLg57LIllvAB0PfL+xBsz6IDzisXy48urNJfpTBrZYKId1LioURw392te
 q5DGNWKlBy5Ii0UNLWcAnsmbdCIm5IDBme4rP+qWg82bwlzdiop9qR1ZIxiAo1yXhqnk
 cC6RdR3BgwNsPZrHkfvdCUQKYuGZI4Dv1CivVZ3hPI7xMDb5wpcitfAQNMwC8rhcajnb
 SuFHBCIJFZ1djg2Gxy+AmgAR0j3NXVDIIgIl2yat47gZfWWtLNdYz2l+7F9A6bxvpJPR
 L+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398052; x=1703002852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=71CicIzXruYhHqVXtV+UMJrTp9zqoZHpwyPC68+WRW8=;
 b=ZVGm+/DSe5ronKshYiJ/i9A4QnLayc1aif0IBg8M8SOmCjD/y4yVOuYHFY5f+SsnSR
 VL4rEFnaddjH78D2geQIEYJYzb4Hvdv4xYMdWviL7rXMWaHeTXsklbFXGdO4FeRLPF6e
 DHIuAnOGCU+uoPgoYkgHRggtfKcJJSEgFDsQEMMEObyQjXdnN6tiVc6ePhlEFqlRUZGx
 qhVpARMknhjKtg1b/rlcrl5Sb0ugDwL25rMlFd0CxcMzWIlLNhjHnl9Ae9wsHLBu7dJF
 h8ywU/bW9EBhlFKS11HicvDqtYO1xgUt71kkI1KtZQFKOW+PJA+BfVZkqR+mntHFjSew
 Zf9Q==
X-Gm-Message-State: AOJu0YzGu489Yp+l8ZA5+dofV0xFBthLizFF+wdp1C9uX52dW2z1kNXD
 SWKRgErgt1ie4qBMDGAt1FQ=
X-Google-Smtp-Source: AGHT+IFWtl0R3EHjcdZW/AXrLN7VrXs9BnCJPnvUpnwPWbuUKdKwp7unHxDtG3bH8UJiAa2td/qcbw==
X-Received: by 2002:a17:902:ea03:b0:1d0:56b9:3730 with SMTP id
 s3-20020a170902ea0300b001d056b93730mr12423424plg.5.1702398051601; 
 Tue, 12 Dec 2023 08:20:51 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a620:342d:797a:5c59])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a170902694a00b001cca8a01e68sm8763036plt.278.2023.12.12.08.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 08:20:51 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: sbabic@denx.de,
	u-boot@lists.denx.de
Subject: Pull request: please pull u-boot-imx-20231212
Date: Tue, 12 Dec 2023 13:20:46 -0300
Message-Id: <20231212162046.744484-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

please pull these fixes from u-boot-imx, thanks.

The following changes since commit 65eed687729c28431d38c6c9174da4d878fb107f:

  test/py: Disable error E0611 in two cases for pylint (2023-12-09 14:58:21 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-20231212

for you to fetch changes up to d3977b130a91459592c040c0321479bd206326f9:

  board: colibri_imx7: fix emmc detection (2023-12-12 09:33:08 -0300)

u-boot-imx-20231212
-------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/18878

- Fix emmc detection on colibri_imx7
- Fix DDR configuration on tqma6 to improve Ethernet performance
- Fix aliases and chosen nodes indentation on imx7s-warp
- Convert pico-imx6ul to DM_SERIAL
- Convert pico-pi-imx7d to watchdog driver model to fix 'reset' command
- Select CONFIG_NET_RANDOM_ETHADDR on imx8mp_evk to fix networking on older boards
- Add USBH_EN gpio hog to fix USB host interface not working on some Apalis
Toradex carrier boards with Apalis iMX8 SoM
- Add PCI fixup for GW73xx-F+
- Fix broken EEPROM read on imx8mn-var-som

----------------------------------------------------------------
Fabio Estevam (4):
      imx8mp_evk: Select CONFIG_NET_RANDOM_ETHADDR
      pico-pi-imx7d: Convert to watchdog driver model
      pico-pi-imx6ul: Connvert to DM_SERIAL
      imx7s-warp-u-boot: Fix aliases and chosen nodes indentation

From: Andrejs Cainikovs (1):
      apalis-imx8: add USBH_EN gpio hog

Hugo Villeneuve (1):
      arm: dts: imx8mn-var-som: Fix broken EEPROM read

Marcel Ziswiler (1):
      board: colibri_imx7: fix emmc detection

Miquel Raynal (1):
      tqma6: Fix DDR configuration

Tim Harvey (1):
      board: gateworks: venice: add fixup for GW73xx-F+

 arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi       |  6 ++++++
 arch/arm/dts/imx7d-pico-pi-u-boot.dtsi           | 10 ++++++++++
 arch/arm/dts/imx7s-warp-u-boot.dtsi              | 14 +++++++-------
 arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi |  6 +++---
 board/gateworks/venice/venice.c                  |  6 +++---
 board/toradex/colibri_imx7/colibri_imx7.c        |  6 +++---
 board/tq/tqma6/tqma6q.cfg                        |  2 +-
 configs/apalis-imx8_defconfig                    |  1 +
 configs/imx8mp_evk_defconfig                     |  1 +
 configs/pico-pi-imx6ul_defconfig                 |  1 +
 configs/pico-pi-imx7d_defconfig                  |  3 +++
 include/configs/colibri_imx7.h                   |  1 -
 12 files changed, 39 insertions(+), 18 deletions(-)

