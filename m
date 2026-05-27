Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B655CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 19:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB168487F;
	Wed, 27 May 2026 21:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n/zq2Ccl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6694684881; Wed, 27 May 2026 21:25:10 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C84847C4
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-479d9b155deso4064344b6e.3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779909906; x=1780514706; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pN16+RSAUHHs1pr9mUO+XbDGrknQ3TUPIpVNUWnYjE0=;
 b=n/zq2CclJ4+fAa2F45W6Z9IlKINznxNww1IxGHhVWTNEOEv+dg8x3+P5VmzGLiGo3H
 83wtK/VfYz9p8YmNgf0fXRiYp1CINRAHlRc15XHSAaoC26ysEhySdJZ4UM0pfyJJCxLx
 708ugEuZ3/1Cx6GtILev46NzBzF8utkwpeo4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779909906; x=1780514706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pN16+RSAUHHs1pr9mUO+XbDGrknQ3TUPIpVNUWnYjE0=;
 b=F7snK+klShboE3AZzN7sJKjdmGQ7tNjrIT2gDnq54AbKHIopL1b+dUMzxIs0I+f9xD
 tl+z7oGBM7kVrmCDtBLgDD3J+0qFFf0UWqst5G9S0CWC+k4rvHLQynIJHKmdk3uQwzna
 RIS2xbjEvbkf8OhWD9sbBuky8ljjLrJQWpLB0vuYHWlWXuZw+3eGwK24VWMz4LDvcCrq
 +Sy7m6xVhWPHPKfZ97AXImjmc8Ae1clcUXhQfewJ9DzI/33EbBDIubPHEMuJDqJUK+3A
 TX8LM2lTtJ1goqCeUzcqCU4xqSq30LMnHo2SP03S1jfYGBV3R3KnEsiZt9J8cQvXLMM3
 h9Xg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GT2SCFVQv90K8qDKZjgyaxlyUMQuWz+oCtYI2+KuDbjm/f9TVBRzGVZHvHqhwa30GzO8ms1A=@lists.denx.de
X-Gm-Message-State: AOJu0YxVScHfBotYcU+AV5PT3CaglXKSlDlbw2NJvI9tDR0QkA6SvDVO
 WPJF4ctbcOzMAzqH07ev1kmeSm1z67ty936cmR8y6WEZdD1ZU/G2Q3oiJbq374rc3to=
X-Gm-Gg: Acq92OGOomF1ZmFau/xPV0/nlTlFvWmhPD74VQduPOfN6GWc2jsXjaNR4ksNz9scjLZ
 ODdmsnKR+DxRawVl4Q59DOt2OMAb8FB2RyTIKCWnYhINgDlQk+SO3ElZvJr3bQsXyTm3hCSav/L
 HsYR76/4ywnrh5E5WPoZdVb9LHkmeJc58VaFeM1POQGef6JddakchbzQtPjvCm9CqXLOQ+zguJc
 L8HXCifvLwRV3MAETZMkWo+sW573oVs8L4HOUPlSia18JilOp9loA4rcF0q+HTIu94FLMfx/seH
 8GG13jJrdg3DG1Bk3iYkQru9tlGyVdXM4nUR37CwzzENodpTM6CYu1jWcJoFFdnXjklLnWAVhHa
 iRJaiB2I79IW0TUa7vv6AKupzGTVJ5Eya9AFXFBQWJEjQ0qV4cfFsAWMqRGvd0e44IZy/ESbWlt
 rFzIb4xVd1iJ5gaiAfefUwlbXNtvuXPgbbdhogGB8zA6xpkgrVC/zviWR9rJSI1ShAVRsal72sB
 CD7qYhrjnqbqp09JtPeb/9Sto8z/WiOVOYfYE2NmQHQA1GVcNy6f6tg
X-Received: by 2002:a05:6808:23d2:b0:467:819:dc61 with SMTP id
 5614622812f47-4854a29f503mr14461904b6e.23.1779909905900; 
 Wed, 27 May 2026 12:25:05 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-485544ae8absm8483321b6e.4.2026.05.27.12.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 12:25:04 -0700 (PDT)
Date: Wed, 27 May 2026 13:25:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/6] Relocate U-Boot in the last bank
Message-ID: <20260527192501.GA93464@bill-the-cat>
References: <20260515135245.45067-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kA+nna1efqOXt75B"
Content-Disposition: inline
In-Reply-To: <20260515135245.45067-1-ilias.apalodimas@linaro.org>
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


--kA+nna1efqOXt75B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 04:52:21PM +0300, Ilias Apalodimas wrote:

> Hi This is v4 of [1][2][3]!
>=20
> There was a discussion recently on the mailing lists regarding our
> management of memory above ram_top [0]. The tl;dr is that we have two pro=
blems.

FWIW, you dropped the reference to [0] which is:
https://lore.kernel.org/u-boot/CAC_iWjKFAzpj3B_MEW7-dnOrcAV-rfkhXXo8Bv0KgLN=
P2VJxRA@mail.gmail.com/

> The first one is that U-Boot always relocates to the top of the first ava=
ilable
> bank unless there's special board code to sidestep that. The second is we=
 don't
> successfully deal with devices that can only do 32-bit DMA.
>=20
> This patch series deals with the first problem by adding a Kconfig option
> allowing platforms to relocate to the top of the last discovered bank.
>=20
> It's worth noting that this is easily testable with QEMU
>=20
> qemu-system-aarch64 -m 8192 -smp 2 -nographic -cpu cortex-a57 \
>     -machine virt,secure=3Doff \
>     -bios u-boot.bin \
>     -device virtio-rng-pci \
>     -drive id=3Dos,if=3Dnone,file=3D"$image" \
>     -device virtio-blk-device,drive=3Dos \
>     -object memory-backend-ram,id=3Dram0,size=3D4G \
>     -object memory-backend-ram,id=3Dram1,size=3D4G \
>     -numa node,memdev=3Dram0 \
>     -numa node,memdev=3Dram1

So, now all of the sandbox runs in CI are failing over at least one of
the existing tests, and the Pi 4 platforms over in the sage lab are also
now failing the tftp kernel test.

--=20
Tom

--kA+nna1efqOXt75B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahdFCgAKCRAr4qD1Cr/k
ClQlAQDaExMiyXlbaz3DCZmPqvwI9hHntyRkT02jw4L64SnQVgD/TZQlclzWb6Sa
svjZ/xbkTsTLo/XOGBWxamgsvw4beAs=
=KB7g
-----END PGP SIGNATURE-----

--kA+nna1efqOXt75B--
