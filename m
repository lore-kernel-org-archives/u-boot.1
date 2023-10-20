Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AD1CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 12:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA5C871A2;
	Fri, 20 Oct 2023 14:21:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LexajqVQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934B18723C; Fri, 20 Oct 2023 14:21:08 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C8BD870E3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 14:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7a683da7be3so6556539f.0
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697804465; x=1698409265; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIANcDsOHPk+ALKluwqsu3y128dzeWCLsJ4xFLFJoyM=;
 b=LexajqVQUbh6nuWAXrg3G2ZPrxvL2zJhbhRXnW1gyXjaMGHA4oC4LTLvMJNKPQryNP
 D6uStUlI/aNsscDvKl0Xv/EQIUfC/BsCJsu8U0eEGi4xC4oFggikgRHUphHPji8VOSyu
 FSuBbV4GSKunGfW5QJ2Y247i8wtJ4Ver2ZVsanAXYf73UCa5hl3RKO+hmAPr/KSdK9DZ
 SXSsssfBmyFkcKzzapdX2SpTNJdnwy11w6gAgxfwPD+2wIPUmewAkzVa7RJFJ4PNi/yi
 Xwfl/YtpO6ABis6eZPZH65wgPe7Y5BEL+fkbh0kYIMMYoxoj3aGkRCHCR8pp2WfgiLBb
 7Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697804465; x=1698409265;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oIANcDsOHPk+ALKluwqsu3y128dzeWCLsJ4xFLFJoyM=;
 b=w8obn1gG98Hz7wgJwcJJGiL9trAB70M/Vg3N92aXFv/2CwgmJL/1fbJ0u5YTOneoQf
 0mSpq8Esr3I2tQqbh+WxDHatZhy78UIvE3KIN+gwQGlpooFiuAuVy+OdKdvhpdwy5Awd
 3FzbGzyjN78lbVI9qpL5nl5f83ANyHC9fBrRV6LkcSOZGeioNZ+O4MK049rZOyrwpgFi
 MK1nl4vFd6yPiyKI6+AT7iFCS4a0lsW8i+Ii4rFXNGcw7PyUlNpGfvPjtYizbcg8wA3Q
 MjBriVB1E9Obj8MWwskERVluTUtWxr45bk5na7AMWN7Q/1HS291fRjxHDAYDFjKwtKYS
 q3mw==
X-Gm-Message-State: AOJu0YwQkrVlhfr3+eCv7vn8GVuLv/gi5b5o1SE0v69adk6nsiY4V0bx
 V668jH2mmlKRIosYuVyeAHyYYQ==
X-Google-Smtp-Source: AGHT+IEs+AP7JlD3MVcyAxuCEK5Hio/gChINCRnlPiTgKg2gMXfKjYis6TOmBu8NcrIzeFmYYTVI1w==
X-Received: by 2002:a6b:3e0a:0:b0:792:6068:dcc8 with SMTP id
 l10-20020a6b3e0a000000b007926068dcc8mr1734650ioa.2.1697804464511; 
 Fri, 20 Oct 2023 05:21:04 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:8685:4bd3:8dc9:1f68])
 by smtp.gmail.com with ESMTPSA id
 e3-20020aa798c3000000b006bda45671b1sm1403517pfm.101.2023.10.20.05.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 05:21:04 -0700 (PDT)
Date: Fri, 20 Oct 2023 21:21:00 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [v4 11/24] efi: Rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR
Message-ID: <ZTJwrFS10FAsUSN3@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
References: <20231019150105.714407-1-trini@konsulko.com>
 <20231019150105.714407-11-trini@konsulko.com>
 <4a17c974-fd56-4412-93e3-47bfe3268489@canonical.com>
 <20231019151933.GC3119521@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6r7eDed36uWuWfT6"
Content-Disposition: inline
In-Reply-To: <20231019151933.GC3119521@bill-the-cat>
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


