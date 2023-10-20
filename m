Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A9ACDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 13:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8501874C3;
	Fri, 20 Oct 2023 15:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D/Aj5M1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B27A986F5D; Fri, 20 Oct 2023 15:58:44 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 623C5874B7
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 15:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a87ac9d245so9185387b3.3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 06:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697810318; x=1698415118; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1jHI3TOUBRrAF5NocE1DM9+/9Rg+0imvRIMe1w2Gysc=;
 b=D/Aj5M1W/S6WYaUkmVulY4rLZU2vgtazmXyf2pyO9uDB7DQhoLIX0kOGgdOShZ+7TW
 alNsJSjuwdJYKaTAJI1N770AsL5Q0w0MDTxpUKzXPX+pvPfGJPsW3ubTWaKbfcz/V+pn
 tK6pQpqkM60VgNWXtUyuoYOkKUL1eYvooDWtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697810318; x=1698415118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jHI3TOUBRrAF5NocE1DM9+/9Rg+0imvRIMe1w2Gysc=;
 b=bhKYPQDJg9idiO7D/5mpDDG+LHoX7Z4cplzVMbElkV1oAXon4Da30k9gOQGN5la0FO
 hRFbSwZRQXpxjuX+M7YwINwclDgh3Ux5HZqFMKIQRx7wZHXyFQjZ6Q9tRS7pNJgstC5u
 6Ihp1xomJrjPcdrwyKrfxk1lh2Qy4akQdaabMiOSBa//OUdmAKwKdNY3yyoh7nvZKDxW
 AiMbYx/uBXXXk8vZKYKSOBjrUGpFSa+vvCG50W47Mnerl3V+6iGJRe2BNXY60HxMhyTE
 +ahx2jPsG46Xp3Q2XSwsRKOS4aLk9lDOV7X219ZfdEiK9Y/fMHU5U5Qq/Zh6ZtaI6KKk
 6IvQ==
X-Gm-Message-State: AOJu0YzQ2ecPO/rZBkm/2lyWwcyhybC2V7/wYkbdKLBMzTdxRKC5iI3l
 YAzWunCRliWdAIDj9Ugw5lP9bMku1pxecG8wvd6aFg==
X-Google-Smtp-Source: AGHT+IHWyB8mUhgit9+JhTWmUYRFcFK3ZuE+PuYCmQKHQ7tBcwRyvRoG89oUF0KB+5TlcvFjVkvqYA==
X-Received: by 2002:a0d:e6ce:0:b0:5a7:af89:c4a0 with SMTP id
 p197-20020a0de6ce000000b005a7af89c4a0mr2180195ywe.23.1697810318073; 
 Fri, 20 Oct 2023 06:58:38 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 s204-20020a815ed5000000b005869ca8da8esm682334ywb.146.2023.10.20.06.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 06:58:37 -0700 (PDT)
Date: Fri, 20 Oct 2023 09:58:35 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [v4 11/24] efi: Rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR
Message-ID: <20231020135835.GH3119521@bill-the-cat>
References: <20231019150105.714407-1-trini@konsulko.com>
 <20231019150105.714407-11-trini@konsulko.com>
 <4a17c974-fd56-4412-93e3-47bfe3268489@canonical.com>
 <20231019151933.GC3119521@bill-the-cat> <ZTJwrFS10FAsUSN3@octopus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v1DbmCWYvRNtt1NY"
Content-Disposition: inline
In-Reply-To: <ZTJwrFS10FAsUSN3@octopus>
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


--v1DbmCWYvRNtt1NY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 09:21:00PM +0900, AKASHI Takahiro wrote:
> On Thu, Oct 19, 2023 at 11:19:33AM -0400, Tom Rini wrote:
> > On Thu, Oct 19, 2023 at 05:16:28PM +0200, Heinrich Schuchardt wrote:
> > > On 19.10.23 17:00, Tom Rini wrote:
> > > > From: Simon Glass <sjg@chromium.org>
> > > >=20
> > > > The command should not be used to enable library functionality. Add=
 a
> > > > new BOOTEFI_BOOTMGR Kconfig for that. Adjust the conditions so that=
 the
> > > > same code is built.
> > > >=20
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > ---
> > > > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > Changes in v4:
> > > > - Integrate AKASHI Takahiro's feedback from v3
> > > > - Reword the help text on CMD_BOOTEFI_BOOTMGR slightly
> > > > ---
> > > >   cmd/Kconfig             | 11 ++++++++++-
> > > >   lib/efi_loader/Kconfig  |  6 +++---
> > > >   lib/efi_loader/Makefile |  2 +-
> > > >   3 files changed, 14 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > > index 16e5cb8f0633..872cb49150cc 100644
> > > > --- a/cmd/Kconfig
> > > > +++ b/cmd/Kconfig
> > > > @@ -379,6 +379,15 @@ config CMD_BOOTEFI
> > > >   	help
> > > >   	  Boot an EFI image from memory.
> > > > +config CMD_BOOTEFI_BOOTMGR
> > > > +	bool "UEFI Boot Manager command"
> > > > +	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
> > > > +	default y
> > > > +	help
> > > > +	  Select this option to enable the 'bootmgr' subcommand of 'boote=
fi'.
> > > > +	  This subcommand will allow you to select the UEFI binary to be =
booted
> > > > +	  via UEFI variables Boot####, BootOrder, and BootNext.
> > > > +
> > > >   config CMD_BOOTEFI_HELLO_COMPILE
> > > >   	bool "Compile a standard EFI hello world binary for testing"
> > > >   	depends on CMD_BOOTEFI && !CPU_V7M
> > > > @@ -2110,7 +2119,7 @@ config CMD_EFIDEBUG
> > > >   config CMD_EFICONFIG
> > > >   	bool "eficonfig - provide menu-driven uefi variables maintenance=
 interface"
