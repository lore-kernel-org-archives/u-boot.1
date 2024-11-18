Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A7AD591AE
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 19:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2450B894A3;
	Mon, 18 Nov 2024 20:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E/bhgDau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4146988E5C; Mon, 18 Nov 2024 20:30:29 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0F3F8923D
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 20:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-460a415633fso26531041cf.2
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731958224; x=1732563024; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N0rA2fmowLJB+Mq4A+VFBpz5p2ttU1E+uuppx3U5oWo=;
 b=E/bhgDaunhI/hrbMIA1cxau8ndk1zxDRbrDRx2DCnO+5A32xhyVwIZEveT5wUBoo4E
 sDDRQqL4aLdSSCaIMejNQRIUN5IDKcjPbUG0NrYPZGWoz3/n19IEnIC/Ioqmn21vR9eN
 SfUt/AdUzxyuxuPPoCpufarrkm6Jg312k/ogQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731958224; x=1732563024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0rA2fmowLJB+Mq4A+VFBpz5p2ttU1E+uuppx3U5oWo=;
 b=lEOddNggQsxFYALd2WJ5wzNj8pJihu6VwJboZoXQhko/k8ckpfN6/75hbF85mnz0jz
 CO/sqDWQEGWiMKSyEw3OZJKAVzy+o5Exqpr3W2zWr/owpLGHB7Y3qBY99QAfdTPb5lI1
 HrTsbzjPr/dv1J5TAwRl/XWMMJyLzLwDiUIL/EomaEFI7UbbPc+1VmOWAOWAIh0snqNM
 AK7xxIXVLROIP0EvUEuH/GR0WlF7kuLxMFpwkyFyM9EPG4HT/LcqEX7/WUTe++rDlDIX
 H6sK1BMV0Z15c27+6qWcUshYHigZ7smR9ZrXWfkds6AY53UbGmKU1BXVamDp4nLceADs
 rN9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI7edvkHu64k4A2S0h3wuGkelBElJAV0ADvAX8nwiBCDk42W6zh4dSFqIIShEdFHPfD38y3VE=@lists.denx.de
X-Gm-Message-State: AOJu0YzWfttZ5LQFuxgFMkWfWQFxDlt1QvFkClStbyZrC7hQ4a7FY5kN
 E0NjhRHUAJi7Zz8hxEl5fscloTvru2fothSV1x12hVDlp5aFZzyimbVAs5PsoeI=
X-Google-Smtp-Source: AGHT+IF1Y1+Rn2iTrwJywRWjGq9UCcf9AtByo+ZwTaKWsBKjtWxaDMFayYde3rirwjuPFi1nS6UFdA==
X-Received: by 2002:a05:622a:1c19:b0:461:1734:37e8 with SMTP id
 d75a77b69052e-46363ec1001mr219136421cf.55.1731958224592; 
 Mon, 18 Nov 2024 11:30:24 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46392bbfa6fsm2013571cf.43.2024.11.18.11.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 11:30:24 -0800 (PST)
Date: Mon, 18 Nov 2024 13:30:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [NEXT] Pull request efi-next-2024-11-1
Message-ID: <20241118193020.GU3600562@bill-the-cat>
References: <a3f0803a-4717-437d-8e17-bdd79b126c74@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZlUQ67ZMEDoySEHm"
Content-Disposition: inline
In-Reply-To: <a3f0803a-4717-437d-8e17-bdd79b126c74@gmx.de>
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


--ZlUQ67ZMEDoySEHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 05:40:22PM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> Adriano has split the patches needed to implement the EFI_HTTP_PROTOCOL
> into two series. The first series received no comments requesting
> changes. Let's get it merged into the next branch so that Adriano can
> base on this when resubmitting his second series.
>=20
> The following changes since commit c71d451033db9ed1ea3ac46fa81a09ec9c5891=
8c:
>=20
>   Merge patch series "teach 'env default' to optionally keep runtime
> variables" (2024-11-15 16:36:24 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-next-2024-11-18
>=20
> for you to fetch changes up to ec054b23c6ac56a0125839ae9cf800c20f886e92:
>=20
>   net: net_utils: Move ip_to_string to lib/net_utils.c (2024-11-16
> 21:58:17 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23430
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--ZlUQ67ZMEDoySEHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc7lcwACgkQFHw5/5Y0
tyyXUAwAmo1s9jQXj0mjmWscnzTdyR7u26pCHstHAY3ySBVFwAiaxMhlJpuRPo93
JtcYq4JN0kC9KaQ4JtfsTgY0OkxHXXEECyL6amuCQ7ATtCOhC+k4dh4OGoOz3JLa
YdqmSjdrvpX0l3Jx/9Az1Yh6VbMFI1tJIGCJHsclo6Md9wEykTyolLVzUeUKpmJl
+P8MIa74RMbzG1Bqt3arPFMTiDr4luHXJrKwEVPZOOvAxyHzJ5SRbNw3yVW2xnC6
TjOSryJskRnC9/GWt4hjTrCfWg2N7j6uOFydtn60c/GpdeNbONhb4uRC1axDsISa
ZUfdmgn2+PMoKB+FelWByDInqeDnVOITpziv5mWGuXTbwjsFZqQlsST+Ffo2iSKo
uuKvkh2yhJ70IZRnwa7i/OPBGU966gQHvmUqL5nOkyw6A84RWEX32wVttn14KQ3I
KUUVG/gIcbHiiYLc5o5N4ialX6O8wnQq367YXsmzWc3inJXMMvcE4FqZgSQ8A68A
OFjHaAoO
=2dHU
-----END PGP SIGNATURE-----

--ZlUQ67ZMEDoySEHm--
