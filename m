Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B6BC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 16:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDC7F87DFC;
	Tue,  7 May 2024 18:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pdGEKo5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A5887E01; Tue,  7 May 2024 18:59:46 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1679F87DF1
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 18:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c968f64cdeso830158b6e.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715101183; x=1715705983; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v2OS3PHZpBji4OLEk7osLCjG+4reMefiKqfEPlBBYBc=;
 b=pdGEKo5Rj4yko6nhaJIQP+zEPMzsezzp4hD2TatngAnpEyJIuy0tiQIL7VA7Q4gd6M
 HmZt7Vz6PzBsDkfnXGUhvyw9VvanE91cgfHcYAwQM62FhHmbHeYFq9r7mVJ+2u8+G7zo
 knRiHoLWs9HfDRj9Rb0W1vGKjHJmIQ/2tfIrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715101183; x=1715705983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2OS3PHZpBji4OLEk7osLCjG+4reMefiKqfEPlBBYBc=;
 b=HiT/dwkgeCM5pwS7BwbudvJ5ORgzfz0UQdaH/XV+/gqij3L/UaRe+oMSGhV81EaQLO
 pyxRTWev1Gm3OLNwnNsEbnuG3k5IANkNoQkt7pwbXg003niXJJKHiT49YHMJ+Sn5y5kS
 jVzenmROxUEUXDQnchVlFkciTKn3IJz9tWNY+V+1NGA5Q/zv/1lZgaOAgWRCMO4fnZXX
 QcuyHvZB8qeOaqtx2MvLbK8+JjT0c26zxWIYjaZBd93l0Oo8F/0miONkH4F5/U0ds7XR
 q0iDCz0IkWGU84jYfjPzA37+sGEtJpZbFZ5HAPDkdLaMke9gmrM2C/ra/vSr3xhN59a8
 wI8w==
X-Gm-Message-State: AOJu0Yw4ASQKQVfA1/guHL2h6I5kSm/FvpsiF+0DcjsRN+ro3b6W320t
 9skV8FlJZhI661UalcdkI2vQHXo3wEcMElCkli4nMVp8M3CMqbjDVpx6GwzUQrZ/SxnT5Y+B0Mz
 u5KU=
X-Google-Smtp-Source: AGHT+IE9GXiNbR0RXRSbrviGHdrN4I2MI124UeIrO+zq5P0qVNtgj/k/C7GFwyF2SYFynirvnMP/7g==
X-Received: by 2002:a05:6808:dc9:b0:3c7:79c:72c9 with SMTP id
 5614622812f47-3c98532b09amr123745b6e.54.1715101182739; 
 Tue, 07 May 2024 09:59:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 n14-20020ad444ae000000b006a0f057489fsm4838748qvt.125.2024.05.07.09.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 09:59:42 -0700 (PDT)
Date: Tue, 7 May 2024 10:59:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20240507
Message-ID: <20240507165939.GW2568172@bill-the-cat>
References: <20240507085139.35388-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="phhBwOgkYAMe6tGb"
Content-Disposition: inline
In-Reply-To: <20240507085139.35388-1-kever.yang@rock-chips.com>
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


--phhBwOgkYAMe6tGb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 04:51:39PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform, this PR is mainly for:
> - migrate to use OF_UPSTREAM for rv1108, rk3308, rk3328, rk356x, rk3588;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/20628
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit 52835266d3e933656a217233eaf672dd9ccd73=
52:
>=20
>   Prepare v2024.07-rc2 (2024-05-06 13:54:17 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20240507
>=20
> for you to fetch changes up to bc7cb4b67a4070129bbfc5bffb2f5e9fd206991e:
>=20
>   configs: rk3588-turing-rk1: disable SPI flash by default (2024-05-07 15=
:56:10 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--phhBwOgkYAMe6tGb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY6XfUACgkQFHw5/5Y0
tywhGQv+JogtpBqUHxPcEBKvUJT/Vn2lqrbuqaWtHsG/OO5lXnbZGW8RgIzM86Xu
ktp0O6qtQypKJQDtUY8pbs7brad1JbT2bG7un0leipb/smHbpuIjtKTc2DkprbZ6
9/JaOUB3Wx1pEcr+mXG0qbIXbRMwjR5pDO+CIz5eBLJBrVaRDAshTZXCDxJjKF2s
AR6aCWh8JenXMLTpZVZONxUBG8P00Da1F/rgXd4hflWv3H3G6bDzp5QNDtq7yNrV
2hFPysuL5zI95RWVkc9AkEstMhp4J6E9FbGRZk5cyes2d1WvV/+YEleGQVM25zO6
HDqJcnNjki7zPhneuMTPzjSh/JjHbvMq0uMp9w4y1pLwUliqSwFGDUS6tdyide/N
pScEqJivN8xxoAIlNJmUomHjjq5E5DdzzIMCDIh79Bv3SfZwymIctpLawNQrBwi+
yueT6LhdTbqy4el50ycCaH0gKYLXC3v+gNdmUlYT3Wcgux9sm6gP4rGJVR9NnCWh
gl4C9NyS
=hHWu
-----END PGP SIGNATURE-----

--phhBwOgkYAMe6tGb--
