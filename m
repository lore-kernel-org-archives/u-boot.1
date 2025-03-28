Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64393C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 09:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B8981DCC;
	Fri, 28 Mar 2025 10:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CRak67h7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF3181E5A; Fri, 28 Mar 2025 10:06:21 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68CB181CFD
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 10:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1A9915C59DF;
 Fri, 28 Mar 2025 09:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF76C4CEE4;
 Fri, 28 Mar 2025 09:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743152776;
 bh=o7mBAsUf1pkfdT50mdwDpscAUpHFscwBW08jley4+BA=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
 b=CRak67h7HhTn1qZ/upiivSGLzwP2hrKUU2ns5NZ5qgfpvID8BXAkA9uJaJHggO0Dt
 jMMRwTf9zCjKbCjibW6dC7jGlQqlv0Nc8/r3VwLzy/Js6SB2bHGZnyHP3G4vlZ0Lrz
 zI9vf9EO3EJLRHxrvO5ALnoLwTrGBylfwgk/Wjz9x4oZJQwytrSFYzo6B9rSySNcZ4
 IADWFRlvEPY+rLuJmscm9n8ODLrE2xP4qP/9dDC+NpXCxAYEjQYGiLeHHFlMVwR39v
 xaEz2qc6ahz+pDXldIV7tjQPvAxv0REGfwU/ZCvLy5RWjbxmU9UOFUYiUzTnmDuZuE
 MT2E7mrnIrAZQ==
Content-Type: multipart/signed;
 boundary=d784c3fa8d0348f14f966854e9699600d5d1d4623c060916ba3a5bb9f965;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 28 Mar 2025 10:06:12 +0100
Message-Id: <D8RS34QA63LP.296JEK5L3IREQ@kernel.org>
Subject: Re: [PATCH 1/3] fastboot: lift restrictions on !NET_LWIP for USB
Cc: <u-boot@lists.denx.de>
From: "Michael Walle" <mwalle@kernel.org>
To: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>, "Tom Rini"
 <trini@konsulko.com>, "Jerome Forissier" <jerome.forissier@linaro.org>
X-Mailer: aerc 0.16.0
References: <20250312073655.2281377-1-mwalle@kernel.org>
 <87cyecdpf8.fsf@baylibre.com>
In-Reply-To: <87cyecdpf8.fsf@baylibre.com>
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

--d784c3fa8d0348f14f966854e9699600d5d1d4623c060916ba3a5bb9f965
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Mattijs,

> > Fastboot works either over TCP, UDP or USB. The latter doesn't have
> > anything to do with networking, thus should work just fine with
> > regardless which network stack is selected. In practice, header symbols
> > are used inside common code paths. Add some ifdeffery to guard against
> > that.
> >
> > This will make fastboot over USB work with the new LWIP stack.
> >
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
>
> checkpatch.pl reports some issues with this:
>
> $ ./scripts/checkpatch.pl --strict --u-boot --git HEAD^..HEAD
>
> <snip>
> WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' wher=
e possible
> <snip>
>
> Some occurences below could be fixed. Could you please have a look?

I've seen these. More below.

>
> > ---
> > Alternatively, we could add the defines and stub functions to the lwip
> > header.

This is relevant :)

> > ---
> >  cmd/fastboot.c               | 4 ++++
> >  drivers/fastboot/Kconfig     | 1 -
> >  drivers/fastboot/fb_common.c | 4 ++++
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> > index d4cfc0c7a28..be84a482b81 100644
> > --- a/cmd/fastboot.c
> > +++ b/cmd/fastboot.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/printk.h>
> >  #include <linux/stringify.h>
> > =20
> > +#if CONFIG_IS_ENABLED(NET)
>
> I think this can be dropped. I hope that since it's a static function,
> -if there are no users in the file- the compiler will optimize it out.
> Note: I have not verified this, so I might be wrong.
>
> If you measure and see size changes between keeping the #if and not
> keeping it, please ignore this comment.

