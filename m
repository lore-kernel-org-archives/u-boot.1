Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CA9C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 21:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EBF980F4C;
	Mon, 17 Mar 2025 22:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PlsEQE73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D5C810F4; Mon, 17 Mar 2025 22:45:13 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF7798056A
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 22:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6ff1e375a47so43334417b3.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742247909; x=1742852709; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t2UNhTQZDu522zni0UZ3iMSNkh+ObmktT1yq60LKgA4=;
 b=PlsEQE73A25nJ7HoVnM5Ep+yEQhmCAMuV8mQRKc6qlxll/iPkWdAge755jvS1XUJRu
 kKL8+3sQjocTcQacPqco5MliFG/HvzPNGFZTx1imCCVOcjqfJFCNuvG2x3+GyD9YnxpF
 GBfUrG0w85hYEsSgVqx8IvAf+9hLcn/y7yDFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742247909; x=1742852709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2UNhTQZDu522zni0UZ3iMSNkh+ObmktT1yq60LKgA4=;
 b=FKSGe93rJLdhTpmizc+Vp4NvhEr9wL/IwtS7wjBRbF+FWt/TM0/x5hAb/Lw7zCNjM6
 fPvKd+Q9hXpmH7hVllOu6ud9qbYiiB5uQNg3HOf3/XwmRT/q6FJxQU949MgCCFsOFUyf
 TqmPamDZZvaa4D7ROwsPIfx/8t0omNZarwRlfDbEOlSGhlyQnNPiPf3gzu7V8yoNxY0X
 vAuTquDPkMsr205YMuz85Z6pWT6l3PXifN3Vimf0oGZoq8s6nMkcOHs2amyveJGYDuQE
 Qfr5SRUJsOFMdHI+L1Kd+BaMxczDCBqpX2cQ9JxlVQThFKEUfhTgKUTijzClbJk9U2f2
 HSUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF1OACCVm0hThZ/lNT+69jrYX1570lxttukr+MWYp5WiYECBUhDk7V7OQe3n85ARkC38mdN5s=@lists.denx.de
X-Gm-Message-State: AOJu0YyzbQJoG3vkCk3uDvtvzrDjmuZz6xn4VVZoSqyw/nVoalJZxZx5
 wbtEy+zUOTcyP5KAa83NveT23XcH9ZBAMpJb7eF0NBqlQVpeDSK7xSKeR1D2iAc=
X-Gm-Gg: ASbGncvq0TUNkZAA2R3ApaJI7JQ5ObNvHBaOlpU/mTCwpEcXHJ1VJmtk0i62TEgEWEh
 bK6U9qlyTNmhRGwk1vKfNu8QkhSvLo86ywyFsIynoAGStdNcierFI35EA2wRJ0K2LBfuZTQjzdn
 203uoQ5r+XFHkB/6cqNoQXr9vkWpQWakWf0MN4V6YhxkkSO8pK7fmJ6NcUK2pxIZPzzo9gJDHxG
 m8+7iXygHIDNV8twEV82HmxAIelh8P+T8Dv+3pY3hroPt78tg36BG+cwCGne6vlCFNW/17wGp4x
 3KW0iotQJzSl7nPU44DuJaE7XinOq6PdAQdNo0owUgbGYg==
X-Google-Smtp-Source: AGHT+IFkbuZGxDfirGCtV5E9L+cG5NdI7Dk7JccA2TV3o7Uw+Bqhp4SvOuvykXEItw8YIfgVfs7AVA==
X-Received: by 2002:a05:690c:6f0a:b0:6f9:8910:38a3 with SMTP id
 00721157ae682-6ff460dfdbdmr184775657b3.37.1742247909651; 
 Mon, 17 Mar 2025 14:45:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ff3288bd3csm23477317b3.51.2025.03.17.14.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 14:45:09 -0700 (PDT)
Date: Mon, 17 Mar 2025 15:45:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sam Day <me@samcday.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PULL] Please pull qcom-next-20250317
Message-ID: <20250317214506.GT2640854@bill-the-cat>
References: <20250317152328.107426-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3en52eCrdytSQI53"
Content-Disposition: inline
In-Reply-To: <20250317152328.107426-1-caleb.connolly@linaro.org>
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


--3en52eCrdytSQI53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 03:16:24PM +0000, Caleb Connolly wrote:

> Hi Tom,
>=20
> A new platform and a nice handful of improvements for Qualcomm so far
> this cycle:
>=20
> * msm8916 gets proper sysreset and spin-table support
> * the first new IPQ platform is added - the IPQ9574. The IPQ series are
>   used in routers. The flashing process is also documented
> * mach-snapdragon gains the ability to boot with an internal FDT and
>   still parse memory from an externally provided one
> * SC7280 gets a pinctrl driver and various clock driver improvements.
> * Qualcom clock drivers will now actually return an error when attempting
>   to enable a clock which isn't described.
> * Qualcomm pinctrl drivers will now return an error when attempting to
>   configure an invalid function mux
>=20
> Kind regards,
> Caleb
>=20
> The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee10=
77:
>=20
>   Merge tag 'dm-pull-15mar25' of git://git.denx.de/u-boot-dm into next (2=
025-03-15 08:19:31 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/qcom-ne=
xt-20250317
>=20
> for you to fetch changes up to 69aab567407efe67b8b2a10a3843656101b402ca:
>=20
>   pinctrl/qcom: fix kconfig option names (2025-03-17 15:12:26 +0000)
>=20

This PR and specifically:

commit 61a1a1b8ca73bb9c5797d9f5a300a51afffc0aaa
Author: Sam Day <me@samcday.com>
Date:   Sat Jan 25 19:59:15 2025 +0000

    mach-snapdragon: use PSCI sysreset driver
   =20
    Drop the `board_reset` function from mach-snapdragon board code, and
    instead use the standard PSCI sysreset driver.
   =20
    Signed-off-by: Sam Day <me@samcday.com>
    Link: https://lore.kernel.org/r/20250125-msm8916-sysreset-v1-1-62073932=
ff0e@samcday.com
    Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Break building on dragonboard410c, dragonboard820c, and hmibsc.

--=20
Tom

--3en52eCrdytSQI53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfYl+IACgkQFHw5/5Y0
tywjVAv5AX+A4tHSGvOcui0d55dZgLTuv1jTaQ38+bM76VDQQfInQv9AFw2Ad50y
PGTrqRV85VZ06kntQMw19jF9gzAauC7/Nc7dQzw51gZeckHUtQGcSw9o3zjpoOtk
TNyOygGqmA2AuAZcn/7HO/EZg4xUwpnR+GYuhgG96jBwDwVer+pwdLJW0Y+qwu9c
KxPtozWhqj3MpLcykXcx8qbFr2jBGMeeZajEAk00aqN4zVNJH8X8PE7KJQpUUL9c
HnMrDBAHJESSSqPikrB1jSb+XDgqPUHmL82+PtSc8uzbHrVMmhtc1Z9TYckmpbv9
WS5vWJUTzlCDq80QH6wCvQd1dDGgyM6kHXHNeMNMyUhrGYiUOXy51f+1mvGwjMfh
A8QADip6S1zgG4A0Gi+JBMrDUMyKjuhBEea9wflzietes97htXVsMqaqqU9tdTIS
3VQ4b6VkpM7F7SUHBh4VPEdSY2/lDp63qckuJ9dOnaMjf29aRrInBl8WKdPQBX+E
A61qmEa7
=ulgK
-----END PGP SIGNATURE-----

--3en52eCrdytSQI53--
