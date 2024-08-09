Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3009AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 19:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59DDC886B1;
	Fri,  9 Aug 2024 21:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JOYfguoC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 747ED884EA; Fri,  9 Aug 2024 21:45:57 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D2D588C18
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 21:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-709345dd01dso1541316a34.0
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723232753; x=1723837553; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tdD3M8n24XPu28Yw91Q1MRqGW17AJ4jOolBhZqPvXeE=;
 b=JOYfguoCgVrIbIiTdjEW9WPUIJe5WCs9K7iZmguCOFM3Jn+DWyl42VAFeQnangqcOq
 LaJK3iVSRJHriuz8w7lzkJntWpqDEJSabfaJG4vnLXFUXN8ibrwCwpuuwol9aQW+dILf
 SAGXpe0SEUXRHZuyBFOAyc9jRu0uRTpv+pyQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723232753; x=1723837553;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdD3M8n24XPu28Yw91Q1MRqGW17AJ4jOolBhZqPvXeE=;
 b=qaPgyjNTq64w2ZSUHH3//jQDSYyGx3GVvgOu7lGKQfheeE0z32nxME9J1OoSoRs/77
 3BJo7zXnTu4psvSoLKT7DK93/ttHkGONinMZT89bEB4D0r72OsLi9jXt+fJ58DjGJZtk
 zZtSNfrQ2xgDB9G1iwBdPI7c1Zum2s1dFIe/J7sYk9tedPBMJbk+onwi7RX3X6L0saXM
 IWSYTrAHb+iuLM47hXuR7ZqGrTEC5BmrAWbsGquCdLtZXGXUY6Uu2KN6MpIZvqPB66FP
 e7kF2TdDOanC32qInfBeMCW8PJB9p1nGuFcMplqgrLZNOGMZ0LbpoTDSWSMctMfxdouc
 7RWQ==
X-Gm-Message-State: AOJu0Yy3sMuKsZv4JQmryjW1r8nruiXXsWnQHWaDvFdqxOgMhL3s7uQ7
 EhEhZmPIs8LQuQ6K1Vgo3K6z1o5dPVijjr+mPcbl4HIiIpHBjtI3os99a/y7jM0=
X-Google-Smtp-Source: AGHT+IHVDn+CJLR7hn8OuaX99ILv/BBveJ4ynpFYohxSG5ulC22rMiIaixsz/JCJEBsQmjkrLv2ZpQ==
X-Received: by 2002:a05:6830:44a8:b0:709:366a:be42 with SMTP id
 46e09a7af769-70bc736414fmr952730a34.8.1723232753295; 
 Fri, 09 Aug 2024 12:45:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70c7b82af79sm112190a34.45.2024.08.09.12.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 12:45:52 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:45:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>, Fedor Ross <fedor.ross@ifm.com>,
 David Virag <virag.david003@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: Re: Please pull v2 u-boot-i2c
Message-ID: <20240809194550.GV1626301@bill-the-cat>
References: <09a3ff7e-d7bd-8dd5-82ea-a62a90b9054b@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YmsRuJYWo8l/UcZM"
Content-Disposition: inline
In-Reply-To: <09a3ff7e-d7bd-8dd5-82ea-a62a90b9054b@denx.de>
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


--YmsRuJYWo8l/UcZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 04:09:09PM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull from u-boot-i2c master, sorted out the DM_I2C patches from An=
atolij,
> to seperate pull request for next.
>=20
> The following changes since commit eb8e25c000d185ece0136b13cca73084eb9802=
53:
>=20
>   Merge tag 'u-boot-nand-20240808' of
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash (2024-08-08
> 16:15:06 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cfixes-v=
2-for-v2024-10-rc3
>=20
> for you to fetch changes up to ec07bcc8eafb8d201d15facc969fe96600660095:
>=20
>   i2c: imx_lpi2c: Support read transfers longer than 256 bytes (2024-08-0=
9 14:46:49 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--YmsRuJYWo8l/UcZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma2cesACgkQFHw5/5Y0
tyw0MQv+KD5K/pttdMWYKF0pgiD1v0JphY0JojQvyt+MZ44DyVtD7hS4Tpmj0mXo
pMKj0zDn3Hf+CMBPZLB24iA78lLdvKdsEgF+AGzZofDbD8n0SlBN0guvMR8lVbEV
UppIj7CnDjqeU1XekdAPQ3cF681UJrlWQZ5Ij7EQp/QdO8zrx9oSLe122hVPdB9J
/oGM+5dC7cBeaBjk1O88trR201Vk0w/41zamdF+BLvVFy9xsvkUkNuBwxivyAj8t
k3KDFYC61vDvklXfjJ2A1WmVcXksB3gF/+v0tw6PnNIo8NLN6DuoSDU0DZWkrOre
EO1uFJCbDTYUG4ELAvzmk5QwyS7nwi3cVepIlVPPpI2eH1cw+ypIWKDQt478fAE+
JxJu4CxF5V01QN3+A7EDnJZCFVyzyEuzqK9Orl5CoDY0T30BD92aG/vhFFovVFpd
PM0Fmc4mk3RBsuoOO6vgXY76KbAHde/BFErOLleRehbr5M1hwWTtu0repnM+HEL/
Yz6uGPJN
=NOz/
-----END PGP SIGNATURE-----

--YmsRuJYWo8l/UcZM--
