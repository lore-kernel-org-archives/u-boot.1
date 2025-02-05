Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD755C02198
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CB45801BE;
	Wed,  5 Feb 2025 18:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="iGAQ/9A3";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="bVE8NebI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E79C1805E7; Wed,  5 Feb 2025 18:18:30 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B88F580104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=iGAQ/9A3LYwYwzdy+Qomt52/nh5qhJF/EMdEHhlLjFY4mJEYu9C+kXgUxcHg34o1uHiXbvmwis0Sgm0HZqo6+MqBSg/nzMbb15MkDPEA7ZmeViQMwi5wp6zJ6bNrCji/+8aGzAdsejsC27b3GMVx4bn4xAyUkmySkiay7B7rFbZxdqz6UTJmmFZ1/O4dy2skdPR9SDaTDsYwdcz821UbNzo4vJRQJNKtabo2MmM38zqBUlU4on0shfm0d/eoMwwbDC59QXiQbysZKuKTt74okhOsAO6M97R5laFQvhLnVrieSSq9KJhx/eOj1Hor8W9bLkxxoodeDEZAeVXtTpAo7w==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=vgLZpa/yu1axLpTn06jtWTXQZ5t2tpPRHp+dHAcwFAI=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=bVE8NebIa5maIspJq/JwC/3hghDj4vyzpzM+90iHpH6lIBUetcj9XywFqr3BOeaMZGhQnrG7ykELpGKIxgVzDanVzQur2x9TpDcxYieNo/exAi1/DMbB/bQwExvRIFR0skRv4/5ftLW+KD9L/Dy9O9ZC9ZFwUG2V4ltGW2xLqus0unkYZG+aIpyOwOipmDcrb/28m111NHUAC4wm0IT4G92pb5u9zG0nnCDJKwInFQK12I0IFidJljozVcIajP+ZMOpsMUy6AeLXEQ80E6S+ZsAmBqeJjZTLbMEXhy+qaJn3da4nyWdUbYCdC6NQLoX0mJg/Ix3oI9ydWBc11fGSrw==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=vgLZpa/yu1axLpTn06jtWTXQZ5t2tpPRHp+dHAcwFAI=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1817051443; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 05 Feb 2025 17:18:26 +0000 (UTC)
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
 Stefan Roese <sr@denx.de>, Tien Fong Chee <tien.fong.chee@intel.com>,
 Tom Rini <trini@konsulko.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 William Wu <william.wu@rock-chips.com>, Xiaobo Tian <peterwillcn@gmail.com>
Subject: [PATCH v3 0/5] rockchip: rk3399: rk3399-nanopi-4: Fix SD power
 initialization in SPL
Date: Wed,  5 Feb 2025 17:16:10 +0000
Message-ID: <20250205171634.826560-1-justin@tidylabs.net>
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

Changes in v3:
- Use dev_dbg instead of log_debug
- Add depends on SPL_DM_REGULATOR

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
 drivers/misc/rockchip-io-domain.c       |  5 ++++-
 drivers/power/regulator/Kconfig         |  9 +++++++++
 drivers/power/regulator/rk8xx.c         |  8 ++------
 11 files changed, 77 insertions(+), 7 deletions(-)

--=20
2.45.3

