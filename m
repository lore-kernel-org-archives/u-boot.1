Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B70D597A4
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 21:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F117C894A0;
	Tue, 12 Nov 2024 22:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PPtSI6bo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BEEA894A3; Tue, 12 Nov 2024 22:12:07 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFDB28947C
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 22:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b14077ec5aso8632685a.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 13:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731445923; x=1732050723; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RvQyylS8ZG/TRGmrQKgQ5B0mKol1zkxVHRmDj2wJGSk=;
 b=PPtSI6boRZIZ1z35XR/Ly0P5pVQ/b7EuNKXfEQy1wdQf62x1jYA5blzWZCiyI41sYs
 qPKlWy55EKxyyGXU6FDqllveEHZ99U2OuoLTMXvh94NLtB31+TLTNnm0iw9q9WlEU7aV
 Yb1dbzVApF8L7f1aIMah4cqSYRG3+xvb+YLvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731445923; x=1732050723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvQyylS8ZG/TRGmrQKgQ5B0mKol1zkxVHRmDj2wJGSk=;
 b=lJsJSVcnSaTZlN1RuYWwD75B9SQjVknnbpnFYRclPqM9vi3r8Jk+ug1tK75ormQ60c
 abA1AKjr0cm2y2e20HcYEiyysG5cFtK2j0X4qV/yU5lh8Nzt/lIDFJGc5s+ns3Xfv8gH
 oTyJjv9gLk0gJ2CnZwNjuNOJOV+1o63wwPwzf6tXDS0MGNcqMsJ9IlPuL8+cGfhe6q+J
 /trykynmFTWdwjuwIvRTXivQ4l+vDa7qCBBEIrkKM/qOukzHUK/Pod/++UlcTb4L/bfa
 grUdMIiFgXkW0WaxhDEkFR9mMD/MlxIFjoNz5Wy4PJH/BvVLbNUAtTYi7fIPCQHqdVJW
 lo6w==
X-Gm-Message-State: AOJu0YzYraCSTTWMvFWrX+06dRRwuPJ9gc9CpI6IKJCVW57PpqKhVLck
 /5gRz8EBF4A8gRCGhjhlvyOazdFgN4BhBSnITMlzJNoU2tOOyqO4Q+QO1Eq44q4=
X-Google-Smtp-Source: AGHT+IHmDJohccLSHglnMm+FTLbLoTbFP7Qo5QtEbNMpTQR944qL0tuEF9lJTNtoZq+YrM8Ilq8Phw==
X-Received: by 2002:a05:620a:424d:b0:7b1:ab32:b71e with SMTP id
 af79cd13be357-7b3327bd559mr2609209585a.0.1731445923404; 
 Tue, 12 Nov 2024 13:12:03 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32acdee2bsm630223385a.104.2024.11.12.13.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 13:12:02 -0800 (PST)
Date: Tue, 12 Nov 2024 15:11:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] Revert "efi_memory: do not add U-Boot memory to the
 memory map"
Message-ID: <20241112211158.GY3600562@bill-the-cat>
References: <20241112131830.576864-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rbI3dz91BLFG5fWM"
Content-Disposition: inline
In-Reply-To: <20241112131830.576864-1-sjg@chromium.org>
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


--rbI3dz91BLFG5fWM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 06:18:30AM -0700, Simon Glass wrote:

> A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted in this
> patch. I am not sure how to investigate it.
>=20
> The boot hangs at some point during booting of the install image, before
> the Ubuntu logo appears.
>=20
> I will sent a series with a script showing how it is run.
>=20
> This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

You forgot to prefix this with "RFC" or "DEBUG" as we're not going to
revert these changes, but we'll figure out why x86 doesn't behave like
arm and riscv do and then Fixes the resulting commit. Thanks.

--=20
Tom

--rbI3dz91BLFG5fWM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmczxJsACgkQFHw5/5Y0
tyynqwv+OjE1vDsIr1KGFS2rTKqa0v+LAuQoUJt/ea1Q5POhF3djTxHLV/Zq9ET/
dskvjHInx+riJfSUfhrz4+el6Yi9YeOwLgNYqCkxUxC6J7ZihzlfotqbiqKi/ICa
DOgwznzwlCCNP9HziiI1eUAAbXh1Q5obZE0DLEY4xIgNN3a0I9yX7ivhRWBsEyyy
11uJKu/Hzg3AxgI5cTT0rq9AbcLzCjIvtmy3Uimmn/Tp32BHjcfWF2qons8MvUPb
RQK5D3hGHMGMYI1H5RHLmqzg/07TWaP58auxQFmXar2g/4LA5TyoWKxJOkfCBrRT
u066u5OcXiGN32B4EpTrNxi3VUs3bw6zjfFjIzXDX3M9tHxNCTeddDz9+KVcrIOE
E5BfH9oYtWgHgpVF1j8E6jhErgeJVQKanJZDCa5mxFhnuV+Vgi0guDXAo4kREk66
sYIE/62tH662XnBqMINojPcM6UaCmG38a3+9ikHQY4o75GfUWVX2FNdyBji3obzz
2r7ur35t
=JmQN
-----END PGP SIGNATURE-----

--rbI3dz91BLFG5fWM--
