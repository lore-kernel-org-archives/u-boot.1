Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C56C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 16:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F30E882BA2;
	Thu, 17 Apr 2025 18:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ka70ABUM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FBCC82CBC; Thu, 17 Apr 2025 18:33:33 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D0C782B7C
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 18:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c7336ed99so301542a34.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744907610; x=1745512410; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SfkgD81KfmS/mkPWRY2XNr84qE2+hM7XAx2j7ARRbHQ=;
 b=ka70ABUMfus4PXMo+daj95Xj0m87kJl+ySYJPaDqkyTl6BniJ9JXDkhtPqDphw3fr/
 cLVjDRc3koToXab9GM2RbY1hIQ9Ezo1OKuypgFxrXpRhn1gaKR/m1DFFwlaHtgUV7r0I
 LRimomdALPOhERkwJYHxsNczUQYMVRKF8deYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744907610; x=1745512410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfkgD81KfmS/mkPWRY2XNr84qE2+hM7XAx2j7ARRbHQ=;
 b=VBgidt7sWO+StJaamrDCikXZo5Ycx3Khh3VjHcAXMyHuDLrz0ggAG1ANOPCGci4nIV
 F+LYKjAcUaaR1pAEn+Qximt2dGqybXk+v1ZrL4Gu2vJgPzTNvP3I0TSNtZ5/HwKKbfOi
 87cWcXhulMtUotA4n/VfhhBOKM0oFXibRBCwtl9ojVpP9UctWst4XG+3Xyp7wTYpDAsA
 r+/JC0oJOr70aG3JKTXk9PApyG6Fma6KuA13agV7BeoahwS3iHJr4oNXWjLPisldwUEJ
 PjfTXR05KkO80N77zyifGpm1ZjJWKPzDhPRtZ89ixv2bgCQK3qI5DWHnRKuhNVYR5kBp
 7KhA==
X-Gm-Message-State: AOJu0YzqOs37sNks0bjnuIxOtYkL7vhbfRBmL1SaddjGFclBWJpDk2tu
 3Ymo9xU/PHWXWAlDHXAUYoriSHdorh5Mv828zCv4VSIllLhYDWIFXaie23JBHFk=
X-Gm-Gg: ASbGncuJTUd/K3NwuYew0PhZVAVfeIpgFh8XVSy0r9IZ8LYPDQq+z9GLzIBGjP1ywmy
 LHeECz/VwMUrBypQiXmdlpO8CXJHQr1PaTx3kKKnlRb8arc8/XNgDdgZObLkmzawbxqJKwSC7p9
 LRKzA9Uoa6x218SZVVDQD3fsbfD6oTKr2tnUBkd3GTjOw+CoM3+WyfMEUWtTzYNI5o+OaPzjuhf
 zpcOHmS0AV6M38WuHmivrGhzPM1wKTZYb1gsRxF96SPYz197nYIbhHA1vAh4hKZeKsn8GFeFJq7
 lWGIzDqn0hN3kIrX5YgjYlPpTC42++9hdXns5kW6J7vovehwbGy/ywzjPsdH3zLUpVcL+J3qXSy
 dwg==
X-Google-Smtp-Source: AGHT+IEC49ikSbbX5jpuHgpxFZSS0ayio5a9u8h3rvjClWZaVIiN3pWAbKtBxYeJxnjJgAzFgcf5Ow==
X-Received: by 2002:a05:6808:309e:b0:3fa:4320:1a4b with SMTP id
 5614622812f47-400b021983bmr4570265b6e.26.1744907609631; 
 Thu, 17 Apr 2025 09:33:29 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff5ee28dsm21382eaf.16.2025.04.17.09.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 09:33:28 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:33:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Karen Sandler <karen@sfconservancy.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH] bloblist: Drop BSD license
Message-ID: <20250417163326.GZ5495@bill-the-cat>
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAFLszTj_JvCRNQw716CGD=i+eJm1YMb=WjOqpF0VFFiac3GmCg@mail.gmail.com>
 <20250417160423.GX5495@bill-the-cat>
 <CAFLszTgWUNP6L6ZML639wz76CuuBoPDt447vjfz8MRZyLE5gFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z4p7JuCAeJUiKKT1"
Content-Disposition: inline
In-Reply-To: <CAFLszTgWUNP6L6ZML639wz76CuuBoPDt447vjfz8MRZyLE5gFw@mail.gmail.com>
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


--z4p7JuCAeJUiKKT1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 10:26:53AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 17 Apr 2025 at 10:04, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Apr 17, 2025 at 09:58:42AM -0600, Simon Glass wrote:
> > > On Wed, 1 Jan 2025 at 12:58, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Linaro has decided to write their own version of bloblist from scra=
tch,
> > > > so there is no point in having a non-GPL license on this file. Chan=
ge
> > > > it, to better fit with the U-Boot project.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/=
+/22215
> > > >
> > > > ---
> > > >
> > > >  common/bloblist.c  | 2 +-
> > > >  include/bloblist.h | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > Applied to sjg/master, thanks!
> > >
> > > (Tom, this one seemed to get dropped but I'm not sure why)
> >
> > Because AFAICT you legally cannot unilaterally change the license as
> > others have changed the code.
>=20
> OK, let's put this on the list of things to discuss.

Sure. And I know I'm behind on getting process going with Conservancy
but Karen can you or someone else please be on the call next Tuesday
(22nd, same time/dial in as before)? For background
https://lore.kernel.org/u-boot/20250101195817.995321-1-sjg@chromium.org/
is hopefully enough but I'm sure Simon and myself would be happy to
point at any other links that might help. Thanks!

--=20
Tom

--z4p7JuCAeJUiKKT1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBLUsACgkQFHw5/5Y0
tyzh+QwAtQY7DYwfiBGZposdjt17S3Luv35nQoGPI8nIRV+CTFVQn7vT+HJeERQR
a3Cn0y7/XlUTca78rwSYCimZJ1+1nlg/eUNFPSiYqAaxHrkit+kbCGsuNcR+1X1e
A9nlYiNLcU1gRihPWuOmE7km3QufbSE0yfKJw9WPUcvEHamMhtyjAeYcspYMaFAV
8lPq+ipBC+aRcdqKc91KdARYQcLyM1V7sCFZT6cLcvPtp5MPoxOAWgSEpdNQiwf7
1doQyRsDJYQd0N8gMQFKp771hKIrSnmWvF1EQpemdSYcfsBt/A6UX90XNNXp/g9D
Tvv6YoesPott2pmSDPrm8X2z9VsR5h08lRlbae33H5smWcW9HvYESg1k85sJ2Ip8
BVoKfD+Zd83jdjCF4QbaCD28JAqo8JJUdtKnnyO5LcYXxWosf4t/DGr/CQpmqLVX
YklUnzbdjJhV1mBODOesgaWc7RIH1UlrCVH5q8PUDKLttLdimbW9GSdD3IudPp2L
r+bdbyS6
=ShnJ
-----END PGP SIGNATURE-----

--z4p7JuCAeJUiKKT1--
