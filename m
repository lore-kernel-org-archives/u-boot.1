Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3277DCDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7402E8727D;
	Thu, 19 Oct 2023 17:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c0pARrpB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97FAA87443; Thu, 19 Oct 2023 17:19:39 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7202086F6C
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a86b6391e9so59830407b3.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697728776; x=1698333576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ujn7DugfhIiWfHqXIfaEHRs70RGpzIEsGGLfIPXb0zI=;
 b=c0pARrpBdaS1CszLsNdqUhZtD1a3AAjslseptI7/AYb0b+Blts+MadJRGUJBvGyk5y
 jVC6X0wovD2puqySfVYUWOzi1Hy/eyZQG24H68WAzq7EIsjMVP4oGlIn80P7HrCQqC7B
 Y3pb6Maw2iGaRMlv+xK/icezJwyqf3Ba+qwDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697728776; x=1698333576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ujn7DugfhIiWfHqXIfaEHRs70RGpzIEsGGLfIPXb0zI=;
 b=JqBdNFUI9+4WHxaRJh7Lur8PLL1OkObSNF9wLI/eK9Za8MlKYDWAfAJsRAdi66kBiN
 Z1Z+vAhRKFV6Eki+bRrRgGVAAk4//yMDjG1eeNA3tfeXQIYWzRYTkvbBrGE1Q0VLXYGV
 THE1hg4Qnu8EtjQnVAMczr0V9dj85nnTrcKM+sq5G7D6RtT4rJUxBQ21q7JPt1L2Ultd
 dnA+3HY/FwJ4cG4jyXnqtMgiD8iS5AQEopnfbgPkYsRRxLfXng5cbixVwpaTfskWJ7vm
 NHSCuqOZMOsOISN6TA2x4zTbIugtFMke9HoRyoFavsH4ujxgSQ2WstWBTMON0tWVGPCf
 A06g==
X-Gm-Message-State: AOJu0YwzLSZ7Q8Cfq38XFiNH9gbL0hACNNNVZgxkrW/h3Qvz7+BDfwTT
 PfGYLfGjEenVEXyTKwQhPqj+7w==
X-Google-Smtp-Source: AGHT+IGiqzw+gS/SHQWSbdC9nddBVFjLF3TwgwXOmNLQfr2P40w8w9PxDwCmVkuAA91q+84o4FOwdA==
X-Received: by 2002:a25:26d1:0:b0:d9b:2477:b624 with SMTP id
 m200-20020a2526d1000000b00d9b2477b624mr2291050ybm.64.1697728776155; 
 Thu, 19 Oct 2023 08:19:36 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 u39-20020a25f827000000b00d8168e226e6sm391780ybd.47.2023.10.19.08.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:19:35 -0700 (PDT)
Date: Thu, 19 Oct 2023 11:19:33 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [v4 11/24] efi: Rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR
Message-ID: <20231019151933.GC3119521@bill-the-cat>
References: <20231019150105.714407-1-trini@konsulko.com>
 <20231019150105.714407-11-trini@konsulko.com>
 <4a17c974-fd56-4412-93e3-47bfe3268489@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w1Dx6xVBxbdzUt7q"
Content-Disposition: inline
In-Reply-To: <4a17c974-fd56-4412-93e3-47bfe3268489@canonical.com>
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


