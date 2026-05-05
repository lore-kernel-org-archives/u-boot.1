Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E631FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 14:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA700848FC;
	Tue,  5 May 2026 16:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tO7cYLgv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 313EB84968; Tue,  5 May 2026 16:32:32 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CFF848CE
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4232323a7daso2055199fac.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777991548; x=1778596348; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ShOo8fyBdqJyKxfj6IsL5mA1Tl9+HrWyQ6SMu/4iaZM=;
 b=tO7cYLgvvQnwSk88YvdUshAZL69keVCjs151zRREvZhtHqaSScvSP/GwC7vA9DwVN7
 0zrXqqEI2KOC8JPJQjg+oQaT91ytXrkQE0pZk8pPqrA+y/dMfTlo70LWv+sDqxPQTYKU
 l+f/MS4cRiZqEl8vEaMTuAVzxW/o5su8FeD9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777991548; x=1778596348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShOo8fyBdqJyKxfj6IsL5mA1Tl9+HrWyQ6SMu/4iaZM=;
 b=T9rngucy6SKNzl5vGsVuKL3HmaKlkP4TXM0Rr5J9g87WwJCBNa3hDR2u+iKWw1Wrx2
 7EvKpi1beFLwcdwF3XLdT5ZZP/hmvxL4Njl2/GhW6m5AqpA1tK8xPV23GfGLetF4TZAO
 60u98yJzXnueHO9j5kYXqe2kvl8PqiDFHfq0S3BdHE2z0UGTGH5THKGfKj2LsgHYz8za
 uwJ0i3FyPwjQApo2VlG2qUudRAIb8ogjjBGaXt7Wo1mMUR7mrE4NvkVh2lZfSTmvdKq4
 ofr6IJQO2owzhRv3W9nVp7elF69EmPgCoybJyhiof9DssZNTglZyeRNrzPNnyCeaWRrB
 31Hg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oh4KbmLtcRBSX9zVSYvo798Z6jNmasCCg4IDiRswcbdsbSV9iLGAU1H981cZFiV45WGjwyhM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxy6VNGd62HXf4mSt+ApDnxiLr/jRzETCAo/CN95VxjRBqRBFH1
 GVenjyalnjHPxlRbGDXEix++Ghndk2eOHM1SZ+RtNZICExWKaQhZavkUegPpg6Mmth0=
X-Gm-Gg: AeBDietQlPFZjbxBbd11mWui0oJpEPWYR97tIxQ/Bwv6M4rZ5JqMoZOpnhU7JYsgpOj
 N3rzKv/1rbUZ0PhS/Y9oDnaMT/PS0tahYv4aPkpK+m8R/xmQpfaqodscT9xO0pfrDkAgAfkzUDf
 y7B937DwtCYiXpuCwW/74+sSVTV1mFAhUvDFKE7ZOnx3ofJOCVDCB2RcZwdZG/aIAB82jCI5xWo
 cHjhprt3YJ1cfcwmRrZrJkhihWHcVnI6/d62RaAFi3nFqNOPAujVncjvWIY56UGdg1zauBcamPQ
 vgjcFNHkkvKyP0jC/ZFWvQHanUolRZNYMHplM/wk72bNPlIlnep51eZvNRFA2tJ+ZY7/lTRk4gd
 tJAjb0hGj/SQjfGmEyt+fp3jMUWlwX7445nQoWaE2RKKj4vRMxdyVc+1POrnOceLxKVZBUJu4VK
 AhYb4mvcshA6DzTmIuGw7TmcwS7dcqy1eCB5iXoLIj4YXUXYSpcOj9f3kO7mfj4EmWvy4kQ5qAG
 4u6cFiUG6GG/pzBLchSXomwKaaVJpSHHjS7D8ZjcMOv5lGmB703bymErmazJnSp8nD/Cr78
X-Received: by 2002:a05:6871:108:b0:42f:ae89:6eca with SMTP id
 586e51a60fabf-434d3fc6b95mr1950565fac.13.1777991542053; 
 Tue, 05 May 2026 07:32:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-434548d9decsm14468122fac.3.2026.05.05.07.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 07:32:21 -0700 (PDT)
