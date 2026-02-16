Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F4DE81A3B
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 15:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 249C08063E;
	Mon, 16 Feb 2026 16:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YSOdnA8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 101A083AAB; Mon, 16 Feb 2026 16:32:56 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E62A880086
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 16:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d4c307db9aso1915947a34.3
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 07:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771255972; x=1771860772; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nQMEfxJkFq+p1GxyBms9+ZvXp/yrbDVgfmk6gXGhQF0=;
 b=YSOdnA8Lre+uy5vwG7VicQdYD5DjtfOcbM9/ZchqaDbZd8yLpAr4zZ8+Fpm0HAsKSJ
 RQdsXqvRZo5YbBCWsjSPpvMQ5egHNNpSJdQz4tZyoB9f0UkHuhhyySIuq6wVUWEIqV9S
 9MQbs82aiMGSEcnTHzWSah5WWC4a+/CxiQZkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771255972; x=1771860772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQMEfxJkFq+p1GxyBms9+ZvXp/yrbDVgfmk6gXGhQF0=;
 b=G08rGGtendPdnLtawkeNZOleIv6jgx6s/9N5TUNNhTEyRVDVD0FkY9Gpt2oFAOD3eJ
 uBbMZGh+WrXwonhrQkWnpPnnRACcF2qf/OSpyVjSQJvZN5oc0XmDOEZJqRQz6cDfTQx9
 2/AEuUwnl7A1P4qRbQF87g3GeYnWDtfHi+WYURDL1xyJnw7HKAFvtaB1ZnwFr/yxJ34c
 iCKaUDhUGTq7bIlsAF7j3oPmF+HSji5Y8fXjKln4Qw4M4EvwoJWpUcf8VHcMN3AkH/Cg
 uS5q1usJl+ZGXshkwBGG63A4IENMoQSj1QQSUlhZeNPTA5o1jQPj4QDLOoEG7LQM1/Io
 zYQA==
X-Gm-Message-State: AOJu0YyUQmVyVRrGDwvkq7cTSGMCCO7jE3g6I3Bf5svGO4gUYSAQ1mwR
 rTZsPcKRaTm3dJnGjKoQClqnODuG5xtp0/Z7JVA+P3xgZKWOQZOmnoY0byrWYnO9H78=
X-Gm-Gg: AZuq6aJdVcqIr9hDuysZpPGVf4vPkQeX+jsd2AU5oSh4JdJ1Ylj6ubYL5iDQafrLXUA
 bKCM4Bde1a6OD7FSykIepO7AJhkKUD64j3ZtiJ4zxFLs2N9fzmUCyC3oWbCe/Wm5yJgYaulJ4/l
 xlIm27gSZllkKRFvwLkylhJ+v504egG5C9udMBcQCWDgtQIVddRIPClKBCiKk9ueeFgfSScN8Dy
 et6HS781v0jRuHzKBFmw7nF+H3+pEXFWE5oI4PPGe2HGrJzqwn+rdiQJLxy1hO0a3zSeQKkoWYn
 PFEY6mRh4Wt/HZb9gZJ0ygigs4kOw0pZBjGZRnXf8t7gdzrFDfZzYuan6Z5siWfWRu5uiNxp4CE
 4t/Bud5pTgKejn0fPhhTjVUx0w34hDfxQflAqFezrOxDWiIRIP2LboCxU6hEn1YNRrdZ4NU9x+f
 Unh73Gf51vMg1/pkgLFBoIVyeQNXnOI//b3zxnUBRGdh3V2jol7naDnyQEuWBghz7yDvzVuQfuL
 lX1hume+cXXrBb5+G79DgFvHa5H5RVBkLuwkp6O0lJiSU3/wA4=
X-Received: by 2002:a05:6830:dc7:b0:7d1:a028:4464 with SMTP id
 46e09a7af769-7d4d0c6d654mr4631766a34.36.1771255972648; 
 Mon, 16 Feb 2026 07:32:52 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e0386sm12976246a34.13.2026.02.16.07.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 07:32:52 -0800 (PST)
Date: Mon, 16 Feb 2026 09:32:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@amd.com,
 John Toomey <john.toomey@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [RFC PATCH] cmd: part: add dupcheck command to detect duplicate
 PARTUUIDs
Message-ID: <20260216153249.GW2747538@bill-the-cat>
References: <20260215131115.3352282-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p3qZUc2El1VWrNmh"
Content-Disposition: inline
In-Reply-To: <20260215131115.3352282-1-padmarao.begari@amd.com>
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


--p3qZUc2El1VWrNmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2026 at 06:40:47PM +0530, Padmarao Begari wrote:

> Add a 'part dupcheck' subcommand (gated by CONFIG_PARTITION_UUIDS)
> that scans all block devices for duplicate partition UUIDs. This
> helps detect situations where the same disk image has been flashed
> to multiple boot devices (e.g., USB stick and UFS), which can lead
> to unpredictable boot behavior when using PARTUUID-based root
> filesystem specifications. It iterates all block devices using
> blk_foreach_probe() and checks partition UUIDs via part_get_info().
>=20
> When duplicates are found, a warning is printed for each occurrence:
>=20
> Warning: duplicate PARTUUID 20c5fba5-0171-457f-b9cd-f5129cd07228
>   first seen on usb_mass_storage.lun0:3
>   also on ufs_scsi.id0lun0:3
>=20
> Signed-off-by: John Toomey <john.toomey@amd.com>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>  cmd/part.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 103 insertions(+), 1 deletion(-)

I see this as useful, but I think it needs to be its own Kconfig symbol.
This is going to be enabled on something like 1100 boards today, if only
gating on CONFIG_PARTITION_UUIDS. Thanks.

--=20
Tom

--p3qZUc2El1VWrNmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZM4oQAKCRAr4qD1Cr/k
CojTAP97pwmBkhM0bAEAczwweDIGCApUknf0UVHnCA0i6D4ctgD+K3kzleBcoIYv
49X6Q82WJ9SS/mJxI28HdUBWeU2x7QA=
=V7u5
-----END PGP SIGNATURE-----

--p3qZUc2El1VWrNmh--
