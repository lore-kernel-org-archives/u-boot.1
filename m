Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E4DCD1297
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 00:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365B0879E2;
	Wed, 10 Apr 2024 02:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KonlOmH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FAB8815D; Wed, 10 Apr 2024 02:44:48 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6308E87572
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 02:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-69b1effececso11513546d6.3
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 17:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712709885; x=1713314685; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S1SdZyGJCibM3wembT9VSAdvLrOZ5GC+e7aXO++QZ6U=;
 b=KonlOmH2larJHkC3PpkQk7xUnQjOGGEgvs/vd6KodkUpRF2AuoDLB+iMrGJ3LwdKmr
 qjaMBRlxjJ76Je4viYeq/SQ8DEwEsIIgpu0iuMGUiSz8Tw4DuzpEhRuH7qHdvL4n8qHT
 sTwh3/F+Wvf3KRhN/ZvcyY/rSSk/AP64KUSNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712709885; x=1713314685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1SdZyGJCibM3wembT9VSAdvLrOZ5GC+e7aXO++QZ6U=;
 b=OL//4lWkQPgBk3qHO7WxG1+gvv1My8ZLmxV0VD0b0WvgiGtxsJZpeXAiLqNiia+Fag
 ND4XfrZc9oN8dAGHhwYEkwbRXolfW5oKUCvvgqeKZXexXFIQKevVyCN1gYFfKTzoPpPN
 2MEtl4/TwRLT4+foypc5X61AxSZlagyHxWLByrhE6R7Qbj/EgrlguDttRZGiqA9TwmuN
 V5RH1ZOtj/8Ir5qT7AWcsMjCL17TMJ/NVgzr2fWU8JKwrj8Bfe/IH8bHkBQYG1SwyQlJ
 s6/M78k+RyfBquPwwnS0lI8gheZUJbcKAcPH2HUMFlJrZY5CuB7lGp79ZkcF95QOMRdl
 TSyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiMWuAP0w/54qwEeguIGtdGRi8JIPtDOrskIFVdDS0jLmIeW0v+j8bwgEJoI9w6kBALnVjwwfypL1z4HKuPcaG4VSAaQ==
X-Gm-Message-State: AOJu0YzHGjVO1zQtMm4G6XJdDJ8Ab4TyAqAVunL4VCIYEmzzC/4llhxH
 1Du7vgonOWHoEf7gsIP0ak5Kx3xQWmIF8Y8nepoPdyl+8i2F68UewIWWJB0caFA=
X-Google-Smtp-Source: AGHT+IFDKtHoK7nGkYdtxrKl+/QuuxYQwjlumqUeJGXMhyqHEBWEa58v0PIvfZTtVt2LzDBz98gqaQ==
X-Received: by 2002:a05:6214:1bc8:b0:696:8ecc:7e7a with SMTP id
 m8-20020a0562141bc800b006968ecc7e7amr1308312qvc.25.1712709885214; 
 Tue, 09 Apr 2024 17:44:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 p6-20020ad452e6000000b0069b3b3b9c68sm40369qvu.41.2024.04.09.17.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 17:44:44 -0700 (PDT)
Date: Tue, 9 Apr 2024 18:44:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jonathan Humphreys <j-humphreys@ti.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 02/16] board: am64x: Define capsule update firmware info
Message-ID: <20240410004440.GE2493117@bill-the-cat>
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-3-j-humphreys@ti.com>
 <185bd37a-9e1d-4daf-8bd6-57ce598e95fc@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kwG1cxX70OPWDLW7"
Content-Disposition: inline
In-Reply-To: <185bd37a-9e1d-4daf-8bd6-57ce598e95fc@gmx.de>
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


--kwG1cxX70OPWDLW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 06:31:02AM +0200, Heinrich Schuchardt wrote:
> On 4/9/24 00:31, Jonathan Humphreys wrote:
[snip]
> The series has been assigned to me in Patchwork.
>=20
> But changes should be tested and reviewed by the respective board
> maintainers (Vignesh, Tom for AM64x) as I have no access to TI boards.

I'll pick it up once you're happy with the capsule side of things if you
like, but in my mind it's more important to emphasize that this is what
capsule support looks like as it rolls out to more platforms, is
everyone happy with this?

--=20
Tom

--kwG1cxX70OPWDLW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYV4PgACgkQFHw5/5Y0
tyzURwwAo84lL8QqCH9aEnigJfEltuiYCzvsG1RJLGYa5Bb5eQSv64DYxiCuKDkj
ikrQ8wElglZIyvsz0j8QYASBKhQUKCVwDNGG6lbcyc9rE2DR6sHYFCCP+7HL4aW0
A3sGC12b7crubQf0ZAtM8opdVnwJQMYSV8wjRFXjauKWBB2r9APrqybAONDXPfFh
YbXXoY3hkkXgmRu1tREApAWstuOF6kNW2ra3eOhKejqBIz+bBnSv/ZFau99aNAHt
rHKETTeyfeoKhxPOtHyMNxi1phwFHzaeSJ8AChbjVUDLetwucbHYhR8SLCis9qC4
OHBIKey9XRdhncTOuBdQMaiT8Eaf5DqxFRRsxm/4Wxgt0YPWM1iLm2d1XEtyaU90
RgGbm/vvWr8In2L7D7JuwXYRuSoIle4xA2NVHcPQQinPSjveyGaVB90KjYWAs1eO
oXCnFqc+W50PNjXCWvnhOGJu4LUUqN0IE82lcGOjVztzwsY5+6Vo9BVX4hTzTtA3
W0ZQHll8
=6/ml
-----END PGP SIGNATURE-----

--kwG1cxX70OPWDLW7--