--6r7eDed36uWuWfT6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 11:19:33AM -0400, Tom Rini wrote:
> On Thu, Oct 19, 2023 at 05:16:28PM +0200, Heinrich Schuchardt wrote:
> > On 19.10.23 17:00, Tom Rini wrote:
> > > From: Simon Glass <sjg@chromium.org>
> > >=20
> > > The command should not be used to enable library functionality. Add a
> > > new BOOTEFI_BOOTMGR Kconfig for that. Adjust the conditions so that t=
he
> > > same code is built.
> > >=20
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > ---
> > > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Changes in v4:
> > > - Integrate AKASHI Takahiro's feedback from v3
> > > - Reword the help text on CMD_BOOTEFI_BOOTMGR slightly
> > > ---
> > >   cmd/Kconfig             | 11 ++++++++++-
> > >   lib/efi_loader/Kconfig  |  6 +++---
> > >   lib/efi_loader/Makefile |  2 +-
> > >   3 files changed, 14 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > index 16e5cb8f0633..872cb49150cc 100644
> > > --- a/cmd/Kconfig
> > > +++ b/cmd/Kconfig
> > > @@ -379,6 +379,15 @@ config CMD_BOOTEFI
> > >   	help
> > >   	  Boot an EFI image from memory.
> > > +config CMD_BOOTEFI_BOOTMGR
> > > +	bool "UEFI Boot Manager command"
> > > +	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
> > > +	default y
> > > +	help
> > > +	  Select this option to enable the 'bootmgr' subcommand of 'bootefi=
'.
> > > +	  This subcommand will allow you to select the UEFI binary to be bo=
oted
> > > +	  via UEFI variables Boot####, BootOrder, and BootNext.
> > > +
> > >   config CMD_BOOTEFI_HELLO_COMPILE
> > >   	bool "Compile a standard EFI hello world binary for testing"
> > >   	depends on CMD_BOOTEFI && !CPU_V7M
> > > @@ -2110,7 +2119,7 @@ config CMD_EFIDEBUG
> > >   config CMD_EFICONFIG
> > >   	bool "eficonfig - provide menu-driven uefi variables maintenance i=
nterface"
> > >   	default y if !HAS_BOARD_SIZE_LIMIT
> > > -	depends on CMD_BOOTEFI_BOOTMGR
> > > +	depends on BOOTEFI_BOOTMGR
> > >   	select MENU
> > >   	help
> > >   	  Enable the 'eficonfig' command which provides the menu-driven UE=
FI
> > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > index d20aaab6dba4..13cad6342c36 100644
> > > --- a/lib/efi_loader/Kconfig
> > > +++ b/lib/efi_loader/Kconfig
> > > @@ -32,14 +32,14 @@ config EFI_LOADER
> > >   if EFI_LOADER
> > > -config CMD_BOOTEFI_BOOTMGR
> > > +config BOOTEFI_BOOTMGR
> > >   	bool "UEFI Boot Manager"
> > >   	default y
> > >   	select BOOTMETH_GLOBAL if BOOTSTD
> > >   	help
> > >   	  Select this option if you want to select the UEFI binary to be b=
ooted
> > > -	  via UEFI variables Boot####, BootOrder, and BootNext. This enable=
s the
> > > -	  'bootefi bootmgr' command.
> > > +	  via UEFI variables Boot####, BootOrder, and BootNext. You should =
also
> > > +	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is availa=
ble.
> > >   choice
> > >   	prompt "Store for non-volatile UEFI variables"
> > > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > > index 8d31fc61c601..0a2cb6e3c476 100644
> > > --- a/lib/efi_loader/Makefile
> > > +++ b/lib/efi_loader/Makefile
> > > @@ -42,7 +42,7 @@ targets +=3D initrddump.o
> > >   endif
> > >   obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
> > > -obj-$(CONFIG_CMD_BOOTEFI_BOOTMGR) +=3D efi_bootmgr.o
> > > +obj-$(CONFIG_BOOTEFI_BOOTMGR) +=3D efi_bootmgr.o
> > >   obj-y +=3D efi_boottime.o
> > >   obj-y +=3D efi_helper.o
> > >   obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) +=3D efi_capsule.o
> >=20
> > This patch looks wrong.
> >=20
> > Symbol CONFIG_CMD_BOOTEFI_BOOTMGR is used in a lot of places where it i=
s not
> > related to the 'bootefi bootmgr' subcommand.
> >=20
> > I see no benefit in two separate symbols. If you want to rename the sym=
bol,
> > please, replace *all* occurrences:
> >=20
> > %s/CONFIG_CMD_BOOTEFI_BOOTMGR/CONFIG_BOOTEFI_BOOTMGR/
>=20
> Yes, there's work on the EFI_LOADER side of things to support the use
> case of "boot to menu" (or, "boot to efi bootmgr") of which this is the
> starting point. The follow-up work that I'm hoping you or someone else
> with more EFI_LOADER experience will pick up is splitting cmd/bootefi.c
> such that we can call in to starting an EFI payload (or bootmgr) without
> the command line.

I will be able to take care unless Heinrich wants to do by himself.
# Test would be another issue now that "bootefi" may handle various
  boot scenarios.

-Takahiro Akashi

>=20
> --=20
> Tom



--6r7eDed36uWuWfT6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEjc56F+RxEkavfJvIJ6vpGq1myG0FAmUycKgACgkQJ6vpGq1m
yG2cewgAro3Ag6PyulhkppSEHhQRhM/nROUZLARE6IuX88w8Sfa3CZhVB8AFapir
Ne8svxUdrvk8vTwBrvhYCchoBDqYvZ7oyv50MLdRGlOnJUiuSmoRXpFBKh8puw31
ew5/C9+F73cqGYtPoR9Hyab2QV4msFg/yxripYlj8rEINWOEea4Ib9I8VTGYY/2j
g6w0wvzm3GOx2Jel0BHAx68jritkVMjrxyxOvTMDDHsV8YRS1zJ5dkA+mc978vQA
f/XP+6k2BIZSR55BKpIQxCsba+vjGzSnQWGdoikCRGQtJhTx9CMpAskVtPbYiH8w
ie68FJLBxUViQSglwfrtpVRGnaQ0UA==
=PuPn
-----END PGP SIGNATURE-----

--6r7eDed36uWuWfT6--
