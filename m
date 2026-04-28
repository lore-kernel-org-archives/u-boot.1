Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB88FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 10:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AB658467F;
	Tue, 28 Apr 2026 12:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5733A8467A; Tue, 28 Apr 2026 12:04:26 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1874984658
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 08D101F80044
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:04:21 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 05DEDB40476; Tue, 28 Apr 2026 09:51:19 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 108BBB40465;
 Tue, 28 Apr 2026 09:51:19 +0000 (UTC)
Date: Tue, 28 Apr 2026 11:51:17 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/3] sunxi: spl: fix SPL_SUNXI_LED active low configuration
Message-ID: <afCDFbxEhVRzSyyq@collins>
References: <20260407223447.4956-1-andre.przywara@arm.com>
 <20260407223447.4956-2-andre.przywara@arm.com>
 <adfMQBPdntWy1KIq@shepard>
 <cf689aa6-4852-41c1-9c49-3c208e40d76b@cherry.de>
 <33493bbd-2364-4015-a3ab-858992800da9@arm.com>
 <8fd75285-39c3-4dfa-a163-41bc6628d995@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M0nSqsiRV/4rKIHG"
Content-Disposition: inline
In-Reply-To: <8fd75285-39c3-4dfa-a163-41bc6628d995@cherry.de>
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


