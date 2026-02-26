Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F7FFD8FD2
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C973483F2D;
	Thu, 26 Feb 2026 17:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZPpIgdaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 285FC83F2E; Thu, 26 Feb 2026 17:30:21 +0100 (CET)
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9922683EEF
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc44.google.com with SMTP id
 006d021491bc7-662f5c5507cso905757eaf.3
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772123417; x=1772728217; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n33Gmd/yxomG3lEYbvgpGB3G5PqR1DQrXjPT7rP4Bfo=;
 b=ZPpIgdaJpSxIAy6A0mlqdTJ7KfaKrXINXKtlCr0TfrcsccIJTLd8CH0cmZlKJH1/HE
 VQhbwDV2fvvOAZNkRGNh34herpM5c6OhGrbPlhMp3D8oDesPzPmopEqm19VUb/X4f4WH
 /fAM/Uq8taPNeqEVG3KoJkA21v/YVMDqu68EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772123417; x=1772728217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n33Gmd/yxomG3lEYbvgpGB3G5PqR1DQrXjPT7rP4Bfo=;
 b=VOy/WXhf9h/NjpFZasdSJNPEGEo8BQr+0+RmC8Hg5549Fa6dQJQqsQarhIqBy7eQET
 htKl8wzpV9DU6zrfyaFdkXFmYAu8HGsB6sRu4hr8o/VLTXL3cf9B408c+do3RaF8IA7K
 Owpz7wMfXCQeFxh5C1ff1NtOX4OqUS1Vh9tB1LyjHJa0RamFLCp/+T/33GQBqxaS79f9
 lP5oQIHrXHHwT2z0oeFEf9z92ExEQyUeU5ov2JgwgIK3SBojOjp0WnUZm/ZDbycvxuur
 ioDC2BqF1p24WxKumhNpnWsCisURXacojOsSeXX7U7ZMwLQfQsTrGFLh34e541I+ZD5r
 ugSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx/2PpkDhJ+tgeAm3Pd1B1JeIbvxeZJx2aSqf5Jr1ogvsbX5ZF+pytUMQ/Z/gOweTa3IHnOeg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxj4uSqMtTQUY4xuelCS8M1WC97jmxaq4U1WWAyIXg94/ZU5T4o
 2XDZmBFt3hU7pu4rTMyrIpsVq2TVAQarRa2/QmY9DRQfPINyYeHaE2E++HbCC9AXQFg=
X-Gm-Gg: ATEYQzxy1fLpZywmeNUlJuuB3YQXjtfwAGFfqSoDuzjX6EZIzWgm61387WP8lrtyqtv
 eMYAsVoNi80fYIOLEwg2SVIDWHKxu5veuGcXfR2VZ6xjtqC47yzD7CaM66NNrlKvwb4UxH0760G
 4HEdKOg4+GAdYMUGqzsHLCeJtpEaPZUTL442zSIiMEgqIrtycMIK6b6jJ8I8LnyrU6nBc4jRTJ3
 POHwBiYyTAjbTJrA0f3KJa7EVXXbdJVEHx1opSY8z3v6rpx44MOugc7fvRzGEB1hyXG2O8+B9CV
 n7ER65Y5uG3lwcIltYqzJG0rJwPUgtOT1T8xkXZTJTQcGEnYkW6/zIg4hgIfJQexvKmhA2icdVC
 hgsz2kIrEj2zLFoIcnrG87ak5J6WDS9YLToJkVnjH3xU2nu6hAWW/4q8Zk3lyw6/SGklbSHPUJ1
 o+o6vLH5oJUt0DrkmWmF1W5I2njkSN1V0rEgT9hPMr6hC3mTSCZ9Wfk8tsCzG/TKACOPAEe+de7
 5uF5WEkZdiTwyaThpdtz5buphTfR8DRA8J/msesnE7ozYeHyQM=
X-Received: by 2002:a05:6820:4688:b0:677:5e0a:a92d with SMTP id
 006d021491bc7-679c461f2f7mr7969122eaf.73.1772123417202; 
 Thu, 26 Feb 2026 08:30:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf23977sm2191122fac.4.2026.02.26.08.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 08:30:16 -0800 (PST)
Date: Thu, 26 Feb 2026 10:30:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Aiden Park <aiden.park@intel.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Subject: Re: [PATCH] serial: ns16550: Fix return-type warning
Message-ID: <20260226163014.GI1593142@bill-the-cat>
References: <20260226-serial_ns16550_fix_warning-v1-1-ea563e6a26e4@maquefel.me>
 <20260226150842.GE1593142@bill-the-cat>
 <fccdc13e79b3a0bed390d6fcc25f04c0fd93feff.camel@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YoLIGv1kGZzf9cik"
Content-Disposition: inline
In-Reply-To: <fccdc13e79b3a0bed390d6fcc25f04c0fd93feff.camel@maquefel.me>
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


--YoLIGv1kGZzf9cik
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 07:28:36PM +0300, Nikita Shubin wrote:
> Hi Tom.
>=20
> On Thu, 2026-02-26 at 09:08 -0600, Tom Rini wrote:
> > On Thu, Feb 26, 2026 at 05:02:47PM +0300, Nikita Shubin wrote:
> >=20
> > > Fix compiler warning:
> > >=20
> > > drivers/serial/ns16550.c: In function =E2=80=98serial_in_dynamic=E2=
=80=99:
> > > drivers/serial/ns16550.c:153:1: warning: control reaches end
> > > =C2=A0=C2=A0=C2=A0 of non-void function [-Wreturn-type]
> > > =C2=A0 153 | }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^
> > >=20
> > > Fixes: 62cbde4c4e46 ("serial: ns16550: Support run-time
> > > configuration")
> > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > I assume this is from gcc-15.x ? Thanks.
>=20
> Exactly,=20
>=20
> ```
> $ riscv64-unknown-linux-gnu-gcc --version
> riscv64-unknown-linux-gnu-gcc (Gentoo 15.2.1_p20260214 p5) 15.2.1
> 20260214
> ```
>=20
> To be precise.

Could you please do a v2 noting the compiler version? We don't yet
support gcc 15.x, but
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D121588 is just now fixed,
so soon we should be able to.

--=20
Tom

--YoLIGv1kGZzf9cik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaB1FQAKCRAr4qD1Cr/k
Csd5AQCp8VY2fDlql3pM8VaZx/52A102pnYIZZAYHXJBfCSPfgEAiCdNx9U8e/WW
/it2W0CE89F63nQGZ4F18PRLr7B3nQk=
=XSy3
-----END PGP SIGNATURE-----

--YoLIGv1kGZzf9cik--
