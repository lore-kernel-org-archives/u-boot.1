Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA74CD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 943B8846A4;
	Mon, 15 Jun 2026 14:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="g22GlAfF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1043284704; Mon, 15 Jun 2026 13:16:28 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76F34846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 13:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nora.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Qy5u1gwlXNY1gECZSEMqbjTZBPJqyB8PpGTez2SzgPU=; b=g22GlAfFocHwl3uNMHUbSCHjCO
 y+HzzPjXfUynhj0r+8vMSSR081TBXm7xCr277uVthf6/PSmETrUZs+RTOWF56TGLMnAwonNHR0Fwd
 cMqEzxA2We5x45E/surP5Dy2dE4Fx2Y6JTbPZNNQpTWHGtBDznUnPj6gc3lIikbmNEGKB3tQwJ8qY
 uUuy+oBFuvPxpniu/jJlquXwxAgog3oXXXQ4IfKQBxCT6iyHyxNx/gCzzwX6/8okXKcx4SzRLokJ5
 3obqWtSgBqS6LIpjnWmP8CH4gL99I2aOCezFLdFtXI/GN1Pggp6UXdh/r3C6rsvukv0xgxocEdwQw
 jYR4hgow==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wZ5Ii-0002fX-2K; Mon, 15 Jun 2026 13:16:20 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wZ5Ih-0002OF-1H; Mon, 15 Jun 2026 13:16:20 +0200
Message-ID: <9d16a17d1e0cea6a129700248896e90c4d74729d.camel@ew.tq-group.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: allow skipping phy_config()
 for speed
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Jai Luthra <jai.luthra@ideasonboard.com>, andrew.goodbody@linaro.org, 
 c-vankar@ti.com, jerome.forissier@arm.com,
 matthias.schiffer@ew.tq-group.com,  trini@konsulko.com,
 u-boot@lists.denx.de, nm@ti.com, srk@ti.com
Date: Mon, 15 Jun 2026 13:16:19 +0200
In-Reply-To: <0d62b807-4205-4b65-bed7-d8686b5386cd@ti.com>
References: <20260611120652.3656640-1-s-vadapalli@ti.com>
 <178118305958.1799417.3241467311184856154@freya>
 <18490eb5-3ab5-4e78-a723-553983c9ed17@ti.com>
 <10236b090b3e6c1ca978c4d71a9d4b15abf3e1b3.camel@ew.tq-group.com>
 <0d62b807-4205-4b65-bed7-d8686b5386cd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 15 Jun 2026 14:45:23 +0200
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

On Mon, 2026-06-15 at 13:21 +0530, Siddharth Vadapalli wrote:
> On 15/06/26 12:59, Nora Schiffer wrote:
> > On Fri, 2026-06-12 at 10:03 +0530, Siddharth Vadapalli wrote:
> > > On 11/06/26 18:34, Jai Luthra wrote:
> > >=20
> > > Hello Jai,
> > >=20
> > > > Hi Siddharth,
> > > >=20
> > > > Thank you for the patch.
> > > >=20
> > > > Quoting Siddharth Vadapalli (2026-06-11 17:36:50)
> > > > > Currently, phy_config() is invoked every time during am65_cpsw_st=
art()
> > > > > which guarantees robustness and also allows recovering from link
> > > > > failures by resetting the Ethernet PHY. While this is beneficial =
for
> > > > > system stability, for use-cases where speed is prioritized over
> > > > > robustness, the existing implementation is insufficient.
> > > > >=20
> > > > > To support use-cases prioritizing speed while continuing to retai=
n the
> > > > > existing behavior for robustness, sample the environment variable=
 named
