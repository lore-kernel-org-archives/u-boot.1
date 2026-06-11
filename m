Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118C4CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96052846D3;
	Thu, 11 Jun 2026 16:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lpQ1rFWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 226CA84825; Thu, 11 Jun 2026 15:04:28 +0200 (CEST)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC5ED84701
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 15:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jai.luthra@ideasonboard.com
Received: from mail.ideasonboard.com (unknown
 [IPv6:2401:4900:1c68:bcf2:9325:a9bd:32b:e71])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0ACE1D0;
 Thu, 11 Jun 2026 15:03:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781183035;
 bh=pz0OdhQLx3IDa+nIXDGkA5fJ5qz1iu2yvhM5E5rCR5E=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=lpQ1rFWJPv/v3dVW8ByDdO267E73/IaAabXcZfoTo+Xvpn5zHh8Z77Al9dQSq2rEO
 jmK3hM3EWdL7rz9QlOyDfnAUyUPQLcLbPNu/35OjGQZoqNeoBgCRFZSpx7dEvq7pt+
 /C7VCBMwpFLP4O0oncqNJhnHpwz2ni2M+2ImuKJQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260611120652.3656640-1-s-vadapalli@ti.com>
References: <20260611120652.3656640-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: allow skipping phy_config() for
 speed
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: u-boot@lists.denx.de, nm@ti.com, srk@ti.com, s-vadapalli@ti.com
To: Siddharth Vadapalli <s-vadapalli@ti.com>, andrew.goodbody@linaro.org,
 c-vankar@ti.com, jerome.forissier@arm.com, matthias.schiffer@ew.tq-group.com,
 trini@konsulko.com
Date: Thu, 11 Jun 2026 18:34:19 +0530
Message-ID: <178118305958.1799417.3241467311184856154@freya>
User-Agent: alot/0.13.dev35+g4a69c46ca
X-Mailman-Approved-At: Thu, 11 Jun 2026 16:53:49 +0200
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

Hi Siddharth,

Thank you for the patch.

Quoting Siddharth Vadapalli (2026-06-11 17:36:50)
> Currently, phy_config() is invoked every time during am65_cpsw_start()
> which guarantees robustness and also allows recovering from link
> failures by resetting the Ethernet PHY. While this is beneficial for
> system stability, for use-cases where speed is prioritized over
> robustness, the existing implementation is insufficient.
>=20
> To support use-cases prioritizing speed while continuing to retain the
> existing behavior for robustness, sample the environment variable named
> "am65_cpsw_phy_config_once" to determine whether phy_config() should
> continue to be invoked once per invocation of am65_cpsw_start(), OR, it
> should only be invoked across invocations. Since the environment variable
> is not set by default, robustness is prioritized over speed. Use-cases
> which require speed can set "am65_cpsw_phy_config_once" to any of:
> '1', 'y', 'Y', 't' and 'T'
> based on the implementation of the env_get_yesno() helper function.
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>=20
> Hello,
>=20
> This patch is based on commit
> 3cdce049f90 erge tag 'u-boot-rockchip-20260610' of https://source.denx.de=
/u-boot/custodians/u-boot-rockchip
> of the master branch of U-Boot.
>=20
> Patch has been tested on J784S4 EVM which uses MCU CPSW2G for Ethernet
> functionality. The following test logs demonstrate the default behavior
> being retained in the absence of 'am65_cpsw_phy_config_once' environment
> variable being set to a logical true, followed by setting the environment
> variable to a logical true ('y') and observing the PHY Autonegotiation
> process being skipped, followed by setting the environment variable to a
> logical false ('n' but could be anything that isn't logically true based
> on the env_get_yesno() helper function) and verifying that we go back to
> the default behavior of performing PHY Autonegotiation again:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/6229b5a3b7d80cd0c2037a6=
364406bbe
>=20
> Regards,
> Siddharth.
>=20
>  drivers/net/ti/am65-cpsw-nuss.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-n=
uss.c
> index 84a3e44ecbc..a5cca52f674 100644
> --- a/drivers/net/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ti/am65-cpsw-nuss.c
> @@ -18,6 +18,7 @@
>  #include <dm/pinctrl.h>
>  #include <dma-uclass.h>
>  #include <dm/of_access.h>
> +#include <env.h>
>  #include <miiphy.h>
>  #include <net.h>
>  #include <phy.h>
> @@ -104,6 +105,7 @@ struct am65_cpsw_port {
>         fdt_addr_t      macsl_base;
>         bool            disabled;
>         u32             mac_control;
> +       bool            phy_configured;
>  };
> =20
>  struct am65_cpsw_common {
> @@ -313,7 +315,7 @@ static int am65_cpsw_start(struct udevice *dev)
>         struct am65_cpsw_port *port =3D &common->ports[priv->port_id];
>         struct am65_cpsw_port *port0 =3D &common->ports[0];
>         struct ti_udma_drv_chan_cfg_data *dma_rx_cfg_data;
> -       int ret, i;
> +       int ret, i, skip_phy_config_env;
> =20
>         if (common->started)
>                 return 0;
> @@ -426,10 +428,30 @@ static int am65_cpsw_start(struct udevice *dev)
>                        port->port_sgmii_base + AM65_CPSW_SGMII_CONTROL_RE=
G);
>         }
> =20
> -       ret =3D phy_config(priv->phydev);
> -       if (ret < 0) {
> -               dev_err(dev, "phy_config failed: %d", ret);
> -               goto err_dis_rx;
> +       /*
> +        * Invoking phy_config() every time that am65_cpsw_start() is exe=
cuted will
> +        * make the link robust. However, it delays every networking comm=
and such as
> +        * 'dhcp' and 'tftp'. For use-cases that prioritize speed over ro=
bustness,
> +        * phy_config() should be invoked only once. To support both use-=
cases,
> +        * sample the environment variable 'am65_cpsw_phy_config_once' to=
 switch
> +        * between:
> +        * a) Invoke phy_config() every time - Default behavior for robus=
tness
> +        * b) Invoke phy_config() once per driver probe - User configurab=
le behavior
> +        *    for speed.
> +        */
> +       skip_phy_config_env =3D env_get_yesno("am65_cpsw_phy_config_once"=
);
> +
> +       /* If environment variable is not defined, assume it to be false.=
 */
> +       if (skip_phy_config_env =3D=3D -1)
> +               skip_phy_config_env =3D 0;
> +
> +       if (!port->phy_configured || !skip_phy_config_env) {
> +               ret =3D phy_config(priv->phydev);
> +               if (ret < 0) {
> +                       dev_err(dev, "phy_config failed: %d", ret);
> +                       goto err_dis_rx;
> +               }
> +               port->phy_configured =3D true;
>         }

Tested-by: Jai Luthra <jai.luthra@ideasonboard.com> [on BeagleY-AI]

Although I was surprised there's no way to check the status of the phy link
through some controller bit that can maybe mark phy as unconfigured on next
attempt? Apologies if that's stupid, I don't understand networking =3D)

Cheers,
    Jai

> =20
>         ret =3D phy_startup(priv->phydev);
> --=20
> 2.51.1
>=20
>
