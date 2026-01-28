Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6797CD3F092
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 16:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A706384034;
	Wed, 28 Jan 2026 17:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="caoO36+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D7B184035; Wed, 28 Jan 2026 17:11:23 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6196D8401A
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 17:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45f18e8f2f5so19754b6e.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769616679; x=1770221479; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VQ7R2RN9M5373t+K4MqwDV9Ac1A5BFjJH9LNtcIJiSk=;
 b=caoO36+I7SSeEt8JytMkeBURMtTrWxSlgD/cvj9alffFE1U77Q71DdNjqpttOAYPqW
 /CTMmp4rasO40X2sWJSNj6qyPfL2oX6XScumUrjT7EzUgQ9cQ3RBnA03eUgJm73tyzdv
 Ot6yHDBnr6hi+LQJA+DY2i9XUPAzpaV7m0LDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769616679; x=1770221479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQ7R2RN9M5373t+K4MqwDV9Ac1A5BFjJH9LNtcIJiSk=;
 b=ry3DlkPRLdZ7hpBxF38Q2gDCPEGKHgjSEtFngWphownFF/3taRF+yfZjVZyETsrp0N
 8vFxyefmxWF+DPrl7bHpCJu2QIkrPDM6vuvP00u5s85f3vvpTXd/rWoxx0QHlLwUj6AW
 rSwYBSBcGC132p1rR2J5xI8iIK7Z8wg3Epbe/Tan1qtXttpATR1G17CZtdBGLXZ4rG/r
 IQOyfh8LLEocmwT4JzRKJhrYKy/6aO37qkIV8NozwbNZyoAyVdX3+Mt5DrfFuNGrcUuM
 +LpliFmHpSlgPwW7hGnn/gvmqVx8v0t5PK5NaOJSTAyAZB1r42Zh8qZJZqxJX/gK0jOT
 i1Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJYKdU7+XKyj5Z2+bjr1JOXg6QC7kUys7ZCGl0SKeADQGOG1xv5/MqYv5XPWvD3q8hNUKrdQ0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5/AJGfK6+amXYezirZodBbUmwuMopAGilvpNIwVO0FRWoovwq
 L2/3+WBED5G+BEtrV9LDUWFMy+bsjM/ip+nJntgxtODHVnBWx4Km4VxQn3FzHdm7wHE=
X-Gm-Gg: AZuq6aIhnLyWR0E9tHDItQh4wZPRWUKYFwiwhGNRry6uw1Hh5rb27v7pJw3omVKsgTE
 b243ZWABUOroBMQXQ1NpwtLE+Y5sWxkKyt1v57k9imroJRU6g/1DnlF4ah3RMp2yL7mqnWACz/K
 VRHa5nE27x7tj0pWMIAvPSNaD1kTuP/APSZ+Or7clLx5tiW2E4RdHVOK+gc0sU31abmszPgXOKr
 XjNW9tx8Sw2fHhPBZuVZF7/ukGk6Qxfr4SyNX3j0bIZ1tPAbA7T1WxsR5PvFmX9e4tgqCaUt2vJ
 vdojKasBWvugtNxzVV/gK2asJxfWQKb125P/1l+cnkA8b34hovsxSOhrHEXyuBzUoQ7xXwmFpLs
 pCkjA3TVVwwBtWk1ozPTfOr/OrbKlVIkbon2to/6jx3FTmpIj+fPxhSBsYY7Xl1m8qsc9FUgA9U
 TDThGCobkxOPKl/F1E7tLuV5S2mAZbGJT0Ha4y+kLf7zuGQ9dvfoKBAWc6zX6zFGNaql+K+wpaM
 OoLL04vVN2dYF0YTP8GOui1v0MMtIdRx/mXibQ=
X-Received: by 2002:a05:6820:2081:b0:65d:aa2:2e30 with SMTP id
 006d021491bc7-662f20b33f9mr3099887eaf.28.1769616678972; 
 Wed, 28 Jan 2026 08:11:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f9a19cb4sm1578917eaf.9.2026.01.28.08.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 08:11:18 -0800 (PST)
Date: Wed, 28 Jan 2026 10:11:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: "Padhi, Beleswar" <b-padhi@ti.com>, sean.anderson@seco.com,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 james.hilliard1@gmail.com, anshuld@ti.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, bb@ti.com,
 praneeth@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4] tools: fit_image: Fallback to 8-byte alignment for
 flat_dt images
Message-ID: <20260128161115.GL3416603@bill-the-cat>
References: <20260128141834.2322865-1-b-padhi@ti.com>
 <71adda09-1f3b-48f7-aaed-845e6a30b6ca@mailbox.org>
 <139a01e9-c395-47f0-a09d-1c591c178bf9@ti.com>
 <3be6cbf5-9a54-424a-9a8e-f43867cb5a3a@mailbox.org>
 <20260128155028.GK3416603@bill-the-cat>
 <43843495-aca4-4556-a1c1-bdfb22a06b92@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vcvxVLtHJJAVEJSf"
Content-Disposition: inline
In-Reply-To: <43843495-aca4-4556-a1c1-bdfb22a06b92@mailbox.org>
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


