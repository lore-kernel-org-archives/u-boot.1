Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A979ACD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 18:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2A48341A;
	Thu, 28 May 2026 20:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OA7rRSP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D384839A8; Thu, 28 May 2026 20:08:10 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F548056B
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 20:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-479d85152c9so4785744b6e.2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779991686; x=1780596486; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KD4H+MRL5pnh4FOoKTWznKQVgWwiN5ir4HFctchuuvQ=;
 b=OA7rRSP15/RFPruqJU4E7JAkm7+NHX/sc3pjmDc5moz5PeGSKBlaDa38fbj54pqjYS
 MDSKEYtwWM1wUYZvrrtp8QmGg7EtIsm7V80Nt7xpDxY/1Y9lMvbglTGdSRwtpUv2ueR9
 iWHHTnfL7dpW//u7EIEXnLvFA7lbYQ2Ym9TFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779991686; x=1780596486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KD4H+MRL5pnh4FOoKTWznKQVgWwiN5ir4HFctchuuvQ=;
 b=Xb9D2zTrGwX/FaDQdzDmMM98JENyDf5hDysNtmh8LtgEu+4MXSj0xXdsCUacS4+zEC
 SdPmtse0tUqdUq8xr/rlgQKyS25YAfPMowLkPNiooBNcCjmyKqsbFKkUIMV/w+3RAxDL
 l8XN/4T5uO3pqF8skDB0wwepzQF1g9KW5PxnJ9DqduU9qqivp7MQfcOrRSlT+Btt8sC+
 cEJcA+7by2La1fM2WI9EyxAhxeurXEAItgwv4comsSz9ufvGP70iHHIRte/Dh1BfALyh
 ViPYIqnn0l7gFQlOD3CgK5CQihyBR0zfHV0veeiUutLZAolBvcAm5qdvyitIcBatcGHL
 ju2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lK6mK+IofneMe8LCVMU9pvWhRj733TUSKu/m/kkKCtv9a1u76l4Wn2MzMoU1hHhWXtCA7NbM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/L9r9MNgSxrrj5WkiUw++sz5tP7Yw6y/erbPZKAglSjCPnpHo
 aJg9qmQ1HTkpBnC/KUhq7iHnB7D54VY/oN8X/GCHBa0CbjinVgWfAXFYWUcHc7getrI=
X-Gm-Gg: Acq92OEUxJdb71I7+skzWRY/8n+TAIuLvWFWrxlDksTcGUM1IvDSNIQPmgPOlUeJP9R
 z9Gzs2VWbWUhdZItH5q7ByXRSO+lOID2J6c91w5Zv00JYhDhyt/J31mOrE8jToyC5dD3b0Qd/Wk
 Ye7Yds+sxa0m/8s5Eg6YJt0hRs5l35EKDzMv52nrgbiCFuO/zqNvXqzqRxogAeLhSVCfZEVPb40
 gNPK9nLTa5YS+gi/CzNfepvoBxq7qwEut8pYvC0yOd+bexOFxfyRxn0XMnus2iIvvRjN/I+/S5U
 xSlO0nBLZFn/r676zb1XvJ1NWO25v2cQnpzrqtpqJnYLEhFSafO7/MWmehX1TFyTFOXKE626bNy
 oDdz6g2ZDjVkOvIqBtVVhbp8Xj9vmIa7hUbTwSfWcjl7+FGiv4xuUOsvryLExW5T8CLRHuxpd7V
 iUIgaXsK2Ge4A59R6h41E/nyZnP9Q9dJZgxfmdGKkRaTExkjhBpQEl9r/AV9NxiNuib+xj8V2sZ
 klIqJ0n2/j8MWO0SUtzNgE5ygrHv9NE48Xo8BdvgDuHDzNwCC5G0YmO
X-Received: by 2002:a05:6808:3a0d:b0:485:7c70:f724 with SMTP id
 5614622812f47-485e3e95f76mr169714b6e.25.1779991686200; 
 Thu, 28 May 2026 11:08:06 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b635e4f8bsm20691142fac.7.2026.05.28.11.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 11:08:05 -0700 (PDT)
Date: Thu, 28 May 2026 12:08:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Siu Ming Tong <smtong@axiado.com>
Cc: "andre.przywara@arm.com" <andre.przywara@arm.com>,
 Karthikeyan Mitran <kmitran@axiado.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 Prasad Bolisetty <pbolisetty@axiado.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "sumit.garg@kernel.org" <sumit.garg@kernel.org>,
 Tzu-Hao Wei <twei@axiado.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] arm: axiado: Add AX3005 based SCM3005 board support
Message-ID: <20260528180803.GF93986@bill-the-cat>
References: <BN9PR18MB41883375E85F8CE353018080A3092@BN9PR18MB4188.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="88l7ERQam2m8NWOF"
Content-Disposition: inline
In-Reply-To: <BN9PR18MB41883375E85F8CE353018080A3092@BN9PR18MB4188.namprd18.prod.outlook.com>
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


--88l7ERQam2m8NWOF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 04:23:58PM +0000, Siu Ming Tong wrote:
[snip]
> >From: Tom Rini <trini@konsulko.com>
> >To: Karthikeyan Mitran <kmitran@axiado.com>
> >Cc: u-boot@lists.denx.de<https://lore.kernel.org/u-boot/?t=3D20260429142=
945>, Siu Ming Tong <smtong@axiado.com>,
> >        Prasad Bolisetty <pbolisetty@axiado.com>,
> >   Andre Przywara <andre.przywara@arm.com>,
> >       Tzu-Hao Wei <twei@axiado.com>, Simon Glass <sjg@chromium.org>,
> >   Neil Armstrong <neil.armstrong@linaro.org>,
> >    Sumit Garg <sumit.garg@kernel.org>
> >Subject: Re: [PATCH 1/2] arm64: dts: axiado: Add AX3005 SCM3005 device t=
ree<https://lore.kernel.org/u-boot/20260429142935.GU41863@bill-the-cat/#r>
[snip]
> >>  arch/arm/dts/Makefile           |   1 +
> >>  arch/arm/dts/ax3005-scm3005.dts |  28 +++++++++++
> >>  arch/arm/dts/ax3005.dtsi        | 100 +++++++++++++++++++++++++++++++=
+++++++++
> >>  3 files changed, 129 insertions(+)
>=20
> >What's the status of upstreaming these files? As of v7.0-dts I see:
> >dts/upstream/src/arm64/axiado/ax3000.dtsi
> >dts/upstream/src/arm64/axiado/ax3000-evk.dts
> These dts files were submitted by our kernel team for Axiado ax3000 board=
s.
> The patches we are submitting are for Axiado ax3005 boards.
> Once the ax3005 patches are approved, we will work on submitting ax3000 p=
atches.

OK. You should plan to move to using OF_UPSTREAM and using the dts files
found under dts/upstream/ for both platforms, once they're in the linux
kernel and synced back down to us. Thanks.

--=20
Tom

--88l7ERQam2m8NWOF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahiEfwAKCRAr4qD1Cr/k
CkAcAP46g0d5xVByU4UWGyyYW5eWazr9HnE0VnZZGndtzLz0nQEAxYgPAywaLRiI
pAx02nayDbNYLpWyA+uGk8N11WBIbQQ=
=fSaq
-----END PGP SIGNATURE-----

--88l7ERQam2m8NWOF--
