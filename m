Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83CAC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 20:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A13984857;
	Sun,  5 Jul 2026 22:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ld9LL1eZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE0E84867; Sun,  5 Jul 2026 22:27:20 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33CAC846FD
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 22:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6a321bb0328so1236601eaf.2
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783283237; x=1783888037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0U3EKaYzbEzVQbaweniGpDBfNTQqG9UDzQWvYPf7We0=;
 b=ld9LL1eZV2Ps8DCGJvwFy2s58UMiKjFdMAJ2BrlkR+zqQ12ZlpPMSdjzTvQx3bGebQ
 /Sti7n7Vjf7ELIIh5jz+SZBmDAa4WDFoGhyyG2e7x2vBQZG/+GVVSno1jsf6LZiJpaxG
 /ZFpL01MgeXcV1awKH9cWyTETc0fCxw7XyBzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783283237; x=1783888037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0U3EKaYzbEzVQbaweniGpDBfNTQqG9UDzQWvYPf7We0=;
 b=XZS/0cPo1CWzZ1P0aiAqc7iP8GpAmnFUuvOdwDbFNHg29q89TXkJxyakaYEtQelOcl
 P0n0R8cZPIhn5ILew7QPhD0zKK7cNASVgdKm2tE9H45BVhJAPV8D0GkgIFK8NwpXY1qS
 P99y3f7zEdUI5ZJ7oPXNha+HQVik0qKRDmjdQuX/YEk8kMHYSLKqYQE/gZNylKC35PcX
 S3554MBC4MGziZUFlg3r9Qo46IF19IcfK/cEdlvhDlIZPuBS5RWAGSB2tp/igX3FzuNI
 IEKQo3Oc9a0BtTanzezrz6fjSxdvfjkGpR34fHxpwuvMhD6rn0bN/z4b3Jx7mXGYdwzL
 ZFEQ==
X-Gm-Message-State: AOJu0YxYniLpyBydAwjbueN66gaY9/MqasOyE7Y8q2XtBQ+5hDUzIT9I
 oeGX9yBhIW8GKXKl8s3b6aQ6fi+rEl5APLcv9mgx3UbVV9fcWEfLgbnqGktcz62RD6A=
X-Gm-Gg: AfdE7cnzbOvuYFyT6gr7IRR9XVyoms3jXqQeULBXU9VyFpEl39Ah/bls7GQmwiO2o3b
 DiuJ/dr+IGbLoguNYO+hQY37AtwcWzovH/J60vz2LYcFsPpmFfB14X2LeTpoCoEdQX982xAdvYy
 06IUw23yoeVzNI8vY+xTklYp1SH57cEEBEjQQUYb19qxuh24Vy7A7WO6jZUEUDe2SPEtPRsGLjI
 CDLbd6xkPHyCalk4HyhnkH4n9Tfct2ncCFnakoCMDnroci9sL77+9kdNYtoGodwwg360O2KaheF
 YVg3tNgsx7wmLgXEFKMtzgfoZh5oeyGtbcj0y5xbrGhDoBWABEai4p4BOApIuhTIpkjR4XEYH7g
 W4byyOdN5y+yh3E2Z6Tcdc5dSf2FtcKIsy7cGUBLhd6Uw+m4z7UvpOCcqZlyAdBaZ6MJWxWggK3
 GgAhwei8syRadB4RCoBo4klk+KvF2qDY9UZUlQf7GXqtSok5LveuNDAliKJUQ969KFWbuFWU/jZ
 SvW7r8n0rPriGajzaoqi3ldJTmK11sbjHh0UQ==
X-Received: by 2002:a05:6820:1791:b0:6a1:871b:fffd with SMTP id
 006d021491bc7-6a32f62fbf0mr4403582eaf.46.1783283236973; 
 Sun, 05 Jul 2026 13:27:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a31040d0c2sm7742737eaf.15.2026.07.05.13.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 13:27:16 -0700 (PDT)
Date: Sun, 5 Jul 2026 14:27:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>
Subject: Re: [PATCH v2 08/11] CI: Stop building and testing patman
Message-ID: <20260705202713.GT749385@bill-the-cat>
References: <20260705193251.2190705-1-sjg@chromium.org>
 <20260705193251.2190705-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/7tsb1dMakBvrim1"
Content-Disposition: inline
In-Reply-To: <20260705193251.2190705-9-sjg@chromium.org>
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


--/7tsb1dMakBvrim1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 05, 2026 at 01:32:19PM -0600, Simon Glass wrote:

> patman is now just a stub, so drop its requirements file and its
> 'patman test' run from the Azure and GitLab pipelines.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

For bisectability of the CI pipeline, this (and some of the following CI
related patches) should have come sooner in the series. But that's a
very niche case and in the interest of expediency we'll not worry about
it here, I'll just re-order when merging.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--/7tsb1dMakBvrim1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakq+IQAKCRAr4qD1Cr/k
ClsLAQCMUStKJWLs8VeLyy2TUy9PLB8WLnm5i8UOkLs7uyqMXAEAkwpvlDR13/wh
S2zs2o1dNZOnNTWrZ1prz8gUOpcEsgM=
=ipcB
-----END PGP SIGNATURE-----

--/7tsb1dMakBvrim1--
