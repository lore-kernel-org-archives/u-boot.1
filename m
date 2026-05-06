Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E158CD3439
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 16:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4C2848EB;
	Wed,  6 May 2026 18:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Es8fkH7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D1084915; Wed,  6 May 2026 18:51:50 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B4F2846DB
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 18:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso1076215a34.1
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 09:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778086307; x=1778691107; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yeQWgHMDA8x3zKyIOSItelaMIzt8Vm/HrUUQM7QNWNE=;
 b=Es8fkH7c9UMpk4SF1I4BK0eSE2eTmbltVw9xtim+J8/7U+nw93GzbV7QtcuaRZhrXr
 nC+ttuiul3IUyOk4J3j2X90cDZl3xJ2kZ2GKseQr9j+jeF9mA/32Qwz8acUFi0gsgAbR
 5TpaYbGUnqwz88gSh7hmOB55pYo9cRvY5PZp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778086307; x=1778691107;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yeQWgHMDA8x3zKyIOSItelaMIzt8Vm/HrUUQM7QNWNE=;
 b=Y9GPFowbAC0h80iUhzAuExF8wtP9ZE0VnG3UqbNxe+eKPzc2OIjWINfepwcJLaeQ1Z
 RRymL1BrQElj7b2AJfikt+uhs5TfkzTa0Gq19ApQYZMTf12Oqo5Uj3m+b2n+npgG2VaL
 4uGywBI3aNSd50gyYXUDVT37DS+ERd+7L82Jmr+8nCU9wkKcUp1G0GBOIVI16ewrrmxB
 CvThRKLXhy24v7m1K2p/QvuIWYZN+tROr/ED+jdJQu7EdCUIM/K/1XW0c+TmaJqZlwzK
 /LGkIUw5nKvSapCrEjd2LNcs1jIYt3jEO8zkhEzkCjwK+5QIfBZsQ7EAZkPSL4xKf0y8
 qB6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iWoXuBB1XvenJNsut2HQFM/fp5Aa2/5zueuTkz0i2d0Bul05NDZvIEMfyi2exr68et++Ycqg=@lists.denx.de
X-Gm-Message-State: AOJu0YxonDTq4D0wn+imwtFbKNLHACCvFT0+q/eh/lJWSxlFgI6TwH8f
 fV4LyGNLxci5CpGW1r93GauIcmw2AveAf2Nxe/DbfgeJ2NiYKg7SSX/LxSnEMAnZsFU=
X-Gm-Gg: AeBDieussNNstSwLNYUq4UWa6AycmjxmV1zXAAporRXllbUOu4Nazzd0OPUbkPV05ZH
 NMCHG/9Y3fR0MPqSSDV7lYVGhaBRM/orkMeSc1bWzJs0Ng1J1KrdnZ0wSytDYF1JAUdKoIGJqCa
 TxmRzQIfTjEp+4O2iN/xV9zSED86FRAa2jUITFYEhTg/AZAMlho2EapttooeP725ivi58Ev1aeu
 YaoyeGW+JWsdD2klvDyQ+iWnbwIvFb8J1RuZdYUOZ+/gXmNOwBitle6b6diuaAD6AifTzBR95YF
 1LE9SB+DfjyBDPvlDpXOpd/xgcaTzD2P8PLaiiWyHdo23hkSUMYIk5zgiIjQ1S81MUhtD/r85R5
 3AFWu4Hd+/KX+WpWyd5eOnRMW5iSzAK5MDvETXHWZ5oxk7rjQBlv1QBNN3ZhT1Embc++zK/tL64
 jthioEH68mTCwKMdmsefnhqG+oq3fxR6l5Btj6pgGMXi0ii9CY3tEMmzN31btXJxC6+CPS+WAMt
 l7gVhLCeYjT7vfCztjl/n5I+kJRAsH9SFYSa6t1TFbsz2i62CYDImIhC/TNIKr0CFwkeWXj
X-Received: by 2002:a05:6830:6ab3:b0:7de:9b99:a8ee with SMTP id
 46e09a7af769-7e0bfccc20amr4877218a34.9.1778086306735; 
 Wed, 06 May 2026 09:51:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca7a9036sm11895959a34.4.2026.05.06.09.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 09:51:46 -0700 (PDT)
