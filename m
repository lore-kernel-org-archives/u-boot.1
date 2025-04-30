Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72B9C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 17:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E731182C03;
	Wed, 30 Apr 2025 19:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GOsx44Ob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9368C82C13; Wed, 30 Apr 2025 19:25:42 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1273E82BF2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 19:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3fcfc85f1f5so54507b6e.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746033939; x=1746638739; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xXY+YAEMpvBBJFPlypdrdbJR4bzJy9BBwRSvEUxr8lY=;
 b=GOsx44ObwsB4bhClQfQ4n9DFQW/ssXHkZ43K/OsZuQlBQFN/PLA0bhjQdrGBOymok9
 T93bdyx6UsYiixxfkshFxrwX0XaVqHIAh0XzClFy+hN3QAveL788R31koe14E1OLzYhp
 GCkWxx4y4h0o5mRbDhoe9g2p95cAIlwyXetSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746033939; x=1746638739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXY+YAEMpvBBJFPlypdrdbJR4bzJy9BBwRSvEUxr8lY=;
 b=jcLM2OBr+tHPd8vVZL0lzfPQBln5pSxyyXFISBKfwOXwIMxVHhEz37uKaMIskTzC0J
 17jQcIYDTKOsVqCZVCx13XqasQl0U50CCCapOTAKBEvfY1K3Dm/sdwGBOOIRWsVxpYZp
 EhkjPI3BuzBhIQWoMeWUyzYq8xZX+3WLeKjnIbM6/QRRNysMExdfbfKioeU1NugshK2P
 GSxuXDkxaFLKDCaW1eTDgANMRUgxglOmcSdLAwEckhyxfKUf8cph2SzhmsFgD4e0lHC+
 TwE3kg0hH/8iIqhoD2cjtAcHSHUHR8u8wBxZ76pHYuyGUitoE4NiUGlOUrdWqbu9YSxZ
 gshg==
X-Gm-Message-State: AOJu0Yx+C287PtlWFjA4yXEX+Pv/EamBZAtwO37WMNqp7tiv+UdyvkMj
 XSFLye1+Y4NhnoONL4g9m+/kvwZ9P+aRjcXAM8MpvmQTti/eavu5h967EexsRDY=
X-Gm-Gg: ASbGncs/cpT7deivRKNOFA0VeZ6fWDnH6+EbV3teg2nHvdDov26fM72cOk9Z9M+EYWA
 vj+WcrRghsbladrxGDceOsvn8ni0RKShWmoysQ6hZB0KPI5ARc33aBnbtJs4dzlozI5Go0TPRLH
 +O2DeXJDu0zI1Sos0WiEyIQ9pmPd2DBiiFwJwFiwCM/X1IYBG4LOA/QjkhGdu826eyiWVRZZ/FW
 bpuOQ19JO1GJwuDARizXawiEvCx7uWRbT9XHwgRXjjYWCY+1T+jSg5U4D91SRltYJGY0Kn419X1
 hFClE+UWfnEFAGYDKvZzS5EjLQTZTn2lctpqjT5nIAXKz8Zlk7ebttUbRMQtSAMCa1hvLBFdLM4
 NyQ==
X-Google-Smtp-Source: AGHT+IHg4YwdhStC8A5B/DcyCIJpLmowjfN6MIFimH7oVJUZX3XCnT6k65acLPzVT+BqrzFr0hshSA==
X-Received: by 2002:a05:6808:9b5:b0:402:1cfa:c708 with SMTP id
 5614622812f47-402c7267c8dmr1963207b6e.21.1746033938694; 
 Wed, 30 Apr 2025 10:25:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40212926792sm904071b6e.18.2025.04.30.10.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 10:25:37 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:25:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH] bloblist: Drop BSD license
Message-ID: <20250430172535.GA1780984@bill-the-cat>
References: <20250101195817.995321-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ygj/sDgKCzMIEqge"
Content-Disposition: inline
In-Reply-To: <20250101195817.995321-1-sjg@chromium.org>
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


--ygj/sDgKCzMIEqge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2025 at 08:58:15AM +1300, Simon Glass wrote:

> Linaro has decided to write their own version of bloblist from scratch,
> so there is no point in having a non-GPL license on this file. Change
> it, to better fit with the U-Boot project.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215
> Acked-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>

In summary, this change is valid, however the commit message is at best
misleading and argumentative. For v2, please just simply state that
you no longer wish the code to be available under a BSD-3-Clause license
as well and only GPL-2.0+.

--=20
Tom

--ygj/sDgKCzMIEqge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSXQsACgkQFHw5/5Y0
tyz9aQwAq9d2Pvv666uRJO+btuBtlFFGUCTpdBFuMv8CsCWCMmLFmsGVA6kGeXJx
OHupmQUOygeXvhZPipVn4pXLN6NwZVmbNUHdyrAE1P/sqY/ofXXsgyGf4y30opb2
2u271MG7gw2I2bzuaic3DG6O4ael3A230g1tmuzYuYnHFY2Y3/tFcb/CTzQK+5Fd
64I43OqKvZZRMvWuUQlKcRGhGj/JTKI6SSS2rrorqLlNX/m9v61Q+GfJoEaOpBDH
hQGlFoFnCCVOLUQsRp7JtKzSIqV8vtjdbALWSN7x0tXp4GxMa33k3PMlhpBQzgaV
p2vjpTZoJcefeHueBZVIvgIEo/QpBSY+gluqa3f9LB55A0eiFLDOEdvHsTKYEWLr
YSdS0JjptgnlHIS/kUwxxFXcXGN7F9/XTYhkA3Ijcre1pFIG546mr70IkOCnrCQM
1MYpKdgYhbmL0M/YS69uDu6GpWbCOjyY1J/82lxVVpp9MZMLeNtuex+SO2MQ5KZQ
ziqEgFCt
=AgC9
-----END PGP SIGNATURE-----

--ygj/sDgKCzMIEqge--
