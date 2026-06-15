Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADC1CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5696984995;
	Mon, 15 Jun 2026 10:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Z6rrrWmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB94784704; Mon, 15 Jun 2026 09:29:15 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3661083FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nora.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=5+r5t/phmgrs9i084fCZJq92hRXGEeLINZVfIjhuP+g=; b=Z6rrrWmTCFGEiMj6kbb9o6Mq2A
 GKpWviOSuOp9CKvAQowXYqqiRueABP9lqBa2YpbKR1p/KDU5Vcx1n8JeRNazohm4Ps81HtLINBv94
 FrPpvhFQ9ecotTIxuBT78Rj4sYQibPuAjS4nnwHd68+zfUrDP9GH4keH/cNv4i4WxF1BLX3HDweYO
 b4OpU/kHMl82PUpZ0zs+ppyeUcCZNgdBo2oQOff8muw8jEGBRlWVttB/wTTTb+F2fZaovDMzh+tRm
 c+BsTsAcnxQXc9t51FVDzKyeOJDeRqTDhPJGoWJD3RRuRmuLz+hePLSZYl2YQtD3bs37QQKcPkNP7
 gXKE+cRg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wZ1kq-000Hdk-2W; Mon, 15 Jun 2026 09:29:08 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wZ1kp-0000oB-1f; Mon, 15 Jun 2026 09:29:08 +0200
Message-ID: <10236b090b3e6c1ca978c4d71a9d4b15abf3e1b3.camel@ew.tq-group.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: allow skipping phy_config()
 for speed
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Jai Luthra
 <jai.luthra@ideasonboard.com>
Cc: andrew.goodbody@linaro.org, c-vankar@ti.com, jerome.forissier@arm.com, 
 matthias.schiffer@ew.tq-group.com, trini@konsulko.com,
 u-boot@lists.denx.de,  nm@ti.com, srk@ti.com
Date: Mon, 15 Jun 2026 09:29:07 +0200
In-Reply-To: <18490eb5-3ab5-4e78-a723-553983c9ed17@ti.com>
References: <20260611120652.3656640-1-s-vadapalli@ti.com>
 <178118305958.1799417.3241467311184856154@freya>
 <18490eb5-3ab5-4e78-a723-553983c9ed17@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 15 Jun 2026 10:34:58 +0200
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

On Fri, 2026-06-12 at 10:03 +0530, Siddharth Vadapalli wrote:
> On 11/06/26 18:34, Jai Luthra wrote:
>=20
> Hello Jai,
>=20
> > Hi Siddharth,
> >=20
> > Thank you for the patch.
> >=20
> > Quoting Siddharth Vadapalli (2026-06-11 17:36:50)
> > > Currently, phy_config() is invoked every time during am65_cpsw_start(=
)
> > > which guarantees robustness and also allows recovering from link
> > > failures by resetting the Ethernet PHY. While this is beneficial for
> > > system stability, for use-cases where speed is prioritized over
> > > robustness, the existing implementation is insufficient.
> > >=20
> > > To support use-cases prioritizing speed while continuing to retain th=
e
> > > existing behavior for robustness, sample the environment variable nam=
ed
> > > "am65_cpsw_phy_config_once" to determine whether phy_config() should
> > > continue to be invoked once per invocation of am65_cpsw_start(), OR, =
it
> > > should only be invoked across invocations. Since the environment vari=
able
> > > is not set by default, robustness is prioritized over speed. Use-case=
s
> > > which require speed can set "am65_cpsw_phy_config_once" to any of:
> > > '1', 'y', 'Y', 't' and 'T'
> > > based on the implementation of the env_get_yesno() helper function.
> > >=20
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > ---
> > >=20
> > > Hello,
> > >=20
> > > This patch is based on commit
> > > 3cdce049f90 erge tag 'u-boot-rockchip-20260610' of https://source.den=
x.de/u-boot/custodians/u-boot-rockchip
> > > of the master branch of U-Boot.
> > >=20
> > > Patch has been tested on J784S4 EVM which uses MCU CPSW2G for Etherne=
t
> > > functionality. The following test logs demonstrate the default behavi=
or
> > > being retained in the absence of 'am65_cpsw_phy_config_once' environm=
ent
> > > variable being set to a logical true, followed by setting the environ=
ment
> > > variable to a logical true ('y') and observing the PHY Autonegotiatio=
n
> > > process being skipped, followed by setting the environment variable t=
o a
> > > logical false ('n' but could be anything that isn't logically true ba=
sed
> > > on the env_get_yesno() helper function) and verifying that we go back=
 to
