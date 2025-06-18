Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6817C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 22:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F25482C2F;
	Thu, 19 Jun 2025 00:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lHRsUt5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316E382C55; Thu, 19 Jun 2025 00:04:49 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B00F682B20
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 00:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40a4de175a3so93902b6e.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750284285; x=1750889085; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BnOjYuBl5N/L2OsrzYcjuE5K1CsasIQ8jr6yhygvJp4=;
 b=lHRsUt5kYYsrsgNgRfLyDFurKlj76WHRHcNR9LCD405pR1bfSON3qBi/jSa2CQuQZ6
 +6kwIAluTdUP45q48WgtEyDHqZtShsT6M8WLKa5XVUsRXOUVtaukrBaOcCX8DuEbyp89
 F2miHO4gawThB4aI43oNeTyV4xnJWbQPsIGeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750284285; x=1750889085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnOjYuBl5N/L2OsrzYcjuE5K1CsasIQ8jr6yhygvJp4=;
 b=RPnzhO3c8gOMS9sdZJv96GSZCWt4V7ONbg2qIriUOc81Om4sP6zg3uiwUEUFjQ37NU
 wTluKSm8R6oBG60eQm33SEvx1YL7nyhbxPfmqZz5Khkofexnqwrkt6WdjFcT9cIkOmee
 12Yvpbw757AW63SKHcg48n9EGohB3bIroo7IPX4WwYLknqzRavCrLgg8drdd+4GcscFU
 UZBk6TrGs4qbBan3lHw0cUDxv/bkn/SzGAr320Qy+17UGB89rb20yKPFrPOFLefzHZw6
 zex5s3ePBWvRgY8udv0ULc8bmmyYQLL8mJy+tZnVgxEhZjm5Wd5L2xOwqAINE1r9lrB9
 CVbg==
X-Gm-Message-State: AOJu0YyXN/6Vmfn3Nw5z6Z2bha1xy2Bp/EA3z/B7lAKulUvb8tDac5gu
 jpwy08upMX5VZOQ9fWZ0ZpX3d2ylGiTLcjfDjBPkRd1vAMZXGmWJ6L7Hd60qZ4UO75XzxW0oTAR
 8zz9HuXk=
X-Gm-Gg: ASbGncvuezly34Z2GlVTxDXMAvFtxerohaGod5Bpos1cC9KFhyhyNohLFzJOZgvomTU
 Fz3nQu6MU23bAh+G+4HOsPud0WpF5U+YVr7RlO/A0TjEzGFJ7K1zylTFeQP37V97Msh9jKWFUpL
 U8i6zQgcj1r5Et17SR0KkgYfeEekVOdOfikYQkv04aiQBZtzJMR/B8ozb4e7FyWCx9rDwq809c7
 Fzi0PiVS9xNpjgkW24L6Xs+I/TIvGVXqYARo/85QvgIVMDHWcg/SoI9jK51D0YX3PBDLguZjalk
 dogq3UpFBXx4t6g6itI/FFo8yByo7mjnXvP6+Ov3tKLnfcVwpqrQ9L+lHMOwgA9odVr2Jbfr4Oc
 yVeHHKTAM+gPazOWrigpT9XI=
X-Google-Smtp-Source: AGHT+IEGxFmv32w86gXWowDpDUYpuFT7i6emRIYLRcwBJGpjKsxLg4NSjlXdKzZUB+So7IV9EDIMrw==
X-Received: by 2002:a05:6808:d49:b0:406:6d79:49e1 with SMTP id
 5614622812f47-40a7c1a4e30mr12060680b6e.24.1750284285392; 
 Wed, 18 Jun 2025 15:04:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a7418aeb7sm2548140b6e.38.2025.06.18.15.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 15:04:44 -0700 (PDT)
