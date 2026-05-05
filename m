Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36999CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 13:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0A33848FC;
	Tue,  5 May 2026 15:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fRYuqPsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B488493F; Tue,  5 May 2026 15:47:17 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A3D848B9
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-612d8a59ca0so3460339137.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 06:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777988834; cv=none;
 d=google.com; s=arc-20240605;
 b=K35S//4Avcuo18R33rwLR++tNxeUv/PpSDhtHz2TZNQGcBkUHmhM/H5h0ulIOy2AM4
 YQ0rSTNuunxkqisQ+W0ylh+DTezTWvNNgDhFqMDaXacLDWp26jdyRScqpDkMCeVr+Uys
 3Tf/B83waaBQzT7yGkRqBL4QDfw3APCZNoLDWA2HZm9BlFbnY4f9i7CnYzOV18eox78j
 Y8YJqF0zVSQ2D3gd7M8kULjz+d9Zt65P/GZUl1cLEXfill2GBrNJsweu47gQJ5VRwF+a
 qxrkv9nb3h0XMJM6cfo4YelpDFMgZcpeqf+6HVhm7qJIGB2loAR7ppFtFXwjZY/m0nMh
 b3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J81hK9WQqZsyMatVdstSY2G86BviPvqirYBPD4Bewtw=;
 fh=LreFm9mn1MAcrpW1m+2bm+MhsMg7kY17DcY0aS1XlUc=;
 b=HMzc8DGnqnSbTfTnbV4G/3nNEg5f9zcF2vWSvcb0LAAKrBvjakhaE3Le6oguPqnaKg
 awO2vohB+gytLdi7tAoGRjRYQyiS0hQBvwzqi2qK7jqCYsjexEJ9+5YtW12Pzs80xYbn
 odXBBVGjqxlIZgZqJJvO9D/ssfAebYLfGyJrBNXTRlwMYBhmOeX53c5eZl8y/StJ/Mls
 S1lXdYuE1KhINMgP3D6yBn3GisR/YGHQ5apacMKDmJbrQpti58r+TeFsJyscmKjaUrnN
 If7tE//NmKohA1JqXHYnQqgHCAHZqWsn2Hj8gU9jySPpcosVbBqPV71PH+gvr/EYKItW
 6a0g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777988834; x=1778593634; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J81hK9WQqZsyMatVdstSY2G86BviPvqirYBPD4Bewtw=;
 b=fRYuqPsSmmbo+p1iYCpIl9bg7mGmedashF7i1Y8EdMC5uG+UwsXERvqwWYd4hFhAaT
 t+Moe9DMjYEygNaW9M83ikQ9w3UXEsbR+6fED6W/Db/rEWTWtiSbTXlQHisCMjmagrgC
 F5FpNTs37cqv9Eet8+k/EVwGDmNg3RIFGfKczlK/BSXgBGPMimSoJBAJitdVty9QOT+e
 CwuZ8F9chY0kajEq5ZH2RZAR9RvhlYFhMaiv160Ku7/RhBFJqoUfJppmCvX6ONarAQPe
 c7C3oD7C+4ORPdXl6zzcZOglrxRn017wE80Ufad+Avqs/jm3Pl+TO+btdxAk2wBF/oI1
 02Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777988834; x=1778593634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J81hK9WQqZsyMatVdstSY2G86BviPvqirYBPD4Bewtw=;
 b=YqQwIqVTtDkKmrZAxnjMdpu69G6UUNrSt4AL5nEnt97wOtTOAuKtO+rrBUdgOsgyIH
 NtgdR+y0HsLBGjoMUFRlVcOyIUA5ra2fepxeq4r7GSbKbpqKND55XR2iBvpe6JqofwQi
 MlPSsIZGnR1iRqFWadFa5plS8GeEZUZKoQij92m8lybXBceJ9C7jxo/bhfOKLCrazTj3
 5TBnj6+97DmzxcSBqh7paTuldCia8OfOu91PL65ijn2hyvNaVXHxrvVBYPs7UNzH5mof
 Wh5UuUJwHtSqlfflImbaWUZnNTy4RRfj8KUuB9X+2SVt5gWoWMVzIbDIixrW/GNhk6F5
 UiGQ==
