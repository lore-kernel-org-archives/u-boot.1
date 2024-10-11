Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB3CD0EE19
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 17:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB8A1893B6;
	Fri, 11 Oct 2024 19:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="irlgjMKh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA7E893AF; Fri, 11 Oct 2024 19:36:00 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9449189291
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 19:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5e988c5813aso1237725eaf.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728668157; x=1729272957; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=81N5hDLf/3Kbu4Sh9zB3KacJ3MjxrWh46rfCpEh1hlk=;
 b=irlgjMKh75zKDZTNLUXySf0+MabtQUUUudOIgG39XC+zCBmxcpdOVGzqM+h9lXP7Ry
 ymXK52yiThuwE8xxwkrab6r9gmfHQkvoI3No3v8ec7P1mq2lqrcnxXNjcPCghamaXvt6
 nSEPdVXO35RidGTc+dlyojuG1ColEK8oKj3gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728668157; x=1729272957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81N5hDLf/3Kbu4Sh9zB3KacJ3MjxrWh46rfCpEh1hlk=;
 b=KCH370LChpZlInlkh7w05++10Zdae73RafaUDCoPgnMke7/Z/D9dEJvebrkcaMiarN
 li/lGlvyC4pLFBLwNB1QcGRM5Qi/NB27MQoDWMQajizw9Jiwo60wahMmBcQ9gH6cGOYy
 iJO1xIuXVmmdYjn1hQn4EAtpN08FV8Q469r61PfUbdMht84w20aMuX4TdElHzlA7vOhd
 BbKcbKqj3Rymq254NCDlsanyaNKNpsCxYeeWrU3qfSp0VKr53SJPS4KyfzDnJ0H0WP0t
 ulCRj60uw1kVah32fad1MeOLi4NxmYjs+2iwESCfuTCPiDNfKgV8V3OqAmLhxM6loPGO
 4LjQ==
X-Gm-Message-State: AOJu0YwJOBjC2t35IQHINp731CiuWvYW9k1rt7e1v2G3PsmwzLmXNAk8
 5JpjMRLxkPYx8D7sKkTzEENiJWpgEUGlH9lOU+6WATDRRTWuG22I0Yon9U3saOo=
X-Google-Smtp-Source: AGHT+IEQThG8EBLwL4H7fbOhEsC+qhqTz9OeSLbAsnq3t8CrOr0ryBrptMX3X6nzb+9YILo0kwXMWA==
X-Received: by 2002:a05:6358:7245:b0:1c2:f482:5c0b with SMTP id
 e5c5f4694b2df-1c32bd0bce0mr193481355d.24.1728668157340; 
 Fri, 11 Oct 2024 10:35:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b11497701fsm149927985a.99.2024.10.11.10.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 10:35:56 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:35:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20241011173554.GX14210@bill-the-cat>
References: <20241011124231.9198-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qyByF+bGHCcRF3IJ"
Content-Disposition: inline
In-Reply-To: <20241011124231.9198-1-marex@denx.de>
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


--qyByF+bGHCcRF3IJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 02:42:20PM +0200, Marek Vasut wrote:

> The following changes since commit a404065479be2c1fe1167c3c91367e8194a69d=
1b:
>=20
>   power: pmic: pca9450: Add missing newline (2024-10-10 12:17:46 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to c69ba5a4fed62463fb137eef8ed1fdc1aba2ff1f:
>=20
>   usb: dwc3-generic: fix CONFIG_DM_REGULATOR-off case (2024-10-11 05:11:0=
6 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--qyByF+bGHCcRF3IJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJYfoACgkQFHw5/5Y0
tywEMwv/X2TqjgMj7ZEnY78CnPBDWFut+PBVE+BZRvtw4ot4mLp0k3HESz0X8I6/
OJrMmVkhFIkKwex50wHAo83VglceyOBGDe3UoUbYQj1XJXD1jjSFju4KhNrXWhDA
Jb25Nu1iQYzGxVyaR5HPaA+54PErUbnMckLm2onrYZLqoHBJ89T6Df7X2bSnlim+
96EQTvY0F39KAgWLV2T+dRceZIvjf58EQe8dC2OvNhXQG9CO40uaTMGKIzgXytuR
QFiqWXuspa9Of21Q6NtVfQmGZrXST0B+3oq+WzXHfo7OU20mlZ/c4I5a+vdBOfN/
P/nICoFyhEIgeuEQrv4rLflUMxu3KoeL5pbsKIergEQN1W8aZr8aa3q1dCjDLhRM
iJ5DaB2HZK4sM7gFegsrnONG/Hm6EHmnWMP94URFB0i9m0DnJL/eg4LQs0rA5mgu
YtLhhHoqNU8UerBqk1M3c6yNs8LtvobYFAS3KN2VBQ6Difq6IifM8ryQHJTVyZRu
htxS3NcY
=jwxH
-----END PGP SIGNATURE-----

--qyByF+bGHCcRF3IJ--
