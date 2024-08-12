Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEE1C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 18:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1CE88883;
	Mon, 12 Aug 2024 20:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t95GGHuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF408888F; Mon, 12 Aug 2024 20:42:17 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE73E8887E
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 20:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-70968db52d0so4887412a34.3
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723488134; x=1724092934; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q9pbAG8PXnaWRRjXBPm/nN5WOXzqWz+egYIgQXhUWpQ=;
 b=t95GGHuw0NKvjNabvDjjpF7UiId92lAU29H9wMDZLcnitsndmI6HOA1tBnL/8ipGYi
 7xWlMayxvo4Aai1zz4p8ZamlDfmftBa/TSZCD1GAjOqjXl4gQ3k4/7Cy2dCQeaFcOGLA
 NGwMlkhg5393XuKXS4lrGTNEhDOFsa/ZJxffg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723488134; x=1724092934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9pbAG8PXnaWRRjXBPm/nN5WOXzqWz+egYIgQXhUWpQ=;
 b=Rsr5DdUz5YmiFIbSPCIqCIwtPZ0RnjGpv5r/porWd4MmdtNHfU0/jHFNdbuHwvRjl1
 ShqmJinloGN8s3QaPE7MoqgtqFHmBd1U4H5CdfmG/OzyhnAnERLmUSz0njD8vLmc33FW
 i0lPlqf5fIBRnGvS5z5yx2orbUBx/YHFO+HpaXG3EdduQXhbFiQgu14fKy1vBidBJFju
 zpmGk9prtoKkziZlm5z7m4OVzzxEDb6/eyEfAtKUIX5f+VBXF1xv1Q0EsZTdP3rCRV4Z
 KE6QRwq3RemOSv22+H4QwzhoqVheFzc5qCrzk//VRx1uAqZz72MTf18XrORZ+zECUIZL
 zhjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoGvjISWCLy5EqRUH6+3G7ZVqNaD6S7aHC34Bae3YaKNGVb5lKxAOJZuDP56rq3yT9f37DSeeBBD51IaaQOvM6YLCHfA==
X-Gm-Message-State: AOJu0YzEWWnYF9gY6tbNsmQhUp5JKse2NWryq7Eby1vNqBSyO+jlLaJE
 ChMRkPWlreI0ss8XWvLQHAQRVO4kOwWokn5LojgZy2CjMlPBz0K92Gg50p42/mOTkVZcP3rJNi9
 P
X-Google-Smtp-Source: AGHT+IFKrPFdedbxEDu1LsSSkKRMhWwng1u9OHok/9B+YTqBnJ2i/v4qXBD/iJ2GpeH7PD/SbJvWgA==
X-Received: by 2002:a05:6830:6f01:b0:703:78b3:841 with SMTP id
 46e09a7af769-70c9389adcfmr1350286a34.13.1723488133725; 
 Mon, 12 Aug 2024 11:42:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70c7b880c11sm1516604a34.49.2024.08.12.11.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 11:42:12 -0700 (PDT)
Date: Mon, 12 Aug 2024 12:42:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anand Moon <linux.amoon@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] disk: add TegraPT support
Message-ID: <20240812184209.GH1626301@bill-the-cat>
References: <20240807121024.11318-1-clamor95@gmail.com>
 <20240807121024.11318-2-clamor95@gmail.com>
 <0C2B63EE-A95F-424A-9143-6A0C2164F666@gmx.de>
 <CAPVz0n1CvhkCCNDPSrPvUweBTzTFEUDFHcAP5B7Wno8RefKpPA@mail.gmail.com>
 <20240809220244.GA1626301@bill-the-cat>
 <CAPVz0n3cw3_MrKjHWtrt1mKiDkD4LWcatBHqvKTMna9dKK6KXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hs/qM+jPCWyR88aC"
Content-Disposition: inline
In-Reply-To: <CAPVz0n3cw3_MrKjHWtrt1mKiDkD4LWcatBHqvKTMna9dKK6KXw@mail.gmail.com>
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


--hs/qM+jPCWyR88aC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 10, 2024 at 08:29:57AM +0300, Svyatoslav Ryhel wrote:

> =D1=81=D0=B1, 10 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 01=
:02 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Fri, Aug 09, 2024 at 08:57:03AM +0300, Svyatoslav Ryhel wrote:
> > > =D0=BF=D1=82, 9 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE=
 08:49 Heinrich Schuchardt <xypron.glpk@gmx.de> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > >
> > > >
> > > > Am 7. August 2024 14:10:24 MESZ schrieb Svyatoslav Ryhel <clamor95@=
gmail.com>:
> > > > >TegraPT is compatible with EFI part but it can't pass Protective M=
BR check.
> > > > >Skip this check if CONFIG_TEGRA_PARTITION is enabled, storage ucla=
ss is MMC
> > > > >and devnum is 0. Note, eMMC on supported devices MUST be aliased t=
o mmc0.
> > > >
> > > > Why wouldn't you use U-Boot's gpt command to fix the non-conformant=
 partition table?
> > > >
> > >
> > > I would love to, but I am forced to use TegraPT and DON'T modify it.
> > > Tegra114 bootloader is RSA signed and there is no possible way to
> > > replace it with open source one unless vendor allows this. SO I am
> > > stuck with vendor bootloader to chainload from which enforces TegraPT
> > > as well. Modification of existing partition table can irreversibly
> > > brick the device.
> >
> > Can we please incorporate some of this information to the help text, so
> > it's clear what the use case is? Thanks.
>=20
> Sure, though usually those who know what they are dealing with will
> understand. BTW, Tom, may I pick patchsets assigned to Thierry (tagr)
> via Tegra custodian tree if they pass? Even if they, apart being
> related to Tegra, belong to different subsystems (like this patch and,
> for example, tegra gpio driver changes).

Yes, that's fine.

--=20
Tom

--hs/qM+jPCWyR88aC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma6V4EACgkQFHw5/5Y0
tyzr2Qv/fuxZdOITp9oU9C8di8KAzdLlXQNK1d/XGMb9YPBRjcpSXOzJkRLM8KiS
GM0DM+lNmmJiuFaFczMsACmCHfXIfKygtmHWjroq69xf0fgNiVvmhgT8IKpVHpiZ
9b2oTyIEvB4s/Q/RMwBmml4n2+XsTPQkHIfAGQZf6wA0cXTpOCvvmG0TScurs/se
ZrwpO9YedmZKhrpH/6yb2dsoAwgGON8DZfgBypu/ZRm7FGxhSra9/U9TYwBj75ij
cpf5LJuC9+vhZTE4V39shACaERLlxsGnIief3d7SL1Vn8BpqdiYjw/CeDE/pZ+tk
+KCxz2UHsJAlFuZHzRiO3OjnugYBYqIKumvnt3+drCnnZP+8OYImd/XO1YoUs6GG
4T5RKPOoRj8PcogFUo1FJLe64IkV20A2lKus0DsltOGeoU9Rzz75YAGPRGUHqw6g
ihzjDP7ARDgx3Vu/F2KczySMJYgPROreNFrlqphmLRl4cAo8EuqFTlxKxKcCGMeW
R52+4Tfl
=erCN
-----END PGP SIGNATURE-----

--hs/qM+jPCWyR88aC--