No, because net_loop(), net_set_state() and NETLOOP_SUCCESS is only
defined in net-legacy.h. Thus we need this ifdeffery.. Unless of
course, we add the enums and function stubs to the new lwip net
inlcude. I don't know if that's a good idea though.

-michael

>
> >  static int do_fastboot_udp(int argc, char *const argv[],
> >  			   uintptr_t buf_addr, size_t buf_size)
> >  {
> > @@ -55,6 +56,7 @@ static int do_fastboot_tcp(int argc, char *const argv=
[],
> > =20
> >  	return CMD_RET_SUCCESS;
> >  }
> > +#endif
> > =20
> >  static int do_fastboot_usb(int argc, char *const argv[],
> >  			   uintptr_t buf_addr, size_t buf_size)
> > @@ -160,10 +162,12 @@ NXTARG:
> > =20
> >  	fastboot_init((void *)buf_addr, buf_size);
> > =20
> > +#if CONFIG_IS_ENABLED(NET)
> >  	if (!strcmp(argv[1], "udp"))
> >  		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
> >  	if (!strcmp(argv[1], "tcp"))
> >  		return do_fastboot_tcp(argc, argv, buf_addr, buf_size);
> > +#endif
>
> This can be replaced with:
>
> 	if (IS_ENABLED(CONFIG_NET)) {
> 		if (!strcmp(argv[1], "udp"))
> 			return do_fastboot_udp(argc, argv, buf_addr, buf_size);
> 		if (!strcmp(argv[1], "tcp"))
> 			return do_fastboot_tcp(argc, argv, buf_addr, buf_size);
> 	}
>
> >  	if (!strcmp(argv[1], "usb")) {
> >  		argv++;
> >  		argc--;
> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> > index 1eb460f5a02..70207573de2 100644
> > --- a/drivers/fastboot/Kconfig
> > +++ b/drivers/fastboot/Kconfig
> > @@ -1,6 +1,5 @@
> >  menu "Fastboot support"
> >  	depends on CMDLINE
> > -	depends on !NET_LWIP
> > =20
> >  config FASTBOOT
> >  	bool
> > diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.=
c
> > index 12ffb463deb..68f92c4b887 100644
> > --- a/drivers/fastboot/fb_common.c
> > +++ b/drivers/fastboot/fb_common.c
> > @@ -183,11 +183,15 @@ void fastboot_handle_boot(int command, bool succe=
ss)
> >  	switch (command) {
> >  	case FASTBOOT_COMMAND_BOOT:
> >  		fastboot_boot();
> > +#if CONFIG_IS_ENABLED(NET)
> >  		net_set_state(NETLOOP_SUCCESS);
> > +#endif
>
> This can be replaced with:
>
> 		if (IS_ENABLED((CONFIG_NET))
> 		    net_set_state(NETLOOP_SUCCESS);
>
> >  		break;
> > =20
> >  	case FASTBOOT_COMMAND_CONTINUE:
> > +#if CONFIG_IS_ENABLED(NET)
> >  		net_set_state(NETLOOP_SUCCESS);
> > +#endif
>
> Same here.
>
> >  		break;
> > =20
> >  	case FASTBOOT_COMMAND_REBOOT:
> > --=20
> > 2.39.5


--d784c3fa8d0348f14f966854e9699600d5d1d4623c060916ba3a5bb9f965
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ+ZmhRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hiUQGAkFo1JsVncUdJen/oGAaUbtiuUmC/sEkX
tENNUEWmCR+VSK2F86VlIWZrX934rZ9YAX9uQke28tkMAtzYtBm5XMYk0qOWT3sx
R4f3C70i9HfnjBjKfrpVcY5rSsOZmEYtVnY=
=+BLy
-----END PGP SIGNATURE-----

--d784c3fa8d0348f14f966854e9699600d5d1d4623c060916ba3a5bb9f965--
