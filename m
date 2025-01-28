Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD57FC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 21:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B7F581DD3;
	Tue, 28 Jan 2025 22:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="mhgAdQaK";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="vFhmeyOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 100D381DFA; Tue, 28 Jan 2025 22:39:20 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3225981D27
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 22:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=mhgAdQaKSYXNBAjLNFSotWNZ9E6/7r3sxYWRn42zxaY1kJpsJyGW1Nr2lZU0lXLsilr5w9gLTs0NtIito6mZVWefffvJr1bsXtfXkWiAqilLSfYwS5hO2lsXYiB7savS/Ki6j7SQemP+CXIVfX995JXAnGxaAznzk1OYHVYHaOzntYDv6wBQstmPF4e8uMYCADv5X2FqlOs5qW2e2By2e06odgggi4/Kfqa20Gcd44qWd7cesupLA6vTHkqJPJFvAOsktjpM2lLXq2Mq6s1Osvt/FUoXjDQkE+rUc3dks0QLnHIAPFHMIzOXHhnYCQjN7ITItaYD5omJ78WCw/q4aw==;
 s=purelymail1; d=tidylabs.net; v=1;
 bh=IiFpccbwmYiQD2t9k4G3nnUirtziBoE6tq0Ym9lVpvk=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=vFhmeyOYOY7roVgMhV2eyJBBTma6KJyzOlsSwmLljiBsMmiiKp7j2rsInz4GULykZ9x6CHgcDTvAEIROHuxkTTBtU/JiBE5To07YZC353gOozBdO6FoDOZQ7+pk4K+/Nxf0x9jBYqjwGH6qSfBBC6PkAEsgdQt6PyzOqAIa02Yg6yLs58Sn8ACrpD8HsY5VjCebTRIcoq9jYfkS6jgQYxIEDi+oQDihXrldlfV2J9jxl6tPMhrEcNtQlN80Flxfgl+fI9323bAxxHxA74AMNVGsX8Y7ORB+an+SPv53gvSwbR4JqrKcTzVB29Ia1MHwtyxJgSY3fB4i+9d2MsxrE7w==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=IiFpccbwmYiQD2t9k4G3nnUirtziBoE6tq0Ym9lVpvk=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -499528210; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 28 Jan 2025 21:39:14 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>, Alexandre Vicenzi <linux@alxd.me>,
 Caleb Connolly <caleb.connolly@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Deepak Das <deepakdas.linux@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Keerthy <j-keerthy@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 William Wu <william.wu@rock-chips.com>, Xiaobo Tian <peterwillcn@gmail.com>
Subject: [PATCH v2 0/5] rockchip: rk3399: rk3399-nanopi-4: Fix SD power
 initialization in SPL
Date: Tue, 28 Jan 2025 21:37:32 +0000
Message-ID: <20250128213852.465664-1-justin@tidylabs.net>
X-Mailer: git-send-email 2.45.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
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


The NanoPi RK3399 boards support UHS-I (up to SDR104) SD cards, however
using any of these 1.8v modes results in a boot failure in SPL upon soft
reboot.

The issue is that the "vcc_sdio" regulator is left at 1.8v on reboot and
the corresponding GPIO defaults to 3.3v. This prevents the SD card from
being reinitialized and read successfully.

This change series resolves this issue by allowing the proper
initialization and control of the "vcc3v0_sd" (vmmc-supply) and
"vcc_sdio" (vqmmc-supply) regulators and corresponding GPIO in SPL.

Changes in v2:
- Made added IO-domain driver logs verbose and consistent
- Added separate patch for added CONFIG_SPL_ROCKCHIP_IODOMAIN Kconfig
- Added separate patch for added CONFIG_SPL_REGULATOR_RK8XX Kconfig
- Added patch to remove device-tree properties that conflicted with MMC dri=
ver initialization
- Added defconfig changes for all NanoPi RK3399 boards

Justin Klaassen (5):
  rockchip: io-domain: Add debug logging for regulators during probe
  rockchip: io-domain: Add CONFIG_SPL_ROCKCHIP_IODOMAIN
  regulator: rk8xx: Add CONFIG_SPL_REGULATOR_RK8XX
  rockchip: rk3399-nanopi-4: Allow MMC driver to control SD regulators
  rockchip: rk3399-nanopi-4: Enable IO-domain driver in SPL

 arch/arm/dts/rk3399-nanopi4-u-boot.dtsi | 12 ++++++++++++
 configs/nanopc-t4-rk3399_defconfig      |  7 +++++++
 configs/nanopi-m4-2gb-rk3399_defconfig  |  7 +++++++
 configs/nanopi-m4-rk3399_defconfig      |  7 +++++++
 configs/nanopi-m4b-rk3399_defconfig     |  7 +++++++
 configs/nanopi-neo4-rk3399_defconfig    |  7 +++++++
 configs/nanopi-r4s-rk3399_defconfig     |  7 +++++++
 drivers/misc/Kconfig                    |  8 ++++++++
 drivers/misc/rockchip-io-domain.c       |  7 ++++++-
 drivers/power/regulator/Kconfig         |  9 +++++++++
 drivers/power/regulator/rk8xx.c         |  8 ++------
 11 files changed, 79 insertions(+), 7 deletions(-)

--=20
2.45.3

