Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FC7FD8FC3
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 15:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 713FE83D1A;
	Thu, 26 Feb 2026 16:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gHyg2brX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F4F83D8A; Thu, 26 Feb 2026 16:08:48 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C4A83AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 16:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so908680a34.2
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 07:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772118525; x=1772723325; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ybwICn6/Djdi5RRSxG7lM5Rsg/aKl1PC4sz2K/nI6sY=;
 b=gHyg2brXg7vfmZGgtJWAR4I3OJ4Q75lGaVyE64f4sjMYi7lusArh6and25VKaBCZB9
 mXWdqgnbn7muvNm6c4Xgrg5Ftu3R33hlHvDPMPt72ehCG9JirFJU/zwPgph4yoc/undn
 vWuMBv/jQv6S1+FoSwfZRzMAktYwfdZmQNoBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772118525; x=1772723325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybwICn6/Djdi5RRSxG7lM5Rsg/aKl1PC4sz2K/nI6sY=;
 b=b6vVTYGUcdxS7jqim6XNM+KrVsZ1rUkj/g2+04yP/K7N4Ay55zdkZy82r4Hu5PWOZ/
 6mIIxqZEh8PL5BwKT3uxIuDb1j5t4Z7vDr2Nr5Sp1eTqaZoSH8M9QWQgVOXJfzD8SZLG
 pqMbAitNPmTRE5tyDeIhXnDE0Va+4teApy6omGMl1s6aC4FxY1ulJFPOaQXnOPXFe71E
 BHQ4t7gXo7NNazVvpgGBBwy9xCRJu35LTeKgUpxk4ozSoPDrDPVKS8I1Yytdxf6ONZsk
 dGkesCZggp40uItWPSeemkuNWmNd3rkaanot8iAxexL4RZWt1gZnYXYf8qC0+szvA+vM
 dNOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfKVGEupTwksWmSDXzn61zuKomT+9BWeGWTqErYbv+EqZFAHEiiwYSXEV0qHXV4lgvpn8dDSE=@lists.denx.de
X-Gm-Message-State: AOJu0YzQ0EjUOSuyoC8DzpLa/Z+wkPIKwaZ/Rllwkfmnz9PONKjwkIFB
 0VIejumstBUIZwv8b7Yeh6CxMeOZAJ0H9ace7u7FA0L2f/IW0XP+RDbQBzWwo23RAjs=
X-Gm-Gg: ATEYQzwfKIEKOsATkQ7D9un/rieZmAet5Svo1fKzxNt3mmKGwOTbpsusGAZphsGB6Ct
 onLU06d+WNiMFtqjtHZDTUYurhHHeDHekcJugQX9657r67i9HaB/tvogfjFNm9ULS2aTE8RH5ID
 2klAhA7qRu9yPTaXs7INZdAveTaxWWaa4S2PnkT/HYx09fJImkxk2qp954zl2JFzro/BQv2/kFq
 ltsl9OYdVriC6kfmmYzQOIuxMd9m9kTncfs/i8Qr6FqAop6HfXREw0WsL7z1ON+q54X+dCbO5WH
 EViUc5qc3oQWHLXTi87Vqljd8QzwJGWFeQfUNF3ZTyWOfB9ONrUyS2yn9YCudrKb2Mn4ftPgVG5
 RidpWmCqWTDjvQ4cVmLHP2yln7b+GMCZbO+7zKJA3onBTl+xgNb4EuwgtbsAh97lkAw5bdmLJ+T
 vQcSfyt4YsMuzWEmF4NhChAZ/ERg7c2cbPti9FW+kY+NayKEcSiha/9k31d6PNF59KBsWn2QeeN
 /kft0+yj+ubHN1u3TeacjCpOU7y04zXyNV9/dbvLHLQXHSdYYY=
X-Received: by 2002:a05:6870:8a28:b0:409:7032:6872 with SMTP id
 586e51a60fabf-415ffe94a51mr2468366fac.53.1772118525262; 
 Thu, 26 Feb 2026 07:08:45 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf23977sm2016760fac.4.2026.02.26.07.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:08:44 -0800 (PST)
Date: Thu, 26 Feb 2026 09:08:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Aiden Park <aiden.park@intel.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Subject: Re: [PATCH] serial: ns16550: Fix return-type warning
Message-ID: <20260226150842.GE1593142@bill-the-cat>
References: <20260226-serial_ns16550_fix_warning-v1-1-ea563e6a26e4@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2dCL9ESU8V/d9jZU"
Content-Disposition: inline
In-Reply-To: <20260226-serial_ns16550_fix_warning-v1-1-ea563e6a26e4@maquefel.me>
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


--2dCL9ESU8V/d9jZU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 05:02:47PM +0300, Nikita Shubin wrote:

> Fix compiler warning:
>=20
> drivers/serial/ns16550.c: In function =E2=80=98serial_in_dynamic=E2=80=99:
> drivers/serial/ns16550.c:153:1: warning: control reaches end
>     of non-void function [-Wreturn-type]
>   153 | }
>       | ^
>=20
> Fixes: 62cbde4c4e46 ("serial: ns16550: Support run-time configuration")
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

I assume this is from gcc-15.x ? Thanks.

--=20
Tom

--2dCL9ESU8V/d9jZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaBh8gAKCRAr4qD1Cr/k
CqiCAP9akLuZCTfYRNbTdrMLfO9gBF0YpvK/w/t6nUBcm8uxsQD/eYIyaPrk1PzA
TEZ5+T/YlvjAwEJuRvjJJQN0KZyXhQc=
=q5PN
-----END PGP SIGNATURE-----

--2dCL9ESU8V/d9jZU--
