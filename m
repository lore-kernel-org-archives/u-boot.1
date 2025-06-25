Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417C1C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 15:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C684282D83;
	Wed, 25 Jun 2025 17:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l+ghBnAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D934082D88; Wed, 25 Jun 2025 17:57:45 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 888CD82CFA
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 17:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-60bd30dd387so15005eaf.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750867060; x=1751471860; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xaTAFrDNNavXZfqQm8SBvfzXSsMMdGmsgmqRpYxlsFA=;
 b=l+ghBnAU4vLC1MlrvNfzSRlYYzZCM4UVA8Z7EKWUaKspOxSeTmqsRLP+ln+X7TFHjl
 SLRdoRJajby9vAa0Et8Cj+zXKco/UVoZsyscMbV0KsNCeEhAftRq3r3RYKBx8GwgNpXA
 UJjb/7ztrWucnx1uI3UsZDVJAdmZ9aWPJDR9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750867060; x=1751471860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaTAFrDNNavXZfqQm8SBvfzXSsMMdGmsgmqRpYxlsFA=;
 b=hEVoyz8reHti6+jzl7/Ko5Rc0E4HoKpJ7HCmPZnzebIDBh4H77+8kmK7SwPX/KYYq7
 H7fcsa7cAIdRQex26hXPlYIC8fnFYR+yl0rzSV4Xo38l+f2lWl4ZcVnOC3ZgAzXguqVm
 QTr7juNruK4jyfMp3fjlTgElH4TV4rwkCeoJ0ayv3gQc6YVDzrN8EBgDzgV5ZbbJgo1O
 N/lqHFM1KNn/6UpW7ccLR1+0wtqEcPKO8VzVnrGD9qL3f6yeDwDGe+NCa+HBj17UrHi7
 maFSwR9hs9K4U0r0AX/mj4xnIcmRyTAm4//cpVT/7fxAW+dQM02Fvx/gxMmiDNuunPWM
 fsgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtVosMlgxTiho3oHEp/USLU2R/C3RATMnSh2G2HQYLoPQCEaqgMAzXkO6iSObh1HQh6k/tg7M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3q4S27Akw29qFyZwWqBzqMmyLuL5uP2Xba7x40E5OgSzfMxoH
 1UEThFhsxl4edymhnwjp2o1aOCuCLbMRQNXmg/GPy0YJJSScI9SwRj6rBFhE6ku0Bp8=
X-Gm-Gg: ASbGncve62/8HROBhtfqgOr/hohQbo0qKa84VGpTGl1KSHghvOuGrld4ovrvEv+nE4n
 zsV0RR5K8zRsbVG7xAzWtHl9V951K/1T14cWvBJYzTNLtZE+KJW+QS8NPLvBH7+J9P+5uQbhwjc
 xA0fRa5aiQh671XiSvNRCWHCDQSEb6Y4pqdNBaVbyHaTZ/S93SV+vSyWWRq0DMcViyuk4y0HG51
 7FchaGy8v/VpK+b2cnEk8YXiReH4UX+GDgGIrurepLuCUdT0ChvtvHEE4JUBkxGM/39vrf34RYY
 H1RUJSPucVGXkf7LWplY7BJ//UX+IVQK5QtZvq8TTtlheXhNrd6kTAPiM6Lp8aT6JyWF43WhHFH
 iDWch/vJkrRf5sqs0NcWDt+T1wWNwoS2gGg==
X-Google-Smtp-Source: AGHT+IG9vqY3V7R3lPkmmKVm8Ss67dgwlCQvtZJw1o82ALfTsNxEGnHru1gYgCnA67E8RTYZQON4Jw==
X-Received: by 2002:a05:6820:2908:b0:611:a9b3:1d6b with SMTP id
 006d021491bc7-611a9b332d4mr531287eaf.7.1750867060193; 
 Wed, 25 Jun 2025 08:57:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b7ca185sm1621617eaf.30.2025.06.25.08.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 08:57:39 -0700 (PDT)
Date: Wed, 25 Jun 2025 09:57:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Safae Ouajih <souajih@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: abootimg: Prevent use of unintialised variable
Message-ID: <20250625155737.GQ4003484@bill-the-cat>
References: <20250625-abootimg_fix-v2-1-0d295dc1f1e2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P9k4BxT9KJS+dfqa"
Content-Disposition: inline
In-Reply-To: <20250625-abootimg_fix-v2-1-0d295dc1f1e2@linaro.org>
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


--P9k4BxT9KJS+dfqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 04:52:41PM +0100, Andrew Goodbody wrote:

> vhdr can be used when not initialised so detect this condition
> and exit early to prevent the problem.
>=20
> This issue was found with Smatch.
>=20
> Fixes: 636da2039aea (android: boot: support boot image header version 3 a=
nd 4)
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--P9k4BxT9KJS+dfqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhcHG0ACgkQFHw5/5Y0
tyyEeQv/bFgSLTQLijfV/Qj+qUtpyEaHT6ITAPZSX7qrxNshUgHSHX0imzG5XOLP
FHrAQgj3ZhvkO1KNFl/3v+KhXoIPLJZyjOCUUvix1+jCf747Gh+Y7Nd/nAv3BJR8
lyE1tw698lZD6RWaYMFTwpe58uJyb+oso2tter+x7gkyWEMNnXh1Lf+k3RYE05Ot
77MRN0fIoJoWo4tT5j1pNIRQXd57fgcFsmnIpyBKDzFn1CBxveNrlSCJyz0Vac+K
IadHiPcnJRIyZ4aayZZytYenNyGXlAs2lIgJlDkopgfIfucSwWx2AFBYgBoOqwLH
cZ1B0KCGUOEc/cHzpmRqKqE19hkM5HHpwm03ASycqTYzxcsru8hSsRxaXO1ctVbz
73laANAl+N7y3dUpC2iS/4ViB/fd5Z4ZS6pd5gnnfpMnsslk3dcyiuRSyMxkfVno
xlhuHN4GCVR516eavIPOeB6OenfHCx0dtNCLqf7RBZk9PbRtEdetLxWdKHXsYZrK
um/CB2Q3
=K80f
-----END PGP SIGNATURE-----

--P9k4BxT9KJS+dfqa--
