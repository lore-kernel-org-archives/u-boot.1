Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CB5D16268
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 14:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D595F88C63;
	Mon, 14 Oct 2024 16:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z6J/WEMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF9D88CA1; Mon, 14 Oct 2024 16:32:25 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 035D288A47
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 16:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-46049c27999so26266851cf.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728916341; x=1729521141; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yCWW6ySfASsgEZWqqPuetIJLZOTB06Dh/tRMe2yeiZY=;
 b=Z6J/WEMirv1r1oF3oOodfarZk3aYc+J2L2s7h1PmKuOlXmBWOCldPUWjnvs2xlJSW0
 qbJS11NDGFPqluFCazWIkGAYWeTToEO2CzWUx1w3wfLyuh3xYEKj+cEHowWHJjsKiLru
 E08LGSKAyZ5mLDewIFmmS0sye9WF3wK+GEg9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728916341; x=1729521141;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCWW6ySfASsgEZWqqPuetIJLZOTB06Dh/tRMe2yeiZY=;
 b=NNuwBBkT77/DqtiZRL4B0LqYS8Mb9/ZVbtigRFvpYQRLFd0YVdSGUixy13YxcwomEc
 hCe7ylM0uA9qQC1q4aQlcMf81mAXTLSAe5QIuEYORK6sGIzBiJJhRldmhbHu+74ACBPu
 rNzXz/UHSctCifPQzrxQENnhcK2snJA3mB4WvB5Wc6+7R4Bl2QoQG+sNM5lr0a6/WpaC
 3W0wiI0g+oMbe7GfaVI4p+3BNswKBaR36NwJjNBWyWeSJ80WK+oaBEcveJJwd83YGvng
 SZPrJ5icSb4OzF/Fu8sPMdhgoTBKTWtZAQhpTVfyvvbpFOh36HuLfg19wCKVLYcUySJT
 s9yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj7aAxFqrKH0/etMdc3q6SeOQce0Q/VN5dRB5HU0kH2i1smikBCAVBSHHs8WzRDNYbIAEE6+o=@lists.denx.de
X-Gm-Message-State: AOJu0YxcMnuCBpRwlwS2ls/QdV8J+OaIDUbYW0B29DIim5TrsjYZRpLs
 k1n/cmMF7EIw9WINZyPsH7rqFARjI0UO9pVhV6Ah4N84QCS0mfHA4T10tyo3Avs=
X-Google-Smtp-Source: AGHT+IG+/AifpssithMfLBeC0YTuWflQOuewCoZkDBr7NuOGg7JIsyD7yyh4fVBBNs0JoFtZVpmxGA==
X-Received: by 2002:a05:6214:5bca:b0:6cb:f920:be0a with SMTP id
 6a1803df08f44-6cbf920be26mr135611476d6.46.1728916341385; 
 Mon, 14 Oct 2024 07:32:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85d8b48sm45625676d6.68.2024.10.14.07.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 07:32:20 -0700 (PDT)
Date: Mon, 14 Oct 2024 08:32:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v6 12/12] test: efi: boot: Add a test for the efi bootmeth
Message-ID: <20241014143218.GK53053@bill-the-cat>
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-13-sjg@chromium.org>
 <20241011223227.GA630742@bill-the-cat>
 <CAFLszTgoxND_qi8WzdgC8-mQLf0e14Mt=KgXy=bqWkqo4svG9Q@mail.gmail.com>
 <20241014035122.GE53053@bill-the-cat>
 <A7089CFC-AD83-4F62-B477-17D65B066A4B@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oP2wvBVmQisYJRtz"
Content-Disposition: inline
In-Reply-To: <A7089CFC-AD83-4F62-B477-17D65B066A4B@gmx.de>
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


--oP2wvBVmQisYJRtz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 09:00:40AM +0200, Heinrich Schuchardt wrote:
>=20
>=20
> Am 14. Oktober 2024 05:51:22 MESZ schrieb Tom Rini <trini@konsulko.com>:
> >On Sun, Oct 13, 2024 at 01:33:23PM -0600, Simon Glass wrote:
> >> Hi Tom,
> >>=20
> >> On Fri, 11 Oct 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> >> >
> >> > On Fri, Sep 27, 2024 at 12:02:23AM +0200, Simon Glass wrote:
> >> >
> >> > > Add a simple test of booting with the EFI bootmeth, which runs the=
 app
