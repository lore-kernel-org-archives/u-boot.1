Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688D0C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 18:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFF687514;
	Tue,  7 Nov 2023 19:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MPJhHJU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C992875A9; Tue,  7 Nov 2023 19:18:59 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2000B86ED6
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 19:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7789aed0e46so396468685a.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 10:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699381136; x=1699985936; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SXrOYHdkZ/0PpMlvuegmLJ7gEKBL36LJ41i29eyVB8M=;
 b=MPJhHJU/oLfyOGqSSLLlf6eSwqAX+cJNA29fw26yqvWI5M/+JGN3VdLsGp8WlmChnL
 A7jrZBsWC82oTjsEMhZgoI8SMoDj2u9Wqksm5MraPFrlMjNHY1AZQcbqz6MEIFnbkrXH
 5pI8MEpjvPYpjq7uf1nKIP+zz6g+qLLhzUhtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699381136; x=1699985936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXrOYHdkZ/0PpMlvuegmLJ7gEKBL36LJ41i29eyVB8M=;
 b=mbIvn/fsQt4RX5inPFImCd9XKBB1HDOyxxFtqFzFA7NwmVFYRkep73v3UyPT2+UjJj
 mcAauw9/x+6BEaqsEFt6N+KVARuK1WcrqbpQmL00v+Selc2ZdYvlfW9we92Iz8ERZRh9
 ozCh7IB5rBSi83W/CTB0i2cdzrgdnnqD1XXqQ6nauVsFXlDbfPZvLuifPif6VDMKItDg
 B0a6dt2svJIZilUDFKJq8geJkl4R4yPQ31/9O+jd7/X9YotPKt7V6dOlA7V2b80FZjgW
 lX5d3aPAYL8Ghni4HStyqmYl32btfCyjemJGruzrCWjBykZP/jpFPSER5XEjtuA/ddH7
 llBg==
X-Gm-Message-State: AOJu0YzKa3rRnWxnnrgP1EfBZv3Tto+PkyUMYHQnRSb/Y6O1Ky2+6R4m
 HA51e5QIKN6q3EBkDQqEgSmG4Q==
X-Google-Smtp-Source: AGHT+IEEs5MfUG0g1KTIMzCdaLfxLXB5Dp38EUnDQjf28hMwE617cG8TEQ4BFWMiIDHKkDmyyxX4xA==
X-Received: by 2002:a05:620a:22f2:b0:77a:59c:d849 with SMTP id
 p18-20020a05620a22f200b0077a059cd849mr29888212qki.33.1699381135780; 
 Tue, 07 Nov 2023 10:18:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 y29-20020a05620a09dd00b0077a7d02cffbsm144383qky.24.2023.11.07.10.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:18:55 -0800 (PST)
Date: Tue, 7 Nov 2023 13:18:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: u-boot@lists.denx.de, nm@ti.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH v2 6/8] board: ti: j721e: Add the missing part of exit
 retention for k3-ddrss (J7200)
Message-ID: <20231107181853.GK6601@bill-the-cat>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
 <20231107161802.855154-7-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0W/56pRQfBGbzprX"
Content-Disposition: inline
In-Reply-To: <20231107161802.855154-7-thomas.richard@bootlin.com>
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


--0W/56pRQfBGbzprX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 05:18:00PM +0100, Thomas Richard wrote:

> Add the board specific part of the exit retention sequence for k3-ddrss
>=20
> Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>
>=20
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

If this ends up being physical board design specific and so someone
making a new design for this SoC with a custom board layout entirely
needs something else, we should think harder about what's in
board_is_resuming() vs what we document the function does. If however,
this is generic to the SoC and will be needed, it should be folded in
with the previous patch and the commit message expanded, and the
documentation part of this series explain clearly what the functions are
responsible for.

--=20
Tom

--0W/56pRQfBGbzprX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKf40ACgkQFHw5/5Y0
tywomwv/RHcA4ya++CGElDNLjR/ONx3upWIswvTkhLOWqX+cNlMv4PEVKz7difVX
2K0Hy5DDrX4mc4WfYhgJjPgb01PUzNsFK/zvka//lXKe0xviPK9GvJXmKvZo2tKJ
jEB635RUgt+nFyqES0YmhLArq68lOlTqRZGhIRCad2YccMjX7gcD39gaEu2vI8XN
o1tQx5+f+dlOk4IM9wckhXz3ZmoTQzZ9r/HVjD0iVCjwGw655ARwFwv+HpZ7xCz2
B4DBvECMj/O7VztrBGFo9GPbfwz9jqdkv7OU40pLpzqsZlewAIY+EvqMh4ZfWK2E
9sVRDBjMxQLiDMB665KN+QVHJSPFA6XyWkUIMDPmDyBNOn0rKb9M+4aZKP83j8QX
5KfSNds/y+j4U0h7pi7K3qSxPGCAKMdJ5ScQW9nbkEZS08Ta/JrsPbkNeQ6Qo+gt
M0hqY8UcIMV8Z+uvvU0ubEL/e4MSUC17Lvm+2bx/X+t5kjp2UmoJMI7ys5SIIHoN
E1aZuGwC
=KY7d
-----END PGP SIGNATURE-----

--0W/56pRQfBGbzprX--
