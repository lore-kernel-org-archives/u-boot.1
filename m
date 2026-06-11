Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6EECD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A61849A9;
	Thu, 11 Jun 2026 14:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lTo0k1zP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BD7883FEC; Thu, 11 Jun 2026 14:37:27 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAEB4838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 14:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nora.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=GqGaD2Ziq5rQhHqK388KtMv9cKnLok7SFGkCSDpYGxo=; b=lTo0k1zPTJUuDv7BeEDAclr6Oy
 cdYgQKCCwQMl3MiTkkuNnnIy3YW/s4RpzKnbsHZW98BYC0hzKm7TD9dL9wmyRMjYIcCREDZX1thSg
 r9nk5Q5PWr4w/oZSeB06nasMT2Kji9gehBXnvZ9eqCeOBQYq5h2fb23kzU20fSIUULqTQgiCndAp4
 KcR0DlsD/Dl69pJM3so4pX/WaHx4wlf4bjgqD0gvMvB9NoSc9oVTtn/ed8JQZ7XKgpJO1XsC9sOi5
 OCn4CUjECIiq33mCVSqTIO/E8eKUbqc5Y3fNwzPWKRA0E0SZ5zBI0NgjHzQ3RaiqGbJy6v9LkrId8
 UxHveAFQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wXeeu-000DCu-0G; Thu, 11 Jun 2026 14:37:20 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wXeet-0001Tr-2Y; Thu, 11 Jun 2026 14:37:19 +0200
Message-ID: <5257419be0ef387d85b7d3192ec03ca855bae95d.camel@ew.tq-group.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: allow skipping phy_config()
 for speed
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, jerome.forissier@arm.com, 
 trini@konsulko.com, c-vankar@ti.com, andrew.goodbody@linaro.org
Cc: u-boot@lists.denx.de, nm@ti.com, srk@ti.com, u-boot@ew.tq-group.com
Date: Thu, 11 Jun 2026 14:37:18 +0200
In-Reply-To: <20260611120652.3656640-1-s-vadapalli@ti.com>
References: <20260611120652.3656640-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 11 Jun 2026 14:44:23 +0200
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

On Thu, 2026-06-11 at 17:36 +0530, Siddharth Vadapalli wrote:
> Currently, phy_config() is invoked every time during am65_cpsw_start()
> which guarantees robustness and also allows recovering from link
> failures by resetting the Ethernet PHY. While this is beneficial for
> system stability, for use-cases where speed is prioritized over
> robustness, the existing implementation is insufficient.

Hi Siddharth,

I wonder if making this configurable is actually the best approach, and if =
we
can't find a way to make phy_config a no-op when there is already a valid l=
ink.
Is phy_config() actually needed to recover at all? I would expect regular
Ethernet PHYs to reestablish the link by themselves - I guess 1000BASE-T1
Single-Pair Ethernet might need this?

Some background:

In our vendor branch of U-Boot, we have reverted commit 05dc050059d2 ("net:=
 ti:
am65-cpsw-nuss: invoke phy_config() in driver's .start callback") because i=
t
made PXE boot with U-Boot's default config path selection pretty much unusa=
ble:
U-Boot would try a long list of TFTP paths based on different identifiers l=
ike
IP addresses, each time using a new TFTP context, thus resetting the PHY an=
d
reestablishing the link dozens of times before arriving at the correct path=
.

Another solution for the PXE problem might be to refactor the code not to
shutdown and startup the Ethernet for each attempt, but that would not help
scripts that use separate tftp commands or similar for a sequence of file
transfers.

Best,
Nora


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
>  	fdt_addr_t	macsl_base;
>  	bool		disabled;
>  	u32		mac_control;
> +	bool            phy_configured;
>  };
> =20
>  struct am65_cpsw_common {
> @@ -313,7 +315,7 @@ static int am65_cpsw_start(struct udevice *dev)
>  	struct am65_cpsw_port *port =3D &common->ports[priv->port_id];
>  	struct am65_cpsw_port *port0 =3D &common->ports[0];
>  	struct ti_udma_drv_chan_cfg_data *dma_rx_cfg_data;
> -	int ret, i;
> +	int ret, i, skip_phy_config_env;
> =20
>  	if (common->started)
>  		return 0;
> @@ -426,10 +428,30 @@ static int am65_cpsw_start(struct udevice *dev)
>  		       port->port_sgmii_base + AM65_CPSW_SGMII_CONTROL_REG);
>  	}
> =20
> -	ret =3D phy_config(priv->phydev);
> -	if (ret < 0) {
> -		dev_err(dev, "phy_config failed: %d", ret);
> -		goto err_dis_rx;
> +	/*
> +	 * Invoking phy_config() every time that am65_cpsw_start() is executed =
will
> +	 * make the link robust. However, it delays every networking command su=
ch as
> +	 * 'dhcp' and 'tftp'. For use-cases that prioritize speed over robustne=
ss,
> +	 * phy_config() should be invoked only once. To support both use-cases,
> +	 * sample the environment variable 'am65_cpsw_phy_config_once' to switc=
h
> +	 * between:
> +	 * a) Invoke phy_config() every time - Default behavior for robustness
> +	 * b) Invoke phy_config() once per driver probe - User configurable beh=
avior
> +	 *    for speed.
> +	 */
> +	skip_phy_config_env =3D env_get_yesno("am65_cpsw_phy_config_once");
> +
> +	/* If environment variable is not defined, assume it to be false. */
> +	if (skip_phy_config_env =3D=3D -1)
> +		skip_phy_config_env =3D 0;
> +
> +	if (!port->phy_configured || !skip_phy_config_env) {
> +		ret =3D phy_config(priv->phydev);
> +		if (ret < 0) {
> +			dev_err(dev, "phy_config failed: %d", ret);
> +			goto err_dis_rx;
> +		}
> +		port->phy_configured =3D true;
>  	}
> =20
>  	ret =3D phy_startup(priv->phydev);

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
