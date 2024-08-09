Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D199C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 22:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1317F88C4B;
	Sat, 10 Aug 2024 00:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BPXXP05A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE4C78641A; Sat, 10 Aug 2024 00:02:50 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBCB188C39
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 00:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-261112c303bso1874442fac.1
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 15:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723240967; x=1723845767; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KZ7vijAnU7x8L+En8NZP5g7xjCiGPul6fXPRtK1D174=;
 b=BPXXP05AeQg7os2c/dMXmaE9nTipoIrz0ypJDgrafW9sBQowiRVcNNgSDr9MUcqjFL
 HqYdiBFuhwgKfrmhCllCNfoM/bv4MFxDOPLYOpNoL2cVfHYLyHryoBCtwxiNyhLTDo9W
 DqPcWNlFMFSlSyM92rwds9jmz0fUFVGHAtN4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723240967; x=1723845767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZ7vijAnU7x8L+En8NZP5g7xjCiGPul6fXPRtK1D174=;
 b=XiOWHEo/Pz9KQrX03EDoxHjF6b2OfhyOcpVhKSkCc9WCSDP3zHV5dzP6Bph5Im2nId
 OnasPlM1P77mTeS77YZGkAg0e3g8uVAcgoKNVjLNkoLGgpCeTCzJdpFBQQYTcWMNTEO3
 iYOVeyn43mltj89M48RMkPjf9JpyMA6i/ATEswq8u286jBmLzWHgAWXA8ICi9aGKkcRC
 hheCWS7hRaym/CxkNUSWr+nQAeTXp6VB9ueUPcqB3iBRs6v54uy2POm8BOjHwfw/zM0S
 msmek0gDw15M+gl6bO/tgH8iksr0N3sqPQxve+49s1+ueO2IAXBS4FCddFV5na/jBuH9
 TokA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyjuKIpEtv870OQqpqyDF3fZX1n8WZBiygIitQ7JHgMEzdcmpk+1PkOywdlj4aFquGb4LkiCj/TKnFF26WR8LFCGJ9iw==
X-Gm-Message-State: AOJu0YxYWFjVzMfAAYOA/HhSZeCAmO1oZBtgiGIxkCaMmjKwdkn/vxUc
 +P5QzF2klyD/zePwn9M+ad7NRG6Wtgqw3u6dMuVbU8DOS++nB70BvQydm08xNT8=
X-Google-Smtp-Source: AGHT+IEOrRMI+lnp2JqQOgr5DOSoR6jDrDiYUR9chrN43bycXvlq0L5xs5+9WXDNfVsv5YoOOcCJRA==
X-Received: by 2002:a05:6870:e38a:b0:25e:d62:f297 with SMTP id
 586e51a60fabf-26c62ff3542mr3899622fac.45.1723240967433; 
 Fri, 09 Aug 2024 15:02:47 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70c7b83c7a5sm182464a34.48.2024.08.09.15.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 15:02:46 -0700 (PDT)
Date: Fri, 9 Aug 2024 16:02:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anand Moon <linux.amoon@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] disk: add TegraPT support
Message-ID: <20240809220244.GA1626301@bill-the-cat>
References: <20240807121024.11318-1-clamor95@gmail.com>
 <20240807121024.11318-2-clamor95@gmail.com>
 <0C2B63EE-A95F-424A-9143-6A0C2164F666@gmx.de>
 <CAPVz0n1CvhkCCNDPSrPvUweBTzTFEUDFHcAP5B7Wno8RefKpPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GfaXJ/nqGh62j9lC"
Content-Disposition: inline
In-Reply-To: <CAPVz0n1CvhkCCNDPSrPvUweBTzTFEUDFHcAP5B7Wno8RefKpPA@mail.gmail.com>
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


--GfaXJ/nqGh62j9lC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 08:57:03AM +0300, Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 9 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 08:=
49 Heinrich Schuchardt <xypron.glpk@gmx.de> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> >
> >
> > Am 7. August 2024 14:10:24 MESZ schrieb Svyatoslav Ryhel <clamor95@gmai=
l.com>:
> > >TegraPT is compatible with EFI part but it can't pass Protective MBR c=
heck.
> > >Skip this check if CONFIG_TEGRA_PARTITION is enabled, storage uclass i=
s MMC
> > >and devnum is 0. Note, eMMC on supported devices MUST be aliased to mm=
c0.
> >
> > Why wouldn't you use U-Boot's gpt command to fix the non-conformant par=
tition table?
> >
>=20
> I would love to, but I am forced to use TegraPT and DON'T modify it.
> Tegra114 bootloader is RSA signed and there is no possible way to
> replace it with open source one unless vendor allows this. SO I am
> stuck with vendor bootloader to chainload from which enforces TegraPT
> as well. Modification of existing partition table can irreversibly
> brick the device.

Can we please incorporate some of this information to the help text, so
it's clear what the use case is? Thanks.

--=20
Tom

--GfaXJ/nqGh62j9lC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma2kgQACgkQFHw5/5Y0
tyyLmAv+PSz15qqaHRPpca8m+3draeC71WlgTiAqLktfh06LNmYqPbZ2/QxifQO5
xw44Lt5H2r1sgKDEfTNLF36mlZYo9MdNHAiaJ4djDVTauZrS5T9wGkmDfBqo8W5M
sVkdr4J3+zD7avhPSwVSz9csUnMowaMCEukAHAtnPhM2tMk/qoBnQxDK2Qjpm+O9
JzJumt79sycCB6894GjrdogeViErySuW/eudKnk6Y5Snzk9DDMx+iR6Zzdk5dT3d
joCvDOwieivb1zewGwEj2zH3CgdCvhtVz1xCkFfzJJO5mYMR9qc+vQucHkoWsmx2
uMFHFOOyswcG5ZLSIJY09seSkiNQGPsz0XFDxvYGgJYNF8gm1uRftkMBUhzbEN6R
lkjxj/ze9vRl0YSyhLVPzpOM0GoQdGxq14Tr9XesRFNQajyeBxvhnz1bsiZkAD+f
YdtEg02vaTzkl1sHRO80YGoDAx2mgU8HYny7KWTT1pQXfqafbiTrkrnIuC2cuNfb
YbYUlh6l
=d4Iu
-----END PGP SIGNATURE-----

--GfaXJ/nqGh62j9lC--
