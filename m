Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE756CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E87848BA;
	Fri, 12 Jun 2026 14:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wDa5RaUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08A7783FF5; Fri, 12 Jun 2026 07:34:03 +0200 (CEST)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 743C48005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 07:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jai.luthra@ideasonboard.com
Received: from mail.ideasonboard.com (unknown
 [IPv6:2401:4900:1c68:bcf2:9325:a9bd:32b:e71])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id E8A5E42B;
 Fri, 12 Jun 2026 07:33:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781242409;
 bh=qLXLeprC5GbzYK0e+aQnapO4bDq7nje7KqEKyZyy+J0=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=wDa5RaUHqoSm20T1re28I9R3wl4RDRMin/ac6bFnheH+EEjXCQVGGRqgMDGs20+JU
 k8risbofoImC0gk9HhM6BHtegAoG9w4P5K5qQGsMXBlKYg/1bjbHQJEENSTkiWUVze
 Sk1mRtFVBrya6H2Gryek9CV7EeW7HHX4st+f9ZvA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <18490eb5-3ab5-4e78-a723-553983c9ed17@ti.com>
References: <20260611120652.3656640-1-s-vadapalli@ti.com>
 <178118305958.1799417.3241467311184856154@freya>
 <18490eb5-3ab5-4e78-a723-553983c9ed17@ti.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: allow skipping phy_config() for
 speed
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: andrew.goodbody@linaro.org, c-vankar@ti.com, jerome.forissier@arm.com,
 matthias.schiffer@ew.tq-group.com, trini@konsulko.com, u-boot@lists.denx.de,
 nm@ti.com, srk@ti.com, s-vadapalli@ti.com
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Date: Fri, 12 Jun 2026 11:03:54 +0530
Message-ID: <178124243466.1799417.15145017019051587066@freya>
User-Agent: alot/0.13.dev35+g4a69c46ca
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:36:02 +0200
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

Quoting Siddharth Vadapalli (2026-06-12 10:03:31)
> On 11/06/26 18:34, Jai Luthra wrote:
>=20
> Hello Jai,
>=20
> > Hi Siddharth,
> >=20
> > Thank you for the patch.
> >=20
> > Quoting Siddharth Vadapalli (2026-06-11 17:36:50)
> >> Currently, phy_config() is invoked every time during am65_cpsw_start()
> >> which guarantees robustness and also allows recovering from link
> >> failures by resetting the Ethernet PHY. While this is beneficial for
> >> system stability, for use-cases where speed is prioritized over
> >> robustness, the existing implementation is insufficient.
> >>
> >> To support use-cases prioritizing speed while continuing to retain the
> >> existing behavior for robustness, sample the environment variable named
> >> "am65_cpsw_phy_config_once" to determine whether phy_config() should
> >> continue to be invoked once per invocation of am65_cpsw_start(), OR, it
> >> should only be invoked across invocations. Since the environment varia=
ble
> >> is not set by default, robustness is prioritized over speed. Use-cases
> >> which require speed can set "am65_cpsw_phy_config_once" to any of:
> >> '1', 'y', 'Y', 't' and 'T'
> >> based on the implementation of the env_get_yesno() helper function.
> >>
> >> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >> ---
> >>
> >> Hello,
> >>
> >> This patch is based on commit
> >> 3cdce049f90 erge tag 'u-boot-rockchip-20260610' of https://source.denx=
.de/u-boot/custodians/u-boot-rockchip
> >> of the master branch of U-Boot.
> >>
> >> Patch has been tested on J784S4 EVM which uses MCU CPSW2G for Ethernet
> >> functionality. The following test logs demonstrate the default behavior
> >> being retained in the absence of 'am65_cpsw_phy_config_once' environme=
nt
> >> variable being set to a logical true, followed by setting the environm=
ent
> >> variable to a logical true ('y') and observing the PHY Autonegotiation
> >> process being skipped, followed by setting the environment variable to=
 a
