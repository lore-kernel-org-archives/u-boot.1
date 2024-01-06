Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E02C47077
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 17:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE39187A23;
	Sat,  6 Jan 2024 18:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QnOzThWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3384187A17; Sat,  6 Jan 2024 18:41:42 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB3B887A1E
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 18:41:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-204500454fcso283946fac.3
 for <u-boot@lists.denx.de>; Sat, 06 Jan 2024 09:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704562897; x=1705167697; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gj2gdnl8UzKQ5sQg6A88I+igwC9iw7OrT/+IDvvuInU=;
 b=QnOzThWFvf/er2+EZHQs7gPQPvwm+4AWfbiv2xHeI4AILxBXetgyYZ/HS31XA4YGjC
 MzTIo52kEP1fY1mfk1K333SPoryKBteAvJ/+iInY7HQDVmubL8HodMAEg9FJ4mTpyRRW
 ytJLy+M4/ck3y6gXOOBrcyLNsu41vijnLlre8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704562897; x=1705167697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gj2gdnl8UzKQ5sQg6A88I+igwC9iw7OrT/+IDvvuInU=;
 b=k/eYozUrRBBZjBJB7y7IkOtz62UQig6qZajpfHIcULk1PpiD+V0aD079Bbmut8vxMO
 pyicsWUvhO03UditF+iLVwj63hr7s4kFNHtklm4Pw5zhRaUT+HjvEnJmLeZkn1lIrE4H
 DdnmkmePcHmcj8aw3X3ykgeXrHtr43tOR21D5vEihYHpWjsX8Oj7+KzAWufbechVC2Sl
 tDjX3JkHTgj/G5iaGbcmBfh0Oy9Qi2F9hK1aVr+vubz6LwCkjZ4oCUEZILeq7ym9sPkX
 allvlO59y2itdHPYSZ+kAGnJ37V8DPW8fvkdoUrasxH+m+46HczwFee0WVNTrIsF4Hxt
 vfHQ==
X-Gm-Message-State: AOJu0Ywbfp2F/ZWcJZOREOfsI/7MxZ2/8eT2tvWGSrvTWQFitfwyKoG6
 Ua+AKfnRoOLxEAltM1ZJFACHR9ONo2Qt2w==
X-Google-Smtp-Source: AGHT+IF0dzAzVMRo9POv6BHy5ISPu1QcXfgdecCDtPESAJOXwCKH0BgdW5srYMOyWS4PtYScDqXFww==
X-Received: by 2002:a05:6870:14ce:b0:203:d54f:8aa9 with SMTP id
 l14-20020a05687014ce00b00203d54f8aa9mr1024048oab.28.1704562897485; 
 Sat, 06 Jan 2024 09:41:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 g15-20020ae9e10f000000b0077d7cfde46csm1449615qkm.106.2024.01.06.09.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 09:41:36 -0800 (PST)
Date: Sat, 6 Jan 2024 12:41:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-tegra staging
Message-ID: <20240106174134.GD1610741@bill-the-cat>
References: <20240106092645.8901-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T09eWcBGZ9xVpAXm"
Content-Disposition: inline
In-Reply-To: <20240106092645.8901-1-clamor95@gmail.com>
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


--T09eWcBGZ9xVpAXm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 06, 2024 at 11:26:45AM +0200, Svyatoslav Ryhel wrote:

> Dear Tom,
>=20
> The following changes since commit 4b151562bb8e54160adedbc6a1c0c749c00a2f=
84:
>=20
>   bootmeth: pass size to efi_binary_run() (2023-12-22 10:36:50 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
>=20
> for you to fetch changes up to 86e581a5609dc4b2876e5c3e2e458c91879b353c:
>=20
>   board: htc: endeavoru: add an early SPL RCM hook (2024-01-05 18:05:42 +=
0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--T09eWcBGZ9xVpAXm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWZkM4ACgkQFHw5/5Y0
tyyUJwwApTV5JjHTKWQNisS6VU5Ws9Jsd4Bsaa/XU6JD6Obd4b1hXOB8mwxe0CTc
zX8btfkG9x96mWmdXJEmv9n2CuqAZ6QGXqedBefA5NtMrBiwvQQXX0KzfxlOTn6c
VgGvpjc4YRj1b4j9zPSV7tKU3ZN8DdP23EYqKIa+P/nFzLlhBXEsMPWPkgNeZLbM
9qEZ0wKvWIRZc1blE+yHW0kV+peWYeQUbUYUlJlKBv57tkZtq2vaJblZDIO1qCH5
OmlgdzDrjUZx2/s9h3pV9Me/qCG2DiVLem3Q0WgktkhVlj/trGGif/15AqZyrDNI
VRBoTp7PGzw4YzHZCyrCZ69EZhweRn17tZVrIxCNvoiraZskYsSgc0hI+2YfrdWr
OENDo8dFG+Zz1+fQJc1oh/TDDFuCpjgh6vCcr8Igzx/e8DA49Z2tCF7osHoaRMwB
zuKhXaSOaTFn7aqECsc9QdSSHq85XscGWeDBe2DWMSn+ABb5lldpH0uYfsKniptL
4DZWB3L6
=enHn
-----END PGP SIGNATURE-----

--T09eWcBGZ9xVpAXm--
