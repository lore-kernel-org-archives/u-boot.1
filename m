Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E31C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E82B887AFD;
	Thu, 14 Dec 2023 18:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ovu5SJCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 707C087AFD; Thu, 14 Dec 2023 18:51:21 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 011C687B03
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5e36848f6c6so11090797b3.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576277; x=1703181077; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dhumto9kQUscxvj9SV+fwR3aQIV1lphNiH3haeKQx6s=;
 b=Ovu5SJCgG7OTF9Juzva5ghC5m6xpXvleKpoNrmezURpcBC2CEuWYRCWOIlJKNj5z4x
 A6gfeK0KTQAszke03o3x1F7HCBl8C7fOPfAO1Ei/ptmqnKL1iJ7DnFNe40yfs2LRdRoe
 cVdOa7W6R766EdIn7YbAXA+rBDGAcB8mC7jmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576277; x=1703181077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhumto9kQUscxvj9SV+fwR3aQIV1lphNiH3haeKQx6s=;
 b=QLwVowk7UTj/oM6ljr+P0g/Zn+kZ2HE+SfYy9QmsqNx6rqi4al0BF5bM7sh9N3GaNo
 CiQb0Qd497oAGnQBMEgl+KZfFYtYB55fGVvYwVdC1wn8MFsOkPNBikq2YPALm3CgGvYN
 Q7Uyz5tIT/mNPDPaAcThO7TH0USUiZqjylt69/t4kHw+XoiyzIm4blwr4xe7JTG0qiDW
 v/vk8bz/YfoQdhONsI2D1c1uG5+P7WaIApj6wagN8yd7iI8xvzjKQZXBJqSfiQg/XL1Q
 z+r69iExx6Vsf5wHoHFhWyZokwUYjMGXQYoD4UUbEqgky/ELyo4aeZ9OINg0gSd1O+9S
 X9LQ==
X-Gm-Message-State: AOJu0YzriJtecIQBd94P83oO+8PHC6RWhyf+9GlxuojNt/g1X374CWBz
 /cdt8ZK1akQrDpHC3HQ3NymCJw==
X-Google-Smtp-Source: AGHT+IGRSohaNJm/f7QvUsN6K637W2O8AYCHiRLqha6QPYXLR6JyRZtjLgQiwW5HHeebv9SOfd8Pjw==
X-Received: by 2002:a0d:f883:0:b0:5d7:1941:356d with SMTP id
 i125-20020a0df883000000b005d71941356dmr7400850ywf.84.1702576275239; 
 Thu, 14 Dec 2023 09:51:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 v126-20020a818584000000b005a7aef2c1c3sm5671713ywf.132.2023.12.14.09.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:51:14 -0800 (PST)
Date: Thu, 14 Dec 2023 12:51:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Huan Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rick Chen <rick@andestech.com>, Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Thomas Chou <thomas@wytron.com.tw>, uboot-snps-arc@synopsys.com
Subject: Re: [PATCH v2 09/21] bootm: Adjust arguments of boot_os_fn
Message-ID: <20231214175112.GD2513409@bill-the-cat>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GaDOJf4bHE3UnQWo"
Content-Disposition: inline
In-Reply-To: <20231214165112.2182274-5-sjg@chromium.org>
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


--GaDOJf4bHE3UnQWo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:50:18AM -0700, Simon Glass wrote:

> Adjust boot_os_fn to use struct bootm_info instead of the separate
> argc, argv and image parameters. Update the handlers accordingly. Few
> of the functions make use of the arguments, so this improves code size
> slightly.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--GaDOJf4bHE3UnQWo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QJAACgkQFHw5/5Y0
tyyINAv+POziLFwuUAYLAFKNTlISdkp5qpG7Evbxa0U0F/r2nvvLKcLuFWT3AELc
zdygQaOt7nMfU1o/WvREkdFnDauvD7EGZ7Z7ZHIno/sZb4AfzzfWgNHIDUPuEPUp
AF7AHFN2pLfxDwd6P9UQX7ZlkTFQpaoSwK+K4WOfcosGXESGRqmljXuY8ry+5XQp
wcYHLlg5tGfVbrHzzUDYKF+cmqjiJAGhRKXd1PKJmwxtQ0LIlkD5Jb0mRLdY/j+S
lR9DQZX3zOURVDeV0dhs9aqyrjofzrHOD8xg6uDvyLEjErQGpfqZ8JJyXq4vC3rd
l8b/fXEoN0rTgYGEDytevBB8egec+y7FmjwZuV37nqxnFr8KJMwehMQuwKgGbqRX
UG/hKXfUdPFGJJSAu+SRc3hoAbnzYjGmzi7y46Cz51mZUEqBxALYazfC4i5O2/q+
C+Tf8TaMqwDimkDFLxDQdDp9SYIFySN5XuGdC4L18hWYm/+PMFZG4ixM83v28fUQ
DaLK7CDD
=bo1N
-----END PGP SIGNATURE-----

--GaDOJf4bHE3UnQWo--
