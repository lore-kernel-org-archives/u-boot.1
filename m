Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D160FE77169
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 01:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6249F89427;
	Wed,  4 Dec 2024 02:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XqP/BMyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BFFA89534; Wed,  4 Dec 2024 02:29:27 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1D268911D
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 02:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b66ea49407so42177485a.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 17:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733275764; x=1733880564; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l64YkZA8zkCGr2v5oV1QQ0aF7mifKTSmfQ9cdx3JHgU=;
 b=XqP/BMyd5xI1GEKNS5haUBTatCNka1flt+MixteQsc16AiYAGd9BXA3Go3b96CtEQ2
 yAWt5fMQLmSdSC1dROHgz+xrBKfigdfvIWy+UF+8wdq2Maluf+HBbik9pSfTlmw/TfuZ
 REeipW0mUdc3JQbV7/GC7jjicuPPVR/l+bPWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733275764; x=1733880564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l64YkZA8zkCGr2v5oV1QQ0aF7mifKTSmfQ9cdx3JHgU=;
 b=eEJpSOKk1quZEK9d0T4oBhJZ6lx/vo06Q8n6897A+fXb+6sVTQvSIgmbR01F6V1v5j
 ZwZOB92/9D4bXGeWNCSVbK2FNq/hYvAIiIBfqAY7qaLTqKNu8sREHGm4S8fsoYtRTnTM
 B4RwHiVSsWEVl1VXESimkkLRGMRSjeZgJNAjx7Crosz6vJ6LDSMpqqWcwdspMzGExr1m
 VHP7skWjXhL1ZD5/u7gE30pJoYh3zLLJf0qrgYafYqqtZ7F+Plpxwgx45wW7meDuxRF0
 cZZgncMn4i/3lDcj+eGjBXoqFwCN5sZg42bwwdTwo25T2sMCPN00sUK8anSRLPbk6v52
 tOlA==
X-Gm-Message-State: AOJu0YyhVSxA08BUnNzaYuGGUcfRLGPiDiVmde9730KlRmWaPXCyvFVJ
 n0tJJfKRutHHpXV0/vrw/5Jllz9llD3lshEq2o9Ce2YFaG5J7CIKjhPtwLXQpBnxaVCtQdFjvHC
 5cDw=
X-Gm-Gg: ASbGncu1vcWrR358imI1pF/9s7/K5K4FUpFmgDZajWLM+n2hT5+yZ0nl5gYEdVmdHBB
 anfioH3Vkkci73L8on2Y4VQWvHjyu3pXy5gnLopvFHReKL60B+VHtUkg6YYR6GA3ozCj7QODlXO
 yriLiKSXugqmJT13aJShPb1aDE/6lZcVbEIaapnYazSKo8KlwCFAKgSIg0tRwvMn2UQIxErVASi
 AZLCobWeBbemVDvQjD07muW2rbIohZxFuxJSsyfKFt5IzbkzA==
X-Google-Smtp-Source: AGHT+IHK6wmLtxDegEqicW6+BOezTTb7YKiY2KXihE76jGtf7Ib7yGwwDUdkMP/gjBcUZjiYdhOxkg==
X-Received: by 2002:a05:620a:4090:b0:7a9:b4d2:9d68 with SMTP id
 af79cd13be357-7b683a396b5mr4023880585a.22.1733275763692; 
 Tue, 03 Dec 2024 17:29:23 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d896ba92efsm44262836d6.73.2024.12.03.17.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 17:29:22 -0800 (PST)
Date: Tue, 3 Dec 2024 19:29:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2025.04-rc1
Message-ID: <20241204012920.GE2457179@bill-the-cat>
References: <d28b39e9-2ba0-4581-830e-8b6f8ec9989d@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6lu/02i8P9zGH9+5"
Content-Disposition: inline
In-Reply-To: <d28b39e9-2ba0-4581-830e-8b6f8ec9989d@monstr.eu>
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


--6lu/02i8P9zGH9+5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 08:42:36AM +0100, Michal Simek wrote:

> Hi Tom,
>=20
> please pull these patches to your next branch. The biggest change is to
> start to use binman instead of arch/arm/mach-zynqmp/mkimage_fit_atf.sh
> script.
>=20
> Thanks,
> Michal
>=20
> The following changes since commit 62224280d9e89648ae90346c0aede76f9b7e76=
10:
>=20
>   Merge tag 'u-boot-dfu-next-20241126' of
> https://source.denx.de/u-boot/custodians/u-boot-dfu into next (2024-11-26
> 10:50:05 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2025.04-rc1
>=20
> for you to fetch changes up to 46097afc70352ce5dc0caa8f95b74cba1e00af9b:
>=20
>   arm64: zynqmp: Update the usb5744 hub node as per binding (2024-11-29
> 13:22:16 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--6lu/02i8P9zGH9+5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPsHAACgkQFHw5/5Y0
tyxbngwAp7XOyejQiEYlBc/y8700nYv8ydaI9LAB+kuScRMjKfinU92rB89T2lfn
R+X2o/AbY0tViDcaEvmOQPiWlbzEGrciJcIpxeH0KxKhwPZwnGIxvAaw03BmP+23
jdg/SqckxwLlKahHbwC/WUmP3fBcLJHW2ETY6eNaIlke97YuCR/XVVcVDgc5VgP5
1q6HaKIX02c2DdsTv3UQb5FUDA3vT6tNni3nxTY6VcZ3eRRyaZNTHgQ2Eoz2wnMH
wKCQv6PpMsmRRRzjBGkjd2AwGzhqwevHUhK6hPw3il8aPVp2o+F4M8hQ92sYWE3H
7iqMBEhlrPEQHL+KPEL+D1MzBtj9f27SSxykVMufud6+wi/fwaLo4kRmeMsbGnaW
g1Ycaq+L2+HwuMbK3o4xEyoNAx88ai1NnDTthThzZqB0/FvxefsNMVZy9TFqrmyO
VE6A89rsv2OK423MncK1L2EO+CfzrMBtRjEoH+dq9ybue5pE9445ccJriAt8kAn5
AhQu7mIT
=TauT
-----END PGP SIGNATURE-----

--6lu/02i8P9zGH9+5--
