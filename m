Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB16C3ABDA
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 21:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8044C82AE2;
	Wed, 14 May 2025 23:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mxTc2pYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE89382AE7; Wed, 14 May 2025 23:58:28 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5404B82AC1
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 23:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-606648c3f9eso103022eaf.3
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747259905; x=1747864705; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DajlBtsfAwmRjAz0HwzfytgadowzXLoGyi0B37wx/Ag=;
 b=mxTc2pYCUozPI5PbPuNLxk81gI2FzAZSgqNWNyi69T27R66sl1kzzqF8eB2+3C52aY
 hOstTZiJ7SWzm+PtbYP2fPZYeFkVc6c4UDc4eCZmnZvEaD+l1atoYdu6XuX6ize0AhJN
 nV9SHvFdLxUhLKRT/1wpgegPX+kpJ4pn6mGbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747259905; x=1747864705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DajlBtsfAwmRjAz0HwzfytgadowzXLoGyi0B37wx/Ag=;
 b=VU5+7gGEMbAfEDRqNY3PNgf1SLfo27nWsoLWU7TP9AhjeONJFNkHkDaURlxtAD8XzS
 XwosFvwBqo5J0olrdjSeFOLVK/DoVIUBu9jjg0JqKvxZ6GQe5IWuW7TtKDj2s5tHODTU
 yEi+6TXrh4j214X0x/p8Zwj3s6Tz3aOJGsO9N76glRojRRL7d2xPjfsUX/Mj4imuaG/v
 qlptfphxeiMsM28OCcd0+ipWqvMCIiqoDXZ0eV/LwTv0yp4njchOAFe5nySIf+erOzNE
 ak4iYM7U9Xe7S7QDaLRMa9OS0ioZaGqiWLSOL8M21TTsyjMc9ANTbdbmpLn34mWU0RJu
 fhHw==
X-Gm-Message-State: AOJu0YznbHIA77P94rzltIbmfr7FRaAkjp1BE8t7JqiYLGkOqUg7vX6t
 zNxe3wW/LvLs57iE0R1aVIv3hoc0yOsHttZQQpgpYcsYJWtF/lb+Wb5DlATHsgQ=
X-Gm-Gg: ASbGncu8/4bKjBHFrdMf6sAA0y63Nxm9p6Pd1/JF2Ql04QVofTgc+Eg77G00+YGEgzm
 k++1sMgU6b+khZcdZfVQAIvAMLOeJgJ+fDXLUgVH1W5lCEOT1g7HTyWfnW8nuESNRuuzkSDXRc+
 sDa6uLk0JRDrKB2RlCyVMPVTxXDVncbCuTgWJOnvrHadf5QA8nYgbCNHrerzL7LgJcLQoX26H39
 YCTxLNx2Gu4FPq6ointe+9WhWW4ZSK9Na3TTGQtQEvL06Qpkml6WASq5+3LEajRlKSZA7uFGFeE
 OdmBlNGNA3VC8ZeeFLFy9nP7wZjMeWZmN/bCxv9wZ7vbJdzVzhJlxDmpop9ZoOBjbOvpPXaclyz
 JmWn/jJgzJZ8q
X-Google-Smtp-Source: AGHT+IGESmsTD/Bqc7/d+pcLbRz+lCbSzuMum0zP5Zq6WYuE4x9VRW5dcQ+TCH00KgRZJHS9MxJmoA==
X-Received: by 2002:a05:6871:2084:b0:2c2:27c8:5865 with SMTP id
 586e51a60fabf-2e3a3b602f8mr148094fac.9.1747259904858; 
 Wed, 14 May 2025 14:58:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0b7f77csm2839828fac.48.2025.05.14.14.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 14:58:23 -0700 (PDT)
Date: Wed, 14 May 2025 15:58:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Xu Zhang <423756212@qq.com>
Subject: Re: [PATCH v4 09/22] passage: arm: Accept a passage from the
 previous phase
