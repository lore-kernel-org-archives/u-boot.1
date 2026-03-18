Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8993FFD8779
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 01:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEDD383FA3;
	Wed, 18 Mar 2026 02:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V9/VqxDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30E2283FAF; Wed, 18 Mar 2026 02:47:08 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1C8283C51
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 02:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-46726528f1cso217973b6e.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773798424; x=1774403224; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V+93eOjZww7sCPLRA1NkVBJwGrVRl/jg6gdVScNedAY=;
 b=V9/VqxDjhb8WFm6tDq77tQsRLnVBsyrCeEe+2RkUd0AvPNz+wee0Co1L07yrltivQ6
 xetuQ+P0rMLgWZBYmNDPzsNKmoeTSd1dwCgpeHh39PZK2y9w4t8Ut/JFGb+tyFUchoRP
 rD5o0gVUkN4Ad2PAmEvj2gdY7yambBZKMvCNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773798424; x=1774403224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+93eOjZww7sCPLRA1NkVBJwGrVRl/jg6gdVScNedAY=;
 b=UN/GZ64sgtWuHj9Sxqik8bEJXwmnNvZpmesxP9lzkXT4XSgls45HI93wdext5paaND
 GBAcuXE1JJk2z8C+magv6ms+ffMhUcImiQEgDnDQXJIhgCr9m3XlBKjCsXes/MfkhNHr
 ol5nq9543R6k5eo0ajY9chzbmOYawSWK1yRnUfCmkRLI0i3+aaIz8ygqFXRlkEnXFuAn
 JDvjbcwAc3FjXdQyJ0Xhm8pnJjbatCFc2LvmiATf3vXujvcmdP2xIXpCTUsI5hflvEYf
 F2AyAh4MddBt6qEOkuL9fcDXmw+UxqIXcKQtmGIsAj8DACdOsuAFPa29mPUh3nzYXXpd
 dpYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrIVcjQ5CETlHuK77OymsWJZ7fRnePO+335rqVpaThs1VQCoHjkT1BomJVHiR6wwsru8WNRSk=@lists.denx.de
X-Gm-Message-State: AOJu0YzpgAgFXjVmVKqrhZzo3tEMiRHhR5+BYK23LrKVkJ7anUgrwEGF
 cO/XcU3q05X7EFo6NPrTOK1K4u8abOl5Q4wk24XlWobxwnX/xoSl++2LY7rUeILHeCCtA6MbVmG
 /zKeFt9k=
X-Gm-Gg: ATEYQzyAM6kowZR+4bEDnBzmJ5YEkLhUOKunqEOEPd7sCI69zrf0VqcM1K2oj5ppjhW
 TfRf50OLzbysr+9kuQzNJHvxImcdAvs0EDPdZQL/F+ok+AdpsVih9v18DJXnHHo54pwUkJkEkyL
 wyFZYorcrSxJ/QK9d9R8upctmZCgkePunnXsWyqnZhBHH0UVBpl4jjPz5/XC2VRNcsISi6X1qHY
 Yp8PWvLKGnAzCVSPlKVMfsdsT1Jmm9IuLF68FhAG1uk52t6dHGYIOplA1agUPK/rrhyVnPt2DCq
 pIo5Lf5qC5l5Yop46rpvTdxMM1+xO/GM69Ea9PLYIPt/Ugaiu7+fzqrXRW8UwdbcgMJHia8XQUi
 LjHNj0TdDBp/QbkQr6I+3kg09m3pkSRqB8Kc9gFLswkcIXiqCMgDFzoNDyNrDJ8efKlOSfaHxuK
 +U+nZYvJ4v64puIJ0fe+LNe1RJi81jFJSmK2Yr4XUfLKqNA/fi3obszDMzp73EeEaCFw5x513bJ
 s9fIWlMCf3t4hFAOXB2joUS9URAwnJ9wmmcoafMbWfSBA7E
X-Received: by 2002:a05:6808:1a13:b0:467:1376:1cde with SMTP id
 5614622812f47-467ba1ef0b5mr1060684b6e.17.1773798424284; 
 Tue, 17 Mar 2026 18:47:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467baac7c8fsm848705b6e.13.2026.03.17.18.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 18:47:03 -0700 (PDT)
