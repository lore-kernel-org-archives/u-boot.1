Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086B4C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFF7829A1;
	Mon,  5 May 2025 15:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FFI5PKYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D607882991; Mon,  5 May 2025 15:45:54 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DA0820F6
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3feaedb4d2cso2956107b6e.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 06:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746452751; x=1747057551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zvfd+7sRAuNmHExgjXEo+Wxm+hrSJbR2JWhAOSKW+gU=;
 b=FFI5PKYKPfsEZcGqtSAULsZmwjHRU0T2xPT6wIzL7hDkgsnOuIYP7Ek8mIktYq0E30
 UXn8xQ86zbAzwwQwzW6YR96ncZLxA71Mmmz1xt/KTEIAch7UJLtnjgsvXzsn8brruKqr
 TiSjtwHbYqRvsck7m8sGrRmd/H4Nj/JFdDQkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746452751; x=1747057551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zvfd+7sRAuNmHExgjXEo+Wxm+hrSJbR2JWhAOSKW+gU=;
 b=HaQmbL/YaRdrhlH9cIHLB/DEkccp25bzGR4BteBASc8XMm5xiO6WXy/1p3wPx9FgGx
 bl3YVB+Bpth7qV8Pd44IhlJRskbpt2RzGGKJLgBGeXMQiuV2xqmjZcTsg/DZ4cO5ZgEk
 EaAokQYW9Mg3KGrUI+fP82ysgx0+uhNHrVez7vqBagKF0uzY2l5lhX6VmEFOn6JwC/Pv
 vRGAFts1cTEjq1B+IayBoGkjEDp3hB8ov/wBTYTZdWncTzotrZ89uUsNI3oyPYcClNbc
 2mUAdWuclQVhkhxqVbbLiHGvvR2d8kRZoiImKIk2SFVS6PUwhEvkSpg3rcY3W3ke1eBS
 C+DQ==
X-Gm-Message-State: AOJu0Yz9A8zak0sUe/BNZwZPy0aqpCmxqPC4r3Fx+T4CE+TgaMly/vGi
 6oCuRmpHEl+N0TjVgJcAGmeiaHd4GrRwvRDMAPl5R+S8xZv4AV83+UZlALlPUAU=
X-Gm-Gg: ASbGncsFIbA16wHCySSIsBE8iMY49H4x8jWvvMJfsaN85zng/J00ce1ajybeIbk3GM5
 3aXeBN5In3jGwQNyWjpnbPFFPFxhLHByn+Sitv8fVig9Rx2715JOrsMqA8t6twQ72SJcEHfWEUI
 LFJpC5jkAV8sDVrn3ix12Sc/a0t/zZV2LBt3C8IFYzNv+WJl4dPZ5hr93Fsa196DsR1Rz+P2NNC
 N4zo8QAeEsyL/e6yECIuGRe/3GKOfUQcViqNovaZoXBW7pEASeFebfOwYg4ievVDZRm3+ITZRgn
 IhHHxCAx5/hWHH+HHITI6Iq1MHfwiAKFtaiwCwGAO+fDPI9H8NEdZXb9XUBfY/AEATkSO5dbWcD
 GbA==
X-Google-Smtp-Source: AGHT+IHULC6cgrLmjGFczC/+c2OkW5q9gQAFfS3qptnvIEvS3Qn+pIRCPn2RlaeYLjY4wZmcK93mMw==
X-Received: by 2002:a05:6808:1801:b0:403:2a0c:b273 with SMTP id
 5614622812f47-4035a5856d9mr4308971b6e.23.1746452751419; 
 Mon, 05 May 2025 06:45:51 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033dae382fsm1837097b6e.21.2025.05.05.06.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 06:45:50 -0700 (PDT)
Date: Mon, 5 May 2025 07:45:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Eddie James <eajames@linux.ibm.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 1/3] boot: Add a function to check if a linux Image is
 supported
Message-ID: <20250505134548.GI1261075@bill-the-cat>
References: <20250501131858.2160756-1-sjg@chromium.org>
 <20250501131858.2160756-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1JgC2zcj9MWTSHRE"
Content-Disposition: inline
In-Reply-To: <20250501131858.2160756-2-sjg@chromium.org>
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


--1JgC2zcj9MWTSHRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 07:18:33AM -0600, Simon Glass wrote:

> Move this logic into a function so we can give it a sensible name.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--1JgC2zcj9MWTSHRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgYwQwACgkQFHw5/5Y0
tyyWxwwAm18Tc/NyY4l8wwZ+Ltabad2aEeH+ezgRIBU+d8B7vBrCn4Q5cCV/2xep
SSWU0Pus8jDxfKPbHsCLgiUGMLpDeT8Kj48DfUFEaKldvHwJXvzJUA+nqG65oM94
UbDRp53NOxP9hOBkzFq4eJV4D/ITtUnqJC7kbdRmLhT/8Cj2fso9TIjuDbqsif48
gXB/Q/dwLxuJcw80hkAhtPFuWSDFj7rdPm0fdR+uycGTmhXz5FDyRDhBq6L5PHLd
tszheutS3MbJxXVtfUSO+Jhp/SIgUkoavxELamnUBB6yNfVpokPMBm+CgRpnLkIB
x2Pb+3BgW+8ewuQbdKyW5GF6JLdtvTb2C0Ztbvl31H3ay+F8uulGffHOcQdHsK6e
tEwHqBau3LCpVP7Hh6HiKTSQ5pSAM4DixrvhxBx563HqrHhJHHQiN1tOcxvDBezA
yCoqE28Z4HTuulLNzlftJI98O1EwAu9hun1u9oXGXxpCTpoBbDx2/JsxGjYeBGIF
IKC6SNGV
=oJHU
-----END PGP SIGNATURE-----

--1JgC2zcj9MWTSHRE--
