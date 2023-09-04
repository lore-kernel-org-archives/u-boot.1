Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E6EC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ACD486611;
	Mon,  4 Sep 2023 16:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eh2Duk41";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B8B8679F; Mon,  4 Sep 2023 16:41:00 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D03B6846D2
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58fb73e26a6so14761767b3.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693838456; x=1694443256; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a3Lydtk5EC0r81V2NV5DTZql6w8//VTH1/GTd4MvHj0=;
 b=eh2Duk41J+5VOLErHA1nVS397M7k7RPpXXG3gEv40xmarCqRbG6WQbQOkktb39Txpu
 Z/CsQGl8f+JTzfWs58VVMDgaIeQpLMTk9bwqkq+JvGqIaz8l549VFgQmIfepOrRKpD3p
 EQmEjEGyX1xuWb8/3lwxV6azC7z7rn9Z9jAd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838456; x=1694443256;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3Lydtk5EC0r81V2NV5DTZql6w8//VTH1/GTd4MvHj0=;
 b=WvcrItCuKJ3MTCzaUu+ShK9EsBT1tK8JGwBHkNjhmC8BrXtdbzvJwnp1ppQONbopGl
 jnUDOegUTul4ccUKeDpdd/5FeCxJX9mSjj/Rp7KS0lDkI/FX7MuNSbKjjIxSWxYHRQi/
 qJKgoE/7aoDzjRYfveO5IouY9PCKUj55Hr1aYJc8Yhv+yzhZBEFkyzxDtXLyvKyIHds7
 mlCJsyMJRdXi83XcW9wekwZnYxURHwg9BJ1E3w2SK51rmtKqrivZqkb0kev/pf88J3JM
 JPSE9EVFsENmlmaPNsfjntng+km9x2UrEqZNOicWpF19Q/P+A/oF3jWk8SeFeM8kETIe
 UYJQ==
X-Gm-Message-State: AOJu0Yxm79L8D6peAoFQ9D1AZdJSsAD3Mce4zE+qsMe2/6k9XdOgF4yy
 JpTYQXssDAzKXI+frhUIF8hSiA==
X-Google-Smtp-Source: AGHT+IF4CdIVw6wmMbquD3fVwqe4z8wf8h1KaVyS01VTZYOBKSLVz5eVlmvXzwvFd6Btrznc/x4UXA==
X-Received: by 2002:a25:938f:0:b0:d77:fcdb:842f with SMTP id
 a15-20020a25938f000000b00d77fcdb842fmr9814994ybm.60.1693838456289; 
 Mon, 04 Sep 2023 07:40:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-977e-7fa5-b64a-ed15.res6.spectrum.com.
 [2603:6081:7b00:6400:977e:7fa5:b64a:ed15])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a253212000000b00d74c43dad49sm2335475yby.48.2023.09.04.07.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:40:55 -0700 (PDT)
Date: Mon, 4 Sep 2023 10:40:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Updates for RPi for 2023.10:
Message-ID: <20230904144054.GB3101304@bill-the-cat>
References: <CALeDE9MLAxKXRZethKcxBKjocRmaFq2dNw0e-5TjHfSiPvryXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BrlIRVEyIPkB80Vd"
Content-Disposition: inline
In-Reply-To: <CALeDE9MLAxKXRZethKcxBKjocRmaFq2dNw0e-5TjHfSiPvryXA@mail.gmail.com>
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


--BrlIRVEyIPkB80Vd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 01:10:09PM +0100, Peter Robinson wrote:

> The following changes since commit 8999257f219d1e371c2fd66f255b8782897944=
d9:
>=20
>   Merge tag 'doc-2023-10-rc4-2' of
> https://source.denx.de/u-boot/custodians/u-boot-efi (2023-09-02
> 09:08:54 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/ tags/rpi-2=
023.10
>=20
> for you to fetch changes up to fc2af2d978b525e188b15d909e321caf9445bdb0:
>=20
>   arm: rpi: Switch to a text environment (2023-09-03 23:33:04 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--BrlIRVEyIPkB80Vd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT17HYACgkQFHw5/5Y0
tyw+wAwAqfbMbYaMqYJ4asue4OrTu+pkBKcqA1FSyoJubkFtz6vy4pRAECyMXEgB
Chsz9kaA6BRddbM0lPtfT3WliwaxFyossMv/hGQwwVimOKZA54umkL71ainGjy9J
it2THQs2ZMJ1RW9i5+ZbwfuCZRASupMA13zc7IPquRrW0ruTQ8HMU3UO9epjtxse
KJ+cQsJHPzUDCCA9IvY06OYFlcWEV2kq+xrjiHI+fqO/5OYGDe9RVypyj5NnsO9T
OCOxssuav4gIL13L1PtPzBF9j8gUkFFGH6k3aLUwK8Asb81X86o1rtCR7T9S38Bk
wPWzOeocHcb4MdaBO4ScAfEryPB4ofZZ9OV0tY0ahSJCRGv56XRkYOPTIGPPx7EA
bygOEiefAbfT281EEuTbH31rzDcDLOx4hyQ/kBpqK9GeqNT6rgqQUmCXt85+GscS
XLTP/I/fVQMoyo22k7SQ+z+wz08ycV+DBka2ITuLo6Dsi0F6rHLbhnBVdF1oDRHP
CrkBEcoU
=tK4R
-----END PGP SIGNATURE-----

--BrlIRVEyIPkB80Vd--