Date: Wed, 6 May 2026 10:51:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "casey.connolly@linaro.org" <casey.connolly@linaro.org>,
 "raymond.mao@riscstar.com" <raymond.mao@riscstar.com>,
 "pranav.sanwal@amd.com" <pranav.sanwal@amd.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>
Subject: Re: [PATCH v2] lib: fdtdec: validate bloblist FDT before consuming
 libfdt size
Message-ID: <20260506165143.GT1614990@bill-the-cat>
References: <20260504212524.1665166-1-raymondmaoca@gmail.com>
 <b7432c55f00b4c9b2043ca8efb262a5d5ec4d6e2.camel@siemens.com>
 <CAMDkj5yUHypTiuYk+VqOVA3FSJpDo6CsqsVAWn69nOS3EapAcw@mail.gmail.com>
 <064b011e32963eb1e6220cafe4614186a1fc16c8.camel@siemens.com>
 <20260505143219.GQ1614990@bill-the-cat>
 <CAMDkj5xX5Vpzg1OEc=FGaJNWAyNrsPwtD9HQnVOxDbkr42VUQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UQ01kmTxHVwfPRLM"
Content-Disposition: inline
In-Reply-To: <CAMDkj5xX5Vpzg1OEc=FGaJNWAyNrsPwtD9HQnVOxDbkr42VUQQ@mail.gmail.com>
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


