Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80ABC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 23:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0CD687DB2;
	Sat, 27 Jan 2024 00:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Us4Ohvwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE3887DB2; Sat, 27 Jan 2024 00:26:35 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9707D87DAE
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 00:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0bb9=JF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1706311581;
 bh=gkJmKBUWAE+vRtHkq9cF//8k5NRhtklmB9Pnu8gSsog=;
 b=Us4OhvwzhNzksdjAjCDjoN0GWfKxfHBcCyvxR77eruf6xl2eTVNwRyU51rh3XFkfUXc7iLQdv
 HIdiq4AjoDjbpEzqr6tUIv0XjxMTXLPYQzLKhNtDj13OaWeU1aeomewD9j+YdyaDHZW9lET2wBE
 zCymddvuYnuUK0FqsVkpF+YJe9CbE7bEZOhnC7E0Np0w4KUy94MZ111uWYsDqeZNm+ZnQGUX4+D
 HENdEtCk/HYtUc1k2PZpksZqkE3qfUFE0T9j/6i7uf9ar08/cE42DtDpmgwq9Zz3UpiMrJKUeWt
 x8Y3j5GT1oddgRKHCfbrOaARSL9tzT9pIMCUabrmGIHQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] rockchip: rk35xx: Fix writing to eMMC
Date: Fri, 26 Jan 2024 23:26:06 +0000
Message-ID: <20240126232615.6826-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b43f9d59c89db01a285fde
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

Writing to eMMC using DDR52 mode does not work reliably or at all on
RK356x and RK3588 boards.

This series fixes this issue by changing RK356x and RK3588 boards to
prefer use of the more reliably HS200 mode.

This series depend on the series "rockchip: rk35xx: Sync device tree
with linux v6.8-rc1" [1].

[1] https://patchwork.ozlabs.org/cover/1891669/

Jonas Karlman (3):
  rockchip: rk35xx: Remove use of eMMC DDR52 mode
  rockchip: rk356x: Enable eMMC HS200 mode
  rockchip: rk3588: Enable eMMC HS200 mode

 arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi | 1 -
 arch/arm/dts/rk3566-soquartz-u-boot.dtsi     | 1 -
 arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi    | 1 -
 arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi    | 1 -
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi      | 1 -
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      | 1 -
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi     | 1 -
 configs/anbernic-rgxx3-rk3566_defconfig      | 2 ++
 configs/bpi-r2-pro-rk3568_defconfig          | 2 ++
 configs/evb-rk3568_defconfig                 | 2 ++
 configs/evb-rk3588_defconfig                 | 2 ++
 configs/lubancat-2-rk3568_defconfig          | 2 ++
 configs/nanopc-t6-rk3588_defconfig           | 2 ++
 configs/neu6a-io-rk3588_defconfig            | 2 ++
 configs/neu6b-io-rk3588_defconfig            | 2 ++
 configs/odroid-m1-rk3568_defconfig           | 2 ++
 configs/orangepi-5-plus-rk3588_defconfig     | 2 ++
 configs/quartz64-a-rk3566_defconfig          | 2 ++
 configs/quartz64-b-rk3566_defconfig          | 2 ++
 configs/quartzpro64-rk3588_defconfig         | 2 ++
 configs/radxa-cm3-io-rk3566_defconfig        | 2 ++
 configs/rock-3a-rk3568_defconfig             | 2 ++
 configs/rock5a-rk3588s_defconfig             | 2 ++
 configs/rock5b-rk3588_defconfig              | 2 ++
 configs/soquartz-blade-rk3566_defconfig      | 2 ++
 configs/soquartz-cm4-rk3566_defconfig        | 2 ++
 configs/soquartz-model-a-rk3566_defconfig    | 2 ++
 configs/turing-rk1-rk3588_defconfig          | 2 ++
 33 files changed, 42 insertions(+), 12 deletions(-)

-- 
2.43.0

