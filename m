Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB65BC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 22:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A918823A;
	Sat,  4 May 2024 00:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hq0SP+sD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F0B788251; Sat,  4 May 2024 00:21:16 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 836768820C
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 00:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78edc3e80e6so6295285a.2
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 15:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714774873; x=1715379673; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JITD0uU9Drmtif2fyt0Adk1i/Nloo05FbzghcbzL/Ys=;
 b=hq0SP+sD75M6hPj4y4rOVI1UkSedpHV0MgdSktpmNumVgzNKY2c9/hDoNNYE+wcE7/
 RgnqXZlDmrFVSlgA68mAKs3xkZoJp2JzG+jZGpcKLcCPcL1Bx82v9QWsmrGCQFGtbHPu
 FjBFhKStNd0kmkWKqx6T1HEfmpnHpr40M/D9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774873; x=1715379673;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JITD0uU9Drmtif2fyt0Adk1i/Nloo05FbzghcbzL/Ys=;
 b=dxlSaBEeU3pLG+rsskTGOunjh03X5E7xBorxvjPi2LyE499OXZlW2K+6hwWC0WgxCn
 srCL3XJbj/xvD8S0GSBtkT5QcWkOS7IJZb5wpx6MuUctNldYAyu1bH0d6Etad6Smk4nH
 hBTCJ+47rSymm5P2rEyrhFJKwxQplHJzJR2i68T+/99QvkereeXBUo0oztlOnc6P4+Te
 PJnna7rUijlIZrWAhCwgmPo52crWtShqd2rx9GkZT9mSv2Wh47rKMpBc7Andg/5VjTV2
 JzQGDb61myLLme6idzOsEl/J9xHqff4KxGFKERES8ik25qfGLTLd7QamXXhaI4Tb/zL2
 ihxw==
X-Gm-Message-State: AOJu0Yw7N+E2j0HQVOMAbaqplwfVzK00+PPmy64kHEU0rbj0AGozBIJq
 /X/h35yQ/87r3wsWZugV6XTVCOAiLf//TQmF5TkfcExATdgGMvJsDGlxehPBHW6lyyr3+8gdOwh
 2IpQ=
X-Google-Smtp-Source: AGHT+IFAsjES5lgbP8bf7wKuOe9hEolRwdAh1gjv+u908Q4uK1XSupB4tQS0itbWDGUjwYv+0rfAcw==
X-Received: by 2002:a05:6214:f0b:b0:6a0:ce2b:c813 with SMTP id
 gw11-20020a0562140f0b00b006a0ce2bc813mr4758437qvb.3.1714774873308; 
 Fri, 03 May 2024 15:21:13 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm1547396qvq.28.2024.05.03.15.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:21:12 -0700 (PDT)
Date: Fri, 3 May 2024 16:21:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: gpt: initialize partition table
Message-ID: <20240503222110.GE2568172@bill-the-cat>
References: <20240422181733.179881-1-kishan.dudhatra@siliconsignals.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IStPb6PEPWtRkwXH"
Content-Disposition: inline
In-Reply-To: <20240422181733.179881-1-kishan.dudhatra@siliconsignals.io>
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


--IStPb6PEPWtRkwXH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:47:33PM +0530, Kishan Dudhatra wrote:

> Change in v2:
> 	- Fix applies to all block devices, not just MMC.
>=20
> If partition init is not completed within the gpt write,
> the gpt partition list will not be updated.
>=20
> Signed-off-by: Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>
>=20
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index d7e96529a6..7aaf1889a5 100644

Applied to u-boot/master, thanks!

--=20
Tom

--IStPb6PEPWtRkwXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1Y1YACgkQFHw5/5Y0
tywf0Av9GlSKgG9uUZhmbAJCGPYa0sr6miRu/ajovNCsWz5ZcTdHCWgJnJjJs98c
JpxJ+AO1ik8X7sanAGOVTHC1PSpLv0hM/xcdBCYajOhpuZdqq+Eanj0M40DH6w6t
2dTMJFBUjMexU2lXXXMm2bti+C2utFzxoxCvqMQBWysUdf/2WRe1Hb9pOkekRfrR
6EqoXkr3UQGfq+5f0G7LVAUatto7VTmP0Z2giA9PUgldMZkRbYP30IZEQ7Q+l6dT
7lLNTgGHQcdgpw947XajFAWi+FlV1bRiOpnlx1EifHFZHzG3/eFObCxgj6PBxdm6
Dy2nyUNzA94L0xNbNzTduphfx8fk+sGYdljUddGomGh2aeNAt8n70uyJBSTtj7/0
IbP03FTi3kYzRrFcgul672pNwIuuSwk/Ei3/PNnIMYBkHDkdrW3SIFcMv2JHlD0p
gONtZCYwUxbiS6gnOHKX/Xt+g0739THf3IIjhtDkP+Xvfzfn1DBauhZnaTXHJe94
jRjs1jFG
=dMe7
-----END PGP SIGNATURE-----

--IStPb6PEPWtRkwXH--