Message-ID: <20250514215821.GD603748@bill-the-cat>
References: <20250510134253.1581164-1-sjg@chromium.org>
 <20250510154214.v4.9.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pYe9VrxyzndXxI0L"
Content-Disposition: inline
In-Reply-To: <20250510154214.v4.9.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
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


--pYe9VrxyzndXxI0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 03:42:07PM +0200, Simon Glass wrote:

> Accept a bloblist and control devicetree from a previous phase in
> registers 0 to 3, as documented in the Firmware Handoff
> specification[1].
>=20
> Note that there is currently a weak function called save_boot_params()
> which happens to save the same registers as are needed for this
> protocol. But it seems better to implement this feature as a first-class
> citizen, if for no other reason than that many boards have their own
> version of save_boot_params() which may not happen to save the required
> registers. A weak function is not a good basis for an API.
>=20
> [1] https://firmwarehandoff.github.io/firmware_handoff/main/index.html
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> While some efforts were made to encourage Intel to adopt this
> specification, this has not yet been successful. However I do intend to
> use my proposed x86 handoff in U-Boot, once this series is in.
>=20
> Changes in v4:
> - Update commit message to indicate this can only be for ARM at present
> - Update commit message to mention why save_boot_params() is not used
>=20
> Changes in v3:
> - Add support for aarch64 also
> - Update registers to match the Firmware Handoff protocol
>=20
> Changes in v2:
> - Use three registers instead of two for the entry
>=20
>  arch/arm/cpu/armv7/start.S | 10 +++++++++-
>  arch/arm/cpu/armv8/start.S | 12 ++++++++++++
>  arch/arm/lib/crt0.S        |  6 ++++++
>  arch/arm/lib/crt0_64.S     |  6 ++++++
>  4 files changed, 33 insertions(+), 1 deletion(-)

This is what makes me think you aren't actually working on my feedback
about taking what we have in-tree, now, rather than just forward porting
your old series and deleting the current code.

We have save_boot_params doing exactly what it should today, including
saving off a standard passage and making what was saved available later,
in an intentional fashion. If, hypothetically, Pi needs to override
save_boot_param because a future new-firmware-blob does standard passage
but at run time we want to support both, that's a good thing.

With commit ea3348ebc215 ('Merge patch series "Handoff bloblist from
previous boot stage"') we already implement the specification in [1]. It
is not a "which happens to". It is intentional.

I guess the overall challenge here is that you want to do things which
are a superset of the firmware handoff spec itself?

--=20
Tom

--pYe9VrxyzndXxI0L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmglEf0ACgkQFHw5/5Y0
tyz4rgv8DIQHnhEdhrkT0oCqZhoGUqqPrAkjk5TLByrygZX5CelRW00aGY5vu5ET
uV6drSEL0sDXDJ9cS4TgRunOt2s0Xm1zdEPh1Or6DfTZT+28wID+c5pT8U7D+9jc
VsCVNE16Ri1hO+Yxk7XojEDQJRlf+1oAGv6wMPF2IPBNgFpwRfaWxT3qC7ICYbv2
Cou73A4H7yNtiWeNd9sflwMuV6Nhqvq75ZJdEKmeWKiELJYEHSvcQahFyENoGFWa
4nwYrNqfEMigfF3h06yd2Vpy/vJ2msLvWJfA+w/TCKIQ6qcYfZnrtZgedq39IbCb
juewwSILfN0AxxO7Lm0PQe6hFS0T3UeeTiutqJ45gAILg1FE45VDtcq+WihsZ6Qa
ZsnQFT7FpOc5h3fMeo/NzXlyIlZC+1BBWC8K6hDBi150I5ZvWIi1Db79ecGr/tJp
Fc6MCSXAkD/qDIj+n0nauAsO3Jbpnv9eVRXLGl1q7KOuKfAuv23ZfB09xKl1WL2B
6UaiO7ym
=jW24
-----END PGP SIGNATURE-----

--pYe9VrxyzndXxI0L--
