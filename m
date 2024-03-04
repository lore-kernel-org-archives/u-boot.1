Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E385C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 23:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D2787FCC;
	Tue,  5 Mar 2024 00:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IROOYEH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 877E887FCC; Tue,  5 Mar 2024 00:44:21 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6847987FDE
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 00:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c19b7d9de7so3327842b6e.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 15:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709595853; x=1710200653; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0dmBryKudjW0uuW2uPzW4/rv1ZxQSGz7SwFUZap10Iw=;
 b=IROOYEH8LmXwzl0BbDaKVKSwZdZ9df2anX7BUpagMfNK/e8K45uB5B14CfhL0Y1wSO
 B3hpVxLKHhaecNZem/oJVECcF1+aBR+E+7LUwiz48itFdXXz+QU0KjmXqy6CyErv8Bv7
 l0J3eJxdZur/MdVO8SMqlc5Krjh2ppgaEXLvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709595853; x=1710200653;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dmBryKudjW0uuW2uPzW4/rv1ZxQSGz7SwFUZap10Iw=;
 b=gSPthjSH3lBGgR2ciYVzUKKzCqDew9YiB+Es0f7pMDX193Jou06Z69HfF1tqJBSWCU
 XQxyRnifJ13r5cO8qwxwoCs3qjhk3pqfKL8yc2i0a3QCnpkRlJ0v1b+C7gxl/AcNEpN7
 9ECAOWexEz+5+yNgp3yjaxlB2fGWJGeOrZ9yFr7Sz8euf+S+SFibIZcyyyjE6juLtv2B
 bdv1nvWcecjcowsVtfVLORbQza4h//TE4KWSBrG5VEJmwkD+M6jN5EacASLwuX5dJD2O
 +qG4mxg3/Aakh/k8ehmpUt/2BjfZalK6xQoyzK6Ycfk4Zby9kbXgG6Eim9XoFGqq20+O
 wKow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOqxRKuhL9asLr7ka+a84nOUmlqPreP6CymhaiMBt5kxMOZHTnhzgQDfw5q6VAr2VqIazSyB1/bJzJ5cJ/jkwQYNvq5g==
X-Gm-Message-State: AOJu0YwP+mkDqudVwuoEOJDJTpmFj2GUant4XeXGOgSZyYf6amCju4vG
 4K2r0Kh8/40q81Dg1uh3OPWKFZjGPbpx01SqvHx89rOvDaAyjaQe92609PRkLxU=
X-Google-Smtp-Source: AGHT+IGCilLCK+0CyToqIfeeYAOLLU86X28uUFpdikZPeByTs004MZbKAbGVA1AXTCLsqSI5DhQhKA==
X-Received: by 2002:a05:6870:d608:b0:220:8d30:8e8e with SMTP id
 a8-20020a056870d60800b002208d308e8emr183466oaq.51.1709595853338; 
 Mon, 04 Mar 2024 15:44:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 c6-20020a05620a11a600b0078823804a9asm2035691qkk.18.2024.03.04.15.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 15:44:12 -0800 (PST)
Date: Mon, 4 Mar 2024 18:44:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 Benedikt Spranger <b.spranger@linutronix.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] configs: am64x_evm_r5_defconfig: enlarge simple malloc
 pool
Message-ID: <20240304234410.GS1523872@bill-the-cat>
References: <20240209-am64x_evm_r5_defconfig-malloc-simple-len-v1-1-4a779a8bd557@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uKGbqr8WJZ1zIUhn"
Content-Disposition: inline
In-Reply-To: <20240209-am64x_evm_r5_defconfig-malloc-simple-len-v1-1-4a779a8bd557@linutronix.de>
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


--uKGbqr8WJZ1zIUhn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 09:06:53AM +0100, Thomas Wei=DFschuh wrote:

> With the default size the stack grows into the malloc, pool leading to
> stack corruption and boot failure.
>=20
> Signed-off-by: Thomas Wei=DFschuh <thomas.weissschuh@linutronix.de>

Applied to u-boot/next, thanks!

--=20
Tom

--uKGbqr8WJZ1zIUhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXmXMoACgkQFHw5/5Y0
tyzKgAv/UbbQUbPoCpNWb7E5ZI6MnytP8nESZgBBh7IsdJR8vqhJjXL3bXfHy3AW
mb2MonZzzWiENDjdK/mDvsnPh/OUBsvcXJnochxeUrAAk20WhkiwSSZj4XipxW/h
hWQ5OxudCz7HkQ9Kw3M9vKvGR735Fsp2EZSer+d4In5JJPMlWBBDMMdyiOXtC58j
1zW9pGVL41WZq0LdGqvu1Gvmn7KUmTVprQEsYPQpZSxrVLsfGAZ8lJqtXY6OVbom
nb5NDyzovfUJscMqpL5JfhQcIYLwVfBq5jsocOTnFSbgDjGayM/BzmfdlMFgaI5N
mO6ZeG6woYPMj5SBl2PylgZJDdMAVY0kw/+HgTk1q18oAKM3lPc65hzAVzGoWC9d
q/Z10fknaIt7/Uqykkzv+0Dce8vcy5NRW1Vl48MDIwgKb8Sweqo+Jxz2+4J8Gggp
GDHCUQkNfpSvZ9XlvboyS9Ufkcn7+Xtn17sUa+TwLe1DYogSCyj8DB1ZYgXC0HvK
Bla/l2Vf
=ck25
-----END PGP SIGNATURE-----

--uKGbqr8WJZ1zIUhn--
