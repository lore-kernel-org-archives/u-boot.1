Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C6ACF2590
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 03:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC7C388D72;
	Mon, 14 Oct 2024 05:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pBtRpj0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2FAB88DB1; Mon, 14 Oct 2024 05:51:30 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80B038641A
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 05:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b11704601cso317335485a.3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 20:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728877887; x=1729482687; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rwszGmyLOgrm7lAIpEq0dcAV+goUMLjpfs8uuE3jVh0=;
 b=pBtRpj0TwvikVPc2xbfyqTb+PJ8io9PsAuuijGbNHl974lT7UY2ekKgvdZlx3UCCAw
 ZhkBeppiXtl0jDYawgzf/GkSBdmkDBhPC+SWK/LUqK0NiCxmdKhwPgmOzt2oWXLbvt5Q
 u6k49Rkrtg5+AIx/zSnL5xb/tVd/04xaAZeR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728877887; x=1729482687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwszGmyLOgrm7lAIpEq0dcAV+goUMLjpfs8uuE3jVh0=;
 b=YygHHyUccYJGDVUbxyvP1kcbNQMJDYJtYpjvKauk/wPr6ZSRUbBJn3u/qNOI/bwzBR
 X0hvXFOo4iZ79nzLjjtZCA9Rzvgg6cJWwL7m31bg7o6EDRmyd7EeFzXMqJk9fCqeFsOo
 6+Nrzh/qX3YeTwZSCmOo5zzRwaoopUpmZBXHmQps9G+1qM9ApuILl9ikNe1mPZrr4GGd
 zzwgcbzB7tE1tgYCBbjkfiAXQVkgWlH2BZ6jTtKzaJG1HlW9QzE2fKh9lsedEJ454qTk
 xCVBh/R1PfuFjeCz8Vg+9d/w7MeH8ofiKRPN8xDxNwF/ffz4Ua/eIrmRKQMhAjIfRP+d
 k7Gg==
X-Gm-Message-State: AOJu0Ywl0c3BQ01WXz3O+EMpCFWM27+Jjymep//noVaTv1nxDanmq5dn
 XsRcx0a5ffZNXVRcoBegL8vUpR2EoMGpmA5WJ+CvzHVnYYF9XGQt/pRaXj0x7Y0=
X-Google-Smtp-Source: AGHT+IFIFGlNL/cE+1pDeacEx8uagYvaOFEDeMrbrD/JGRCWkfHKGYR9TFGfHxR9IcoFqD5nrjZ3Cw==
X-Received: by 2002:a05:620a:24d2:b0:7a9:ac2d:5962 with SMTP id
 af79cd13be357-7b120faaadbmr1088794185a.8.1728877887068; 
 Sun, 13 Oct 2024 20:51:27 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1149893basm373721085a.134.2024.10.13.20.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 20:51:24 -0700 (PDT)
Date: Sun, 13 Oct 2024 21:51:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v6 12/12] test: efi: boot: Add a test for the efi bootmeth
Message-ID: <20241014035122.GE53053@bill-the-cat>
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-13-sjg@chromium.org>
 <20241011223227.GA630742@bill-the-cat>
 <CAFLszTgoxND_qi8WzdgC8-mQLf0e14Mt=KgXy=bqWkqo4svG9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j2ausO5Mv5ax3b4y"
