Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9298103E192
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CAD0839A8;
	Wed, 18 Mar 2026 15:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D2eS1EQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E63D83CE3; Wed, 18 Mar 2026 15:53:17 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E39F6838FA
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 15:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d75371d873so7447538a34.3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773845593; x=1774450393; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0K3TZj6aWH2ODcgqnITLKMD9mVezwawzafBoerqGfdo=;
 b=D2eS1EQnS2oUUQY8s73bvNgZlK+ig+uinNkYJ4BKZFRadcelg08wFxKlwMQfdVJg7F
 v+NgsfzzlvkvPPLDOyNr/XWHbHB+NXdufEq/Uo2HSUxsKlYqgrA+AftpzytBz1k5LYfc
 Sbdhmcf/ll1ebC9y1p90h7Jk9xfa8OL7O4rRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773845593; x=1774450393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0K3TZj6aWH2ODcgqnITLKMD9mVezwawzafBoerqGfdo=;
 b=pJQgf3YaBE8095SzxKZX9+n48D6Z6FEOBfRu41TjcJ3Xl5P8UeLK8gzg07mgUl7ciG
 WCKDT+aasQoDY2jsxCVYCzH5xl8fjCRTWkXyQmTe4C5Ent5XCUveIQFDX/VnOkvBZh+4
 VLle6Qjt+gm3J/MDqYXTuGlB8CXJuDtMWCT5sHYBT9d2x5GW32ejiKhASp5+oQAYBIN1
 ITs55UVodW1dX0TjWjjX6LyPesZ2cS2r6AHGDxr04qA9ZKVwRgSlBMv2NlEasfGL0OS4
 GnCnpVCeDPgHdvC0Jw1D20FD1/Y3/svRNrASunCZ1eg47lWpFyQAyRh3hVEahH5ug/8E
 YQBw==
X-Gm-Message-State: AOJu0YwrZfeZmFRsmTz65GDpvCGwmLnQ2pKpghbPzfRXoo4kJSgaHFMd
 ytqHx4jcVPb2xDy1EXGm2bu+28ZfD33HbC6dx9w64XALXbnky+edOeLB80LDn4jE6v4=
X-Gm-Gg: ATEYQzzf2xlsRLLQE7wIppU9fbV8ABl2T3c6kZ8MIaF0PoTPkExMZcUEkiQD7Gzt430
 VhhZxPkosUyq4ur+CrgLIoO8WIqaYqIrkHixqhQ802O/xl0N06dpMPqKylwMKheXhA7VTEV0wwp
 ZRwlut3tcib8BrcpD77hBsfFwvNrny9BAXT4Lasy/zlXjgm/sOsaQyQjvWv76jIk8OhFhMpqvH1
 wykdNZDhL1UmraS8JU1A4OfL+I8MHQ6kUA6wKkERMjKu3TA7ilv3Lm3/ZRoAR1GfILdINTqun7K
 4jrkQRMPcxFjOPvNdwIZUAwzZ/XV31nVj/Z69THmkSU3nBRvqvwUlur9H1MYpzeCsGzyX1Vdf/l
 nJ9HSt3fNSj7nl8KUthhHMB+9c7jBTPqRJhK+1H3ms3sz1I1qG6y8EJtCJ/j5/Ok64lt1wSMWLZ
 brOm7d0NAvRrXT1TiuTZfvAGN9sP3HMMKU3TDeMztGiiqhTlP+esx8XWfPNMez5KhxxoiKvNDmV
 L6DJPbxOLOrvB/WeAiGMfGpicQJmnOH3tu9aTi+qm8Qi6yy
X-Received: by 2002:a05:6830:64c8:b0:7d7:4d85:eb05 with SMTP id
 46e09a7af769-7d7ca775284mr2181667a34.22.1773845593537; 
 Wed, 18 Mar 2026 07:53:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7cf2b8325sm1489620a34.9.2026.03.18.07.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 07:53:12 -0700 (PDT)
Date: Wed, 18 Mar 2026 08:53:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
Message-ID: <20260318145310.GK502704@bill-the-cat>
References: <20260317012449.4162666-1-trini@konsulko.com>
 <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
 <20260317134256.GT502704@bill-the-cat>
 <CAC_iWjL+OUcUhZQ9hD9Vsp2zOfxdr3wu2fCX03HshXxrvR_EoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5EU26ozmzhz9LioF"
Content-Disposition: inline
In-Reply-To: <CAC_iWjL+OUcUhZQ9hD9Vsp2zOfxdr3wu2fCX03HshXxrvR_EoQ@mail.gmail.com>
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


--5EU26ozmzhz9LioF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 09:09:17AM +0200, Ilias Apalodimas wrote:
> On Tue, 17 Mar 2026 at 15:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Mar 17, 2026 at 09:03:47AM +0200, Ilias Apalodimas wrote:
> > > Hi Tom,
> > >
> > > On Tue, 17 Mar 2026 at 03:24, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > As exposed by "make randconfig", we have an issue with the dependen=
cies
> > > > for EFI_HTTP_BOOT. As this is implemeneted by running commands (as =
seen
> > > > by what it selects) it must depend on CMDLINE as well.
> > > >
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > >
> > > In theory, you can configure UEFI with a set of prebuilt boot options.
> > > If one of them is http(s) the device will boot even if CMDLINE is not
> > > selected. I am not against this patch, but we will remove the
> > > possibility to build a firmware without cmdline that just boots to
> > > whatever is was preconfigured
> > >
> > > Cheers
> > > /Ilias
> > > > ---
> > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > ---
> > > >  lib/efi_loader/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > index b5f81e0ff530..a9b2f813e1d5 100644
> > > > --- a/lib/efi_loader/Kconfig
> > > > +++ b/lib/efi_loader/Kconfig
> > > > @@ -600,6 +600,7 @@ config EFI_BOOTMGR
> > > >  config EFI_HTTP_BOOT
> > > >         bool "EFI HTTP Boot support"
> > > >         depends on NET || NET_LWIP
> > > > +       depends on CMDLINE
> > > >         select CMD_NET
> > > >         select CMD_DHCP
> > > >         select CMD_DNS
> >
> > The select lines here mean that you cannot do that, today :)
>=20
> Fair enough. I was just thinking "lets not limit it more".
> Heinrich is right though. This needs an overhaul and depend on the
> protocols instead of the commands. Either way I don't mind merging it
> now, but maybe add a TODO with fixing it in the future?

Sure:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/24

--=20
Tom

--5EU26ozmzhz9LioF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabq8UwAKCRAr4qD1Cr/k
CitNAQCuAE/LAp6otBhTaw/eEJAlAOj3nyG+RFwednCsQ6qWpgEAz38PXHyislD5
SYzcHxss5PrAVKjTwSwEw8xfPxTh4Ag=
=aGdk
-----END PGP SIGNATURE-----

--5EU26ozmzhz9LioF--