--M0nSqsiRV/4rKIHG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Mon 27 Apr 26, 19:27, Quentin Schulz a =C3=A9crit :
> Hi Andre,
>=20
> On 4/27/26 3:07 PM, Andre Przywara wrote:
> > Hi Quentin, Paul,
> >=20
> > ah, it seems like LEDs are the "embedded bike shed", let me add my shade
> > of blue ;-)
> >=20
> > On 4/21/26 19:12, Quentin Schulz wrote:
> > > Hi Paul,
> > >=20
> > > On 4/9/26 5:56 PM, Paul Kocialkowski wrote:
> > > > Hi,
> > > >=20
> > > > On Wed 08 Apr 26, 00:34, Andre Przywara wrote:
> > > > > The newly introduced Allwinner SPL LED "framework" defined a
> > > > > SPL_SUNXI_LED_STATUS_STATE Kconfig symbol, that was supposed to d=
enote
> > > > > the active-low vs. active-high polarity of the LED. However this =
is
> > > > > a bool symbol, so it will simply vanish if not defined, and
> > > > > we cannot use
> > > > > it directly inside a C statement.
> > > > >=20
> > > > > Filter the symbol through the IS_ENABLED() macro, which will
> > > > > return 0 if
> > > > > the symbol is not defined, which is the intended value here.
> > > > >=20
> > > > > This fixes configuring LEDs with active-low polarity.
> > > > >=20
> > > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > > ---
> > > > > =C2=A0 board/sunxi/board.c | 2 +-
> > > > > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> > > > > index d7722d1858a..80dcae9c1a4 100644
> > > > > --- a/board/sunxi/board.c
> > > > > +++ b/board/sunxi/board.c
> > > > > @@ -563,7 +563,7 @@ static void
> > > > > sunxi_spl_store_dram_size(phys_addr_t dram_size)
> > > > > =C2=A0 static void status_led_init(void)
> > > > > =C2=A0 {
> > > > > =C2=A0 #if CONFIG_IS_ENABLED(SUNXI_LED_STATUS)
> > > > > -=C2=A0=C2=A0=C2=A0 unsigned int state =3D CONFIG_SPL_SUNXI_LED_S=
TATUS_STATE;
> > > > > +=C2=A0=C2=A0=C2=A0 unsigned int state =3D
> > > > > IS_ENABLED(CONFIG_SPL_SUNXI_LED_STATUS_STATE);
> > > >=20
> > > > Sorry I didn't react to the initial submission, but it feels like t=
he
> > > > CONFIG_SPL_SUNXI_LED_STATUS_STATE symbol really means
> > > > active-high if enabled
> > > > and active-low if disabled. The name would suggest that it's an
> > > > int with a value
> > > > of either 0 or 1 instead.
> > > >=20
> > >=20
> > > Yeah, I lazily renamed the old CONFIG_LED_STATUS_STATE which used to
> > > be an int range (0..2) and made it both specific for Allwinner as
> > > well as changing it into a bool.
> > >=20
> > > > I think it would be less confusing to call the symbol
> > > > CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_LOW and reverse its meaning,
> > > > so that we can
> > > > spare defining it in most configs (that will be active-high).
> > >=20
> > > You can also have
> > > default y
> > > in your symbol to not have to reverse the meaning.
> >=20
> > So what about:
> > config CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH
> >  =C2=A0=C2=A0=C2=A0=C2=A0default y
> > then?

Sounds good to me!

> > > > Also the description currently mentions "initial state" which
> > > > may be confusing
> > > > as it could refer to the state inherited after reset (e.g. due
> > > > to some pull
> > > > resistor) or the state we do set in the SPL.
> > > >=20
> > >=20
> > > It was the prompt for the now removed LED_STATUS_STATE. What are you
> > > suggesting instead?
> >=20
> > I came up with:
> > Whether the GPIO of the status LED must be set high or low to turn the
> > LED on.
> > Thoughts?

Looks good.

> > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int gpio =3D CONFIG_SPL_S=
UNXI_LED_STATUS_BIT;
> > > >=20
> > > > And while at it I would rename this to something like:
> > > > CONFIG_SPL_SUNXI_LED_STATUS_GPIO since it indicates the GPIO
> > > > number, not a
> > > > specific bit in a sunxi-specific kind of register.
> > > >=20
> > >=20
> > > Also a remnant of LED_STATUS_BIT* symbols. Either work for me.
> >=20
> > Yes, indeed CONFIG_LED_STATUS_GPIO makes much more sense.
> >=20
>=20
> CONFIG_SPL_SUNXI_LED_STATUS_GPIO I'm assuming?
>=20
> > Let me know what you think.
> >=20
>=20
> Ack to all but I also don't care too much about Allwinner. @Paul?

Yes Andre's proposal sounds fine, I'm all for it.

Thanks for looking at this.

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--M0nSqsiRV/4rKIHG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmnwgxQACgkQhP3B6o/u
lQynTQ//c2H3B8AQrI1ibCD/5n8S0I56hITpO8xSxB9HOLqtpY0wY0R6ZhX3RFQK
l2AmOhYhx+tjun7yeEDgQXTPERjBHdx7ZKgmewJTvcFyZbmdsHLE9jfl0Jvn8G+t
aaYbjZ7jZZHx7usIld6gA79li89sWunb8oSuFrYn8ps8/boGeiFQowoV9aPxIYWs
uraiOa9kyOTNEUBaXoFjoWh0IGRTdpPLRg/QmpzCq5rHwaFLKT5SXOLto9w4OA+E
vxPxpIXsprzzeJtwu2x/6HJLV5enGO8T05cLQ2EbNvHTvOr/U/Xin/umQ2A/4LIa
tSPlw1NSJfgfYFhly2DLwjplBW6n2uHSxd5bcwmiMr6ycaeEvPpfoxkiJxvReVwk
+v2lMO3cUgYs6ZCLff9hsHKJwdG9MuM+GghjMGq6EZ5wuNNE1nk19/0nsipaHUg5
ORL1CHWkuKmc2lebHbFYmp/4ZGlSjVlr4Sw9kHKr4g7r3J2rz4qruG5deGwtHpfL
9eJFgpxRxGPg8nV6IEX4PhV/QDaF2qnq5lBWrY/wKXsGuJ/eipocyAMH2PWYWXgl
pxBOZVFptbgYo07OrKfEr7IZMY0c8jwy+yfmuCbGWYcuMcWXTscioEaAz4uIsOUE
dAaWRMVpp9Zd4q2RmcLi67aimw7O33FQOyMg8jAUP2AmocsdZtw=
=T4IS
-----END PGP SIGNATURE-----

--M0nSqsiRV/4rKIHG--
