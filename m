Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D918C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 789A482EAA;
	Tue,  8 Apr 2025 00:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cwiTd0zF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B918982EAA; Tue,  8 Apr 2025 00:00:12 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A51F282EA3
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-60402c94319so2418058eaf.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744063208; x=1744668008; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Te1JNNoCcFnyMg3HUEzIZDeKDAQqTyNNPvPehoRndpE=;
 b=cwiTd0zFi5hhs5Kew1l43YMsCBejDE4PN6p6aR0/zXKfh7tbXzQskF2QIozwuiM/fy
 JsYLfx7lJ6ZGNQbbkOfu4ZdINJKmi64Fvdj50R2Iaj3dNLE9yNc+BcZj++9Ln5X2ANmf
 l+c8eGBmPUSAgeJF2Iynl6fKgyeyfTShR2CqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744063208; x=1744668008;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Te1JNNoCcFnyMg3HUEzIZDeKDAQqTyNNPvPehoRndpE=;
 b=IUmOEVCEo7mQ1qfMx36/bwUtz2mzNHU0fbOGheoeH+FdmcoPvtDU2w8IaTuMnKZM0z
 ZgkaSb5gu4HRJXpsUyGjcAhdZr6myAHQ7nYB2ggqCQuwBz08n1/u8Qi4M7YMx1yKqlc6
 a4ImR8A+xGQZNW5jbKSTLBLNN4nfJtNKtLQyL+dc/UHuPaO8F4VXRg8tGjPMFF7Z+iDv
 yf4lINdNHNwZMDRvcu8KGPm0ts2a+N1+EPse3e8vk+kDCztrzu7tOUDjrpNuhb8vkkaH
 yadtYZhP7pCMB6m89GgsX92xATjfuGPJBKs3oNkw9yFYRV1hvuTgmz/88mE0dr4hwp2E
 Wa0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0tR6N7Cn2uoomE7wf5chlgerLpPIZZuYvP6QnXN2vSAcU25ONcQXblQFrWnqFm26xcKYlTBY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxki7MUxDU41zmA+3/X8nw3Nfx5f22+5bDDXS/5czSrWfdK3SK+
 lYLNCVPx1Ubb/Vz+U7yjLNvasZtMxOaVLwP0IZ5tu1zsJM/KbpJ5sQCz+OkXMPE=
X-Gm-Gg: ASbGncskHifCzEs4Z0OKCWLJqDU6uEMufrwHrLIny/Jea2Xy+W2ZckrGia4uokslrKh
 L7ECgFrMIoAi8dLhct0urA2Khdoe6H5NsBdo5T6u3wx293Komu/yCyLz+ZUV/YT+vOfoZPUrtd3
 wIJSzIk49jDrJfpa3F5Sprwv5+ttynTAZ7n8nqVmpdSfFiy87XhstmJd61v5O6NQjozN4U6QEZH
 +4yedjX1A6UJbqI0HbUM3zp2hS22kBby748OkzgK5RSD4cMQUZerI9Ag1DBgFBc/e08K7Po4/Nh
 7TXtuCTyIYqofGEzC5UHyclGST0duudclr+o9vXYt6rZf7SWgTCeoJIRqXp1ZtfJ7obg1acTCvY
 RVG6Z9Q==
X-Google-Smtp-Source: AGHT+IGZ9QSzPK17kGop1wHWv4ilNNcuJLwpGX+y5Cnrx48fXEj7VBKUifeyndCfIiGw8IObg/Qmrg==
X-Received: by 2002:a05:6871:28c:b0:29d:c85f:bc8c with SMTP id
 586e51a60fabf-2cc9e89e78emr8081332fac.36.1744063208409; 
 Mon, 07 Apr 2025 15:00:08 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc84b2798dsm2204370fac.36.2025.04.07.15.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 15:00:07 -0700 (PDT)
Date: Mon, 7 Apr 2025 16:00:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] smbios: select CONFIG_BLOBLIST
Message-ID: <20250407220005.GR5495@bill-the-cat>
References: <20250407064424.71541-1-heinrich.schuchardt@canonical.com>
 <20250407064424.71541-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+/D0QkojpVwM7coU"
Content-Disposition: inline
In-Reply-To: <20250407064424.71541-3-heinrich.schuchardt@canonical.com>
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


--+/D0QkojpVwM7coU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 08:44:24AM +0200, Heinrich Schuchardt wrote:

> Since commit 53d5a221632e ("emulation: Use bloblist to hold tables")
> `make qemu-riscv64_smode_defconfig acpi.config && make` fails with
>=20
>     drivers/misc/qfw_smbios.c:93:(.text.qfw_evt_write_smbios_tables+0xe):
>     undefined reference to `bloblist_add'
>=20
> Build with bloblist support.
>=20
> Fixes: 53d5a221632e ("emulation: Use bloblist to hold tables")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--+/D0QkojpVwM7coU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf0SuUACgkQFHw5/5Y0
tyz4OAwAnVdjDCAgBYpo7VLQkUWxiYtYOYwDDwfSLx4JG7ax4tqaZp1jA+3JcVpu
Q6VHBWUP22UbUMI4F9IHGYZxK4mYil/DBnu1xjwrb5SdrPMdgWj9O1U5KBOAlzHq
kCaE/pHNzxC7xVpIcozf9K0aErYSkhxj0DZ6HGuhuwyx5UQFLAFJWVJawi2mCS+H
hD4rbZDwz8oroDUIQvcK8hFvOhM9HZadkSX1G5vPmv16DAHzQCy9apKYhU1y658D
aRDP7rsK9ZyDaSVh40+u3SVyGYKZTA2+Z5mcBs1Sp3YlGC5AcpF+1668I6L/pK3f
Hz6YyS3B9vYPwKOhhg6d6bFPc3yR99yp3UNwjmwYNbp8cjD7QAo5EyvtQwJHXEGP
3a0dLOSQtXQYE94c+s5vcL6dNcqxeUeEEQnFBzezUdcKOVmg7MACZpkTexY7pIMb
H5LhKHUVGBqz7iRuTesLQAk7PVBccSHLeASiBHZttDAPLfBGS6SS4ZMOMDiOco4c
BgJbwuT7
=MyeL
-----END PGP SIGNATURE-----

--+/D0QkojpVwM7coU--
