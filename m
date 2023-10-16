Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F1CCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE3F86D2D;
	Mon, 16 Oct 2023 23:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I9148xvk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ADB886B79; Mon, 16 Oct 2023 23:32:13 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF0F86E2F
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7af52ee31so60888577b3.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697491921; x=1698096721; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FsA59635c7onPnB5CEmmXLiAG8ZjI2vui4Th0RFojqE=;
 b=I9148xvkcAGa3vdZR3WqtG8PqoUmwK733EnNc3w7J42BHSPACX9+RVVgkPr03fAEJK
 xrETmimMbQvJCzIjHYRV8xe6Me921qrso1BU7FkNdsXZ0ws1mRO2zrpOKSauko0kOX+2
 S0MnDN9woZAo5K8jgdsKAeulSqat66QQktkDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697491921; x=1698096721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FsA59635c7onPnB5CEmmXLiAG8ZjI2vui4Th0RFojqE=;
 b=Pxk3iKnG7btxYXwTbrbHXihg9ajYE7t9wx+G9YTTZaUj1kyEaVUM9SsyBV+Pp+WHLF
 J9RZ1qHXVSrNVYB7TsSdzHg0b+29LAk6eGY2lLbMuL9gQ/2zcaQl4ptt9o0QePn84ics
 XAQ2fqoSV+r//DKyQIYk521mVKh4saG7hX6+IEVHcdrM6Sbr+GBi+8NDUrmSdERZcVTD
 bzlAM2/IddtkPORHGpDygIs+yCSJVojGhObX2hjBA8VAfPIqJzW2Ohe2IaTVYGvg5UWv
 MnfSbS5eB5bXTvYzRhAvrUiHlLCAoVcbiPubHqIdirtrtUD3+VZpXtxoUN3C791G8dKE
 Gp+w==
X-Gm-Message-State: AOJu0YzKgn65LXlIOIUVX4wPwskhzJhiDlIkyCAG/aobfDEx5LysAnqN
 OtWZWnMWBmL1mvLX+hziuapEfA==
X-Google-Smtp-Source: AGHT+IHSVNsRnxoJVSCOheyb0IwgYngD7rsp2kaCiNwFVSqQyQM+6AMI8Sk/vsZ9j/IvVayI+MAE5Q==
X-Received: by 2002:a05:690c:fc1:b0:5a7:fc84:4314 with SMTP id
 dg1-20020a05690c0fc100b005a7fc844314mr427609ywb.40.1697491921062; 
 Mon, 16 Oct 2023 14:32:01 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 v5-20020a81a545000000b0054bfc94a10dsm34083ywg.47.2023.10.16.14.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 14:32:00 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:31:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Knecht <rknecht@pm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 6/6] eeprom: starfive: add 'mac raw' command
Message-ID: <20231016213158.GM3119521@bill-the-cat>
References: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
 <20230930120147.59482-7-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A1d8R3+Pzse8UTdm"
Content-Disposition: inline
In-Reply-To: <20230930120147.59482-7-heinrich.schuchardt@canonical.com>
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


--A1d8R3+Pzse8UTdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 02:01:47PM +0200, Heinrich Schuchardt wrote:

> Add a sub-command to print a hexdump of the EEPROM content.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--A1d8R3+Pzse8UTdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtq84ACgkQFHw5/5Y0
tyz4pQwAsFUhIYK5m4x/t9nsQujcBIOTM3tKNw4DXXRWs/22ZZLnsrITaUedn9RB
D+QYSmF+tnXygKnJYKdO5yvJftc9yKY3a0w9iDXJAqsjsxwfFiChJhyq3QrbkxeN
HmM+rlbUnkbLueZ1UZOAWxd+QUNaAf8av4CM3gO3iqoNKQCctbB9bSzzsx+1pdmb
hV4dNGciX1Vznru5Sex6Qw1ZtLaPCG/eBF/gVKHhWpJC+YW2UiNTgvS/72ObXwJK
o1kB3Ui42azzJjEmk1LkkbsoszS2LwV4z/6Ll/SLTOIpHl5/IdfMmFuRB4wQ/uU6
YzAaLx08SpbhF0aBSu6N/1alT7E8ud8AriC56HqIkSqWmxDb7L9eRKDVgPXnBOvK
xcC7M6UITtO0aANgLJBfMJcB7ap18Cjx5+mBgWR1uAm8dL/sfx8r445ZS/GwDzIu
r/7bOji5ma+ccUfTk0nQXcTnm78edyC6+9JVwZKJbk8wi4QM9e18vFNdDaff3eN7
VRgSC1ch
=S4wm
-----END PGP SIGNATURE-----

--A1d8R3+Pzse8UTdm--
