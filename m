Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DACDC3ABA3
	for <u-boot@archiver.kernel.org>; Sun, 15 Sep 2024 18:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B32AF88E18;
	Sun, 15 Sep 2024 20:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mGI79ASQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D52288C9C; Sun, 15 Sep 2024 20:28:39 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DFC888E18
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 20:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4583209a17dso31756271cf.1
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726424916; x=1727029716; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+nGE+6CyS10j4VwozObrXCDpc/27cZr/3E6EsUpuPE0=;
 b=mGI79ASQs3fRWDEqglB1zsrbpZcQ9wkiQDtBtx0lxPi7W0tShkVLioJw1ROJ+kbrWG
 klItH23sttVwewYnHXx3ZFhAWFbdCp3cb9Y3JPBNsHitqwNQ38DFgeO2Aj1qf4ljlVtO
 rHJne4pybcwVyNp/shttu/Jj/hE0oOYuxuZmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726424916; x=1727029716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nGE+6CyS10j4VwozObrXCDpc/27cZr/3E6EsUpuPE0=;
 b=RL8dyFNdYf3YAfmzdaCfHQWXW2lVX3r5+wct3UiaGOw1GHweDHOBYeTNvRuvf59OSF
 8//o6Ra8a/MNmJcoLqQ3n2/TF7T29u9yVDLezgb8lzYcCQ+lwe7ue84CyvQWRPm9rHTn
 dlREme6s5D2BOnFQWXvMsL4CPfVrHX3srUzngMYRqbDsTeyX/T0ipLxNMudYKIYk1dvs
 oxchw9/7dOeGRBqH/z9/TeMnKvPm5XUGCEX++2zIbmNbY90FKGifftXaB4EEByuwL+gf
 Z8HbHCfvWw6UKH0UOBm3RfX5ZoglxY8LNHuUfW+K1haoo/WrOX4pkqACWnQD3sCC2lka
 jqGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJXXFj7wsK/5SUUjxkTiTC3yP2bIdhxjUVw7pplfHHwqsMznaDhPU4PgQT9Xa2uXPBBE2pLPo=@lists.denx.de
X-Gm-Message-State: AOJu0YwWRotLaFaswVbJB+mmobZ6X5AonT4sUMXDRNVWMllw4iMxxoLa
 BmWvh/a6JhgWnFaCN/UYWZfewPfBdSF8CL8sMQKrFzjYS6JGWBLlyFOTMPfMtxY=
X-Google-Smtp-Source: AGHT+IEc4CNCkT4L3mHK5Z5rs79P7AErrMO6ZJufOwuStIA2DzYj5U38IKJRjhG6FFQp6nNdjdSzbA==
X-Received: by 2002:ac8:5803:0:b0:456:77c3:c0f0 with SMTP id
 d75a77b69052e-4599d23c4dfmr143895181cf.17.1726424915727; 
 Sun, 15 Sep 2024 11:28:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad24937sm19596651cf.96.2024.09.15.11.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 11:28:35 -0700 (PDT)
Date: Sun, 15 Sep 2024 12:28:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Stefan Roese <sr@denx.de>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 00/10] SMBIOS improvements
Message-ID: <20240915182831.GD4252@bill-the-cat>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
 <ffeb90f8-4f3b-4455-83db-d7b03b872c84@linaro.org>
 <CAFLszTg8gM53pcbHGj-LoA9GDSU-X294_q6ZRnP_QjYFppG0sw@mail.gmail.com>
 <20240826182345.GJ2479150@bill-the-cat>
 <CAFLszTiD4A2eCMfnnKvrbm__urLu+vdi_L1T1iiwU-qOY-yYJQ@mail.gmail.com>
 <20240826195924.GM2479150@bill-the-cat>
 <93c2ab53-aa9a-4403-80da-7bd6d8872b3c@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="phHv1mWwZ3HUWgiT"
Content-Disposition: inline
In-Reply-To: <93c2ab53-aa9a-4403-80da-7bd6d8872b3c@gmx.de>
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


