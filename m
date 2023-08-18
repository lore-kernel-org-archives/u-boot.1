Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21498EE4987
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0377186F00;
	Fri, 18 Aug 2023 19:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OdhlP6Tf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B93786EFF; Fri, 18 Aug 2023 19:49:48 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B297486F6A
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58c7bd44c7bso12147647b3.0
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692380983; x=1692985783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ILwH6iBy/fssWogMuQAZXv3PBWHKbW2vnKRIkiMqUMA=;
 b=OdhlP6TfjqwDDLOrneh3aIPOXUKYgmiunZ9Msi3eO//BZtJU+WrreFW2ZRzdZc6YM9
 rXLZdJ8uxF599Nb+5ZKAnOUxNh4/fjndxh9V+rvtw5iAoM7YjfEehR9wH9CgUQ5TuAgX
 b6U81R5CAi+5TFfOf6zT0dtZYsPaoziegsII0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692380983; x=1692985783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILwH6iBy/fssWogMuQAZXv3PBWHKbW2vnKRIkiMqUMA=;
 b=FHs7kWNSA6DSDZXnMKZDP1XtPDqBv/XjlsxzNk/Jb6TJfq2c57uoD96T7LXTgN9KGK
 2oNAbD0GI5UepvUQ2x60ECod0frhPgXeKtliIpfTq2jZqRImshSSpQviuI7X0dN0ojsI
 tuKEGsdnHpnjQPZFuBUEoxlrIXOG29VLC7FKpIiBhFza2WiQhwbascWWX9EWKSVbd/+T
 TNXq4Ufr46IA4YghoAEsAC+m0rtGefGRklIddJ0idpOuaF6BZtcpLjPspb/c2UHBn0jJ
 rkL1B5tUJ+gdMo5tg/E8Oe2m7plxik1+xDuGP+UdzYtsduDZdzUULwARZ6CqqfblWCIi
 CG/Q==
X-Gm-Message-State: AOJu0YxmJMC8fOuajFJi8+4WqAL86Wo6aKGE78uS7lfY7hZDXeCb5i2Q
 F9qsY168VS0WMM0KlbRu54PLqqig7CG9URrO/aOSmA==
X-Google-Smtp-Source: AGHT+IHF1gr5Lg8zlbep0oJn1aSX95astNSBjFWmiJBIW2Ih3NJptvQHDb3vRzPkfwavs9DEkJaYpA==
X-Received: by 2002:a81:7142:0:b0:577:65ea:78fb with SMTP id
 m63-20020a817142000000b0057765ea78fbmr3250432ywc.19.1692380983394; 
 Fri, 18 Aug 2023 10:49:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a81b402000000b0055a07e36659sm616299ywi.145.2023.08.18.10.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:49:43 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:49:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Naveen Kumar Chaudhary <naveenchaudhary2010@hotmail.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com
Subject: Re: [PATCH] arm: bcm283x undefined reference to "print_cpuinfo"
Message-ID: <20230818174941.GE1515023@bill-the-cat>
References: <MN0P221MB0873D775A88123A7065F171FA208A@MN0P221MB0873.NAMP221.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b6cSTmDWG/+Q7e3Z"
Content-Disposition: inline
In-Reply-To: <MN0P221MB0873D775A88123A7065F171FA208A@MN0P221MB0873.NAMP221.PROD.OUTLOOK.COM>
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


--b6cSTmDWG/+Q7e3Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 07:09:35PM +0530, Naveen Kumar Chaudhary wrote:

> Builds for Raspberry Pi targets fail when CONFIG_DISPLAY_CPUINFO is
> enabled and following error can be seen -
> common/board_f.o:(.rodata.init_sequence_f+0x90):
>     undefined reference to `print_cpuinfo'
>=20
> Added implementation of function "print_cpuinfo"
>=20
> Signed-off-by: Naveen Kumar Chaudhary <naveenchaudhary2010@hotmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--b6cSTmDWG/+Q7e3Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfrzUACgkQFHw5/5Y0
tywydwv8CIEOH+ljQN5JhszUSR5Yhrhy/a4DwvM9Ujlm8kpIpn/zBzascdeXNBZZ
CjSnrmeDtx6BREVOZfAu6O/D5v7moKNDvMAKhuhWZE2M+NZg3c8M582LD98Gm72b
MTj/KI+dcWZDnTLN/igLGmVICC5oZhOr+ots2wmr7t4AE3ro7zOmAqz8ilN/m/GO
JjRuz8wxzoV4TFKmRLshPOsDySW8z4XYdOo8d0lUynPWVuiHZwV7rzQhEyep9nBV
kv1LnPYWAND/gaZCm478gzEAc4tLfUKonE40UdnZatF4mt+S1ZmMEpjgRLl4k1N6
sd+XNnu+B39W0bg45F5BCEHupqrAHpVMrJ8ey0HNGDSHaRmCFFKLJFC/JBc3iLQf
Kall00GAoeLyhm0zV449PuzT5efVVuQkxufqiUIcYW+MXvZpIRlIxXCd83rJ7VAs
wr//fprrwMuvRwL5SbshndHa/F7TmB0sxuT+43l/MPJ1I4ydCJht/4m2KvSI2a90
WtJB4+YM
=GM7j
-----END PGP SIGNATURE-----

--b6cSTmDWG/+Q7e3Z--
