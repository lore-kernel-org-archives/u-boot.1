Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC23D15D9E
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 14:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DF488895E;
	Mon, 21 Oct 2024 16:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YabrJ4Vy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8093088EAE; Mon, 21 Oct 2024 16:33:44 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 726CD87F7D
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 16:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cc2ea27a50so46376596d6.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729521221; x=1730126021; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uAbYzekLl+vNUN72RsO74YGZILo4mmJKdJ6EaBRRSj4=;
 b=YabrJ4VymZcCA/Du1yQQPDNi8Wq3Mjv9U0a6k91R1EHaape2pO2ZHe7xbU/FQxbYMe
 /tyzuY/Ym4AdkG2DopThePjrbdjxY9JePoYs9SodVlU11jx3UlNyRwOIrX4gMlmWMLTH
 VDGrMxvj7bH9rivmhmOgO7ZmLdZQQJvi9p6Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729521221; x=1730126021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAbYzekLl+vNUN72RsO74YGZILo4mmJKdJ6EaBRRSj4=;
 b=DxhuBNmwEf0mHuUhDfsGyWNfdHaKT4YO58jTZ/B9Zq1jOCOneAixfCfju+0kLVaV45
 yw4B3DMTmTMXpqEAheU6VmxkEPTb1lUpTneWfXzLF1sm2btujNQyGeoiQQOrfagJh7JZ
 I8rwb+nNengCWNFS3aRJKsuP1bfUwpbhwJTnSJaJpIlE3F6WuAIUuSEwKKmM3W7c53VX
 euDR1K5rndRfmvFvwFzk2BdZAvB+VQ8W1jpJ+9G7dl+wx9XGC3tmABxi7PdQ2Uqx3hzY
 f5c4QFPTUY5sZAVeWu+moSB7K/DNkUsvl79oxlPSrGPj77xHrAsm7gbmfa/dtzbsTuUZ
 /iyA==
X-Gm-Message-State: AOJu0Yxfb/UCGseV4mAI1rM2iIg8TYqrKDOBw2kSrgDIr84jUUKtoUFc
 WZgqLJ1UeYI2wc893FqVYjq0n/MzxdFv5JV85y2a939tIBdonY4j7OsoN5yNGe4=
X-Google-Smtp-Source: AGHT+IGkZlM6ydzIYfgBOI25aKRq8JIJyUOCmNJ2mFGlvkII9dAj57Ze7UPGCX+g7tf2dZKqtjlv8Q==
X-Received: by 2002:ad4:5f4f:0:b0:6c3:6477:16e7 with SMTP id
 6a1803df08f44-6cc3785617dmr277217486d6.11.1729521219796; 
 Mon, 21 Oct 2024 07:33:39 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0091e5b3sm17480906d6.65.2024.10.21.07.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 07:33:39 -0700 (PDT)
Date: Mon, 21 Oct 2024 08:33:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH] CI: Add a test for building without CMDLINE
Message-ID: <20241021143336.GG4959@bill-the-cat>
References: <20241021134450.22985-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GnDlQ1XLSx9DKiEc"
Content-Disposition: inline
In-Reply-To: <20241021134450.22985-1-sjg@chromium.org>
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


--GnDlQ1XLSx9DKiEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 03:44:49PM +0200, Simon Glass wrote:

> Something this breaks, so add a test to keep it working. Since sandbox
> enables a lot of options, it is a good board to use.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  .azure-pipelines.yml |  8 ++++++++
>  .gitlab-ci.yml       | 11 +++++++++++
>  2 files changed, 19 insertions(+)

I don't like this because "sandbox" is one of the longest run-time
build options due to all of the tests it runs. And given how we break
down the jobs this will make a further bottleneck. Can we just disable
CMDLINE in one of the existing sandbox defconfigs instead please?
Perhaps sandbox_spl since that only does SPL related pytests?

--=20
Tom

--GnDlQ1XLSx9DKiEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWZjwACgkQFHw5/5Y0
tyytNAwAhKs53u6JJwHzPNhFrjQQNggVMJr8ySDBulIozM/gGceWFklb4d0Qr++x
6lpjoHjKxpPVsYsXun6l+osw+NEJA7hI1elG1OA2ajEmQQr9n/XDlI+UM/4rTP4U
s1W+kGaeW7mxahWet00HUE5v1IJqrmhOcubd8Ia23dNEB9SIv9t/Uh4veMuCFULG
3Yib7snnMQ7+lNp6oEn954IZ9TeeNHrHhoPmFbO0mxLZJAdHj61bCuYcWzh7hMcn
hZDlI1GOt34aObDT7RAAEwB2RgkDX/3F9aB9AGHTn50OA+HTm1GxyzFst7HrF1Rk
JpuBw4T633S2wxXQUj3r96gyrB6P4/fYORUTrFzZB5lUc+aLRru82JJfbn8DpPVR
A65gflTtFXeiiE/OFx8/hDqPvL/riEVIi8nnpUFs0IemxPIjuK7qUCg7tBmt3keU
AFCTnMhLaIskpG1KOpAwHGixZr4at7Yy7+kp2G2JkeGc/QEu2B2r+3DyQeBsSaEC
CwNZEjuf
=oVpn
-----END PGP SIGNATURE-----

--GnDlQ1XLSx9DKiEc--
