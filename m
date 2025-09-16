Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E31CAC59B
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A2C18329B;
	Tue, 16 Sep 2025 20:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sb3Kd/tV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314D68329B; Tue, 16 Sep 2025 20:27:59 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9D183390
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3323a06b5daso1151007fac.1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758047276; x=1758652076; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TfCQ7hBGwNewXcn+bTJJwJCvdjbZDeJPrJoKAiwXfsw=;
 b=Sb3Kd/tVvbs4n+DjzO590urhiKiq+uSXSXzoKaAriZklFYsIKP0Dg++2ZmmjvmEO/G
 O6NVCb8iMs3sE/DqXoOn9FqFh1gTwmslxDqcIH1kcJ4QS6DyP6/532z7Eiq/4FiT2Zsr
 1WB2AnitAcpM+83zKww12w5APZWDC6Vs7PXa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758047276; x=1758652076;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfCQ7hBGwNewXcn+bTJJwJCvdjbZDeJPrJoKAiwXfsw=;
 b=BZgCEC3bVYGsqMc8weJFvD/7k6Ywaz8FF+6SugtjNSq0sUi958qZ2q/QxZpkYYQXj9
 JKYy67dSQco1BR2yhV/B/AAjw9QUhHybmRncyDeXSicIRElRCosH1JWg8xEkl6jBJykz
 jySm0aVDZ+84lya3af7hr/8/2hIQAbVQwVhNROJjRrLtxYWji+XO/wNAb5UmVfGQpo7W
 5/M7kh0/oeTTxMx5ZS4V3U6APftrB6AN1NtBD58yacFbTcMjiDXqQ9c/oKNZEJ9qpaVS
 YPY5Kq2mPxSgxRh8M5UPKUKj2fZOXAZGUSKboylD6VOXVyiUaRdB4QTTBy6pYk+hveJt
 1bkQ==
X-Gm-Message-State: AOJu0YwJ54f1up5O0hkuINZiVdHBpCNyZJyy4HLj9uWUl/akiWN2lg4E
 4La3oSCH4kkSCcDQfojyDgpTkarlcs6SpSz244RmhtIxb/shH1/xAXj9B0NMaNqoQK0=
X-Gm-Gg: ASbGncvA7RnFHDIbFCPRVZTl43ni3kH3OoAgCLEfywNiEOFCDsNEZbkKeoq0h6yix6x
 j6nEVp6wSg52NWZzOE9/dy0u3nfRKqdrQ+M3cRswufOg1WtWadsAdRiVv25vzZYPslnsRfRPJsh
 S33MlP03yhiMZyA6aA24V7bzfafgQB0RSb/YM35ikR1m5zOSgHE74pHx1zKeziGm4XXMyYUD8J6
 KPjl+KNQqZCPVfJ5BjILck1t481oylfGs8jImEkg4SoR3RaV3u65OFTFq3sH+YU07TnPe8n92rX
 ICTGo8rV5+fSHCLp4tqvpQNRqV3/1fg6xteyIlWrIHuR1yXhpjQmtoovyhdcSEsonmKBLbDY78F
 q2ktv78tXCTS08OUVZH1IUy/JQU69ixBWiJcEfdoSWYy+IW2/81imhyw7
X-Google-Smtp-Source: AGHT+IGX0/o5X/5e7pM4MCBuvwMIYdkpvHFgCAlI2it+GHEbM18bvt5mvV70qkXT0/OzzH307iWLLg==
X-Received: by 2002:a05:6870:80ce:b0:321:29a5:4e11 with SMTP id
 586e51a60fabf-32e578040aemr8943370fac.47.1758047275757; 
 Tue, 16 Sep 2025 11:27:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d357d2faasm5064275fac.22.2025.09.16.11.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:27:55 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:27:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 5/5] ci: add test entries for qemu_arm64_tfa_fw_handoff
Message-ID: <20250916182753.GB124814@bill-the-cat>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-6-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xlWmE2VQ0N5lzevn"
Content-Disposition: inline
In-Reply-To: <20250916161426.32259-6-raymond.mao@linaro.org>
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


--xlWmE2VQ0N5lzevn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 09:14:21AM -0700, Raymond Mao wrote:

> Add qemu_arm64_tfa_fw_handoff test entries to azure and gitlab
> pipelines.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--xlWmE2VQ0N5lzevn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMmsKAAKCRAr4qD1Cr/k
CsueAP47/G0wbA3HFq+7Gpe3xQKAa35PsK0gqks3qtfI6bJtWgD/YBPJPVWmQV1g
r5V5jJzh1MAOjBY3C73Zsa3Qx1uhOAw=
=4OlJ
-----END PGP SIGNATURE-----

--xlWmE2VQ0N5lzevn--