Content-Disposition: inline
In-Reply-To: <CAFLszTgoxND_qi8WzdgC8-mQLf0e14Mt=KgXy=bqWkqo4svG9Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--j2ausO5Mv5ax3b4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 01:33:23PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 11 Oct 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Sep 27, 2024 at 12:02:23AM +0200, Simon Glass wrote:
> >
> > > Add a simple test of booting with the EFI bootmeth, which runs the app
> > > and checks that it can call 'exit boot-services' (to check that all t=
he
> > > device-removal code doesn't break anything) and then exit back to
> > > U-Boot.
> > >
> > > This uses a disk image containing the testapp, ready for execution by
> > > sandbox when needed.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > So lets go to the problem point. What asserts here fail due to ANSI
> > escape codes being in the output and needing to be filtered out?
> >
> > [snip]
> > > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> > > index e05103188b4..da2ee1ab345 100644
> > > --- a/test/boot/bootflow.c
> > > +++ b/test/boot/bootflow.c
> > > @@ -13,6 +13,7 @@
> > >  #include <cli.h>
> > >  #include <dm.h>
> > >  #include <efi_default_filename.h>
> > > +#include <efi_loader.h>
> > >  #include <expo.h>
> > >  #ifdef CONFIG_SANDBOX
> > >  #include <asm/test.h>
> > > @@ -31,6 +32,9 @@ extern U_BOOT_DRIVER(bootmeth_android);
> > >  extern U_BOOT_DRIVER(bootmeth_cros);
> > >  extern U_BOOT_DRIVER(bootmeth_2script);
> > >
> > > +/* Use this as the vendor for EFI to tell the app to exit boot servi=
ces */
> > > +static u16 __efi_runtime_data test_vendor[] =3D u"U-Boot testing";
> > > +
> > >  static int inject_response(struct unit_test_state *uts)
> > >  {
> > >       /*
> > > @@ -1205,3 +1209,62 @@ static int bootflow_android(struct unit_test_s=
tate *uts)
> > >       return 0;
> > >  }
> > >  BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
> > > +
> > > +/* Test EFI bootmeth */
> > > +static int bootflow_efi(struct unit_test_state *uts)
> > > +{
> > > +     /* disable ethernet since the hunter will run dhcp */
> > > +     test_set_eth_enable(false);
> > > +
> > > +     /* make USB scan without delays */
> > > +     test_set_skip_delays(true);
> > > +
> > > +     bootstd_reset_usb();
> > > +
> > > +     /* Avoid outputting ANSI characters which mess with our asserts=
 */
> > > +     efi_console_set_ansi(false);
> > > +
> > > +     ut_assertok(bootstd_test_drop_bootdev_order(uts));
> > > +     ut_assertok(run_command("bootflow scan", 0));
> > > +     ut_assert_skip_to_line(
> > > +             "Bus usb@1: scanning bus usb@1 for devices... 5 USB Dev=
ice(s) found");
> > > +
> > > +     ut_assertok(run_command("bootflow list", 0));
> > > +
> > > +     ut_assert_nextlinen("Showing all");
> > > +     ut_assert_nextlinen("Seq");
> > > +     ut_assert_nextlinen("---");
> > > +     ut_assert_nextlinen("  0  extlinux");
> > > +     ut_assert_nextlinen(
> > > +             "  1  efi          ready   usb_mass_    1  usb_mass_sto=
rage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
> > > +     ut_assert_nextlinen("---");
> > > +     ut_assert_skip_to_line("(2 bootflows, 2 valid)");
> > > +     ut_assert_console_end();
> > > +
> > > +     ut_assertok(run_command("bootflow select 1", 0));
> > > +     ut_assert_console_end();
> > > +
> > > +     systab.fw_vendor =3D test_vendor;
> > > +
> > > +     ut_asserteq(1, run_command("bootflow boot", 0));
> > > +     ut_assert_nextline(
> > > +             "** Booting bootflow 'usb_mass_storage.lun0.bootdev.par=
t_1' with efi");
> > > +     if (IS_ENABLED(CONFIG_LOGF_FUNC))
> > > +             ut_assert_skip_to_line("       efi_run_image() Booting =
/\\EFI\\BOOT\\BOOTSBOX.EFI");
> > > +     else
> > > +             ut_assert_skip_to_line("Booting /\\EFI\\BOOT\\BOOTSBOX.=
EFI");
> > > +
> > > +     /* TODO: Why the \r ? */
> > > +     ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
> > > +     ut_assert_nextline("Exiting boot sevices");
> > > +     if (IS_ENABLED(CONFIG_LOGF_FUNC))
> > > +             ut_assert_nextline("     do_bootefi_exec() ## Applicati=
on failed, r =3D 5");
> > > +     else
> > > +             ut_assert_nextline("## Application failed, r =3D 5");
> > > +     ut_assert_nextline("Boot failed (err=3D-22)");
> > > +
> > > +     ut_assert_console_end();
> > > +
> > > +     return 0;
> > > +}
> > > +BOOTSTD_TEST(bootflow_efi, UTF_CONSOLE);
>=20
> Thanks for taking an interest in this.
>=20
> Nothing at present, as I added ut_assert_skip_to_line() to skip it
> all. But it really is just wrong...I get gibberish showing up in the
> terminal after I run tests! This is what I see with this series:
>=20
> ** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi
>  7 [r [999;999H [6n 8No EFI system partition
>=20
> ^^^ strange output there but I'm not sure if it will come through on email
>=20
> No EFI system partition
> Failed to persist EFI variables
> No EFI system partition
> Failed to persist EFI variables
> No EFI system partition
> Failed to persist EFI variables
> Booting /\EFI\BOOT\BOOTSBOX.EFI
> U-Boot test app for EFI_LOADER
>=20
> Exiting boot sevices
> ## Application failed, r =3D 5
> Boot failed (err=3D-22)
> Failures: 0

So we're finally making progress I think to see what the problem you're
trying to solve is. I think the next thing to figure out is if you use
picocom or screen or whatever on console, the codes are handled
correctly, or no? Specifically, picocom? Next, is this perhaps just
another strange artifact of how oddly (and as you've noted before,
slowly) pytest consumes the console input? It feels like maybe we're
doing several layers of wrong there? Because to be clear, this is not a
sandbox problem. Looking back at the log I had posted about the watchdog
reset not counting banners correctly I see that same escape sequence,
now that I know what I'm looking for/at.

All of that said, if it's not a pytest-consuming-the-console problem
(and it's not a picocom problem, like I was just asking about since the
board failure in question was via labgrid-client), maybe it's just a
thing to note about making sure tests understand. And perhaps document
somewhere why it matters (and I'm not saying it doesn't!) that we know
what the dimensions of the console are, for EFI, and so that's why we
init them when/where we do.

--=20
Tom

--j2ausO5Mv5ax3b4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcMlTYACgkQFHw5/5Y0
tyxPcwv/cwo5secABkHrjOjj22//KRvPiBg93BbQKI5tEeh+tW7vzLiU5boabG42
Op/7TyIS9PoqtatJG2YFnyQyaFn4B+k/g5k8j/3Tqma8vu+NLIAoTufJBO/iyeHG
sA4SqTmjh/KwQ3kGEKDJfqt3lZJ3dZ/M7Sh9ozyefaWOwpB+c7zdKZ17jgSAvy1q
sOUZQ8s1ocpkJVcr0EaOPTeqpTwkUeyArcKAQ57MrRSI1WRsdLyx1nvqsniiw+am
HhixdfI8v41Hd96lzwBzaKGtOpj9vZidxKgmbRzAS77Kqcsqqvsx+fHb3vKECAFe
Y0kcUURE8kWBB+wpXIeILcM/I+BVlpmRfLcwHipFH/r64/kg8bXnvookFqG5W79v
lN8BuZxR7TJ59i8CH/Blp/YW9tP5PMC4tJtL2OCN9dL9060qoXwdfw0LW9pHUesC
rL5QKspazNBuNgzwDX5zCfTcgKTG7gpu6qXZuXDzjRXq+5Q+upP5Br/0VVO8eMn8
5NvEixDz
=Lr7p
-----END PGP SIGNATURE-----

--j2ausO5Mv5ax3b4y--
