Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71067CEBF61
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 13:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B11083A8F;
	Mon, 17 Nov 2025 14:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mHNqcKKB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42DA683AEF; Mon, 17 Nov 2025 14:30:22 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE29839A1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 14:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-45076d89e56so1983280b6e.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 05:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763386219; x=1763991019; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cF3xBKCnMzgeUbNPIC43kuRXGi32EFVnaARq3flYvGo=;
 b=mHNqcKKBtdN0V02CgAfNXytUztOtOoDsAL+Jcn7MHK3ttZyeb/xdw9B0cwiOee/3Xa
 0KrvHT6cY1z6bM9nJFw9mDXpt6/0pmrh/vCURnEy5Okk1RkOQu6hghgNsBMpZ0x2jFRI
 mdlSTH6Z7Vs/LH9u9VhgyeLKgk7vfi+3EM6SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763386219; x=1763991019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cF3xBKCnMzgeUbNPIC43kuRXGi32EFVnaARq3flYvGo=;
 b=QPU8lUuCiY+hO3a1Nk6nY7FhfZGkGBRaAiKPFl2xEmswvbXdmURzDPABcwdozYyCLH
 L3/o+8cziAJDCl9XusipWU5kkU3s/HiLTeuyzfmYexdd3LfYm1o5KPjxR8YBDYFOjVcN
 FyZc6OMXoic2XSwEL+GVE8mM6+B2cb9lIHKoZYaendqazuW3Daurl1CeKZ7Ko1UQ6GQV
 sdPuftqsQX2mAecgGmr9RNijxzkjPZU5WE9sMG96ZP8PLWA1VQRxZBIXc/6eH4iGR1OI
 7dZzpoqXezRW/b2uAffcPmH1rnXw3G0n74Whncp9swiOIdSE9ITwhVz82ZCGLKkhLQB9
 ENhw==
X-Gm-Message-State: AOJu0Yy1DjYbi2x0j87wzEKIeUgJsMohUNINLa9WFm+DPnc1orpJcQdU
 L4EiASR6AEYDSqOVA6ZRydPLjbISyDGduFGInEaGQ/a8sMcW4/TlAEf9Uz1YrmFWF1zaB2k+V14
 7q2pNc/Tmjw==
X-Gm-Gg: ASbGncu6MNbbv0yMYCS+RqkJfPD1l1cReWbYCl0AWDb/l7+7mi+rEgTXhxYHE3ZClUU
 +mKF+23buqzB1BMevK+K4HmtyrZgQza7LL+4zRryBGHHpp8woiIKlh4pEItsA4aKgh9yeJ/Wd/Y
 0ouMzh/jVm/0EoSEhdjL3KwGuKtkEVywLdkABmll4I3SJZ3T+7dDOTmfme+0pL9Zr/UhqFCcsMP
 AaDz+ehVce+0HijSYl7hGY+QoG9lG76M5WXucYoubqRZNnInZbBHUbu99w27SVlEyKeh7baUaLr
 us772NKtiVdy0nbedjf9x8qOUoyZBygHMsX8LpZHqlIsWZwtMYComAqY5sMRqIsU807OvTlVM1E
 2cB22r9AmMU/cwbdCQAs3spFWxrj8IupasO7SqC7V1EBr7nqLm0clDBew4H1u6oaNJD8OJjddPY
 PYj9BeWh2CBQbj9Y9uIsKXV2kIGiUCYEJyBIsVHqrbOaBn2ozaxg==
X-Google-Smtp-Source: AGHT+IGKDAENpHjEKHyNJTMG8bShe75VFhvzQZZZtGRiQ0UlaP6lyr48+W5agqly4M+Ny40QR5gNCw==
X-Received: by 2002:a05:6808:1901:b0:44f:feb2:462 with SMTP id
 5614622812f47-450975b1457mr4885319b6e.37.1763386218787; 
 Mon, 17 Nov 2025 05:30:18 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-657604518a3sm160113eaf.1.2025.11.17.05.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 05:30:17 -0800 (PST)
Date: Mon, 17 Nov 2025 07:30:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Walle <mwalle@kernel.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] drivers: rtc: add PCF85063 support
Message-ID: <20251117133015.GE2125796@bill-the-cat>
References: <20251114151255.2008694-1-mwalle@kernel.org>
 <20251114151255.2008694-2-mwalle@kernel.org>
 <20251114152236.GB6688@bill-the-cat>
 <DEATIC39P9JQ.24GJE4VJJVRSB@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CWgcfqNph4SHdKPp"
Content-Disposition: inline
In-Reply-To: <DEATIC39P9JQ.24GJE4VJJVRSB@kernel.org>
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


--CWgcfqNph4SHdKPp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 09:13:36AM +0100, Michael Walle wrote:
> >> +config RTC_PCF85063
> >> +	tristate "Enable PCF85063 driver"
> >
> > tristate is wrong for U-Boot, only bool is meaningful (and I need to go
> > update checkpatch.pl to complain about this).
>=20
> Yeah, sorry, This was a copy and paste error from the very next
> config entry. I'll fix it in v2 and add a patch to convert the
> existing tristate to bool.
>=20
> > This is I assume otherwise
> > checkpatch warning free and compiles on sandbox?
>=20
> Yeah, except for the missing maintainers entry.

OK, thanks!

--=20
Tom

--CWgcfqNph4SHdKPp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRsjZAAKCRAr4qD1Cr/k
CpYuAP9Sir8rEmtMKS8142w4mAMYuSYWz7czJd2a04fntxSveAEAsFtjUyMg6ELs
wA4VE7b0eQ4LaHUrg/DRhotWy4jTqQM=
=qmLK
-----END PGP SIGNATURE-----

--CWgcfqNph4SHdKPp--
