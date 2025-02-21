Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D69BC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 21:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E1D98056B;
	Fri, 21 Feb 2025 22:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mu2/SXqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DBE08056B; Fri, 21 Feb 2025 22:20:17 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD95800C1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 22:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fcc940bb14so3968873a91.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 13:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740172812; x=1740777612; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wH/YgldVKY0vwtaRsnJW1UWyL6nIi6WU5z+/gMlDhmo=;
 b=mu2/SXqOfbuFTxZIZoP7iNaKxO8cjup5jZqJPNBacZ97goQq/Oxa59rL7lg3kJjDlk
 x60Js+pZd8hcU4JrNnhQaLF01ZDFaM9qeSA+ES3oYG/HrOuPUp1eBPFDJDf0RERpZiGT
 hH8WsN+86+puDezyw+l67ZWQJVJu+jyZbkASY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740172812; x=1740777612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wH/YgldVKY0vwtaRsnJW1UWyL6nIi6WU5z+/gMlDhmo=;
 b=IydAQWMIhcqcwaanEAboq2FiqMUKY873SrAMFKD3EHDFhNkE/5nl5wFjMyiNZ8z650
 viL4DvqfVZIPCGNtdN1OVGxmQXhR5QgIpFZJKcK+VIjixrfyadevZ3scoIyzb6tqwETg
 Ozut3sl5POVy3IYFlIDkkHDL2RRcWxk3B+9H3xGiwf80TexuSv1xE5rgawr+3ZXU/5zs
 g7hzq2gpa+1spiQ68TuaVEa1YRupXb+b/BRf7M8JZwbZRfYX+sDAJlfL+ppF4w1K8G/c
 nJPZLmebIq7YXWtYINk1TgOEX7LFXkiioOMOOjbyD4PHGycV8BdAkWQ2o9HCmRe7589X
 W28g==
X-Gm-Message-State: AOJu0YxQPz8ZoVZSIU14VxyWiY7wS5Bye/LbmEKCI7ww6RgPh1CGyArR
 2FMJ3drE6E2RZ9EYNVx3x1XAq4P8fJP0Lbo8+5Iz5r2COI7LO6WuRBqcA2P7dU0=
X-Gm-Gg: ASbGncubP4Owe5c8fD/nwFeAL29zBmu447QTr1Jdr1aZNLYfvHAP0Yu+XaZTTkNlXqk
 4Ce1CO0+w7bE3c3ufkSgZ1kfJw4uxK3fLWq3WvuNhU8s5epvHdmgcg9WYZlYF9iPgpI0bxGQTb5
 lEaCoVADg8eHBJQULFNX2vnjTlaTFIZYPh2QTnn85I4bOGQ3MiCR77VOL1k31K3FCuojLfDNZ+b
 x0WlyVRstTRUBLR8JC2dxkntLTKzBFEb0eUi5pHjCHalxj91u9wSmRFhSccUedDJW3Vu1//h0ZI
 1QJBDAd0vciZwUVow6h95GBN
X-Google-Smtp-Source: AGHT+IEKapcQCL6H5bUEjRxRkEs1asKWB7qykrulDKkQ238pL+BkseYrqe7om1xUac5H6JT2+Loizw==
X-Received: by 2002:a17:90a:d44f:b0:2fa:226e:8491 with SMTP id
 98e67ed59e1d1-2fce78a0e55mr8315445a91.9.1740172811993; 
 Fri, 21 Feb 2025 13:20:11 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb02e387sm1886068a91.9.2025.02.21.13.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 13:20:11 -0800 (PST)
Date: Fri, 21 Feb 2025 15:20:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH 3/3] RFC: Add some network info for
 ellesmere lab
Message-ID: <20250221212008.GU1233568@bill-the-cat>
References: <20250221203243.672465-1-sjg@chromium.org>
 <20250221203243.672465-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KwIiXUWnb44NMrJd"
Content-Disposition: inline
In-Reply-To: <20250221203243.672465-3-sjg@chromium.org>
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


--KwIiXUWnb44NMrJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 01:32:42PM -0700, Simon Glass wrote:
> Provide network configuration so that some networking tests can be run
> on ellesmere.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  py/ellesmere/ellesmere_tftp.py                | 32 ++++++++++++++++

Erm, can't you just use py/travis-ci/travis_tftp.py as-is? And yes, we
should rename "travis" out of files/variables since it's been forever
and a half since we used travis-ci.org.

--=20
Tom

--KwIiXUWnb44NMrJd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme47ggACgkQFHw5/5Y0
tywYBQwAuj5YGZhnnTURzmQLjDPv2og6NVDjMPM0sNAeQsRXxBVK5MDqalQ60bN5
I4HgM4Dp3FKDbkHiGar8vBCOEA+oAFj5YCYYEdOjHSCV4b8P7r15EAaQG3+Q+ZcW
rE3+rSUPKLMRS5bqS31Td0dFU9FSFLbYgRmkbyDLeMExaegHCygkHpBuJ62W+sPW
ffX8Zzedf30R9A5E0QnrmnGRFkHFuWUqjz5dxvciAWfUlPRYjZtzPzAQJ90PKpv+
TQVIH3B6oKvLruuf1KR47oUOTtnpgFqB+5n6pEU2jnsuZZOUhy12QvlPIij7Ry0L
hgToezoa4mFGdXE/QFEkdK2uSqHtF+ysS50ovcukuSatcNYbnso5Rq7eLhm048GD
86to+qnZFhkDp9Sd2dhoY7aSOr3h6cocpUvMUoSRRLXWnZkxHKL5Ly3rJcVEvU+c
ZlMo5H60amTNMcGbL5mru6Y9RySDQC1Ig4m52e2fOHrd577nT6zJrQIkmh5+tuFT
V/prilSY
=sauZ
-----END PGP SIGNATURE-----

--KwIiXUWnb44NMrJd--
