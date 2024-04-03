Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB324CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 11:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF0F88376;
	Wed,  3 Apr 2024 13:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uJqKmg5B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26AD788240; Wed,  3 Apr 2024 13:19:19 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E24B488322
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 13:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-60a0a1bd04eso67686187b3.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 04:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712143156; x=1712747956; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7E5nc8ETSEdQL88fUxDEDebi7EWte0r6iRA+bP3ROts=;
 b=uJqKmg5BS/39c1KiROsVakP8sx+AO/bSCOAc9ussrnRElYaKHChVYe1c7KpdDDbKo2
 Wt9TwXq/7WKM1QaOpP+dW7kg3a9HD1W2X70vaaJfj1x8l8m36V3VEem3IChUaRVDxkfy
 rvcqqLWoaVbJMofhORfFw11NBY1Kgc2O6Jw90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712143156; x=1712747956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7E5nc8ETSEdQL88fUxDEDebi7EWte0r6iRA+bP3ROts=;
 b=ZA8n7WrPjT4Sth7Z23GsUkeuOBNgNsnONef01eRr2RTO62irfI2YLtW10ceSXbDPut
 qcgeFqL9G5Z49sU6jaRgzAssV78sQqWzhbu/s9ShoThCoZNC7Tiuc59LvCfzifoN8h/R
 4nA6SGZO7vRvh0AwBvqdqpr+ydT7grXAe2cUvUv/zNB0xjkA5znNhiBprdVsvLORTYVT
 qkosrXAccI50ZNaG3JRGtBMmTdbZASNj2dzd/HNKbGv2XMU3q803z7R3uiC7efepHpsQ
 YnECjaIdx4ckS+5f24AUdpaGKkPn2d3Yt+9ZYQBkOSp7XLTHmETsRmaX1WDGNQKGPxi5
 +JLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9dSsIw0OOxCGSmZux6PtRE0fP8UDHSIbCXQclFbnZ7H7WkOKrQ8XnsL0Tk81CLYn/kntAiIj4d6XjrsNDb034qy+F+w==
X-Gm-Message-State: AOJu0Yw9+zkd/AIzGDlTcspfzLcP3OR3+ZswIzJZ8uKkdxC7WpoNTowg
 K7Xrrxc5mfJgWsVoQDZ+6ONl5p6JRHnG4zJD3EDrAle1wB8hykNxCPisFZZokN4=
X-Google-Smtp-Source: AGHT+IHnwKsow4FdGqA4unZzvMJBbQIGYQjGbvNDF031XAze/Fo+YogA3tE5cyVHY7VbiOAoLTCnaA==
X-Received: by 2002:a81:6588:0:b0:60a:2c16:da3f with SMTP id
 z130-20020a816588000000b0060a2c16da3fmr13139358ywb.28.1712143155799; 
 Wed, 03 Apr 2024 04:19:15 -0700 (PDT)
Received: from oliver.lan ([23.155.80.164]) by smtp.gmail.com with ESMTPSA id
 iv4-20020a05690c6d0400b0060a0a571e47sm3239939ywb.104.2024.04.03.04.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 04:19:15 -0700 (PDT)
Date: Wed, 3 Apr 2024 07:19:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20240402
Message-ID: <20240403111913.GB3633@oliver.lan>
References: <878r1wglap.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5AmvHwj2/ONu9hdK"
Content-Disposition: inline
In-Reply-To: <878r1wglap.fsf@baylibre.com>
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


--5AmvHwj2/ONu9hdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 11:34:38AM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Here are some developments for next including:
>=20
> - Implement Qualcomm wrapper for dwc3
> - Multiple sector size support for UMS
> - CDC ACM gadget initialization fix
> - Refactor board code from dwc3 to prepare better interrupt support
> - Bugfix for for qcom-smmu when compiling with -DDEBUG
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pi=
pelines/20143
>=20
> Thanks,
> Mattijs
>=20
> Note: sorry for the noise, I forgot to include u-boot list in the first e=
mail.
>=20
> The following changes since commit e50cb36cb5e772d5bbd30d070faedf73234063=
64:
>=20
>   Merge branch '2024-03-19-assorted-updates' into next (2024-03-20 08:39:=
05 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-next-20240402
>=20
> for you to fetch changes up to 12ac51cdb788b9f8e50cbc4fa3681102882ade33:
>=20
>   usb: udc: dwc3: Fold dwc3_uboot_handle_interrupt into dm_usb_gadget_han=
dle_interrupts (2024-04-02 09:08:07 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--5AmvHwj2/ONu9hdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYNOzEACgkQFHw5/5Y0
tywRrQv7BaohmypiTd3DYkGD4wHewg2c+fMiNgjV1s63DlYJGPk3Ii1vlAhJGVJG
hoZ2RYN5XZxLoCdystM1T6KN52ATbDVEAvOQWowVZrCI06JR85QDQMcXobNCvEg3
Ehu0PbYiuA+07b/MOnlZdbKGkyUn832R04fA3YkblHjP1h2UpOuZB742u6ZXpBKe
h9iShO9ap5moMeNB8oMaUGAgHfen9JpuaOwE2ovVka5fB/LzIwkkZfRJHGzOHfMP
d6nekm/r3P3rLDDN36E2EGhKxZo5Dwbj3rSlwELxulh6PbFvZdxXUtHy/+qQNKwo
99PHfhy+50xep5W7fmLORi4rlIY/dQZsIUGaDFDLrhO1yYTes8J0Ciu9qS360jRm
3ncQwNkFvmmDqoxlwVLsJ7JVfQ655VJbf9dSMEBqC5pe2D2dfm2/MmlSBdsMaOK0
TYUaMpVgpFFQlUYILLAGEna7cNV3ZsLrazJ3/mUhXgW3AqFl1vFBSIj94NpC3LHM
KiVDU9wq
=IGuP
-----END PGP SIGNATURE-----

--5AmvHwj2/ONu9hdK--
