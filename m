Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C91CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 13:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD7EC83849;
	Fri, 31 Oct 2025 14:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cbx9OD0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE34838CC; Fri, 31 Oct 2025 14:57:11 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 528E0836F0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 14:57:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3c94deb7c7cso1404829fac.2
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761919028; x=1762523828; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/+q0SX4ec217veqFuSs63sGOeWWUkSPvv4+PtuCB1xw=;
 b=cbx9OD0SldzpTpJaos79PcaiQ2XEbQ9ZWssQhS4b0dJlFgJA3GnTWQwI8ngHoIB0A8
 IQV5wx26OsIrTRo9Cc9Cy4K63oQjRhtuiSqei1cHYoANTjwqhuOiiMJnPZx6I3Z+p3A0
 ykKRxyS3nPpUHx+aSqiMnrYEgZdZJ0ba3a8Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761919028; x=1762523828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+q0SX4ec217veqFuSs63sGOeWWUkSPvv4+PtuCB1xw=;
 b=fRIveipiH4kVBZv2pq05AVeUnkykabJ/KagAkH+Fdy11H3/qdNKfBS8Y+IEse+6UF2
 SkUjVm3pHN83CebxAkk7+UW6/Gn7rJIpikuS5t/zELkamAPgMz+n+kxTuZvDl+houZ3W
 GdEN2ThuNr5GMAkqe8gyU53pDf5KPS+tSwl244DB9txrEDDycRi6fhJlspaobPOJ1DO8
 T+D3h9Nrm/uhe1HI6Re2/waCeIlPLftORO4RcDic27AoX+HT4GMmNdWSu2pD43Hu/I4E
 AItnIaVmA9vNUDqI88q0Za1Lwu/AYCQUiQma1VDIsbrsOCWehVa23QqKglWjq9Q0+F+l
 zdOA==
X-Gm-Message-State: AOJu0Ywtj47YFvUhT7RzwW76wLQhkTx2MAOkVy02MERF94D/g/lTWPtL
 yEhRW07y3rJVmx5dciej4UUNED1fIPg9AYNB1FQ6HWpwAx+qc8255acD1PwOFpAWplo=
X-Gm-Gg: ASbGncvtrRI1vSQT/oIY3x3NQbBv/Asl16XIIrcS3AbKFO6jCYU+RWrpsSWVeLryhsv
 R6PmadbDyMK5aRK2Nj9PWxQpVPeO2pxv2kPmJ6wXuGcbTnKzJ/Oxh+sz1nM/o4UYalYjQXODaDl
 /cCHaGqWqxiuRj0tWPF7ofbRUnVfdssvSrQFI+QyZ88iHkU2I+NyDXwHqrLuisfrSR2Hr2sjhnk
 yuzH78JnBUD2TC2GUa1/8psGOtxXabcGhsTHn6BNq3FcIjllIXTOxujZQV24wDk8YqeFxhdNY2C
 5JXDkQsXzmmWhK/fsRqSfanrF2BZqKC+g7qu17+fUWLMOQ0Isa38mGwWvXV3jNQnMzcrB5y7So9
 3qy3BIwTEunYN5CKk57pDqJ3+LOVwdQVlqZrA820ZmUTklQw0taEGnDNr/H/vU6gZRZp2uBLghr
 sgxtMCfxeD6SDAhLul2G6snbd67i3QzhtPlwxyoxu43XkCL5asYA==
X-Google-Smtp-Source: AGHT+IExNaVVZrC3Ld2EmRa5QCT4Rpc0GnLGmRzcLHsn0Ay/E+pi0G819X0fREehd0u4unj+1QkLvg==
X-Received: by 2002:a05:6870:b28b:b0:2d5:ba2d:80e4 with SMTP id
 586e51a60fabf-3dacbfc2318mr1674695fac.24.1761919027986; 
 Fri, 31 Oct 2025 06:57:07 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3db429afcdesm573167fac.14.2025.10.31.06.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:57:06 -0700 (PDT)
Date: Fri, 31 Oct 2025 07:57:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, festevam@gmail.com
Subject: Re: [PATCH v3 1/3] bsh: update readme with instructions to build M2B
Message-ID: <20251031135704.GZ6688@bill-the-cat>
References: <20251031074611.39426-1-andrea.calabrese@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="chNjvAMMyXiJYleB"
Content-Disposition: inline
In-Reply-To: <20251031074611.39426-1-andrea.calabrese@amarulasolutions.com>
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


--chNjvAMMyXiJYleB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 08:46:09AM +0100, Andrea Calabrese wrote:

> readme was missing instructions to build M2B. Now added.
>=20
> Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
>=20
> diff --git a/board/bsh/imx6ulz_smm_m2/README b/board/bsh/imx6ulz_smm_m2/R=
EADME
> deleted file mode 100644
> index 03d01325a97..00000000000

Thanks for iterating on this!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--chNjvAMMyXiJYleB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQTALQAKCRAr4qD1Cr/k
CjR5APkBzkHa2j/+oqodMtR00EuiWLBoPIY07m/n/YeQcOyfjAEA4GWLRrvTAdzK
PBdtV7TsNGll9L9MfNndpT6kT2kvSwk=
=2rfB
-----END PGP SIGNATURE-----

--chNjvAMMyXiJYleB--
