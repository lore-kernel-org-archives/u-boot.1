Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17616C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 00:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C95688ADC;
	Wed, 21 Aug 2024 02:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jdSauZLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1109A88B0B; Wed, 21 Aug 2024 02:42:55 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC8B88AA4
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 02:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db23a608eeso4045083b6e.1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 17:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724200971; x=1724805771; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3HaZ0OI4o9uFF5iZFlS5z+nbKRbkrGem4086NoXEcWg=;
 b=jdSauZLC3vRTS3qA6DStAnvum+T4Q2bb/AW8dXfZaAIk2SEHG8abHXWZ4MtKzafqB0
 tC4LfumTXM5vs+oe3Falg82nx5c75nCdtsoEex491eiY1mKZjJ1eua9N0T87vDcCb4xi
 E+ZDMoQbJb+IaIyjcRdgybPAug3Q0CGW1Lfxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724200971; x=1724805771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HaZ0OI4o9uFF5iZFlS5z+nbKRbkrGem4086NoXEcWg=;
 b=k8wPh2cAKEyyAAryZ7M+T5koyifgk3lopWWAZg740yaM39p0/HJznhlvqXo/F2okPz
 6XsoOQYkEGgE6iTC+SOJVxsLQbb68sFY+D3iTNw7FmpF5jvbW6AySdsBRhOF3Szr+nn5
 w1h6dZEs+9ZQv53x7g7L5uIHIbkJ4C8q/V9AuEKLB/GgdJx9HuyXbiM0S4XUWa4KhBWA
 ttRn5uAeSrctuE6aRsG/HZ6dmO1UkyM8KQiXUNCcs687F+eBlJGoK4r1cFlRcUxnRO8E
 am/v8Uu5jp2f5FJbIKepKDu/qPz7+qJ5Lg1oq4q9n8T4UKEaN+uNytGJxwsRIKR2VTjq
 y6Bw==
X-Gm-Message-State: AOJu0YxGBaltp9Ha86gtXBckwpdllyqAZUX4AKH4fc2+0dMJqcM+VG+z
 c9kP1N8dxCMXV/cxBzK0EM57vOtebDJj9SsKO/quEUq8OZHQsIVYK5pUir8+tvY=
X-Google-Smtp-Source: AGHT+IG+OsOEW8hqcYgV30glOj6jyUeLFzDrAh4vmzvb1JNqMBR4mZ/vxr09FicKYLd3cgQC0ktBOg==
X-Received: by 2002:a05:6808:1917:b0:3d9:1f05:845 with SMTP id
 5614622812f47-3de195070b2mr1071042b6e.19.1724200971242; 
 Tue, 20 Aug 2024 17:42:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd33d400b4sm3113507b6e.11.2024.08.20.17.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 17:42:50 -0700 (PDT)
Date: Tue, 20 Aug 2024 18:42:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Zixun LI <admin@hifiphile.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20240820
Message-ID: <20240821004248.GO1626301@bill-the-cat>
References: <87r0ajuxbz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3paI2d6Q0+JAv9HI"
Content-Disposition: inline
In-Reply-To: <87r0ajuxbz.fsf@baylibre.com>
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


--3paI2d6Q0+JAv9HI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 03:40:16PM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find some developments for next:
>=20
> - Migrate Atmel usb gadget to DM_USB_GADGET
> - More small cleanups/improvements on the atmel UDC driver
> - Change udc uclass name from "usb" -> "usb_gadget"
>=20
> CI job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22060
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 6f4c31c2b658358628b5b0fa801f55c7477c75=
85:
>=20
>   Prepare v2024.10-rc2 (2024-08-05 18:13:42 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-next-20240820
>=20
> for you to fetch changes up to 73f5b54a589cb6ff97aaca55e7c97d68b43997ee:
>=20
>   usb: gadget: udc: Fix duplicate uclass name (2024-08-20 09:36:36 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--3paI2d6Q0+JAv9HI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbFOAQACgkQFHw5/5Y0
tyw0vwwAiPePkTFd5NPu2t8VyoKI1V4DAjjAsWiwZEyvdYDXU6R6rhcZW1RR/CkH
ITYqhNQmULIbwj8Tv/CrVZaUZDd1Bf5lNz+kFSVdHeJyi3W3gc5ggMyQnpCnSZs1
eaRuB0AK8vrBZ3mopmYSa5kJH/staf+DNt6BqxOYA4uGkuKSafePLXpD9C2knOyv
liubIB6D98950kIP3I6OilGyS/d0Tm0VIG7oXMs13ZxdgUhAZDNsfssnm0oHz9JC
rhiX9fN1szg/9B7VrHukjJVpAvuKKkABXBHZa+Ctsx3z+5jnfe08CE0eSDi+09As
Bz+iEVtphSigCWSqyldhYbHm/Xy4wtsn7NXebGk+2D1mOLQo1LbPvQ4Aa/k3lySr
Ylbzm12oLboOkH1ENwr2LJbXjJ7HbWPsKfSC50OVtPz4T8JpbLbqzPqP4lZC7V0u
mQMcC09vvq7czvMYGqSRZNsAbEoNeSf9tU3v41FxSGt3SPjalwy3LpRs6aDks3iG
8OkW8t8F
=2ECl
-----END PGP SIGNATURE-----

--3paI2d6Q0+JAv9HI--
