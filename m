Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2581D46BFB
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 20:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D43D83DFF;
	Wed, 28 Jan 2026 21:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f4ZlYEa1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF9E83F14; Wed, 28 Jan 2026 21:41:10 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A35F83D8A
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 21:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-4094d7d71a9so80984fac.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 12:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769632866; x=1770237666; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U39Z7FtEBVQgKgj8SVH1DRl1z7lKlJF9n/KpivQqROc=;
 b=f4ZlYEa1pyRDupXvS/+JSywCKvpppnhhd4ATm0h5dTMLLxnbmvnHXr1tLJeWEt2f4J
 I824JVAniIYSppAm2NRdhcRSLD7+HjpXABeMvqH6BV3Xlvl/g+Orbcg342ytS6HQz+TH
 mh10YOUI+c3m6kSg2BF4pUDxA4Vd92R/I9/WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769632866; x=1770237666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U39Z7FtEBVQgKgj8SVH1DRl1z7lKlJF9n/KpivQqROc=;
 b=KboOTseiID2BzaVdJrpfZA6INg7MgyOGGkQrfLiN5BGOXM4ZfIVvZ2LDaUGf22ro5R
 eP4AU4ns/gsoPtzQSrLp402iJhz8pC4DzxQc96KBXo8GBStv02UgFDYUtMyVFQeyzBqz
 79gyeUefbLMJC2GcrawqwNYYbWiEuEPCAYCxXXziZoFCLbBdTohXxnJSoKCPo4g12tQk
 hT29giJB0j86pLdMCvXGNOd8EoBM0zohb2r6SPHxsOfMMvig+IWKZbzjpNdrwn5+v+Vi
 q7ZOjf5u4D/GxPztwbCl3v5p291wI+r8BraDSVuhPpJIblnAqgZYBZdPyuJ5OkByYch3
 YWoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+tWl2ZBdeYZmuWvq1QdQissf3MmXKOYtSAEnQG/ind64SMC6F8pdcejTSweqspAoi3JWfO6M=@lists.denx.de
X-Gm-Message-State: AOJu0YyDrLRpM+E27nBxZvU0hILxU+AYVGoVGG6h1rBJtSGdx4AbPt0W
 vjBiWgh3cXp9V59Jt122adx92QrjSz9D5aIaSMheGOK2h2hNXND7uypNNj8MZLYZ6EygHrlwyxx
 gRozN9qA=
X-Gm-Gg: AZuq6aIDmB4Kv7hxAXeBlBNpTCisFCgL/KruUhqVgGzV2gYnlVevcllWnUa/B68x0wk
 hMk5z59pVauSw7Y8rv8z2bvaY9BvkdbJ+STyxDtROHAURXAjks4fWnHKzXDxeHoU8DKBI68cDlQ
 IxqpIw1W9Et4Io1QLBbdfi9MMmukB/iUVzxHVaQWLmTJBmSsvBlw9zihX4X3FD6QzpdqPOJk4F3
 XKHfLgc33MYniaUrz4J6q35bY1rzHVteD+CDz2OAhnJqHmsz0bbUf521TK2iDmM7LL822B0UotD
 gG6mw98/SD03kMiETUXCo/jT4maD149ov4LTfoJm+gvQT1N0vm2NrK3s3rPTZJETtiyKCtIkeI6
 x4Vbmbemzwtca4MnfzCdFq+6rhiORiV7zEFsINHx7nxg1wRkxn2fjR3aAvF9I/DHS8Ylfpqpa6A
 BWHFtXhwirRXozmyqbORl2xpI0CmAYmus0H/cHAeMKTbIN5CK1U1MQQX+3CokmfmDSQVq9u+Mve
 wjVh0CPtvLytsAoUURKI0SU2EQSu89xz2szHEY=
X-Received: by 2002:a4a:e841:0:b0:663:517:7d8e with SMTP id
 006d021491bc7-66305178077mr544589eaf.17.1769632865767; 
 Wed, 28 Jan 2026 12:41:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f9a18de2sm2054866eaf.11.2026.01.28.12.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 12:41:04 -0800 (PST)
Date: Wed, 28 Jan 2026 14:41:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: varadarajan.narayanan@oss.qualcomm.com, gabriel.dalimonte@gmail.com,
 u-boot@lists.denx.de, caleb.connolly@linaro.org
Subject: Re: [PATCH v3] fs: fat: Handle 'FAT sector size mismatch'
Message-ID: <20260128204102.GA1740001@bill-the-cat>
References: <20260122063442.2622684-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2wcXbl0lzv0Myd7M"
Content-Disposition: inline
In-Reply-To: <20260122063442.2622684-1-balaji.selvanathan@oss.qualcomm.com>
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


--2wcXbl0lzv0Myd7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 12:04:42PM +0530, Balaji Selvanathan wrote:

> From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>=20
> Do FAT read and write based on the device sector size
> instead of the size recorded in the FAT meta data.
>=20
> FAT code issues i/o in terms of the sector size. Convert that to
> device sector size before doing the actual i/o. Additionally,
> handle leading/trailing blocks when the meta data based block
> no and i/o size is not an exact multiple of the device sector
> size or vice versa.
>=20
> Tested on UFS device with sector size 4096 and meta data recorded
> sector size 512.
>=20
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>

First thing, clang shows a lot of warnings from this:
https://source.denx.de/u-boot/u-boot/-/jobs/1365316
Second thing, filesystem tests do pass:
https://source.denx.de/u-boot/u-boot/-/jobs/1365314
Please make sure v4 is put through CI:
https://docs.u-boot.org/en/latest/develop/ci_testing.html

Thanks!

--=20
Tom

--2wcXbl0lzv0Myd7M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXp0WwAKCRAr4qD1Cr/k
CuzEAP4zA+klUfsWIwMt+k80Au7tR3QWJQALfnTuDZwDqucDDgD+Ll+Cpp5Ck8Uu
qhlGSIoASzWXbwBE10PGDJL66LiKegg=
=F4M3
-----END PGP SIGNATURE-----

--2wcXbl0lzv0Myd7M--
