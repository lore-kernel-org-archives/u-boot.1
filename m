Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB71CD8C90
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 23:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 253AF8466E;
	Mon,  8 Jun 2026 01:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GHQbNWIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B81CD8466E; Mon,  8 Jun 2026 01:47:32 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898B884154
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 01:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4865e953031so4165298b6e.0
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 16:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780876049; x=1781480849; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H50Pb6mERhtrUo+UW2DPxdopKXHRdfKA/0ipLyyG19c=;
 b=GHQbNWIxvQqgL+wihI3gdPX4b2eGyB/YUmNNcy7VqH5FlYNPimBdINkAMLcxLOMf8k
 E1P7s+7juPZfK8cWgq66LyYj8Fbe3V/3FiDcmnuMYCVMINjyYjgFZiJadV2Yq2wgGp/L
 YeEj91UvQ8MXplnvhMUorfi/o3Y2eS8v1lYAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780876049; x=1781480849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H50Pb6mERhtrUo+UW2DPxdopKXHRdfKA/0ipLyyG19c=;
 b=NGG9yOsxfjb2gWQkIJdRmHwdcBPgobJHgiQdUNLePIZEOFyApABXFLy/cmLN68AtBo
 y9uL8n1sLQsVxtFTC1GnANcWitw/6ZxbmD+Na4iNMB/PWlsOVoJbPx84VGNkQ8rmZHOQ
 CEQVpJctHNgfS7k4ISgEPacPDppZjOA5/0K4vBBGBcKRHtbm44+NUgikYqviPwH8AHuw
 +QdxBrmTze8Ao8aOWY8x08vzCxFrncnuZ/7/j/py0CdXYj1a8N1U+9RGdGPMWYaGxhub
 8omE+lmmJOEQ5DpaN5b5nTqEjrK+cuZFS9l/NeeH+5l677cPbsQ/mthVXcSuovYHum6/
 XjXw==
X-Gm-Message-State: AOJu0YxDO9MiTfaxFFoylV7h4aKAaKaVig4pfe7AUoiFmGEZt2UWAGH8
 9z0zDMIv7X75dOLFRqobRvl5TCQwhz05uf9ZAUyiMH7WYIvXXR+vxwjDaKXfonpoE6H5sVidnS2
 xCSpHFDc=
X-Gm-Gg: Acq92OGlxR9mxucvxVZ7TU4DbC+3604N6Pnq8tN8Dkv+2dfqqle6efCj9oQ4XKs2Z3a
 fnq5ZbGUuR3QVhMy8G4xG9df+JQr7cLDIph3RavmXz1WX+zJpYR0YRzga/VgM8u4Oq4MC7euqNb
 euHUUR3R8NLgJ2pvq40/8Nb1L8SD795j1WXGNYfcEcTQeH5jqH8MSYx0heH3ZYYnlA3Nb880eLa
 /VryZncAV4i9nkekD5YIcgjbJ25Nm8tT55qB070GjAiGk6rprZX2Bg74j/Eh4BKeupZhFaCE2ZT
 T35FUKonyF5aQYFYjNVhXeMdUtejZWbHXdN3wezDuFUKPS6/s54TxwAhiFaeVUicKvuJYs4vdK1
 lK/K1y2KYepknIQw8b2B/0NTGFbrGSHpF+t+vA6BSf9JEK+x7VSqpPBnFjYNG7xwKPl6pw0gv6r
 sXqE2fpwM+Yhr464I/T6u6RGh9mZlkmku0gICQH3bQa2goBsVVjbPdA9sesG5Dh68wDcAONffO2
 3Z1PedXPhhQZd/s0ZR1ESSPzKJvReTZpXNoOOpvEMPAxyHszqqDtzoQ7OMgKg==
X-Received: by 2002:a05:6808:1b0c:b0:485:29c3:3269 with SMTP id
 5614622812f47-48692dc9d0emr6074929b6e.21.1780876049191; 
 Sun, 07 Jun 2026 16:47:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b91f944sm12405283b6e.9.2026.06.07.16.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 16:47:28 -0700 (PDT)
Date: Sun, 7 Jun 2026 17:47:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH 3/5] x86: edison: Align U-Boot via binman to fix the boot
Message-ID: <20260607234726.GF382693@bill-the-cat>
References: <20260607230519.3022520-1-sjg@chromium.org>
 <20260607230519.3022520-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+OViKB45TcJ9hYCG"
Content-Disposition: inline
In-Reply-To: <20260607230519.3022520-4-sjg@chromium.org>
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


--+OViKB45TcJ9hYCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2026 at 05:05:12PM -0600, Simon Glass wrote:

> The mask ROM loads the OS image to 0x01100000 but enters it at
> 0x01101000, so U-Boot must sit 0x1000 (4KB) into the loaded image. This
> was arranged by board/intel/edison/config.mk, which prepended 4096 zero
> bytes to u-boot.bin through an 'INPUTS-y +=3D u-boot-align.bin' rule whose
> recipe moved its output back over u-boot.bin.
>=20
> Commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1") stopped
> that rule from running, so u-boot.bin no longer gains the 4KB prefix.
> The mask ROM then jumps 4KB into U-Boot's code and the board never
> starts, sitting in BootROM download mode (DnX) and cycling.
>=20
> Since the Edison image is assembled by binman, provide the gap there
> instead: pad with a 'fill' of 4096 zero bytes ahead of the u-boot entry.
> Drop the now-redundant alignment hack from the board config.mk.
>=20
> Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
> Signed-off-by: Simon Glass <sjg@chromium.org>

That's an unintentional behavior change we should understand why
happened, and then do whatever needs to be done to fix it, so that other
platforms that might have been in a similar spot can also be fixed.

--=20
Tom

--+OViKB45TcJ9hYCG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiYDCgAKCRAr4qD1Cr/k
ClHTAP9XP8Iu0o9tMxrdAe4nws6ee8un6k5Ic2WxjOr56NNS9AEAs7UNUt6T5JQ4
4geTYmWZqVjlMaor9paRBtM7LGTYEAk=
=g1nk
-----END PGP SIGNATURE-----

--+OViKB45TcJ9hYCG--