--w1Dx6xVBxbdzUt7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 05:16:28PM +0200, Heinrich Schuchardt wrote:
> On 19.10.23 17:00, Tom Rini wrote:
> > From: Simon Glass <sjg@chromium.org>
> >=20
> > The command should not be used to enable library functionality. Add a
> > new BOOTEFI_BOOTMGR Kconfig for that. Adjust the conditions so that the
> > same code is built.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Changes in v4:
> > - Integrate AKASHI Takahiro's feedback from v3
> > - Reword the help text on CMD_BOOTEFI_BOOTMGR slightly
> > ---
> >   cmd/Kconfig             | 11 ++++++++++-
> >   lib/efi_loader/Kconfig  |  6 +++---
> >   lib/efi_loader/Makefile |  2 +-
> >   3 files changed, 14 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 16e5cb8f0633..872cb49150cc 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -379,6 +379,15 @@ config CMD_BOOTEFI
> >   	help
> >   	  Boot an EFI image from memory.
> > +config CMD_BOOTEFI_BOOTMGR
> > +	bool "UEFI Boot Manager command"
> > +	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
> > +	default y
> > +	help
> > +	  Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
> > +	  This subcommand will allow you to select the UEFI binary to be boot=
ed
> > +	  via UEFI variables Boot####, BootOrder, and BootNext.
> > +
> >   config CMD_BOOTEFI_HELLO_COMPILE
> >   	bool "Compile a standard EFI hello world binary for testing"
> >   	depends on CMD_BOOTEFI && !CPU_V7M
> > @@ -2110,7 +2119,7 @@ config CMD_EFIDEBUG
> >   config CMD_EFICONFIG
> >   	bool "eficonfig - provide menu-driven uefi variables maintenance int=
erface"
> >   	default y if !HAS_BOARD_SIZE_LIMIT
> > -	depends on CMD_BOOTEFI_BOOTMGR
> > +	depends on BOOTEFI_BOOTMGR
> >   	select MENU
> >   	help
> >   	  Enable the 'eficonfig' command which provides the menu-driven UEFI
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index d20aaab6dba4..13cad6342c36 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -32,14 +32,14 @@ config EFI_LOADER
> >   if EFI_LOADER
> > -config CMD_BOOTEFI_BOOTMGR
> > +config BOOTEFI_BOOTMGR
> >   	bool "UEFI Boot Manager"
> >   	default y
> >   	select BOOTMETH_GLOBAL if BOOTSTD
> >   	help
> >   	  Select this option if you want to select the UEFI binary to be boo=
ted
> > -	  via UEFI variables Boot####, BootOrder, and BootNext. This enables =
the
> > -	  'bootefi bootmgr' command.
> > +	  via UEFI variables Boot####, BootOrder, and BootNext. You should al=
so
> > +	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is availabl=
e.
> >   choice
> >   	prompt "Store for non-volatile UEFI variables"
> > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > index 8d31fc61c601..0a2cb6e3c476 100644
> > --- a/lib/efi_loader/Makefile
> > +++ b/lib/efi_loader/Makefile
> > @@ -42,7 +42,7 @@ targets +=3D initrddump.o
> >   endif
> >   obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
> > -obj-$(CONFIG_CMD_BOOTEFI_BOOTMGR) +=3D efi_bootmgr.o
> > +obj-$(CONFIG_BOOTEFI_BOOTMGR) +=3D efi_bootmgr.o
> >   obj-y +=3D efi_boottime.o
> >   obj-y +=3D efi_helper.o
> >   obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) +=3D efi_capsule.o
>=20
> This patch looks wrong.
>=20
> Symbol CONFIG_CMD_BOOTEFI_BOOTMGR is used in a lot of places where it is =
not
> related to the 'bootefi bootmgr' subcommand.
>=20
> I see no benefit in two separate symbols. If you want to rename the symbo=
l,
> please, replace *all* occurrences:
>=20
> %s/CONFIG_CMD_BOOTEFI_BOOTMGR/CONFIG_BOOTEFI_BOOTMGR/

Yes, there's work on the EFI_LOADER side of things to support the use
case of "boot to menu" (or, "boot to efi bootmgr") of which this is the
starting point. The follow-up work that I'm hoping you or someone else
with more EFI_LOADER experience will pick up is splitting cmd/bootefi.c
such that we can call in to starting an EFI payload (or bootmgr) without
the command line.

--=20
Tom

--w1Dx6xVBxbdzUt7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUxSP4ACgkQFHw5/5Y0
tywvtwv/cbxGRVx4umxEh+qggmk4kfibiZgZNP1cTNz1OzNzo3UH/YwPFFT/iQuG
QeWjjQ0YSBydBoiQfJeIPYFcoyP5DZ6IKGOFXEHkt6C3vISU6wpTzN/cW9x81x6t
KJLd23rtykc5DsRO6d+Ds3jcuuCZ0h8+qpdPAtKimcolTxQbSZic3y5DWhq3ifqb
K7so+0aTkncriU/gVE35SbXzR0MFuP5suWp9hE6eHQ9U3kq7AiROEM/8bHebSep4
yY9kZMmO7qIC48PSNMR+Wnt0ei1KqbLg9XfehpxKEODuK5Zj0A015Yz8gWX1Ouuy
Z3O2vciDl+a6DbabJf/yGm+FXGDjNtaHqs2yNreTZ3YeXmqVciU4bf2jq9oUOPg/
XuOeHbkG205I1xywhrlf49aHE6wQdiA7rhFIECYRknU6AYpRXOLLUTceykDCJ+uU
YoUhLwhzXri/U3Jya4xTcPt95bQ1oxLxyF/kv08Bo8W/QQjhnYm3unZbqe3xWza4
BFndYwOC
=Rx1N
-----END PGP SIGNATURE-----

--w1Dx6xVBxbdzUt7q--
