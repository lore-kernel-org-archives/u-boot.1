Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AF3D7879C
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 16:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96C6880077;
	Fri, 19 Dec 2025 17:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KKGEx0TB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF8980433; Fri, 19 Dec 2025 17:29:45 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89D7780050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 17:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4511f736011so1792980b6e.0
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 08:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766161782; x=1766766582; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+N9tZsKAhVhd2+USWa5gCQfFnr+rOzw5G32bFJ2rrwU=;
 b=KKGEx0TBlHCFbdSFLfezbV6cyQGeK9n8E5KpMukmA834ZbgTidJFHY6T8Rf/N3Wlcp
 QB2/lF2X1iy9smxjUHpYxg0nepwWlAmciNfy3z/x7q9KGw0kwdcXWvEquJMU40sdkiv3
 32ZQlKcMVrDXJ9+3fkYNKtzB1tBbW371mbmIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161782; x=1766766582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+N9tZsKAhVhd2+USWa5gCQfFnr+rOzw5G32bFJ2rrwU=;
 b=HS1sLFmgmducAA0xS8crDJn5XUzYMrbzZu1YuydBPFG43DJhFD2pA0zbMx3MaRuKfx
 w+CXOUQKP94U7RZRnDKB4Lfm8ag8zxy/C51V6F++BnD7n0sKgv3V7i5ESENo9H8Bio4U
 aZFPf6X+kAj4ZT45Gyh5t4y5VOfXSJjg64kiNp4hrfugl16taxdu+HiksqkkwTtS0beu
 FiGgrVy9sOU4/AxerWPTuqBrStNtPq2DBJWG5VkgCly+lmBSTky7cFxp31xLQUl50eBU
 zf9T2FxVQQ6ZY73NqJEq7a+bXb5zensG9OQbyt6NUCSq0DN+vnJos492l4oshqm/waMi
 HWpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw7oZLbzY7rpn30NJszXKqzxXDP6lhs3Sqv/F6e5W7LEFYLxOkUqAlZaV6NTv5PMT23cip2IU=@lists.denx.de
X-Gm-Message-State: AOJu0YxIWPFBr4YbvsEKYGjWdIpoUBwoIf1fFXbF2EivD1UG18rfIMnR
 QenXDxJYFmFswx12CUFbKPYc3P6IymHesTq4UNOU96TO287NL9WrcjyOi8DKcj/eSss=
X-Gm-Gg: AY/fxX7F0dQ3nAW/9LY0iIKdIybAkHmbhBIThYkx0lQCyk3rvZmAMAIPVn7HldVXy0W
 SvIDparobwtuvtMCVrQR6gU747QQ7cgnBOoUjMAgVS4pw6bme0Uh4eg3U41ZjYIAzfq4bFAK6c/
 mSeYFkpjjPDbFLRx1RA9cHlOTdXm5/NHS03IYB64nojGV7YCzz53eWGmFm82TZlkwdcGnEDMyaE
 HpvlOu0856A43UsjcVBKvutDoHFAmY9XUS6jPZV/MkB9LytyZacl+E2BiQwkIplPvc0r1Xxoy3W
 qEjgG3vzQdD3mq3xVpIaRCbMEVh5U8R8R6ZE0WNmHGSn+VUSkG1bdgTNMinD4mNRPqnXcT+GfKZ
 xcnw0urWcVdMqcW9Emil0lvrvd+xl0EkUMOIQs9Daii1Qk10yiUdTOHffvALh9g3cwpoRypOJru
 Neq8M+4muEBJ6FB56KVMrTTxL8ulNK5GCpLXfMG94mfFo4i4XHFmb3mNoETUFG
X-Google-Smtp-Source: AGHT+IEFvQYGfE79jv/bkeP9uhOeUYLvMRqbwP3ikpMZ+7aH5stMTz5Eet8a+QDJmIxM9gGEtaAWEA==
X-Received: by 2002:a05:6808:4f5f:b0:44f:def8:2aa5 with SMTP id
 5614622812f47-457b1f5614bmr1546443b6e.0.1766161782116; 
 Fri, 19 Dec 2025 08:29:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3edb23esm1243393b6e.19.2025.12.19.08.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 08:29:41 -0800 (PST)
Date: Fri, 19 Dec 2025 10:29:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PATCH] Revert "drivers: scsi: fix inaccurate block count
 reporting in scsi operations"
Message-ID: <20251219162939.GS303283@bill-the-cat>
References: <20251209025634.14466-1-mibodhi@gmail.com>
 <20251212145056.GR303283@bill-the-cat>
 <20251216170641.GY303283@bill-the-cat>
 <4e912159-3b7d-4ba0-886c-d62ad1a3654e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ooXZjsLWcgMGn/DA"
Content-Disposition: inline
In-Reply-To: <4e912159-3b7d-4ba0-886c-d62ad1a3654e@oss.qualcomm.com>
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


--ooXZjsLWcgMGn/DA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 11:04:07AM +0530, Balaji Selvanathan wrote:
> Hi Tom,
>=20
> Apologies for late reply. Somehow missed the mail.
>=20
> Upon analysis, it seems the most likely root cause is Tony's 238GB disk
> triggers the CONFIG_SYS_64BIT_LBA code path in scsi_read function. Any re=
ad
> beyond block 268,435,455 blocks enters this path.
>=20
> 'blks' is decremented both inside the 64-bit LBA block AND after successf=
ul
> scsi_exec(), causing incorrect block count tracking and (most likely) the
> data abort observed.
>=20
> The fix is to remove 'blks -=3D blocks;' from inside the CONFIG_SYS_64BIT=
_LBA
> block in scsi_read() function.
>=20
> Hi Tony, can you please check with this change?
>=20
> Tom, shall I raise a new patch for this now?

Thanks for looking in to this now. Yes, please post a proper patch for
it so Tony can test and add a Tested-by if it works, that'll make
pulling to master before release easiest.

--=20
Tom

--ooXZjsLWcgMGn/DA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUV9bwAKCRAr4qD1Cr/k
CpMgAP40ejcq2/ukD5WsVBxV1IIAS12Ci/7Dq7eWTQM+DKY1TgEAj3VRbvfX4fwT
/cYbtNqBv1r3M9O01LFdXWxr2Ka7dg8=
=2r8Q
-----END PGP SIGNATURE-----

--ooXZjsLWcgMGn/DA--
