Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9451CCF2DD
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 15:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CA583A6A;
	Tue, 20 Jan 2026 16:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jv9pic+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F23B183A8D; Tue, 20 Jan 2026 16:52:18 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0240783A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7cfd65ea639so3229018a34.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768924335; x=1769529135; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XZyg0VvtEV1FYYUZULc/gHGiSdpToRuEGHnbd4Q7DRs=;
 b=Jv9pic+WWY4mpEqDWkWd7yPqJyIhe0X50rVw57nTNN2b2nQ9/ZiJNVyQScZq4WyCBv
 LL8jSH1T/mocP1a9RtDTfU6A7Yr9iXXoFn4z6eo8s1DInjTEwSn7t5vjP8CaiSC+4bBm
 zisPQ1xugLpQiXvLinuH3z2I67nONi4B/t/dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768924335; x=1769529135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZyg0VvtEV1FYYUZULc/gHGiSdpToRuEGHnbd4Q7DRs=;
 b=GBfIkWJlrlI1hg+T2P0tX8ZFA2c15IUjMPYdGuwnVlc8YlAz6Umrl5C/zK+h76IKdS
 gtIUQykt95xatTOSCOCMw624B6zSyjns5PIX4izlHa0eh2TuENkfFa5pzV51acLqdo/K
 DfB9RZUWqe6/4eKMKtBzQb3Z3WM/GKtAutqpj4Pgcvvn5MF6/+DXAOYODIFhSN2h+t/U
 JB/p2+vrzEzYhU9PHlDXFn+lSRQ2WAK7974aQQNMJu1vXnUN2hQbAEirR3LMJXzHyv5j
 1Z9pEW/GYxmm3IcSyABha6uqFeeHqcUY3Dpwwtfe4t769ju3BovQSnBzyeNRP8p6cUUY
 luHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCaxvWqyjITLVYLn2zE998GUtSRG3SP96FWKNC3EiUdRl14vn/JHxLY7TZ9xEVIqCfgkwK8kk=@lists.denx.de
X-Gm-Message-State: AOJu0YzB2l4Z+CfzaHXz3NUDS8S+5TZSmQ8en44yaHgXMsvo39R8kS4B
 cshAtBuTaB2760ylXhfYk+CXP3nMqx//u8ylzt6dFJ7myA5zyhNMXC1LBkroE76e2Q4=
X-Gm-Gg: AY/fxX7iqmYi2SLzskrg0WuTaB24f74jghNIyNmB8a+Qmn9BPP3kxfCaFxVM1dM22e4
 tcZ65W7Cj6gsXX06UUpWlx2s8qJPxlKejj0Ff560LVqyO/ZYpEsrbwEJjZT7wPuKzdmfE3HBu9T
 426z+X+eCphK+7HPpRE9tEVEDr8HNFBkhgWkJK8eKqMLNZLVDRsD+ZlZ63C8wtAF1KzQucj2Xyh
 PUcrtKLenZPWn3r3HPi6SKekoQX1PsSkMXW04KRwPKGJtE2JAGi0X7s88qnu6VldM96zGJ8eqTr
 5BosJYk/bFkEAvbK8uNGJXIqgrH5J4PZ/CzGVn2XwR6KZ1xr31u3Buxz7RnMwtHbwDm/N9bnpIS
 IpDwi5ERK8HB6N4Um9pyOgfYTlG86QJwaHEeZLd7HTNc1BLuZd2eRuBAWvBd2c/UYA/XRuByO8P
 6CGkS8+MTxIhzUSXuQhTZTqDf4ul5EOPFZl8aQ1f0GIwRYOF4fxIVluYwMxqnNrl9y71e3jEXPU
 Ye8WMdC1eOcMPFqYsUdojkhucys3DtNn9Sl3Scz1guKOYFMUw==
