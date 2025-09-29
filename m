Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C091ECAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 14:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2303483071;
	Mon, 29 Sep 2025 16:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MXCGy9gK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5054583071; Mon, 29 Sep 2025 16:07:49 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF1D982A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 16:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-74a61973bedso4474777a34.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759154865; x=1759759665; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uOKijwT33iUXsqC6bDS8Mnvdbz3nAwj2YnHfu3QI6KU=;
 b=MXCGy9gKmWNdray59F1KZSOIFrBRX4dX9+CQIdpXNIozD0DfRsCv1B6z3AGnZryaa3
 WvJOr5Vay7dStG5fEtM2hOz5JyXcQ6YAzfLjl4lHglRJiMB6JMZMhN9iVl1gIW7V3lCw
 VHLMfft6p/AZ9YIsHZyfD9RsM3lpP/XXcq2g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759154865; x=1759759665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOKijwT33iUXsqC6bDS8Mnvdbz3nAwj2YnHfu3QI6KU=;
 b=Qu2Be6zR27YAznC7lTavkZJ8y6qMweQ34v5LXmmUVKvFprvDUNB6L8zhiXXEZ0AjQD
 bEvtUQyFA/jzxXw9KiCw9WzR11k6KjqMpim6tQaeIDieQOyR4fK/ZhfhadUjqA1Gxq5N
 C0Ex6ydgDEopNz2SIW9oZTyKGHEmFdEaRTRXJs0BqBa/Int/FSPNtQzLep1zZmK2ML/S
 +SdxzRMVZQtmbx1DFn9F1Es74FMBDUXUf35AMEqtVvw8r7tGvbNq4RHp4Ir/UhiZtLGx
 0xMF8ro7770/Fu/QQdC3PZfiXrUHfy9ACf+aqAl7HaTcLYFHzcs7OxOsUBr3Oods1Mev
 /55A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5dbeWiFi2rutqxAA8w5VKV0ubV2syS4YS05kR2Es/l8YNoqH7r3wyaIUhvHqd4sWWmxRyZmI=@lists.denx.de
X-Gm-Message-State: AOJu0YwebsHaDj3Msjie2eZ3b0UEKk5GUlv4oajtT0Q9bZZDCtmNT7Ot
 C+1l8Lf5CiW7dDwTMacByyu+SD/dMr6eeoRFqaVCy2B8kXvC/67R7witUqUxhF+OWjw=
X-Gm-Gg: ASbGnctsANHdo0Y7zilGDHUJlPsB7iWgQWGr/72tJRv0IJxkU3SG7qm/ln01+K6i/L5
 v8oHhRilMZGrhmkPn206zlAiyv5Bn8/PxsuFNn9A/vLZTGEWYqcIGeThaK+9wYybcrRorrei1fR
 F4ASjMXPcAF8HjtKWewZKJKbuAAGupJcJ1yZqyhwYbtwHRa2S2leUrAfgh1VAdi6COZPgI8A2+f
 pi+JHgJHlwmDHs45hBbnoLU0Wul4kSaRz+CC4rJrrnpFnqEq6NnFQQ3x4+J4PHFfOzsEdM/3Itj
 RnlGpZSyLYs923JHVmYYr6VpEWIK7k91dUuizWlMeYrq2dEXx5GaO00o/Zy5cE9qr1SdqofG2Jp
 V34yc5sRkgy0nFxvH6Y6sElfeuGYQ7ZiSMjlv09s5iMvXAafs9pABwVjaSX9nXiALyK8=
X-Google-Smtp-Source: AGHT+IHXCcXQYIrS5IXh6LbPfcSjwdtk8yuXE8wpWSVhaFDOd4xBwK2Tha8E4+mmmPEdgOQrjhfPDA==
X-Received: by 2002:a05:6830:2b14:b0:7a2:fe20:edd1 with SMTP id
 46e09a7af769-7a2fe20f074mr7943060a34.14.1759154865218; 
 Mon, 29 Sep 2025 07:07:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-63b27214bb4sm1074595eaf.17.2025.09.29.07.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:07:44 -0700 (PDT)
Date: Mon, 29 Sep 2025 08:07:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 git@amd.com, Anshul Dalal <anshuld@ti.com>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>,
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] xilinx: Enable sntp command
Message-ID: <20250929140741.GC6093@bill-the-cat>
References: <8259ca2496dd8f6a25df566c43f16be019d75cb9.1759127081.git.michal.simek@amd.com>
 <7ab73b44-8efc-47d6-9e6e-5ffd9ab0e3d7@mailbox.org>
 <cbf26fe2-1267-4965-807b-fa0805e61bea@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JTM296KkohM0CWOd"
Content-Disposition: inline
In-Reply-To: <cbf26fe2-1267-4965-807b-fa0805e61bea@amd.com>
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


--JTM296KkohM0CWOd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 02:54:17PM +0200, Michal Simek wrote:
>=20
>=20
> On 9/29/25 14:13, Marek Vasut wrote:
> > On 9/29/25 8:24 AM, Michal Simek wrote:
> > > Enable SNTP commands on all Xilinx boards.
> > Look at #include in configs/ , that should let you deduplicate xilinx c=
onfigs.
>=20
> Good suggestion. We have actually started to use it for mbv defconfig in =
our
> soc tree. It should be sent out soon.
>=20
> The only problem is to keep that config options aligned with Kconfig layo=
ut.
> Maybe you have any trick for it.

We just ignore doing a "savedefconfig" style sync to it. In the context
of manually managed files, which these fragments are, it's just
cosmetic.

--=20
Tom

--JTM296KkohM0CWOd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNqSrAAKCRAr4qD1Cr/k
Clj7AP4w0YqLds8nmyEX6ujP0eYxcfrKYW6iSeVH46U3ihLExgEAmrwSIhn6kuES
IbtySKUl9etVkKMrl8GOTk+U2NhpCgU=
=jzXm
-----END PGP SIGNATURE-----

--JTM296KkohM0CWOd--
