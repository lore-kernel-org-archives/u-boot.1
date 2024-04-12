Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827D6C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 14:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1779880A8;
	Fri, 12 Apr 2024 16:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TFT+U3cM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5142881A8; Fri, 12 Apr 2024 16:52:41 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F0688027
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 16:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so1018362b3a.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712933558; x=1713538358; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lTpEmUap4Wly1aB3S3tH/cgnlV0kyDb5egPWVX6Awn4=;
 b=TFT+U3cMDCxfO7TBP7e1+op61xJXotYxri/mAs9ubkI6ovL0lLjmhG64JY+EKu10ck
 YlI85IDFfPnJDWCX6/JobUmSbLvJVWaYsm1o92yhvktHjheYSEn4PFGLr1wMPugAw2sz
 431ZE3RIqJXifM2xqup0sbph5cktwAD9aaujk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712933558; x=1713538358;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTpEmUap4Wly1aB3S3tH/cgnlV0kyDb5egPWVX6Awn4=;
 b=bfNApI9UZ437krPd6ZqcCxupHOSLU0pDzvQJ7Xye0Up3GOqH5LgrFpKz1k0AZw4QfK
 hBCwNS3T74sJ5KZLSgEwE0DXZHP3o1Y3NasTJAZS62PYZIv95SYpVwPROig6t8A1Qsvb
 K527dFc3LwNYpKsWgxwor/0F8swJbw9jJzDeO/8mIqj0aeOVn1gKvVtxM//zDI+VZ/DS
 5JQqH3b2M1jFp/A+IxgoCe1ei8v8ISFzjH9jJhb8GtCoBQST5KW4Ay0DpXScw4tiX1D/
 XGN3qsyFr64bXL3bFU/zcDexo4CTpvQ5j8aPTtodHylcSgp6Y90kroG9+1hFacAT6FkD
 tvxg==
X-Gm-Message-State: AOJu0Yxy/+Pf5gQCa42fku4h0WoR+3nazlKAg2CbY1S3JYMH1pyTy8QC
 zR0Mm3hBd9B9279BBxWU6BcOAvgrWbxm2pvYSVaPZ+BG6KIZs98YGMyQbYh6Vw0=
X-Google-Smtp-Source: AGHT+IGEyNLpqsFgSF1ZLabSwX4y42Of4XpNnOEmSSamJmCznA5Pn2UgESEEjRTE0r0YhgU+yORjLQ==
X-Received: by 2002:a05:6a20:3a87:b0:1a9:3cf2:508d with SMTP id
 d7-20020a056a203a8700b001a93cf2508dmr2583184pzh.38.1712933557678; 
 Fri, 12 Apr 2024 07:52:37 -0700 (PDT)
Received: from oliver.lan ([2806:102e:18:245e:2606:71da:664:f052])
 by smtp.gmail.com with ESMTPSA id
 e20-20020a170902f1d400b001e3e09690c6sm3087871plc.199.2024.04.12.07.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 07:52:37 -0700 (PDT)
Date: Fri, 12 Apr 2024 08:52:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, nm@ti.com, upstream@lists.phytec.de, bb@ti.com,
 vigneshr@ti.com
Subject: Re: [PATCH v2 0/3] *** Introduce get_boot_device() for K3 platform ***
Message-ID: <20240412145234.GA361815@oliver.lan>
References: <20240403135911.1987293-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vXWN8JFAXrvoP55q"
Content-Disposition: inline
In-Reply-To: <20240403135911.1987293-1-w.egorov@phytec.de>
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


--vXWN8JFAXrvoP55q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 03:59:08PM +0200, Wadim Egorov wrote:

> It is handy to have some u-boot environment variables set based on
> the current booting device.
> Provide a way to obtain the boot device for non SPLs by factoring out
> spl_boot_device() into an own function get_boot_device().

Applied to u-boot/master now (but I seem to have missed this in b4 ty),
thanks.

--=20
Tom

--vXWN8JFAXrvoP55q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZSrIACgkQFHw5/5Y0
tywhpwv9EkFvq2vUuKgTBk8CoivF6T/CTDJPuzvQNveNW4asehj91xgd1P7p5BG2
tA92pTxgyQJBqDMW53nQKHczflOQFtYDvS4iNj9FuOv+xJM4tlArqYYllhiSfcVm
Qq9UZMZe+7uQS00/nOycI3Y1WibalEqo+YJ0xrbPisMiUjbPxK5UYA3keiUQDrwY
+VLXqTMN1mPVcGzpKKjDsE0ekTc0zmVhTg81w69KBQo274Fr1hQMjhOxdooxXGvi
ydLMRqM/fqTvZ7h8g7If9CCLFT1blhgj447JNhdBnhFmA8SQE5tisYsj0hay1gI6
rNbhuygcVyqG8FIQ24vhQHQ/oY0jAmBg+DFch75a9k/WKxSf/hcMp5gY1IOGJcfT
ummRwAdH8rj2vMcZtY89Zp56dokamHIS9AuwZ+kxyKayIeKz3sNBFh0jtXWCLDad
nKdJX2emTVIvoyfpfkg+qDb8hbSIe7S9c1Xp85uAupsv6+vSeXe/g8zVrdCy56sx
KEvFvGyv
=sOLG
-----END PGP SIGNATURE-----

--vXWN8JFAXrvoP55q--