> >> > > and checks that it can call 'exit boot-services' (to check that al=
l the
> >> > > device-removal code doesn't break anything) and then exit back to
> >> > > U-Boot.
> >> > >
> >> > > This uses a disk image containing the testapp, ready for execution=
 by
> >> > > sandbox when needed.
> >> > >
> >> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >> >
> >> > So lets go to the problem point. What asserts here fail due to ANSI
> >> > escape codes being in the output and needing to be filtered out?
> >> >
> >> > [snip]
> >> > > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> >> > > index e05103188b4..da2ee1ab345 100644
> >> > > --- a/test/boot/bootflow.c
> >> > > +++ b/test/boot/bootflow.c
> >> > > @@ -13,6 +13,7 @@
> >> > >  #include <cli.h>
> >> > >  #include <dm.h>
> >> > >  #include <efi_default_filename.h>
> >> > > +#include <efi_loader.h>
> >> > >  #include <expo.h>
> >> > >  #ifdef CONFIG_SANDBOX
> >> > >  #include <asm/test.h>
> >> > > @@ -31,6 +32,9 @@ extern U_BOOT_DRIVER(bootmeth_android);
> >> > >  extern U_BOOT_DRIVER(bootmeth_cros);
> >> > >  extern U_BOOT_DRIVER(bootmeth_2script);
> >> > >
> >> > > +/* Use this as the vendor for EFI to tell the app to exit boot se=
rvices */
> >> > > +static u16 __efi_runtime_data test_vendor[] =3D u"U-Boot testing";
> >> > > +
> >> > >  static int inject_response(struct unit_test_state *uts)
> >> > >  {
> >> > >       /*
> >> > > @@ -1205,3 +1209,62 @@ static int bootflow_android(struct unit_tes=
t_state *uts)
> >> > >       return 0;
> >> > >  }
> >> > >  BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
> >> > > +
> >> > > +/* Test EFI bootmeth */
> >> > > +static int bootflow_efi(struct unit_test_state *uts)
> >> > > +{
> >> > > +     /* disable ethernet since the hunter will run dhcp */
> >> > > +     test_set_eth_enable(false);
> >> > > +
> >> > > +     /* make USB scan without delays */
> >> > > +     test_set_skip_delays(true);
> >> > > +
> >> > > +     bootstd_reset_usb();
> >> > > +
> >> > > +     /* Avoid outputting ANSI characters which mess with our asse=
rts */
> >> > > +     efi_console_set_ansi(false);
> >> > > +
> >> > > +     ut_assertok(bootstd_test_drop_bootdev_order(uts));
> >> > > +     ut_assertok(run_command("bootflow scan", 0));
> >> > > +     ut_assert_skip_to_line(
> >> > > +             "Bus usb@1: scanning bus usb@1 for devices... 5 USB =
Device(s) found");
> >> > > +
> >> > > +     ut_assertok(run_command("bootflow list", 0));
> >> > > +
> >> > > +     ut_assert_nextlinen("Showing all");
> >> > > +     ut_assert_nextlinen("Seq");
> >> > > +     ut_assert_nextlinen("---");
> >> > > +     ut_assert_nextlinen("  0  extlinux");
> >> > > +     ut_assert_nextlinen(
> >> > > +             "  1  efi          ready   usb_mass_    1  usb_mass_=
storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
> >> > > +     ut_assert_nextlinen("---");
> >> > > +     ut_assert_skip_to_line("(2 bootflows, 2 valid)");
> >> > > +     ut_assert_console_end();
> >> > > +
> >> > > +     ut_assertok(run_command("bootflow select 1", 0));
> >> > > +     ut_assert_console_end();
> >> > > +
> >> > > +     systab.fw_vendor =3D test_vendor;
> >> > > +
> >> > > +     ut_asserteq(1, run_command("bootflow boot", 0));
> >> > > +     ut_assert_nextline(
> >> > > +             "** Booting bootflow 'usb_mass_storage.lun0.bootdev.=
part_1' with efi");
> >> > > +     if (IS_ENABLED(CONFIG_LOGF_FUNC))
> >> > > +             ut_assert_skip_to_line("       efi_run_image() Booti=
ng /\\EFI\\BOOT\\BOOTSBOX.EFI");
> >> > > +     else
> >> > > +             ut_assert_skip_to_line("Booting /\\EFI\\BOOT\\BOOTSB=
OX.EFI");
> >> > > +
> >> > > +     /* TODO: Why the \r ? */
> >> > > +     ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
> >> > > +     ut_assert_nextline("Exiting boot sevices");
> >> > > +     if (IS_ENABLED(CONFIG_LOGF_FUNC))
> >> > > +             ut_assert_nextline("     do_bootefi_exec() ## Applic=
ation failed, r =3D 5");
> >> > > +     else
> >> > > +             ut_assert_nextline("## Application failed, r =3D 5");
> >> > > +     ut_assert_nextline("Boot failed (err=3D-22)");
> >> > > +
> >> > > +     ut_assert_console_end();
> >> > > +
> >> > > +     return 0;
> >> > > +}
> >> > > +BOOTSTD_TEST(bootflow_efi, UTF_CONSOLE);
> >>=20
> >> Thanks for taking an interest in this.
> >>=20
> >> Nothing at present, as I added ut_assert_skip_to_line() to skip it
> >> all. But it really is just wrong...I get gibberish showing up in the
> >> terminal after I run tests! This is what I see with this series:
> >>=20
> >> ** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi
> >>  7 [r [999;999H [6n 8No EFI system partition
> >>=20
> >> ^^^ strange output there but I'm not sure if it will come through on e=
mail
>=20
> It seems you are not providing a video console. So the EFI sub-system is =
asking the serial console for its size in query_console_serial().
>=20
> Set CONFIG_VIDEO=3Dy and let vidconsole be your first output device to av=
oid query_console_serial() being called.

That's not an answer to the problem. Please note that
rpi_arm64_defconfig shows this same issue, and it's about being able to
run tests on hardware and parse the output reasonably. And so:

>=20
> Best regards
>=20
> Heinrich
>=20
> >>=20
> >> No EFI system partition
> >> Failed to persist EFI variables
> >> No EFI system partition
> >> Failed to persist EFI variables
> >> No EFI system partition
> >> Failed to persist EFI variables
> >> Booting /\EFI\BOOT\BOOTSBOX.EFI
> >> U-Boot test app for EFI_LOADER
> >>=20
> >> Exiting boot sevices
> >> ## Application failed, r =3D 5
> >> Boot failed (err=3D-22)
> >> Failures: 0
> >
> >So we're finally making progress I think to see what the problem you're
> >trying to solve is. I think the next thing to figure out is if you use
> >picocom or screen or whatever on console, the codes are handled
> >correctly, or no? Specifically, picocom? Next, is this perhaps just
> >another strange artifact of how oddly (and as you've noted before,
> >slowly) pytest consumes the console input? It feels like maybe we're
> >doing several layers of wrong there? Because to be clear, this is not a
> >sandbox problem. Looking back at the log I had posted about the watchdog
> >reset not counting banners correctly I see that same escape sequence,
> >now that I know what I'm looking for/at.
> >
> >All of that said, if it's not a pytest-consuming-the-console problem
> >(and it's not a picocom problem, like I was just asking about since the
> >board failure in question was via labgrid-client), maybe it's just a
> >thing to note about making sure tests understand. And perhaps document
> >somewhere why it matters (and I'm not saying it doesn't!) that we know
> >what the dimensions of the console are, for EFI, and so that's why we
> >init them when/where we do.

My last question here was to you or Ilias, thanks.

--=20
Tom

--oP2wvBVmQisYJRtz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNK3IACgkQFHw5/5Y0
tyzGhgv/Udm64pupAntHW0SHdthwautaP82P4DiGr1+0SdDoH9a6NOEpL+AvvZg+
JCK7K3ObTHuPsAhupCtfA0HA2R15054qoPxpqvrrqa6+irKZ8XK+TK6VIJU/9ou5
LZXjaUqzWWXIbDnC0FQnHrpkKqdBKz7NNkMwEZhLfFwxPq+0teNvHj8kPXdmAWnk
xlVDoYNAs45HELiK7w8j333L8Pl0nDyPBIKekDe7n3jGBIcfM0U+BS9tt5DjXqv0
GzB34t1BpCbPFYCz2tQjBzdu0kNmEJVtL+G1yo9IZkvMsfgt0Si8GP/7PNY75QeL
b/S66C+K3MtKR2bGBGSAY38uDGvPvVTNCQStC0b/5uWIOnYPA+fkl+NEhmDAr0jD
xRhwWCLkEYXlxK55F6AIRMQ9W+OQkR/xCcTPLj90HLoORf73dOdrCw2ttFoMafCL
HNuIsniOHDWmipb9CIXNnuTKXxEwjQP2HH97v/BwDUSIYNCyIWLcSwPi+YSpBluu
yxF/kerw
=bMsI
-----END PGP SIGNATURE-----

--oP2wvBVmQisYJRtz--
