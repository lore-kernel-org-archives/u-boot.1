Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FA4C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC7778846D;
	Fri, 21 Jun 2024 21:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nogpAy4P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 648BF884B2; Fri, 21 Jun 2024 21:19:23 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B528845A
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5b96b249d56so1453434eaf.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718997560; x=1719602360; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yonucuKO2rHKHXzDDT7aFyDBl3aLt2IkJmQwfgiL5xE=;
 b=nogpAy4PaVXejScF1BcPdNnNfj5aQRGB5z39m1d75bcYBIwjsdgTb2yCagAB8QZstP
 +0DHMjhzuH1n8ZBBF5oD2Ta7iodAkYmAC2KYP8CojzCRkJbgh05hV03YadBH7rtvSm9C
 nZOsn7DnyWRhP4UKiUE60ACU1CLx37fmogzO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718997560; x=1719602360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yonucuKO2rHKHXzDDT7aFyDBl3aLt2IkJmQwfgiL5xE=;
 b=rpzwkB6E/yzj+AN7EQKUmJ/4ZZyUjjskFW+cA/Edp4hzWEXPMTgkGbZDXxICpZdAjQ
 rRHoH3UsvyiTIp2QJQKHrGsEWPJsdGBjKj4B2LNZn3dvX1LdmVJGiIps2R2waKDnGIl+
 nCrDkgj1A7a04QQLNOKy5yHriYapF6jxnPDtIBS/yETPS0SheAo6AK4QtpK+4s50OjMT
 yHt/8zJBCIJWpUo4yfrhGUDudVUIUdl3wGqootELJjrfr4nVYV7VqHij3824DA0/9fS3
 BOLmNG15co/yJu2WQ3vdR65n1oNwAfsrl9ilm4sWNDdKOj31ciZAFfnvNjg/UVci5CO4
 8YlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeQUW7HC770ysMM0OXkZTIpt6N67XMV9ge5vg1BGJxu5kvpuKYyegK49quDpHunpBdsmf54aLrx4A7shR6crLVpvS4Ww==
X-Gm-Message-State: AOJu0YyEECW1EY4NBVlbatZfaIgHBMBvNujBVldLQG0dLkB5i1pWxrrc
 7rfymY0p+a8x6YzXKaiIUXYCJSo+neSGvcnZjskaHongbvdrIQxdv0JVkZjmZf0=
X-Google-Smtp-Source: AGHT+IFsfrKb4M3+sTTA4hUINOaMtWGffcEkhyU4iZbbzEDmrF/FL8tdfMH18foTL7cTchPWHDJ6Kg==
X-Received: by 2002:a05:6870:e2cb:b0:258:32c5:ebc4 with SMTP id
 586e51a60fabf-25ceb7b59d3mr304958fac.26.1718997559853; 
 Fri, 21 Jun 2024 12:19:19 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd49dc9c6sm531405fac.34.2024.06.21.12.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:19:18 -0700 (PDT)
Date: Fri, 21 Jun 2024 13:19:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
Message-ID: <20240621191915.GZ68077@bill-the-cat>
References: <20240617171623.GY68077@bill-the-cat>
 <CAFLszThO9Hnfv90X4yu49h7LcWCfgMztSGtQdGwrCt9UDH_cGA@mail.gmail.com>
 <20240618141524.GO68077@bill-the-cat>
 <CAFLszTj--0hi4=isy2Zmq9fBDFr5DMciFs+BZtfuvvmFO-9o9Q@mail.gmail.com>
 <20240619153207.GF68077@bill-the-cat>
 <CAFLszTiHSn4Vw7oMBOwOBC1gAHNYQ3Xc4mT54FkT-dfGSb0F0A@mail.gmail.com>
 <20240620231943.GT68077@bill-the-cat>
 <CAFLszTgA6Gc1T55v07skZQ3U=_JuM7yW9aTxmAtXsoLTbSOtdQ@mail.gmail.com>
 <20240621160514.GY68077@bill-the-cat>
 <CAFLszTi45oeCoLRQK_noh2dHXTMGGteadT83M9Ce9cC2fcR9wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X8IdzF+lBr1f8AkG"
