Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E05CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 14:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06575831BE;
	Wed, 27 Aug 2025 16:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mzGO6NPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2997A831C2; Wed, 27 Aug 2025 16:55:58 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E99CC831BB
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 16:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-743749537caso846554a34.0
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756306554; x=1756911354; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HR7DiZes3wxLb0ToyZwS924sYk9e8+Z240tYMtI9N78=;
 b=mzGO6NPnYyFPVPp5q8y5PVYmrHK7hwAOfhb2oWP+Luvf36DidkNxH8WgZKimQI3t/A
 vT2yZ5KshwMUIIIt1GKmRpa4Y2fQAOd6NKXb9WuatfrTxwmHMvd5b9xvB8NVd4iS1+OJ
 6qsWooPh932legHiWBPSF5vN8wJ8172v2PZNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756306554; x=1756911354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HR7DiZes3wxLb0ToyZwS924sYk9e8+Z240tYMtI9N78=;
 b=LzvTU3Z/az/4yTixie31f5rvvPwKfihGJiLrx/rl1z6FcGyZqQbMcE9jbs9XjjAmQT
 C/Scrj6+S3dD2Rgid/udoqlOWE3ujF9s+o8fYUk33xvDbGEsYDJAD19ViGWrGaI0qW/I
 K8Ph9LfGkoUKUiV4I7n9E8YxTjUroyy8v+uKL2RT4+CAZMH6kyN0MY19UZZBWCyQYGwe
 c7Sjj396TDOOZovI+mRY+KHH7PP7HacLC+QI/PQfCIlj9yK7TMhvx/kKLggLYHbKvUEn
 pHiAAWDfxR76ctRuHG/2DgsIO5StNK5r2U1CRYXpHjkj0CRNOWjZ98KB5vu15op8G9r4
 rJvQ==
X-Gm-Message-State: AOJu0Yyd/MHhQ4JSUjLrt2At+hzysA4aJRR63Khza9+NLymdr2BZGuFX
 cv8l4nxXu40jmyK6+bT1Czpu6bfY2n87KJJbC5cpPh87Cg9uxSc3hk22ZYEHEEoiqGE=
X-Gm-Gg: ASbGncvNDfAcIHBi4Ys6wf8PGEAcgpAaKNv8ac4pOUJFOFVcMMuJjFJqKeQO6uieYsv
 N9ux3nMJ3pA5FtydVOCNC/BpxrhNR+thdhI0px8fCQIPeHJ+iNyBgSR9YkoW/aJSJoYO/DWpfCL
 XRq4c6zvqbQtW8jhf2oJiQnxOIt9SlJ9oub2ydYR9hcTkRMiKdj2E8mt8jaUcbMc4TsSEghU0RV
 wnqonoZvKu6jtrhcEIX8e+jXn2GLo5STfH9UAxglSf+2eoDsoTlaNkKyvV8/V986962AE3bNcCv
 kqaW+WafW/wpS/DstHgIgO6D9zXUr+693Cs/6RCfZwfm4LOurZ4kZ07J6SX7PrvMgE5ic7UT1YT
 dGydi8uoum4l31sOCiCaud9t24pHv8/8G0fGqHTkL6qEGgoK3h1Xq9DNH
X-Google-Smtp-Source: AGHT+IEjBBNYPZoUAKncLuDMUHtV6d0iusUegjJrYIyF0hDzCxHJiSNAHmkA/0DJkV1aNTfQH7TMrg==
X-Received: by 2002:a05:6830:4d83:20b0:745:3ebb:b25b with SMTP id
 46e09a7af769-7453ebbb820mr938879a34.16.1756306553888; 
 Wed, 27 Aug 2025 07:55:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e4bc54bsm3088772a34.43.2025.08.27.07.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 07:55:52 -0700 (PDT)
Date: Wed, 27 Aug 2025 08:55:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>, E Shattow <e@freeshell.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] net: introduce CONFIG_DNS
Message-ID: <20250827145550.GA644866@bill-the-cat>
References: <20250718104852.724720-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iybqIdIltkblmK2s"
Content-Disposition: inline
In-Reply-To: <20250718104852.724720-1-jerome.forissier@linaro.org>
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


--iybqIdIltkblmK2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 12:48:48PM +0200, Jerome Forissier wrote:

> Introduce the DNS Kconfig symbol so that various network commands may
> use host names without the dns command (CMD_DNS) being selected.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> CC: E Shattow <e@freeshell.de>

After talking with E Shattow on IRC, lets take this now for master to
fix the regression and in the next branch move forward with more
aggressive renaming / correcting of Kconfig symbol names (and introduce
as needed new splits between library functionality and cmd
functionality, which in turn might also mean needing to move some
argument validation out of cmd and in to library code). Thanks!

--=20
Tom

--iybqIdIltkblmK2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaK8ccgAKCRAr4qD1Cr/k
CowwAP9PfoaCNkVnRyf51Z1AcdazyhtBthdktDLzWY4UOF8nmQEAzuszkJooRO41
DR5830jyROZnkV5OHtFrOO+3p5Z0FQ0=
=x6DN
-----END PGP SIGNATURE-----

--iybqIdIltkblmK2s--
