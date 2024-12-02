Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B656DE69E95
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 21:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9CC2894B8;
	Mon,  2 Dec 2024 22:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="flqPJI9U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CFE9894F4; Mon,  2 Dec 2024 22:59:31 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27A4894B7
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 22:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ea427001c5so2597116b6e.3
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 13:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733176767; x=1733781567; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AlSS5n4GlxgbZWUsXsQG1aGflYq3l8SmckozcowTQXY=;
 b=flqPJI9UgPLMblDhGXKcE2NjGrUoIa0vLxy+EJDrbmEpnUeqjuQBP415q8NVvhfONZ
 m6D2hUAISn18UaPwJar9ysZFebUSrBd+ib6H0D0bEsodM9tXbaMvTSJStnWxsbhrBdoP
 5kr3RRaKaDxkndJQxmQd4TFzrPg31vEJQSJT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733176767; x=1733781567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlSS5n4GlxgbZWUsXsQG1aGflYq3l8SmckozcowTQXY=;
 b=KARzN/89gRi2U1vXAEMxXFxUL/r9mxQV7qSLvddQU8vPtUOlYaI5Zwg9LFmr5XCmoz
 qYi4snJYpXGrN1LeYKUrSpujmIv9X1bEsNoxxAlYLNg8ANQ4HvJpCKS8p0OmQqbRR59w
 dsEFCF8BbpfrsyeA0hBlxay5PJzEBNs6lOnw9kT3HkZ9dmYpxzX1BvvgLQSDwLrwzQUi
 wuYjK7QTFKLzl84OwSXiH/mE60MKVsuWBpX/DnV4cS7WdKDRZzcMOlZYmAQNlw53s2pd
 zekGI2ugFT0igM8XoCh10y9sTmp3jeOVZNYi8xtctHHiylw6NfvBPHmY/26mr3911IOl
 +LpA==
X-Gm-Message-State: AOJu0YyUZSoH1OTIfX/xjUIW39YZ4K7nfP9WVpYzFL8EJp1L7OxlY292
 4KTF0/6YgxYOn0dtsTd1cZbn+4ENRsI6HOBpvF9Hg1nt6tF8pO3JV2i0K3Ybr5b3C6OrE7pOFlo
 dxNo=
X-Gm-Gg: ASbGncs5M+k3xB6tlqxfK2AxfL3zou5WNspYySEQW5wOi8YJeuGrsujPNv4SLVJijE3
 RQmrjkDsZiJDPRmMQiPHY4O34IZ1AF16eD4dW3p9s4AaGTB+5qTbfO/vLDHisXiHWNpEjagvzPK
 zhNuomItuq3k6LGwegblzOfSnB6cvp6EBeZ3xiMlwMNf8MHSXKknN4Q9nzJqTYU7ENA4+/1lV+l
 agTo57jpgbogTl6dhoVW7O1mCKZv8yRxn+9LchRdz3J1/2XNQ==
X-Google-Smtp-Source: AGHT+IGU70TX3HBWw37pqLUC/rLvugNTpynNS45kBxRHyjBML4qxThEeX+Li91JTQ3+XpM63hdkKzA==
X-Received: by 2002:a05:6808:158f:b0:3e6:19a9:4718 with SMTP id
 5614622812f47-3ea6dd9fecamr18780798b6e.40.1733176767470; 
 Mon, 02 Dec 2024 13:59:27 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d898045dcasm29598726d6.102.2024.12.02.13.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 13:59:26 -0800 (PST)
Date: Mon, 2 Dec 2024 15:59:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH v5 3/9] board_f: Correct stack reservation
Message-ID: <20241202215922.GI2457179@bill-the-cat>
References: <20241201152815.1668093-1-sjg@chromium.org>
 <20241201152815.1668093-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="441Bf20LNCT4wp5d"
Content-Disposition: inline
In-Reply-To: <20241201152815.1668093-4-sjg@chromium.org>
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


--441Bf20LNCT4wp5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2024 at 08:28:05AM -0700, Simon Glass wrote:

> The reserve_stack_aligned() function already ensures that the resulting
> address is aligned to a 16-byte boundary. The comment seems to suggest
> that 16 is passed reserve_stack_aligned() to make it aligned.
>=20
> Change the value to 0, since the stack can start at the current address,
> if it is suitably aligned already.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Er:
/*
 * reserve after start_addr_sp the requested size and make the stack pointer
 * 16-byte aligned, this alignment is needed for cast on the reserved memory
 * ref =3D x86_64 ABI: https://reviews.llvm.org/D30049: 16 bytes
 *     =3D ARMv8 Instruction Set Overview: quad word, 16 bytes
 */
static unsigned long reserve_stack_aligned(size_t size)
{
        return ALIGN_DOWN(gd->start_addr_sp - size, 16);
}

is what the code is today.

> ---
>=20
> (no changes since v1)
>=20
>  common/board_f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/common/board_f.c b/common/board_f.c
> index 98dc2591e1d..677e37d93c0 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -601,7 +601,7 @@ __weak int arch_reserve_stacks(void)
>  static int reserve_stacks(void)
>  {
>  	/* make stack pointer 16-byte aligned */
> -	gd->start_addr_sp =3D reserve_stack_aligned(16);
> +	gd->start_addr_sp =3D reserve_stack_aligned(0);
> =20
>  	/*
>  	 * let the architecture-specific code tailor gd->start_addr_sp and

And this is the last call to reserve_stack_aligned(). So, this is going
to save us between 16 and 0 bytes of memory. If we're going to make a
change here we need to comment in the code more what we're up to at this
point, and the commit message should be more authoritatively worded too.

--=20
Tom

--441Bf20LNCT4wp5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdOLa8ACgkQFHw5/5Y0
tywnWAv8CMlcMODovR9fVqHGq90HN1Xcqn9i80witxNPc6k+X7AkCfeUXjHNM79a
XxAhkj4iU0n2TBbddS/oI6RKmMEUFJwmp1R4ToCwvenyHHpf15+tRzBeseNMPVz0
Pq/zVxPPTmQHTobWBzbqKLVYk6MzobkR+AH5MyfEEXoUGcBQ2Ete3Yv/pH/lfrwQ
En4U9FANqPPU7MJI8dr8t6Yez1Z1s4WNQ64iB5vNxKjJqpwYdoAQ4OZ4xED008u2
5O3Y1/sHtn8fbEPTYBs/YlRc5QaJMPb81DYufZ1W2yzhlmCfPr01IUsJaJz4esAP
emgL1D1iyZ3QS3dT9BhYz/csX4YAcpZSV70/ZlF7kByxJcSJi8pO8R2gMl29b5qA
3KF15Oufi3fqI56xpCRzPUgzaaMPG+DTkUJVslYpIdtQ4waEhV1yfIYHPX1C1arK
ctX1C8k9BLmhWQQhcjEtYD4ETosDifztZgNSGJSkrClSSasTFlPRgO1jvm8kP9ml
k9c2FJVB
=MC47
-----END PGP SIGNATURE-----

--441Bf20LNCT4wp5d--