> > > >   	default y if !HAS_BOARD_SIZE_LIMIT
> > > > -	depends on CMD_BOOTEFI_BOOTMGR
> > > > +	depends on BOOTEFI_BOOTMGR
> > > >   	select MENU
> > > >   	help
> > > >   	  Enable the 'eficonfig' command which provides the menu-driven =
UEFI
> > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > index d20aaab6dba4..13cad6342c36 100644
> > > > --- a/lib/efi_loader/Kconfig
> > > > +++ b/lib/efi_loader/Kconfig
> > > > @@ -32,14 +32,14 @@ config EFI_LOADER
> > > >   if EFI_LOADER
> > > > -config CMD_BOOTEFI_BOOTMGR
> > > > +config BOOTEFI_BOOTMGR
> > > >   	bool "UEFI Boot Manager"
> > > >   	default y
> > > >   	select BOOTMETH_GLOBAL if BOOTSTD
> > > >   	help
> > > >   	  Select this option if you want to select the UEFI binary to be=
 booted
> > > > -	  via UEFI variables Boot####, BootOrder, and BootNext. This enab=
les the
> > > > -	  'bootefi bootmgr' command.
> > > > +	  via UEFI variables Boot####, BootOrder, and BootNext. You shoul=
d also
> > > > +	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is avai=
lable.
> > > >   choice
> > > >   	prompt "Store for non-volatile UEFI variables"
> > > > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > > > index 8d31fc61c601..0a2cb6e3c476 100644
> > > > --- a/lib/efi_loader/Makefile
> > > > +++ b/lib/efi_loader/Makefile
> > > > @@ -42,7 +42,7 @@ targets +=3D initrddump.o
> > > >   endif
> > > >   obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
> > > > -obj-$(CONFIG_CMD_BOOTEFI_BOOTMGR) +=3D efi_bootmgr.o
> > > > +obj-$(CONFIG_BOOTEFI_BOOTMGR) +=3D efi_bootmgr.o
> > > >   obj-y +=3D efi_boottime.o
> > > >   obj-y +=3D efi_helper.o
> > > >   obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) +=3D efi_capsule.o
> > >=20
> > > This patch looks wrong.
> > >=20
> > > Symbol CONFIG_CMD_BOOTEFI_BOOTMGR is used in a lot of places where it=
 is not
> > > related to the 'bootefi bootmgr' subcommand.
> > >=20
> > > I see no benefit in two separate symbols. If you want to rename the s=
ymbol,
> > > please, replace *all* occurrences:
> > >=20
> > > %s/CONFIG_CMD_BOOTEFI_BOOTMGR/CONFIG_BOOTEFI_BOOTMGR/
> >=20
> > Yes, there's work on the EFI_LOADER side of things to support the use
> > case of "boot to menu" (or, "boot to efi bootmgr") of which this is the
> > starting point. The follow-up work that I'm hoping you or someone else
> > with more EFI_LOADER experience will pick up is splitting cmd/bootefi.c
> > such that we can call in to starting an EFI payload (or bootmgr) without
> > the command line.
>=20
> I will be able to take care unless Heinrich wants to do by himself.
> # Test would be another issue now that "bootefi" may handle various
>   boot scenarios.

At the very high level, this is solved for "bootm" today, and I _think_
booti/bootz also but I'm less sure of that.  The non-command side logic
is in boot/bootm.c rather than cmd/bootm.c and so we exercise the core
still via the normal tests. I don't know if the best answer is
boot/bootefi.c or lib/efi_loader/something.c. Tests of new functionality
will require some thought tho, yes.

--=20
Tom

--v1DbmCWYvRNtt1NY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUyh4sACgkQFHw5/5Y0
tyw9+Qv/fvpGWzu6T6jOLLy4l1EB91Ue50ijG847wQVjPT9O1ZDAFzyG7vfxnd5j
FsUvqvrayjwgnrVuztWzW4A2j98Cmmw9pIUx1BTiSSkAUMKBubIBv12qDg4czDit
HRYRTyjoT0dqQQM30xq5P63dYDIqjoijICUzRkjcjz0rtdaLgpA4vSWlBjxt9m53
yoNhjgQeMLaP2l9PTNCBPd6w8ETgr6TSRFY2BYdbe8XyKocsCAMHBti4vC+lSlqo
TRZF+asX1/5eHlSb6tx2Ij4MY5TBOjSeW6WHxIg/h0ynGenv3r+uqTyMUPeYkOVR
n85jJORpWSfkONUGt2u3gfi8ruWAWE6o7UScYd/2BMaf9q7vhAdrNmnzCYiY1Ljq
2EJPKwATj8mJvc4lMO86TElPpRGTMbZgEnoms3iaHQaGWSsozdfK1Pmgx7MR2m5O
h+mDgge+j+5Xc4lUyqVuBg/6YVcwG1sMCyUon8kpuRr20zlHvUHsWCqve7mf6FLK
HLC4PmTk
=+DLv
-----END PGP SIGNATURE-----

--v1DbmCWYvRNtt1NY--
