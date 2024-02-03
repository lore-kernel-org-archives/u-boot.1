Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A332AC4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 22:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 724C3878D0;
	Sat,  3 Feb 2024 23:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RiMIfMf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC778879D7; Sat,  3 Feb 2024 23:00:34 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 723DE87873
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 23:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-60427d9c5dbso16819297b3.1
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 14:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706997631; x=1707602431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m2irI9iYylRQWOyGxBV2r6YJwy2bZpuGFwUITSUuZK8=;
 b=RiMIfMf1L49vR/1xMI+tZzepVs0XxnDTBonqf03mhNKxXXrYv8clOom8njQKgkv+vI
 k5Em8ygPDBY5gxHkLTPBeQLhZxgQ/HX4/FH82K43gaojqOQwEqlzntiZoCGw0wUuSMWy
 u6mcUq85nMv+kf8Y6Xd4zrjGowZ0iBWwDNeHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706997631; x=1707602431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2irI9iYylRQWOyGxBV2r6YJwy2bZpuGFwUITSUuZK8=;
 b=YzXS+l8+VE1NxvYSAkeBzeoijdsG4S3y0J4KhLcy/Fo8lZoVrma72uQ1o8Kknxsjib
 fvb+fgZfYJRyltWxTiebHYAf8QiaHwVW9ESCTbHMj1cO+PbgDUuj3pII4eAQD4+d/pFj
 XZaDoo8iZTgQ9xzcdcUQ66sYg1YQxn93z0Cgii8fMCV2cEWoI6RtG3NSe3M7ymekO8aC
 jMoeFe/LQjpCBTvmQ7xSrDPNFWimUCF0Kk5JyuFa/Jthv4iYMJZWe9GnoLmquxAaQaXa
 Ci91+Kxv+xtWGNqasoguMIaf0OQLPNFyhBZclrkv3e++6h/e62l5utS43oVuXbPLRmOR
 w+0Q==
X-Gm-Message-State: AOJu0YxuEqaRAsFMz05CASfEtTSjD26B0pQ22s5sbp4HYYoWw7d4Z0vP
 TblmMrwiVwu8aClrg3uloG7QV5UdTx6DDbI6pxWKkdbMNPQmj02UO75Heyun8Io=
X-Google-Smtp-Source: AGHT+IGm0JUxmCPBchKUMYCAXC5jaBK/HvKCLlqAZatnS2apQYPzbbJGl5DxppZuxzE8Vot/NQt6Jw==
X-Received: by 2002:a05:690c:801:b0:601:eaa6:9d1e with SMTP id
 bx1-20020a05690c080100b00601eaa69d1emr1670792ywb.11.1706997631095; 
 Sat, 03 Feb 2024 14:00:31 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX4QtIUsZ96G9ClWmAKT1Xz8rh9FXG9vlhCZgqZpPfBH534anm5P54k1tJ50F0AY966ptZ0HgcNls0tSFkEcEOACw==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 k125-20020a816f83000000b005ff9b3e6dd4sm1158702ywc.116.2024.02.03.14.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 14:00:29 -0800 (PST)
Date: Sat, 3 Feb 2024 17:00:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Matthias Brugger <mbrugger@suse.com>
Subject: Re: Pull request smbios-2024-04-rc2
Message-ID: <20240203220027.GG1152441@bill-the-cat>
References: <0ff1a399-e295-480f-9949-4e021f0794f4@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3a8b6nkH23oTJ4oG"
Content-Disposition: inline
In-Reply-To: <0ff1a399-e295-480f-9949-4e021f0794f4@gmx.de>
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


--3a8b6nkH23oTJ4oG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 03, 2024 at 09:57:30AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 050a9b981d6a835133521b599be3ae189ce70f=
41:
>=20
>   Merge tag 'u-boot-amlogic-fixes-20240201' of
> https://source.denx.de/u-boot/custodians/u-boot-amlogic (2024-02-01
> 09:59:53 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/smbios-2024-04-rc2
>=20
> for you to fetch changes up to 406c410ef747d66e16f2f5494cbf88ba1307224f:
>=20
>   smbios: correctly name Structure Table Maximum Size field (2024-02-02
> 19:57:45 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19538
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--3a8b6nkH23oTJ4oG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW+t3gACgkQFHw5/5Y0
tyyl+wwAouvDFcHSUMnezchVxNqs5gjSLhtqjgu45BTVtCyAOk+IRPZD3Pezdg8W
rXZUkMmtTdZ4DEdyzY2r3IsJI12S3HBpgFI3xyzYBuZWre3zUMjRHa+bMeWk/adY
MhiH6WqQEU715Rh1xWuHWZoUCnlUbifntjHS9Cn9nNSva1eMm+hVrWNfABb+5Ztl
0K48dSKZPSfyfeJ4q3VHW1P9dNngdX3QP1ws3DeXeQWw91fwD8NhSlV6l6TEfd1i
Uq/D5rHkbDqVwfsj2jb0uw+8X3yHBhSRg0GUKHY3RVTIstJwzhYOm9FanC3surZx
/ma25tUxUGKiR5Yo2YL1bH3fB6rkpcAChBmg0/kl+ODNIkvlpA3rFeKHSlVy4Odm
KST/9Iltg2e/5ZuA3R+8DNk/LEWBQOgHDulqoYDuzQLZBNJtF3ChNLQu0QEQTiZ0
A8DyYm5OfBm/g7HF3RSG98CLOV/T3f6VteNJHT0Fzud7h5t5NMj6OCDOu38K9jh1
OOEJYKKB
=UcMc
-----END PGP SIGNATURE-----

--3a8b6nkH23oTJ4oG--
