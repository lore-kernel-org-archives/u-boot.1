Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17ACC7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 21:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0648882BA1;
	Thu, 19 Jun 2025 23:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ql5rIXiW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1363982CBB; Thu, 19 Jun 2025 23:27:21 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A21A580C83
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 23:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-735a6d7c5b1so800401a34.2
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750368437; x=1750973237; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1nND4yFp783a+0/yJeswQJAb/TdzYs6gehjJX2yfJk=;
 b=ql5rIXiWiRf9bSXYzHoOFFvwZyXoJzYvdH+nzThlbowFAI0nk6Y0y3BQY9z4NMKatP
 snLtS7KKTlaGeHvUMnfD+QwEzDAKb89IOArjBEh09CSltX23ebrjsWyZtm+j8Dl0/Os2
 yv8XKcWAZtoEB3DawiwUxVwvy4GZ6a6mS4X2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750368437; x=1750973237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1nND4yFp783a+0/yJeswQJAb/TdzYs6gehjJX2yfJk=;
 b=YLyx/s7fwAa7mvJhgzP9fK7VF1rmXxdCqP/sH5n99HDIPqSOxblUW/PzWyz0COz2ez
 fCuSAiZlyTCgvOzA7eYU1+CPyQfs/z1LCosIc3hwfmcSeQfPCyB+a6cs7VFHNLTgOv1t
 QiDe9OQXtJ48caA/TjwjzJrt+7U73oG8Vs6+nrkxG2yJg3G2vKLb90aS4/tbhJfvdCwI
 yEW54ZANR7QboRG5mfhnPCKd8v/8NZIzSs3v8xe85BCbcgJvc/WjAxWGfBBkNL8P9+vL
 suQRHJsoUHmOzKQLY7kfxdVx8vOEzUKlrTq5y5AxVSN2UjScyML0FHJw/vBHdCWt91jU
 axhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7JL/zk6FOBtjYFxwgl8L6n0di1cyLmG6dP1xwrbdu2lcxzk4VfI/pq4fEKecfVtBTOxpdyfA=@lists.denx.de
X-Gm-Message-State: AOJu0YzibwKhkYqORDpuwnOpJaGmbXr0kfuEvVlXi8NfDZympsBA9UZz
 VoJOFlKD2zsTwJFHAmr4hsaF+cuIMCd1q6ABY+4IOsNQzpveDNJShQS3GZwkKcgfg/U=
X-Gm-Gg: ASbGncsXRozNPnR3tIne9fqO0/nIesiG5B9/BXky7Q/dwoO2x3706F2KZYk8NxRvlqd
 e9ya3dFZrWfPG9+5P62mVMY03U74noCbaQNkQR+IqtnOqpE9h9XWUIhWlB93/4six+xUxbA1a0x
 WtL2xFXi9Xo4w+KxYvyi167+yWbphxVq+rRfvJfuYGviHrfSQwSfQfAVOoHL9ftrRX7MPvnK60/
 lQwVmLbgiFoXYy5tfwwi3XPWtXTwaD+1D1fYwfe3gKtsEQB3jXbbaclK2F41/5lrRXh4OP4nC90
 2s/EHb0UMOfIaNKHBLkEKdRy+5+5zxPtoZx220oiFk36riqz8KuQ8CcLBcjPyXVdaCreh6q+7A4
 AkA0+WOuxXHrLM8HNekivqLk=
X-Google-Smtp-Source: AGHT+IFLCywtvik/Zy9BY1i9iWISAfFJb/jaOsvkq/7R2zWuQsPuGFD7mwlKYsTEr6GBMOlJpnBfGw==
X-Received: by 2002:a05:6830:3102:b0:739:fe04:7aec with SMTP id
 46e09a7af769-73a92032511mr206381a34.26.1750368437244; 
 Thu, 19 Jun 2025 14:27:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a90cbb386sm71362a34.57.2025.06.19.14.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 14:27:16 -0700 (PDT)
Date: Thu, 19 Jun 2025 15:27:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: arm: mvebu: Kirkwood boards are broken by commit 6fe50e3
Message-ID: <20250619212714.GD216500@bill-the-cat>
References: <CAJaLiFwpdskG-eQjFKQseB3ResK=6Lt_RNRbXZTEFq7FYYSuAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mt0W4T0L+j2sV/V8"
Content-Disposition: inline
In-Reply-To: <CAJaLiFwpdskG-eQjFKQseB3ResK=6Lt_RNRbXZTEFq7FYYSuAg@mail.gmail.com>
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


--mt0W4T0L+j2sV/V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 01:37:53PM -0700, Tony Dinh wrote:
> Hi Jerome,
>=20
> While fixing some ext4 file system problems on 2025.07-rc4, I ran into
> a problem booting a few Kirkwood boards. kwboot loaded the u-boot
> image,
> and then u-boot execution was frozen without anything going to the
> serial console. I did a bisect and found the commit that caused it.
>=20
> https://github.com/trini/u-boot/commit/6fe50e39508043f386fc1bd40bbc02b8a7=
5c1940
>=20
> When I tried to reverse this commit, I had a build error like this
> "{standard input}:24246: Error: selected processor does not support
> `mrc p15,1,r3,c15,c1,0' in Thumb mode"
>=20
> Currently, the only way to boot Kirkwood boards is to disable either
> CONFIG_LTO or CONFIG_SYS_THUMB_BUILD or both.
>=20
> I'm using the pogo_v4 and nsa325 boards as test beds. Please let me
> know if I can help with testing to troubleshoot this regression.

I wonder if the right answer is that CONFIG_SYS_THUMB_BUILD should be
off? A quick look around and this (and sheevaplug) are ARM926EJ-S which
is Thumb-1 not Thumb-2 and it looks like the kernel for example only
supports building itself with thumb2 on armv7/v7m. I know that this was
working, so we should dig more too, but I'm not sure what the best
answer here is.

--=20
Tom

--mt0W4T0L+j2sV/V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhUgKoACgkQFHw5/5Y0
tyw0Gwv/X2yvvqIIdSV1Lv4wx3kl+4gPyhbjLDxFE/ZwdaRp8Bl2qSB4AmHoOhGn
Ze8ffL7uOmHi8eCFZf4NNQIcBRj54hg5OYl1lOmOXnqyzfJPake2VpJfpYrnOAVZ
LLJB5q/9CZM5E87yp7OkJo6w+WptbF/sYH299sSJ9GvHxsgqOLjC3aNqr8FSRJhx
VLihfZydxxbAGsKINuDqo76VR3iYbbrQ9PW8dJlZM86h1SrwcX5PY0S720aV/wTy
24F4LDIcirBRvdv0Bk8C+sStjOqtQlxrMHhg+sQJ7Wn1bDf+7BRtKQkAnPh+Aok5
C33W0HDpSEWicAoRT3QkfMb5hN9avw/UfLmCXXPmHN71uUYlDdCqQkThIG8MLnNZ
I1M9+q+/Xu3HH+UM0TcZOSjfXrh4JOabTwTYzWVbyZyjUtLwOwBlM4K2v/0DcXBm
41mukGeIBcHW7ieACNbmnVpQ4/9SOLmJH2YYk6Qm+vYqZHa/aOBEUu3vz3YWFMNN
ivh5TBdZ
=FCoQ
-----END PGP SIGNATURE-----

--mt0W4T0L+j2sV/V8--
