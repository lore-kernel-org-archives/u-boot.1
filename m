Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68F5C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 16:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 224FA86F6E;
	Tue, 14 Nov 2023 17:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lDYMgU+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 785078714D; Tue, 14 Nov 2023 17:31:57 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5826986470
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-66fa16092c0so34648816d6.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 08:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699979514; x=1700584314; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JZMgla21+SsO7et1ev++NmopIGpxTZbIYVP9gVQRyvA=;
 b=lDYMgU+eaQHRMMi+ThlcTK6O1rT7wqu+5bC+RNtU3w+TFe+/GtE2NJVSl4PLH643we
 KIfNbFfTj2jEAcmFx1kDduowHQXHMATYNSxPIo8ziWw66cclt5uhZqvgv4/HPmGTNU8z
 0yg/C3kB8ylPMOSgknFpj/s0m4JEdROAytmBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979514; x=1700584314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZMgla21+SsO7et1ev++NmopIGpxTZbIYVP9gVQRyvA=;
 b=ef9LB2+bJKAIPb8eiKgoz8xlWNaT6A9vKy4OU+/8LEU9J6O0a7dySrxV4SG5yHHcUK
 nuMmfdR3JINEtoyRTC9b65paHnof3cZNnTuShhvNLngCOpAIxXrotk7kkzCfYd09zF1R
 5VUNt8tzmOeSe9T7Y1363IOnlthRqzBWDTXQerJpktqcmKDRgqb4lJDnNWFBoVV27TrG
 oyxrhEqUn4Ih6hwAApO3haWvzmFYnIbFiHmC8ECz8DXqn5aUIT/7lTqyl8SywZvxZxpL
 3czZIqwjE6ahIdxFwFdWBnB9I3jYb4/20fmthM3n1ReihoPWI4GgNq8/0/4IUdHsHu1c
 XH6Q==
X-Gm-Message-State: AOJu0YwTKgQX4SPRFYMh2BiWkoT8RpDuA8rZT4xc3/VkVtUUY/dz525O
 GaRUUbjGjzzdvvTkOP9H2JmUoQ==
X-Google-Smtp-Source: AGHT+IEa7R2ertnvzbQhGVwugFf0Ts83WjIEMp0Dw6IYEI9GgX3jUIhCgLa60VelSOHQX3SYXmk5RQ==
X-Received: by 2002:a05:6214:2488:b0:66d:1244:cea5 with SMTP id
 gi8-20020a056214248800b0066d1244cea5mr4497096qvb.46.1699979514038; 
 Tue, 14 Nov 2023 08:31:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2a5c-a31a-8ead-8e73.res6.spectrum.com.
 [2603:6081:7b00:6400:2a5c:a31a:8ead:8e73])
 by smtp.gmail.com with ESMTPSA id
 cw1-20020ad44dc1000000b006648514e276sm3005358qvb.78.2023.11.14.08.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 08:31:53 -0800 (PST)
Date: Tue, 14 Nov 2023 11:31:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v2 5/5] boot: Don't allow kernel_noload with compression
Message-ID: <20231114163151.GW6601@bill-the-cat>
References: <20231112035001.103897-1-sjg@chromium.org>
 <20231112035001.103897-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1TCzWTb52Fi1LjK9"
Content-Disposition: inline
In-Reply-To: <20231112035001.103897-2-sjg@chromium.org>
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


--1TCzWTb52Fi1LjK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 08:49:57PM -0700, Simon Glass wrote:

> It is not possible to execute the kernel in-place without loading it.
> Detect this and show an error, to avoid a crash.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--1TCzWTb52Fi1LjK9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVToPcACgkQFHw5/5Y0
tywmuQv8CuDOyxNM4PjGEfWyasmIOe0FN95JXOAQW6iJMhAR6k2BjEexx9LFMRWr
qMRPyptjmP4erUKrtseY+DkFRGRIhaIH4Z/B6f8ZtI4S7zkfm1bTbj9IT6Q0K9Ra
VxzDfqJfy2j6xnbWwKzzjN9Ki/RVmJyA2buY7rpllP/nsKaYci19D6lePHg8B5Sh
nT6akqe4/52WXo2WVm62HzKfoqfVZqc0VPZGwTkigFlhDnj+fGsPkRbidAnQAZxq
3MFEMZVT1t3A7jgfydO04cadKlprLekpPQ1OVhYsF2YFdsn7PCVvQEiJPQ2kxkLe
dAVrg4vM+PinSNDKZxwA79+brse8Fo1OIvM+rCLfxR9k6wbBYB9PZCZwK2IcTWFf
NZ5XbPnTfuTrujYeVFU+IcB88UGFuf/p6fLo7PjCGdZhr85LLRYNBM7bAqCzI5L+
SibJRCiu1Eip71AYMlzAGFWQj4GTajZxgAGsipsvP6DOV7KXwKCINhcRR/CU7XYI
ZqseZc7D
=k06K
-----END PGP SIGNATURE-----

--1TCzWTb52Fi1LjK9--
