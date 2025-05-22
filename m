Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFACC54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 16:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6E9830E9;
	Thu, 22 May 2025 18:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nLfa+4UK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B5E830EB; Thu, 22 May 2025 18:56:54 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F7D83055
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 18:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c27166ab3so6251847a34.1
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747933011; x=1748537811; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qsGL6QtaI+9h486ioB/PoH0jLBbQdJgylET7bYvFokI=;
 b=nLfa+4UKG1PfDQIKkKLWuCpmuQ5eEfd9EmmGF6OyQ+hTLEbKrFuftJN8hjWh7qLzUl
 9+0FndkUuGW710czD2dCZfUDlBbjAhA8tF88botIS/wsY0mMsbZvDZkxFiR47q9f4iq1
 DxH5t/VrryPDwgwiiuvIIj+pDxckoKNm+gmrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747933011; x=1748537811;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsGL6QtaI+9h486ioB/PoH0jLBbQdJgylET7bYvFokI=;
 b=YTVISYESoQi5SBiJGhMS+7z1OkgsiPOJqFnj869E1fyPgNq43ROQxyiwSj1hRdpqwo
 WQKBE9gJOZe8LsR1HC3shiemKchSZiRUk6tNCH8P4oYf1lsrRKZUpw2Z07NaOBIEn9Vn
 mwOHUOSKJUVJnGRs13YAfwrth0Lo/HF+YcNk7OEpVqhHB5giAKDOrs2RoAU9V/eNGyvA
 udHDsDmzd4RBQYgJTq5G83NP9Aw3BoRCdLuqm8A+oZU4jcJfuMSuRrNzfeBpWRZdEBvs
 MuB04UEAoEXK8kvG0I9bKZKCCmbws1FGq4+AzRHogGh0Q7ioz2gblshRqGSxHcjEVBcj
 hL0Q==
X-Gm-Message-State: AOJu0YwURw4FgrTGJgfoYYNsDxV2Fu9+QKVLUj4QdOK0/wsf4ydAO2VH
 qEP6ERbdRGTysRHjO7/0/TrOAPDrS0bYW9wlD45bjoBsRptJWPmsoCFLtw+XAhYTJZM=
X-Gm-Gg: ASbGnctJlf+XIxOL3S9AUGeF0fqJGj125l+PRVoXAJOcSguiT7Fbus3XtQhLzPHbeMY
 crTtYNvMlfqatCy1PnwLmBh6SKBSRrTHm5hq+jPAaxkojKPT+mYrpNN2kI8pm74REs+EVwRwbkS
 WTpXX9nB45ndwuLGwbs8omShwcnVo5zbvZPxYkoSzWWQwmRIsZ7QXC2QE4COHHpB0exWIIeIElh
 F39/fhUFwMuXRTRBcdSboCxJUnU353mX4YLHKkBQIwONpB9+GlD6vdwvS6QC/y6NBrpHVW9NuNO
 +8o83Rcxf2hY4dcLO1siGRk5Qrg5UPnWmI1E7T9Mw8+Zvu1TuM0ZR6J/hhTClGQPQkMHUFl3VVZ
 jlS7KDad5OdST
X-Google-Smtp-Source: AGHT+IFucKBvE+cNONpBclEkJ7Qa9neRkvtEurROUVPO5Ta3IT5Qle4MXu2hDSYoUYGq9E4pucr3gA==
X-Received: by 2002:a05:6830:3696:b0:72b:a175:2f0d with SMTP id
 46e09a7af769-734f970403emr18336661a34.0.1747933010958; 
 Thu, 22 May 2025 09:56:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3cadesm2524124a34.47.2025.05.22.09.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 09:56:50 -0700 (PDT)
Date: Thu, 22 May 2025 10:56:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] xtensa: xtfpga: enable DM_SERIAL
Message-ID: <20250522165648.GA2179216@bill-the-cat>
References: <20250512163931.4184305-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SPh45G60E8QKyMjA"
Content-Disposition: inline
In-Reply-To: <20250512163931.4184305-1-jcmvbkbc@gmail.com>
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


--SPh45G60E8QKyMjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 09:39:31AM -0700, Max Filippov wrote:

> Enable DM_SERIAL for the xtensa architecture and update xtfpga_defconfig
>=20
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/Kconfig             | 1 +
>  configs/xtfpga_defconfig | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)

This seems to lead to the platform not working anymore in CI however,
any ideas?

--=20
Tom

--SPh45G60E8QKyMjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgvV0wACgkQFHw5/5Y0
tyxxlgv/a0FD1WFZVlavYCyXHEbHrRQ/HO4QtwcrxlkncBe26Ni3+3bxFNpyusTl
HcM+22Xc0YqLZSi+a9MKA1oyuX1os2eJAI5tLHMnj3qY1SQwAJJoepY6Ze+gn4vL
iVAPGLUJGlPoMEQ+bw5rrG7ZAx1NtDveISV2jGAVp58920ZqO8LBr9pjtLS7Q65K
r7k7v0UmESpt3VeLo4s1l8SLe/E33hlqnms5Jh2wzra/QHidRrStmaaPHnkEt4kC
aqoB8rvcZmHEIoUeup6DjJaHPb16WRTwARgmRApALHDHrgLoVvQ4/+TbtU/t/Xq1
eqp2wOCEzk3Bi0DnZCcRmUWeUqRhGhDdGM7vSV9QjYONTK4B3Ef9VOSlgBLsMKOn
B7W8BU/X3SUngdmcVaM2CMRCm+OMecUGLmwhD2FdZXGYUnkMBTslq/Nh37tAL3oy
qvKIr3vgGB6pyARbMTtbwYb057aOfoXeE/JsbxulBE0Oka8YohR3/RVP46xLyyx/
w+JBSlBV
=GeWT
-----END PGP SIGNATURE-----

--SPh45G60E8QKyMjA--
