Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D132ECCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 818028361E;
	Wed, 15 Oct 2025 17:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OMhb/NH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D54835C6; Wed, 15 Oct 2025 17:57:47 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F3E835C6
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-43f912f9738so589205b6e.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760543863; x=1761148663; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eoCIKmVwI5eqrFZP9ywfVOrkB1XnVqwlupKYmgDGfq0=;
 b=OMhb/NH/b4MirJGy7ohIFRjuRI1KQkMWh2DIisaI2rsv+Ry5tctkNDco3oab1nGrX2
 GH/1+j5GXN4A8HLFLecwVTB0W+w5LYs+ipel/S0YZo9d0yWLsA/Ypa/wyFjI8upVfeo2
 K6tQ8UUvscyzyJj1m1dDK090ghPvnt68FFWgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543863; x=1761148663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoCIKmVwI5eqrFZP9ywfVOrkB1XnVqwlupKYmgDGfq0=;
 b=nuCUal72IFgiQuh3KBsNxDUoMLiFCM84I83tKuDOqodbYEk73ZGlQgxX5lBexk1eeF
 dnb52rZZHg+jj4U1Ta4yP9FnxvdLMyFrt9DdxVg6wjPxKDBfU8pGoefjzbBeXVcSM1zD
 R3SuWbrolSuIXv5LpgEVIzLSrQYDrMo3qbK68jN+UZE/vG23QpPOd08oi9dPeZ9n6eO9
 2Cpp3KCGEEfODbX2vQTSRvlh4K6e4QePo8cMv3gh4hfo1AY3SwPptttzXCqeqASDN8ha
 60cX68XU+PRSo/giaDbivceJvXhypFq6aSwUwPD0f3+nAM+9XI9jBn0Dt8JY8KrrmiGe
 zOEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw3zp0RDcqlp1Vu2gM1zQS6WP1Ps72bTBLHB+g4dacCkCIk0dKIsTWpKGcAqeMaU9vUC0rVCU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+cG9VISnHNN2XWeW4N0KpIthy35Xm1/5PU/SiYWNov6oHInrM
 BIu81A1krNYTbpS1LJB9MV/hsSj/mMN2xfEg9xTi1LRfDulne9MYjwdPE8b4YnRQPUA=
X-Gm-Gg: ASbGncsiiDvodiSINvbTlC1LOQOn+fZr9sLW67bL0v3V8tVHKaiAzYMdt/S2yXFb2ew
 CKJG+4fQ0Mplt4kox0hj3fJbwi4HxuE+C5DE6QfUSsUmH47hLoXzcTwayREZt1dZ49ftrtCdVlJ
 e3oU+9qZ2/WsJE/GqMD0gcs5tg06R/8gau5XgOij2kdUGaQbZPdcBHJV2YsUmVivgQghxLj10EW
 ggypB9qI4rO4PTINQFP5K/0W45pPfb0JV3Zq0hGhPp1A5IsLwbFcRYVug6lX2aeRhEqwzb6vsMc
 DhysGNOXB63+KRDEXHWCnF0ab4E+pEZd4nXYh4kcQpd1rtk07sMluok8o8p6P2IShN8h4yUryAt
 kyudgaprGlFt+hFK9khKnWfiRjxCksOqsfAMdjr05tIdCeF0679EK/YB2NU1HiIH8/NPsw7e/Km
 VUiiwU
X-Google-Smtp-Source: AGHT+IFcfSiNHl4t2IfKShKVPDNRn2OQb9tvqI1VQ1iBaEl7FZkpvtYO/dzh33I8uJbh780QlbkDxA==
X-Received: by 2002:a05:6808:238c:b0:434:ef1:568a with SMTP id
 5614622812f47-441fb6fe42emr332081b6e.0.1760543863507; 
 Wed, 15 Oct 2025 08:57:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6501a8cc2bbsm3771264eaf.7.2025.10.15.08.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:57:42 -0700 (PDT)
Date: Wed, 15 Oct 2025 09:57:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: msuchanek@suse.de, quentin.schulz@cherry.de, u-boot@lists.denx.de
Subject: Re: Seeking advice on API return type inconsistency
Message-ID: <20251015155740.GP6113@bill-the-cat>
References: <50055473-7684-4a61-bce2-c61f19d754cb@linaro.org>
 <20251015155318.20628-1-andrew.goodbody@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zm4C4nsu0xkbRQ8Y"
Content-Disposition: inline
In-Reply-To: <20251015155318.20628-1-andrew.goodbody@linaro.org>
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


--zm4C4nsu0xkbRQ8Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 04:53:18PM +0100, Andrew Goodbody wrote:

> That 1st series ended up in list moderation as there were too many on the=
 Cc: list.
>=20
> Can someone release it please?

Done.

--=20
Tom

--zm4C4nsu0xkbRQ8Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO/EcQAKCRAr4qD1Cr/k
CpAHAP0Rz4fbBcEIysIJz/P7VTT7/tWY8ErAh+in3guZv02XcgD/U/e0fFr1QtWU
qPrkJIsDbp5IrrqiRQbMdixV151HFAk=
=I/yT
-----END PGP SIGNATURE-----

--zm4C4nsu0xkbRQ8Y--
