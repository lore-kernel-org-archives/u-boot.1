Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B098DD1714B
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 23:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0165B89251;
	Tue, 22 Oct 2024 01:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="moggQYEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064EC88EAF; Mon, 21 Oct 2024 15:56:09 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A575E88E75
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 15:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+vasileios.bimpikas.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 84D45A43390;
 Mon, 21 Oct 2024 13:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51426C4CEC3;
 Mon, 21 Oct 2024 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729518957;
 bh=Cq311unnyEOsAEXQ+0MeodXiBtSZTdLSvvW0P9gzTmY=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=moggQYECAlk7EHGfycaH6elcjzQSD82KvnKK0B6CSzYAZX7vBrAtLUvgD+jHQPiiH
 2B1lCqL5JHC8q2iDb0SBdklAi0YM3QYRlP66KKgPlNWiDxTzwlRLIQXAyHLbPLD98H
 tkJFnyTtbGX5zwWPUMY4dUGtFgxquvRfEFV0QnSbog4nzpAy0dcPvHPqPEsA+ViIH9
 nL1KJ9l21BbFKZ9+vdTY5RZ9QtaI3PTdLkHTOle6Uwczkh+fOjGItimjhFdBBR1osX
 ykmFyDK6k5cDg154akQUXoP9Z2tYIDb3TT/7JIIvAIesA6uwzXdUwUutR6bKaPCey4
 GPxeHqc0q8dPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 40C47D15D9A;
 Mon, 21 Oct 2024 13:55:57 +0000 (UTC)
From: Vasileios Bimpikas via B4 Relay
 <devnull+vasileios.bimpikas.analog.com@kernel.org>
Subject: [PATCH v2 00/11] drivers: Driver support for ADI SC5xx SoCs
Date: Mon, 21 Oct 2024 14:54:31 +0100
Message-Id: <20241021-sc5xx-driver-series-v2-0-53e2472e11d0@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABhdFmcC/0WOQW6DMBBFr4K87iDbgICsco8qi8GMjaUYiO0go
 ih37yS06m6+Rv/99xSJoqckTsVTRNp88svMQX8Vwkw4OwI/chZa6lr2uoJkmn2HMfqNIhxlwB7
 t0Jqm7wYjuLlGsn7/UL8vnG1cAuQpEv6zGtVo1XRVW6pa6g4UuEiuDHh9JDxnHyg9UmmW8AuMd
 LuzXT6ogt8JP3Ys++Z1zDjc7mvKPBX87GDFbCY23BRIqOuxx9GOttLtGWe8Lu5vYMBEwHfw+VR
 sb2CpJERTi8vr9QPA5NlEJQEAAA==
X-Change-ID: 20240923-sc5xx-driver-series-a9afb7c598bc
To: Tom Rini <trini@konsulko.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Stefan Roese <sr@denx.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729518874; l=5307;
 i=vasileios.bimpikas@analog.com; s=20240927; h=from:subject:message-id;
 bh=Cq311unnyEOsAEXQ+0MeodXiBtSZTdLSvvW0P9gzTmY=;
 b=kUR/y1nq/tGM6RRoJBBPBbULmFUVQIU5B8h0bjGDK4XsW91H6DekUiPQDP8OzaklY0LhcpViM
 YXSICK01PUKCRrhAHtGgweIuRV3d+s2i1mefdk13KfDKfENUZ7B0uPr
X-Developer-Key: i=vasileios.bimpikas@analog.com; a=ed25519;
 pk=JkXh+NeXYCpTenwrB0gg5fMpKEnagLOXdsLFiUrqZRo=
X-Endpoint-Received: by B4 Relay for vasileios.bimpikas@analog.com/20240927
 with auth_id=220
X-Original-From: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
X-Mailman-Approved-At: Tue, 22 Oct 2024 01:45:50 +0200
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
Reply-To: vasileios.bimpikas@analog.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This series adds all of the supported peripheral drivers for the sc5xx
series of SoCs from Analog Devices and other drivers that are used by
the evaluation kits, such as a GPIO expander used by the EZLITE carrier
boards.

This series is based on my earlier patch series:
  "arm: Initial support for Analog Devices SC5xx boards"
  20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com
since both that series and this series modify MAINTAINERS.

Note that patches 05, 07 had Reviewed-by tags, but have had minor
changes since v1 so these weren't kept.

Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
Changes in v2:
- Address comments on adi_spi3.c
- Clean up some whitespace errors
- Modify Kconfigs to reflect changes to mach-sc5xx/Kconfig
- Link to v1: https://lore.kernel.org/r/20240515215837.14028-1-greg.malysa@timesys.com

---
Changes in v3:
- Rebased with current master
- Link to v2: https://lore.kernel.org/u-boot/20240925-sc5xx-driver-series-v2-0-ad9287c25c08@analog.com/

---
Greg Malysa (2):
      net: Add support for ADI SC5xx SoCs with DWC QoS ethernet
      dma: Add driver for ADI SC5xx-family SoC MDMA functionality

Nathan Barrett-Morrison (3):
      gpio: Add support for ADI ADP5588 GPIO expander chips
      usb: musb-new: Add support for Analog Devices SC5xx SoCs
      remoteproc: Add in SHARC loading for ADI SC5XX-family processors