Date: Tue, 17 Mar 2026 19:47:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
Message-ID: <20260318014701.GJ502704@bill-the-cat>
References: <20260317012449.4162666-1-trini@konsulko.com>
 <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
 <9F36DE37-16FF-4519-9F66-A4A79F618794@gmx.de>
 <20260317134427.GU502704@bill-the-cat>
 <CALeDE9MVgs--ABnZZ4RJDOnTLM-+imKxG6iJBGmQFHHXivLMxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jjQ6ayNsUVQWeWnX"
Content-Disposition: inline
In-Reply-To: <CALeDE9MVgs--ABnZZ4RJDOnTLM-+imKxG6iJBGmQFHHXivLMxw@mail.gmail.com>
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


--jjQ6ayNsUVQWeWnX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 04:08:22PM +0000, Peter Robinson wrote:
> On Tue, 17 Mar 2026 at 13:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Mar 17, 2026 at 08:42:39AM +0100, Heinrich Schuchardt wrote:
> > > Am 17. M=E4rz 2026 08:03:47 MEZ schrieb Ilias Apalodimas <ilias.apalo=
dimas@linaro.org>:
> > > >Hi Tom,
> > > >
> > > >On Tue, 17 Mar 2026 at 03:24, Tom Rini <trini@konsulko.com> wrote:
> > > >>
> > > >> As exposed by "make randconfig", we have an issue with the depende=
ncies
> > > >> for EFI_HTTP_BOOT. As this is implemeneted by running commands (as=
 seen
> > > >> by what it selects) it must depend on CMDLINE as well.
> > > >>
> > > >> Signed-off-by: Tom Rini <trini@konsulko.com>
> > > >
> > > >In theory, you can configure UEFI with a set of prebuilt boot option=
s.
> > > >If one of them is http(s) the device will boot even if CMDLINE is not
> > > >selected. I am not against this patch, but we will remove the
> > > >possibility to build a firmware without cmdline that just boots to
> > > >whatever is was preconfigured
> > > >
> > > >Cheers
> > > >/Ilias
> > > >> ---
> > > >> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > >> ---
> > > >>  lib/efi_loader/Kconfig | 1 +
> > > >>  1 file changed, 1 insertion(+)
> > > >>
> > > >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > >> index b5f81e0ff530..a9b2f813e1d5 100644
> > > >> --- a/lib/efi_loader/Kconfig
> > > >> +++ b/lib/efi_loader/Kconfig
> > > >> @@ -600,6 +600,7 @@ config EFI_BOOTMGR
> > > >>  config EFI_HTTP_BOOT
> > > >>         bool "EFI HTTP Boot support"
> > > >>         depends on NET || NET_LWIP
> > > >> +       depends on CMDLINE
> > > >>         select CMD_NET
> > > >>         select CMD_DHCP
> > > >>         select CMD_DNS
> > >
> > > Having to select commands here to get network is what needs to change=
=2E The network commands and EFI_HTTP_BOOT both should depend on configurat=
ion symbols for the protocol implementations.
> >
> > Yes. And this is about fixing missing dependencies, today.
> >
> > > @Tom: Do we have a target release when to finish the move to the LWIP=
 stack?
> >
> > We do not. I'm not yet sure if all the various use cases of the legacy
> > stack are fully supported now (I don't recall off-hand the NFS series
> > state right now for example).
>=20
> I did see NFS patches go through the list.

I saw the NFS support as well shortly after hitting send, as part of a
randconfig build.

> I think there's also likely some legacy usecases where non parity is
> likely fine too.

Perhaps the question really is, for the distribution folks, what are the
use cases you know of where lwIP doesn't have support yet? That's the
first big hurdle towards, likely, saying EFI_LOADER implies NET_LWIP
maybe, since I know there's cases there lwIP is better for.

--=20
Tom

--jjQ6ayNsUVQWeWnX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaboEFQAKCRAr4qD1Cr/k
CosPAP9fxm7kim4FvN5T9NqdEqrVIy6sFsirzGJI2g9s7RnkcwEAmd/qPCR7Ki3S
q4hFfNpUtIG047kW3celykE28Kj7cwI=
=zAiP
-----END PGP SIGNATURE-----

--jjQ6ayNsUVQWeWnX--
