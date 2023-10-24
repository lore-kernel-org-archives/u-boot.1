Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C4CC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6419D87973;
	Tue, 24 Oct 2023 20:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nns9/VMh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499068726A; Tue, 24 Oct 2023 20:03:45 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEE908799A
 for <U-Boot@lists.denx.de>; Tue, 24 Oct 2023 20:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d9a58aa4983so4548917276.0
 for <U-Boot@lists.denx.de>; Tue, 24 Oct 2023 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698170611; x=1698775411; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S/m03lObdo/t9kFzV3qIMbQsI+bnKnrka/4fSaqHoGg=;
 b=Nns9/VMhjVEpl+9EZvWh7FjoQNYQwho9vcO3f3PSc3i4MIg8t8GIrHwhXg0MyDpfyF
 jrCQfSfQaIyTRxlO/hD84rtty2CC0IKwgqqXaGRN7UlqJaZXFzvPM+7oZ0DF+9u+guUK
 eanXHIP3oJTgklXyRmy1HXGgfTPbA29CGAQn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170611; x=1698775411;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/m03lObdo/t9kFzV3qIMbQsI+bnKnrka/4fSaqHoGg=;
 b=U7uA6J61HCUpGT5S249i8B9xCE3F2iWzMSX6uRZdxrT9yIUgmEwhxv/6KhSVY281m9
 M3I7hrwPSs/j2DWnCtgar1wUBDsPxFMpNG4w6sVN4H7sDzCqwgX6Ezmg1ex9tobou8Uk
 AG4KFyTEWA5OpcnGBOu0ltwLnl27Gk1afDk8zOAmY+xo/C0VFcDU1ZxtStUtGfcZmFtp
 4nGQQ9pONcfWGRtHtudx6wlKA+JN1fVHZZzYjqPsBJSiu9igVAN637jIqzZB+l0KjD22
 FaFlMU3K38Nn/pJmZD6+7tuEUwv9Hc2fVVr9b2axAYzsskPpa3dsFoMPTVEs44XLwWK4
 YfnQ==
X-Gm-Message-State: AOJu0YwW3XVz5anEytNgzULIQHbV289CHB2TQi9rwYy+ZXsGQWPp+j8S
 gyyWptUN80S+FfAw1Km9W8nQEddzo/GGabZ8t1+fSw==
X-Google-Smtp-Source: AGHT+IHR8wFwiugI4X+Z6CV/bWZRJfPvGzt/xv4CVp3jaC083pFWfMnhOMyoRHPYNopnMAKiE3WCDg==
X-Received: by 2002:a05:6902:1083:b0:d9a:57c9:f9bc with SMTP id
 v3-20020a056902108300b00d9a57c9f9bcmr16975779ybu.49.1698170611575; 
 Tue, 24 Oct 2023 11:03:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a257414000000b00d9cb16d7749sm3728601ybc.21.2023.10.24.11.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 11:03:31 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:03:29 -0400
From: Tom Rini <trini@konsulko.com>
To: Stefano Babic <sbabic@denx.de>
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: Pull request: please pull u-boot-imx-20231024
Message-ID: <20231024180329.GZ496310@bill-the-cat>
References: <3c1688e3-3500-440e-a398-704337b9dc47@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7NtqfK7YgD9nULu5"
Content-Disposition: inline
In-Reply-To: <3c1688e3-3500-440e-a398-704337b9dc47@denx.de>
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


--7NtqfK7YgD9nULu5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 10:20:57AM +0200, Stefano Babic wrote:

> Hi Tom,
>=20
> please pull from u-boot-imx, thanks !
>=20
> The following changes since commit e65b5d35c9116485366bb08138043d51220551=
da:
>=20
>   Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-sh (2023-10-17 09:15:56
> -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git
> tags/u-boot-imx-20231024
>=20
> for you to fetch changes up to 2f96064d0cf78e21a668ad907d41d63e56f9f7bb:
>=20
>   arm64: dts: imx8mp: Describe M24C32-D write-lockable page in DH i.MX8MP
> DHCOM DT (2023-10-18 21:29:59 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--7NtqfK7YgD9nULu5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4Bu4ACgkQFHw5/5Y0
tyxy5AwAl61pFmH8wFe0sbxrusYkDiJQhHzUKQVcBVC+lajCQUX8Fow0eW2ioz/l
TxQ7ORUn/0x32MM+YxLw50smJuvp587+MVzhD3c1cQMNdZa4XQydvFfClxJ3VP5D
O3qcwoEOM/SpJ5vfsAdI8foGOVM5k9KuofDKJKpaWCvHPkx3eOeSDFvsbHyRa+Zw
xJ/N6WfSmIPax4ROtT/tx4X0s9oO7ALHhZbamSLLkLv0klnDoNcPsGEkr2BbZDxI
brjNdDkmEIuGuPCxGBCOoxJLfRrLn3aSKf8CgfNN3Ir5t2fhA7R9Efxbpbgwd/X8
ZZ6QbxovTSiTuBLPcsJFImGqOWIjEnA43UW1gCzLaUznOaz9Xyv1EnssTzYhtuv2
dLPLhGTA5thTaVISZ6F9j6WnZe2mER4t3rp2S8dCTq0PF3wJfAOxFnaAVhfhGKiJ
V85g7eaOBOePLxq2SKfZwRSmYaPsBLH6RwFhef7E7OZutmzPIw/KqcMo1KDCyCwL
eIwMOfPD
=qbhk
-----END PGP SIGNATURE-----

--7NtqfK7YgD9nULu5--