Date: Tue, 5 May 2026 08:32:19 -0600
From: Tom Rini <trini@konsulko.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "raymondmaoca@gmail.com" <raymondmaoca@gmail.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "casey.connolly@linaro.org" <casey.connolly@linaro.org>,
 "raymond.mao@riscstar.com" <raymond.mao@riscstar.com>,
 "pranav.sanwal@amd.com" <pranav.sanwal@amd.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>
Subject: Re: [PATCH v2] lib: fdtdec: validate bloblist FDT before consuming
 libfdt size
Message-ID: <20260505143219.GQ1614990@bill-the-cat>
References: <20260504212524.1665166-1-raymondmaoca@gmail.com>
 <b7432c55f00b4c9b2043ca8efb262a5d5ec4d6e2.camel@siemens.com>
 <CAMDkj5yUHypTiuYk+VqOVA3FSJpDo6CsqsVAWn69nOS3EapAcw@mail.gmail.com>
 <064b011e32963eb1e6220cafe4614186a1fc16c8.camel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V5nCULDEgagPXbT7"
Content-Disposition: inline
In-Reply-To: <064b011e32963eb1e6220cafe4614186a1fc16c8.camel@siemens.com>
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


--V5nCULDEgagPXbT7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026 at 01:49:53PM +0000, Sverdlin, Alexander wrote:
> Hi Raymond,
>=20
> On Tue, 2026-05-05 at 09:47 -0400, Raymond Mao wrote:
> > > > Coverity Scan defects are observed in fdtdec_apply_bloblist_dtos(),
> > > > since the live FDT taken from the bloblist is passed to libfdt help=
ers
> > > > which consume header size/offset fields:
> > > > - fdt_open_into()
> > > > - fdt_pack()
> > > > - bloblist_resize(..., fdt_totalsize(...))
> > > >=20
> > > > Add a small helper to validate the FDT header and confirm that the
> > > > advertised totalsize fits within the currently allocated bloblist
> > > > record. Use the sanitized size before calling fdt_open_into(), again
> > > > after overlays are applied before calling fdt_pack(), and once more
> > > > after packing before shrinking the bloblist record.
> > > >=20
> > > > This keeps the existing flow unchanged while making the size consum=
ers
> > > > operate on validated FDT metadata.
> > > >=20
> > > > Fixes: b70cbbfbf94f ("fdtdec: apply DT overlays from bloblist")
> > > > Addresses-Coverity-ID: CID 645837: (TAINTED_SCALAR)
> > > > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > > > ---
> > > > changes in v2:
> > > > - Rebased on master.
> > > >=20
> > > > =A0 lib/fdtdec.c | 43 +++++++++++++++++++++++++++++++++++++++----
> > > > =A0 1 file changed, 39 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > > index 2d66860f6ed..601f418db6e 100644
> > > > --- a/lib/fdtdec.c
> > > > +++ b/lib/fdtdec.c
> > > > @@ -1744,9 +1744,31 @@ static int fdtdec_apply_dto_blob(void **blob=
, __maybe_unused int size)
> > > > =A0=A0=A0=A0=A0=A0 return fdt_overlay_apply_verbose((void *)gd->fdt=
_blob, *blob);
> > > > =A0 }
> > > >=20
> > > > +static int fdtdec_get_valid_fdt_size(const void *fdt, int alloc_si=
ze,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *fdt_sizep)
> > > > +{
> > > > +=A0=A0=A0=A0 int ret, fdt_size;
> > > > +
> > > > +=A0=A0=A0=A0 /*
> > > > +=A0=A0=A0=A0=A0 * Validate the header before libfdt trusts any hea=
der offsets/sizes.
> > > > +=A0=A0=A0=A0=A0 * Also make sure the advertised totalsize fits in =
the bloblist record.
> > > > +=A0=A0=A0=A0=A0 */
> > > > +=A0=A0=A0=A0 ret =3D fdt_check_header(fdt);
> > > > +=A0=A0=A0=A0 if (ret)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > +
> > > > +=A0=A0=A0=A0 fdt_size =3D fdt_totalsize(fdt);
> > > > +=A0=A0=A0=A0 if (fdt_size > alloc_size)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -FDT_ERR_TRUNCATED;
> > >=20
> > > here you return an error from the libfdt error space, but...
> > >=20
> > > > +
> > > > +=A0=A0=A0=A0 *fdt_sizep =3D fdt_size;
> > > > +
> > > > +=A0=A0=A0=A0 return 0;
> > > > +}
> > > > +
> > > > =A0 static int fdtdec_apply_bloblist_dtos(void)
> > > > =A0 {
> > > > -=A0=A0=A0=A0 int ret;
> > > > +=A0=A0=A0=A0 int ret, live_fdt_size;
> > > > =A0=A0=A0=A0=A0=A0 struct fdt_header *live_fdt;
> > > > =A0=A0=A0=A0=A0=A0 int blob_size;
> > > > =A0=A0=A0=A0=A0=A0 size_t padded_size, max_size;
> > > > @@ -1760,8 +1782,12 @@ static int fdtdec_apply_bloblist_dtos(void)
> > > > =A0=A0=A0=A0=A0=A0 if (live_fdt !=3D gd->fdt_blob)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOENT;
> > >=20
> > > ... the caller returns the codes from the standard errno.h
> > >=20
> > > >=20
> > > > +=A0=A0=A0=A0 ret =3D fdtdec_get_valid_fdt_size(live_fdt, blob_size=
, &live_fdt_size);
> > > > +=A0=A0=A0=A0 if (ret)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > +
> > > > =A0=A0=A0=A0=A0=A0 /* Calculate the allowed padded size */
> > > > -=A0=A0=A0=A0 padded_size =3D fdt_totalsize(live_fdt) + CONFIG_SYS_=
FDT_PAD;
> > > > +=A0=A0=A0=A0 padded_size =3D live_fdt_size + CONFIG_SYS_FDT_PAD;
> > > > =A0=A0=A0=A0=A0=A0 max_size =3D bloblist_get_total_size() - bloblis=
t_get_size() + blob_size;
> > > > =A0=A0=A0=A0=A0=A0 if (padded_size > max_size)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 padded_size =3D max_size;
> > > > @@ -1772,6 +1798,7 @@ static int fdtdec_apply_bloblist_dtos(void)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
return ret;
> > > >=20
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blob_size =3D padded_size;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D fdt_open_into(li=
ve_fdt, live_fdt, padded_size);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
return ret;
> > > > @@ -1781,12 +1808,20 @@ static int fdtdec_apply_bloblist_dtos(void)
> > > > =A0=A0=A0=A0=A0=A0 if (ret)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > >=20
> > > > -=A0=A0=A0=A0 /* Shrink the blob to the actual FDT size */
> > > > +=A0=A0=A0=A0 ret =3D fdtdec_get_valid_fdt_size(live_fdt, blob_size=
, &live_fdt_size);
> > > > +=A0=A0=A0=A0 if (ret)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > +
> > > > =A0=A0=A0=A0=A0=A0 ret =3D fdt_pack(live_fdt);
> > > > =A0=A0=A0=A0=A0=A0 if (ret)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > >=20
> > > > -=A0=A0=A0=A0 return bloblist_resize(BLOBLISTT_CONTROL_FDT, fdt_tot=
alsize(live_fdt));
> > > > +=A0=A0=A0=A0 ret =3D fdtdec_get_valid_fdt_size(live_fdt, blob_size=
, &live_fdt_size);
> > >=20
> > > doesn't the fdt_pack() already guarantee a valid header? Can the pack=
ed size
> > > exceed the blob_size if packing only shrinks?
> > >=20
> >=20
> > This might not happen, but just in order to solve the complaint from
> > the coverity tool, otherwise we need an exemption.
>=20
> Is it some king of new U-Boot policy that Coverity false-positives justify
> a dead or cargo-cult code? Shall it maybe fixed in Coverity itself?

If this is a false-positive we can just mark it as such in Coverity.
That would be the correct path.

--=20
Tom

--V5nCULDEgagPXbT7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafn/cgAKCRAr4qD1Cr/k
CqNOAQDAtOvEsZVsjrmhDOcLSn5t0X86g/OyetjGfc5h0G4XrgD9GG9V0y/Yz4Ml
zN2JeTlOcNftvMqOLERA04AomraGkw8=
=lgz/
-----END PGP SIGNATURE-----

--V5nCULDEgagPXbT7--