X-Gm-Message-State: AOJu0YyhrWKY62H0PeNXOQ69zGFYQtH4LvKDauA+piNZdTNRc/18oH37
 aN0wmaaz60M9PWS+7SxclMuOFk3O8HNzQ3DNXYpRqzuL4jpDg2VmfKpqi4a05GIQ+idcsMIxgYo
 D33ed/rxuH8zreCT7W5kmOQYXzOYo2yg=
X-Gm-Gg: AeBDieskEi4VSdTJQD2R1cC6Bz5rkvfwP9z71918xwSIWE+XhfyA1b0OTDlxKSBkpd3
 gMn8P6+2XaR2pt0HKs6ZLC65g+YP9+3S2VnQGtW2tB8oKTfaQ9xMymtCvnUNxufKTUERgte6qmn
 +T8NMKGfE/kL20y+o/Iifm71ikE0rK68Xl6OVPREfLFaEUAXD+vxYknIXyOzS1eeUAexgMYbRES
 2Xy/AUe+Ws30Z1+FtgASEdECL/9PJLBWtNPOhZb9BkYX4VbavhPaguwp1lUvUJLJ+Hhj9bqzAbi
 7XxbKcUQlLKdamtO1Z0=
X-Received: by 2002:a05:6102:2d0d:b0:610:76c6:b74a with SMTP id
 ada2fe7eead31-62d868151a0mr7946906137.14.1777988833649; Tue, 05 May 2026
 06:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260504212524.1665166-1-raymondmaoca@gmail.com>
 <b7432c55f00b4c9b2043ca8efb262a5d5ec4d6e2.camel@siemens.com>
In-Reply-To: <b7432c55f00b4c9b2043ca8efb262a5d5ec4d6e2.camel@siemens.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 5 May 2026 09:47:01 -0400
X-Gm-Features: AVHnY4Lz1wCYwL-vvDPmRY0WGdL6GdHLgIaUa09VYMinEL9spaBFVczOkbHZtDU
Message-ID: <CAMDkj5yUHypTiuYk+VqOVA3FSJpDo6CsqsVAWn69nOS3EapAcw@mail.gmail.com>
Subject: Re: [PATCH v2] lib: fdtdec: validate bloblist FDT before consuming
 libfdt size
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "trini@konsulko.com" <trini@konsulko.com>, 
 "casey.connolly@linaro.org" <casey.connolly@linaro.org>, 
 "raymond.mao@riscstar.com" <raymond.mao@riscstar.com>,
 "pranav.sanwal@amd.com" <pranav.sanwal@amd.com>, 
 "michal.simek@amd.com" <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Alexander,

