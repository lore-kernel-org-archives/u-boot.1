Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58506C4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 21:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF5AE87837;
	Sun, 14 Apr 2024 23:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PC+c1MUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3488887A80; Sun, 14 Apr 2024 23:55:12 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B3286DEE
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 23:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-78d620408f8so209822885a.3
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713131708; x=1713736508; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q6zBOfkknq/HTj62FehOFudTOqwxieDi6hwjco2vYxk=;
 b=PC+c1MUl8h2zDfrIzoy0WHzkEYJ8hFXw6o91fpwaTJZCSaQrhyU6yG+8wyiHpgIFWP
 /+DO7P5/4g9f8YU6WFcfG82cAXKcJLkP6BjwDdVhNJm38kazEXAwhtJEg3JoinwmNkYQ
 Yz6fLYTBrS0QD1lpEct5fUKws99ExdbCaSahc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713131708; x=1713736508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6zBOfkknq/HTj62FehOFudTOqwxieDi6hwjco2vYxk=;
 b=adV0q0W9tNrpcWmdSV+CXxY+cDhvuX8CFMFbUoGI4RPmZSxd0mpUf1pYekwp8Ym8B/
 NQqylxldqL/V0ulAr09Z85DIqY5gzyXxlRKC6akBuMdj8cG+IW+uSGfpe1sJ8Mat9E09
 dpmF57L5X4VnFONmKRekLfOl8KcGLWUQEe0ORjbpDhEWNIEp09OEwJqNGhDy7CcHZZoJ
 E9CTd3loE5nsnmzXR0rieq98uzdKFhnkHmjTihv4aFnPP+Nx6vJBlTRtUef665RYOBZ2
 m41IAu5a3NJ19cH1lKhp5kdycHGCd8KIosyF56DduHR01ubxoyZxE3RJEYDcvbAxT9Eu
 ///w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg6dSGJ4RbnwWbdmM5hWz4K2/v9F8ow79gtL2aKFLapdgc7l+DfSFZU1zaOmLOyDPwdn6bxatOGcmPO1JC6n2QwzfT5Q==
X-Gm-Message-State: AOJu0YwnDQDWHBI7GZlwlK62VpMB+pcZFXo0cDAM/kMHW5gJIkpVEW+z
 x1vYWL599awxTuT4m5bIc4tdJ361zF8GvexpdOQgMJoorWsV8c5S8Ih2EuDk++8=
X-Google-Smtp-Source: AGHT+IEOZFdDazMB1kb7zjl6+HNc3PBeoDqnsMupN52SuEr85jYHUknrekJxA2JsajCBuuiAkSY6Yw==
X-Received: by 2002:ad4:4184:0:b0:69b:5475:ca74 with SMTP id
 e4-20020ad44184000000b0069b5475ca74mr9516684qvp.31.1713131708481; 
 Sun, 14 Apr 2024 14:55:08 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 d18-20020a0cfe92000000b0069b3e70937dsm5408078qvs.81.2024.04.14.14.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 14:55:07 -0700 (PDT)
Date: Sun, 14 Apr 2024 15:55:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, Alexander Dahl <ada@thorsis.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Bruce Suen <bruce_suen@163.com>, Weizhao Ouyang <o451686892@gmail.com>
Subject: Re: [PULL] Pull request for u-boot-nand-20240414
Message-ID: <20240414215505.GD1054907@bill-the-cat>
References: <CABGWkvodMc8TEMXSMJ2H1ij24YeLH=PmTgKV82Z=tEHRqxyCNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7PCr/xWe3vTJno4J"
Content-Disposition: inline
In-Reply-To: <CABGWkvodMc8TEMXSMJ2H1ij24YeLH=PmTgKV82Z=tEHRqxyCNA@mail.gmail.com>
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


--7PCr/xWe3vTJno4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 08:16:13PM +0200, Dario Binacchi wrote:

> Hello Tom,
>=20
> The following changes since commit 266603d8c39cf4d194e2cfe8d86d870590e150=
e0:
>=20
>   Merge tag 'efi-2024-07-rc1-2' of
> https://source.denx.de/u-boot/custodians/u-boot-efi (2024-04-13
> 10:18:38 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
> tags/u-boot-nand-20240414
>=20
> for you to fetch changes up to 248fc16055858c2028a381bb59e12354c4ae19ea:
>=20
>   cmd: mtd: OTP access support (2024-04-14 08:49:40 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/20=
333
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--7PCr/xWe3vTJno4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYcULUACgkQFHw5/5Y0
tyyA7wwAs+DPTNoiCrWv8qS7zDhFUcTlda5gGFIK9TbUANfwz5MYikFyErpKIyX9
LdyvHcmNKV0ynjq1g+ULHyHeAy2a0D1TP+9t48oRMCmhZN4hIElOuZh4hG2JGqPW
79tHbhRCPjcsUgfJg6TcJjKY9cmBV6Bp9L8wtL5zy4+0KyTz/SQXHrYSo3OomG/0
GZpgjRECZZCzrVSkkU8+tU4d+mdo619NAKwCfkldFq5m5D2r95l3lLrMkPArsUGn
qJZEg9dXk/w7nQQ2MCaOk9WhbIixhlcTfDenXmTMX1452M2ai0C2gFij5ilWCbJU
RhEfn1kgaOWjgNUBLbEkKm1vVWRYSFiBYfWNZFW5VTya6Y850MXYhNgmBp25EUCi
SP2DvJVC85ZwUnbzewvCZBPf+ifKXSx8hljRJfg7KaLIU/xJjSNcMoXddxCrJq0k
drMC9Q5fXEtG8yF/5GijKWr7uQKkzgIBzsjYljYD6Yc8x/ZmBq47CKBCLpWIN/d1
oYwYfG2U
=ShoS
-----END PGP SIGNATURE-----

--7PCr/xWe3vTJno4J--