Date: Wed, 18 Jun 2025 16:04:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/6] bloblist: add blob type for DT overlay
Message-ID: <20250618220441.GK6521@bill-the-cat>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-2-raymond.mao@linaro.org>
 <20250618173713.GH6521@bill-the-cat>
 <CAEfUkUJe+sgbPU0BYiZnGo15CMXfaixiRVYNv+vw8+h6YAOrZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ej70bPJA4g6Z+0Gu"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJe+sgbPU0BYiZnGo15CMXfaixiRVYNv+vw8+h6YAOrZA@mail.gmail.com>
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


--Ej70bPJA4g6Z+0Gu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 03:53:15PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Wed, 18 Jun 2025 at 13:37, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jun 18, 2025 at 07:59:23AM -0700, Raymond Mao wrote:
> >
> > > Add blob type for DT overlay according to the update of Firmware
> > > Handoff spec[1].
> > >
> > > [1] https://github.com/FirmwareHandoff/firmware_handoff/pull/74
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >
> > Once merged, this should be a Link: line for tooling to better pick it
> > up. And I don't want to merge this here until it is merged / agreed to
> > in FirmwareHandoff.
> >
> > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > index f32faf78560..b40e04fe2d3 100644
> > > --- a/include/bloblist.h
> > > +++ b/include/bloblist.h
> > > @@ -110,7 +110,8 @@ enum bloblist_tag_t {
> > >       BLOBLISTT_ACPI_TABLES =3D 4,
> > >       BLOBLISTT_TPM_EVLOG =3D 5,
> > >       BLOBLISTT_TPM_CRB_BASE =3D 6,
> > > -     BLOBLISTT_ACPI_PP =3D 7,
> > > +     BLOBLISTT_FDT_OVERLAY =3D 7,
> > > +     BLOBLISTT_ACPI_PP =3D 8,
> >
> > ... sigh, so BLOBLISTT_ACPI_PP isn't something in FirmwareHandoff yet.
> > Was someone working on that it should it be moved down to the project
> > internal numbering area?
> Since we decided to make bloblist compliant to Firmware Handoff, it is
> required to get an ID placeholder in the spec first (at least a PR)
> before updating the code to avoid conflicts, but BLOBLISTT_ACPI_PP
> does not exist in the spec. In this case, I will consider it as a test
> only ID and can be shifted. Or I can move it into the custom range if
> you think that is better.

I'm hoping maybe Patrick will chime in at least as yes, we should either
upstream it, or move it.

--=20
Tom

--Ej70bPJA4g6Z+0Gu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhTN/kACgkQFHw5/5Y0
tyztmQv/fi1oiFCv/r1VGA3XaNz/m7BoeOJHWDm0sC1g3MrzdFIac2aGXRXfnyaz
E9i+ZIdxBvBo5O764oBEAfVPRV6YQrXYkFUcl9butzweyehIyA4d7ac74MKDHxkt
dhzPm8tjwasuuJJs3bqFAcVxj6pHTjpPY19P/V+wimiH+qMj4sYuWLSjZUok/5gF
sVax+tgbNAs6R6Fp7yM37BU8ChWEvbprl7MVE/j81I199UwZ4yHBjqnwEbKnYLYn
eW/pxT5Bwg5Ng9aLNXz0VxyUPRjXMW6y5TQMhnVO7UaY/Tglob5ER75u6/xJ2zpM
Fq7ZX0Xp0n8qt/qqhg6Wrbb9ex1YzWkOfcs14Hdz6G7WT0q5DDSGKOm0SVWqm7jI
fLSrM1cpZOJScIsmzBIcV5ZfH54srZXX5LXMy68eJCZnY/zdc5yUaCoX04SrWODV
7ALsT/ZBqJQc9Cq2E6d8u5zIbFBzKC/J3asu5koizcsjfsrVgI2wFZEuXZrilNk9
TXsnvUPJ
=YXcb
-----END PGP SIGNATURE-----

--Ej70bPJA4g6Z+0Gu--
