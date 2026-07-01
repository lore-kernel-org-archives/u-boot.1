Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5808C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 18:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6591D84B92;
	Wed,  1 Jul 2026 20:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UfpAEVvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC28E84BB2; Wed,  1 Jul 2026 20:15:39 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F5984B88
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 20:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e6128bd9b3so488292a34.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782929736; x=1783534536; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EHBPsXvpd5pJ0Z1ZBgqdr94Yi3NoRa0yspbuQtYv1L4=;
 b=UfpAEVvn+gtkaJOormqaIt6rSwyYhlUgPi2tpi1btFtCydTQ9Zxyj87ZnVZk3jZZgD
 55MLMyxEkoeYlhKeYvrDTtKTN6wucQcUKwuW9vYC9Z9Dmp0CmuESjXVbc0HNdZ2R7c6n
 lOv2rxHgqxkV3Syi13Xlwj5hnCKGYWMgaPBco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782929736; x=1783534536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHBPsXvpd5pJ0Z1ZBgqdr94Yi3NoRa0yspbuQtYv1L4=;
 b=sB83IJt6YKd9r4z2E6XV9bNGKUCJQ0w+uwwflRi80M8OX5N6r1xFAYHY/I6LYZoLZo
 AYZ92uLkRdX87W6JghJbsvc30FRaneJHsbLSv+6l3krmIFh3AW70Z/mhTlQ+/nZcpAg1
 mF0S83yBwYHhmG2e5+lg+TpOz4Z3jZehixtqj6OhSdVs/IiI5tdMAarx5Q8xpVLFpbA5
 7iCXho+iQJVmBlI9/52dkK5nXqz0SVKMlgl8SJw7XWOjPzT8PnBMfkOx6bySLXS2opmX
 vHtu/NLF+6PYx2OF1T7Tzp3J0Bc2USW1augg0NO8rAWCLlyfXmJK9ReSB7N5zPLLmdLw
 S3Rg==
X-Gm-Message-State: AOJu0YyifdFgW0lCUfAHTiWhecIHpEsnb6w8gatyME+ZPANDvZYGn97O
 tHP1/HFrWBPVv0ylQHQ8IVhlWcC1RCNiqrWmq4ZTF86VJtBWChqjAfjD3U7SG7zFGR/FhvpmYb3
 1wnZm0jKDdg==
X-Gm-Gg: AfdE7ckTcj1g5JXZMjcsdGBWhse0fMMFS6sRaRx3csQTkETPXKJuOlYV83ZV6GRy6XI
 MUkEAwnV5COED0ijNopQM7J6tmNBomp0hkiEW0uLBgR0s/XFtxNV6+C6FKf2rkTFMjqU9Q8Xuh8
 8gNJecYRCId+DWSRWzwYMu84lgAYZWyNQS0kWBoseaQBFI+NiKdNopFDyEjiV4Uyim2QR/p0bNG
 ferPInMM3dhYlaTvJGUt50BdMNmCFGSBuf777qSyPMmR3+NpfrJuL/11+L7xc85pZ/kiGoKLyNH
 DsNMxaS5i4X1Dw0mTOjdc8fZiTsTpydakviL9jM6HHZxSuFiqeEDKIZRYgWZvvXFy4LSlwZkjEw
 VGBiYKI+rl3eNwJsBbQN/09qASrKrJM/UukLbB16W/g3O7F1WL22sMa5Y7Ym63qdEoD2t/8s4cH
 InNZa2SZeQ2BB3CPcwxzAKYlf1SUfRlXy5ClWR2M37SkbcEn9iRKz+8VXXb67nMDSAOGF5CYSt0
 PKkj9Bmnjc9A3gNl7+mVwm9BUYTZHvPVuwmVw==
X-Received: by 2002:a05:6830:f8a:b0:7e6:efb8:fe66 with SMTP id
 46e09a7af769-7eb48b15c64mr1658231a34.12.1782929736131; 
 Wed, 01 Jul 2026 11:15:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb542fd74esm615823a34.11.2026.07.01.11.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 11:15:35 -0700 (PDT)
Date: Wed, 1 Jul 2026 12:15:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH 8/8] cmd: config: allow simple filtering of output
Message-ID: <20260701181533.GT749385@bill-the-cat>
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
 <20260701171535.906272-9-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DesCz7OTqEXXk/Ih"
Content-Disposition: inline
In-Reply-To: <20260701171535.906272-9-rv@rasmusvillemoes.dk>
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


--DesCz7OTqEXXk/Ih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 07:15:35PM +0200, Rasmus Villemoes wrote:

> When doing development, it can be quite useful to enable
> CONFIG_CMD_CONFIG, so that one can always check whether a config knob
> one has just enabled has actually made it to target.
>=20
> Because sometimes, one doesn't flash the right binary, or maybe one
> has just done CONFIG_FOO=3Dy in some config fragment, but that had no
> effect because one would also have to do CONFIG_BAR=3Dy.
>=20
> However, 2400+ lines of text are rather hard to read through. One
> probably uses a terminal emulator with capturing enabled, but
> searching back through the capture file is a little tedious, and one
> easily ends up finding something that doesn't pertain to the most
> recent 'config' command invocation.
>=20
> So make it possible to limit the output to those lines containing a
> given string. Like the search functionality in menuconfig, make it
> case insensitive, because it is much more convenient to type "config
> pinctrl" than "config PINCTRL".
>=20
> Since enabling CONFIG_CMD_CONFIG by itself adds over 10K of data, and
> that increases with every U-Boot release even if one doesn't add any
> new features to one's own defconfig (because the .config grows lots of
> "is not set"), I don't see any point in guarding this by some
> CONFIG_CMD_CONFIG_GREP.
>=20
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> ---
>  cmd/config.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

Reasonable addition and explanation (and having switched to tmux from
screen, I don't have an easy capture anymore, the one regret I have) so
this is very useful. My only feedback is that you should add
doc/usage/cmd/config.rst now too.

--=20
Tom

--DesCz7OTqEXXk/Ih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakVZOQAKCRAr4qD1Cr/k
CufTAP9+Fy+OWnv12atDdUwjI+yAMixf7B5iL4hS3bCCBj16QwEAjh2wGj+7sfBP
R5TwpKrb8xbK4zcVmo8NAcQ8vyxvpwI=
=NP/p
-----END PGP SIGNATURE-----

--DesCz7OTqEXXk/Ih--