On Tue, May 5, 2026 at 4:31=E2=80=AFAM Sverdlin, Alexander
<alexander.sverdlin@siemens.com> wrote:
>
> Hi Raymond,
>
> On Mon, 2026-05-04 at 17:25 -0400, Raymond Mao wrote:
> > From: Raymond Mao <raymond.mao@riscstar.com>
> >
> > Coverity Scan defects are observed in fdtdec_apply_bloblist_dtos(),
> > since the live FDT taken from the bloblist is passed to libfdt helpers
> > which consume header size/offset fields:
> > - fdt_open_into()
> > - fdt_pack()
> > - bloblist_resize(..., fdt_totalsize(...))
> >
> > Add a small helper to validate the FDT header and confirm that the
> > advertised totalsize fits within the currently allocated bloblist
> > record. Use the sanitized size before calling fdt_open_into(), again
> > after overlays are applied before calling fdt_pack(), and once more
> > after packing before shrinking the bloblist record.
> >
> > This keeps the existing flow unchanged while making the size consumers
> > operate on validated FDT metadata.
> >
> > Fixes: b70cbbfbf94f ("fdtdec: apply DT overlays from bloblist")
> > Addresses-Coverity-ID: CID 645837: (TAINTED_SCALAR)
> > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > ---
> > changes in v2:
> > - Rebased on master.
> >
> >  lib/fdtdec.c | 43 +++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 39 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index 2d66860f6ed..601f418db6e 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1744,9 +1744,31 @@ static int fdtdec_apply_dto_blob(void **blob, __=
maybe_unused int size)
> >       return fdt_overlay_apply_verbose((void *)gd->fdt_blob, *blob);
> >  }
> >
> > +static int fdtdec_get_valid_fdt_size(const void *fdt, int alloc_size,
> > +                                  int *fdt_sizep)
> > +{
> > +     int ret, fdt_size;
> > +
> > +     /*
> > +      * Validate the header before libfdt trusts any header offsets/si=
zes.
> > +      * Also make sure the advertised totalsize fits in the bloblist r=
ecord.
> > +      */
> > +     ret =3D fdt_check_header(fdt);
> > +     if (ret)
> > +             return ret;
> > +
> > +     fdt_size =3D fdt_totalsize(fdt);
> > +     if (fdt_size > alloc_size)
> > +             return -FDT_ERR_TRUNCATED;
>
> here you return an error from the libfdt error space, but...
>
> > +
> > +     *fdt_sizep =3D fdt_size;
> > +
> > +     return 0;
> > +}
> > +
> >  static int fdtdec_apply_bloblist_dtos(void)
> >  {
> > -     int ret;
> > +     int ret, live_fdt_size;
> >       struct fdt_header *live_fdt;
> >       int blob_size;
> >       size_t padded_size, max_size;
> > @@ -1760,8 +1782,12 @@ static int fdtdec_apply_bloblist_dtos(void)
> >       if (live_fdt !=3D gd->fdt_blob)
> >               return -ENOENT;
>
> ... the caller returns the codes from the standard errno.h
>
> >
> > +     ret =3D fdtdec_get_valid_fdt_size(live_fdt, blob_size, &live_fdt_=
size);
> > +     if (ret)
> > +             return ret;
> > +
> >       /* Calculate the allowed padded size */
> > -     padded_size =3D fdt_totalsize(live_fdt) + CONFIG_SYS_FDT_PAD;
> > +     padded_size =3D live_fdt_size + CONFIG_SYS_FDT_PAD;
> >       max_size =3D bloblist_get_total_size() - bloblist_get_size() + bl=
ob_size;
> >       if (padded_size > max_size)
> >               padded_size =3D max_size;
> > @@ -1772,6 +1798,7 @@ static int fdtdec_apply_bloblist_dtos(void)
> >               if (ret)
> >                       return ret;
> >
> > +             blob_size =3D padded_size;
> >               ret =3D fdt_open_into(live_fdt, live_fdt, padded_size);
> >               if (ret)
> >                       return ret;
> > @@ -1781,12 +1808,20 @@ static int fdtdec_apply_bloblist_dtos(void)
> >       if (ret)
> >               return ret;
> >
> > -     /* Shrink the blob to the actual FDT size */
> > +     ret =3D fdtdec_get_valid_fdt_size(live_fdt, blob_size, &live_fdt_=
size);
> > +     if (ret)
> > +             return ret;
> > +
> >       ret =3D fdt_pack(live_fdt);
> >       if (ret)
> >               return ret;
> >
> > -     return bloblist_resize(BLOBLISTT_CONTROL_FDT, fdt_totalsize(live_=
fdt));
> > +     ret =3D fdtdec_get_valid_fdt_size(live_fdt, blob_size, &live_fdt_=
size);
>
> doesn't the fdt_pack() already guarantee a valid header? Can the packed s=
ize
> exceed the blob_size if packing only shrinks?
>

This might not happen, but just in order to solve the complaint from
the coverity tool, otherwise we need an exemption.

Regards,
Raymond

> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Shrink the blob to the actual FDT size */
> > +     return bloblist_resize(BLOBLISTT_CONTROL_FDT, live_fdt_size);
> >  }
> >
> >  int fdtdec_setup(void)
>
> --
> Alexander Sverdlin
> Siemens AG
> www.siemens.com
