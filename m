Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327ABD3C549
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 04:40:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E0B489215;
	Fri, 18 Oct 2024 06:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TZEJ0nfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55B4389215; Fri, 18 Oct 2024 06:40:54 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7DE8891A4
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 06:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4606347c791so13727391cf.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 21:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729226450; x=1729831250; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1Trf73c1113QZYiaGbyoPYgCsOqQGscEz7iFaIE1Mxk=;
 b=TZEJ0nfDQeOd0uEVVnv4KaSdHghDRH7nDqh4qFig8MiUERoB/ENW46YnfCYitRqVM1
 swdlTF1Q3pk1sldRdmlaaNh+tSpPAgnP5RQL2p8W1uJNKMeKctPoN/esgYuscFllsq9S
 3+ETdoSItExFoUoVGGCYRio95gNuyXnRnUkiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729226450; x=1729831250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Trf73c1113QZYiaGbyoPYgCsOqQGscEz7iFaIE1Mxk=;
 b=vxhkwC6tFcYSISrxkcjWUlaY94vbF8hRGVynI5Fo6etuzy+hlZBjhgPsZLwdSSjWUG
 2RcLCd8thAnjTf8DZGm/1SEmBl+j7rzR0Nv1dwm+K7ZD6MXeGF6F9RCo//vC8C0d7vjL
 C7GC6rmGr/x+CU0qJhaVNnXGaJFNZnd0FXuCQ4azUnd9fdGpKunhKAb+wwdaOhqatsjO
 cJiFu5KkdETlj0C2iCxZNw4GkCaJT+S/N4ukYuhK2axt7uHKBDGWEwdHvi2p6gDmaFwC
 rWvy81FJLZGS/Ey1xhYfJsrSRtI2XxvVt0xYZjl1Z6Z/pXZeH5S5swovv2HmlR4eLHFy
 xuBA==
X-Gm-Message-State: AOJu0YyVCXOONUntXwDdCMJY3zMQJVts8Jv9gcESuQWpxcs3MmeoWPUC
 fvFtJbGV+8joklLnKr0NnkentkTmX0QDYKG4I97fjqMWBiJPErqBaOL4iX2o956KxWCv4ebkUTb
 HXTY=
X-Google-Smtp-Source: AGHT+IHHWyj+xkrNVf1SNvLcM6Bg+sq1B0TGOQv5TCLPalUcLAuphfHMuDZRTLWOzI2U30oVKOQYVA==
X-Received: by 2002:a05:622a:60a:b0:458:217d:be48 with SMTP id
 d75a77b69052e-460aed41f73mr17707771cf.14.1729226450540; 
 Thu, 17 Oct 2024 21:40:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460ae96d7e9sm3605021cf.33.2024.10.17.21.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 21:40:49 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:40:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20241018044046.GW4959@bill-the-cat>
References: <CAFLszTiu=mRQLfG35HMYd004Res6-SNFVBU8qosZjzFY8q9AsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l8E7pKIvD7doPppY"
Content-Disposition: inline
In-Reply-To: <CAFLszTiu=mRQLfG35HMYd004Res6-SNFVBU8qosZjzFY8q9AsA@mail.gmail.com>
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


--l8E7pKIvD7doPppY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 05:23:40PM -0600, Simon Glass wrote:

> Hi Tom,
>=20
> I have kept back some of the coreboot patches until the docker change
> is applied. It needs a newer version of coreboot.
>=20
> - Simon
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/22775
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D69&view=
=3Dresults
>=20
> The following changes since commit 8efc954fc77eaa734b9fe0cba4b33b75b6e8db=
b8:
>=20
>   Makefile: Drop SPL_FIT_SOURCE support (2024-10-17 08:36:10 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-17oct24
>=20
> for you to fetch changes up to d9cfa1e3a3d6977feb8265703a6612f1477e9508:
>=20
>   x86: cpu: Add missing header inclusion (2024-10-17 14:36:23 -0600)
>=20
> ----------------------------------------------------------------
> A few new x86 commands and minor improvements
> expo improvements
> binman support for signing FIT images

Please re-send with the patch I just objected to (and anything else that
now needs to come out) dropped, thanks.

--=20
Tom

--l8E7pKIvD7doPppY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcR5s4ACgkQFHw5/5Y0
tyzq7gv/Tm1ZBrMjNX6CYnb0oBNlUBtr0GKm8VW1X39boTvmxJVWhZRJPO5q5Nll
eszbR4j3Y+HOnr9Lol/SjnikvWxueTbsSZSSzl2qYCO80YMA52gJW3vkMr+EGiJq
Hz2KfmbIpbwXYlujIJdcOsL8GwUTnzAcu81Q47YwSI1Zh0Hbbaqr2gn4LUC93hHK
ZderxhO2YdzmsX1bkqY6OkOQeL9eBI7gmWWYzqCdM80dOXbtwzvBKwxnn6x2/KNr
saUX8y/DEupr4G9xbbDUWPjg/sLXokxTTynj2H+S8RJjV9P3Y7NK6EOuv40CEnr6
jbZAwbjG/tLG53XNCzty5wsMtHRsLxCEBZemV1JwwA/elvjRli9awAXS2/hrpiKM
E7wTDXpQG0OZzyiZdbimwFsSxQF4vxQ+d7UEu1RiEE28thpOkJNqGOWHApfXPNYB
w3gkkzdxZYKCG+Tu6IdbSzrLxuDo7gVr991SBRu14/vZJvwI8ZNMDoPA8EBGM378
aZv0uqK5
=yqLJ
-----END PGP SIGNATURE-----

--l8E7pKIvD7doPppY--
