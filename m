Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3768BCAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 21:08:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8804580107;
	Thu, 25 Sep 2025 23:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GSRCjnIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AEF8802C1; Thu, 25 Sep 2025 23:07:59 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 347428003E
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 23:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30ccec59b4bso1382546fac.3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758834476; x=1759439276; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z43SXngmoPI7cdz05qPPFhp37DQlv5VvcYnIkKIG45w=;
 b=GSRCjnIxIDPhKVAqy27LApG08FOBHZEvbO6Bs5YWUnPOcBLuohvaHDevcuYXDMHn6e
 njfhJvyRY9CNisGFDijIdwD12VfhVw+y48ElivAXPAGHKWbpB88xaf9My5ssqeUPrpPg
 zIvfFt6ZHHOJEmWJ9wdzROI6beHJPXyvZPdyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758834476; x=1759439276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z43SXngmoPI7cdz05qPPFhp37DQlv5VvcYnIkKIG45w=;
 b=rxWjjWORfTtn4y+j/Z9oNMbX1wBCgC+N1xc7Y0NKUbygX1IAb6AHNB3Ljtie5QUNEe
 e88Xq6I6SYGGimlQWaQsgTdOHxFIG539CTPmBJQmOHx8THUyGRvc0iGwnTvwHto3MTCZ
 8hqVbqwt0BTOhdqGDKGU30vDFhdfENAgj7Nkt4+axjcr/92Ut+sKEH0R1F4lq3laqxpE
 Ea+E9vN6Un58gUATcErJ4WTq/P7uFEsG/g2GEK8EZWGYzC9ODy4EwTg4NL+07vD2LsGN
 nYDmSnbwXYR+9QBVi/T8Mkj5s4dZ8Yz+bM1q5oTb9K+fGEsQSzs59T1+Q+dK1x+mwiO4
 JOQQ==
X-Gm-Message-State: AOJu0Yz2gnkp4hpPQ2iRgz/SbDr39gt5YRVgRfGKK78ncS/y19dQigF7
 +D6/80q8U+d0vGrMK8syOm4Y+mRP5PsdXCnRRhdnRXPesq/+Ri020vTcvt7V5oFYdQM=
X-Gm-Gg: ASbGncuYYDhF+jrQt+sMITNaCei+RCyBciBx7NJANgERpCh5RBWaQka5oA2Cv7B6pnL
 gxYoM4v4IezHPokun2mUPdBNg2nzlo76wfO01z2kvqV9Eur9OKuxNt74z38Ie4E9iEMLeh/Jy8D
 Ax2+v0KSN7Qq0h3JuQdkepqzSID3elUI97JVaSmwLmUG/r4kUVZ9BjkH9uBB6+k1h0ovgcd97b0
 eV6EIgpJizvSowYcbulztNemE/dGQsok+fO5GpWuWts6atcIrS+WMcdHxFq5/vzMmBAh3ucxn1R
 FHT3ILdrLIf5AojmnbrfOGtLS2m2TYfGOj1vuB8Sh0B5Z+VwjbcOZveA9MCE8tud31MJ0H25wFE
 JRBhWoZUKFrZT7yMnA6ps3a1ioa+GxkyP5ptFQ734PNBhCji4b4kaW0eN
X-Google-Smtp-Source: AGHT+IEfeT5gNjRWvP/Ma2s5ATm3eFEBy3FxoEQ7Z/P06rJBo3wFru1ohnHDr2EHLtxQTv2sqEj2KA==
X-Received: by 2002:a05:6871:3501:b0:365:1c38:3141 with SMTP id
 586e51a60fabf-3651c383a63mr1641882fac.13.1758834475855; 
 Thu, 25 Sep 2025 14:07:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363a15c0449sm856975fac.3.2025.09.25.14.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 14:07:55 -0700 (PDT)
Date: Thu, 25 Sep 2025 15:07:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 1/4] usb: musb: Remove reference to drivers/usb/musb
Message-ID: <20250925210753.GS197373@bill-the-cat>
References: <20250925204225.3560724-1-trini@konsulko.com>
 <d4d60493-6c8c-44ca-8cab-4661f8bf5cd8@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9D6rlFHkzDVZwm3p"
Content-Disposition: inline
In-Reply-To: <d4d60493-6c8c-44ca-8cab-4661f8bf5cd8@mailbox.org>
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


--9D6rlFHkzDVZwm3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:53:51PM +0200, Marek Vasut wrote:
> On 9/25/25 10:42 PM, Tom Rini wrote:
> > With this directory removed, remove the reference to it in the list of
> > directories to traverse.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Peter Robinson <pbrobinson@gmail.com>
> > Cc: Marek Vasut <marek.vasut@mailbox.org>
> >=20
> > Marek, can you perhaps please fold this in to Peter's 3/3 on musb
> > removals? Thanks.
> Which patch/series do you refer to ?
>=20
> Can you both maybe prepare a combined patch/series instead ?

This is a follow-up to
https://patchwork.ozlabs.org/bundle/trini/allyesconfig-prep/?series=3D46288=
7&state=3D*=20
(I forgot to --in-reply-to this patch. oops) and yes I can v2 the
series.

--=20
Tom

--9D6rlFHkzDVZwm3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNWvJQAKCRAr4qD1Cr/k
CgRqAP9gPoSpxw64bFblV03OHQ59Kv6njun7YxSr8CuCW+schAD+OIHiNlngXHZX
p887D6DV3HtkGOBkZI3ypqYIsVWcnwM=
=j1fU
-----END PGP SIGNATURE-----

--9D6rlFHkzDVZwm3p--
