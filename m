Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01156CCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 19:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF5F833F6;
	Wed, 15 Oct 2025 21:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VyUvFEyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94FB08357F; Wed, 15 Oct 2025 21:59:50 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26CEF83303
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 21:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-64fdca63b41so3349308eaf.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760558387; x=1761163187; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pgC+eMKsBlv3cr9NXUPzMQwiZ8JfCftXckfVeG78sDA=;
 b=VyUvFEytsB4aSbHu21QVzOOBb4wy3rQ6w5Oer2ceypDVMU04+dEjZpgOnMmzeTHiWo
 hAX6ZNUpvxhVw7a9cnYMddz4xAtJs04576qGjKooMGivERItdx0ULj/klnqgkQn8/O3F
 LEp1vaa/7L5RvW57BS2UFzlBn4hRf3Z1Ztues=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760558387; x=1761163187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgC+eMKsBlv3cr9NXUPzMQwiZ8JfCftXckfVeG78sDA=;
 b=scYss7lre6HUJl5PMeAS7kIxxN1Pn7ppVSLj8gxHnY0naEzK4mgVF51IHei7Ntz679
 91u1Ou8TQTXRFGyOgLs/S7xUoNu5gWFTZICr7+dVKHUrdizsb90PZ2W6LEEVK2VnKPQg
 ZCS3VrhfcXh+1xueVmvSuR/biz5kwd1VpoUoxZl2gB4rI0O9+t52DMZuBZ0c84mXioK7
 O8aqZpLv1N8QshXAw8OTCqvizqHEHefWcU4b6S1Z/tW/UJmoeDHRz+Q3GW2EqRTWBqCT
 HMAupR76dC4oplOug+ol4vE3xiSMIiQedtiWRvlcagjCgzFt0dHbGQyf/ga2iHMH3rtl
 jppA==
X-Gm-Message-State: AOJu0YxQQBiEKQqwrq8oKVxrkVRW2uwOWamQpovwAMrFI3YURMtm3zPh
 ppQx84vI2sq8Jvl9f4gQItfLQJh6OtzytuWpI8OUKrQfAgS+IMui9Awf6rH2ObuIa8w=
X-Gm-Gg: ASbGncsGXMJnistb/Ml4l5pivJjiZcq6sybj1jcFt9IG1D0HJ/PyMyK0p2Ww+7zQszG
 WdPbtP4/QMM2lgVacZxMbf9gC+hJSYFe2fT7W8fx4OH817BuS3ecbnpoZwqk/xRnQ2vRHepp4vY
 ggnQuxpz96wOFRALzlLKuDxG/XlxFrcxbv56ku1niJ9iiYAqlMiuBFFBU/IXFGeyy2SNQCjonBc
 RlkTIbL3Btp10SxdoCqouXovljLr8BDDtDQLbO+N6iEf5AduClJokrQ1cRfzHJpCBdhHIL2Pz5T
 gs2JwKftPsrx0iAOzxlyRYZSG3hJT+ggZ1t+aUYcG7VqoRaUY8Jwl//vJ7m2eQHyVhd+lNkk6dh
 1KkP/keE8YiJGhpVUSKXAgCoeRsBIoAVOoqwka7xkSiVfIrWi1nhNeq0ov+3uurfNsoupsvW3tC
 LMg4bd
X-Google-Smtp-Source: AGHT+IF4m/L12P9sKt4q2PHYbT1UikFZxMEeqKdAyMaANKkjrJHRVkdflKjN49UThnbm+miu39aTfg==
X-Received: by 2002:a05:6820:189b:b0:650:1417:73ce with SMTP id
 006d021491bc7-6501417933cmr10116214eaf.8.1760558386547; 
 Wed, 15 Oct 2025 12:59:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-650181e6ce1sm4349155eaf.10.2025.10.15.12.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 12:59:45 -0700 (PDT)
Date: Wed, 15 Oct 2025 13:59:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com,
 kever.yang@rock-chips.com, hl@rock-chips.com, tim@feathertop.org,
 marek.vasut+renesas@mailbox.org
Subject: Re: [PATCH -next v3 0/7] Add support for secure falcon mode: disable
 fallback
Message-ID: <20251015195943.GA710760@bill-the-cat>
References: <20251006101057.4172248-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o97Xruzdxflkjw7u"
Content-Disposition: inline
In-Reply-To: <20251006101057.4172248-1-anshuld@ti.com>
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


--o97Xruzdxflkjw7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 03:40:48PM +0530, Anshul Dalal wrote:

> Hi all,
>=20
> Continuing from the last series[1], this patch series addresses the requi=
rement
> of allowing no fallbacks in secure falcon mode.
>=20
> To do this in a clean way, all the falcon mode logic for each boot media =
was
> refactored to a corresponding *_load_image_os function whereas the regular
> boot is implemented in *_load_image, this allows us to easily return earl=
y in
> case the *_load_image_os function fails with secure mode enabled.
>=20
> The series also introduces the new SPL_OS_BOOT_SECURE config symbol which
> enables secure falcon boot flow.
>=20
> The generic flow after the patch series looks as follows:
>=20
> 	static int spl_<bootmedia>_load_image(...) {
> 		if (CONFIG_IS_ENABLED(OS_BOOT)) {
>=20
> 			ret =3D spl_<bootmedia>_load_image_os(...);
>=20
> 			puts("Failcon mode failed\n");
> 			if (CONFIG_IS_ENABLED(OS_BOOT_SECURE)) {
> 				puts("no fallback allowed!\n");
> 				return ret;
> 			}
>=20
> 			puts("Falling back to U-Boot\n");
> 		}
>=20
> 		/* Regular boot flow */
> 	}
>=20
> Regards,
> Anshul
>=20
> [1]: https://lore.kernel.org/u-boot/20250923124639.667718-1-anshuld@ti.co=
m/
> Depends-on: https://lore.kernel.org/u-boot/20250923124639.667718-1-anshul=
d@ti.com/

The depends-on has been merged at this point, yes? I tried this series
on master, and hit two problems. First, a number of boards such as
pine64_plus failed to build due to defined by unused warnings in
common/spl/spl_mmc.c. I fixed this up easily, but then found
j721e_beagleboneai64_a72 for example fails to build for defined but
unused warnings in common/spl/spl_nor.c so I'm going to ask you to
rebase this series (and as needed, the rest) and put them through CI
first (see docs.u-boot.org/en/latest/develop/ci_testing.html for
example) to make sure there's no other problems first. Thanks.

--=20
Tom

--o97Xruzdxflkjw7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO/9JgAKCRAr4qD1Cr/k
CqPRAQDuKlfVOb17cbPgRbohXzUSit+oow4VekcLmKlQS4K7wgD9HD3TBHT+DjFM
hwokWmwgOOQl4VMEAPfJQRLcd5foQgU=
=CBjU
-----END PGP SIGNATURE-----

--o97Xruzdxflkjw7u--
