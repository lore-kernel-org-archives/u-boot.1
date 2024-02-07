Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B0AC4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1420E87D2F;
	Wed,  7 Feb 2024 16:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JEIBcoml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D788D87D1F; Wed,  7 Feb 2024 16:45:15 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D495F87D1D
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-783f49812aeso27770985a.2
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707320712; x=1707925512; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=49WOjELnfM0pg/QuPMhJso7sldaGAKsx7n1XMq0BpZk=;
 b=JEIBcomlkwnX0Q3QCvT0SZFkVuYSnm3AtJmTSI5b3gdNs+r5Mi1wxOKDoBSQ/0ckN3
 BNsaUmD8qwFevhfnFm+JzuNqJK8Meu1uz059IH31Jc0Y/xnXbtMlB97PiGjZe26Kemk8
 YOovZSnpKi3eFsnkb2WxYAlxk9adcO96xgIGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707320712; x=1707925512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49WOjELnfM0pg/QuPMhJso7sldaGAKsx7n1XMq0BpZk=;
 b=u+XQCKhx9QazEZDjImnyMvWsfHAffcNIYjpPHt7SsL3q85S1ApgzdU8uSjvo2Tt5Sg
 PFypQebCPrQl1n/XSF/BYqaFoqB81RbpWcdlOPyMzdaCRBuyOA8vmltnmo9eupewR9le
 kijl7i6j1LTonclNtYGpatuhj9Z6fBhSan6KMXGGvPxdpJXATFMVFRmIl4lL3cJHXKAe
 IheAZGNOV+zbY7SLV+9mBVfzFgWz4w30b3UyUbDu+lzUINw3IjFQDCEqU7CiAy9+TD6j
 WvXQQyZ9YnonqUyXIjANYNQYQVDROpkZodA1CQuE74bz/5OVdtVsm+U4ZeAQcb1mFjXL
 qG7Q==
X-Gm-Message-State: AOJu0YwNkAT4RLaL5fo/D99EXOyKwIFNHGUWytwoWKe/CYNml7ABI2aO
 xYjtajLEC7kl7sGqXJG+8lJKZZras/BgHXVeownAmbKnWaxw16TYXNXtsumrPaw=
X-Google-Smtp-Source: AGHT+IGl0cxWdQRLLMy1P+Ly2Fqjj/36k2XfFQeHNNpOpqtNGCGgsLmPqTmHgy+c/C5EQp14+m+pIA==
X-Received: by 2002:a05:620a:4c3:b0:783:3a23:ea3f with SMTP id
 3-20020a05620a04c300b007833a23ea3fmr6139618qks.77.1707320712708; 
 Wed, 07 Feb 2024 07:45:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX8ZVOP5gXUHWDPsuYFZgR0Y0K1Hvs+nTnaxeSCdhsy7vsZkZbG3RNd5/5KDQqscGvQuYhYl+RhZfBsNEOokTfTG0sDOOU0JlIie7DvUxaon3T0rPEz2u4N5XmbPqtEmyxYRN5u/A5tGqrFooJCJUygr82IYkfDdMtwVH7HBAbZkShiGuYLYIZoyxcSaHbzU17riTOfpxA8HoR+gEAW0Rv8BNnV6og33NGv47Qp5xMAvxc3w/W5xoJgSXtQVD5Q8jDMvmccVYGsiI5AUyGj
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 bl10-20020a05620a1a8a00b007840721780bsm616662qkb.66.2024.02.07.07.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:45:12 -0800 (PST)
Date: Wed, 7 Feb 2024 10:45:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: m-chawdhry@ti.com, u-kumar1@ti.com, afd@ti.com,
 christian.gmeiner@gmail.com, j-choudhary@ti.com, nm@ti.com,
 d.haller@phytec.de, joao.goncalves@toradex.com, u-boot@lists.denx.de
Subject: Re: [RESEND PATCH v2] arm: mach-k3: j721s2_init: Support less than
 max DDR controllers
Message-ID: <20240207154510.GE1152441@bill-the-cat>
References: <20240130102356.2762733-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="myy0FEWbgWOvp3jR"
Content-Disposition: inline
In-Reply-To: <20240130102356.2762733-1-n-francis@ti.com>
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


--myy0FEWbgWOvp3jR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 03:53:56PM +0530, Neha Malcom Francis wrote:

> The number of DDR controllers to be initialised and used should depend
> on the device tree with the constraint of the maximum number of
> controllers the device supports. Since J721S2 has multiple (2)
> controllers, instead of hardcoding the number of probes, move to
> depending on the device tree UCLASS_RAM nodes present.
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--myy0FEWbgWOvp3jR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDpYYACgkQFHw5/5Y0
tyyiMQwArt/lFH2riCdcVahSi9UJwPtWyUB/GXg+eioIAeMBIvuPSPDHjzZadgE4
VOS1SxVfVHWbyiYxwD9JG5rDklact40bu8lzmoznSvXACpu2qu7Bz6z0+uJbklkI
6j92JP6Hb7tDXpFT+upAhY6ZO/J+dKd+7kq7uNQqj3lFf/BZ8KXrNgybV2BPgu+G
6NVea/me33Gz3TyaJlVJdyEo4kht9B0vWkmWJqkdZBg4QQ2aF5nHtZER5b5uEkrR
LG7r1uHK8s7UxR6AeEKQ7rDRDWcAeBj2bfs9VF2JFH9s9ZcwXoRsh2WpKHVQjAoI
5W3YWUStqewdVY981sKcAXDISre5GL7LFEh3S6ekqv3C6wUWD94MfquowsoovCvZ
nOn6PlmJhN0x7hdbUrhe8N1Pn61Bmh1h4B7sbI1pF2y3jXrNjf4+q4mT72QT7w/c
5jvVWwIlA9nCMJkltUMwC5Kc4agTqCNPuzU9qc5UpwJ5zxZBPWT0lewhrt8YEtKF
NmzpwiKg
=7j8G
-----END PGP SIGNATURE-----

--myy0FEWbgWOvp3jR--
