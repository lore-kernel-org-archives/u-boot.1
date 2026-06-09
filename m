Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CE0CD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D2A0848D8;
	Tue,  9 Jun 2026 21:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="lu4pkj2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE3384911; Tue,  9 Jun 2026 21:04:33 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FFFB84704
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=RgI+0y+5cueBS24p3WXzgD55ZRaPDCZCQ6fPoThuvYM=; b=lu4pkj2TIF1O3Mig4VVbq9w684
 3HYR/Bw16PhcdzEcANGCzDCrak9fdY8DgMvJ2IxWGJOVwzk4LWidNL+qRtxjKccMqzAtOyuUyQV4Y
 2jn9LOK+YplRs06jFeACzhMVrRT4qMI/LivMc7XzDiK8Bla8kXLf3P84287Bv2s9pwTi7tVnIhRP9
 vui4Dvbtp9eqkMtbw/CGaNmPBdFLJ0iSuwj+pHx0//pt5JShmP1a0mTXjM5v+z5oSPAWt7lKMlgWD
 jPwQyvlAa9/JykF7xX722qdlWlsGBI+jcvep3zKnJwxzh3xyeFOK1EpOZXZj2SQVJvZqoLo29ks1H
 /1yPk8aw==;
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
Subject: Re: [PATCH v3 3/4] pci: pcie_dw_rockchip: drop clk_release_bulk calls
Date: Tue, 09 Jun 2026 21:04:27 +0200
Message-ID: <1963052.CQOukoFCf9@diego>
In-Reply-To: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-3-58f2cea72030@superkali.me>
References: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-0-58f2cea72030@superkali.me>
 <20260520-rock-5-itx-pcie-refclk-dtsi-v3-3-58f2cea72030@superkali.me>
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

Am Mittwoch, 20. Mai 2026, 08:05:29 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Daniele Briguglio:
> clk_release_bulk() loops clk_disable() over the bulk; the bulk
> array itself is devm_kcalloc()-allocated and freed at device
> detach, so the function does not actually release memory.
>=20
> In parse_dt() the clocks are acquired but never enabled, so the
> existing call disables clocks that are off.  In probe() after
> init_port() failure, the inner err_disable_clks: path added in
> the previous patch has already balanced clk_enable_bulk() with
> clk_disable_bulk(), so the outer call is a double-disable.
>=20
> With the new gated-fixed-clock driver both cases trigger
> regulator_set_enable_if_allowed(false) on regulators that were
> either never enabled or just disabled, desynchronising the
> regulator enable_count.  On rk3588-rock-5-itx with only one M.2
> slot populated, the failing empty slot would decrement the
> enable_count of the still-needed regulator twice and pull power
> from the populated slot.
>=20
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Daniele Briguglio <hello@superkali.me>

Acked-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de> # rock-5-itx


Though the whole clk handling is quite strange.
I would assume that it's always a
  - clk-request
      - clk-enable
          something
      - clk-disable
  - clk-release


That a clk-disable also hides in the clk-release is really surprising,
and I guess a lot of places in u-boot will encounter the same
imbalance - just mitigated by the fact that the double-disable
won't matter.

Directly in clk_get_bulk the problem is apparent ...
The function tries to get all the clocks, and on error calls
clk_release_all on the already gotten clocks.

All of these clocks never got enabled, but are getting double-disabled
by the clk_release_all() call.

Very very strange ;-)


Heiko

> ---
>  drivers/pci/pcie_dw_rockchip.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pcie_dw_rockchip.c b/drivers/pci/pcie_dw_rockchi=
p.c
> index 8ea51e642..c1e34df53 100644
> --- a/drivers/pci/pcie_dw_rockchip.c
> +++ b/drivers/pci/pcie_dw_rockchip.c
> @@ -425,7 +425,7 @@ static int rockchip_pcie_parse_dt(struct udevice *dev)
>  rockchip_pcie_parse_dt_err_phy_get_by_index:
>  	/* regulators don't need release */
>  rockchip_pcie_parse_dt_err_supply_regulator:
> -	clk_release_bulk(&priv->clks);
> +	/* clocks don't need release */
>  rockchip_pcie_parse_dt_err_clk_get_bulk:
>  	reset_release_bulk(&priv->rsts);
>  rockchip_pcie_parse_dt_err_reset_get_bulk:
> @@ -476,7 +476,6 @@ static int rockchip_pcie_probe(struct udevice *dev)
>  		return ret;
> =20
>  rockchip_pcie_probe_err_init_port:
> -	clk_release_bulk(&priv->clks);
>  	reset_release_bulk(&priv->rsts);
>  	dm_gpio_free(dev, &priv->rst_gpio);
> =20
>=20
>=20




