Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7A5EDF173
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 14:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C028D83AAB;
	Fri, 13 Feb 2026 15:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ba6Oi5gw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A19B83AAB; Fri, 13 Feb 2026 15:39:45 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA98983015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 15:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d196a2334fso942463a34.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 06:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770993581; x=1771598381; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J8X4L7gdtutJmBqEoQWarroz3UCLPcmKBWVISCaaoDU=;
 b=ba6Oi5gwFv5s2aqLQ3YfNqSGU7jcAN4SYePDLPo7N/MIyAmJRSEKHgDGvTvW7ptMkh
 jlteVShjwFTcj23tTQzZ1dBCIC2p3X3qA2BG3L4LXWMqNzbB67IXp2arY3uVlK+uFGIQ
 4kW5PvSFSlB7CnOl8zK78oDkdij5Q5F/NLdMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770993581; x=1771598381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8X4L7gdtutJmBqEoQWarroz3UCLPcmKBWVISCaaoDU=;
 b=B0Ox6k7DNtkTNH9pfR1iEe0+wSmipdoheiGL3vIOrUKpQHAd6SfqHoPqhjG5oycPcJ
 +ykokswGcUqXua9qy1eqUxSkmgnW6qORYrXxF6JIat8tDFabzpbFS6hjtTXOiwEejzZa
 zn7UlMX8pgyQUgiZ/D5BEZnjsA1m+JGoW/zIvCsOmjAT9QbMF6SflLy7ARGPK/boGmyd
 dTB2XfZrBR6PHrHTiXDF9DH72A/tIZQtMpEj/Y1mcuHjL7QgD38MB6teqvYpjVd4pbP6
 uTFqTlVvTgMg/QhMiQ3KngND4ZFJq4CqBC9fvfNMGxHkkToUmAVMoJW+w+rnh67lL1hV
 maHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7u8YjCKs+05ZddkWkerVd/17vax/4v3P/rZ4LHFqSbxKAeWNKpy7P2WMvHo/um00NfTRzK4Q=@lists.denx.de
X-Gm-Message-State: AOJu0YykKt4sxZtSIDi58WcD0Fz8Tc0kFDlkaRFdlsqvQnQpaSLEjO/S
 VGMKtqcjm0hjGxsWELm+oUrl0oXF9TcbGWLAjiujtni7DKpeR9J8aYSZgxn0etFdvfjXH/Qivxz
 kufkdkGg=
X-Gm-Gg: AZuq6aL5rFqgFbOyLhFYjvuxU8uwmCHNDrhg50LJzSxiZVSItOKYCEFMCayacjXvaCc
 1r54CXGxgD5Md2XSDjwB4eIMoih1SOIiwxYtusTlOuzKLbql8QwqoDgRiJNejEr495VMoo0hOh9
 40P5YSoj6c5wd1vSV8TY3+QorXZDGIlpCdoTC0jqWIa/nm+jTq//fV9KQGSF5ahAAZWbjiyEvO5
 djluO1hpojT0KXFgAiWKngzt/MaWWy+hrJb0xqfi7pRt+O7Y1bIcIafNDNEt/IE9nYxIdYkkiut
 pN8EVM2WvXstyiQNzQBQhhXr8ll4Ro0+r9tvWTpyFti/O6tlSwlKFcZchvxWLS7eV9QcZBssC1r
 yfmZA9Pc9CR/ASW95YxI5578CwgQYeW48w+HPQkex3YMbTOAata2FGkG5eHra25ko5m4wkv9ZFV
 L3laDSInPZH4PLGJ+zmnfcE5SeftvygbJ7cnKHsbTuxM/p/PgayGl/IzwAKoaWDDLItqqNy0Aez
 hKgjyX/tba/3VKf8X9U3Zfxkl5SgxP48GI9JNl6zl3e29AIbFI=
X-Received: by 2002:a05:6830:8299:b0:7cf:d42d:edb1 with SMTP id
 46e09a7af769-7d4cdefa9cbmr182452a34.10.1770993581468; 
 Fri, 13 Feb 2026 06:39:41 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f9cf3sm6048483a34.24.2026.02.13.06.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 06:39:40 -0800 (PST)
Date: Fri, 13 Feb 2026 08:39:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: gabriel.dalimonte@gmail.com, u-boot@lists.denx.de,
 caleb.connolly@linaro.org, balaji.selvanathan@oss.qualcomm.com
Subject: Re: [PATCH v4] fs: fat: Handle 'FAT sector size mismatch'
Message-ID: <20260213143938.GF2747538@bill-the-cat>
References: <20260213053719.2590474-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WoipPj/5M4c7QUGO"
Content-Disposition: inline
In-Reply-To: <20260213053719.2590474-1-varadarajan.narayanan@oss.qualcomm.com>
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


--WoipPj/5M4c7QUGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 11:07:19AM +0530, Varadarajan Narayanan wrote:

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
> ---
> Changes in v4:
> - Fix clang warning reported in https://source.denx.de/u-boot/u-boot/-/jo=
bs/1365316
> - Remove unused function 'size_to_blocks()'
> - Triggered CI, it fails with this error https://dev.azure.com/u-boot/u-b=
oot/_build/results?buildId=3D12817&view=3Dlogs&j=3Da007cd84-3be0-5a02-8a7a-=
a34fb3052485&t=3D216c79d4-eaff-5600-0b8f-3a63c01a45d6&l=3D405. But that see=
ms to be seen on top-of-tree without this change also.
> - Link to v3: https://lore.kernel.org/u-boot/20260122063442.2622684-1-bal=
aji.selvanathan@oss.qualcomm.com/

And to be clear, since CI fails, this can't be merged.

--=20
Tom

--WoipPj/5M4c7QUGO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY83qgAKCRAr4qD1Cr/k
Ch0UAQC2UOaj+R8QSaxYgprsWaygpm5OeMgzAvuxv0iV1JZHGQEA/WscrsObI1rH
7v6YRXx45vxJ8bY1yYphmK96U3shAgQ=
=Teif
-----END PGP SIGNATURE-----

--WoipPj/5M4c7QUGO--
