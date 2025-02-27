Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB57BC19776
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 02:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D05B80805;
	Thu, 27 Feb 2025 03:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BAR1znx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6824C801FB; Thu, 27 Feb 2025 03:09:05 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D6E8006D
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 03:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7c0892e4b19so50323885a.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740622141; x=1741226941; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HCdo0gj/9yFBrxrpb3hiIjM4QondR8tK5sZjrlOFQnw=;
 b=BAR1znx9lbZPbCRJW+KR+9LGvNWXHqC1vrdenum1NZItmnv/BJGVbYzrGdq+5Jo0i1
 4uAo6bdDPdI5awcdo3JEPHADlCxNoNn2ADaqtqWBI8300N3Ps8mv11Kr9ayuujQggk+1
 D4L+3YXZ7fedlXNHkqYsneS1dwhmhyu2vTORg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740622141; x=1741226941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCdo0gj/9yFBrxrpb3hiIjM4QondR8tK5sZjrlOFQnw=;
 b=MVl32bm76/9GL6IOuORDDttml5g5cJrMxmn4Q+y+iCpUuaWY9AJfVtju9OtmV4q7/H
 UwZ3mcNBSsraQYiyJVFhVewOi0bAkYcC0t/YzQKOJJ9OXdn0T3ch3G4iEVunqynrGTbD
 wsCv+0KR8QkXwdGOXSzH4ycUIO+5+wkoRBS7u9jxWHw6LEViqcil5Jk0kh3hLH8YkhE7
 Q5nECB+yNyqyPTsN57DvORp+JhqimkwMmJAYaBCpFVdK4jC/2BIcZaeHPC/ciDR+svh7
 dkR/7PIUKVLVcRS6pnqREzIBRpuo3HiOSaNzmJIaIWL+ezdj9q0dTlGP8HBZ53pTT6fL
 OWrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjHQNTZisNSjnsz0J5+7GRrS0ocmqQClsqrIvjnTuSZon+P1e61EI9avT2l2ecc7aCkvSy1/0=@lists.denx.de
X-Gm-Message-State: AOJu0YwYSuv14h4zqMuFc/GJDcvKXOSNG+k0YJthzZDHOY2ocNeJodcC
 atIV2WK57kLhZjR3Kqmvb6tVpF5Bk2gfcZd6eHYQBxq4T1fr3M9be7KppWLdfsQ=
X-Gm-Gg: ASbGncvoNlKSeIujJdPVTW5XSbsUX9+IyLAKEKoP43X20q9uZM0pAtilEYuylGC8ozn
 fWaiymzvKMIibfW7ixBXQ92/fcTYdDgNMGZ60YGCKhGx/T1gHqiqeQZ7WWz8ST6I1YwfGgjkbQf
 1hqWZnEhQHCcHyLCJxCk2Uak4vyAoyu547uamrJXzD7mZ9oa1nmaumBUIQFPeW/m0tW5dCkbqw1
 kqkDHfHie4z3KbeUVZy6Bfz3dTHb/c8CddU2Xn87RC5EXmTA98AzA45mpq4KlOIZk1bOdF/HszW
 MXwkckgn4WZ4x1c8QLKsrf8D
X-Google-Smtp-Source: AGHT+IExp/7ZqI3oTjn4b28mKnckSun1q1NYfSBvtGYlfFgjNS0APkJTb3ptT1WLxh1qDf0ZHHpgfA==
X-Received: by 2002:a05:620a:2446:b0:7c0:a1ac:1525 with SMTP id
 af79cd13be357-7c247fcb792mr888829185a.37.1740622141271; 
 Wed, 26 Feb 2025 18:09:01 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c36ff12777sm44062285a.65.2025.02.26.18.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 18:09:00 -0800 (PST)
Date: Wed, 26 Feb 2025 20:08:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: Re: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
Message-ID: <20250227020856.GQ2640854@bill-the-cat>
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
 <CAOMZO5C3UmU45sN-JyS-qRkVbFC=wW1=OjhZ764UGbmK4YJp6w@mail.gmail.com>
 <20250227005524.GP2640854@bill-the-cat>
 <CAOMZO5CMHA3QZKd_6uO_u3hj29KWe4dvYsY5SLaDNznbWegY6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OzdGE5cPo7VxRnDp"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CMHA3QZKd_6uO_u3hj29KWe4dvYsY5SLaDNznbWegY6Q@mail.gmail.com>
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


--OzdGE5cPo7VxRnDp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:47:43PM -0300, Fabio Estevam wrote:
> On Wed, Feb 26, 2025 at 9:55=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > But what part of things here is trying to call "sysboot" as a command?
>=20
> This is my first time using bootstd, and I am not familiar with it.
>=20
> I got a 'Unknown command 'sysboot' error as shown below:
>=20
> mmc1 is current device
> Scanning mmc 1:1...
> Found /boot/extlinux/extlinux.conf
> Unknown command 'sysboot' - try 'help'
> EXTLINUX FAILED: continuing...
> Loading Boot0000 'mmc 1' failed
> Loading Boot0001 'mmc 0' failed
> EFI boot manager: Cannot load any image
> u-boot=3D>
>=20
> That's the reason I added CONFIG_CMD_SYSBOOT=3Dy into the defconfig.
>=20
> If there is another way not to use sysboot, please let me know.

Yes, it's not that extlinux.conf is doing it, it's part of bootstd?
Sounds like it should be implied as part of BOOTSTD_something rather
than per-board.

--=20
Tom

--OzdGE5cPo7VxRnDp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme/yTEACgkQFHw5/5Y0
tyzDaQwAtPYZfBa4oevDzmXKB/tYFSsvGlUWNDeGuTJjjOz2KdZSv2OxfWbP1kns
oEZM74jjGZTuoEf70lIaA+6i6pyOJniM5yjpdW7N0GW2CEybTmkhljGuLsBanCxg
5PDTSwUTmCY0u6m8JZr5L4xYEGvUJiuJkiNb0t8RXw6Ap3ocYxcgnK7OtZufqgvM
R3t0w6QipsV/Jzhl2GF3gM2hu+hk/i1dgdHuA0bhJn0IODyrSzq5eERjQzWw+u7U
hSDdjAwOrFn88S7wr+BeT1+LUZtpKHUceZgHnNUs7WdjTY8vJDMHL8WYJOj2vZC0
SbXHVon6S3wA2kqAOut3lpd8wgivAFMMp06s+PmrlDHBS6DbCbW8+Us9PjTWpB4Z
t71tgr527WWcMbfWWBsXAQiiAm6c4xaHTt90UC0YxYh0x9kO9NRW9EM9j0O6M7cZ
k/nsYlyOF2nP7SfEg4P3bGBhAQm06gb/1W+9QrNZ2KT28/a4wd+rcp8k0d/Wjlco
anaHLwH/
=NnuH
-----END PGP SIGNATURE-----

--OzdGE5cPo7VxRnDp--