X-Received: by 2002:a05:6830:6ab5:b0:7cf:e4e6:2d42 with SMTP id
 46e09a7af769-7d140a3ddcbmr1202078a34.8.1768924334749; 
 Tue, 20 Jan 2026 07:52:14 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0db2ddsm8737295a34.3.2026.01.20.07.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 07:52:14 -0800 (PST)
Date: Tue, 20 Jan 2026 09:52:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 paul.liu@linaro.org, adrianox@gmail.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, jerome@forissier.org,
 mkorpershoek@kernel.org, ravi@prevas.dk, me@ziyao.cc,
 u-boot@lists.denx.de, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v2] efi: stop hw watchdog during EBS
Message-ID: <20260120155211.GN3416603@bill-the-cat>
References: <20260119210925.29185-3-casey.connolly@linaro.org>
 <87ms287hmu.fsf@bloch.sibelius.xs4all.nl>
 <5995c605-0e94-45ed-981e-49506233597f@gmx.de>
 <6922d2ec-207b-48e6-aa77-ca1e30393bc5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1ajGerBx6ERTpx9U"
Content-Disposition: inline
In-Reply-To: <6922d2ec-207b-48e6-aa77-ca1e30393bc5@linaro.org>
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


--1ajGerBx6ERTpx9U
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 04:12:27PM +0100, Casey Connolly wrote:
>=20
>=20
> On 20/01/2026 11:01, Heinrich Schuchardt wrote:
> > On 1/20/26 10:33, Mark Kettenis wrote:
> >>> From: Casey Connolly <casey.connolly@linaro.org>
> >>> Date: Mon, 19 Jan 2026 22:09:25 +0100
> >>>
> >>> Hardware watchdogs don't currently get stopped as part of
> >>> ExitBootServices, this can result in resets during boot if the OS
> >>> doesn't have a driver for the watchdog, or if the driver isn't loaded
> >>> in time.
> >>>
> >>> As with the EFI watchdog, stop any hardware watchdogs as well.
> >>
> >> This has been discussed before and rejected on the grounds that this
> >> defeats the purpose of the watchdog.=A0 I think there was some consens=
us
> >> that an OS that doesn't have a driver for the watchdog or doesn't load
> >> it in time is broken.=A0 Some folks also pointed out that on some
> >> platforms it isn't possible to disable the watchdog.
> >>
> >> Ultimately, I think EFI needs an API to control the hardware watchdog,
> >> such that an OS doesn't need a driver.
> >=20
> > The hardware watchdog interrupting an OS if it is hanging is intended
> > behavior. It is required for recovering from a failed capsule update.
> >=20
> > Some watchdog timers have a maximum timeout that is too short for
> > booting (e.g. 16s on some Sunxi boards). To avoid resets these options
> > are available:
> >=20
> > * Set CONFIG_WATCHDOG_AUTOSTART=3Dn.
> > * Use device-tree property u-boot,noautostart.
> > * Use the `wdt stop` command in PREBOOT.
>=20
> Hmm, thanks for the suggestions. I considered doing this in some
> platform-specific way, but I don't think it's correct for U-Boot's
> default behaviour to leave watchdogs enabled, I haven't gone digging
> through the EFI spec but I would imagine it's not EFI compliant either?

We've had some long discussions about this in the past. It's very much
intentional that U-Boot leaves watchdogs running. As Heinrich noted (and
is a summary of the older threads) some hardware doesn't even let you
disable a watchdog. But it otherwise defeats the purpose of one to turn
it off. Part of my feedback before was that the EFI spec needs to be
addressed if it can't handle this correctly.

--=20
Tom

--1ajGerBx6ERTpx9U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW+kqAAKCRAr4qD1Cr/k
CuIHAP4xQmNdxSBYm70DDB/XkJYFuLM+LMtLqz51rWX2MtMedAEAvVBMuRYBgsvh
Ybef0eXBd0/Rta6aQHgGMFkWpu+1NwE=
=yrrs
-----END PGP SIGNATURE-----

--1ajGerBx6ERTpx9U--
