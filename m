Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B60CCD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 23:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73EE584974;
	Wed,  6 May 2026 01:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timmermann.space
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0195284968; Wed,  6 May 2026 01:14:07 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8568495B
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 01:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=timmermann.space
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uboot@timmermann.space
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g9Dpq6KlCz9v2Q;
 Wed,  6 May 2026 01:13:55 +0200 (CEST)
From: Lukas Timmermann <uboot@timmermann.space>
Subject: [PATCH RFC v3 0/2] Modern pinctrl for Exynos5250 devices
Date: Wed, 06 May 2026 01:13:28 +0200
Message-Id: <20260506-pinctrl-exyno5250-v3-0-11649fe82210@timmermann.space>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwMz3YLMvOSSohzd1IrKvHxTI1MD3WTTxFSzNBMT8yQjCyWgvoKi1LT
 MCrCZ0UpBbs5KsRDB4tKkrNTkEpBpSrW1AHSgeo56AAAA
X-Change-ID: 20260506-pinctrl-exyno5250-c5ae6f447b28
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, Minkyu Kang <mk7.kang@samsung.com>, 
 Lukas Timmermann <uboot@timmermann.space>
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

This patch series adds the necessary files to use a modern pinctrl driver
with an exynos5250 SoC. The changes are well tested and are working.

In contrast to v1, this reenables GPIO functionality. But as I'm still
lacking experience, I'm not quite sure on how to prevent s5p_gpio to
load when using upstream DTS in a clean way. Because of that, this 
patch series is marked as an RFC.
checkpatch complains about using #ifdef.

All changes were tested with an DT already in linux-next.
The tested device is a Google Nexus 10 (google-manta).
U-Boot was ported to that device and will be upstreamed into U-Boot
soon.

Changes in v3:
- Reenable s5p_gpio
- Fix new driver not binding s5p_gpio

Signed-off-by: Lukas Timmermann <uboot@timmermann.space>
---
Lukas Timmermann (2):
      pinctrl: exynos: Add exynos5250 driver
      gpio: s5p: Disable when using upstream DTS

 MAINTAINERS                                 |  5 ++
 drivers/gpio/s5p_gpio.c                     |  2 +
 drivers/pinctrl/exynos/Kconfig              |  8 +++
 drivers/pinctrl/exynos/Makefile             |  1 +
 drivers/pinctrl/exynos/pinctrl-exynos5250.c | 99 +++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+)
---
base-commit: 7d6cd981df6662ec042e570495b04dc922f0e9d7
change-id: 20260506-pinctrl-exyno5250-c5ae6f447b28

Best regards,
--  
Lukas Timmermann <uboot@timmermann.space>

