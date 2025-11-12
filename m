Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05B7CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 13:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 498C783C64;
	Wed, 12 Nov 2025 14:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VdNtDweS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF0C683C72; Wed, 12 Nov 2025 14:36:05 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4413D83C54
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 14:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45033024e45so330923b6e.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 05:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762954561; x=1763559361; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S7n12eNuGicp/V/TwdUxy419pLxAWpEPiE2lv/3+HyE=;
 b=VdNtDweSfcwmPLYTvd1nR8T0DYBxLcu8226vB1bYzTvMKEFxuwdkxxBINgwnsLagTk
 lKFwUqHhzGl0zcamVHIfw0G6CtmCxdpL2t5zFaXgFKapxAx8Diw0nl6gdoAz6oXrLtg1
 X7fICw6iCkURTtLrsZGNxG3OsDUntWuE26cmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762954561; x=1763559361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7n12eNuGicp/V/TwdUxy419pLxAWpEPiE2lv/3+HyE=;
 b=vLKX4ruYNYyrRprqqx0etmXVIRkxujhvwybL++Mf9B6UmN7mSIWaZReS7Rb1i1eM17
 fF2rO7zkhe3wwNKjxsmwaPTYjMkbVaJMkrZaUX1Nd4BeZzJrZ2FIl1CTWEuU6CrbG+Jn
 GeeGcL9PETIkRr2ozs5lOEe/9f/+ktbl8f+h5qtA84rPxdv+ymz3ZmmrsuO5APlBXhw2
 FrFY+xoy7X3RrYXvLaJDUut8NLJiVECdfQ+tKqZlCHdA2dRsILKTr73lFjk52ad51khg
 UVZgVsiHPvBSsI6cZ7uIERqsgxhj67moFCHSybq4+z+4jme1d7XmLctAje9TzTCJPMo2
 XxSA==
X-Gm-Message-State: AOJu0YwFOUKjWqKwuWjl2X6tZZujb+wUSa5yCf85jbQ/mIEax9zbKZJZ
 BULv7iGVAApHEXf8EF4t2wzozSphx5AGKS+fqPb3bs8VoFEWIMjqQ70Zbjhi+yker+Q=
X-Gm-Gg: ASbGncsbrQ7Omk8Bvx/+fkE5j49KDRcOTm3Zov0jHPqLwWeShyN2R+oxR+Pqo997PTG
 IyqSxuNvBPWTZeMQ/TQK1C7iU+n1hd8kUPWpu1czwGj1lQl09nMGbJ29M14n8TSQOIcw37b8pTd
 VlCHPLl/HFe6nQjg9dS1VdL4mrJsRTgvCVLU6BUEbrPZx7BHgWEOVNDKSx3SOLi8SoezEc1yQ7M
 /41q0g5gzLPLRjX77u7buQ1jBBxqGVlqLeVKLQVv/eg2Ytt5e/1ae9eTOoZkDKXEsUgBCV0TQXO
 ttNuT8x2/2VT38MaUIwYsH5XRSIyJZ55L+7LKjP7jsSvz/TltkRH7sEaek9MkerK0vEjjOrb0O8
 JGF9iXkSUayTxDewV6F24Ab0v9LLD1rB1mvfEgyxyK21aY1J6a8S5yxp9SVSv0wjJaXiumRvXwv
 3I6QGvWLL9qSY0kRLjQ1fjiEopaqy7Uu2/ee+RrLo=
X-Google-Smtp-Source: AGHT+IHrfyddyOPmrqHG4nC6TxxOaQ9O0vToSybhflHrhb9713taeezTxbCaXOoypivfCBdedsU96g==
X-Received: by 2002:a05:6808:1b14:b0:450:3c7b:e7d0 with SMTP id
 5614622812f47-450745997camr1279626b6e.48.1762954560880; 
 Wed, 12 Nov 2025 05:36:00 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4507467fc29sm1060831b6e.18.2025.11.12.05.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 05:36:00 -0800 (PST)
Date: Wed, 12 Nov 2025 07:35:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] test/py: Use aligned address for overlays in 'extension'
 test
Message-ID: <20251112133558.GY6688@bill-the-cat>
References: <20251112020230.414101-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8XlnXWkKXuIGonVH"
Content-Disposition: inline
In-Reply-To: <20251112020230.414101-1-marek.vasut+renesas@mailbox.org>
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


--8XlnXWkKXuIGonVH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 03:02:21AM +0100, Marek Vasut wrote:
> The 'extension' test would set 'extension_overlay_addr' variable to
> decimal 4096 due to conversion in python. The 'extension_overlay_addr'
> is however sampled using env_get_hex("extension_overlay_addr", 0);
> which converts the 4096 to 0x4096 and uses that as DT overlay address,
> which is unaligned. Fix this by setting extension_overlay_addr to 0x1000
> as intended, which is aligned.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  test/py/tests/test_extension.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/test/py/tests/test_extension.py b/test/py/tests/test_extensi=
on.py
> index 61223496054..ddc62e7d5ca 100644
> --- a/test/py/tests/test_extension.py
> +++ b/test/py/tests/test_extension.py
> @@ -38,7 +38,7 @@ def test_extension(ubman):
>      assert('overlay1.dtbo' in output)
> =20
>      ubman.run_command_list([
> -        'setenv extension_overlay_addr %s' % (overlay_addr),
> +        'setenv extension_overlay_addr 0x%x' % (overlay_addr),
>          'setenv extension_overlay_cmd \'host load hostfs - ${extension_o=
verlay_addr} %s${extension_overlay_name}\'' % (os.path.join(ubman.config.bu=
ild_dir, OVERLAY_DIR))])
> =20
>      output =3D ubman.run_command('extension apply 0')

As we often get patches to remove the "0x" portion, can you just correct
the format character? Thanks!

--=20
Tom

--8XlnXWkKXuIGonVH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRSNOgAKCRAr4qD1Cr/k
CtNpAP46t2VFfQvsQFoYlqly0OJG+4xejOXtZaPVn+V0TuSV1QEAugPvLFdoWOVf
lnPGbOJZEikgUxA92JciObnK/FUfQAM=
=L7b+
-----END PGP SIGNATURE-----

--8XlnXWkKXuIGonVH--
