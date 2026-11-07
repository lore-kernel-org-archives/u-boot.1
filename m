Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672D606A32D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dimPqB+W;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FOpoPb9X
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BAF960730;
	Sat,  7 Nov 2026 14:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WhDoaX3t7BZH; Sat,  7 Nov 2026 14:48:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C4D7460740
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062905;
	b=C5UeXO3dEHa7HOQDLM5uKtJQhifdPCk4g6r9gv7i0VctS/G4zYIQ9NIFXJ5JH64ivrP3
	 nsuDStVSIT8HsijCjmD+mK9WBAo+EeiLmwNckv+0ftkia+yKamxai7CpANTOtfWgDlr/z
	 REdIw+W5Pmxu2YfR9x48Pid4Hfk0ifnt5HJeTNJ4lOKqmli4tf55VxzTSfJ1j40i7EPbZ
	 d+jLIAtwuqB28s9zE/l3YqLq8enmG9K6w0V/M0W7O+h5dmnIseC7V1CfsT9YB9OJSOjK4
	 r+xd08ArCUO7llsPVHA4ilDKKRU6rtRwK/jO1x9qehEB6RVwSYrzln5kVGFn7Mnu6Cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lHy/Q19uM7fTzT2LCTRDEmRb/6yaZsTv3rKrW8CA2d4=;
	b=iYKOl7YuHVRoTRiqffSKrK+nr2A3MvVw12JGVa/IEOB4Qfi0CWZr2kLCkDYt0YgjHnE4
	 +hzrPJV9hGUuO+gxYwkZXLRUUrf1S+j1JS+emOt6PF8mrp5fpyEUSQDPxb7U8GdCARjt8
	 kPeFwwJKYcY1n3lGkNzh5frA9shGYwnSy+7jESL+NFUCOBDsSD4UVkbRkHMVNcrybM9w+
	 H6ZFyy/hjB/yDAHcaOj6Fn2Hw4YtITXmm/kFAQIqXICvR6Amu2hY9WgI18NllwOiKznZB
	 3l0HSiap43A/0IVf0mt/OKuP2UVCBwPdqI3Fw8XW4ELw5+xDYPBcLv0qP1X4e/0B8gQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062905;
	bh=lHy/Q19uM7fTzT2LCTRDEmRb/6yaZsTv3rKrW8CA2d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dimPqB+WiYpuuhbWKs/jP+WddCSbjRAuqff6R939KA/IAz81FvCdCyy6MYt7yToDj
	 4RxSpNStP2Gua4pQAeJv9lxsdbNyMZdK+hM+5HF5VNBho9I6JnniZ4N35J0nGzz/yX
	 0xtfFKZkCIzotUtnhj7Y9T0l2TTZBCS03M+zQH0+0/QhDAm5eJGM7iQnhUTbnRLxGi
	 xIqtJiM+6WhKQ/j3H34d53X80EBQs0wOip523qhgk9rzT2WgvKrhqCc/iEdsE6hIMV
	 MvvUwRC+kkDw2p0aYHj/eLH0Z9gZtCI8J/ieCkLxsif3IW4a8Ok5ySNETQ9PhoeECe
	 B39C3aHWMH6Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4D7460740;
	Sat,  7 Nov 2026 14:48:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D1B22FE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 336CF400E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:48:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pzkhFgK4asHM for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:48:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 884484009B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FOpoPb9X
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 884484009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:48:24 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7f84a55e31aso1095103a34.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794062903; x=1794667703;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lHy/Q19uM7fTzT2LCTRDEmRb/6yaZsTv3rKrW8CA2d4=;
 b=FOpoPb9XU31LrxzcAGPXwF3DoadcXF3hRNIA96dOJ1uus8rLAcnmhi9r66oJFUEm0J
 RAaMYM5hIe1mPw1Z7Ht2PvAi486yhSicLVyQORGbhg/yZI9w5dGCL8gK5IZQxkZEDez7
 BQZlgzNnZ9ChNNbBKSxx5qLU1lKhTz8EVd3lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062903; x=1794667703;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lHy/Q19uM7fTzT2LCTRDEmRb/6yaZsTv3rKrW8CA2d4=;
 b=rA82ZC1fYTW7aL+OzBYe6ivJ22/c+J/jG1VHA/KcNUV9Yk6QeWvhK1n4J3f5R51b5o
 EJ+nBX9YolAhHPz3Ql5Ofx/uFEH4hp5jtzWRKHGIktu+DIectPlDGEbnb/hh9vLE4xyN
 oFPA8roYbkuGvREYKHoA+EDhzHWkFiWmHGLBv/gHoIn36kxevgw8Y1W/OySN7ffQBNdV
 Gfurjz+stTu7AQYX1novLhiGc2lQNOMJjvAAFC8l2Th7UsZnWDkcoZ1NntPalbwyTxoK
 rDRgKX5K3SmHVWEqG5+BEPIpsB4pCbHU3e9W93U5lgxG/vtoS+HmpFDPfri2jZarICNj
 ENJA==
