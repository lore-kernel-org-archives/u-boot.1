Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A7BC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 19:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 866AA888A5;
	Tue, 30 Jul 2024 21:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hfpp5NEw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B966888A5; Tue, 30 Jul 2024 21:48:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F24887F51
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 21:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722368928;
 bh=E4rNLq07eRhcPSCI0gkKUhVr2Zl7nyzjhi67THG6SAE=;
 b=hfpp5NEw8YR5lu6OOK460Nt38x9mOn4m2e02R785EAEGMDK7YnAOo+Ty2Vp1UJv3Ybe0tNg1M
 XP0XX+9pN0QkOh76LLBFJkXTKZzwBXw2ZdMaYsCvNrSHhFa65h0W5dZlUIEes080DVJPnHeEjIE
 o3jXAq7qzjFDFYSQyjGrV6285DEhhR+/XATPsNuK7wpRRz2fVrykCrpFalIKexfyHMwlTBLrmh+
 3mKsTw3vwu4nRp6fd8xLgnJs79eQ/KjI63ca25eZ3uEaXL807jPpMMZ1KKC7kkYbULfsuKHCl2+
 eWCoV+gOC6EE1HjjGlqErRvFaPEJ7BxmXdMU0ZekP00Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] board: rockchip: Add Radxa ROCK S0
Date: Tue, 30 Jul 2024 19:48:35 +0000
Message-ID: <20240730194842.916502-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a9439f2c52d9ba4458b18d
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

This series add support for the RK3308 based Radxa ROCK S0 board.

Features tested on a ROCK S0 v1.2 with 512 MiB RAM and 8 GiB eMMC:
- SD-card boot
- eMMC boot
- Ethernet
- USB gadget
- USB host

This series depends on the following patch:
- arm64: dts: rockchip: Add rk3308 IO voltage domains [1]

[1] https://patchwork.ozlabs.org/patch/1966593/

Jonas Karlman (2):
  arm64: dts: rockchip: Add Radxa ROCK S0
  board: rockchip: Add Radxa ROCK S0

 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi       |  21 ++
 board/rockchip/evb_rk3308/MAINTAINERS         |   6 +
 configs/rock-s0-rk3308_defconfig              |  72 +++++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../src/arm64/rockchip/rk3308-rock-s0.dts     | 293 ++++++++++++++++++
 5 files changed, 393 insertions(+)
 create mode 100644 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
 create mode 100644 configs/rock-s0-rk3308_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3308-rock-s0.dts

-- 
2.45.2

