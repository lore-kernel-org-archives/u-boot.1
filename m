Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23165C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 20:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9473387B2B;
	Thu, 14 Dec 2023 21:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ccmgR5ak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CE087AEF; Thu, 14 Dec 2023 21:15:20 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17CF087B2B
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 21:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5e266e8d39eso29749097b3.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 12:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702584915; x=1703189715; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MoKxmCRm3Sr15GNm3SqsSkHNIJv8+ft/NupKZLa75p0=;
 b=ccmgR5akqQpCP8EQtUmsyj4HY806SBJUjBn2o1dlyFiUp5CyeMAkadbITGPDUcc4If
 L1p8YQMalsn1jT8tp63PhCK6LJB6shXzQohydB4xLNjYbXbqahJfMyiCI8FdhsSk+x+B
 UhpQ4uqgkxdIOEtyvRpF/GmALgfI+lvGM2tC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702584915; x=1703189715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MoKxmCRm3Sr15GNm3SqsSkHNIJv8+ft/NupKZLa75p0=;
 b=dKZZIIM92Z2EYTPp++vAwDIbnONK/piy6qhuB+nN962LkTPc6j02+2b7ASR8eBz+jG
 pM1VuFKl1aa6/aaHEzPmiZFbx+gQlIhIewsKYOv7c501nDyRCDtH2bPuuWGsQMVmQ5aG
 CIksSMvRAvbq+oqC0O+Xn2hsKx7Gn7Oz8sOZp30JPzlRKS50aVKPh+v2D0Dtr7/iLp3A
 B4LVs9msGWgAPdqA2n0GtVHwTE2xb3lZd/N3niDao/Sw+GSsEtYlDVX6IPVhUWHBaIOG
 n4tmpFjYt0Rghd6eNUaGyK1OSCFDxhmFOrzbqSvMil1XmAlexqTv6LtcD9n/ohnJ+plh
 pxNw==
X-Gm-Message-State: AOJu0YzHbMw+uMuSG7oL6bjaxIEQ7hUn8vhPVPAurkIdJ3+CPYDllE98
 kh65GxQpSPz4h+1HgOGS53dmSQ==
X-Google-Smtp-Source: AGHT+IGcgMU12rXcdUy6ujOp3LPFUj1y95FRucqW1kQ3okzU67pSdsYhNhir3rpier+Rb4hkWjOETA==
X-Received: by 2002:a0d:d304:0:b0:5d3:e2a2:8bcd with SMTP id
 v4-20020a0dd304000000b005d3e2a28bcdmr8406120ywd.5.1702584914768; 
 Thu, 14 Dec 2023 12:15:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 x145-20020a0dd597000000b005e2fb7fad5asm1369996ywd.78.2023.12.14.12.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 12:15:14 -0800 (PST)
Date: Thu, 14 Dec 2023 15:15:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: neil.armstrong@linaro.org, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
Message-ID: <20231214201511.GR2513409@bill-the-cat>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
 <20231214182328.GQ2513409@bill-the-cat>
 <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YKSR0UsW+3kxGDxP"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
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


--YKSR0UsW+3kxGDxP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 01:48:42PM -0600, Rob Herring wrote:
> On Thu, Dec 14, 2023 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Dec 14, 2023 at 03:53:11PM +0100, neil.armstrong@linaro.org wro=
te:
> > > Hi,
> > >
> > > On 14/12/2023 14:50, Sumit Garg wrote:
> > > > Prerquisite
> > >
> > > s/Prerquisite/Prerequisite/
> > >
> > > > -----------
> > > >
> > > > This patch series requires devicetree-rebasing git repo to be added=
 as a
> > > > subtree to the main U-boot repo via:
> > > >
> > > > $ git subtree add --prefix devicetree-rebasing \
> > > >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/dev=
icetree-rebasing.git \
> > > >        v6.6-dts --squash
> > >
> > > So I think the big question is: when should the subtree be updated ?
> > >
> > > Because as we discussed in the previous GH pull request, if a binding=
s changes
> > > was made in the upstream Linux DT, then the subtree update should wai=
t until
> > > the u-boot support is merged before updating. This could cause a lot =
of frustration.
> > >
> > > And this could cause a lot of regressions, even more if both Linux an=
d U-boot are
> > > not maintained by the same people.
> >
> > I think some of the important questions to ask are, how often / likely
> > are the breakages to occur? It seems like these days it's either:
> > - U-Boot had an early version of the binding and we already state we
> >   don't support backwards compatibility here. It should be on the
> >   maintainer to be proactive in this case.
> > - It's a "the DT was wrong about the hardware, sorry not sorry it's an
> >   incompatible DTS change now". This too is hopefully the kind of thing
> >   that at least board maintainers will be more actively aware of needing
> >   to deal with in U-Boot, if it's really a problem.
>=20
> A common issue in the kernel is with forward compatibility when
> platforms add new resources from a new provider. Then the kernel
> expects a driver for the provider and waits for the dependency. Of
> course, older kernels don't have that provider driver and so the
> dependency is never met. Not sure if u-boot will have similar issues?
> At least you should/could know if the provider driver exists or not.
> (The kernel doesn't because modules.)

I think we'll be fine, but time will tell. And perhaps the more frequent
re-syncing will make any sort of corner cases show up more quickly and
be something we can figure out how to resolve going forward really.

--=20
Tom

--YKSR0UsW+3kxGDxP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7YkwACgkQFHw5/5Y0
tywceAv/SdTLgyhe8sCnAnCxl5PsSBjY4d/MpKCVjWWcGAYWn3lbV3cRV6+DtTPS
8NFBXdQzZaj/Tt/9qa7nXYieBQMqzWWJ8oAB7SOknGTdvGyEpXjeE100wPpQ/pPA
Ch+llUH8Ol6kSuiDB+jUJ1htYCcTpE7+koaMaG3fN0SZE6xjBk1kUnlJg+mRc/fY
JJVzQzjK8n0NTAVVn3qLuAc+JCKG/dVIdzkol8LB/3sWQMXQe73ETVXR3+eTZAJO
uRtSuUG4Q0awMU0fLRdfi0YG0wkJ0g8M2JzD1GlGzI1OalSvVGbOf7qK6bkFgdwY
yh7VWOhHH9h+ON3uZVGNxEy1NPQ0Z0kYUiMaTI8mVd6rnH4NcPrWOeGW8R8guLGR
NaY3WgtziZmlODw4nTIBf9jVmDq/+HkvLVRoj3D5U/tAuJhcRc7Mfiq7LNGaVa2U
UG2UOtMuRFku6SFVfhC4APNTaPCv74+WJs1cInTLE3SXVcAVKh6HTvQeJFed2l2y
VDe8f97P
=4AWg
-----END PGP SIGNATURE-----

--YKSR0UsW+3kxGDxP--
