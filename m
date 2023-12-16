Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E142C46CCD
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 16:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E401876F6;
	Sat, 16 Dec 2023 17:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oi/rH/Xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D6CC876C8; Sat, 16 Dec 2023 17:04:29 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E53876E5
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 17:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-425c6157762so15165671cf.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 08:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702742660; x=1703347460; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0RRitIYAZOilYibBK/98nyCiTMHIpCB80rcbKOnbrCA=;
 b=oi/rH/XcW80NPMiGM2bjezBid3zYSDYVvwGadKUvJ6Q8Fs39v48z3d470JxLy860fA
 Fr+FdwY4kXr3j4DSxXvSk5ksgwEuQn7S4vO6ZBwQGLVRnMv7NQcL7BMW/IlGXC9zxNs8
 YMay8kOGcSlEX7qnkmbnzxpZYu+nguJKR78e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702742660; x=1703347460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RRitIYAZOilYibBK/98nyCiTMHIpCB80rcbKOnbrCA=;
 b=tUIyBxQgu8ND7s01ItqONIw7EgeWyfHQBUiPwy0DIOG6/Ibyi2GGFruozoD/zwobAo
 0eHNO1yajnDlE8JXnolqe48pin4GhD+FJMLs1scZoEhObbH9NsX03Pw9Qy/DbkQWfJ1h
 VQjxm8DltC5MxiJSLsmYSmfB4lMdGawdWk/e4wzM4trgHuCRtvyUOcTiWh9J2JLXU/Wz
 OYsbymrwbxfO96NoDLPFnH2VnXgS1M8xCqCZRbXr/cv8vZcbVlfGZsEWJDs898agAxJR
 w6LL0bGYxxVIWeGsNeTWVMZzNoCW+k1ggXDjovSg7/gRmQpodZ4UKYisbS6KHrfMriDZ
 p/tQ==
X-Gm-Message-State: AOJu0YwLu8Qs0jiIBreiTkrRBQmDz40Yq/aIUFdwcCz1HKmHV9XgIH9A
 NOUl7tHgko0XWeK4976cOBWgaA==
X-Google-Smtp-Source: AGHT+IGqPD5oS7htbtxd9Lf2B8Ne0EtUI5S930xuY1000bh1Wg73XZloWL8VpD96JlGxiuSDXt3C6w==
X-Received: by 2002:ac8:5f48:0:b0:425:8a50:cbcd with SMTP id
 y8-20020ac85f48000000b004258a50cbcdmr20467500qta.45.1702742660700; 
 Sat, 16 Dec 2023 08:04:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 a13-20020ac8720d000000b00425406b64a1sm7571193qtp.24.2023.12.16.08.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 08:04:19 -0800 (PST)
Date: Sat, 16 Dec 2023 11:04:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jim Liu <jim.t90615@gmail.com>,
 Igor Prusov <ivprusov@sberdevices.ru>
Subject: Re: [GIT PULL] clock changes for u-boot/next
Message-ID: <20231216160417.GP2513409@bill-the-cat>
References: <30d112d0-3952-5b40-5689-a0abfc37f989@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xgehQzENTOF9Na28"
Content-Disposition: inline
In-Reply-To: <30d112d0-3952-5b40-5689-a0abfc37f989@gmail.com>
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


--xgehQzENTOF9Na28
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 03:52:26PM -0500, Sean Anderson wrote:

> The following changes since commit fa3f19aa56c519d6345cc774187b7a8fdc053d=
71:
>=20
>   Merge tag 'xilinx-for-v2024.04-rc1' of https://source.denx.de/u-boot/cu=
stodians/u-boot-microblaze into next (2023-12-14 13:27:11 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-clk.git tags/clk-2024.0=
1-next
>=20
> for you to fetch changes up to 652d8d4561a34fc71d9bcb6ad2b0035d2c4189c1:
>=20
>   clk: nuvoton: add read only feature for clk driver (2023-12-15 13:05:55=
 -0500)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--xgehQzENTOF9Na28
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV9yoEACgkQFHw5/5Y0
tyy/Mgv+Pf7a1aoCryvYBd/z1ASZgx7DDDII/Mw1M6nSTCcQpxE+u4IOp3MMrQgy
XzlGMPWK/8IYPBUKOTfuY09sg3J1iRllBmprk/fuDGnPT4sMiDMcjxWqt/epv586
8QaYc4NDtgMDtvnnVwxYTFZAa3v3EqelwcKNDefHPjofdP9DXsvcxnimscX9lpCR
V4aKuI54HtxwpEtmNtVdJuYy5+ku+5MG9eFEGna2wuXRNSUhVdbf8l+RKc2BDcTt
9rBXhglfrEifADz0rZ1Xyy7+UXCc2wkFvP2mtsltuGhYUAM8mm0ji6jz1TsNWQoI
Vkn0oOiG3DPLr0v5Tc8i+uJhpWrxdI+Wnza/OzHvMJbwC8jqrt1JbwHFb5z3BkmU
ufA3FCyrOjoZtwP4nqj8Wxa1H2B87C8GDjR0o1n1C03kqMR8iv3IJi+CM/udfL69
HliVzqwZ+rKl3Xw47dqGT3WQdfjZPp86iE2ArLikdLJY+ZXUOMK7wRiX4SbjU02Y
OVEhx2wB
=IZqq
-----END PGP SIGNATURE-----

--xgehQzENTOF9Na28--
