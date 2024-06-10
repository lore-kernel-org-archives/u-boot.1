Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E554C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 20:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE40B88678;
	Mon, 10 Jun 2024 22:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D75EC886AF; Mon, 10 Jun 2024 22:02:53 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C93885A5
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 22:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i53875b65.versanet.de ([83.135.91.101] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1sGlE1-0002G0-Ay; Mon, 10 Jun 2024 22:02:41 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Jing Luo <jing@jing.rocks>, Quentin Schulz <foss+uboot@0leil.net>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next v3 0/8] rockchip: add support for Theobroma Systems
 SOM-RK3588-Q7 Tiger module
Date: Mon, 10 Jun 2024 22:02:40 +0200
Message-ID: <8222860.eFmWaWnqpD@diego>
In-Reply-To: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
References: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Am Montag, 10. Juni 2024, 15:13:30 CEST schrieb Quentin Schulz:
> This has a dependency on https://lore.kernel.org/u-boot/20240528170406.353616-1-liujianfeng1994@gmail.com/
> 
> Changes in v3:
> - rebased on top of next,
> - changed patch series dependency from DRAM ATAGS (merged) to RK3588
>   upstream DTS cherry-picks from 6.10-rc1 (USB nodes),
> - cherry-picked kernel DTS commits for Tiger between v6.9 and v6.10-rc2,
>   note that the "arm64: dts: rockchip: correct gpio_pwrctrl1 typos on rk3588(s) boards"
>   commit triggered some git auto-merging while cherry-picking,
> - support for Q7 USB P1 (micro-USB OTG) has been dropped, it requires
>   extcon USB GPIO driver that isn't supported in U-Boot (yet?),
> - Link to v2: https://lore.kernel.org/r/20240423-tiger-v2-1-4a3fa0a01b5e@theobroma-systems.com
> 
> Changes in v2:
> - removed uart controller muxing patch as not necessary until we get
>   open-source DRAM init,
> - disabled DEBUG_UART_BOARD_INIT as it's only used for muxing the UART
>   controller and it's not necessary since DDR bin does this for us
>   already,
> - added missing uart2 mux bootph in U-Boot dtsi (though not required
>   yet),
> - switched to USB_DWC3_GENERIC from USB_XHCI_DWC3 as requested by Jonas,
> - Link to v1: https://lore.kernel.org/r/20240422-tiger-v1-0-8816b070d748@theobroma-systems.com
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Putting both the dependency and this series on top of next, still allows
my tiger to boot, so

Tested-by: Heiko Stuebner <heiko@sntech.de>



