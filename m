Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BABFCD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E399084987;
	Tue,  9 Jun 2026 21:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PPh3Fatx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F958497A; Tue,  9 Jun 2026 21:01:44 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 822838498B
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e71198e0adso1650118a34.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781031701; x=1781636501; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MOP75hnHiZyRqUFkwCeIS8GY+9Qz+k7g/ffRICOP8Ps=;
 b=PPh3Fatx5HX8ySB/OMwpniRmoUJMG7t37GFuVpYr86umrnUtA7Yrfdc9vYS7UKDtO0
 OKuPLQInLXS4Oebng5Z6gYIB4k1tv3Tt9eH+h+k7zcJFcQFpTWEUY3G9WuhgdE+azVlN
 pdK9/U3veNrmfA56RLK0ONQiTfLXBWKrWtY4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781031701; x=1781636501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOP75hnHiZyRqUFkwCeIS8GY+9Qz+k7g/ffRICOP8Ps=;
 b=qAeoKGqONjfxZY79DEiWLcYgPG2j/BE0TZZ/bKIXP9EKj7HmaKI8SG/AWsq5vsTmR2
 uL0Fpl0Zlm84/Ode/23a0ZlYPSWchup3Ztk7IIfJqdK4m/xAKxuB8/VfIBIfDYXqb22Q
 zTvHVqWG0LTcuvy4uZG3qzRcILZpU8PSDgwj3OqOThbxpeHjh7XIaXHfpthbvfn8U70v
 Fi7+Xdy51f+rksGe7/zMAcRdXHWHGd/sFgGn3d0WqulCjY72h58BJMgmNVgJ+F2gldCr
 jPAUeCKnypbfP9zENMXxLyq+YqyhIWVTOT8wFkver9Mzt7KwF+aZ3r5/8ufH2xH1Jk8P
 N1Gw==
X-Gm-Message-State: AOJu0YweRmHxOceq9HrWgDkZQt9P/HRigQ+otk127HNUtqPyPwfkPQTj
 O7W2Vr77YGE62t8FiGv+xXbpkNJjjVuOAqfWVQiTCWi0mcSoF4FKflpM/SzS0LM38hXP7rP2Z5o
 i9dYmQQk=
X-Gm-Gg: Acq92OHxir5A1QuDBaiKUM8p9xmZgeKRulFaND6teNAynsSj/5PbO8Z0hsssh54Csr3
 09njlaqf/a4VsPzqaXhEhN6QwUJuZjUZACEQ7g1Ng9NDSn2qJVb9jclDtPZoLJrOL866PFWqjYv
 R+O9kKZzu+qltGRjdk+M7pyfYZJvzFlR8h0XYmw64R7ZteVCj7GrLf0Fcn7zAzLs2ekkNMp2nmL
 w+3ulBTp3o84zEV2ZuuZWLb99Z08VLdQ5dL+f+2RGrhow98KXBbFhV3FO6nYA1b4iJhs6G8AiH4
 fOATYgBW2PMOekJwGKgGQ7H59LccIiIwb0cLmoioOzlRWO7EFHGbMEaPOZcyj5cwFr3d6Upy71b
 bD5c3PfNYqnI2fAUdi2gU/v5b/dmo50pXLLroevzgQdf/o3GkW5ahDqPiHALvQBAdgnFCBj+x+S
 RVpgm11ZGE/00AjkzCD9hYr2ZBtV+nUDU1Q9SClctlAFInYJ4qr4+r4FzVofJJDZiCm+o5jF/xb
 o6vgPKqc+TPwZ0wZDzdFyHfpHc0l0CkmsBfgG5ShT16R8VQTBvzo6TOcf/MXW2GLW7gHowS
X-Received: by 2002:a05:6830:34a9:b0:7e6:f362:eadb with SMTP id
 46e09a7af769-7e70c686601mr13925473a34.9.1781031701051; 
 Tue, 09 Jun 2026 12:01:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e796c675sm15143813a34.24.2026.06.09.12.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:01:40 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:01:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 4/8] Kconfig: themal: fix typo
Message-ID: <20260609190138.GX382693@bill-the-cat>
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
 <9123523a-11a0-47fd-a118-bcae55da34a0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F1C53gn1AMJhQpTj"
Content-Disposition: inline
In-Reply-To: <9123523a-11a0-47fd-a118-bcae55da34a0@gmail.com>
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


--F1C53gn1AMJhQpTj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 03:25:28AM +0200, Johan Jonker wrote:

> While restyling Kconfig the script checkpatch.pl gives
> this info:
>=20
> WARNING: Possible repeated word: 'for'
>=20
> Fix by changing 'for for' to 'for'.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--F1C53gn1AMJhQpTj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaihjEgAKCRAr4qD1Cr/k
CoC7AP96bnpBSRvNESxvHcleL/3E5hmGLiXxEFPa1GmqZe5G3wEAhfpDqzLfDP4O
B09k3025t76XGaXEU5CkGQehA++jpAo=
=tZg5
-----END PGP SIGNATURE-----

--F1C53gn1AMJhQpTj--
