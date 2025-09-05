Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CB3CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 23:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82FCA83995;
	Sat,  6 Sep 2025 01:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WrBqCP55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF1508399B; Sat,  6 Sep 2025 01:12:05 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B3A18391E
 for <u-boot@lists.denx.de>; Sat,  6 Sep 2025 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-319c2a87a5aso1060647fac.1
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757113922; x=1757718722; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P0vXM/Z3zlAQBx4109tGtDof7Kuwxsht+cA/ZBIwvYo=;
 b=WrBqCP55r5N2EFSwrsNS4aAMmAVz/O3YnRkWFgFqupI7O9XCqJHvADxCHGDBwolT1i
 NaBw1qQvc8a4xghC4IkSl2bMynDvgDIYO5rtAu8693VrHEQxz6prr42HtmjxBczVe8hm
 Mflw12FOSqBVwRKgJQD31xWRY29JTKWpMKVgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757113922; x=1757718722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0vXM/Z3zlAQBx4109tGtDof7Kuwxsht+cA/ZBIwvYo=;
 b=KCCCNM+md7AcTbwa/bXEZqNWmkMkOpPM5CmYBVDGfnF7gjd3qRdEnfMAj9DVuJ57Vr
 9UbMTpcpayuakbnhxodMjFeiHJ6DbYrAcb6iRGCYNhwhj1rE9v4pU08O9vRJttaDtQVO
 nOjG71eWsJ1rQzHA1T3PAKYNms3OhO18Pb3IzlDkCd8SpRrX4CjgqvF5SSLvp2wu642Q
 YSO4Wa5Smpvr5N3rTs+OBOgK7LxCYh354aP9ks8oKBjGK7gI4jjhCSkDxgcmnBtbocqy
 gdK9aKtBR8b3Yx3hAnKhoRv7NH+FU6TCWfy7/1P3dNCfnFqUMZL+2ZTYlPH8Sn2GMKYm
 S1hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK9DMO2Ae5heH2o9iJc+vDSpA0/C6F12jgifu2rBuuLsxIgdbJNaDGgP/PtXtSH7WnbxGD0ak=@lists.denx.de
X-Gm-Message-State: AOJu0YzLBd+VR2enCUrFKdAgXdD1yPRTLbV3vII7eiKI7/N0iKlZzd5p
 b5XkOKSzAAMDtRuWg0x9rT4Gl9cHb4be4dwO5nRYPJKJ/nUSspSmwMO62darJSeVDWo=
X-Gm-Gg: ASbGncsc59NDXB6pV0d6BKp8oFC86fSiFp9VFucabWsmra0S8Hd5fFuRKqzl291GNQl
 3wLmkpZ38xJZnEbWNr4rCkAZIHnMMZC/5wikqRk835QbMU8X+uRqTe60sKXzzM/jfCRFCyxpjyj
 UCHgIqyfaEJAmTcu4IjQENXEdo/7RV14Ok0aSwSJm+w22Tpdjk0AGxeODsOomr67Ga8gjyf4rRw
 OjupVVbuj/hUEdUI7Hp2rBuVJANhcuVMxKS4EvnJGUYiyHIrv1+yPbf+4GRh8PXl8p0wM2odHR1
 9o57FQauy6uorJyk49YCjU4JoMxQZfQtKuYEPvGsROAAj3XfrqnqbDVm3Qnt/pbIViYHOXZyy1c
 UuTiA2krVV7Tsw21Uk1TlKnIqW00wpWFRCWf7AXj5Gy9qmfdjQ67yHYV3
X-Google-Smtp-Source: AGHT+IG4/8L10rAX34vP27OrFERBX4smaO2x1/3niHghCKngSmD5dA5S6a7gnPUqQ0ZhpnCCKgfzKQ==
X-Received: by 2002:a05:6870:8884:b0:322:4c04:dd94 with SMTP id
 586e51a60fabf-32262d8eed3mr141388fac.18.1757113921713; 
 Fri, 05 Sep 2025 16:12:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32128eaef7bsm1216330fac.26.2025.09.05.16.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 16:12:00 -0700 (PDT)
Date: Fri, 5 Sep 2025 17:11:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] configs: Fix crash on coreboot x86
Message-ID: <20250905231159.GO124814@bill-the-cat>
References: <20250903070502.136681-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NFYe5ZWbDbjScQ6g"
Content-Disposition: inline
In-Reply-To: <20250903070502.136681-1-patrick.rudolph@9elements.com>
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


--NFYe5ZWbDbjScQ6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03, 2025 at 09:05:01AM +0200, Patrick Rudolph wrote:
> Booting u-boot as payload with coreboot's main branch is currently broken
> since commit [1] on x86 as U-boot assumes the active GDT matches what
> U-Boot would have installed in start16.S.
>=20
> Make no assumptions and always load the GDT when building as coreboot
> payload to make sure the segment registers are actually matching the GDT.
>=20
> Fixes #GP seen when booting U-Boot as coreboot payload.
>=20
> 1: https://review.coreboot.org/c/coreboot/+/87255
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Glad to see this. We should likely update coreboot in CI more often.

Link: https://review.coreboot.org/c/coreboot/+/87255
Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--NFYe5ZWbDbjScQ6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLtuPgAKCRAr4qD1Cr/k
Cs3vAP4oMnd1LtkueN504BbO9VMXfQBqFeO1tfCWUhFkg02RGAEAtO9Cb/ezae6g
gOzZJEYwNFuWTPjpiO43isQUloPwPwM=
=uhGZ
-----END PGP SIGNATURE-----

--NFYe5ZWbDbjScQ6g--
