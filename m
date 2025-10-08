Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93802CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 20:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0BF83948;
	Wed,  8 Oct 2025 22:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YxQZiPXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77207839B7; Wed,  8 Oct 2025 22:50:43 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 648A883930
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7a7c1ecd433so163662a34.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759956640; x=1760561440; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gW8xm7l0IwfX0NRDLtjqWg8VVkf8CXQZJvkO3LTgQEE=;
 b=YxQZiPXjUSM3aYz/IyEe968QleDOdrv6mmxRGQn9ANxuYT8bMwfRQpjCOYCg2LRLOa
 0MaZgLPtku7e19Ie2YgKOjrtd/SAavuVgdAae/aseMPy+T6CE9mQ2Dhf646zu1hriZrp
 ulc11O7/Z5bAftrfZSWhWVcgFGxdSe6cyOwFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759956640; x=1760561440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gW8xm7l0IwfX0NRDLtjqWg8VVkf8CXQZJvkO3LTgQEE=;
 b=CFzFnGek8vurmipZu9w6UlTMJ9JFx4KoLKJLOpMhAbZBIWWqdesDUPZ9d9eJ6hcA44
 JWFxAds3ISCsaIVR71C/q4vUfIYWyAotKUVgMALH/X4UpMyHjJGA46dnNRiMw0SDI1t9
 N38t1VSv3CwXKEeFr9O2o0sdO91IjQV89y5jyFFb4NlaH4oOmJqm8psSICStjXW7RBIs
 CNgxb2MmTUZ+8piRX/4BkEIFm+u5J+Ckd8gcd86JWB7CWrEUgxqTnpRNB2i+dqjuzTF3
 M+EgHFJ+R4bCZkubURfY92XXLEEleihjWWS/1Hiy84pJuhoVbjmbRejsIvT+KZ/bLD/T
 +NCg==
X-Gm-Message-State: AOJu0YzrB4l6ulS+Wh3SunxTsa8DzOsNVOvwNAn7ZlHbEfYSmnsqVyaD
 COO55dgj7Y41i9pPqaGcvt0TkYo8PwLE0cNl9tc7q/EBLb3vawSa2SGcEeBRZArkYUk=
X-Gm-Gg: ASbGncsoDRuRwHWAEYzfY95o3I+6g7K/AvvXhSA3IDHljH8OzbsGld4MhxxU7WxDLKM
 aEsGNUJDQnqTvdVXMLJ2Wxvpc7N+Qddl7y04TPkux1Ph6Hw+6anfOPlic+AFhPTynqwI55meaWw
 nYKfGL9yCj/h6ynx4F5LqYwHSxcMJ0+ywhnJfvGm1bPwa0B2Vq/5P0SKBZlB7MJp481k/BvOXsT
 3K9W9eUYYcuH4dsjvGHMUgBtDeUcuF/+uOUXTpkx6a2seVWSmjZsj1xrLkg2+s3j9i18XC7gyG9
 8qX1zxPTwWc/88Ocs9lFCMd9X8+enFP/NHWEdqaxhVHrh90iVHWXqwTKoKQMkVGOt13+lkxTrGF
 pr+E8CmBXx9NL8osJ4Td5QpR0CFUxaGgrGqdQ80cyVCrPOUCQzdK3eR83nyFcKSyGJ3T7HomhJF
 +jr8LgOcwwgj2WqSSnAHsm
X-Google-Smtp-Source: AGHT+IHyZhjuL9KeQl1aCmAT3hMxVDvMZTJJxEdJ3fUrRkzcWDV0a97/OYWXxUVyMXQtOQ1rKQLuQg==
X-Received: by 2002:a05:6830:b8e:b0:7bb:385:5da8 with SMTP id
 46e09a7af769-7c0df701c58mr3188235a34.9.1759956640134; 
 Wed, 08 Oct 2025 13:50:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf43028c25sm6136006a34.19.2025.10.08.13.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:50:39 -0700 (PDT)
Date: Wed, 8 Oct 2025 14:50:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd/dma: documentation
Message-ID: <20251008205037.GL298503@bill-the-cat>
References: <20251008204103.1497-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pAHQ2iQd/Ev435yV"
Content-Disposition: inline
In-Reply-To: <20251008204103.1497-1-briansune@gmail.com>
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


--pAHQ2iQd/Ev435yV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 04:41:03AM +0800, Brian Sune wrote:

> This explains how
> to use the new U-Boot command 'dmareset'.
>=20
> Signed-off-by: Brian Sune <briansune@gmail.com>

I built this locally and no problems.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--pAHQ2iQd/Ev435yV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaObOmgAKCRAr4qD1Cr/k
Cud2AP0fB/tPTKqR7SZ1WmmwdFqzKst/QrquiWi96KldLKdtmQEAumNys/CimhIB
5z8DNS/o6yl+fzl1/CntYBRvoRtNQQU=
=gvZn
-----END PGP SIGNATURE-----

--pAHQ2iQd/Ev435yV--
