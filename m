Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C6EC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE9787061;
	Mon,  4 Mar 2024 16:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Eknj8pjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E595786FCE; Mon,  4 Mar 2024 16:27:43 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96A787061
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-68fb730fdd5so18780916d6.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566060; x=1710170860; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gLL5mZXsgp0v0iQGgULGpSH3HJMLHogv48Y+tOQ74b8=;
 b=Eknj8pjM8RmxAkLdWNJ6kz/wHulFCP5SRdWbRGvxAIhiwg1dtjr0VIDWtZM130TVP8
 m1jhKNwOct6wFYcwg8T3x3Aj9g3NFvR0tvwZrLpACMF1HOolQGdbQVcjacwtQvaQUNpe
 dJg1tMp9JU+436tfwFRxRjnXmHQ3S4vXzns1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566060; x=1710170860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLL5mZXsgp0v0iQGgULGpSH3HJMLHogv48Y+tOQ74b8=;
 b=uYitoGEMJUJ0KooULT4mBnpDtQInkDi8Q+GBZdqU4QzgIDsq9U8R0lRoNZxYyKgSXS
 2ruEIBKb7jPwllXCxj6JQZ6drm0E68R/lHxluGGUktRyW+2oANy64F3NKt25XDGgu+ob
 usMi4UJQCAGLHXZhToE8pQhZsu9NbSBnah4ZG3XzIBbPuVy+joQYUwEMARqaf0i3rbw3
 ZLW2HaEDVmyYu7HLzI63c++cycvraehooPtk2AzCHOAOTI4GNGR7DZF78nAhXitEax2d
 2Bc3liCfQSvD5Y3ozXFbd3NGb+9KyuNyxTFKO/e2Q6RwhLdrGCbjpyPfpWxsIVOj7gYH
 MSkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHr5MiglyKFNV0kkp9/EtuU3coBURPjPMwy/k4zDTpcZQzvyoyyj9BOrLk8CzO/30YYzQLcpVXL0YF6YG/iroMzKFSQg==
X-Gm-Message-State: AOJu0YxAau8v2GlDSFwE+HbUSj0TA1WBNlTrJLLjvsOV0OaBGiEzjTgL
 ccOf3p2L1fyw9WAQVaGnDmNszXQ485XwkTX8GrlPADr46PcZU5rYDZTPa+Nens8=
X-Google-Smtp-Source: AGHT+IE58syJwf/eutDj9LilaccEmOIsBy7dyKH03/7vmahW4SAgRpUxTHWnX5gBuNfC+cbwYx9loQ==
X-Received: by 2002:a0c:ed46:0:b0:68f:cbdd:aaf2 with SMTP id
 v6-20020a0ced46000000b0068fcbddaaf2mr10471272qvq.33.1709566060703; 
 Mon, 04 Mar 2024 07:27:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 qj22-20020a056214321600b0068f73372424sm5207683qvb.90.2024.03.04.07.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:27:40 -0800 (PST)
Date: Mon, 4 Mar 2024 10:27:38 -0500
From: Tom Rini <trini@konsulko.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] bootflow: Fix build error when BOOTMETH_CROS is disabled
Message-ID: <20240304152738.GU1523872@bill-the-cat>
References: <7f33a6aa-5018-484d-af40-bdb7c4e3a70e@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="svxSjsD0rHNNEGbx"
Content-Disposition: inline
In-Reply-To: <7f33a6aa-5018-484d-af40-bdb7c4e3a70e@moroto.mountain>
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


--svxSjsD0rHNNEGbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 09:26:09AM +0300, Dan Carpenter wrote:

> The bootflow testing assumes that BOOTMETH_CROS is enabled but it
> might not be which leads to a build error.
>=20
> aarch64-linux-gnu-ld.bfd: test/boot/bootflow.o: in function `prep_mmc_boo=
tdev':
> test/boot/bootflow.c:549:(.text.prep_mmc_bootdev+0x1c8):
>     undefined reference to `_u_boot_list_2_driver_2_bootmeth_cros'
>=20
> Fixes: d08db02d2d3d ("bootstd: Add a test for bootmeth_cros")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--svxSjsD0rHNNEGbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6GoACgkQFHw5/5Y0
tyxs0gv+ILV6H38FWpcSDe4fIPLXYTkQMytQd/KmvNeCNCcK0cvdZDxs5l1PNTvD
f+cVkqmsrNEzlezupmkito7PHvfXvzlp7brQnAs9tz9P/3qdvog2RB3ooKt1MX6S
ePwB5npJH8CNMz7msFdNRtTPFrdddiAfxsh4tgMWYg17uawOwbkrK0QvVqQoNfnu
KmwqA8bX5Z89baDLlf3o0rA4KSWr0KOcU7kwQBqIsQ02MNtCOZf9eoc34jOZPkFh
Yvl/QpYH2vwrl6Nl/JoxLXowMlXi8FPbc7ixmkSpGPg3R+vvJ/7Qd2/neFGcMExP
QytW1/BKT/v4oD9NUh791zXnJZDWaMInLG2tyYpkoAFy1Z/NO1zLqM8hRWqat0wF
V2prnb300iVM/O7Bjc/t71zT0V5F19xbnD+xvmNsP3a5sU0sXwZSl8V9N7u9yfT3
Y1ZnpAAW1prYiYkAlbBvwYaLA/zvrCjd01VE8Dj5Aech9ydJJTxdNUA8MUaG7HZV
CVc/kpoi
=z/az
-----END PGP SIGNATURE-----

--svxSjsD0rHNNEGbx--
