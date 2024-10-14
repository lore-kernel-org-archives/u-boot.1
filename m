Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F57CD16268
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 14:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6F8289117;
	Mon, 14 Oct 2024 16:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DHTQMyzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3401C89048; Mon, 14 Oct 2024 16:17:21 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF65A89121
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 16:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4603ce01023so36707641cf.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728915436; x=1729520236; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xOIsFQnUJRw8FvlHwdeFA10oO6Xru5qyI0VvHj+gvko=;
 b=DHTQMyzwq0eAs2LBRU9bGBV4FSaU1GLCNlMkR3cGRUTV3gtGnXnxZbNrA/DV6WAbSj
 04jBNKyPxBwTS5w4+r9hgWCIMX9Vnd1ZZtWMIDx6zPqCeGL+ZfnQrkkGYoaRJTbaI6EO
 7yfi+yD+KxPFroQScedYqu3HBSn4T+GBlGxZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728915436; x=1729520236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOIsFQnUJRw8FvlHwdeFA10oO6Xru5qyI0VvHj+gvko=;
 b=ODbCTFZXW1Ws8KFur03VGyWsyuO9LEb4bph2caa/W/Ec+NPv/wlOHpf4NlxblXMw/E
 quFBwZ9I0z83NUzcRiaq2BwhxhRkg3dTg6adSHip0Jn7MB1ff9m9nT3E2vcqhI6XTOj9
 /hyyRf23ARtZG5u0sFZclFePcIEsazYEFJ1M7CMl81j8jAGg/LMMkb4VB68JaS3xkEpH
 noiRnqD7NgzHcGCtPp2F8waRYYUBCrf+Nigh2ZV2vD/FL1XNcsI1GUUBZ3OCNr+38nBj
 Fr8IbEWuYZmvZ6TZSVsgyFCZ/vcS3EmOWiPT9ufCa2PrDQmxTtPP07MOU8SSziz4rGYR
 Uc8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpLGBj6QnjgfbBiJk6XmVlUMPnjrbQsnZBkP39uhqIoaYck3hqC27c01yHRMWOmFvzpkfARCQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwYqaODLC9UK/GUtu0jf37ZObIvEj+Ul8T0Dw9HXkfz9qjKFq+5
 wjv66rtF7nhW9KrtjJ2RGf08FePo/4T3yVlfAkG+kKVPqRTWmea96bX/66Yh8AM=
X-Google-Smtp-Source: AGHT+IEC3fEHfYMUJTMPTSFAOGdIoCDGSHjUTxxWYUpRgmbDWXJvJGG9Gb6FnCXiihJDm6XhSsnVCA==
X-Received: by 2002:a05:622a:24f:b0:45d:7ebd:43a4 with SMTP id
 d75a77b69052e-4604bca942bmr173174391cf.58.1728915436264; 
 Mon, 14 Oct 2024 07:17:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46049606cadsm39779601cf.95.2024.10.14.07.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 07:17:15 -0700 (PDT)
Date: Mon, 14 Oct 2024 08:17:12 -0600
From: Tom Rini <trini@konsulko.com>
To: "Bimpikas, Vasileios" <Vasileios.Bimpikas@analog.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 "Agarwal, Utsav" <Utsav.Agarwal@analog.com>,
 "Artamonovs, Arturs" <Arturs.Artamonovs@analog.com>,
 Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Linux Factory <adsp-linux@analog.com>,
 "20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com"
 <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Subject: Re: [PATCH v2 00/11] drivers: Driver support for ADI SC5xx SoCs
Message-ID: <20241014141712.GH53053@bill-the-cat>
References: <20240925-sc5xx-driver-series-v2-0-ad9287c25c08@analog.com>
 <20241011173125.GA526760@bill-the-cat>
 <BN8PR03MB5121B87679EE1A717A8A9AD9E6442@BN8PR03MB5121.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cSXKF7eLgSjD0K94"
Content-Disposition: inline
In-Reply-To: <BN8PR03MB5121B87679EE1A717A8A9AD9E6442@BN8PR03MB5121.namprd03.prod.outlook.com>
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


--cSXKF7eLgSjD0K94
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 01:59:00PM +0000, Bimpikas, Vasileios wrote:
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Friday, October 11, 2024 6:31 PM
> > To: zzzzGaskell, zzzzOliver <Oliver.Gaskell@analog.com>
> > Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>; Greg Malysa
> > <greg.malysa@timesys.com>; Ian Roberts <ian.roberts@timesys.com>;
> > Bimpikas, Vasileios <Vasileios.Bimpikas@analog.com>; Agarwal, Utsav
> > <Utsav.Agarwal@analog.com>; Artamonovs, Arturs
> > <Arturs.Artamonovs@analog.com>; Marek Vasut <marex@denx.de>; Heiko
> > Schocher <hs@denx.de>; Joe Hershberger <joe.hershberger@ni.com>; Ramon
> > Fried <rfried.dev@gmail.com>; Stefan Roese <sr@denx.de>; Jagan Teki
> > <jagan@amarulasolutions.com>; Peng Fan <peng.fan@nxp.com>; Jaehoon
> > Chung <jh80.chung@samsung.com>; u-boot@lists.denx.de; Linux Factory
> > <adsp-linux@analog.com>; 20240828-sc5xx-upstreaming-patches-v1-0-
> > 44d9adfdf327@analog.com; Angelo Dureghello
> > <angelo.dureghello@timesys.com>; Piotr Wojtaszczyk
> > <piotr.wojtaszczyk@timesys.com>
> > Subject: Re: [PATCH v2 00/11] drivers: Driver support for ADI SC5xx SoCs
> >=20
> > Please rebase this on top of current master, thanks. Also check that ea=
ch patch
> > is only doing the correct MAINTAINERS change, that's where trying to ap=
ply
> > this by hand failed for me.
> >=20
> > --
> > Tom
>=20
> Hi Tom,
>=20
> Thanks for this. I've rebased and resolved a single conflict. I could not=
 find any
> MAINTAINERS issue after rebasing & building. So just before sending my
> changes, I wanted to confirm if I'm missing something regarding
> your remark about MAINTAINERS.

As long as the series applies cleanly to top of tree, you're fine,
thanks.

--=20
Tom

--cSXKF7eLgSjD0K94
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNJ+AACgkQFHw5/5Y0
tywk6Av/bpOSju3dtnlKgOfLnAxdBC6Fuh8O6gJSOBVi00ucEtv8JxZFHz0aEpoq
bME/U91OtckDs/y48RMz1duP+0xyAq7Xl1NCdgyAIgLH+C2EewBe//tEfQrqqMN7
YeWkniAvVWioOJ6+G7D+mh2Qy3UDWhGQcnM/LN7rSeSIRN/tf0Mv+hfJlK3cBusV
ZE7QYYlhKVBAp9MD1A54wiOp5OCKLG7ijwHvuYwPCyhppUBmgANdknmNrMKWrMPS
LARWyC1aLN18iML2jThGCipyjyt2W/EXvrp9hCVw4jeD2kvIU0RtzqmENpAi9Dhc
0RVqgYn3eRZpMaHY1bs4+zHTstY9QxQ4C6is6HRvWJ6fkNBpTahNaN7GicgCIrup
cRyVKa4zs0Q1WEvshPBR6VOLCoh7qtRQDpM67SAheG8r5E/8DbOOj6WVaxy+sV9h
vfvm8a1eayX/aQEH0XwfA6xwzLKNk3Znvo9LFcejJNNPYtfcbbdfW8cQYOFZnHIn
RTGngg3C
=+zKs
-----END PGP SIGNATURE-----

--cSXKF7eLgSjD0K94--
