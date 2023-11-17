Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B962C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61394874EA;
	Fri, 17 Nov 2023 14:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cb97F9dA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BCBF86FB8; Fri, 17 Nov 2023 14:41:46 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76AA4874ED
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41cc75c55f0so26732831cf.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228495; x=1700833295; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6+ZNM192aAX5zlAfSoPz/tjB6zX0hQXi+OvUKimxBA8=;
 b=Cb97F9dA4CaW5k9oA6fWWmKhPsnJBq7sQly/9MG+LEwsyx9wMzV0a7/7c1GXP5G3Zr
 8s4gjkDeoHIxoRqM/ABaKILbxiDkMzLmxPKRHqHCicmdkmA8N9uh2eF8GX+yFabV8oi1
 lWYMwzvUXAecU4cpVyfvsIlrhn/UM8ak3zcL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228495; x=1700833295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+ZNM192aAX5zlAfSoPz/tjB6zX0hQXi+OvUKimxBA8=;
 b=jcW24wVMohDGFTgIvlpDTLbgFmlknLopHABTXPtrucLa6YO6Yfg6T3oFKRW6wVtenF
 3MMZ7d1LTN77dCpAShesbsiaPpxewD0F3c64WM0BHN2dKDyhAzJmNvTaObwRUDrIv2qh
 HkjrU5X7QVn+aHIDg2MclHETAvUhI9D51QYjFvP94SsvLbqEjLJvDplFyg7y+wFBahj/
 FlUzME+3wWtDlayTrOI7jGtjpe4ex9gV6ZnomHcCGbqe+U/+qJe64oflVvJN+ohlMKtF
 vbdK4ULI4sfY/hBbVe+DT3YWSh+QXqg+v575JxjlzesVoN6Aym7jOZ15VSXnYRcAc/fW
 5P8A==
X-Gm-Message-State: AOJu0YyHdXSvv+Q5uz5aLEFC1A5dE+BnPAMPGbknifg/YmOzNmvEp9bK
 A47finCztTD1+Q1fj87NZLkz5Q==
X-Google-Smtp-Source: AGHT+IHXncuQ+cXwXiedfDpJ5nFHkzkjU0St+bMK1YvIqTaEhgN6QFDcC8oxplwXG+NzopxBRl5j6g==
X-Received: by 2002:a05:6214:40a:b0:66f:b0c0:93bc with SMTP id
 z10-20020a056214040a00b0066fb0c093bcmr8854252qvx.22.1700228495198; 
 Fri, 17 Nov 2023 05:41:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 eb14-20020ad44e4e000000b00677fbf0d69fsm95724qvb.105.2023.11.17.05.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:41:34 -0800 (PST)
Date: Fri, 17 Nov 2023 08:41:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH] sysreset: Fix unsupported request return values
Message-ID: <20231117134133.GP170968@bill-the-cat>
References: <20231108085110.883-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f5m585qFGJiNIBzy"
Content-Disposition: inline
In-Reply-To: <20231108085110.883-1-paul.barker.ct@bp.renesas.com>
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


--f5m585qFGJiNIBzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 08:51:10AM +0000, Paul Barker wrote:

> The description of the sysreset request method in <sysreset.h> says that
> the return value should be -EPROTONOSUPPORT if the requested reset type
> is not supported by this device.
>=20
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--f5m585qFGJiNIBzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbY0ACgkQFHw5/5Y0
tyzLYwv9EMdnriXNY4fcgf5xeZJbQE2KKHK+oieNPkq7vOtxCvigMan3Lqtan79r
VZTNR6FKRJqUIJTExhWvd43f0F5boWj8qPkWpGzCKmzKAMz4tjU7t80BWakDmYuH
j2YOxWNw+A2Q7ustohj22AxmXwdsU/OVa6Ya12vdsekFRx1gSUouU1/wi/7tDJMd
lgE9/wl49Y4ZqdCr2+eNIbcFASilUZ3P6GAQ8sqMTQ+m/juV7igF3kyeppHUYTNd
Gt92skAZIk7MuOn3iSIi3p1N6vj3vT7BI0SvZg+qYo5Ny/SjvjxCGT2/KqSANzA9
byvBAvIq1JslHDpXMFuZ6jk+HpSP2Y6Zx2IeJK6zWbLG53RTjFkfZea3GGIE/e7R
7PCsJrHb2s6AtlMHt9+OjxzrmaayubcgGvwQeRj8CGv/0aJMlG9bSu9nL87q6vWC
/iuZARepA7f0K6WPI3VHG7oH0ryesoutSM+tr5SJ6LTiJR0AdRPAteYQiDhdinP7
unvSjHwX
=k0rx
-----END PGP SIGNATURE-----

--f5m585qFGJiNIBzy--
