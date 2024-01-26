Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD35BC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 22:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2072287D42;
	Fri, 26 Jan 2024 23:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Hr+zqMrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B114A87D42; Fri, 26 Jan 2024 23:15:25 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25AFC87D40
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 23:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0bb9=JF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1706307315;
 bh=kWk18PXcW+ttC5+4LCwI/Mmi2daLJ3zQ79/WgBSL+Q0=;
 b=Hr+zqMrHB9g+pBUYzh5i/05Fumx+4RUigP7hDi7UasevVzV5YWXYZ/eNCAxAVoKyf9TSP3Al8
 64JDWeuzg6Ufwl8vBh7M9+8Exy2mT8lX2BfvlaZTa++LkmQPitHek/TLHgow4uY9iyGkMmmUKdQ
 CWEsBJELL6IXhGy0w8V2CB8hc53UuMADfEan6zwVsDAFEUa7PQ6ZKwHdA2k27Zp/kH3GgLPhoX2
 od329pj+rGkzrz/6KD2iCVxtwiPw3JMKKeQxRBUmbAoTa99EI0h0sEly6BrKRMlg/rSX7mSLUKG
 O2/GQQmf5bh+mttmRK6S1KQ8wb/7z4XbHQPubZejt6hQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/7] rockchip: rk35xx: Sync device tree with linux v6.8-rc1
Date: Fri, 26 Jan 2024 22:14:48 +0000
Message-ID: <20240126221508.4093334-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b42ef30365e200626455be
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

This series sync RK356x and RK3588 device tree with linux v6.8-rc1. It
also moves some common/default props into the SoC u-boot.dtsi files.

Also drop the rockchip,rk3568-dwc3 compatible now that dwc3-generic
driver support the rockchip,rk3588-dwc3 compatible.

Patch 1-2 sync rk356x device trees
Patch 3 move common uart2 props to rk356x-u-boot.dtsi
Patch 4-5 sync rk3588 device trees
Patch 6 add default u-boot,spl-boot-order prop to rk3588s-u-boot.dtsi
Patch 7 remove unnecessary status = "okay" props

Jonas Karlman (7):
  rockchip: rk356x: Sync device tree from linux v6.7
  rockchip: rk356x: Sync device tree from linux v6.8-rc1
  rockchip: rk356x: Move common uart2 props to rk356x-u-boot.dtsi
  rockchip: rk3588: Sync device tree with linux v6.7
  rockchip: rk3588: Sync device tree from linux v6.8-rc1
  rockchip: rk3588: Add default u-boot,spl-boot-order prop
  rockchip: rk35xx: Remove unnecessary status props

 .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |   7 -
 arch/arm/dts/rk3566-anbernic-rgxx3.dtsi       |  42 ++---
 arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi    |  12 --
 arch/arm/dts/rk3566-quartz64-a.dts            |   7 +-
 arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi    |  12 --
 arch/arm/dts/rk3566-quartz64-b.dts            |   2 -
 arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi  |  12 --
 arch/arm/dts/rk3566-radxa-cm3-io.dts          |   5 +-
 arch/arm/dts/rk3566-soquartz-blade.dts        |   4 +
 arch/arm/dts/rk3566-soquartz-cm4.dts          |   4 +
 arch/arm/dts/rk3566-soquartz-model-a.dts      |   4 +
 arch/arm/dts/rk3566-soquartz-u-boot.dtsi      |  12 --
 arch/arm/dts/rk3566-soquartz.dtsi             |   4 -
 arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi    |  13 --
 arch/arm/dts/rk3568-evb-u-boot.dtsi           |  17 --
 arch/arm/dts/rk3568-evb.dts                   |   3 -
 arch/arm/dts/rk3568-generic-u-boot.dtsi       |  11 --
 arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi    |  12 --
 arch/arm/dts/rk3568-lubancat-2.dts            |   3 -
 arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi    |  12 --
 arch/arm/dts/rk3568-nanopi-r5s.dtsi           |   3 -
 arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi     |  12 --
 arch/arm/dts/rk3568-odroid-m1.dts             |   3 -
 arch/arm/dts/rk3568-radxa-cm3i.dtsi           |   3 -
 arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     |  12 --
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       |  12 --
 arch/arm/dts/rk3568-rock-3a.dts               |   7 +-
 arch/arm/dts/rk356x-u-boot.dtsi               |  12 +-
 arch/arm/dts/rk356x.dtsi                      |  20 ++-
 arch/arm/dts/rk3588-edgeble-neu6a-io.dts      |   4 -
 arch/arm/dts/rk3588-edgeble-neu6b-io.dts      |   6 +-
 arch/arm/dts/rk3588-evb1-v10.dts              |  99 +++++++++++-
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     |   6 -
 arch/arm/dts/rk3588-nanopc-t6.dts             |  10 +-
 .../dts/rk3588-orangepi-5-plus-u-boot.dtsi    |   6 -
 arch/arm/dts/rk3588-orangepi-5-plus.dts       |   1 -
 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi   |   6 -
 arch/arm/dts/rk3588-quartzpro64.dts           |   2 +-
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |  12 --
 arch/arm/dts/rk3588-rock-5b.dts               |  13 +-
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi    |   7 -
 arch/arm/dts/rk3588-turing-rk1.dtsi           |   6 +-
 arch/arm/dts/rk3588-u-boot.dtsi               |   2 +-
 arch/arm/dts/rk3588s-orangepi-5.dts           |   9 +-
 arch/arm/dts/rk3588s-pinctrl.dtsi             |   2 +-
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi      |   6 -
 arch/arm/dts/rk3588s-rock-5a.dts              |  10 +-
 arch/arm/dts/rk3588s-u-boot.dtsi              |  49 ++----
 arch/arm/dts/rk3588s.dtsi                     | 152 ++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c |   2 +-
 include/dt-bindings/clock/rk3568-cru.h        |   1 +
 include/dt-bindings/soc/rockchip,vop2.h       |   4 +
 52 files changed, 372 insertions(+), 325 deletions(-)

-- 
2.43.0

