Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA93C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 16:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A653D82103;
	Mon, 28 Apr 2025 18:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OfykYK6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A386A8211F; Mon, 28 Apr 2025 18:10:57 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B3208056A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 18:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3f9832f798aso3972107b6e.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745856654; x=1746461454; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wru9iJyct6SD4osnyYsA49r/XtpXRrcrSo4nFe61tRg=;
 b=OfykYK6tTnm/gN8mPhr+sK6be905sUfRDzSVdJYyfRbsxYjy9Sc1LyqRiXA68eVHwD
 6jyQQOJnw8RwMXL5q95+yr5/Kae9apMjzkO/Sf/c454qIbZNuoQUupL+BWCnTsWlzEFp
 XyrCI2Nkga9V7YxVdonkr6w7kCRshCH6zieJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856654; x=1746461454;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wru9iJyct6SD4osnyYsA49r/XtpXRrcrSo4nFe61tRg=;
 b=p42cXmm98S4ZnpA1ZH+6QR+yMocqUR4dsXEkDAT0U1qjjhPR5B0ltldYrhev+FgyP1
 zqZT50EWGR7ygaz0j5faChqw8dkVt38biUoGL5HRWDLPJj/wFKazZbRj88tDXLkIgZ8A
 KYOx0VLpKMe1zGLTQmE6vuk1ASwFqWL2r7vQqqfNGIduubUmcVamvo7Z5pGls2Chw0OQ
 1K4Mm0dmBkFCZ3+pOCBxp7VUOUB8Dv0rLRuE1Wnndz12FkCF6MfYKKhFLUuYujpRUW4h
 pi3eII+IrHV08Yi0fqdp8mZLLCGFjKkhC8Fy/o3hk6QSCfeV0foy9qwU0viqwxmDVViC
 7CDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULkgNaQzGmHMzwQKfp6L2tYk4SE52qQTx/CjPRgFgwC8+FxLsljQRDZKI5GXcHPKmQlR2EXN4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzq32r4SoqzDnADRGhoooY8LMDPjf9omwxQrew4+FPfzmtCSxx+
 AiaM5tuQo2nqUbC3qoLjVkuloPtfA56nxj0ALfdLSLB+PaLENDYpJ8Nz7i+X8y4=
X-Gm-Gg: ASbGncvAsvTCKDfNwh4P8u69bEG4xHu8G2x8By2X4WyyKmxdld27aHFnstiay1LkfCv
 +23JhABcvOf38o2UArG1/OVQgPIg3UGVrhwhMwHDrBXvxEFNvYIFfzaUIH4vPURuL1CuSfdAYAZ
 +3qjJT2bVKWydGcJU4W4GX6wyKEyQbjw4MbWe4qcq6WZ53z4ZfXQkFO6mFA71Z6Cgy16YJf5ayP
 ZDrzxAdBZDyKlPl5LWCZBjwZ89RqIJTrEKH8iD3ZHfQoE9jFEwa0EM5MpCfg6ZI5ZvxIkWtYsiX
 zNLb0xj5TYz20Z4bypP/irYt9vxmFiKA9MKUVhcHBh7cmVMVjq9T0DaTGKkJH8l/J1upGXvbvsa
 OeYweyat6tdrD
X-Google-Smtp-Source: AGHT+IGSSvI7ivCwxt9t5hr5PxVJ/QRp2mQFgnCpCvui76Yo/m7fkzB4kMUjnRRmTSbnqRbHFI6Xpw==
X-Received: by 2002:a05:6808:6f8e:b0:402:292:4417 with SMTP id
 5614622812f47-40202924462mr3849584b6e.1.1745856654145; 
 Mon, 28 Apr 2025 09:10:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401ec8e4f55sm2076126b6e.28.2025.04.28.09.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 09:10:53 -0700 (PDT)
Date: Mon, 28 Apr 2025 10:10:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: ggiordano@phytec.com, w.egorov@phytec.de, u-boot@lists.denx.de,
 joe.hershberger@ni.com, bb@ti.com, nmorrisson@phytec.com,
 upstream@lists.phytec.de
Subject: Re: [PATCH 3/3] board: phytec: phycore_am62ax: Update Environment
Message-ID: <20250428161051.GC5495@bill-the-cat>
References: <20250428144904.1058574-1-d.schultz@phytec.de>
 <20250428144904.1058574-3-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sebV5tBWghNMGYmy"
Content-Disposition: inline
In-Reply-To: <20250428144904.1058574-3-d.schultz@phytec.de>
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


--sebV5tBWghNMGYmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 07:49:04AM -0700, Daniel Schultz wrote:

> Add fit_addr_r to the environment to allow us to boot from a FIT image.
>=20
> Increase the maximum Image size from 23 MB to 26 MB by moving the
> initramfs start address up. This gives us a bigger ranger to
> provide kernel images which are not stripped down too much.
>=20
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>  board/phytec/phycore_am62ax/phycore_am62ax.env | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

What is the minimum memory configuration you have to work with here?
That's still a very small window unless you're shipping modules with
512MiB or so.

--=20
Tom

--sebV5tBWghNMGYmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgPqH8ACgkQFHw5/5Y0
tyyfggv+IsQNGh0qpgSSRo5ha8BCH8YgXtCiAN4AJvNdEA7gTU0xQ7bRMBsV1HpV
Hy9ahix+K0wweVz2hLBc/sVlPiYQlcNSKsy2PvDoxfCisZgX2y8Te6mJ9h2R2nxM
0EC4IKqCQF6gENk8071Oh/ImZJtyhXfXGRx4E40utrwM2jVPhFcXSMJpV7Z+ztF+
hlE2ZU3p6rgYykm83F52fVMLakuOhPxZnUvnukT1iAoxlkdnjRDYk16Fp/QI01UB
5ahu4notdN+NqCfxJakW5Vu9MDL1kI0vBWzn2/gBwWtDI0xpWvAyLbVUPqnxyYo5
BhjlvPUXV19QS5K/jfO49TOXFGM+tkMTPFdqQr9jyuuDQvLy8YJIiOZTfTQt8NIM
Fq7U0wlhmtiVeFgUo/MJ3GTW3Z8VgP2fAnLCmYkRZMWuxASHk40mCow3iHBkQBhQ
Do3b6pUMLB3p9/9JUZkRz0091llfv2L3ghFA7rFEBGjR8lIUwjImmrc2mEUeh1eo
FYc13abC
=Ml1X
-----END PGP SIGNATURE-----

--sebV5tBWghNMGYmy--
