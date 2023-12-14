Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF39DC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 13:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC6D87A42;
	Thu, 14 Dec 2023 14:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JxNDT/Vr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4183487A4C; Thu, 14 Dec 2023 14:11:56 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C63A5879E9
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 14:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5e248b40c97so25416847b3.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 05:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702559512; x=1703164312; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lGGHiGhpiWHfFs1fm8v37u+jzysul2cx+veEbb9TKuQ=;
 b=JxNDT/Vrsmcj87M7NT/xr7yFkAVOhcNraZqkMQfIJ1MltF0MHxPC+deFAdEyDAROxI
 KbQRAj0akLIaLMpEKY/8SdB5KYPdXsFV/s/5LPa0ZGAF5paM+APhqgz5M7xbKRfmb8Lp
 IDOkhNyT/o/dAOh4RloiHN8BlMEBXfPWIoWy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702559512; x=1703164312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGGHiGhpiWHfFs1fm8v37u+jzysul2cx+veEbb9TKuQ=;
 b=LXiYtsB/aPLww/nenckTfEAz89yF3DjosxtJySemTR3iQYNTvhSISftdmWy3M53yKr
 991k8NcytFLz4XlaUEvSbPKtrQNYoEbonybQyIfOijhbadFdF0vAGkddapYrqJ7XW6A5
 P4lifUGFfoOgQEUSJcm1Qq+Ha97Hm7fLoEMbtqXrwcJ+pzT1r/0ZYb45ZRJyImwZwgkn
 Sb9fiBZ96src74rdwxbw+DleMWGGJ+Z35fv1vbMQmydSV88rji3qePG0n6QsshijTJDp
 TVsV8jbPMq7nqG4ddTE5Tu2+hWnhy7+xqwHlvhyBYx+YLYQCMfs2z1aPlj8kuplSNkTe
 R0DQ==
X-Gm-Message-State: AOJu0YxyOi4WauNuId8oL7JsJoTnFhaSlIBJLpdW3Aaci0zD51gW/tUi
 q1nVqzbrYDXrDLF0X2Zmt4wKiw==
X-Google-Smtp-Source: AGHT+IEDt+M+1V0H7677fjxAboeMkE1fiGG41iEDUZ9LBabpIveejIAdBtqhizcdNBoQbkwGRvWuXw==
X-Received: by 2002:a0d:cc4b:0:b0:5e2:b4f2:a203 with SMTP id
 o72-20020a0dcc4b000000b005e2b4f2a203mr2283645ywd.96.1702559512519; 
 Thu, 14 Dec 2023 05:11:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 g200-20020a0dddd1000000b005e3073d611fsm1059091ywe.59.2023.12.14.05.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 05:11:44 -0800 (PST)
Date: Thu, 14 Dec 2023 08:11:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sean.anderson@seco.com,
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com,
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
Message-ID: <20231214131139.GY2513409@bill-the-cat>
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
 <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
 <20231213205634.GK2513409@bill-the-cat>
 <CAPnjgZ2hV25e1zjrNqKqd-doO9A1L9H58oToDANOSEQr5jwexA@mail.gmail.com>
 <20231213230545.GM2513409@bill-the-cat>
 <CAPnjgZ0L+kVG0DWExwDJXYG5FfObq34LULV=se9T50OvcmhfMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x1OoQdyXqDlTfz4y"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0L+kVG0DWExwDJXYG5FfObq34LULV=se9T50OvcmhfMw@mail.gmail.com>
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


--x1OoQdyXqDlTfz4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 08:19:11PM -0700, Simon Glass wrote:

[snip]
> The new DT nodes / SMBIOS binding [1] allows for the correct
> information to be provided, though.
[snip]
> [1] https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bindings=
/sysinfo/smbios.txt

I think the only feedback I can give on your message here is to please
go upstream that binding, and then we can see what to do afterwards.

--=20
Tom

--x1OoQdyXqDlTfz4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6/wUACgkQFHw5/5Y0
tyxOuwv/UDwAUe9/jQaoSGAUoSbH4bdMDdBc5PiaJodWfJTslamZEiX9g9CU2HmE
baPpX5MFu5WVpo7u8vVX3NBXmT3MBysJGsl77Hc8PqH07aeQg2mp7jXC2Ou08H25
aBxfNTpZVbo9wdNV7wY7dq9XFbkgXRD8FYFXXmCwLPrBctUSCZ9xeRTALP+7ZVhv
d85X/UCqSICKwK8t5z97Xjo68Sx0Tqj8xozUKHOWAcYzc9WLoOGFkKKWdwYNa+/a
wGLC0eJmR0ZpRyM6SuPwg4v0DOcGSBLxekCm+k98B/fhziUG80UDyd/jXn0+/M4e
T2e9by/rrks1Rj2/7oCFoMor86hEPPhhbTg141u1AKx4gxgxxutdTw1OwuuBF0dt
c/baZjK0SEI0lK+hbnlX8iy/XR//csftup2NBjmZaNKODe4wQhX2QkLjNib9aRsv
y5986vOHhnmXUrAilLS7FkO640Ov3dSxLAmIoaP1CML0UZjH19cRKOPEeMeW40T+
3loYEayx
=IGSy
-----END PGP SIGNATURE-----

--x1OoQdyXqDlTfz4y--
