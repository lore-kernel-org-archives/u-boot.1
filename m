Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8010C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 17:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5172282B9C;
	Fri, 18 Apr 2025 19:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ll+gJm8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F026B83290; Fri, 18 Apr 2025 19:54:26 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF7C982B7C
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 19:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6042c04fd18so990005eaf.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744998863; x=1745603663; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2SFQ10pQ7rA6ljepvASdpsmOU/T7gUFwlbA+yawhsKw=;
 b=ll+gJm8I4jng2Wp+wejYT3x3/1COwiKe6S9pGvslZTCDcmjjoINXzOqmARTu0r5NvN
 vOcczrg05OoZB0efXnPrSRTRQJpbnyig00U40dHjP/kD1ywwRzy7Pcq05kxb+Pl1ENo4
 tdnvwNOYM7hqVl3IJJ7UXGvukLNq2qBCm+U64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744998863; x=1745603663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SFQ10pQ7rA6ljepvASdpsmOU/T7gUFwlbA+yawhsKw=;
 b=YGDJiGdP+GMs39dENw+IM+ftZV/MJQ5tuTVRXc1GgK4oVvHCVd/u3ddEdtdHB9r1DG
 RADcisCKVzqTEEsN9KJfmMmZrgP5N2SZjCgkqS2TjSZDTlkxGWJvxLLH76XOM1vH9JaL
 3eSQpWxRvV9Fyof7oL+TR3z+LeE7OpFvNxwEfl9+YoVfN9v7UugD7ymkAkhzcUukZ3l2
 Zuhn2d3VsWFiJ/T+FsSp821656trpHe10JZ6sCTilKHJHveWFspnpvcRnUnCpPA2RHcW
 VbDyhAB/zVb30a8qFaPp3GOYt+fOxIqtgQk7EQuXw6P3N4SDfiEf9d8EH07x2DBgR0Ot
 s+RQ==
X-Gm-Message-State: AOJu0YzcISJueVYur+4PtQ/5sOfVbOcwbb63U8K5I3vCFZBdW87Jd7Ke
 QuUk2DGMEJWUEY/dRf+fFy06TVsYto1DG8fg97y3xJFxQffMNiD5ZIjHDq00p0o=
X-Gm-Gg: ASbGncue+pW0hCxOBvFAGOfyZ928tBIumD82ztUiJw1rYcp3RdsgiAte4Aq5M/H2p5q
 WsqhCPi8nus9sS1bwCdspd0XV0xVr2pIKxvvwq0PslGaUBvUHW7ZBxyUvOc07p1wZUGi/hMRNDB
 YWlmO7JZS5Uc0cNtgY7cSCdN48cFch4SEeTtyijcKoB8rzCeAjFoqN4Q4DDpqx22gBS0eMEnPYf
 Zb3Z+u7mB/VrsA1YYUHsdkPnjI+/BG/LlOahHPcif7Kq7gFRcBaEVWvhE6VJdTWEot3ZIaLe9Tb
 M/pwNywU/TH1J5u+6PbVGYbY5FTw7LFwlljeNcbRS4OErb1FKPlA9VsjCenHT2FQx0IfhRwmmwT
 Ftw==
X-Google-Smtp-Source: AGHT+IHE95jXL46L4CwG9EtdqQxJT0UMU+57JNCmMo8sz44gNc3/P5FYtyeGSD/3uULPFnwN5KH+QA==
X-Received: by 2002:a05:6808:8314:b0:3f6:65fe:2672 with SMTP id
 5614622812f47-401c092fff7mr1761563b6e.2.1744998863510; 
 Fri, 18 Apr 2025 10:54:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401bf081e3csm412075b6e.32.2025.04.18.10.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 10:54:22 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:54:20 -0600
From: Tom Rini <trini@konsulko.com>
To: ant.v.moryakov@gmail.com
Cc: u-boot@lists.denx.de, Maks Mishin <maks.mishinFZ@gmail.com>
Subject: Re: [PATCH] tools: Fix memory and file descriptor leaks in
 read_full_file()
Message-ID: <20250418175420.GR5495@bill-the-cat>
References: <20250418171947.172163-1-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OhxFEv5Td/VNyKl1"
Content-Disposition: inline
In-Reply-To: <20250418171947.172163-1-ant.v.moryakov@gmail.com>
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


--OhxFEv5Td/VNyKl1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 08:19:47PM +0300, ant.v.moryakov@gmail.com wrote:

> From: Maks Mishin <maks.mishinFZ@gmail.com>
>=20
> Fixes potential memory and file descriptor leaks in the read_full_file()
> function. If malloc succeeds but read() fails, the buffer was not freed,
> and the file descriptor was not closed. This patch ensures both resources
> are properly released using a common exit point.
>=20
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> ---
>  tools/zynqmpbif.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Please note that this patch is malformed:
patch: **** malformed patch at line 125: @@ -214,24 +215,29 @@ static char =
*read_full_file(const char *filename, size_t *size)
as it looks like you're hand-editing the patches.

--=20
Tom

--OhxFEv5Td/VNyKl1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgCkcAACgkQFHw5/5Y0
tyzhgAwAg3yDYuyAzwGmIBmWBVE4tAqsqxTKMu1JOxjXJHpNOd4mxHtUo787nF84
NtB8Uj77ToMLI48xWoxGg1YsjCf/7K2FpWINDcsA1OSvGxyTI/rLcvw/7kZkqJiV
nuitH75qoqnpIh8i0UPG9HD/oo3n09qQ67NgAhQkFQ46zjfwoHgchSvlhmUqU8QB
zymSCC6pNWRSHHwVBXLtPRZEfo0wAYQRiXWgrEUAiMxk8w1p9Kojij0b5rT1N9es
GROkuN6pRQ9fPeoZfoT6jeWQ3EV83zM0CZwqp6+DR4NwmYRpuyuOfeYbL8rQ5jNT
DNzuFa4qQFnzVDLH0xnZhKGCLzVw11fWJibfaHgCeSwxUbCbOGZpVTNBFKUmjrFB
zpYvGNl4fwsbtif/p7/Z/ee5MMIsv64rN2zllYJj7BZPWoUlmKO68CQtg09dLK/1
yIMc1sHYPg2GfD3syspVImZtUHwnIlpcmXrvgLqIRs4rvxdjtAWXf0FjMQNb7IQo
07z9PxwC
=at48
-----END PGP SIGNATURE-----

--OhxFEv5Td/VNyKl1--