> > > > > "am65_cpsw_phy_config_once" to determine whether phy_config() sho=
uld
> > > > > continue to be invoked once per invocation of am65_cpsw_start(), =
OR, it
> > > > > should only be invoked across invocations. Since the environment =
variable
> > > > > is not set by default, robustness is prioritized over speed. Use-=
cases
> > > > > which require speed can set "am65_cpsw_phy_config_once" to any of=
:
> > > > > '1', 'y', 'Y', 't' and 'T'
> > > > > based on the implementation of the env_get_yesno() helper functio=
n.
> > > > >=20
> > > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > > ---
> > > > >=20
> > > > > Hello,
> > > > >=20
> > > > > This patch is based on commit
> > > > > 3cdce049f90 erge tag 'u-boot-rockchip-20260610' of https://source=
.denx.de/u-boot/custodians/u-boot-rockchip
> > > > > of the master branch of U-Boot.
> > > > >=20
> > > > > Patch has been tested on J784S4 EVM which uses MCU CPSW2G for Eth=
ernet
> > > > > functionality. The following test logs demonstrate the default be=
havior
> > > > > being retained in the absence of 'am65_cpsw_phy_config_once' envi=
ronment
> > > > > variable being set to a logical true, followed by setting the env=
ironment
> > > > > variable to a logical true ('y') and observing the PHY Autonegoti=
ation
> > > > > process being skipped, followed by setting the environment variab=
le to a
> > > > > logical false ('n' but could be anything that isn't logically tru=
e based
> > > > > on the env_get_yesno() helper function) and verifying that we go =
back to
> > > > > the default behavior of performing PHY Autonegotiation again:
> > > > > https://gist.github.com/Siddharth-Vadapalli-at-TI/6229b5a3b7d80cd=
0c2037a6364406bbe
> > > > >=20
> > > > > Regards,
> > > > > Siddharth.
> > > > >=20
> > > > >    drivers/net/ti/am65-cpsw-nuss.c | 32 +++++++++++++++++++++++++=
++-----
> > > > >    1 file changed, 27 insertions(+), 5 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am6=
5-cpsw-nuss.c
> > > > > index 84a3e44ecbc..a5cca52f674 100644
> > > > > --- a/drivers/net/ti/am65-cpsw-nuss.c
> > > > > +++ b/drivers/net/ti/am65-cpsw-nuss.c
> > > > > @@ -18,6 +18,7 @@
> > > > >    #include <dm/pinctrl.h>
> > > > >    #include <dma-uclass.h>
> > > > >    #include <dm/of_access.h>
> > > > > +#include <env.h>
> > > > >    #include <miiphy.h>
> > > > >    #include <net.h>
> > > > >    #include <phy.h>
> > > > > @@ -104,6 +105,7 @@ struct am65_cpsw_port {
> > > > >           fdt_addr_t      macsl_base;
> > > > >           bool            disabled;
> > > > >           u32             mac_control;
> > > > > +       bool            phy_configured;
> > > > >    };
> > > > >   =20
> > > > >    struct am65_cpsw_common {
> > > > > @@ -313,7 +315,7 @@ static int am65_cpsw_start(struct udevice *de=
v)
> > > > >           struct am65_cpsw_port *port =3D &common->ports[priv->po=
rt_id];
> > > > >           struct am65_cpsw_port *port0 =3D &common->ports[0];
> > > > >           struct ti_udma_drv_chan_cfg_data *dma_rx_cfg_data;
> > > > > -       int ret, i;
> > > > > +       int ret, i, skip_phy_config_env;
> > > > >   =20
> > > > >           if (common->started)
> > > > >                   return 0;
> > > > > @@ -426,10 +428,30 @@ static int am65_cpsw_start(struct udevice *=
dev)
> > > > >                          port->port_sgmii_base + AM65_CPSW_SGMII_=
CONTROL_REG);
> > > > >           }
> > > > >   =20
> > > > > -       ret =3D phy_config(priv->phydev);
> > > > > -       if (ret < 0) {
> > > > > -               dev_err(dev, "phy_config failed: %d", ret);
> > > > > -               goto err_dis_rx;
> > > > > +       /*
> > > > > +        * Invoking phy_config() every time that am65_cpsw_start(=
) is executed will
> > > > > +        * make the link robust. However, it delays every network=
ing command such as
> > > > > +        * 'dhcp' and 'tftp'. For use-cases that prioritize speed=
 over robustness,
> > > > > +        * phy_config() should be invoked only once. To support b=
oth use-cases,
> > > > > +        * sample the environment variable 'am65_cpsw_phy_config_=
once' to switch
> > > > > +        * between:
> > > > > +        * a) Invoke phy_config() every time - Default behavior f=
or robustness
> > > > > +        * b) Invoke phy_config() once per driver probe - User co=
nfigurable behavior
> > > > > +        *    for speed.
> > > > > +        */
> > > > > +       skip_phy_config_env =3D env_get_yesno("am65_cpsw_phy_conf=
ig_once");
> > > > > +
> > > > > +       /* If environment variable is not defined, assume it to b=
e false. */
> > > > > +       if (skip_phy_config_env =3D=3D -1)
> > > > > +               skip_phy_config_env =3D 0;
> > > > > +
> > > > > +       if (!port->phy_configured || !skip_phy_config_env) {
> > > > > +               ret =3D phy_config(priv->phydev);
> > > > > +               if (ret < 0) {
> > > > > +                       dev_err(dev, "phy_config failed: %d", ret=
);
> > > > > +                       goto err_dis_rx;
> > > > > +               }
> > > > > +               port->phy_configured =3D true;
> > > > >           }
> > > >=20
> > > > Tested-by: Jai Luthra <jai.luthra@ideasonboard.com> [on BeagleY-AI]
> > >=20
> > > Thank you for testing the patch.
> > >=20
> > > >=20
> > > > Although I was surprised there's no way to check the status of the =
phy link
> > > > through some controller bit that can maybe mark phy as unconfigured=
 on next
> > > > attempt? Apologies if that's stupid, I don't understand networking =
=3D)
> > > You do ask a good question. Maybe I should have clarified that in res=
ponse
> > > to Nora's question.
> > >=20
> > > The issue discovered during automation is that the PHY reports the Li=
nk
> > > being UP, but doesn't send any packets out. Based on the statistics i=
n the
> > > MAC (Network Controller / CPSW), the packets are being sent from the =
MAC to
> > > the PHY, but the PHY isn't transmitting them on the Wire. At this sta=
ge,
> > > simply resetting the Ethernet PHY by writing to its registers using t=
he mii
> > > command fixes the issue. Therefore, it seems to be a rare situation w=
herein
> > > the PHY ends up in a bad state and the Link Status alone isn't suffic=
ient
> > > to figure out whether the PHY is working. Hence, resetting the PHY on=
 every
> > > networking command and starting from scratch not only reduces the
> > > occurrences of the issue, but also helps us recover from the issue by
> > > rerunning the networking commands.
> >=20
> > It would be really good to figure out what is going on here. If the PHY=
 can get
> > into a state where it incorrectly reports a link, shouldn't the OS be a=
ffected
> > as well and not just U-Boot? We don't randomly reset the PHY under Linu=
x either
> > after all.
>=20
> While that's true, users do have an option to restart the Auto-Negotiatio=
n=20
> process via 'ethtool' command in Linux, and its equivalent isn't possible=
=20
> without invoking a 'phy_config' in am65_cpsw_start in U-Boot. I did try=
=20
> figuring out what might be going wrong with the PHY but wasn't able to=
=20
> root-cause it. I don't know the internals of the PHY so I cannot comment =
on=20
> it. In my experimentation, resetting the Ethernet PHY fixed the issue and=
 I=20
> chose to allow users to do the same so that they don't have to reset the=
=20
> SoC for Ethernet Functionality at U-Boot in case it fails.
>=20
> >=20
> > I accept that this option may be a valid stopgap measure lacking a prop=
er
> > solution, but it does seem to me like it allows you to choose between
> > "unreliable" and "unusable" for some applications like the mentioned PX=
E boot,
> > and neither sounds desirable...
>=20
> The terms "unreliable" and "unusable" don't seem right to me for the PXE=
=20
> boot issue that you are referring to.

You are right, "unreliable" is not entirely accurate, at least not when the=
 PXE
boot is run right after a full board reset which should get the PHY into a
working state.

I would argue that PXE boot taking up to a minute instead of a few seconds
because it resets the PHY and reestablishes the link ~10 times could be cal=
led
"unusable".

>=20
> Invoking "phy_config" on every invocation of "am65_cpsw_start" seems to=
=20
> cause PXE boot to fail and to address this you can set=20
> "am65_cpsw_phy_config_once" to true. Eventually, if network functionality=
=20
> fails, you only need to set "am65_cpsw_phy_config_once" to false, rerun t=
he=20
> networking command once, and set "am65_cpsw_phy_config_once" to true agai=
n,=20
> thereby recovering from the issue.
>=20
> It will help if you clarify why providing the above option to users is a=
=20
> bad idea. I am not forcing users to choose either of them at build time.
>=20
> The alternative you are proposing seems to be that of reverting an earlie=
r=20
> commit (as you have done in your vendor tree), but that causes stability=
=20
> issues. Therefore, to address your use-case, instead of reverting the=20
> commit, you can still set "am65_cpsw_phy_config_once" to true to get the=
=20
> exact same behavior as reverting an earlier commit. Hence, I am failing t=
o=20
> understand your concern with the flexibility offered by this patch.

My main concern is that this is only a workaround, not a real solution - I'=
m
neutral wrt whether this patch should be applied or not. If it is applied, =
we
are likely going to set the variable in our default env in future TQ releas=
es.

One question is why this variable and behavior should be specific to the am=
65
Ethernet driver, when it looks like it is actually a PHY issue - and if it =
is
made more generic, what the default behavior should be.

Best,
Nora



>=20
> Kindly let me know.
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
