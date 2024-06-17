Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15310C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24BA2882FE;
	Mon, 17 Jun 2024 16:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RhER0YuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC6F88208; Mon, 17 Jun 2024 16:40:12 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A925A882FE
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d226aff122so2423847b6e.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718635209; x=1719240009; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dkLVNGIQPg7KQ5XyjNp/0v6v4K295BUItJV3UcYCYO8=;
 b=RhER0YuUDzW95LWg6voL26dZ1lS74bBv6vTtAY4jP7SXZwoCf8qFPJjc8knqRnX85p
 7CTj6DGOK7X3jgnrrp4UIJi0i2hHZJJG1g/cDdjIHwd80c2LlYWZSkATwwD10WZU1sJZ
 y3zDb+NZd/VW4ltlyA9GJuGoyrFQLBSPRgDA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718635209; x=1719240009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkLVNGIQPg7KQ5XyjNp/0v6v4K295BUItJV3UcYCYO8=;
 b=SaAbjAnWo+pfbtFAg5riiowBasFoZxAiyVOhXZvHuNw0Gc9kiUdjzrBArCtFcnNhN1
 Q9ZpUda0wzL61DgKoaGNEddFVQClcY8ZIdxsBm0EiGMm8QC0g8G3nC/DlZIM9F7cdY8C
 TwHSwbgs+cHYSRo1X5M1Pxu+7s4HrA5erjZ7FCeam2BJS6t1zVlZ8+HKUAqYYjGCUU+n
 +f5kmPQMUha6c7Y37Oy78lXQGFiyzyAsNH6sEGF2IGon+A0o4i+1Q8X64THvbTKzoM8w
 qHsRdOZww7FAaamw8KzNtFnmc8/bSFSk3X+2oDjsAZe30Pq68U7Y8SGty8R8SB/eqrkw
 ClPg==
X-Gm-Message-State: AOJu0YzmcjdMMjPuv0vClzWHCxZHWvizF9m4XtL/ZJvyhYY8li8cASY/
 P1z7tuJf+zX1lMVYoBqsfqPLRij5TyXFXkE57+8unk1+fn1GlPkg+9WTy3fWvFQ=
X-Google-Smtp-Source: AGHT+IGd8HSCPG/yyN/n5BkxgtOS8xkjQpLH09tibNVk4LuBcXsuDB23Mjp4LDfBa9qOCaLqwQ1Eyw==
X-Received: by 2002:a05:6808:2393:b0:3d2:2848:4c91 with SMTP id
 5614622812f47-3d24e8fa96bmr13573897b6e.28.1718635208435; 
 Mon, 17 Jun 2024 07:40:08 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476bb76fsm1492573b6e.39.2024.06.17.07.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 07:40:07 -0700 (PDT)
Date: Mon, 17 Jun 2024 08:40:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-watchdog/next
Message-ID: <20240617144004.GW68077@bill-the-cat>
References: <683ca5ff-1f70-4ca4-99c4-33abb16b60f1@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Tz82h+P3izLp0lZY"
Content-Disposition: inline
In-Reply-To: <683ca5ff-1f70-4ca4-99c4-33abb16b60f1@mailbox.org>
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


--Tz82h+P3izLp0lZY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 12:18:52PM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull the following watchdog & cyclic related patches:
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--Tz82h+P3izLp0lZY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwSsQACgkQFHw5/5Y0
tyyuKQv8Dkm1XQlbc/R9XF67av8wLTTrbiwVMzVNEFP26Eh6CYOMYh/ZIgPlnv3C
zi5hN0hY+wtnHp/Fi+Z6bVzZshiDA+XfVmWmt3jTraKjeClElkjcWk8dljJRymhs
jaJ43cqtbHJUGzubaDJ7/0Sgx7QqN316Pachy17tZRZtSHVBWv8vKwAfktt2iv0w
MJzYYm2xgI9cbZdrKDDPDqn7TqtPMp88k8D7ZR8WoZRv4tjkiJLyP2IcGYa6QPz5
+PUe+3o1xe2xPpccSXBUb/lC9Sd6+GV4Pxqtrv8zYiJEJ9rw7judKFeBn7Mlyjk5
2m18AqUSzWohuAJIebRGvUHggiO1t8VQH95k5iRajmaFbGdMLOqR5oGuuBlJLCiv
MhbPJpUllL1VwzhbkpET9YVFFq/Fu37jSp8jl4ssxikAVvQecKkEItGQ9uDce2a1
YoQ4bcMEVAVSqTqCzxD2KBA7a8VsuUOW4Jf9hZgqw5RkwWMp7w39QwWeQIGl4xj9
YpsfHsda
=tbjY
-----END PGP SIGNATURE-----

--Tz82h+P3izLp0lZY--
