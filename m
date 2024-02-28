Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9483C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 13:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB37C87D07;
	Wed, 28 Feb 2024 14:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CfkDYEtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D104788065; Wed, 28 Feb 2024 14:10:36 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD92688060
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 14:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-607dec82853so57400257b3.3
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 05:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709125832; x=1709730632; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OFpfQ58+g85L4XIT1yB695WTNr485st4KAzfhvBaDd0=;
 b=CfkDYEtceeBvu8SFvwiA6wcblk5h243K9fMlX8tbEzHK0J4cjbfTHqCo/vhNYx49cJ
 dpQFzr4KrzPfIwKab3xErf5EPUq+kFF2HqFUbwpFLvF5EcK2/tw8/15r3DaNPYMt3MZA
 /gFzn6ZEbyWP/RJdFCu287miI8jPksPzU6rV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709125832; x=1709730632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFpfQ58+g85L4XIT1yB695WTNr485st4KAzfhvBaDd0=;
 b=Ov37mDN/uF5KtfQ9OkmSWG8x7B8gP/k7DScs/iIHd5gWWisgofY7cjncVdQuj2+O9P
 1WHDFW5Ru3CBOVm0W12CoZk42jF0phh7GIVDI7vxqov0TVrW/MPRju3mu/9fhk42dAnR
 pSqoGb1U6SI65HWAUgWvmnvx8IaPEtHU+nlCyi3WUvEHuCP86NI3RuMgO3KrIw03Y+iM
 hs7BXz5TXiujviIgEPWX3wWWsldiTGymmpfpX8oUa6ALdhi5Vr03I9q0wZauNu8kv+dW
 bvJ43/FvbXlclG7/tYCFyTFvSgXk5SVukzKW17YZAh++bblNWQXtQCC8/YwAh8za7Kd6
 a4TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlkGTm4mvVQKhYpOuPkmSsFXnV+xu6OigJyKmjaj/MjRGhjFUB5nF+LmAL9eE9EOYlk/kbj7J0kJG6T0Qa9qPms+aMaQ==
X-Gm-Message-State: AOJu0Yznd1TemipYtUzvWM7KN5TmZyrTiWIu6Zozo3lgZ0Y//eLW11De
 8CjQFt1gyrEtwobxP86wXy1X908cmyauOI+xVrUMx0C8Zj496FHJQ2jWZfnT2GatHvYZb0LFfKr
 K
X-Google-Smtp-Source: AGHT+IHj0b8+wQ/mgrmYwOD9Q34HGldjWg7hz237uHjJ/9WxXlzyBGHWGmwioCkoqgyX1IxsAk3+yQ==
X-Received: by 2002:a81:bd4c:0:b0:5ff:a9bc:b7f with SMTP id
 n12-20020a81bd4c000000b005ffa9bc0b7fmr4812018ywk.21.1709125832495; 
 Wed, 28 Feb 2024 05:10:32 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 r135-20020a0de88d000000b006086a467647sm2384309ywe.56.2024.02.28.05.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 05:10:31 -0800 (PST)
Date: Wed, 28 Feb 2024 08:10:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Rob Herring <robh@kernel.org>
Cc: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Message-ID: <20240228131029.GM3040305@bill-the-cat>
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sd5E6WiQrdPeK/+3"
Content-Disposition: inline
In-Reply-To: <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
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


--Sd5E6WiQrdPeK/+3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:09:13AM +0300, Dan Carpenter wrote:
> On Tue, Feb 27, 2024 at 04:40:01PM +0100, S=E9bastien Szymanski wrote:
> > Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with
> > linux") removed the display timings from the board device tree whereas
> > they are still needed by the mxsfb driver.
> > Add the timings back (the correct ones) in the
> > imx6ul-opos6uldev-u-boot.dtsi file and remove them from the
> > opos6uldev.env file.
> >=20
> > Update the opos6uldev_defconfig file so that the LCD turns on at boot.
> >=20
> > Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with lin=
ux")
> > Signed-off-by: S=E9bastien Szymanski <sebastien.szymanski@armadeus.com>
>=20
> Huh.  This is the commit that did that upstream.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dd9aa4d4fca67823838fe9861456201430c545e69
>=20
> It's interesting how the timings in linux were always slightly different
> from in u-boot.

Thanks for tracking that down, Dan. I'm adding in Sumit and Rob here
because this is a recent (rather than ancient) example of one of the
concerns about OF_UPSTREAM. I think the commit in question can be
summarized as "remove a bunch of explicit HW information because there's
now a Linux Kernel driver that determines that dynamically". What do we
do next? The old information is in a presumably valid binding still, can
we just put it back and comment that consumers outside of Linux use this
still so it's not removed again later? Or am I just missing where we can
instead get this information from the DT still and not need to come up
with a new driver and subsystems?

--=20
Tom

--Sd5E6WiQrdPeK/+3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXfMLoACgkQFHw5/5Y0
tyyBxQv+JklGqftboTkCBrUwEc8lAG8QZdxWrafSSIDseyV1TCVQZwobUrUokBkr
LN+pk51pcUCi6ZyBOGdHumT6W0eNObt5UuNRAAaGaZHKqaSZ/i7xqgrBQP/m3vpk
JnrShG/rroCeay1f4s2uKrz5xxc5GFMZct8iB57lfv2auPkQ2xpJPhpuo1dSaOeb
Miam0ycjRscvesLdbsCpg14mgJCbIoBsOL+56C+lRoCk24dZ79CKZ+tGO66kcaSL
7UuAYWD68RVwjLG0n/+Gq6fvyRmg95iHQctpG5M3tMZEuSMHZjio0BX0L4+u1Qk3
DcDJFXfySMCnPoX/b3H/EZZG+5RAmSZLjPO2AGAMxNQ09KILi5gXvuFaQTuljYyn
PZrFmWnfSWMykw+BGb3PqYVqPTH+PAmIIBBdFrhOF21y37ZJvmw8IUMKLUnxeSYi
0Em8NdVvfvCSuNenIxtCRIqj4FW2HTOTZhrY61C+ouxnQKxlBy14ttVQCW8B3k9P
Qtxr1+n8
=OAE+
-----END PGP SIGNATURE-----

--Sd5E6WiQrdPeK/+3--
