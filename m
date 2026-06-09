Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922EDCD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 18:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12CB8484C;
	Tue,  9 Jun 2026 20:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="Aux7eO0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A3E284869; Tue,  9 Jun 2026 20:50:01 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B6AF84704
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 20:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=RAk1d/Y0fPd2xym1mpBMQ50P/dleQrOIwAVQq9NeRqk=; b=Aux7eO0XQ/tPlBXrAA79/JIqzf
 A1/5cYUfsaH+9lA8kQYXDNxOjMkCyxBMJ5dxzT8VcyG3Vr0riw+aAdXH52sn1QeTSW0XY021mJ96L
 kXxN1fOJs6zcBqcfNr6fSw+GAta9uLC9+YSQ6rJToMVx/DNV/50179O/Ku+Bb/PbC7wxDNHMIySew
 /g3JrFCEuhL0xKPVNbCHOIg5zIUipzhgV92MsuPfI72xc7lPG+coEPJkRmfG7U60+ZXBUWikFj9NB
 Y7QhSsGnOEn8byJmLjVauLEHX1Zelax03K5KX4Pj3owI0U48cZi7ih3LoViAH3b8vC7arPa4ltr1l
 wWoqmjHw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Richard Genoud <richard.genoud@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Peter Korsgaard <peter@korsgaard.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Daniele Briguglio <hello@superkali.me>, Jonas Karlman <jonas@kwiboo.se>,
 Daniele Briguglio <hello@superkali.me>
Subject: Re: [PATCH v3 1/4] clk: add gated-fixed-clock driver
Date: Tue, 09 Jun 2026 20:49:44 +0200
Message-ID: <3698807.iIbC2pHGDl@diego>
In-Reply-To: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-1-58f2cea72030@superkali.me>
References: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-0-58f2cea72030@superkali.me>
 <20260520-rock-5-itx-pcie-refclk-dtsi-v3-1-58f2cea72030@superkali.me>
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

Am Mittwoch, 20. Mai 2026, 08:05:27 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Daniele Briguglio:
> Add a UCLASS_CLK driver matching the Linux DT binding documented at
> Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml, a
> fixed-rate oscillator whose output is enabled by toggling a
> regulator supply.  The optional enable-gpios variant is not
> implemented.
>=20
> The first user in U-Boot will be rk3588-rock-5-itx, where the PCIe3
> ports reference a PI6C 100MHz oscillator declared with this
> compatible and pcie_dw_rockchip currently fails clk_get_by_index()
> with -ENODEV on every boot since v2026.04.
>=20
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Daniele Briguglio <hello@superkali.me>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de> # rock-5-itx



