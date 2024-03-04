Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3DCC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B514987FAC;
	Mon,  4 Mar 2024 15:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mN6YRwxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E11D87FAE; Mon,  4 Mar 2024 15:16:32 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D289987FB9
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7882b1e87c4so24288685a.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 06:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709561788; x=1710166588; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NeePnM1mF0q3uXlEDYy3Ay9tCOjZZsgLBPvEkFXFxnU=;
 b=mN6YRwxzmAL/zmQKkkCmX8QWbM2rsDiQlWak8cAUpuClIGo8wBBpEnLElQJYa5dPLq
 7lVKTKoUom7HoizCej4HkPqg5uqJvoQ7N4zyQFXVlxEERku/5WKKH1etVKjrGI0zJExn
 DH6Zzy5BbntFKtHeTODWbcyD9kEvg4JAbH23c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709561788; x=1710166588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeePnM1mF0q3uXlEDYy3Ay9tCOjZZsgLBPvEkFXFxnU=;
 b=L3yrthb9hCWnnA3/pjqZ+Ik6GGIM9CF5w9CALZkIE/SVUO7UQa6k54myU2DUQmUSmS
 pCm+Y5FFqblLrfcnWQxkL5xpTC6PueAilbDdXZOx+o/duXOy2TkNueOB/JKEtWs3JWvx
 kM1BzDgEfwm0GiVqaJ57SBb87soc43Vl/J838SBaWd/5PDt+i4oRJ41WRf4XH2EcEKKr
 ihMuOXA06zgdBsDA2Qh4yELbl7YJ5ISNksvEEHj+Nh3U/+CS3toxZLm+h2WNJG617/eJ
 nk/DZc+I2KsULLt1JPicm8dwxUtoydPZqww/yhmzsQbcmPz93HQOcBWnypMDUgEqZ6B0
 KWJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGGHB4h3+SESW//VdO34NuGPSDVSJFZ8drbEC5RePXYT9IXsDdzPPbGkq0AktKnzlz5AQO0zG3oIddVtKLHrEEhxXwiQ==
X-Gm-Message-State: AOJu0YzkBz2282AOGaCONGMvPz9f9ONuuW19r9ZrDEu48Py7FFttfCGm
 D/mKubffeI52xatHvipummhIj4mLRT/x8uHkBmtfst5B/1ivPuZjn53Lnitsn/o=
X-Google-Smtp-Source: AGHT+IG07eWYLX22i9MbFCILnE0i3KhWe8b3/kRIAOsoPHoNQ6L4wCX7ZQ809eqlDWd3oL+fHrbedw==
X-Received: by 2002:a05:620a:4047:b0:788:2420:1c1e with SMTP id
 i7-20020a05620a404700b0078824201c1emr5091351qko.3.1709561788562; 
 Mon, 04 Mar 2024 06:16:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 c19-20020ae9e213000000b00788228fbe05sm1650258qkc.17.2024.03.04.06.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 06:16:28 -0800 (PST)
Date: Mon, 4 Mar 2024 09:16:25 -0500
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
Message-ID: <20240304141625.GG1523872@bill-the-cat>
References: <1cb3255b-5ed7-443b-8a02-6e998126d417@moroto.mountain>
 <b57b0fd3-dfb9-48c4-af0e-076222c85df7@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UX3aifqAQjTxZs5r"
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


--UX3aifqAQjTxZs5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 10:04:15AM +0300, Dan Carpenter wrote:

> These configs are used in multiple places so put them in a shared
> Kconfig file.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--UX3aifqAQjTxZs5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl17kACgkQFHw5/5Y0
tyxK9Av+LMlN6WTJGzaTmTSWokCKrMvxEaRjrIeh82PwJ13PifPVgCi3t0ByCG4W
5HYLxCw3hhHR1YOT7ksU4KiWT5KWsKmuvhajTZ9AhUsG6Hvde6poUaB3Xj0RfZl9
j+isp+B73CFlk7abkSBjj3FoOoSemSd57MoOCfD1AD/eyV4IMeE/Vd8H+v/suD7p
0fCtSyBmDkIo+BlyHXyudiTOJlybaNgn/CBT/K0Sg2V+YdE6YqweHPZjxqea6BWX
jq0cRQZz5bHKe/Gn8JMq2T1c4t0bkuaqx9M1rvvczZQlwrO8kpMX0R6mX+8KxsEx
+/Dyqgxrj2oUD7hsyL43ku43JPbUz/iZqyK6nXqpu4YayKi/CBsqrWD86G0688mn
uo38S9ULz0z94uF/ccnuKXAbc3Tbx2K4+1J+ALOeKqWzSl2li8+bcLYELvU5YrDm
auKr3QpH1R3ShlHG0e6IReLgWupS6lf7UW4MaXDeejXqPPQaXfx02ZTdkYE7/qdf
9JA1n45V
=tVB5
-----END PGP SIGNATURE-----

--UX3aifqAQjTxZs5r--