> > > the default behavior of performing PHY Autonegotiation again:
> > > https://gist.github.com/Siddharth-Vadapalli-at-TI/6229b5a3b7d80cd0c20=
37a6364406bbe
> > >=20
> > > Regards,
> > > Siddharth.
> > >=20
> > >   drivers/net/ti/am65-cpsw-nuss.c | 32 +++++++++++++++++++++++++++---=
--
> > >   1 file changed, 27 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cp=
sw-nuss.c
> > > index 84a3e44ecbc..a5cca52f674 100644
> > > --- a/drivers/net/ti/am65-cpsw-nuss.c
> > > +++ b/drivers/net/ti/am65-cpsw-nuss.c
> > > @@ -18,6 +18,7 @@
> > >   #include <dm/pinctrl.h>
> > >   #include <dma-uclass.h>
> > >   #include <dm/of_access.h>
> > > +#include <env.h>
> > >   #include <miiphy.h>
> > >   #include <net.h>
> > >   #include <phy.h>
> > > @@ -104,6 +105,7 @@ struct am65_cpsw_port {
> > >          fdt_addr_t      macsl_base;
> > >          bool            disabled;
> > >          u32             mac_control;
> > > +       bool            phy_configured;
> > >   };
> > >  =20
> > >   struct am65_cpsw_common {
> > > @@ -313,7 +315,7 @@ static int am65_cpsw_start(struct udevice *dev)
> > >          struct am65_cpsw_port *port =3D &common->ports[priv->port_id=
];
> > >          struct am65_cpsw_port *port0 =3D &common->ports[0];
> > >          struct ti_udma_drv_chan_cfg_data *dma_rx_cfg_data;
> > > -       int ret, i;
> > > +       int ret, i, skip_phy_config_env;
> > >  =20
> > >          if (common->started)
> > >                  return 0;
> > > @@ -426,10 +428,30 @@ static int am65_cpsw_start(struct udevice *dev)
> > >                         port->port_sgmii_base + AM65_CPSW_SGMII_CONTR=
OL_REG);
> > >          }
> > >  =20
> > > -       ret =3D phy_config(priv->phydev);
> > > -       if (ret < 0) {
> > > -               dev_err(dev, "phy_config failed: %d", ret);
> > > -               goto err_dis_rx;
> > > +       /*
> > > +        * Invoking phy_config() every time that am65_cpsw_start() is=
 executed will
> > > +        * make the link robust. However, it delays every networking =
command such as
> > > +        * 'dhcp' and 'tftp'. For use-cases that prioritize speed ove=
r robustness,
> > > +        * phy_config() should be invoked only once. To support both =
use-cases,
> > > +        * sample the environment variable 'am65_cpsw_phy_config_once=
' to switch
> > > +        * between:
> > > +        * a) Invoke phy_config() every time - Default behavior for r=
obustness
> > > +        * b) Invoke phy_config() once per driver probe - User config=
urable behavior
> > > +        *    for speed.
> > > +        */
> > > +       skip_phy_config_env =3D env_get_yesno("am65_cpsw_phy_config_o=
nce");
> > > +
> > > +       /* If environment variable is not defined, assume it to be fa=
lse. */
> > > +       if (skip_phy_config_env =3D=3D -1)
> > > +               skip_phy_config_env =3D 0;
> > > +
> > > +       if (!port->phy_configured || !skip_phy_config_env) {
> > > +               ret =3D phy_config(priv->phydev);
> > > +               if (ret < 0) {
> > > +                       dev_err(dev, "phy_config failed: %d", ret);
> > > +                       goto err_dis_rx;
> > > +               }
> > > +               port->phy_configured =3D true;
> > >          }
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
> The issue discovered during automation is that the PHY reports the Link=
=20
> being UP, but doesn't send any packets out. Based on the statistics in th=
e=20
> MAC (Network Controller / CPSW), the packets are being sent from the MAC =
to=20
> the PHY, but the PHY isn't transmitting them on the Wire. At this stage,=
=20
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

It would be really good to figure out what is going on here. If the PHY can=
 get
into a state where it incorrectly reports a link, shouldn't the OS be affec=
ted
as well and not just U-Boot? We don't randomly reset the PHY under Linux ei=
ther
after all.

I accept that this option may be a valid stopgap measure lacking a proper
solution, but it does seem to me like it allows you to choose between
"unreliable" and "unusable" for some applications like the mentioned PXE bo=
ot,
and neither sounds desirable...

Best,
Nora


>=20
> Since certain users may prefer speed over stability, or alternatively,=
=20
> since users may prefer speed by default with the option to recover on the=
=20
> same boot in case they end up in such a situation, using an environment=
=20
> variable seemed to be the most flexible approach (build-time configs will=
=20
> only provide speed or stability but won't allow the user to switch betwee=
n=20
> them at runtime).
>=20
> I hope this clarifies your question. Let me know otherwise.
>=20
> Regards,
> Siddharth.

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
