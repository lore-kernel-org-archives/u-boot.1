Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57533C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C353B87156;
	Tue, 21 Nov 2023 20:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e3nxcePO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35708758C; Tue, 21 Nov 2023 20:37:24 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D499986BFA
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 20:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-677fb277b7cso21010766d6.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700595441; x=1701200241; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FpeNsIhByEo7ae3seqMmznlo9HsRBXsaBiHza4mhrps=;
 b=e3nxcePOoPCFD0EMPzCdfjUxqk21EgP++9QuhzLmUP4qjCCeaGRjnC/c35i/8zydmD
 Oc5evS9wB9DUJsQKJzRtLcf3CABepM4k0J7wULBqvzC8GL33ULWYFwKpJ/QX+jlDj4q9
 QLCBWhIxp21BIQa5EM2IVtV+6N4k9pVwcnKD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700595441; x=1701200241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpeNsIhByEo7ae3seqMmznlo9HsRBXsaBiHza4mhrps=;
 b=b7mwAsjsHrgXgx0TCGi5FIG5u5i3r+JaZAfvBjZvQtmzDhRkGxlEBH/jUhj1nzjG9u
 U5gIh7XORqd9fNiehY+GC2xEIPeYLGRr83Z08jEa6STOnmUCKQfqbw1nGcx8OdFLJgnf
 0o4iTulwt3In0pyQcYdF/kLBaWTyPkj80bbgJR5PFy+SV7exw5lTRzvHvQBsWScBx4fx
 7DiQzPKufQw45G67qyT4m65kzbA0RshGNCE16bbQpUxrhHDPIucRhMTEM4nOyVFGGf6X
 BfFnJ14Nz+P9V64LMTwO9jW91UlvKBkCitduDrPevx+r+UMKFun5IU6b/E/44PNbGzWv
 onVw==
X-Gm-Message-State: AOJu0YwRgSBBkT+aUTqJBK4iqbunVEO7ZTHPNBZGqElrHyxO4Ikogrsl
 QpJ8VkVxTaaldpzc8MFeOIOXmrLL5Nxo1F9yjMloSA==
X-Google-Smtp-Source: AGHT+IEh6EDP9OV6ukiNqw1volnDGUtT9Rzxhl9DxXrk6P4Q3tMNdSee680Fd7xZaoZI4hgt6L20xQ==
X-Received: by 2002:a0c:9a8a:0:b0:677:f54d:b176 with SMTP id
 y10-20020a0c9a8a000000b00677f54db176mr20281qvd.61.1700595441678; 
 Tue, 21 Nov 2023 11:37:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a05621412d000b0065afcf19e23sm4149757qvv.62.2023.11.21.11.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 11:37:21 -0800 (PST)
Date: Tue, 21 Nov 2023 14:37:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Vagrant Cascadian <vagrant@debian.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: Licensing discrepancies or ambiguities
Message-ID: <20231121193719.GH2513409@bill-the-cat>
References: <8734wyudku.fsf@contorta>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dFemN873h+cBLGm9"
Content-Disposition: inline
In-Reply-To: <8734wyudku.fsf@contorta>
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


--dFemN873h+cBLGm9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:10:57AM -0800, Vagrant Cascadian wrote:

> I've been reviewing the copyright and license information for Das U-Boot
> in preparation for uploading to Debian, and found a few surprises.
>=20
>  tools/libfdt/fdt_rw.c: /* SPDX-License-Identifier: GPL-2.0+ BSD-2-Clause=
 */

This comes from the kernel and has been clarified there:
// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)

> I *think* according to the SPDX spec this needs an OR or an AND. I also
> see no copyright declaration, although maybe there is a standard
> interpretation for this.
>=20
> Similar issue with (though thankfully they include copyright
> declarations):
>=20
>  include/bloblist.h:/* SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause */
>  common/bloblist.c:// SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause

Simon?

>  doc/README.ubispl:# SPDX-License-Identifier: GPL 2.0+ BSD-3-Clause

Should be an OR as well, yes, but it's also out of date and we could
just delete if a problem.

> This one has a non-existent license:
>=20
>   test/lib/strlcat.c: // SPDX-License-Identifier: GPL-2.1+
>=20
> No such license exists, though thankfully it references the exact file
> in the original glibc sources it came from, which is listed as
> LGPL-2.1+.

Since you did the research would you mind sending the patch? Thanks.

--=20
Tom

--dFemN873h+cBLGm9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVdBu8ACgkQFHw5/5Y0
tywlUAwApUoYgxBJPm2nguEBs7Ics2zL5laidZMMG+cr2j0x2SCUklMbWRdzw6sx
ZAYrIwMHmU6jyflUi/ZsVGop306iRd+2jmXrMTvTjtC7poCkeIWF9rxVgIzGQGr3
87bhgN9L6Ape9mMGWaHO0HJjOHWqwafHlXA3iCBUwnlhhreS1RVGBYA7VwR6cKUy
fqTihLhigRrLkgdrLW3Uu1FlDgYwuyBcQG3GpvGGlG5qDqR0SIVntFenH/wNO1mA
+jS/lDdGT69gvFbeeRVGRDpYIfr3XvDY549bgxpwxjSQeF5cDV/5KKW6J+6PKll0
t68+JadALqGJLlnh8iqrRK3/ONMoJ9Mhe7gDa/elsPFxVVLZNtbRdSlD3v7omtIA
Rty26wigTVTJATXaMTCQixea4vVpmdodcRrKRGfqIlneCTx8K+cvsisyJ9x/baAx
SIhMCcAv84YrZ1tk4xDAHRPRxIVA+Vo+8D0trsGaukH+E6WRYD2eKm8sRmod3mnK
WDQ/gLkm
=E6WY
-----END PGP SIGNATURE-----

--dFemN873h+cBLGm9--
