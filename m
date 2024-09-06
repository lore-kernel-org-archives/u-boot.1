Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1B3E6FE38
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 17:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D7288D1C;
	Fri,  6 Sep 2024 19:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q1apozIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 519A988D25; Fri,  6 Sep 2024 19:54:41 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39B1E88BAE
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 19:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6c34c2a7dc7so11896756d6.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725645278; x=1726250078; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6bHxoBWIqzFI7GcS28GSFUXaf6bYtuOJB+0DcZb0Zpk=;
 b=Q1apozIO2qmYIv2L0CaWvVJ6YKI7r9BVlAd2YDND+HWsmpflEoG2l21WjKp6tSlbdj
 BBq84uZBwSByygNFiB2FgU39VUdGl3aDsuvUbq5CtsSsZIlKIpvsYono+KbLpvaZKuEd
 jqtR60xTKhofyfiSGHjWoY/sjYZ43dCVsGt4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725645278; x=1726250078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bHxoBWIqzFI7GcS28GSFUXaf6bYtuOJB+0DcZb0Zpk=;
 b=hZ8FOw9WhgclZ/E2E5kQJaeSTAJ+ygKphEAMtXC+1ktl3Le5msFQgh5ToxuxnOBWvl
 gaaOuiNJZ96exrRArZmzER2iPdKq0r+IDFrNu7qV+7RO2fTEiKnluLRR+R2nx2ktGVw1
 rQJm/uRDuyIOgT3LxMDSgbXANa6lL7/xyCi26Uz2GtOt01p1/p3oisyOXu8jhHICzLrg
 nZbNIBcNhsFFrLZFdP848OL26g1PYb+e7p78eYaRZSfJcwiLH85lZvkTgsyaAbWkfZHb
 DWqJFq7U1FbzGbr1azF3BixcJfYVxMHmO188PIlCQ7V3PS2e8fcab9guSpJou6CHAxOq
 FQPQ==
X-Gm-Message-State: AOJu0YxJonyaOplb6eOEcqVXC+5XdB0EsPv7RkRxcLtGBx9Mc2GihIq6
 5s4d2Lh/3SYSJabH8QV1J8tHP10ZkmQOAmknsqEcZTK1dCgzSlZxdAB+OVwnVMw=
X-Google-Smtp-Source: AGHT+IExZ+5yG6yL3L+wQQrB3Yr8iIMmZMeaM83Of9Te15snU4ykPrGdo317020K2gGQPix/wO7dnA==
X-Received: by 2002:a05:6214:3902:b0:6c3:7026:203 with SMTP id
 6a1803df08f44-6c370260427mr157372166d6.11.1725645277930; 
 Fri, 06 Sep 2024 10:54:37 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5204180ddsm18309866d6.109.2024.09.06.10.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 10:54:37 -0700 (PDT)
Date: Fri, 6 Sep 2024 11:54:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
Subject: Re: [PATCH v10 00/25] Introduce the lwIP network stack
Message-ID: <20240906175433.GE3879073@bill-the-cat>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4Rr2PRTe248T0gXo"
Content-Disposition: inline
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
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


--4Rr2PRTe248T0gXo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 02:33:16PM +0200, Jerome Forissier wrote:

> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. and
> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> so. With that it becomes possible to fetch and launch a distro installer
> such as Debian etc. using a secure, authenticated connection directly
> from the U-Boot shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot

On am64x-sk (am64x_evm_a53_defconfig) I'm seeing:
=3D> tftpboot 80200000 EFI/arm64/grubaa64.efi
Using ethernet@8000000port@1 device
TFTP from server 192.168.116.10; our IP address is 192.168.116.23
Filename 'EFI/arm64/grubaa64.efi'.
Load address: 0x80200000
Loading:
=2E.. silent hang ...

Which I didn't see with v9. I can test other TI K3 platforms if it would
help.

--=20
Tom

--4Rr2PRTe248T0gXo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbbQdYACgkQFHw5/5Y0
tyyrmAwAuhh+MWE8VK0jz009nLMnf8lCvno8CB+e0FJQCylVO23nZuXpVqYm/9sX
QUUeLaW++XYzfd69ch/LDaLaf5nxnN5dR96ogdbf/2S7RpU9xDbxLPWVVU71C8TV
JgoJgug9FvxES9dRwJey3gry+TboioJFyLCX1ERFbg+T2K9xEEcdfs5OQiWVYUQX
SgNh4gtu3l+F5Xxypc1MmGuZCUjhxvCBmrlECGFZGgHfe/1UrT2SpXawLtJHVDzB
yFVgj76k8M9DLLwNv9POjefxfTe4JkIyE7SeXup5GN59WDVi2DAh+Jo88vc9iKze
aZBPhfXkgL1t4PU0loo8EZU4byyFw9wOO8BGTJy6z/hXEZELEyM1x5kcyXad9xha
g45Qkss4CuRMuoCi67/N2AjOIvrz4Ki/9ao8DDckatS/vFEiObMx9CeDVvDd5z40
KxN7eatynSeH5kKbGJ62BLu/l9j8FtNOZa5r4kNgLkydTTm9lv8tvk7Sj4lJjkf9
k87Duxlj
=aF8g
-----END PGP SIGNATURE-----

--4Rr2PRTe248T0gXo--
