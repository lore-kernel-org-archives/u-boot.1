Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6ADC25B6E
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E25187B6D;
	Thu, 26 Oct 2023 14:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fanEdYk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B6387B5B; Thu, 26 Oct 2023 14:48:03 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E63C87B5A
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-773ac11de71so64722685a.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698324479; x=1698929279; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0ybq7ATU5cSeyErqyGxGbC9xUprW46brFp5bmEO8cVE=;
 b=fanEdYk6euwthwnKyfxwBSBXqKMTwppAFtxyyGvvMxOUD0C9NqoqWjeW0P7B/m4xZO
 e7zBVn2rbrJf3+CZdGNbgUj4b8bT7Q/Puflnj6IZumDFJDnVG7ndk6ILH4W/SK/VtoeY
 h6h3WQgw3VLNam9oISpKZHm03/OTTvK2HD3FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698324479; x=1698929279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ybq7ATU5cSeyErqyGxGbC9xUprW46brFp5bmEO8cVE=;
 b=KeBoE9nMYzprH9gpdsQVb4bJ0eEc7OCmFH0CIJlYHkoarJJuSQ3A15VqwlcbY1tkEe
 sRsAFhwS0BKPewOqYxpoSwC7dvzH/j4jWQ0/HDwQ5VrsWmPni9j4eglD1Lw5sd0Yw7Ea
 DrXnezwOnAZO8UY4gqsr2eqL68slu3S906MHvHW5sK5xc3xwiXC0/ZVuKnublXE/+Lq6
 7h/PXxtbfmsbWFTq/tAXZXcKfaL8tmAPc81lmaLMFrrp0/j942JhS/86/Fje418T/VPU
 X4fSNcYTVuDutOruZkoL/hZP6Odzzl3gtzJVnShE22/0ZullBMR0ij6DZZkbsH9ZCgi+
 T01Q==
X-Gm-Message-State: AOJu0Yz0legDF90LYRA0Sct6mX+10sU11gMXEXppJhO4iM/4YADyKGKH
 3eo6v+6AONyuqG2P5QPgcy7bXw==
X-Google-Smtp-Source: AGHT+IGXRYcDozs8AcPmDHUZT+H9SZWz923w/mfH/KNb6gz7MqiQ4Or1isQbDfl/JOB1TYIAVd/L3g==
X-Received: by 2002:ae9:e216:0:b0:76e:ef17:d37e with SMTP id
 c22-20020ae9e216000000b0076eef17d37emr18373494qkc.71.1698324479694; 
 Thu, 26 Oct 2023 05:47:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a05620a410100b0076f0744ff50sm4918936qko.136.2023.10.26.05.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 05:47:59 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:47:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, jbx6244@gmail.com,
 u-boot@lists.denx.de, sjg@chromium.org, ilias.apalodimas@linaro.org
Subject: Re: [RFC 02/13] cmd: bootefi: re-organize do_bootefi_image()
Message-ID: <20231026124757.GG496310@bill-the-cat>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-3-takahiro.akashi@linaro.org>
 <f9ce4a74-6bb7-4b72-97a4-0a605c4389cf@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nS43xHEw1auKQhQF"
Content-Disposition: inline
In-Reply-To: <f9ce4a74-6bb7-4b72-97a4-0a605c4389cf@gmx.de>
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


--nS43xHEw1auKQhQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 12:44:00PM +0200, Heinrich Schuchardt wrote:
> On 10/26/23 07:30, AKASHI Takahiro wrote:
> > Decompose and re-organize do_bootefi_image() into three parts for
> > the succeeding refactor work.
> >=20
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >   cmd/Kconfig          | 15 ++++++--
> >   cmd/bootefi.c        | 82 ++++++++++++++++++++++++++++++--------------
> >   include/efi_loader.h |  2 --
> >   3 files changed, 69 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 0eb739203ade..825a41d68aad 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -363,9 +363,19 @@ config CMD_BOOTEFI
> >   	help
> >   	  Boot an EFI image from memory.
> >=20
> > +if CMD_BOOTEFI
> > +config CMD_BOOTEFI_BINARY
> > +	bool "Allow booting an EFI binary directly"
> > +	depends on BOOTEFI_BOOTMGR
> > +	default y
> > +	help
> > +	  Select this option to enable direct execution of binary at 'bootefi=
'.
> > +	  This subcommand will allow you to load the UEFI binary using
> > +	  other U-Boot commands or external methods and then run isince 2021.=
 t.
> > +
> >   config CMD_BOOTEFI_BOOTMGR
>=20
> This symbol is in lib/efi_loader/Kconfig:
> lib/efi_loader/Kconfig:35:config CMD_BOOTEFI_BOOTMGR
>=20
> Please, rebase your series on origin/master.

To properly test this series, it needs concepts in the series to disable
CMDLINE.  I'll get a v5 going soon, and I am aiming to have that be in
-next once that opens (after reviews).

--=20
Tom

--nS43xHEw1auKQhQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU6X/0ACgkQFHw5/5Y0
tyyY+Qv+PWUBDtSO2bF80SB29qQhB+08XXDXyMebEvtD5s809O5ovTO4ML3zh6qT
Rrvi6Zlop0Hc4BJWbX5dY8J/tCEb5l51Mclx2RBRAPBKNsm/MzmWhtYBDpovfeEg
fkrCxMUvmP8C0+PxD2hB0CtAggPvcQ1vCuVQqm0195x9GOFMLBt32c7BeZFLNvY3
OaJl51rGS7VqrB/bSB3C+f/cxGbNaE3WxLzVMKHNYj+E4VhGzGREDau0t69j712U
eD0QdKDpLzRijGCIxE7B5GZfi7qZvsdMx6JTK1+R0JJSkgay0iiERihLOnYWFhFD
H4hPJJOFoHN/EXNV9f1S2fY/3fXKSvQ5dOwVviM6iiUj4cR9mwvOJHQKXYGMLxNS
dHI7pe5JePGbgTA7KHK716Pr/VbF+tjzjCBL9qaxIYBZPcaJblZ4kskypDK+tZjw
Df4aLrxBcLKAyPJDWEm2CbY+ktl7jkuP+pa5zYUIpCD+LfSuK4CTxB1ebBtEU0EL
8gOk3v+m
=0y4H
-----END PGP SIGNATURE-----

--nS43xHEw1auKQhQF--