--vcvxVLtHJJAVEJSf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 05:02:06PM +0100, Marek Vasut wrote:
> On 1/28/26 4:50 PM, Tom Rini wrote:
> > On Wed, Jan 28, 2026 at 04:42:47PM +0100, Marek Vasut wrote:
> > > On 1/28/26 4:26 PM, Padhi, Beleswar wrote:
> > > >=20
> > > > On 1/28/2026 8:26 PM, Marek Vasut wrote:
> > > > > On 1/28/26 3:18 PM, Beleswar Padhi wrote:
> > > > > > From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > >=20
> > > > > Please drop this , it isnt needed.
> > > > >=20
> > > > > > When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees=
 are
> > > > > > packed inside the multidtb.fit FIT image. While the individual =
DTBs
> > > > > > and the FIT image start address are 8-byte aligned, the DTBs em=
bedded
> > > > > > within the FIT image are not guaranteed to maintain 8-byte alig=
nment.
> > > > > >=20
> > > > > > This misalignment causes -FDT_ERR_ALIGNMENT failure in
> > > > > > setup_multi_dtb_fit() when locating the next available DTB with=
in the
> > > > > > FIT blob and setting gd->fdt_blob, because of the recent libfdt
> > > > > > hardening since commit 0535e46d55d7 ("scripts/dtc: Update to up=
stream
> > > > > > version v1.7.2-35-g52f07dcca47c")
> > > > > >=20
> > > > > > To fix this, check the image type when extracting
> > > > >=20
> > > > > "extracting" ? This code changes mkimage, so not "extracting" but
> > > > > "packing" (into fitImage), right ?
> > > >=20
> > > >=20
> > > > Well the function name is fit_extract_data(). It is documented as
> > > > extracting
> > > > all the data properties of a node to the end of the fit. So just ke=
eping
> > > > the
> > > > same terminology. Its obviously not in the same context as extracti=
ng data
> > > > out of a FIT image to consume information...
> > >=20
> > > ... check the image type when moving image data at the end of the tre=
e ...
> > > or something like that ?
> > >=20
> > > > > > FIT image data and
> > > > > > set the alignment size to 8 bytes (if not already) only for fla=
t_dt
> > > > > > images. This ensures correct alignment for device tree blobs as=
 per the
> > > > > > DT spec, while also allowing different alignment sizes for othe=
r image
> > > > > > types within the FIT.
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > > diff --git a/tools/fit_image.c b/tools/fit_image.c
> > > > > > index e865f65a400..f842c845771 100644
> > > > > > --- a/tools/fit_image.c
> > > > > > +++ b/tools/fit_image.c
> > > > > > @@ -682,9 +682,17 @@ static int fit_extract_data(struct
> > > > > > image_tool_params *params, const char *fname)
> > > > > >  =A0=A0=A0=A0=A0 for (node =3D fdt_first_subnode(fdt, images);
> > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 node >=3D 0;
> > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 node =3D fdt_next_subnode(fdt, =
node)) {
> > > > > > -=A0=A0=A0=A0=A0=A0=A0 const char *data;
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 const char *data, *type;
> > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 int len;
> > > > > >  =A0 +=A0=A0=A0=A0=A0=A0=A0 /* Fallback to 8-byte alignment for=
 DTBs if unaligned */
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 type =3D fdt_getprop(fdt, node, FIT_TYPE=
_PROP, &len);
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (type &&
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 len =3D=3D sizeof("flat_dt")=
 &&
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !memcmp(type, "flat_dt", len=
) &&
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 align_size & 0x7)
> > > > >=20
> > > > > What will be the resulting alignment if align_size =3D 0x1f ? 8 r=
ight
> > > > > ? I think it should be 0x20 .
> > > >=20
> > > >=20
> > > > I thought we agreed on resetting align_size to 8 if its not already=
 aligned
> > > > (regardless if < or > 8) in v3 version of this patch[0]. Do we real=
ly
> > > > have to
> > > > align the align_size var itself? It seems like a overkill to me...
> > > Maybe simply call round_up(8) on the align_size , to align to the next
> > > 8-byte aligned offset , but somewhat respect user wishes ?
> > >=20
> > > But looking at this code one more time , look at the calloc() in this
> > > function, I think you might also have to allocate a bit more memory to
> > > really hold all the newly aligned DTs, right ?
> > >=20
> > > Also, don't you need to align the buf_ptr as well ? Consider a scenar=
io
> > > where the fitImage contains two images, one ends at 4-byte aligned ad=
dress,
> > > followed by a DT. The users passes -B 4 to mkimage, and I think buf_p=
tr
> > > would then be 4-byte aligned, so will the DT, no ?
> >=20
> > I'm confused. Where did we go from "default should be 8 not 4, for
> > device trees" to "take what the user passed, make sure is 8b aligned" ?
> > If the user tells us to do something, we should do it, and they can
> > suffer the potential consequences. If the user doesn't tell us to do
> > something, we should pick a reasonable default.
> You can remove the "the user passes -B 4" part from my example, keep the
> rest, the DT will likely end up 4-byte aligned, no ?

And 4-byte aligned is not a reasonable default.

--=20
Tom

--vcvxVLtHJJAVEJSf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXo1FQAKCRAr4qD1Cr/k
CkOOAP9+s8B4W25hNAt1/DlS1OMtL1FE42zIHOq6TaEHFyXeWQD7BaGjAtZe3hMg
OROcc0eWmi21wk7KcUYTXoGjWVhkLg8=
=7v4y
-----END PGP SIGNATURE-----

--vcvxVLtHJJAVEJSf--
