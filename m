Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FA5C54E58
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5ADE87F2F;
	Thu, 14 Mar 2024 01:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SFYjNu7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8796F87F2F; Thu, 14 Mar 2024 01:38:56 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C3487F25
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bbc649c275so302999b6e.0
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376733; x=1710981533; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f7a6LDWxAdBS9lLiW4BPxn4582g0nw5GAcTLDZyvLxU=;
 b=SFYjNu7OUxrkyPBgqDZfLZ6TkivhHMS4ijNWnSwtv2VjZRnQUzX9jE5jI2mno1ohX2
 kMExjs8WUwb9O8DfEpT9GJSu4ccT1OU6ZR+2Imc6ifCzUe3hOTD6nFixjejC3Mj0Ayk9
 mAl3lHHMe3jKw+3BmIsCBJHgddhJyrL++Juaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376733; x=1710981533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7a6LDWxAdBS9lLiW4BPxn4582g0nw5GAcTLDZyvLxU=;
 b=svho3D84lpd6FETSLQWE9Y+lYgF1uJGxZTiPBQBBdrxPiQSoLSH+/GVYlFn8vwKBYj
 qzC7Fhy0ghtj/E3p5AdxR9pMSG8O8o0Dloo+9HQCK20dOE4LCKhoucGh1mTd22hcimit
 HZB1eK4IWXzwyRYTuO/ZejfZs+t1LqpKzrwB8ixmGk57YuWh9IyyCV46MxxgGHcB9NAk
 Ln2Ml4nL5+KAkkSprSZ6dvcbz8TCmM5pqbFlXptC4kkoTDBrECYXRQRRmN9mJ/Xnkhkg
 Khr2GnXs4YOm7xN8teF0eacxcTjHgXmL/LWsE7WPJbKgaHbexRkg2N1K4No5rn+xCbj2
 CxuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxSvpKY/LfKh0BGeSwlwAKJ220qMmsm3JbJPg8sDBrm2TZftzsB8e87I0KFOj+vIwm5jLO8fuW3YZI5JYXBTweooVQeA==
X-Gm-Message-State: AOJu0YwkqJ+rOpLLiz3lGzpmH0Gi68EhwIRH52rlLuOwXAkmfL/sj1ji
 5vx7Ol95u8RgRmzG9c872ffXqzEL9AF+TFIUxwcrm2YltlClel3ltyi16r+10Yo=
X-Google-Smtp-Source: AGHT+IExAXGWpYPjOTb+nu22kUgN1LQbSBD9zXG78rRlvp5fTv12ibU1Qnet/zsUZ6M/0LpQKu9iuA==
X-Received: by 2002:a05:6808:15a2:b0:3c1:d4dd:6aa4 with SMTP id
 t34-20020a05680815a200b003c1d4dd6aa4mr410908oiw.44.1710376732728; 
 Wed, 13 Mar 2024 17:38:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 s7-20020ae9f707000000b007885d2f3a74sm172553qkg.7.2024.03.13.17.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:38:52 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:38:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Gendin <agendin@matrox.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Randolph <randolph@andestech.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Samuel Holland <samuel@sholland.org>,
 Shengyu Qu <wiagn233@outlook.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] Kconfig: move CONFIG_32/64BIT to arch/Kconfig
Message-ID: <20240314003849.GC3442575@bill-the-cat>
References: <1cb3255b-5ed7-443b-8a02-6e998126d417@moroto.mountain>
 <b57b0fd3-dfb9-48c4-af0e-076222c85df7@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j0PvY1MH1SJaPqGf"
Content-Disposition: inline
In-Reply-To: <b57b0fd3-dfb9-48c4-af0e-076222c85df7@moroto.mountain>
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


--j0PvY1MH1SJaPqGf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 10:04:15AM +0300, Dan Carpenter wrote:

> These configs are used in multiple places so put them in a shared
> Kconfig file.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--j0PvY1MH1SJaPqGf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyRxkACgkQFHw5/5Y0
tyyXQAv/WSq/Ookgk8LubvBFqhfu693uc58GzmBE+60Nx31rlNBAyBOJTvVEvCpj
L0X4Hc2HTPd4lxCLuRaTnYsc2aRz5bMGMm4GU7qREqv7+jS1vjbxh0GEQxJPD4Vd
rK+a7HMMHIdpc4oSUNM9WLByFCsIk63L5Elf3ZhHVF77ysrz7LCOqJsWU9xtQ71u
MqLrCLb4Bh0PQmzGpJUbxSZuHFx7BmtEYbptUW7Vlp2UjKyeX3ZvL84552IAx+aA
vJOnn0XBwypmAF50eNWnxFFeKzk/eoxefaD1EEn1o5us0WdM99rPj1x/3y6uvKoF
CKOTQfku+bTzCk/bCmLaCIktGLK/pKtfSftoR1+pbusXuMpQk48d2PHPL5X3tt5n
qTKLlGHJ4wEgGL0fpWGEQ39G1hdbwviMkizhPuXBODrHJC+JfyzmX0y2Nd7ZKjJG
nYAqB+R1eafLL91zxx48+BDGToY08VwxT3Op1ZjrgZssFt0A1TXUhFafrWgX4dsE
QAAyUqj9
=vghx
-----END PGP SIGNATURE-----

--j0PvY1MH1SJaPqGf--
