Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE3AC07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 20:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB45A87505;
	Wed, 25 Oct 2023 22:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gsMh3n9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F0A87505; Wed, 25 Oct 2023 22:18:39 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B331C87503
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-457bac7c3f5so85714137.2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698265113; x=1698869913; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F/rWnhyZrWYJEs4CqKpAl8ekKY1xjncT3G2SDgt66VY=;
 b=gsMh3n9w82gNdTFTYNWeSRIU8TvpCSLan/EsGyFInH7IoMw0DegZR9k0v094HhwWlt
 KYOWhojhvtHBqyCTeS3Ze1yxR3SDRyyNuddf/VN3JbPf9jK9aImmf/pMv6ODD9EPiEzU
 Ba9OBtqR8cMnofRAxricuw1zefqDzkZAh3his=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698265113; x=1698869913;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/rWnhyZrWYJEs4CqKpAl8ekKY1xjncT3G2SDgt66VY=;
 b=UjhfyIZlRexly4C0mNhKCKDxH0og/ZSyMTD1WrIQF9REVO6Lmw59/eWHRRYgozUD7O
 xxmWvh8uOgKBwu4z3OqDc5ANfDit5M8F2oIIzNpiPbSXO+11BmsxpQt1FPCJnfa54jUz
 68vG8J5OuLTW2IZD879WD+SGkMRSA5MWk29X0yvWo5XCIV1rpPvwq6ur7XtiHwMlXgvg
 8L9HEykQuyisTmpmfGGsI008undo/uXvFlS0TVbAF0Twl2k6WV+hEhnYqgwiEu+tgL4E
 ySvqCz1s/+qJ5yNOlUkpdA4Te7D+6KD119uuWFhodATObmFQAHa/A4nkb37odCKXdpzT
 iNiQ==
X-Gm-Message-State: AOJu0YxYf+zKV8Vk62vXmFejNx9la3rjXZfeZS88AkxBpyULw0nergsA
 ujPxPKEsG0QbQ3ZNu096htvCeQ==
X-Google-Smtp-Source: AGHT+IGpDCd8qfCmsjIF4brbnBOiKInGXP2lmWrU1ZgcBgZAiqZVj4Si1cfyTlTB67KtsZsEVrnNuQ==
X-Received: by 2002:a05:6102:10c3:b0:457:d682:913e with SMTP id
 t3-20020a05610210c300b00457d682913emr16432169vsr.32.1698265113390; 
 Wed, 25 Oct 2023 13:18:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 e20-20020ad442b4000000b0065d1380dd17sm4587094qvr.61.2023.10.25.13.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 13:18:32 -0700 (PDT)
Date: Wed, 25 Oct 2023 16:18:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dylan Corrales <deathcamel58@gmail.com>,
 Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: Re: Pull request efi-2024-01-rc2
Message-ID: <20231025201830.GX496310@bill-the-cat>
References: <d61eb00b-baa8-4804-801a-045eb56ed617@gmx.de>
 <20231025185719.GV496310@bill-the-cat>
 <b5d3846f-0d10-465d-aecd-647200409a24@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E04yxwk0cEayLrmC"
Content-Disposition: inline
In-Reply-To: <b5d3846f-0d10-465d-aecd-647200409a24@gmx.de>
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


--E04yxwk0cEayLrmC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 10:09:55PM +0200, Heinrich Schuchardt wrote:
> On 10/25/23 20:57, Tom Rini wrote:
> > On Wed, Oct 25, 2023 at 04:20:06AM +0200, Heinrich Schuchardt wrote:
> >=20
> > > Dear Tom,
> > >=20
> > > The following changes since commit 5cab3515f8c9796015739c1750b8933291=
c816be:
> > >=20
> > >    Merge tag 'u-boot-rockchip-20231024' of
> > > https://source.denx.de/u-boot/custodians/u-boot-rockchip (2023-10-24
> > > 09:39:52 -0400)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> > > tags/efi-2024-01-rc2
> > >=20
> > > for you to fetch changes up to 916dad34af0e53181dfe21f5764d3a787cb24b=
dc:
> > >=20
> > >    efi_loader: fix EFI_ENTRY point on get_active_pcr_banks (2023-10-24
> > > 23:56:43 +0200)
> > >=20
> > > Gitlab CI showed no issues:
> > > https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18293
> > >=20
> >=20
> > So, there's not been enough time for "efi_loader: expose the device-tree
> > file name" as there's still comments on how to word things there (and
> > I'm fine taking this eventually for the release, we don't need it
> > today).
>=20
> You and Ilias marked this patch as reviewed.
>=20
> Which comments should I look at?

Well, Simons that you replied to now, and my follow-up.

As yes, I did RB it, but I also didn't expect it to be merged a day
after posting since it's not a critical security fix. Most changes
should sit on the list for a few days at least, to give people a chance
to read and comment. I thought it was good enough at first but on
reading what Simon said (and this is a thing I will do as I read a
longer thread I hadn't seen at first) I changed my mind a bit, and
noticed something else too.

> > And since we're here anyways, "efi_loader: fix efi_dp_from_eth"
> > isn't needed as with "sandbox: eliminate unused functions from binaries"
> > we can build sandbox with EFI_LOADER=3Dy NET=3Dn LTO=3Dn (and CMDLINE=
=3Dn with
> > the rest of my v4 + an unrelated to this fix for fastboot) and since I'm
> > asking for changes anyhow, lets just drop this. Thanks.
> >=20
>=20
> I am fine with dropping the patch. Will you be moving that sandbox patch?

Yes, the gc-sections patch will be merged, Simon and I talked off-list
about it more.

--=20
Tom

--E04yxwk0cEayLrmC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5eBYACgkQFHw5/5Y0
tyzNZgv+IiC1nElb+VMsgIXCK9vWTWHN8iIqWac5xWir3B71CxbZ1Wxx6UP0S2Yp
XdGwpANFcMMvgBPziFkaPnx73xzT93Zni9gi/fOngaescYjkSXbrvlbimnLM6Zxp
6dqRfFbS3YwOchpPg4Z+xUdezkMBRxINZzxt26xjD+5CxUilrjsrXE+FAm5YMgGG
jBEimtyHzVE6ybMTnynZEnaHxWpiAow/ttREidl2kBJA7zqXjv507tVkUlxH66s1
YGHPLjk2rxgTeZEJJpxD7inm9HcaK3vvGGX+LmQKawRKWbORAWGM/xwCSfMjRrOJ
2imWgZmwQbUxs/ua6OliAh05hwhXBjxSr6Yi68RGEEgXPJAaBpduZJJR4cPTFzYa
G0GsLSSyuN0jRmFdkMvVodC1I3/ZNyRxYV7l8EWJiyq/+ySYKyySIAjEtn65bxuA
HSh7N0QrchXpWkye1qINZ778S1TMmvWMAwjdr8QySn/vLhNddx/2pma4bMyQ3f7m
vmozMCIm
=ofbP
-----END PGP SIGNATURE-----

--E04yxwk0cEayLrmC--
