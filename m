Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01334C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 22:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 426B781F7E;
	Wed,  9 Apr 2025 00:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Eox+Rrbr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFCF08267E; Wed,  9 Apr 2025 00:13:31 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EFF08003E
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 00:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-603f54a6c8aso3090189eaf.0
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 15:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744150408; x=1744755208; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=clImj2IspIyf1PU3CtNlY40AjEWxqAtPdDu+F0i3U6w=;
 b=Eox+Rrbrjmm+SJnAyJVB5mEXUaiBHmUgep/qg9ZC36Z5yuv3cMzQLVy/k6p8DjPYbY
 SmhaXzbDuH8VWFnidG+w+AawnQ6Aabzl/P60d4VSnzpAAFbMjb0cw0rxMsRE8vywG4xL
 gTHu4tqIwWCcCD+zJyH4PtU+fdEVGUEct1IRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744150408; x=1744755208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clImj2IspIyf1PU3CtNlY40AjEWxqAtPdDu+F0i3U6w=;
 b=LJuSPcDs1T0WlEoIbHm+WdErZTBZHtAGddh0YoVyI48UcSDLZtsqxPv+K2tlymXQCg
 hxxzBW4QdaDtoKcLxngEAg9mix4aVn8te5Aq9rhiDLUCXd78nRf0upMIuCPcs1jqi2ex
 KYPAeVPqIy15zWEXAt0HlZjfJo/G5eTYLAEXdJMk5WXDDM9lDNAJuE6P6vgT1J+GiwQs
 cPGTgy9GF40q75NkqRUwaiffKYvnUWtDpEOE1Paff2b9s625MRVL0MqdUkNHLuVIjhCF
 TACA1NxM4MjzalrmsqzHlukdnxvVpA/e43IJ88UBb5kqRrojxAw/JeXlEQVMcrsYyopm
 eCnQ==
X-Gm-Message-State: AOJu0Yyege96ZaP2kRLQUYnDaN21s9gGmazDgSD7FV0DgcWd6cwbxc33
 Gs8RCB6nBZ6NrulvE0LmExecUVmFFXTf1O1XVaQsvfVEmnXXtb/00Ocou0zWcFI=
X-Gm-Gg: ASbGnctgW9sd4xptNf8LB5rjWkbO7RTer4vDhnDj9I4mz4zamZN0g/9ZLzjHvuWZ7/t
 ZGNHOOZHcv6reHt9kfgnxklCFSBZ+aqaPOhYBjniOePQzHt7YKqYdDT86a7luo5YdQaCcuxEvvZ
 nEfeMI/jS+s7bbxeOfSufilh16L+hsiMeGwRSsmeTUj5XaWdatHCAs6l0iFlBqrv/CT93ZkrBrM
 VAzDAe+egTOHmD53BNdYvdwPeVZ9BDVJB4iPR9LW0wbadIHMWTf/gQvk4gINF4Kvn8GnlLoGnmt
 9kRtIg6JOQzPnTvG1qRXwylDFobLwNMhQYzowW1GJeK15Z+n2ZlFTZge11IiWLL8wfYlWpW6SQf
 k4Hat8Q==
X-Google-Smtp-Source: AGHT+IH0MlxwwftqLTl7XFcWnXz+k92a+cLe8IxzGFQyw2nLcHsd7CwREL4RIAzDFYhVVdYgoN9qUw==
X-Received: by 2002:a05:6820:507:b0:604:1:3736 with SMTP id
 006d021491bc7-6045cad95a5mr408065eaf.7.1744150407812; 
 Tue, 08 Apr 2025 15:13:27 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6044f4a61d1sm608285eaf.9.2025.04.08.15.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 15:13:27 -0700 (PDT)
Date: Tue, 8 Apr 2025 16:13:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 0/5] patman: Separate gitutil fully
Message-ID: <20250408221324.GA5495@bill-the-cat>
References: <20250407105151.689453-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m/JZwZRFrqpSvlbr"
Content-Disposition: inline
In-Reply-To: <20250407105151.689453-1-sjg@chromium.org>
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


--m/JZwZRFrqpSvlbr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 10:51:42PM +1200, Simon Glass wrote:

>=20
> The gitutil module uses Patman's settings module, which is not allowed
> as it is supposed to be a separate package. This series ties up this
> dependency.
>=20
> This series depends on these two patches being applied:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20250227192735.406389-1-=
sjg@chromium.org/
> https://patchwork.ozlabs.org/project/uboot/patch/20250328130225.2607974-1=
-sjg@chromium.org/
>=20
>=20
> Simon Glass (5):
>   patman: Untangle settings from gitutil
>   patman: Pass the alias dict into gitutil.build_email_list()
>   patman: Pass the alias dict into gitutil.email_patches()
>   patman: Pass aliases to Series.MakeCcFile()
>   patman: Update Series.ShowActions() to pass alias
>=20
>  tools/patman/control.py       | 11 ++++++++---
>  tools/patman/func_test.py     |  8 ++++----
>  tools/patman/series.py        | 32 ++++++++++++++++++++++----------
>  tools/u_boot_pylib/gitutil.py | 34 ++++++++++++++--------------------
>  4 files changed, 48 insertions(+), 37 deletions(-)

I just want to reiterate my question / request to host these outside of
the U-Boot sources themselves so they can be managed (both in the sense
of U-Boot as user and as maintainer of sources) following normal Python
best practices? I'd be fine even with something under
https://source.denx.de/u-boot/<something>/patman, etc.

--=20
Tom

--m/JZwZRFrqpSvlbr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf1n4EACgkQFHw5/5Y0
tyxGEAv9EJ0SP3HUXiQvPp1frL5D/pZ2Z2Jd827tvq8ewK+I07Wa8bPUgwANW+Sa
4ocYyk5J5NVbvUKfkzQenawGc9KRpZgY4jvraUXGRhebycLauxwsZrJSwh1tRETR
JkQt4hkSAY32r1voAQNbVa+A6Z+OmmDQCczR18zJ5WDfRDkwhAaGm8+MhOMmWQnR
N3/rM6/QQZHc89y8KPt4dQH/TpGwqwPsgbg0yzZLmj8q8iYdI+OJVzz6CEhKRK1b
LA9GRf9Vmfq832fRTs6jzh3EU7jch3dTWE+DrxPJtFp6WgMOnL6FBwpVzcjNkC2a
hB4YU9G0D8TT53CIoDJyyEDs5mqTLCMsTxBOpQ0+tJ3BDEflAivO9Zpcy8BGs5nX
4bNSMAOKITJbCyer6Qwc3yRuiFf5o7tJl3pKmlabuPTHhPfSPHl9JUOxdqaINwKa
nKbDhcRfjexHu83nUbRROyMrAnsCBelTlau2Vr4+pVAEUhEuKLsFFXwsRfCZ55Sf
pBvD4DRw
=spfJ
-----END PGP SIGNATURE-----

--m/JZwZRFrqpSvlbr--