Content-Disposition: inline
In-Reply-To: <CAFLszTi45oeCoLRQK_noh2dHXTMGGteadT83M9Ce9cC2fcR9wA@mail.gmail.com>
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


--X8IdzF+lBr1f8AkG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 11:55:42AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Jun 2024 at 10:05, Tom Rini <trini@konsulko.com> wrote:
[snip]
> > Yes, I very much do not like guessing about 3 numbers instead of
> > guessing about 1 number and using the standard mechanism we already
> > have. Please use BOARD_SIZE_LIMIT as this is the standard mechanism to
> > enforce size limits on U-Boot itself.
>=20
> If it were that easy I would have sent a patch :-)
>=20
> Here is the map for this board:
>=20
> ImagePos    Offset      Size  Name
> 00000000  00000000  00800000  rom
> ff800000   ff800000  00001000  intel-descriptor
> ff801000   ff801000  001ff000  intel-me
> ffef0000   ffef0000  000999f0  u-boot-with-ucode-ptr
> fff899f0   fff899f0  00005554  u-boot-dtb-with-ucode
> fff8ef50   fff8ef50  00000000  u-boot-ucode
> fff8ef50   fff8ef50  00000571  fdtmap
> fff90000   fff90000  00010000  intel-vga
> fffa0000   fffa0000  0002fc94  intel-mrc
> fffcfc94   fffcfc94  00000000  private-files
> fffff800   fffff800  00000070  x86-start16
> fffffff0   fffffff0  00000005  x86-reset16
> fffffff8   fffffff8  00000008  image-header
>=20
> What limit should I set on what?

Is this a trick question?
$ printf %d\\n $(( 0xfff90000 - 0xffef0000))
655360

Of course since we're less than that today, you can reduce it by
whatever other magic numbers I'm not seeing but are part of your assumed
sizes.

> - the U-Boot is the thing you are wanting to limit
> - the dtb has microcode added
> - the ucode is empty in this case
> - the fdtmap is variable in size
>=20
> So this all seems a bit backwards. The actual limit is that
> (u-boot-with-ucode-ptr + u-boot-dtb-with-ucode + u-boot-ucode +
> fdtmap) fits in the space available. Note that some boards don't have
> intel-vga or intel-mrc.
>=20
> With the other patch I sent I can have a sensible limit for all x86 board=
s.

And you can set the same sensible limit with the existing mechanism with
the bonus of it not making x86 different from the rest?

--=20
Tom

--X8IdzF+lBr1f8AkG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ10jAACgkQFHw5/5Y0
tyzcBwv/V6E5AsMkb+0XwxZEl7UGbPADAPNBFd4B3djStIyTfIVUuWlhgQrR6Zfd
ifZDA864dClNkBpUnxEukQpMAPCVw/XgU/txto02H0GCvujjYEkyhLJexasFPG9s
b9HaDU5PsITdreDXLfeyAUyXa3y5iVnJzwBJDQdbBr4VeXHQOIP6WHU3u7ERyVxw
OhQ7yoNMj6rSY9qMrcyjHldTzjryJzhnoia9NP1e0QdVFOrzlF3JIHySK64PI9m3
xJz2aWHHTHjtdym3RTKXMj3sPkUvxBK3lvClKVcluE4tbS/yN3IavUDvq6vgjWE7
R5XdNBwyWuxJ1+w5pOAhS8ZLMfmTkile3X2WjjgfWCjlIG997SX9pINlGhNc8hOu
TNUhsrXIODlE0fFF26Cv5tQUWu3G5GzPNGu9TA7lWdAPKtoJfDQKSHDPSSacMXR1
r5hZoa1unq9vGlWy3W/02y/cEyUMTWfORbTqrpdNB/PQkxOlK4bgZQeTCUyjA3lD
O0ML8uaj
=qxo1
-----END PGP SIGNATURE-----

--X8IdzF+lBr1f8AkG--
