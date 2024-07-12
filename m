Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7409C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AA40887CF;
	Fri, 12 Jul 2024 18:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cyb6G9pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AB5B88791; Fri, 12 Jul 2024 18:50:32 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F402488204
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3d93df6b54dso1249131b6e.2
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720803029; x=1721407829; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LR2X7MBxdk4C00WS/I/bItXDy0jRMaYwgG82kIKPqdo=;
 b=cyb6G9pivF2oLAooCnz47nHDoXeWEm4k2T1+Ji78O9WVXd1dJpKkJrLPFJsi7kJdVt
 7ai2x96YfJztV/bIpPQpnvlB7cg6CKRnaWgFqjiDtzM0WlCmbpPhQ+k8Jzio8QgLUjMp
 CLyhp900l1uaR7F95snyuJdUVkpBu75xy41VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720803029; x=1721407829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LR2X7MBxdk4C00WS/I/bItXDy0jRMaYwgG82kIKPqdo=;
 b=Z/T6wyOZUPk3ILEqzG/qIp/R4NBcJxa2ml5g2ibpozchOfUsncijC9zqX3ilSYLrhg
 WgHNbdbWaQ2VPr1Jxm4YkGfx87zPWScVhk43n43/WD6PLg3mH8+CYsm92Sct3jfbjr+g
 01tJkndkVh41Mp8agsr2Y1llFvnIbV+TPkCvEn3WZbKmWBo4fXNky5U+1uylqlNLYF6f
 XGZnQ/TvzXfh+VEX+uB5DD//TgUKLAmE97dTx8mSbAOJZljseKiE2uSPEBiBncf3hEew
 DIy9AzVTb1PX4vFmQugnlK4UT3cNYxe458S8SpDqXmc9LY/pRtsqIeSOBb+0ORNr51Uo
 t2xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+8Z/J/H7W4j6nB2INPx/GWv726vz4ITGwAtdtH1alj627MJVFX1gI95s5KY+E90pZERg8kp4rcKO25KWfHaVMyY6Lsw==
X-Gm-Message-State: AOJu0YyIyHUX9iUgT/fYTX75NS+Z0HbWX4/JSR83UfSDavZ80GHs9svG
 1RIii9IsqJRYD6Kxobz0sQyxvonaLmgOjNBh8+9lKbdFce2hMABzq4wTAf3VdXBaTCG0l1fEcQ6
 f8M1qHg==
X-Google-Smtp-Source: AGHT+IGEw471RhQ+KO0RWrpEZVljs2kBvGe0RcpePKO4HTz6HAYiGgmkSUstwqL0gcR5zSLKkcdE4A==
X-Received: by 2002:a05:6808:221a:b0:3d6:3106:52bb with SMTP id
 5614622812f47-3d93bc0c140mr15606810b6e.0.1720803028694; 
 Fri, 12 Jul 2024 09:50:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7044ac2876dsm992161a34.2.2024.07.12.09.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 09:50:28 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:50:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Phil Sutter <phil@nwl.cc>
Subject: Re: env: CONFIG_DEFAULT_ENV_FILE and CFG_EXTRA_ENV_SETTINGS
Message-ID: <20240712165026.GX38804@bill-the-cat>
References: <CAJaLiFzx140yJxPs=x+1Rm0+j+xT3cXBN8svqaq6XW9_D1CHyw@mail.gmail.com>
 <87o773m3h8.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YHAZ/EWpN+wBFqjP"
Content-Disposition: inline
In-Reply-To: <87o773m3h8.fsf@prevas.dk>
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


--YHAZ/EWpN+wBFqjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 10:14:27AM +0200, Rasmus Villemoes wrote:
> Tony Dinh <mibodhi@gmail.com> writes:
>=20
> > Hi Tom,
> >
> > I'm trying to move some envs from a board header file to the default
> > env file. I recall that the envs in CONFIG_DEFAULT_ENV_FILE are
> > appended to the envs in CFG_EXTRA_ENV_SETTINGS. As you mentioned here
> > before:
> >
> > https://lore.kernel.org/all/20220810170439.GJ1146598@bill-the-cat/
> >
> > But it looks like envs in CFG_EXTRA_ENV_SETTINGS are completely
> > erased, and then the envs are populated with what's in
> > CONFIG_DEFAULT_ENV_FILE.
> >
>=20
> Author of CONFIG_DEFAULT_ENV_FILE here.
>=20
> Yes, the point of that option is that you supply the entire and full
> intended default environment in that file. No U-Boot CONFIG_ options of
> CFG_* defines or anything else affects what goes into the default env
> when that option is used. [At run-time, U-Boot probably injects/sets a
> few env vars, but that's true regardless of how the default env came to
> be].
>=20
> I think there may be some confusion with the much newer
> CONFIG_ENV_SOURCE_FILE, which is another mechanism entirely. In that
> case the pointed-to source file is sent through cpp, thus allowing some
> u-boot config stuff to be used/referenced, and I think some further
> bells-and-whistles also exist. I don't know if CFG_EXTRA_ENV_SETTINGS
> are taken into account in that case or not.

Yes, I think you're right about the confusion as I too missed that in my
reply.

--=20
Tom

--YHAZ/EWpN+wBFqjP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaRXtIACgkQFHw5/5Y0
tyxD9wv9GVtJNOUD5J1ZNxZLAdPwqFeZDaCx4eN6ezFtbesrmwzIE6U0ZUhq3Hf+
t+AOoP8vJTKtTJRCjiohsrlo+x1no1fIddlAGiNrUs9LtXGcOK7uG6uauR8GXhmU
CHe8pJPwxtQOm48uO7ayCxmvIX0LP1U1n5esiQ7Y77gxRGmVQEGMMSicLFOQmN8g
wmY7hJT2b2YyB5fdMDDtrtaTFALnCrj6CfwI+Jacg6AcmT7K+w7oyp3vEtAbPLwc
5h2mcmQTkLeJm1R8gSos8iPM/f7gzBa1KHkzh6KbjnL7AB+6sojJ3GLlpMmL2LAR
VI3+bHkNXKXCsc2Ij3PatZ1lriyOY8TRx/T95AinrPg/hFXLP3uUVvF9NV626KGq
vnfdLahOGMOUYwj5K909wjFAOBu3Gyvl2ljHCCy8bdvY0R2m59SKAVEDeBAr5UBR
MJA5MfbH6Kh10bZDP/M3xKXiNFabnQH3knK4S2CrB1mquXNGo0omRaeQ3q/LiJrE
65zX3MSH
=0/ko
-----END PGP SIGNATURE-----

--YHAZ/EWpN+wBFqjP--
