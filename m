Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E92C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 774B187B6C;
	Thu, 14 Dec 2023 19:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KRUpLc8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C416A87B78; Thu, 14 Dec 2023 19:23:34 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E5387B65
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e35e1dfb99so11137707b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702578211; x=1703183011; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B9LLmQt+8gdlmhrVj3fg4fNVC6Ym5XbNTTORsMHExC8=;
 b=KRUpLc8bJky4MuEDJVqUVBzHiN7HesvdDojgLNzA4W9cj/7RDdi3z/J10F+i2rAHd7
 26eRCZSWg3PAZAMDYT9o4QAz8TrgcCD/6HDZb9jPJI9LRPhZ6jilv8qjTaBnHnp7JzEd
 lTON+uInB06dbwZ8KG9rqjmPR8itjm+tIOVHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702578211; x=1703183011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9LLmQt+8gdlmhrVj3fg4fNVC6Ym5XbNTTORsMHExC8=;
 b=n2C+czbZVdosV1t1bVDFqO+xzgoItH1NI3UB5cPvxUpXl16BMUnOgUA4gM8gAc4UqX
 WJhrtzutj3vJPW7s/Gsqz8nuSU4mI10je0z+LKjDpi/9huuR4uqVbZm0nKYhbWllOTs3
 bOZT9/Bm0RhBJjYWBenw40wzHZjHH8V/VtnngotqgOwKRIIVe+igTrZurI1GC7T8qahC
 ZWBVdzTIa/MWXeHq3Yiy2ANoubRC7YMOZ/bpqcgfBkI/8s6seqXouAEJhCZJXiSaQ4uf
 LsRQVjc64D2O9FWv6rU8r7Vqw2le3yeqCi/lWYIbsXGeOSIti/fQ8cPxaondKPnNZdKY
 271A==
X-Gm-Message-State: AOJu0Yz4MVjnPD3myFXmbAKdtyF71BeJh+iybary9Xcl7/oaFAGdX28U
 yrxEbYC95JUmsbQR4mXejLCY6w==
X-Google-Smtp-Source: AGHT+IFyzhwqFmKuKmwoHC+GMYZpblJNMlCbacisO988azC+tYqFZCZKgrmPJsXWFpNIx2qIkSS4Bg==
X-Received: by 2002:a81:d541:0:b0:5cb:332e:ab68 with SMTP id
 l1-20020a81d541000000b005cb332eab68mr8456795ywj.5.1702578211299; 
 Thu, 14 Dec 2023 10:23:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 j83-20020a819256000000b005e41757c940sm165010ywg.57.2023.12.14.10.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:23:30 -0800 (PST)
Date: Thu, 14 Dec 2023 13:23:28 -0500
From: Tom Rini <trini@konsulko.com>
To: neil.armstrong@linaro.org
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 sjg@chromium.org, robh+dt@kernel.org,
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
Message-ID: <20231214182328.GQ2513409@bill-the-cat>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ypWK503ZnJrJ6kVr"
Content-Disposition: inline
In-Reply-To: <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
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


--ypWK503ZnJrJ6kVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 03:53:11PM +0100, neil.armstrong@linaro.org wrote:
> Hi,
>=20
> On 14/12/2023 14:50, Sumit Garg wrote:
> > Prerquisite
>=20
> s/Prerquisite/Prerequisite/
>=20
> > -----------
> >=20
> > This patch series requires devicetree-rebasing git repo to be added as a
> > subtree to the main U-boot repo via:
> >=20
> > $ git subtree add --prefix devicetree-rebasing \
> >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicet=
ree-rebasing.git \
> >        v6.6-dts --squash
>=20
> So I think the big question is: when should the subtree be updated ?
>=20
> Because as we discussed in the previous GH pull request, if a bindings ch=
anges
> was made in the upstream Linux DT, then the subtree update should wait un=
til
> the u-boot support is merged before updating. This could cause a lot of f=
rustration.
>=20
> And this could cause a lot of regressions, even more if both Linux and U-=
boot are
> not maintained by the same people.

I think some of the important questions to ask are, how often / likely
are the breakages to occur? It seems like these days it's either:
- U-Boot had an early version of the binding and we already state we
  don't support backwards compatibility here. It should be on the
  maintainer to be proactive in this case.
- It's a "the DT was wrong about the hardware, sorry not sorry it's an
  incompatible DTS change now". This too is hopefully the kind of thing
  that at least board maintainers will be more actively aware of needing
  to deal with in U-Boot, if it's really a problem.

So I would plan on grabbing only full kernel releases and in to -next as
soon as possible. Our cadences don't match up exactly, but I think do
fairly well enough.

--=20
Tom

--ypWK503ZnJrJ6kVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7SBoACgkQFHw5/5Y0
tyzBCQwAtdVhCLPvnQmd4EuYkf4A9cf6yDSKZVR+GsPrO6PmmPtyVZsE9w/X7GCj
2aXcM+VxdjNTI5kO26y7hmnYdaOMqvBjZ/rnZREdNq6CpI6XhMo+c9D64EH2kKmb
0Y4bcm+noTixfOVVLlnXc0CnDCW4GZ7VJ3Q9WloqppnMNOiTOXe8PenkRh6djCAs
CcnAlh01qkgakOH2IOvk6579oKTaNuWbazs3B4zB+UKEAs1gb+gfeScPcfXBJeIK
Ty0tRbJfBXMxCQSX9RJExk0wfAoAhLqc1FIKYfOSaNuoPPxW9z2aFN8OfmLQGSVm
IwONGUqMR1duK5wm1FXsNK5VNcL9YiAeHU3s9/uOYpyPDMPczVTBoj85DY+jeWQR
fb5yOExuN21BQMrTE+oA6uOOUT0eVWylUT2hw8X9BLo8kEnoM6vMkF5L4A3aMoQR
huQPM0SA4bKKNxZ3+9xzxpcxKWkI2/xTLS6isO6Zcyzm6wKw2oxfqjIZJIGyBc9X
RZor69hr
=pT1W
-----END PGP SIGNATURE-----

--ypWK503ZnJrJ6kVr--
