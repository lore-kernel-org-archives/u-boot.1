Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD703F531E5
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 02:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BACA8407D;
	Tue, 14 Apr 2026 04:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G40igWJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA78283EC6; Tue, 14 Apr 2026 04:09:38 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A16883BC4
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 04:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dbd2a0211bso3688196a34.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 19:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776132575; x=1776737375; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R2WkrxYXYe7o2NoYp8tOhNd9ic6AYGfKB5XUilM3W60=;
 b=G40igWJ6MkqtX8nVjtEb//vBkJ+IYA3JJVBKBR2YQqr6VnaAKnj74T4gYcCCDGtPbi
 3ZP5n0Fm5BYdnJg0lQgxCfUfJGs6/5cYXoNwye9MXALc0UN2t28sx0URNfGsJggdW4FB
 SXhd+4vn9I80YnN3Z26pe1vYQEJsALNciLvJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776132575; x=1776737375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2WkrxYXYe7o2NoYp8tOhNd9ic6AYGfKB5XUilM3W60=;
 b=ozhs04GBDZL644JHbdEgYpA7wRHeTwbUdbYqRO29BSpR0Or9mE/FMoRO3nZKvpBGWL
 WpPVAtEFsTw3B+7RkDb42/8XK1/AbivcckeNHHBVRCRp09lkMr9FMnVKy7qNIH+U7n2e
 vbaIkW1OqNh4oNPoiFNhtyGX8/G1RBPOfyhnAfVCuhJtNN3LdB0yDlRc742T43OAeMut
 iQYSkkW3rE/9WkDAbPUrufaWsIyYOwCBxpf05oYyRnNBxeLFk4YuknA9rSX7AzVsr6jn
 o07+6oDerw5j/MuVWBw8F8FTo0m/Oo/H9kqWZ3YnkR2J9AWN/O6/XnM+FS5D7OltRkMu
 0ktw==
X-Gm-Message-State: AOJu0YwMmNr2fq0hNfLKY71euNx1HX0AS8CvSBBUzyVptQyLjD7rvWfs
 XFArOzsbEnpiuAuvoo8O+BlNDeWp+Sy+tWVDSMEn43X346vjlNmH9ZNLxAFn7T0FaDj2a/c35Ig
 T0jRUq+g=
X-Gm-Gg: AeBDievRl1gSac6JzdsMrlCkP6SZcH9oc6jd02Wz9zJ9SsOQMjI25BhUNHq5aZ0v58n
 WDp8u0JzhSXfQR8GtkI4PDAqOa795GmnIZmbMdWOHFXo9ePNKF/foMndh+hHnBuzCNePOzyOJ6n
 HOadKD4fnjOyminojCddkArMVySMAK05kC6s7fqsC99gwxO14SoB/iv1LOD0c76Pxu1uLooM3MG
 BMcYXUmzjbrVU8SLqMPCLzf5yHa1UYgMKhs/AwgCiXxfzGZ+2VuPy0m6vMUn8vSg+7EucCvEAxl
 yFQEP6EIABQR4IGTHryRJZh8ai9JRbhsulL6Oz7+yAp3xak/ndLEckuZEJrk96h37pktSx1AkQQ
 rhtx94SwQ49dSzverVXS3gALtPSEV0UKvQJRZNrCrOhPkUVWB+WAyy3WEKie2GVeuAQjIn6O9hp
 neOKY0blKXJvT7+uLzcFObq24U5lzf3c4VdVlKyZJhYBHZtZb6hryoB5JfljASA0FbcH/lmBaHP
 0Dw+LbRGZE+H5YIZt8gYaB8YSNDDad/CLtWl2b3RV5u3yp7mfE=
X-Received: by 2002:a05:6830:310f:b0:7d7:eabb:2a5 with SMTP id
 46e09a7af769-7dc27f2534amr8873632a34.24.1776132574655; 
 Mon, 13 Apr 2026 19:09:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc26941b7esm9571294a34.19.2026.04.13.19.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 19:09:34 -0700 (PDT)
Date: Mon, 13 Apr 2026 20:09:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] common: cli_hush: fix console_buffer overflow on boot
 retry
Message-ID: <20260414020932.GI41863@bill-the-cat>
References: <20260406023100.95279-1-S4210155@student.rmit.edu.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E9dxNFcGEev/w1rm"
Content-Disposition: inline
In-Reply-To: <20260406023100.95279-1-S4210155@student.rmit.edu.au>
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


--E9dxNFcGEev/w1rm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2026 at 09:30:27AM +0700, Ngo Luong Thanh Tra wrote:

> Add const_strcpy() macro to linux/build_bug.h that enforces at
> compile time that the destination is a writable char array (not char *
> or const char *), the source is a string literal, and the source fits
> in the destination including the NUL terminator.
>=20
> Fix the console_buffer extern declaration in console.h to include the
> array size so sizeof(console_buffer) is valid at call sites.
>=20
> Replace unbounded strcpy() in cli_hush.c with const_strcpy().
>=20
> Fixes: 657e19f8f2dd ("cli_hush: support running bootcmd on boot retry")
>=20
> Changes in v3:
> - Reject const char * destinations in const_strcpy() (Simon Glass)
>=20
> Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>

Can you please rebase on top of current master?

> Made-with: Cursor

Please see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/coding-assistants.rst
and rework this tag as well, thanks.

--=20
Tom

--E9dxNFcGEev/w1rm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad2h2AAKCRAr4qD1Cr/k
Ci0rAQCH6kvbyGIC26HFj5JDrjbHUAy6HzzSKqjGl9QOmv0yPwEA4Vi8hJ+11IdP
0XPRdVQpT6vuZ9nLwpmlY+E13Zq9RQ8=
=/GFh
-----END PGP SIGNATURE-----

--E9dxNFcGEev/w1rm--
