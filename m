Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F8DC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 18:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8FD6849A4;
	Tue,  7 Jul 2026 20:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="s2oDILl7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD082849B1; Tue,  7 Jul 2026 20:29:59 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D09884942
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 20:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=QOOej2ic70f6kENefVLKUhjuij1FnbHce2aFevW0z9Y=; b=s2oDILl73Qhc9EhM2FUYHh90fy
 ausS87ZNbQ8BBXzTN2+mnNahbzBZkf3nzo6Eq2NQTMJq90MqvCFrInkeM719G3sG/p1JFuVX0AFWI
 K0WxHjI7XyZ2CiclGUjkk/oN1BnI1bOquVFOjxnCKvXPg85Ypm5U4TxKv8PALXimeCCBLj3aUDVWU
 XH0YcpBB5T6iIGAhmTcJo8g9zyrbwdL9mGmhjAJm1Yzf5QHjA6ol6z7ex9heUeH/XRg59EVo3ymeZ
 sgnVwFMP0PCxqDLGQyaU5FCe8qszTwn+5AM8Qa8Zo0xarOIuIHqH4Z0phfgkSWCf2jpxhFXFd2o8s
 VJMrk2xA==;
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, Quentin Schulz <u-boot@0leil.net>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz <u-boot@0leil.net>
Subject: Re: [PATCH 01/12] MAINTAINERS: remove redundant entries for ARM
 ROCKCHIP
Date: Tue, 07 Jul 2026 20:29:53 +0200
Message-ID: <3425375.44csPzL39Z@phil>
In-Reply-To: <20260707-rk-custodian-v1-1-dbc9c696e613@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-1-dbc9c696e613@0leil.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Dienstag, 7. Juli 2026, 18:09:15 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Quentin Schulz:
> The ARM ROCKCHIP entry already specifies an N: rockchip so we don't need
> to repeat a path with F: if it has rockchip in the path, so drop it.
>=20
> Note that for some reason get_maintainer.pl doesn't return the exact
> same list before and after this patch.
>=20
> Signed-off-by: Quentin Schulz <u-boot@0leil.net>
> ---
>  MAINTAINERS | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 45e9076de671..e2c78ce39161 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -574,12 +574,10 @@ M:	Philipp Tomsich <philipp.tomsich@vrull.eu>
>  M:	Kever Yang <kever.yang@rock-chips.com>
>  S:	Maintained
>  T:	git https://source.denx.de/u-boot/custodians/u-boot-rockchip.git
> +N:	rockchip

It took me a while to realize the existing N was at the end, so gets
moved up here :-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


>  F:	arch/arm/dts/px30*
>  F:	arch/arm/dts/rk3*
> -F:	arch/arm/dts/rockchip*
>  F:	arch/arm/dts/rv11*
> -F:	arch/arm/include/asm/arch-rockchip/
> -F:	arch/arm/mach-rockchip/
>  F:	board/amarula/vyasa-rk3288/
>  F:	board/anbernic/rgxx3_rk3566/
>  F:	board/armsom/sige7-rk3588/
> @@ -590,25 +588,14 @@ F:	board/mqmaker/miqi_rk3288/
>  F:	board/phytec/phycore_rk3288
>  F:	board/pine64
>  F:	board/radxa/
> -F:	board/rockchip/
>  F:	board/theobroma-systems
>  F:	board/vamrs/rock960_rk3399/
> -F:	drivers/clk/rockchip/
>  F:	drivers/gpio/rk_gpio.c
> -F:	drivers/misc/rockchip-efuse.c
> -F:	drivers/mmc/rockchip_sdhci.c
> -F:	drivers/mmc/rockchip_dw_mmc.c
> -F:	drivers/pinctrl/rockchip/
> -F:	drivers/ram/rockchip/
> -F:	drivers/sysreset/sysreset_rockchip.c
> -F:	drivers/ufs/*rockchip*
> -F:	drivers/video/rockchip/
>  F:	tools/rkcommon.c
>  F:	tools/rkcommon.h
>  F:	tools/rkimage.c
>  F:	tools/rksd.c
>  F:	tools/rkspi.c
> -N:	rockchip
> =20
>  ARM SAMSUNG
>  M:	Minkyu Kang <mk7.kang@samsung.com>
>=20
>=20




