Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68DACAC58E
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 15:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0EB382FC7;
	Sat, 13 Sep 2025 17:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g4JOd0NQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEE8D833EB; Sat, 13 Sep 2025 17:52:00 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9010A82AE1
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 17:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3f663c571e2so29038275ab.0
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757778717; x=1758383517; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lCWrRPMdxOHsbpQNfgWAI75OJGeg4cXFBKXdyXqxv1M=;
 b=g4JOd0NQ2HMx9WX3/yckquhLr+D7oqMJ8VZdfBJQHtgbOgHejfgRjG2AdXa2e7gM9N
 BlGP+2nxOgB7VNkdulDMI5aHuRu6zH803A+mwjcRsABJjm99K8oJm+PT/2jmnQElj+VD
 X7LHWscwvAIs6jfz9gH6TdOQQs4RtVs2s1L90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757778717; x=1758383517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCWrRPMdxOHsbpQNfgWAI75OJGeg4cXFBKXdyXqxv1M=;
 b=hSTr3t0tls4VGX9XwMG3VrJXN+7kaKeGad1oB7brIfLHKU0DlRTV45A/Y1mcSwt0HJ
 KHjsFFj6OqkiriaqhnJa42rvzU6vWXuMThn/S86rP9ooL1P8WtYWKP3ApU02Kqs8Ytos
 e7Jk/0UKD2Tcqd3z5gz7kXuiBn4PSrVCCIdBYjKQ8cOh2RzOvlWkKlJ4PwHe5kwaS3Ae
 A+Wets+eSTEcGNStLNJgIT5t1mN6JVacO53O41G2609a/nZDqPxQ/iuff74qubpWhygT
 h8abKfuKHWI+54Szdy3NjIBjYSfwyAkRbuRk1nkCFCAg6llNjZ5xQ2Jnm+f9XoFWCFTE
 OukA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXfVvS5UrAxtO/tTA1srNX612gnJe8r5LnAoSGcleiiDpEmStdXPIGtCOsfC6RgXqHQOMzs6U=@lists.denx.de
X-Gm-Message-State: AOJu0YyiNmAPkP0qxcCeCrOB+K2j+ELb6ZJ8ahMUa3+VJpwerwG2Mjt0
 AGylxBw+JnSXg6HfDiH4y7sSMnkh8sseLKPEhGuySh4UYJoi5M2DAveoDlXb53vDXDvQ3XpFG9x
 9cvGf+F8=
X-Gm-Gg: ASbGncuNSwS6SjngclOxznIihiD5+TlKidzJI/1nn0C+SF4B8bVZYTIMC7nGy0eukA5
 gGaKcnSlEG+4SFr7E0BmI9FlugOVUmplVRkBWymMLtjzUTSGg+XzKam8n52hiXaRoIVgo5C5YQ0
 paa+V7zdabj0wwAhWgmK6vsUiDzjwBHdEFkCAXoLW8/BndFu1pLDLizEbYtq9oVZfb4cSyJA+P8
 iW0ZMTFtUqL5QFJqtFrb/vYyWTysx4JD4Z/UFN75gmJWv2jPMA8yw2QXfYk7t5sZebRjDSLfszg
 rywME/WmAys5dy14xn+vEC6XpUpBImc4b5eeMF711FmWKToJ+xmWTnuavqmodhjwTHAbT6jeUNU
 USfORSQArvXqervajXnB4ZG9FCeP+q5KjZr8U+9l/Mnzd7jeD+WEAGxQliXT0i8Zk+Rc=
X-Google-Smtp-Source: AGHT+IF1jqV9mWo2lMY0Nq09GU20enCd5o7ikIJhROHiBa1MkwJwq0CWG2Xs0v/IB8GpulFcta5mqg==
X-Received: by 2002:a05:6e02:1fe5:b0:41f:8265:4101 with SMTP id
 e9e14a558f8ab-420a5782009mr78715045ab.30.1757778717285; 
 Sat, 13 Sep 2025 08:51:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-511f2efc550sm2824953173.4.2025.09.13.08.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 08:51:56 -0700 (PDT)
Date: Sat, 13 Sep 2025 09:51:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] power: pfuze100: Ensure loop index is incremented
Message-ID: <20250913155154.GF124814@bill-the-cat>
References: <20250703-pfuze100_fix-v1-1-5f838e29d122@linaro.org>
 <20250831153513.GA2800031@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wYOhWtu/pc74PrcY"
Content-Disposition: inline
In-Reply-To: <20250831153513.GA2800031@bill-the-cat>
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


--wYOhWtu/pc74PrcY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 09:35:13AM -0600, Tom Rini wrote:
> On Thu, Jul 03, 2025 at 12:31:50PM +0100, Andrew Goodbody wrote:
>=20
> > The for loop in se_desc uses i as the loop index and also to cause the
> > loop to end if the passed in name is not found. However i is not
> > incremented which could cause the loop to continue indefinitely and
> > access out of bounds memory.
> > Add an increment of i to ensure that the loop terminates correctly in
> > the case where name is not found.
> >=20
> > This issue found by Smatch.
> >=20
> > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > ---
> >  drivers/power/regulator/pfuze100.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> I size tested this as part of merging and saw unexpected shrinkage. In
> turn, this got me to look harder at the code and I think the best answer
> is to refactor things so that se_desc(...) follow the normal (linux
> kernel) pattern of for (i =3D 0; i < ARRAY_SIZE(desc); i++) instead of
> being passed size. That's I think the root of this confusion too. I'll
> post a patch shortly.

While I really wanted to make this suggested change, I'm just missing
something as to how it should work, and perhaps the better answer is to
rework the caller a bit to handle the check inline? I'm not sure...

--=20
Tom

--wYOhWtu/pc74PrcY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMWTGQAKCRAr4qD1Cr/k
Cjv3AQDXHu0sfeUVt/TQK+RPLv4Z9Q4CUj+1Y3y7xfyvMHu7iwEAwIpN0OG1Hp3J
+NF46QM6V7Kgx1T9L8o1N2KrTExXyg8=
=PuOW
-----END PGP SIGNATURE-----

--wYOhWtu/pc74PrcY--