--phHv1mWwZ3HUWgiT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 07:57:19PM +0200, Heinrich Schuchardt wrote:
> On 8/26/24 21:59, Tom Rini wrote:
> > On Mon, Aug 26, 2024 at 01:12:16PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >=20
> > > On Mon, 26 Aug 2024 at 12:23, Tom Rini <trini@konsulko.com> wrote:
> > > >=20
> > > > On Mon, Aug 26, 2024 at 11:58:54AM -0600, Simon Glass wrote:
> > > > > Hi Caleb,
> > > > >=20
> > > > > On Mon, 19 Aug 2024 at 17:03, Caleb Connolly <caleb.connolly@lina=
ro.org> wrote:
> > > > > >=20
> > > > > > Hi Simon,
> > > > > >=20
> > > > > > > As a general comment, this is adding a load of code which is =
used by a
> > > > > > > lot of platforms. As more and more aarch64 platforms are crea=
ted, this
> > > > > > > data grows. Why not use the devicetree for this hardware info=
rmation?
> > > > > > > That is what it is for.
> > > > > >=20
> > > > > > This data does not belong in devicetree, the various system reg=
isters
> > > > > > exist to describe this information... Putting it in DT would be
> > > > > > duplicating it.
> > > > >=20
> > > > > I am not wanting to duplicate info which can be read from system =
registers.
> > > > >=20
> > > > > >=20
> > > > > > Using DT for this would additionally require having bindings ac=
cepted
> > > > > > upstream and for all SoCs to add them. To what end?
> > > > >=20
> > > > > To get the correct information in there. How are boards supposed =
to
> > > > > add SMBIOS info? Do we end up creating a whole infra in U-Boot ju=
st
> > > > > for the driver to read it out? It just doesn't make any sense to =
me...
> > > > >=20
> > > > > Let's put hardware info in the DT where it belongs.
> > > >=20
> > > > I'm a little confused here because of some older threads on this ov=
erall
> > > > topic. Part of the issue here is that in user space, "everyone" has
> > > > SMBIOS-based tooling today, and wants to have that work, rather than
> > > > inventing new tooling or modify existing tooling. And you were conc=
erned
> > > > I thought that we had tied SMBIOS too much to EFI being present when
> > > > indeed it should be possible to pass the location along to the OS
> > > > without EFI, but at the time Linux at least only supported that not=
ion
> > > > on MIPS I think?
> > >=20
> > > That is a whole other concern I have, that we are perpetuating this
> > > legacy format which is a real pain to work with, when we already have
> > > devicetree. Let's leave that issue aside as I have not detected any
> > > interest in solving that problem, or even any agreement that it is a
> > > problem.
> >=20
> > OK, yes, lets set that aside.
> >=20
> > > But for this particular series, I am just wanting to get the correct
> > > info in there. Having the CPU-detection code provide an opinion about
> > > what type of chassis is in use (just to take an example, the patch
> > > pieces I highlighted have been dropped from the email I am replying
> > > to) just seems a bit daft to me. Only the board vendor would know that
> > > info.
> >=20
> > Yes, I agree the detection should be reworked a good bit as some
> > information will be board design specific while others SoC specific. And
> > we should avoid adding many unused at run time strings to all platforms
> > that enable this too (looking at all the CPU vendor related stuff).
> >=20
>=20
> I doubt on productive machines there will be much use of U-Boot's smbios
> command use. It is more a developer tool.
>=20
> For reading all the details we currently have
> lib/efi_loader/smbiosdump.efi which can dump the SMBIOS table to a file
> that dmidecode can read.
>=20
> Maybe instead of adding more and more decoding logic into the U-Boot
> smbios command we should add an smbios sub-command to dump to a file.
> This would be less of a hassle than running an EFI program for the same
> purpose.

Sounds like a good idea to me.

--=20
Tom

--phHv1mWwZ3HUWgiT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbnJ04ACgkQFHw5/5Y0
tyxMPwwAuBYiRyf1+hm/Zl2o9r0XFoA+HJczRrE2sx5FxvhCmBkMx6Qa6PnURCL7
jmqB6hWcJbCWr+AH3XYt9PB5WZYrT1lIMIDwjdXXKlsP9y1Sr28jbHjdA6RHznFk
ChmjBYHjWNdfmTser+RNnYVP/djNgWa3+qS26JmmGAMMJn41PKuYHssaHdEWG1JG
Gh/EsmJRwDKQ6xjG6wCsGy2zTzJpoJ2G89rUz3QRJfmpiHuMR0wqmhD8IPO0R/2Z
YRjwvVik/ipNrezkCo0HUPwuJVENq+vLtc5FZebquD3T8f+0or3X/meG45/VPX8B
iYGwwDwc9JA9uCHg4h7GtT4Ht9S8eKqrnk8hGqBjC8jbTuahKQMG+3jnyGEdzbJM
tIDmxGPqM9b1swGoIUBSuVDqFUGrRLwdRsT0UlYZ7X8N5AgWjodUK+ntgMGRIsj5
ndJPeMjQif8GcZahR46JpFjkZyhcXhCTZxJ5GmTBC55tP7tMO/KYLaexErmC1fE0
EB/m/vfK
=lAGI
-----END PGP SIGNATURE-----

--phHv1mWwZ3HUWgiT--
