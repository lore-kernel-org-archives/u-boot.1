Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068E4C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 18:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81D1B88263;
	Wed,  5 Jun 2024 20:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H6e2fX2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB53881E5; Wed,  5 Jun 2024 20:48:41 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FEEE88263
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 20:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d208a05f97so53226b6e.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717613316; x=1718218116; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WhHBdcL6odTNtnNkXOarQBnrXbZTf3Srj2i6A661SOo=;
 b=H6e2fX2Fqxi9qmPAru0mdHeMCE7Brg5cuhD8SMWZtSOsKaBDT23bgfg1lRlWgpKxhq
 qoTxxzcs5QV/8jQtZRZZcZwJcjU5E003F/iDXkN+oohJzXKX/W0NhxQ0S62opzZPl87r
 rEO9U2Rupyqk26YVjU/D8uw1uNQtIGegv64qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717613316; x=1718218116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WhHBdcL6odTNtnNkXOarQBnrXbZTf3Srj2i6A661SOo=;
 b=b3Iu0J618b10yp413661q+l2h0PykpRUt4pJK0t33owgOfV1cs5pVMQ8gi8IBUmgEr
 IzDAZC2AT40O/DBvuIK8oQS0ZNEnpu6qa0zUG2Dh1Et6/q+Mii1P5pgp9qU/rrvDp/Y9
 a6KG2hAuN6s++3U+hrTVYena+GAI52OSEx6oSjtblVlDWRMeq6lZOdUDhO0wwr0T5f8m
 i/qbmSaYp1znpPPDVtjsrP7tzjkYZz/NYrwh66/jMvvagqBDBdmSIhnfpnDddiUX6Fmd
 ENCyZsLaZ6NhiD5ICiR/cIB9m9urGFLafx5EALzVpnyD7qXzouGqyR8Toea8+hOQNYFT
 ZjrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsShMpxiOxxAm/of86BYmcyvYhZ+rGA7boJpxi6u7wLplpmFkhDHRp7xXW9tkpgwnkw+oV2lo3H/smD6z16nLzImooEQ==
X-Gm-Message-State: AOJu0Yz3yk9R6Dk5hRu+eHxq22mL+lH/mtCVtYzBDQIOp4k3diEHPlmJ
 0zgwmcunVfHQwOmYBK1JDQK5YB1my5U6apVea9rv2/GvJnGyQx4C39zDmRW+1AI=
X-Google-Smtp-Source: AGHT+IG8sAmO1y2vPYrv12RH3PnYXvkYfv+k3v5sC1xLdP6yTp+dAhP1sjSOlYusIhv0Jg5shoo04A==
X-Received: by 2002:a05:6808:3948:b0:3d1:d437:28e2 with SMTP id
 5614622812f47-3d2044dcb31mr2919844b6e.51.1717613315187; 
 Wed, 05 Jun 2024 11:48:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20a7970c3sm28606b6e.36.2024.06.05.11.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 11:48:34 -0700 (PDT)
Date: Wed, 5 Jun 2024 12:48:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: hs@denx.de, pro@denx.de, vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 0/1] drivers: bootcount: Add support for FAT filesystem
Message-ID: <20240605184832.GV68077@bill-the-cat>
References: <20240605181041.68317-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="acJGaOXjWeUuUnts"
Content-Disposition: inline
In-Reply-To: <20240605181041.68317-1-vassilisamir@gmail.com>
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


--acJGaOXjWeUuUnts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 08:10:40PM +0200, Vasileios Amoiridis wrote:
> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
>=20
> This patch adds support to save the bootcount variable in a file located =
in
> FAT filesystem. Up to now, there was support only for EXT filesystem.
>=20
> The reason I put this as RFC is because the file "bootcount_ext.c" will no
> longer represent the implementation for the EXT filesystem, but also for =
the
> FAT filesystem. Should it be renamed? If not, wouldn't it be inconsistent?

Yeah, lets call it bootcount_fs.c ? It otherwise all looks good to me,
thanks!

--=20
Tom

--acJGaOXjWeUuUnts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZgswAACgkQFHw5/5Y0
tyxcbwv+NVcUxVxUvFGMkyW52pK49RAu033b8qh1qVbLyFChE4vqk6jT7x7y5ahW
KpbbeoSshdDanKOw3UtP0GW/14Zb/TGmAQ+y4nrUgE3l8Pd1nis0JONXN4vT0bFI
A07eTIzhteJH3UrLaSM4buSZSZzHTYdqbjn6jJzjSzSQBmgIllDNuEAAXvESgexB
40l0OaQfNcH7dfA7bIdGRnF70v69e5wlC3HMUNP+hLi1h8zLHdk0+cNKtgQN4Bxl
SMj1oA8Ig4McGmVPYPZm2wGxwTatS+rimFxWlEzEaqvEcbbHvgxydjAsbsDAVPpE
/AuKjnIqJS7ZmQneTuaGzHJbZotp1k7F+9eeEfdHxOvxjWeDISkxuWtJCX6sfYiO
cW1y43uwn7W3qaVhxMFeWoyXTOznHjCK0aFXUBfqfOmuJPC1Xxi1swLQrImSfP98
3dolbH2Zd4END4hJIrR2yHZ/Y6hRCzyrDs0EtACgejw16CycalIS0RUwyjwR4kaq
PPvmfzb6
=Zcy1
-----END PGP SIGNATURE-----

--acJGaOXjWeUuUnts--
