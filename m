Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AC9EE49A6
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 22:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D52DA8713A;
	Tue, 22 Aug 2023 00:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="guTDemLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC9BA871C3; Tue, 22 Aug 2023 00:30:26 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B9F8713A
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:mime-version:to:cc:content-transfer-encoding:
 content-type:cc:content-type:from:subject:to;
 s=s1; bh=MXLykt6FDq7xSHY6Jn/LrlcrPHBj0A6NQYoUQSl9wJc=;
 b=guTDemLWnZSILFUjcVlkRXFEgS1W43B0MDdLEl69PzXZKMyEy/PqKytygdQOwn8lFoNd
 xwt+MJNxVjqI+QPPQTKHn7Gd0sUP7MZHwxdunSbArXmeNZX1NBdcQDwJU6eXbN+TsjHt7T
 hv7UmireliX2yiJC7vekiJqbv1+v3raZ+eqIXw//zXjChqUDptoMqEohdp6926RLeLDtHE
 qDDJyryyTKNNZmHX6GDjx2cIB8UFcp32jh+Jps16n1H6CRsyTAzALsAouUSjqE5N59ZOrp
 zaCQKMPoq6yrOmo602xyjpLaXMIb0p+T/GwxBmPFCQFsBnI/4jCpXHnNaRGguGSA==
Received: by filterdrecv-d7bbbc8bf-jcg2g with SMTP id
 filterdrecv-d7bbbc8bf-jcg2g-1-64E3E57E-1D
 2023-08-21 22:30:22.317528484 +0000 UTC m=+8895044.168731752
Received: from bionic.localdomain (unknown) by geopod-ismtpd-7 (SG) with ESMTP
 id dnkmJd5QTA2IWfW49HcuyA Mon, 21 Aug 2023 22:30:22.015 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/5] rockchip: Port IO-domain driver for RK3568 from linux
Date: Mon, 21 Aug 2023 22:30:22 +0000 (UTC)
Message-ID: <20230821223020.3918620-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h4x=2FgD7G0=2Fp=2FGQXwU?=
 =?us-ascii?Q?yBzc49VkkgfKJNyGc=2FZwVEZfnVQ5eJXGokBdOtX?=
 =?us-ascii?Q?TyqwQbatHNydjgV1DuMwRGgrToPfgk+HIvq7akV?=
 =?us-ascii?Q?uCzj4Fv3DJuE8WihcAzijzlsuK1pfeFV+E5uUzQ?=
 =?us-ascii?Q?GOeRN45qKSQ3ILmNKtH4ULIawwkBkcsVdI4Q4t?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

This series port the IO-domain driver for RK3568 from linux. It is
necessary for the IO-domain setting of the SoC to match the voltage
supplied by the regulators.

The driver auto probe after bind and configures IO-domain based on the
voltage reported by the regulators. This fixes issues observed while
working on the GMAC driver for RK3568 devices. The IO-domain setting
default to 3v3, however some vccio domains may be supplied by 1v8.

This series also add a minimal generic RK356x board that only enable
eMMC and SD-card node and keep the IO-domain driver disabled. The
generic board can be used to boot from eMMC/SD-card on boards that
follow reference board design.

Changes in v2:
- Include patch to return correct voltage for switchout converters
- Simplify code that return correct voltage for buck converters
- Add a minimal generic RK356x board with IO-domain driver disabled.
- Collect r-b tags

Patch 1 adds protection so that regulator autoset only happens one time.
Patch 2-3 fixes rk8xx buck/switchout regulator driver to report correct
voltage.
Patch 4 adds the IO-domain driver.
Patch 5 adds the minimal generic RK3566/RK3568 board.

This series can also be found at [1]

[1] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3568-io-domain-v2

Jonas Karlman (3):
  power: regulator: Only run autoset once for each regulator
  rockchip: Port IO-domain driver for RK3568 from linux
  rockchip: board: Add minimal generic RK3566/RK3568 board

Joseph Chen (1):
  regulator: rk8xx: Return correct voltage for buck converters

shengfei Xu (1):
  regulator: rk8xx: Return correct voltage for switchout converters

 arch/arm/dts/rk3568-generic-u-boot.dtsi    |  14 ++
 arch/arm/dts/rk3568-generic.dts            |  38 +++++
 board/rockchip/evb_rk3568/MAINTAINERS      |   7 +
 configs/generic-rk3568_defconfig           |  64 ++++++++
 doc/board/rockchip/rockchip.rst            |   1 +
 drivers/misc/Kconfig                       |   9 ++
 drivers/misc/Makefile                      |   1 +
 drivers/misc/rockchip-io-domain.c          | 167 +++++++++++++++++++++
 drivers/power/regulator/regulator-uclass.c |  18 ++-
 drivers/power/regulator/rk8xx.c            |  95 +++++++-----
 include/power/regulator.h                  |   1 +
 11 files changed, 375 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm/dts/rk3568-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3568-generic.dts
 create mode 100644 configs/generic-rk3568_defconfig
 create mode 100644 drivers/misc/rockchip-io-domain.c

-- 
2.41.0