> >> logical false ('n' but could be anything that isn't logically true bas=
ed
> >> on the env_get_yesno() helper function) and verifying that we go back =
to
> >> the default behavior of performing PHY Autonegotiation again:
> >> https://gist.github.com/Siddharth-Vadapalli-at-TI/6229b5a3b7d80cd0c203=
7a6364406bbe
> >>
> >> Regards,
> >> Siddharth.
> >>
> >>   drivers/net/ti/am65-cpsw-nuss.c | 32 +++++++++++++++++++++++++++-----
> >>   1 file changed, 27 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cps=
w-nuss.c
> >> index 84a3e44ecbc..a5cca52f674 100644
> >> --- a/drivers/net/ti/am65-cpsw-nuss.c
> >> +++ b/drivers/net/ti/am65-cpsw-nuss.c
> >> @@ -18,6 +18,7 @@
> >>   #include <dm/pinctrl.h>
> >>   #include <dma-uclass.h>
> >>   #include <dm/of_access.h>
> >> +#include <env.h>
> >>   #include <miiphy.h>
> >>   #include <net.h>
> >>   #include <phy.h>
> >> @@ -104,6 +105,7 @@ struct am65_cpsw_port {
> >>          fdt_addr_t      macsl_base;
> >>          bool            disabled;
> >>          u32             mac_control;
> >> +       bool            phy_configured;
> >>   };
> >>  =20
> >>   struct am65_cpsw_common {
> >> @@ -313,7 +315,7 @@ static int am65_cpsw_start(struct udevice *dev)
> >>          struct am65_cpsw_port *port =3D &common->ports[priv->port_id];
> >>          struct am65_cpsw_port *port0 =3D &common->ports[0];
> >>          struct ti_udma_drv_chan_cfg_data *dma_rx_cfg_data;
> >> -       int ret, i;
> >> +       int ret, i, skip_phy_config_env;
> >>  =20
> >>          if (common->started)
> >>                  return 0;
> >> @@ -426,10 +428,30 @@ static int am65_cpsw_start(struct udevice *dev)
> >>                         port->port_sgmii_base + AM65_CPSW_SGMII_CONTRO=
L_REG);
> >>          }
> >>  =20
> >> -       ret =3D phy_config(priv->phydev);
> >> -       if (ret < 0) {
> >> -               dev_err(dev, "phy_config failed: %d", ret);
> >> -               goto err_dis_rx;
> >> +       /*
> >> +        * Invoking phy_config() every time that am65_cpsw_start() is =
executed will
> >> +        * make the link robust. However, it delays every networking c=
ommand such as
> >> +        * 'dhcp' and 'tftp'. For use-cases that prioritize speed over=
 robustness,
> >> +        * phy_config() should be invoked only once. To support both u=
se-cases,
> >> +        * sample the environment variable 'am65_cpsw_phy_config_once'=
 to switch
> >> +        * between:
> >> +        * a) Invoke phy_config() every time - Default behavior for ro=
bustness
> >> +        * b) Invoke phy_config() once per driver probe - User configu=
rable behavior
> >> +        *    for speed.
> >> +        */
> >> +       skip_phy_config_env =3D env_get_yesno("am65_cpsw_phy_config_on=
ce");
> >> +
> >> +       /* If environment variable is not defined, assume it to be fal=
se. */
> >> +       if (skip_phy_config_env =3D=3D -1)
> >> +               skip_phy_config_env =3D 0;
> >> +
> >> +       if (!port->phy_configured || !skip_phy_config_env) {
> >> +               ret =3D phy_config(priv->phydev);
> >> +               if (ret < 0) {
> >> +                       dev_err(dev, "phy_config failed: %d", ret);
> >> +                       goto err_dis_rx;
> >> +               }
> >> +               port->phy_configured =3D true;
> >>          }
> >=20
> > Tested-by: Jai Luthra <jai.luthra@ideasonboard.com> [on BeagleY-AI]
>=20
> Thank you for testing the patch.
>=20
> >=20
> > Although I was surprised there's no way to check the status of the phy =
link
> > through some controller bit that can maybe mark phy as unconfigured on =
next
> > attempt? Apologies if that's stupid, I don't understand networking =3D)
> You do ask a good question. Maybe I should have clarified that in respons=
e=20
> to Nora's question.
>=20
> The issue discovered during automation is that the PHY reports the Link=20
> being UP, but doesn't send any packets out. Based on the statistics in th=
e=20
> MAC (Network Controller / CPSW), the packets are being sent from the MAC =
to=20
> the PHY, but the PHY isn't transmitting them on the Wire. At this stage, =

> simply resetting the Ethernet PHY by writing to its registers using the m=
ii=20
> command fixes the issue. Therefore, it seems to be a rare situation where=
in=20
> the PHY ends up in a bad state and the Link Status alone isn't sufficient=
=20
> to figure out whether the PHY is working. Hence, resetting the PHY on eve=
ry=20
> networking command and starting from scratch not only reduces the=20
> occurrences of the issue, but also helps us recover from the issue by=20
> rerunning the networking commands.
>=20
> Since certain users may prefer speed over stability, or alternatively,=20
> since users may prefer speed by default with the option to recover on the=
=20
> same boot in case they end up in such a situation, using an environment=20
> variable seemed to be the most flexible approach (build-time configs will=
=20
> only provide speed or stability but won't allow the user to switch betwee=
n=20
> them at runtime).
>=20
> I hope this clarifies your question. Let me know otherwise.
>=20

Thanks, that makes a lot of sense.

Given the failure happens once in two weeks with hundred of tests, I have a
slight preference for keeping the default to not call phy_config()
everytime, or maybe just documenting this environment variable prominently
somewhere, as most developers with a board on their desk would prefer a
broken link every two weeks as opposed to slow transfers.

But I understand anywhere with automation it's okay to spend a little more
time and keep it robust.

Thanks,
    Jai

> Regards,
> Siddharth.
