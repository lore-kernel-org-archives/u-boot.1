Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68DBC54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 12:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E922187E3A;
	Mon, 25 Mar 2024 13:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OSEfTgLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE6DD87E6A; Mon, 25 Mar 2024 13:17:03 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B0D87D73
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 13:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C808360F27;
 Mon, 25 Mar 2024 12:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BFCC433F1;
 Mon, 25 Mar 2024 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711369019;
 bh=YKX+rP6Sx/WWmX+iXIQ6ne3XbQsstCEyZ1kCLNOdY7g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OSEfTgLTZJCxMwtuVC0D3mXKJ5MZwoWji9xNZZxtxbTuvehQvJNrgAupdxmPgMJS6
 kt0oNDjqR9BqfiU1O2DIOAxTA0brIdY3vYhhk62W/inC+U9BOsb3qY7OgLcLA4DsG0
 hhiZhk8aX/nGSkWCqxlh0HsOjM3ZClCWeql6o5uxN8NgPv1OyvCZBqz5fq8IOD1KZJ
 Y0VJj+Pz1VGAUUaIQrjXvuQqSZIFdiPkMst09ZVP/htuvsT1KhG9b1JGVkpXzYtPkv
 Oxtu+B2D8EsRQRvNK51NMGHY6I36tqpekgsTFC1rQHWiOyHedloDHJgRzEcvcMuy1X
 sYOwnsvqTUufA==
Message-ID: <a91f3573-0e2c-49ff-bbe0-933eff7eedc7@kernel.org>
Date: Mon, 25 Mar 2024 14:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: mdio-uclass: probe generic Ethernet PHY driver &
 Fix Beagleplay Ethernet
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com,
 danishanwar@ti.com, u-boot@lists.denx.de
References: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Tom / Joe,

On 05/03/2024 15:24, Roger Quadros wrote:
> Currently, the GPIO Reset Device Tree properties of the
> PHY node are ignored when the PHY is probed via mdio-uclass driver [1].
> 
> To resolve this, for each child of the MDIO bus node, bind and probe
> the generic Ethernet PHY driver if CONFIG_DM_ETH_PHY is enabled.
> 
> This should now show the generic_phy_driver in "dm tree"
> and also apply the GPIO reset before the MDIO bus driver scans the bus
> for the PHYs.
> 
>  ethernet      0  [ + ]   am65_cpsw_nuss_port       |   |-- ethernet@8000000port@1
>  bootdev       3  [   ]   eth_bootdev               |   |   `-- port@1.bootdev
>  mdio          0  [ + ]   cpsw_mdio                 |   `-- mdio@f00
>  eth_phy_ge    0  [ + ]   eth_phy_generic_drv       |       |-- ethernet-phy@0
>  eth_phy_ge    1  [ + ]   eth_phy_generic_drv       |       `-- ethernet-phy@1
> 
> To test this on Beagleplay, the following series is required
> 
> [1] Switch am65-cpsw to DM MDIO
>  https://lore.kernel.org/all/20240228-for-2024-07-am65-cpsw-mdio-v2-0-f74f972eafeb@kernel.org/
> 
> The last 3 patches are marked [not-for-merge]. They are to show how the
> whole solution can work to fix Ethernet on Beagleplay, which has been broken
> so far. Those DT patches will be sent once the device tree changes are merged
> into Linux tree.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> Roger Quadros (5):
>       net: mdio-uclass: Bind and probe generic Ethernet PHY driver
>       configs/am62x_beagleplay_a53_defconfig: enable DM_ETH_PHY

Any comments to the first 2 patches in this series?

>       [not-for-merge] arm: dts: k3-am62*: sync with linux-next-20240229
>       [not-for-merge] k3-am625-beagleplay-u-boot: get CPSW Ethernet to work
>       [not-for-merge] arm: dts: k3-am625-beagleplay: Fix Ethernet PHY reset GPIO
> 
>  arch/arm/dts/k3-am62-main.dtsi               | 126 ++++++++++++++---
>  arch/arm/dts/k3-am62-mcu.dtsi                |   4 +-
>  arch/arm/dts/k3-am62-phycore-som.dtsi        |   5 +-
>  arch/arm/dts/k3-am62-thermal.dtsi            |   5 +-
>  arch/arm/dts/k3-am62-verdin-dev.dtsi         |   4 +-
>  arch/arm/dts/k3-am62-verdin-wifi.dtsi        |   1 -
>  arch/arm/dts/k3-am62-verdin.dtsi             |  76 +++++++---
>  arch/arm/dts/k3-am62-wakeup.dtsi             |  38 +++--
>  arch/arm/dts/k3-am62.dtsi                    |   4 +-
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |  63 +++++++++
>  arch/arm/dts/k3-am625-beagleplay.dts         |  66 ++++-----
>  arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts  | 104 +++++++++++++-
>  arch/arm/dts/k3-am625-sk.dts                 |   4 +-
>  arch/arm/dts/k3-am625.dtsi                   |   4 +-
>  arch/arm/dts/k3-am62a-main.dtsi              | 201 +++++++++++++++++++++++++--
>  arch/arm/dts/k3-am62a-mcu.dtsi               |   4 +-
>  arch/arm/dts/k3-am62a-thermal.dtsi           |   5 +-
>  arch/arm/dts/k3-am62a-wakeup.dtsi            |   4 +-
>  arch/arm/dts/k3-am62a.dtsi                   |   4 +-
>  arch/arm/dts/k3-am62a7-sk.dts                | 162 ++++++++++++++++++++-
>  arch/arm/dts/k3-am62a7.dtsi                  |   4 +-
>  arch/arm/dts/k3-am62x-sk-common.dtsi         |  24 +++-
>  configs/am62x_beagleplay_a53_defconfig       |   2 +-
>  net/mdio-uclass.c                            |  41 ++++++
>  24 files changed, 825 insertions(+), 130 deletions(-)
> ---
> base-commit: 84f5bb0be0ec9fbf98f8f3317b578dfc114cf44e
> change-id: 20240305-for-2024-07-beagleplay-eth-f82a51197937
> 
> Best regards,

-- 
cheers,
-roger