--UQ01kmTxHVwfPRLM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2026 at 11:00:43AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, May 5, 2026 at 10:32=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Tue, May 05, 2026 at 01:49:53PM +0000, Sverdlin, Alexander wrote:
> > > Hi Raymond,
> > >
> > > On Tue, 2026-05-05 at 09:47 -0400, Raymond Mao wrote:
> > > > > > Coverity Scan defects are observed in fdtdec_apply_bloblist_dto=
s(),
> > > > > > since the live FDT taken from the bloblist is passed to libfdt =
helpers
> > > > > > which consume header size/offset fields:
> > > > > > - fdt_open_into()
> > > > > > - fdt_pack()
> > > > > > - bloblist_resize(..., fdt_totalsize(...))
> > > > > >
> > > > > > Add a small helper to validate the FDT header and confirm that =
the
> > > > > > advertised totalsize fits within the currently allocated blobli=
st
> > > > > > record. Use the sanitized size before calling fdt_open_into(), =
again
> > > > > > after overlays are applied before calling fdt_pack(), and once =
more
> > > > > > after packing before shrinking the bloblist record.
> > > > > >
> > > > > > This keeps the existing flow unchanged while making the size co=
nsumers
> > > > > > operate on validated FDT metadata.
> > > > > >
> > > > > > Fixes: b70cbbfbf94f ("fdtdec: apply DT overlays from bloblist")
> > > > > > Addresses-Coverity-ID: CID 645837: (TAINTED_SCALAR)
> > > > > > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > > > > > ---
> > > > > > changes in v2:
> > > > > > - Rebased on master.
> > > > > >
> > > > > >   lib/fdtdec.c | 43 +++++++++++++++++++++++++++++++++++++++----
> > > > > >   1 file changed, 39 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > > > > index 2d66860f6ed..601f418db6e 100644
> > > > > > --- a/lib/fdtdec.c
> > > > > > +++ b/lib/fdtdec.c
> > > > > > @@ -1744,9 +1744,31 @@ static int fdtdec_apply_dto_blob(void **=
blob, __maybe_unused int size)
> > > > > >        return fdt_overlay_apply_verbose((void *)gd->fdt_blob, *=
blob);
> > > > > >   }
> > > > > >
> > > > > > +static int fdtdec_get_valid_fdt_size(const void *fdt, int allo=
c_size,
> > > > > > +                                  int *fdt_sizep)
> > > > > > +{
> > > > > > +     int ret, fdt_size;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * Validate the header before libfdt trusts any header of=
fsets/sizes.
> > > > > > +      * Also make sure the advertised totalsize fits in the bl=
oblist record.
> > > > > > +      */
> > > > > > +     ret =3D fdt_check_header(fdt);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > > +     fdt_size =3D fdt_totalsize(fdt);
> > > > > > +     if (fdt_size > alloc_size)
> > > > > > +             return -FDT_ERR_TRUNCATED;
> > > > >
> > > > > here you return an error from the libfdt error space, but...
> > > > >
> > > > > > +
> > > > > > +     *fdt_sizep =3D fdt_size;
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > >   static int fdtdec_apply_bloblist_dtos(void)
> > > > > >   {
> > > > > > -     int ret;
> > > > > > +     int ret, live_fdt_size;
> > > > > >        struct fdt_header *live_fdt;
> > > > > >        int blob_size;
> > > > > >        size_t padded_size, max_size;
> > > > > > @@ -1760,8 +1782,12 @@ static int fdtdec_apply_bloblist_dtos(vo=
id)
> > > > > >        if (live_fdt !=3D gd->fdt_blob)
> > > > > >                return -ENOENT;
> > > > >
> > > > > ... the caller returns the codes from the standard errno.h
> > > > >
> > > > > >
> > > > > > +     ret =3D fdtdec_get_valid_fdt_size(live_fdt, blob_size, &l=
ive_fdt_size);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > >        /* Calculate the allowed padded size */
> > > > > > -     padded_size =3D fdt_totalsize(live_fdt) + CONFIG_SYS_FDT_=
PAD;
> > > > > > +     padded_size =3D live_fdt_size + CONFIG_SYS_FDT_PAD;
> > > > > >        max_size =3D bloblist_get_total_size() - bloblist_get_si=
ze() + blob_size;
> > > > > >        if (padded_size > max_size)
> > > > > >                padded_size =3D max_size;
> > > > > > @@ -1772,6 +1798,7 @@ static int fdtdec_apply_bloblist_dtos(voi=
d)
> > > > > >                if (ret)
> > > > > >                        return ret;
> > > > > >
> > > > > > +             blob_size =3D padded_size;
> > > > > >                ret =3D fdt_open_into(live_fdt, live_fdt, padded=
_size);
> > > > > >                if (ret)
> > > > > >                        return ret;
> > > > > > @@ -1781,12 +1808,20 @@ static int fdtdec_apply_bloblist_dtos(v=
oid)
> > > > > >        if (ret)
> > > > > >                return ret;
> > > > > >
> > > > > > -     /* Shrink the blob to the actual FDT size */
> > > > > > +     ret =3D fdtdec_get_valid_fdt_size(live_fdt, blob_size, &l=
ive_fdt_size);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > >        ret =3D fdt_pack(live_fdt);
> > > > > >        if (ret)
> > > > > >                return ret;
> > > > > >
> > > > > > -     return bloblist_resize(BLOBLISTT_CONTROL_FDT, fdt_totalsi=
ze(live_fdt));
> > > > > > +     ret =3D fdtdec_get_valid_fdt_size(live_fdt, blob_size, &l=
ive_fdt_size);
> > > > >
> > > > > doesn't the fdt_pack() already guarantee a valid header? Can the =
packed size
> > > > > exceed the blob_size if packing only shrinks?
> > > > >
> > > >
> > > > This might not happen, but just in order to solve the complaint from
> > > > the coverity tool, otherwise we need an exemption.
> > >
> > > Is it some king of new U-Boot policy that Coverity false-positives ju=
stify
> > > a dead or cargo-cult code? Shall it maybe fixed in Coverity itself?
> >
> > If this is a false-positive we can just mark it as such in Coverity.
> > That would be the correct path.
> >
>=20
> v3 is posted at:
> https://lore.kernel.org/u-boot/20260506145535.1679611-1-raymondmaoca@gmai=
l.com/T/#u
> leaving the report (as below) between fdt_pack() and bloblist_resize()
> as a false-positive.
>=20
> 1784            /* Shink the blob to the actual FDT size */
> 1785            fdt_pack(live_fdt);
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *=
)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));

Thanks, I've updated the issue.

--=20
Tom

--UQ01kmTxHVwfPRLM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaftxlAAKCRAr4qD1Cr/k
CkluAP47U7MjlE+x1VihB/3eNUiqZbu51frJMouiSRdA1ZHC2gD/auR1tt/TtajW
6CMvmlhCc99VKrZUPohpGoJ6TOWflQo=
=gT0G
-----END PGP SIGNATURE-----

--UQ01kmTxHVwfPRLM--