Oliver Gaskell (6):
      pinctrl: Add support for ADI SC5XX-family pinctrl
      gpio: Add support for SC5XX-family processor GPIO driver
      i2c: Add support for ADI SC5XX-family I2C peripheral
      watchdog: Add support for ADI SC5XX-family watchdog peripheral
      spi: Add support for ADI SC5XX-family processor SPI peripherals
      mmc: Add support for ADI SC5XX-family processor SDHCI peripherals

 MAINTAINERS                            |  11 +
 drivers/dma/Kconfig                    |   7 +
 drivers/dma/Makefile                   |   1 +
 drivers/dma/adi_dma.c                  | 255 ++++++++++++
 drivers/gpio/Kconfig                   |  17 +
 drivers/gpio/Makefile                  |   2 +
 drivers/gpio/adp5588_gpio.c            | 208 ++++++++++
 drivers/gpio/gpio-adi-adsp.c           | 179 +++++++++
 drivers/i2c/Kconfig                    |   7 +
 drivers/i2c/Makefile                   |   3 +-
 drivers/i2c/adi_i2c.c                  | 395 +++++++++++++++++++
 drivers/mmc/Kconfig                    |   9 +
 drivers/mmc/Makefile                   |   1 +
 drivers/mmc/adi_sdhci.c                | 154 ++++++++
 drivers/net/Kconfig                    |   7 +
 drivers/net/Makefile                   |   1 +
 drivers/net/dwc_eth_qos.c              |   6 +
 drivers/net/dwc_eth_qos.h              |   2 +
 drivers/net/dwc_eth_qos_adi.c          | 102 +++++
 drivers/pinctrl/Kconfig                |   8 +
 drivers/pinctrl/Makefile               |   1 +
 drivers/pinctrl/pinctrl-adi-adsp.c     | 156 ++++++++
 drivers/remoteproc/Kconfig             |  11 +
 drivers/remoteproc/Makefile            |   1 +
 drivers/remoteproc/adi_sc5xx_rproc.c   | 276 +++++++++++++
 drivers/spi/Kconfig                    |   7 +
 drivers/spi/Makefile                   |   1 +
 drivers/spi/adi_spi3.c                 | 690 +++++++++++++++++++++++++++++++++
 drivers/usb/musb-new/Kconfig           |   7 +
 drivers/usb/musb-new/Makefile          |   1 +
 drivers/usb/musb-new/sc5xx.c           | 202 ++++++++++
 drivers/watchdog/Kconfig               |   9 +
 drivers/watchdog/Makefile              |   1 +
 drivers/watchdog/adi_wdt.c             | 145 +++++++
 include/dt-bindings/pinctrl/adi-adsp.h |  21 +
 35 files changed, 2903 insertions(+), 1 deletion(-)
---
base-commit: 041bf69038e2957f38e2de4e5d77bdb3e2ccf8a8
change-id: 20240923-sc5xx-driver-series-a9afb7c598bc
prerequisite-message-id: 20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com
prerequisite-patch-id: 184667bccb34335a943f5ba405bf2acd75b8c7f3
prerequisite-patch-id: aad9a1786ecfe51a46034fc055c57bff62d2a653
prerequisite-patch-id: 7640097fdc5a25ec2ffdf0eddb22f3c452510390
prerequisite-patch-id: 909e13e6d779858f6d862b703e7cbfe510cb3a16
prerequisite-patch-id: 0564b8079526f2fe1d9f723c8c4a2471e3ec6e1c
prerequisite-patch-id: 469d6193e82a2f702e938004ad6ff7c22dfbab86
prerequisite-patch-id: f6a45739e56120f54170b924a3069b98d355d1c0
prerequisite-patch-id: 24787a90e7adadab2ae3aa2348ac9d5838c26cfe
prerequisite-patch-id: 94e1c6fde429c63a6fa4f7b5aeab0df9a8a00d81
prerequisite-patch-id: 32d268fd6372bda3129cddd26da45d69291efc33
prerequisite-patch-id: f54e027ac323522349f24acbc4a946d8a3cdfaef
prerequisite-patch-id: 0ca62b4ff0cfd3bf5a10ac84f13d0ab261e737d1
prerequisite-patch-id: 8101423151112c3876c88223ac9ab196aebb8912
prerequisite-patch-id: fbc3b9227e2dc550878d4e8d113b1ad81ee00028
prerequisite-patch-id: 63cec707680793ef2feeb5b782b1db19d49766ce
prerequisite-patch-id: 6f85ade3b9119dba85b65da8a49c4a6345c6b3ba
prerequisite-patch-id: 988919879c6440227124dc0bb4b24d22c9041d99
prerequisite-patch-id: 3227e7bdc2614c377b6837a47ad1cde99791d794
prerequisite-patch-id: 10f9f40c697f22a33b83a8538e13bac642795851
prerequisite-patch-id: e57e6a95ef319c12565a6469f230198259f0bf7d

Best regards,
-- 
Vasileios Bimpikas <vasileios.bimpikas@analog.com>


