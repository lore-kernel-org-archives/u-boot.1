Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EADC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 21:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 339F388CA8;
	Mon, 19 Aug 2024 23:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b7OiRlGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E88288D0F; Mon, 19 Aug 2024 23:04:45 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D4C588A82
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 23:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7091558067eso2000421a34.3
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724101482; x=1724706282; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AN6qEIvfN5+FVn7oj5Fiiy14YIFTvw0IlMfFFFo0lY0=;
 b=b7OiRlGdBiHskq/nuQ67DBX6l6LQ6xr9gzLKaD49E4Dh6AhtZ0FP0cq+EF729F/2Fx
 80z9JkwFpd6z4QIebLtJNV3oTRYVLOyyFaLXlYufL+wMgmio1iaqebUqikjUjQfLX9LH
 2thz0SUp7vvm1X5ztPS+ZSbenTuFAJUgVu1MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724101482; x=1724706282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AN6qEIvfN5+FVn7oj5Fiiy14YIFTvw0IlMfFFFo0lY0=;
 b=bzP9/8FGxxHe8pFeXTI1CUb9fy6HHEaJ1CnXjzVLNEmKCaMJI1UngoiDc2FoOuM4r3
 ZD8cCxpMiz3Cg69Lqm9JL8iZcfcDMuOHHOFRfiAIzShtYtgxnlQGLAmfKS+0RNFn5BU1
 V1Liv2JRmnOeU5lMYTezdn501LVOev1wabsJsx29P4266H2bLsdJ5BZJZg4s9+6OGO5q
 eA1zKc9P/XKS7O3U++ZHq9CGJnMCk5Zya10gzaTnWtgNpoOT4TRHiP3Fj4PwGyuE0Ygn
 q7iF1+F4QgwVDRAe4ivihYV5c2e963+6TXY2R67yok7HHDNUPjM7dVxPdypdAP3j9GWK
 KR8Q==
X-Gm-Message-State: AOJu0YzIIdx6Zv5EQ9cwD4X8z7S3hxiuiYRH09YfaDHvckfpz8gfs0lU
 ZWLuH331lSmLG/UUvjJfjJXsF4lmZjvPY4qD/bCoSkQjUMhbvs1msIG28ATlwZs=
X-Google-Smtp-Source: AGHT+IEKET1kfUTRWWCQVBISNOPXk99Wki013Hc9T/vjXL4FZv4DPD85F+dev0h/IIFOCmto6IpDKg==
X-Received: by 2002:a05:6830:314c:b0:70c:a98c:4d7 with SMTP id
 46e09a7af769-70cac84515emr9978386a34.9.1724101482005; 
 Mon, 19 Aug 2024 14:04:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca662064dsm2429694a34.64.2024.08.19.14.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 14:04:41 -0700 (PDT)
Date: Mon, 19 Aug 2024 15:04:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Andrew Davis <afd@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240819210437.GH1626301@bill-the-cat>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jqmMF80Dd8mBNiGc"
Content-Disposition: inline
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
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


--jqmMF80Dd8mBNiGc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 02:43:49PM -0700, Raymond Mao wrote:

> Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
>=20
> Motivations:
> ------------
>=20
> 1. MbedTLS is well maintained with LTS versions.
> 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> 3. MbedTLS recently switched license back to GPLv2.

Whereas I think v5 did well with global build with mbedTLS being the
default option, v6 blows up so many places.

--=20
Tom

--jqmMF80Dd8mBNiGc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbDs2UACgkQFHw5/5Y0
tyxuBgv+MbEjS4qZeB2Qq6tSY8ma2LdtseYVk06vkkgVy9dBKArY6c6yX+FP0wdR
2BVbb3s3MFu5Byd9LUrKpoyYlZ27rllML6hZwYmkK/uJSi40bJCyPr52s98KcY/o
D5l5+uE5RhpW+9AaXGUcFXtJvnIHnQbMuTIANOb55u4A8cIaMhnsFrfJPte3vTM2
RpyBsKX9RMDTAzQvBz6eKOIl5Iblt9MxjADABd5KinR/0UeZ2mwAfS0ZyPuS1+PA
32sLnkw+z0NqxVGEKtr70hkttUrGVr3VZDR6TkpCs6Ag2jknD4NPdGJi3qYCxK6c
lmFc1cpNNiAHIj3/6sNbV6yobvrobwwah3yXhwLWPMEJ1llp7ES6f9SjBzisyWL2
QOzmTJFdZRaPz3eWh+GNnTiGMdL+1Us1moj9k0VV165MxWTUsmKf9Ieh9RQPKpo9
/lP7S2/3Y3FwPazse1Sw15Y3+rgj8uSkD/AvYn/shZTaXxSvmjZTM16smn7gvvZW
IaAfSRUi
=O6Jn
-----END PGP SIGNATURE-----

--jqmMF80Dd8mBNiGc--
