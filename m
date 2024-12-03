Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068DBE64AAE
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70374895C7;
	Tue,  3 Dec 2024 15:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cAsrq2uV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA978950E; Tue,  3 Dec 2024 15:04:07 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B108961F
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b667e13949so314575885a.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 06:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733234644; x=1733839444; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SF37y2BuIwPMago7cEaXFREZD/yFjtOxTaOVXsPR/Zs=;
 b=cAsrq2uVUL1PRzj1WwcLHYyr7aODcgT0s6P/zywgr3qN3CD8aJljKGwdroEyKfH5UN
 XfZgifk4q52tk+ML02Cq+NEntKFmBiESUqBpkmTVmSIdrAXY0CASlTxrN+KWN0dcCaMd
 sgiSdgCGYo+H537PQOnLvKlZb6zGhjxmzQSQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733234644; x=1733839444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SF37y2BuIwPMago7cEaXFREZD/yFjtOxTaOVXsPR/Zs=;
 b=c0NcspaMczlfPLnNq0msCLOFhtJ6/ON9Ks7Wm2/I9Gj7ncl7TWO/bhbGYUx1FjzfB9
 KdkrrCUKlvb2T0PD6gvPs/Hox8XgJe+pV2rgrUW/6oa1ZNt8GM8/Zx114cybKfVLLRDP
 uMoZBSYy9le0L6PncMhMytMHHHkhubJ7i1V1LVmfSI4qsCucqGYvbLWDUjadoXuIUC5Y
 L4dDDXiDC+xe1ZCUxFvioVzpCkL2iaIYcc3ajOCYcOnbQx22qOC9+AkMJ7iK273ZO800
 SNt9Z8u00ds7I4WoFspUf1o3RiW4eNrdMPVjY2MpLFCPdAFXWPxQrhNk5UHto4Ho7xDI
 UAIg==
X-Gm-Message-State: AOJu0YyPg/IyUKVj/sRijZeqaz1ZMOPxITMI/DQF4mJXdcqG9ha7BBKP
 rJ12/+24dccR6VgjfdxIjnJqiIVzJxu4Juj/612+fFN86Kqjp6eTN4eWVrXwdTc=
X-Gm-Gg: ASbGncuacL0D6quAq4vRbCCddGnNJJAbd62M3lWGEhZ59LEDdWq9CL/1xLgi/ry4mMT
 lxDkjC787P5PQU58iK+QQJdv0YZlQXH1kvr/TBROBJulVxomO5etc7CxN4TIzCLN2Mnwnpx+zVj
 sJZBAgUdtEhs/eOoPKMKiwxaUrBJT0iiYS5dy91IukTIk9NxmI2Mnx7NZA1qDmtRcYNMv33rMQH
 cQP58RRyq6YPQGhDgqRV2CvXONSA0VoU3LmPOK/1xb+3IaaQQ==
X-Google-Smtp-Source: AGHT+IE3jmXB68l433ggvUnOwlX6PTAzU+B5tc1xYYmZ1em/n7awAjJ5ncysUjtkXyaV437VFBwcqQ==
X-Received: by 2002:a05:620a:8018:b0:7b1:64fa:3696 with SMTP id
 af79cd13be357-7b6a61cdcf2mr315568885a.51.1733234643997; 
 Tue, 03 Dec 2024 06:04:03 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849217e9sm510574985a.23.2024.12.03.06.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 06:04:03 -0800 (PST)
Date: Tue, 3 Dec 2024 08:04:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 03/25] efi_loader: Drop extra brackets in
 efi_mem_carve_out()
Message-ID: <20241203140400.GU2457179@bill-the-cat>
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-4-sjg@chromium.org>
 <20241202201641.GF2457179@bill-the-cat>
 <CAFLszTjji7SwxEHYcw6dQdJA__epJ_CpqvOeEVR0AVP_gJUR+A@mail.gmail.com>
 <20241203003719.GN2457179@bill-the-cat>
 <CAFLszTh91eW5yQgQHLDVfe67GYw_f9-jzWmdu9pDTaEvNEG2Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EWUfStHpTBPay4A8"
