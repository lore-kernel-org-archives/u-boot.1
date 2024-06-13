Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B2AC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 14:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B30688920;
	Thu, 13 Jun 2024 16:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HGVkxKD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8013A88926; Thu, 13 Jun 2024 16:20:11 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C54807EC
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 16:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-24c9f892aeaso491352fac.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718288408; x=1718893208; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l4cq/5v9eRpLL0m00ref3gb7UAUXV1nQRgcJttnLFMY=;
 b=HGVkxKD117ed6kWcMbdx9m4AjCGVhVxcxGQDm0o0WLL+mAcKWguYlJyuG0uB+SQdHN
 9toq9TNTzBY4PW0j/ZyCipWjRHhf+VkRf1PJYtmw6R0mOKh8wUIx4xMIaFwDFAxNDmQU
 /t4l4cSVJ3xdjcCdAaPI13wyi6tsVTz9SFg98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718288408; x=1718893208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4cq/5v9eRpLL0m00ref3gb7UAUXV1nQRgcJttnLFMY=;
 b=DzJ4KZGH19C5GjTzTaUqkAwlGifmNu6aGjPWTNHsHwiVF6G215fXCbzlc1GZuDuvU3
 AY++KJTQ1nLTTMjcw8nRqFkN/8GpEzXiArhv7koKDJyQFeHPdknQb0f3+DUXYsVIz9mk
 ZpRUvJhRir96A37x3FGc4u/X9Tphjmm9PKA6xw0jphmUVWGq/20Hadt43EjCfjRIZz+W
 9+9uwVYf+HfjZ86THeRP3yYSXstAO3mYRkvZ7+bzeR2Mg6HpNgwVNRkhMTJ7YDyXDMjx
 JnA0Ue41sGHfrf3JydJP68dTQQ0hnn+ATCLcrzgg2BKT72q6Qg7ccVw4gXIrNNPdASnP
 2n4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWltAu49lMx1NR3qeo+DXWQCX521c0rIDe9L5ksk5O+Lwp+vpL//PKknhjrtp2gZbPIAhjCJdHJpuXkQZ8xCKf2221YhA==
X-Gm-Message-State: AOJu0YzZjmNpR06eGCgfUUudLZeY3zr9/rGH1wnR45o7jPG6HFOPU1Pg
 bqEgT+9CLdTqLxtmAW7RWBQJU1WPsNR/aLUsavzXY2sKiTMk7TOlhMuTYEZJerw=
X-Google-Smtp-Source: AGHT+IFUilBePESKmxmAsccm+SiQjMCk8rMDTjYaI9S9aztBMHixCojUC2HLrl+gMGzNmKQpO+AJ3Q==
X-Received: by 2002:a05:6870:e9a6:b0:254:9085:7bd9 with SMTP id
 586e51a60fabf-25514c27139mr5776801fac.18.1718288406392; 
 Thu, 13 Jun 2024 07:20:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94b7besm414448fac.6.2024.06.13.07.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 07:20:05 -0700 (PDT)
Date: Thu, 13 Jun 2024 08:20:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 Neha Malcom Francis <n-francis@ti.com>,
 Keerthy J <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Aniket Limaye <a-limaye@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 2/7] drivers: misc: k3_avs: Use soc_match_device
 instead of compatible.
Message-ID: <20240613142003.GA613089@bill-the-cat>
References: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
 <20240528-b4-upstream-j721s2-avs-v2-2-df940f2309d0@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y7cD8PeJfs+HKzCU"
Content-Disposition: inline
In-Reply-To: <20240528-b4-upstream-j721s2-avs-v2-2-df940f2309d0@ti.com>
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


--y7cD8PeJfs+HKzCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 01:43:01PM +0530, Manorit Chawdhry wrote:

> vd_data remains the same for most of the SoCs but there are some
> differences in power domains and clocks that don't need a change to
> compatible and can be handled at SoC level.
>=20
> Change the data population logic from compatible to soc_match_device to
> add support for newer devices.
>=20
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

On am65x_evm_r5_usbdfu am65x_evm_r5_usbmsc:
       arm:  +   am65x_evm_r5_usbmsc
+(am65x_evm_r5_usbmsc) In function 'k3_avs_configure',
+(am65x_evm_r5_usbmsc)     inlined from 'k3_avs_probe' at drivers/misc/k3_a=
vs.c:459:8:
+(am65x_evm_r5_usbmsc) drivers/misc/k3_avs.c:333:12: error: 'conf' is used =
uninitialized [-Werror=3Duninitialized]
+(am65x_evm_r5_usbmsc)   333 |         if (!conf) {
+(am65x_evm_r5_usbmsc)       |            ^
+(am65x_evm_r5_usbmsc) drivers/misc/k3_avs.c: In function 'k3_avs_probe':
+(am65x_evm_r5_usbmsc) drivers/misc/k3_avs.c:323:27: note: 'conf' was decla=
red here
+(am65x_evm_r5_usbmsc)   323 |         struct vd_config *conf;
+(am65x_evm_r5_usbmsc)       |                           ^~~~
+(am65x_evm_r5_usbmsc) cc1: all warnings being treated as errors
+(am65x_evm_r5_usbmsc) make[3]: *** [scripts/Makefile.build:256: drivers/mi=
sc/k3_avs.o] Error 1
+(am65x_evm_r5_usbmsc) make[2]: *** [scripts/Makefile.build:397: drivers/mi=
sc] Error 2
+(am65x_evm_r5_usbmsc) make[1]: *** [Makefile:1892: drivers] Error 2
+(am65x_evm_r5_usbmsc) make: *** [Makefile:177: sub-make] Error 2

--=20
Tom=20

--y7cD8PeJfs+HKzCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZrABAACgkQFHw5/5Y0
tyxXzQv+KUvHRb+prA6SHLYf+JS9yGxqBCTedHRKJOMISlVlPhkbfwalZbjhUWzX
hBWtUock483QNJvryDi8sqZGxW1Ohmqaa+K4yJzG6IPWepQowC3p41T25ZgN33mw
tdeilThBHOcFHh6g8chtWPTanZ57V4S422X/GDf6i+P+rX/04ThCVfraJBuChF4j
OXnRujh1OOz/UEr9+HAlf7pSMoXAk73LiTl/arUeQjbXZUrKLQz6D4rgjTkk7ynO
XEQ9eV7WZr9tVXyxZxnhdFXdieCDcecobgiXiy/SOmo1Ttp+me2/AUSl/KUaxv93
MrU7U0cRTNFa/ElRQf9bwOcYhdQqK3wJcD2LO49PHC+ZBqx9JFbuLRlN68/qCxQz
iSbntNweEKkJzlJWgOsm6ogXaY3V4JTyaR16pK8P82o2GFrsWIKeg7rwS8ra9/6+
dpT5/Kq5x0Cum94D71QRfCQUSWkq6KVypQ6zSI9i+ZgjWZIsUE8wYQiGMxd7sZSN
q4SRoaeV
=kjH5
-----END PGP SIGNATURE-----

--y7cD8PeJfs+HKzCU--
