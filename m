Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABF1C83F34
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 14:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C503A834B6;
	Sat, 19 Jul 2025 16:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CHZsVUer";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDDB783510; Sat, 19 Jul 2025 16:58:25 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E0E5833AD
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 16:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso2119589fac.0
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752937102; x=1753541902; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PaTiTuGuRGS56uHFqbW3mX/yyMy4suW9kYtdiMgxo2E=;
 b=CHZsVUerMHV6omSXvjUixSBxCKSPHqGfiSApibWpqohRn/FWsD4jwedKbLIx5+X3yn
 /fCIf3tyup+IdbkHyqL3gV6+8JD+ds2LWbQZkWB8mCNJMOev1y06/emb1kbg2axc5pwO
 XWnIECyHKwSeOzdaXyCUcPE0wFv+Fp7iUMtMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752937102; x=1753541902;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaTiTuGuRGS56uHFqbW3mX/yyMy4suW9kYtdiMgxo2E=;
 b=Swrmf1ilSpT9Gd+QiAg4PY/vBkQ2uGXFADF80aUz3tmKHiWb0THgI7b6k57FMYO5Y3
 RhMos92hSJJA8E73e+odNll7yWeSqL8syoTSNjqtm7HHI1wA6G7Ig+kN4dAS3abJ0cwb
 XQZmQWgAXd5ZLy6FNQqDZBagQa0oXNjhdobMShJKDcn0FQqKh0EFbtB38DsdbNMuqSkc
 dhC3XLbRq+snqt8aQPBkcLr23fIFc4KwpGklXKQtSmDBLbhU2TUCrlVipQxvrVblnzBK
 nrr3yKqBg+YqP81Uf0Jf4pSlOASbZbQN9V5Ahtx7N2rNdYyu3ZYetW6k+p/ysUmJY+ME
 +Exg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkH/Hv+jr/rF8ueJnwgUYDFElZHMZFMKJAlPfy8wVxx3qgAkFB4WlwnJAi2sDOhW8orZgWMOI=@lists.denx.de
X-Gm-Message-State: AOJu0YwRdsefM5ZI4pvDbYR6InqX4G+wJ8G71W8KUMOIWis5Qp/ig53F
 vDMPsLwl554XIwPrQwKL4WSfvIGIwQJgm6/Up65UXOm7UoyIerwRdzT+tCc7uvcbGvk=
X-Gm-Gg: ASbGncv9qZYrj9vxRMHWTQADePFc2WNPRCmHfPdZRPAutjJr8dR6wMqLDY/Lqglnid1
 BGTHgRT/QtZ90wdHA/a1pGnZXQ+h2Y3ge+nbeexeKDfIxUHfYOFtIbC98KTKCLUxKFgF3FN8lMN
 9ZLZaw+e4fWMb9oFuhdIBIM7v5FSteHGKTLdETH8gVgRpy2jbyUGmT3pYNvKdRlsuzctvzIlDoD
 Ko3HFFgLJ4lJ7ywT5XwBcmFGnUqWgseLh7mYcPLHAZUrl0Sbh4rZFcizz+N+BmBGGrJKmkO1KvG
 88JrpChjvLH/ORwZrkdA1PMjmvnD5HSt+ilNCPh3UGXU20ZSUSyyccxZIMCDsOCYny74X/vfIdz
 pkmv+Ub8neIjdEDTD5PwL5MxkF+lp8bQXwMNswY8jI9l/cruGwIPKgxTq
X-Google-Smtp-Source: AGHT+IF5iW5oq/vK56BXIw6cKooiiXFL43nwtqANWWQ6OQNv5bS75/S00cnXfyAXRwV7vDyDc/sJzA==
X-Received: by 2002:a05:6870:7051:20b0:300:d9f4:dfb5 with SMTP id
 586e51a60fabf-300d9f533a1mr3370304fac.24.1752937102020; 
 Sat, 19 Jul 2025 07:58:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30104796fb0sm1737925fac.45.2025.07.19.07.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Jul 2025 07:58:20 -0700 (PDT)
Date: Sat, 19 Jul 2025 08:58:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/7] airoha/an7581: add CONFIG_TARGET_AN7581=y to the
 defconfig
Message-ID: <20250719145818.GZ193579@bill-the-cat>
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
 <20250719005717.113842-3-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y2iOs74zF/No7sbX"
Content-Disposition: inline
In-Reply-To: <20250719005717.113842-3-mikhail.kshevetskiy@iopsys.eu>
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


--Y2iOs74zF/No7sbX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 03:57:12AM +0300, Mikhail Kshevetskiy wrote:

> This is required because airoha/en7523 will be added with the following
> patches. Without this line config for en7523 will be created instead of
> an7581.
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  configs/an7581_evb_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
> index baa3fc3f5de..73af30cd693 100644
> --- a/configs/an7581_evb_defconfig
> +++ b/configs/an7581_evb_defconfig
> @@ -1,5 +1,6 @@
>  CONFIG_ARM=3Dy
>  CONFIG_ARCH_AIROHA=3Dy
> +CONFIG_TARGET_AN7581=3Dy
>  CONFIG_TEXT_BASE=3D0x81E00000
>  CONFIG_SYS_MALLOC_F_LEN=3D0x4000
>  CONFIG_NR_DRAM_BANKS=3D1

This needs to be in the patch that adds the symbol.

--=20
Tom

--Y2iOs74zF/No7sbX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh7sooACgkQFHw5/5Y0
tyyJegv/Tw850zjoliaadf5DJsEpFP+5olerApZgPotivVQ3sU0FsbNua6jUnzRd
ViWgwD11OAyc6Z/VEk8uyyqV2brmRRiIOTt7CF3LF/LPSVlWIyEbSSKrjTvTTN2h
R4rAQvEWHZRT1huwtjyavqqD45Div6SPOPavTIEpsYOCfQ76ydAoMuGTt2ctaKV8
rrNTeUxehHnXmIi6K1Wl1bPJ2hUMNOoJ1KmyGo6QlBU3SXYwBwdhml8E3I6RfyLo
fLIjBeCtbeSHvjyMooOxY6JuIwc4QiV4Gj9Q/YhbDIYJJOcvvNJykNfBNxYq4qrN
lidP+nN9lIS9HsttKP8otSyGRRbUKFSSg3USKoOYZ3nrC3WXHNvbooclvoPzBiCJ
IRfIA6d0YYKNE3t05BCBG7oH8WzfUTr2h56j2TwNbHDErH09arLCze9bqWItwU5c
NBPgSUqJGihi8jbOmlh78ZNbaxVpfPo9x2cVDPXMRX7Aa9ZgFsy6CTQ3yTjltzk0
EwSixEsx
=EcDe
-----END PGP SIGNATURE-----

--Y2iOs74zF/No7sbX--