Content-Disposition: inline
In-Reply-To: <CAFLszTh91eW5yQgQHLDVfe67GYw_f9-jzWmdu9pDTaEvNEG2Bg@mail.gmail.com>
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


--EWUfStHpTBPay4A8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 06:46:11AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 2 Dec 2024 at 17:37, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Dec 02, 2024 at 05:24:35PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 2 Dec 2024 at 13:16, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Dec 01, 2024 at 08:24:22AM -0700, Simon Glass wrote:
> > > > > Simplify a few expressions in this function.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  lib/efi_loader/efi_memory.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_mem=
ory.c
> > > > > index f1154f73e05..3b1c7528e92 100644
> > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > @@ -206,11 +206,11 @@ static s64 efi_mem_carve_out(struct efi_mem=
_list *map,
> > > > >                            (carve_desc->num_pages << EFI_PAGE_SHI=
FT);
> > > > >
> > > > >       /* check whether we're overlapping */
> > > > > -     if ((carve_end <=3D map_start) || (carve_start >=3D map_end=
))
> > > > > +     if (carve_end <=3D map_start || carve_start >=3D map_end)
> > > > >               return EFI_CARVE_NO_OVERLAP;
> > > > >
> > > > >       /* We're overlapping with non-RAM, warn the caller if desir=
ed */
> > > > > -     if (overlap_conventional && (map_desc->type !=3D EFI_CONVEN=
TIONAL_MEMORY))
> > > > > +     if (overlap_conventional && map_desc->type !=3D EFI_CONVENT=
IONAL_MEMORY)
> > > > >               return EFI_CARVE_OVERLAPS_NONRAM;
> > > > >
> > > > >       /* Sanitize carve_start and carve_end to lie within our bou=
nds */
> > > >
> > > > As I believe was mentioned in a previous iteration, please drop thi=
s as
> > > > they aren't excessive generates a compiler warning, merely for
> > > > clarification and should be kept.
> > >
> > > I did this patch because checkpatch complained and I am changing thes=
e lines.
> >
> > And checkpatch is not the authority, it's guidelines.
>=20
> Agreed.
>=20
> > I believe the
> > review comments are "no, these should stay". Please drop this patch.
>=20
> Just so I can figure out what to do here, are you saying:
> - merge this patch in with the one that produces a checkpatch warning
> (i.e. remove brackets so resolve warning), or
> - drop this patch and ignore the checkpatch warning in the result

Yes, please just drop this patch, I only look at ERROR from checkpatch
when merging things and then it's a matter of what the error is.

> I don't really mind about this, obviously. But as I suspect this
> series is not going to be applied to your tree anyway, I'll await
> events.

Yes, if you're not going to be addressing most of the comments you get
this is going to linger in, well, whatever it is you plan to be doing
exactly.

--=20
Tom

--EWUfStHpTBPay4A8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPD9AACgkQFHw5/5Y0
tyzYQAv+JDUWS5M0MDudHvn3GUsezv6XCQQbwKixLEOZGXnMBZFp0VEpQJPh+BjC
G7dcadSLqGfZvwq58cxNJafKU0lOlBF4mdYypbgsRJ9Vb4786MqnZhkHKt1luBlN
QuIcP3zH3asxK1DyfG2wW3EbQGo84pMuCMGw5gog7/f/+kGa0Po0sqVffoz00kCu
OeV0gXbo+ghqMEI152UwBd+kn8ep9u1ts5uZ3Wy9BXMkd2qtILY6HTDQdIvB49hq
okyYtYfsukY6lXAOsXOK8d1umo+BY2K2hP3z9E34Wq1JFS88jMNenb/gMvEi9XQD
T4CqY6eQZ+nP0TBT72hAflMMWOvDLLQ167/qm8kZA+XYoJg7+K78kzz7LCPrqtTG
Ggm1utV3onxMt0ayjMHTbY5XxUwy0GBiaCNn5EbwGvjkBZ3sj89zfDYCha0DrSdT
eXbSDax98WwN8GElhl4UpepYWqqoy8u6+ryYqoY4GNc6KI4TW66CAcgbStYzSCeo
6mEeBANZ
=icHP
-----END PGP SIGNATURE-----

--EWUfStHpTBPay4A8--
