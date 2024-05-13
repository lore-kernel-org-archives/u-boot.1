Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577EAC25B5F
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 13:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7784B882B6;
	Mon, 13 May 2024 15:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ks4uCaxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 042F787D7C; Mon, 13 May 2024 15:43:18 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91479882B6
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 15:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3c96a298d5aso2474364b6e.3
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715607794; x=1716212594; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tdriqmbz8mAvUq+ZePRQM2ZtilHkTtVha4vTAxcaMr8=;
 b=ks4uCaxolZya5AnEXzBRjyn/IPEOpG+VLYqB/RGlw6DsS0bSQYB2JvEn8iq6DxMkyU
 NZ4szk8ft4OJiz818Cd4CJi9//TSkH2Se9LEf5lmdrOhqHJ1x66elY+zZFh9EpJOa/5D
 I99/U2VSwz8Uss4WFSpaTNP8BuCDklbtWcIF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715607794; x=1716212594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdriqmbz8mAvUq+ZePRQM2ZtilHkTtVha4vTAxcaMr8=;
 b=eF6k2Gg7M3WsCFtu/l/nO6Veu3QQMbBRia8HcEshjhkHDIJoGjd8iK8DV7NEgFRznd
 WraLhOdmX+DTNxA4BeLBv8GAOs8tmj+0rAt1x7iEFY3FqaXU4Uj001T86kcgifKs6A7e
 of+ADS6ft53SSKmolXEebrEm3ehNAd13jLg1I3SrgPaW1VPCvOKk7i+ZKx+eyp1gQepp
 9Jln3XR4Vcj/qYD3SKXPQIvCie06p9Lu9k2F/iKLE6NbDc0k3C0lNL7pswUgblmozD8p
 c5SFfuE6y94J/3kxsMpuOWxY1UV5rCtBiT2edWm1VdYgqqy6pOFrmdpEYGg8TcUO+y6G
 cM3w==
X-Gm-Message-State: AOJu0Yw3h+7S704s/1SSET2D0JD8IdKROA8FjS9mV2hIT6Uz1YjXelSJ
 0hhzahGzQN20jR1iv67MkWKIkEuVAlq8y1S0zPm+zy6qeArULR5FcaDO2z8/HYQ=
X-Google-Smtp-Source: AGHT+IGgOE+E2Fmx1xYEKXnRW6yRtUQUe5zTkGbYAPm460KSZ0jsJ1uHn0BTR4kDNe8BVxcn+RCACw==
X-Received: by 2002:a05:6808:16aa:b0:3c5:f365:16cb with SMTP id
 5614622812f47-3c9970cf97cmr15406112b6e.37.1715607794294; 
 Mon, 13 May 2024 06:43:14 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1d9ccasm43485266d6.127.2024.05.13.06.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 06:43:13 -0700 (PDT)
Date: Mon, 13 May 2024 07:43:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master-cleanup
Message-ID: <20240513134311.GC2568172@bill-the-cat>
References: <20240511231302.74263-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n9TGdPJ1f5M6sH9u"
Content-Disposition: inline
In-Reply-To: <20240511231302.74263-1-marek.vasut+renesas@mailbox.org>
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


--n9TGdPJ1f5M6sH9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 01:12:27AM +0200, Marek Vasut wrote:

> The following changes since commit 5c5565cfec92eb7377ff7fe197612c6a813bb6=
c7:
>=20
>   Merge patch series "arm: davinci: Migrate da850-evm to OF_UPSTREAM" (20=
24-05-07 11:59:26 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master-cleanup
>=20
> for you to fetch changes up to 2d10e76547b896fb002cb3f946ac6f9b628e9fb7:
>=20
>   ARM: dts: renesas: Drop DTs with OF_UPSTREAM counterparts (2024-05-12 0=
1:12:00 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--n9TGdPJ1f5M6sH9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZCGOwACgkQFHw5/5Y0
tyxZAQv+JxJL9iUlgZ3sDCUbWUxdzo7vnyHbM552buVyMJEGi0XRivnL0V3UCQyU
96nRqqarIZIzNSehyrHbQmoA1jGfBktbw4c2g9+BVZJrhHB1fcENhvBkPd+HNyl1
x146UBYQZggeJWneVA2evApFNMbfo5LQCnI7Ax2Xq0jq0j2XO77sWLg8A2F380CY
JpW5DrwZNtqOCiloCV6u7KRdopBOOWDQ7UwISytBjbsk0yDJImzGxsRteTlFvxZm
F9I4pR6J1kdrVOxNapmQiv8esHjsguhrVZ2dOcriPTRdaXv64XZbD3LXeor/9PMu
AZCFknZ3J+0LjumSqKOB6v54mnUiHeskstKaw9gZXatLzs94DRsonujzGha79Rzw
qLoewy3Sr3NGHfosulfoTbCM8HJMw5fJOk4LJCIceZYZqpBoCJ0QZYU/H7J6q1Rt
+ZYYXQ61gwyHR4XoxdwS3326OLjpQ0Lj4TTjrmcboLC8OmU4GJT9Pc/0sqG980ub
qDliHVRj
=oZmZ
-----END PGP SIGNATURE-----

--n9TGdPJ1f5M6sH9u--
