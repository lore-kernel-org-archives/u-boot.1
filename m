Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBAEF3C9A8
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 651F583981;
	Tue, 24 Feb 2026 16:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TdA6vTH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24BC483E13; Tue, 24 Feb 2026 16:59:11 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 111E983642
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d4c65d772cso5255451a34.1
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 07:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771948748; x=1772553548; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DFmRa3aWXH4HxvM0P685ULYITq/siXfCAZSFBZ/r1GA=;
 b=TdA6vTH8HJFm0x/YiyxH8c5DNotfi3+dta2pefOVifoQuzVwXkIN4OWBvrloSHQk5T
 LlC1mTr4L/SdPA7MkUhEF8boVNAc9Y9OePW0QjluaRMjrkhClhV0sUlYPtI/ZtXwaUPu
 SGqz624PU+fjNBqoBE33gQSfJMDxniMJZSaNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948748; x=1772553548;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFmRa3aWXH4HxvM0P685ULYITq/siXfCAZSFBZ/r1GA=;
 b=cbZFcczHQA2g6R5b3szDpSTuEQd2g1svroVhpAMZpQijAhjzuVeVxVsISnbWqeLHxl
 Ij+NzEEFN2n+KeSO3kxq/AlvyAL8SvZ26bb4KZncbBcrZFHngZrYk1sJ3X1IQ72TA9iH
 Kx0mlAacq9htDuOM/tgPBU76RIjOzTz5tqQlBFZD5TSMxLDJbK8qNFFTXCrfjO0raBiu
 A5rdHGylXa6qLA/cUZgZ27bpFw+X5I71OIT010aPo7IvsSoOSZ9RRB44AlrBlir/KC0F
 45w4QwJz1cJIaBPMk/N69z4FsHqYk7HhW0TsBXScOkEZuKAECY9CMyWgnHHLNJGI6VmY
 G68w==
X-Gm-Message-State: AOJu0Yy0ZNK5HnfYIr9Ss9FZswm8a83U88NviFR9Zbzx9gm3mxvTeAej
 x9O/nsEJNu8a3+qwEpCalgVFJPXXZJig8E5LwBO1Xd6YXjWj5EsKRU5S/4KJyQ/Acbc=
X-Gm-Gg: AZuq6aKm/rUjv4u4qEtcdpwxhC7+Q3xb34cRnI2OP+p3nNyxtLNVnw6p0tIMGWIMSuC
 UhlMLLgyPODXJQJlcFhLoc/ntidiob6Qpp2kRgBMRwdqXPzLlJgEc2U3W6A2AEN4KsZxxsiYave
 MAL1MwzAwSSO/tfbVQbphVz8CSrbVIQ5lnbRrC55aqR39x2PnWcad1CbKBfFqlBpArBs2Lim1+B
 cnLPFmYcpvOwavfZKvI4Q8IwcQtudtZdTYv0ydqgr/pQxNFW1JLJ0YLF/7WbncMqO5tdrZAznCz
 wetnO6rM3AOlXGJRzA970ZK3N2M4pqAW7gePw8YEGhO/QhnJ7OXBqef8P/RgU9ejayYTBLSYjRV
 edP886l/4xnl4zQFFEoRj6vqK9irggGN3JQ5dk+xisXCIIQzHRo24LkTNzEg/iDTTsU7qUN5HKG
 aUC3U1pd6DzwY7Io+vWp3tdUbEvW+CL12a+RUTTW2Sj5/A9rKNOXdwqlqmoQ9A4bLVNb+YxNf7K
 QF801R9idIwzTSe4UGgEmrvOuPsFweF8VEfkyCADZEL4ru5KnI=
X-Received: by 2002:a05:6870:d0c8:b0:409:50b3:273e with SMTP id
 586e51a60fabf-4157abcb0b9mr7991693fac.10.1771948747679; 
 Tue, 24 Feb 2026 07:59:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-415a607a7d1sm6308737fac.14.2026.02.24.07.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:59:06 -0800 (PST)
Date: Tue, 24 Feb 2026 09:59:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>
Subject: Re: [PATCH v2 8/9] riscv: Call bootm_final()
Message-ID: <20260224155904.GR3233182@bill-the-cat>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
 <20260224142553.1608883-9-simon.glass@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h/jjG6Fo+BJVfQDC"
Content-Disposition: inline
In-Reply-To: <20260224142553.1608883-9-simon.glass@canonical.com>
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


--h/jjG6Fo+BJVfQDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 07:25:50AM -0700, Simon Glass wrote:

> Make use of this function, adding some pieces needed by RISC-V
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
[snip]
> +	if (IS_ENABLED(CONFIG_USB_DEVICE))
> +		udc_disconnect();

This is still a NAK because nothing does this today.

--=20
Tom

--h/jjG6Fo+BJVfQDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3KxQAKCRAr4qD1Cr/k
CjrMAP0ZN9/0Xdw5gzPCisuf8//240wcLK+S8gdQqJLcGLRNlwEAnQhuOigT88NZ
jCmV5nWOtIu7FzFptniKtUoAFu4rkgw=
=Evim
-----END PGP SIGNATURE-----

--h/jjG6Fo+BJVfQDC--
