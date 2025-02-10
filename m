Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5421FC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 14:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F888807B1;
	Mon, 10 Feb 2025 15:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a2sagozd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 365A180A55; Mon, 10 Feb 2025 15:38:50 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31DB806ED
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e5b1c4b952dso3515103276.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739198326; x=1739803126; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E6huMHuzLdaJ0vu/agzGZAKtIB/Mha8kgMSGWASnhCA=;
 b=a2sagozdBkVWpxpu5l9nGbTwpqRavn4OS1U61PphiqG+EvZtFZUvpBoKjD8JwF5NpZ
 qgO1OFK+d9BhWdGfWTXX5uB3lv4+uZkbu0Hso++CwaKE49y4E+NdbSLTlzjKVCn8ipBc
 go1U01vbw1OaNPAVbGMWtjoILAqXAZfumDNaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739198326; x=1739803126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6huMHuzLdaJ0vu/agzGZAKtIB/Mha8kgMSGWASnhCA=;
 b=ac7pOyGU3NJFTQ3h/M1vFEptlBoSUy1UMCNycnes8DYqlwixv0Jw/08p/mSgOuqyOL
 mcYJakWL6Ec10mtxreppuk2DpG8MYqA5Nq90hgSEiAxRFRa5gpLmmP7790Aq90bS2DLa
 SIJyLlE6q5jMsZFSD+wviyKO3glnlEUHMcXtHc5n32E5bB1Gut1N5NrBoKhB44jnuFi0
 mBQu3JD/bczVd3mOXZz9KJOny2ZZ9oObPE4sAwIrfX+26r0oXIQ0RO+SwUFADULq3gxS
 Xpk4lxKaedfw9s6966zeo/H1rQvGabuUI2fwEnjBawA3Jmch1YFd8Hz0h1yqL2HWIkKK
 qvvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU86GEK849utarBS81433GX73IxcE7cwBwfrmXJLt56VVfCNqXXvanup1mWmF7l5wmQIoO8GSk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3exZV/0usQvt/uKyPEoWiWd3FC+/2nkXlgL50JIA3SmzydZFi
 4iDX0QIkTvsFf8vQge078nSfvoKwDiZZp6xjPCwZd7Gx0XR3A98p1HhPYRmOaQk=
X-Gm-Gg: ASbGncvMrR4OohyGcer1uOWSQQ6grOgDTP1szRjWa7QKb9QHer7ql5XR0pmtswgGDAJ
 VUH96en/zm/dh7X0CxvY1Ke+GTyiSYfZwmqAESb6Oa98X5pxFUihKLMfWn40E9f/wBZimhl1gFK
 atVaTWmM+gg088BawseL/H2Bpqz11Dmoe9J2TtTeJBtelSO4epiyBjHaNlO6CKahSv0EByrQ9qs
 8iswFTqAaIPeuWq1NXdueTQy1s2toDjPWtOxWt+lOSigGVjTaGnIaS7dMR3Hay+RjtNpl2UOQFE
 khbZ/qzFf/D7r+I=
X-Google-Smtp-Source: AGHT+IGDWGfr5vcW69JE6AQYH+JOdug+eD27iSmxtqYyFgt1HUbWIEDQQYGE+Tq4YCrQobnpbZ8ebw==
X-Received: by 2002:a05:6902:260a:b0:e5b:149c:d8e4 with SMTP id
 3f1490d57ef6-e5b4616d55dmr12168448276.1.1739198325995; 
 Mon, 10 Feb 2025 06:38:45 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a221138sm2582054276.27.2025.02.10.06.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:38:45 -0800 (PST)
Date: Mon, 10 Feb 2025 08:38:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/12] rockchip: rk3399-gru: Include binman generated FIT
 in u-boot.rom image
Message-ID: <20250210143842.GD1233568@bill-the-cat>
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-7-jonas@kwiboo.se>
 <8a6bb542-aeda-4d74-bdcc-8eace71eaf62@cherry.de>
 <c3cd2190-096b-4f5d-a5cc-481cc44fa11c@kwiboo.se>
 <CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com>
 <20250209164945.GN1233568@bill-the-cat>
 <CAFLszTjFDzM18Nzacj+z7E+PaGwmF5+PcP=T2vFA=Eg1+AdpsA@mail.gmail.com>
 <9f366f7e-f1ba-464c-9d3f-79beaf3db52a@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XRe3dnhCDSq9Nhob"
Content-Disposition: inline
In-Reply-To: <9f366f7e-f1ba-464c-9d3f-79beaf3db52a@kwiboo.se>
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


--XRe3dnhCDSq9Nhob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 10:40:05PM +0100, Jonas Karlman wrote:

[snip]
> For clarity, I only have my personal tree, named u-boot-rockchip, at
> GitHub, and do not have any tree at https://source.denx.de/u-boot/

On that note, while we don't have the resources to open our Gitlab CI to
the world (which is why have Azure hooked up to GitHub, it's slow, but
it's also free) I was thinking about adding a "contrib" repository to
allow frequent contributors access to Gitlab CI as well.

--=20
Tom

--XRe3dnhCDSq9Nhob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqD3IACgkQFHw5/5Y0
tyzWFQwArX++rdIqMfq3wi56tqKMDOOsDUwM69b2ny8a+5/2VzfkoJZw8NKSwAWQ
nHWEeJUPIZ5NmHIiQU7cGWvYqsk1CoxG8uUdwIwgrVNMvdi+c7APj19SgAqG8ixg
ujoVfgMjw8oKouzk2xiDnrDwO/l6mPmvYwPgJkybo/djVsTSB+EJW/0RNC7wJYuy
zL86yet04oFK1fzezOi3cURQD+eOWi13zMiVpeVlE883yQZRf3yxeY6Vrl7yHxBy
+/zju/vFq9KO2LQeAeJ8r35q2vOuUnjvA8y2N2rdel/akg/cgeRmMvqDjFtho9dq
cKcORXgSlxJwQnFgpLwZQ5r/5whfiyqoMrksbzss8S53o7Xnw5R4fv8aA1sRRPQD
kqqLhbhhffx7nfjpojDifN7Nt48fZX86OdlzW038Di+ObBJMaXTsB1c8ihqLeRBi
ahNi00xqPq1+2GZsvZH1590489CIiO9rz0wtBEMyyya0DFK0uIXVb7a3yfob8yx5
FNJk9ZhQ
=S/5T
-----END PGP SIGNATURE-----

--XRe3dnhCDSq9Nhob--
