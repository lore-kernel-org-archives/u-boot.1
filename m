Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A176C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8158983285;
	Fri, 23 May 2025 18:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="Yv6GUMSt";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="fKvRRCGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1CA4832D8; Fri, 23 May 2025 18:55:03 +0200 (CEST)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD15E83278
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 18:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=Yv6GUMStDnhAFqZLoGiJb5ocdAM2+YwW+dFGLQgI11/itOdyvWDw0bbq4qUlKSBgvbN2kUWgaBm2lpA2K7x1106KPDru4ckHrt75uleRDaXjSuTavUQYhFufhdZs4MxfEDgZd56ytuucd39OsDOufh81fCMAGcFbudQga4waE/8vQpwhdh7yBdfr1AdQYKCuu14wCeqrymlj4JI62XwuZeSThNztNMTtghlaD9u2f8DKMVkIFeT21XCSQgXvIIPZq0ulyYZwodyigw7be/aa7ZDXrteqQWVYopJAVla0TBQK3ycVrXw+9hKT9YE+ZBct9IARiK+TDLWStoQjPV7olA==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=BxnPtYPU7BbWJn4NqMjSuyD6A3+4eVAk49+UqmarWf0=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=fKvRRCGXNL0OEZd38+aSTSnUGeiKRosJOGqps0/DQnXjyc70TGQQUwycGtcFrQiZlXYl6NhsrhH5HxatbANBUlIB/R+xsxb6p0L/sMmtC22yyqGZaIFzfcO3KXQwXLhrmz02NbUXwIdsQhhh8d4SgGMXuxp6pnmHNpyzzJ0Pc30Rqb3UCTPzevVD/mKSOJjbr2veebXFS2vAE3CPKKwTNzKehXHNKSlsYALUCaJ+SylXf97JAA7Xfrl7RzqgqtlxyH/zrQWNdn+kyD95xDsirN+Ao9A+/bkTHhtSC9YPF5yofPHWV2sh7hMTCXUmuhZ8L0TGK2PZEWtExe48rX+iqg==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=BxnPtYPU7BbWJn4NqMjSuyD6A3+4eVAk49+UqmarWf0=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2127220571; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 23 May 2025 16:54:58 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>, Alexandre Vicenzi <linux@alxd.me>,
 Anand Moon <linux.amoon@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Casey Connolly <casey.connolly@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Deepak Das <deepakdas.linux@gmail.com>, Harsha Vardhan V M <h-vm@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Keerthy <j-keerthy@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Samuel Holland <samuel@sholland.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Xiaobo Tian <peterwillcn@gmail.com>
Subject: [PATCH v4 0/5] rockchip: rk3399: rk3399-nanopi-4: Fix SD power
 initialization in SPL
Date: Fri, 23 May 2025 16:53:36 +0000
Message-ID: <20250523165406.40915-1-justin@tidylabs.net>
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

Changes in v4:
- Resolved merge conflict

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

