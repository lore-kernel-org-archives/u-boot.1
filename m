Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A055ACAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 17:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE42833BF;
	Thu, 11 Sep 2025 19:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XiiCLyYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18594833C0; Thu, 11 Sep 2025 19:23:13 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E98FE83390
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 19:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-322695f899aso754315fac.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757611389; x=1758216189; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3TmWWi+qDexGnBNyKH6tJQSclu7Mk9eVvkKGW4CZQvU=;
 b=XiiCLyYLwlNV76w4OhZ1/0t+4n8P8ceV4/FAlLgNOWgzIv4Gsoq+aaViT//k6ro5t5
 FNqTMNBk3i8Nge+dfGNlN6ytxeMCzcwxeLXWJrb9p6vAgFHhN2gsLtA9+qEhhNfMKLjS
 VKxa30NlVqQf+Oivy46tiW4YxTR0gC/LWd4vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757611389; x=1758216189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TmWWi+qDexGnBNyKH6tJQSclu7Mk9eVvkKGW4CZQvU=;
 b=plfY0j7/yegBRAk35KOrlSdDGTgQgqBXo9m6up5qwwrsKNFplrY/TjbUNWvoGnXyoT
 l6LLZSnBMZ2ILZCbVkVfMAZ9hpl8L3c0qQMWlBPCRBEVQ3EVyJWtQi3vlnL6Qee0tm/z
 fQpLhb/sFPuq2uZVzOPrgKmv+UxEGynZsLFwSea7tCi81+JYNayuprl9vHmfRdXzvXnB
 ytikGhYYnpIGnAh0l4Xpuxptv1qAo/920UBxlQfYqwBoJOrfF0fdFYTz6nrO2w3hE9lB
 v/CtbdDnlldshXmqUqjkk63KhYMwhzGx+APXA122oTCPjhJY6qPo/b8WQpUokqFTOiqd
 HawA==
X-Gm-Message-State: AOJu0Yz0gGExQZyNd1uFCbJgDAwqY2hZkRnKILjnRItC9M93MJYDPgVW
 6+r7mUcyiIZ81Ztv2Jg69IRfarcA6aXt2hJPRqc1aWr+XvnLwyGDTOnznOcrxWAqPqY=
X-Gm-Gg: ASbGnctk3MRk6oPNqTnbE2wNAgS8d1jhVOzmQtovM4frp8p9Ne+TIdnIuPlCvh45LsP
 rNDHibJkm7qMCnldU4ywTfHefQzVLAcYbJdybdn+jw5+Urei/8Y8yePsCnRhDkh+OQPdsKP2kmM
 +gRwIuE4MdTdlArOg6v/7i9WZt7joMOkrhXDRUuaGnfzLLZPJQBfwjZE+x8qdjS7X8V3+JcXoFS
 67GZLNwmoBQ1liAdV22kajNkjrkWvwKLv6sLmexv0LCkVTIUrD3A9mVznHE85kOnOYGWJQMV6kn
 9hnGMdFKOvB44pz6bKdNpFph/i/82aB3yPJxTQvDZwualDgddeiT+UPU4CfEg6hKCKHaQqcrhni
 JUKNHG/g2PAVN2eSOFr9itpVRXCisgxrrheoF7jdZGJFbLx65ymgzy9MH
X-Google-Smtp-Source: AGHT+IHqofey87cSzGOG4aSAzgTmDLCfzImc27uKgEu8Z4floc3T++wGZrWBh5v9R0v2cUiPUuToTg==
X-Received: by 2002:a05:6871:5291:b0:316:8c45:3959 with SMTP id
 586e51a60fabf-32e53f80959mr18558fac.7.1757611389638; 
 Thu, 11 Sep 2025 10:23:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524be7ad7fsm450747a34.37.2025.09.11.10.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:23:08 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:23:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH RFT v1 01/17] spl: Kconfig: add SPL_OS_BOOT_SECURE config
 symbol
Message-ID: <20250911172306.GS124814@bill-the-cat>
References: <20250911131414.3296697-1-anshuld@ti.com>
 <20250911131414.3296697-2-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zpbJVwdl0L3hD2oe"
Content-Disposition: inline
In-Reply-To: <20250911131414.3296697-2-anshuld@ti.com>
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


--zpbJVwdl0L3hD2oe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 06:43:57PM +0530, Anshul Dalal wrote:

> This patch adds the new SPL_OS_BOOT_SECURE symbol that enables secure
> boot flow in falcon mode. This symbol can be used to disable certain
> inherently insecure options during falcon boot.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--zpbJVwdl0L3hD2oe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMMFdgAKCRAr4qD1Cr/k
CtCtAP9Bv1lBpAwfJ0MaUWskdPNx4zTlkGt72nECCb65GAhY/QD/fLGoB9WKz3iP
BQvULc5Q9BWqKub//iGSFJHRGAfkrQA=
=9/vS
-----END PGP SIGNATURE-----

--zpbJVwdl0L3hD2oe--