X-Gm-Message-State: APuU4Z+iCgck99fxDJP4oM9xdTmFR9o9nD5zmxGgoXaTdc9BLuK2KapB
 7S9VvnTANyWMjO1qU792bAFwoQiOwNbf4U9dafJJAifEUdRZhbzoG68hVJyS8FqAwo4=
X-Gm-Gg: AYBFou3XOZZ1aG/znPFAbYGDLEw4Mxk3oPzS1+oz860faJ6o5AqGW7ye2vhYGa3+WKs
 TFxckXwAdfpORxPmqA2iOSOxa22m+bsp07ZbbCLbLSLRzxFwoYDvVCqsq6IoogbFNcO/QRUQXKt
 7RmeUXq4l0FWDgZQKkgREZ0eB9khTBHtjVWCryPiMKC2XfNM9+tzq81CeHXOMLrP24GfLAhZHrK
 SD/F99TnFpnaX7qBntOabNVWFLUvldSsysw+ozQGC0xVhhYTUDC/kbBFompxloNr8dFE87r0aE0
 ZB5KuTy0RAFgNizI35zueqlNx2/nGoXv3mS0LnuDw53ran5bMpHOJMKkdsdFZz3LjcFn9Tbfn4m
 /0c/NkKFV3tvDSFaOorzN3udr/pjwktZySRFsjkkJ8k+GqflIl6rWGqS68MZdRBzBvV9mkeVFQm
 3yMM/R1mswCMAPlZ342RTwY8luZ55OKjzoaFLlG26oQLiq3XP1ayrGWM0W7nTjTGWoKwWLpRh2p
 VdKlhexea0gDO1kpL+ttW2vn2RUgniYsCsTbrTz9Bk4NLqwlbQSYeP3TMacWyT9RXwujELYzgaR
 QvKlQtl2rNocEzI15XRVhKi+AoRjkAt632EgvEq5VItut+ZwxM8mn3hsVTEgSaMMV1gVeLGt4ft
 +XUsico7EBuR3XyXNK3sFXx3l6Ae1oG9havsdOqXBEuEkq2pTidQlbDirk+gjd1J0MXVz1aj+0f
 9626HWINY0OtvDVfcEFczpfqSlnN2mXA==
X-Received: by 2002:a05:6830:2b20:b0:845:8d86:9f7a with SMTP id
 46e09a7af769-85f1cf0d3femr5043062a34.10.1794062903140; 
 Sat, 07 Nov 2026 06:48:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1dd1a172sm4665085a34.15.2026.11.07.06.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:48:22 -0800 (PST)
Date: Sat, 7 Nov 2026 08:48:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.u-boot-project.org, Raymond Mao <raymondmaoca@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: Re: [PATCH] test: lib: ecdsa: Do not report skipped hash algorithms
 as failures 
Message-ID: <20261107144820.GH3741582@bill-the-cat>
References: <x3.ZqLG.6UGBtjSAs8i.1gxhi5@seznam.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t8TrioFFCVoTSvd8"
Content-Disposition: inline
In-Reply-To: <x3.ZqLG.6UGBtjSAs8i.1gxhi5@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--t8TrioFFCVoTSvd8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 07, 2026 at 06:45:41AM +0100, Tomas Paukrt wrote:

> The test vectors using a hash algorithm which is not enabled are
> meant to be skipped, but ut_reportf() reports a test failure, so
> lib_ecdsa fails e.g. on sandbox built without SHA1.
>=20
> Print the message with printf() instead, so that only real
> verification failures are reported.
>=20
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--t8TrioFFCVoTSvd8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau86MwAKCRAr4qD1Cr/k
ChVyAQDL5b2KRSTZgw9aWmxw+waeLisStgBnYNPqZBE+cPmOagEAgO/N2m/aHVj7
o+4Y4iA1daSphW9w7JVxP712+wGrKQE=
=lUac
-----END PGP SIGNATURE-----

--t8TrioFFCVoTSvd8--
