Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BC7E7FDF3
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 01:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E555B83F86;
	Tue,  3 Feb 2026 02:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XbpdQxv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 274AE83F8E; Tue,  3 Feb 2026 02:06:46 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B364783F54
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 02:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7d1959ba05cso2196395a34.2
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 17:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770080802; x=1770685602; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gnNEYpkjuEueHUfW6WtSNxiqpw/p7C2dutLz9zUfMrY=;
 b=XbpdQxv+lFrYfSLwGoVSLC+np88PDP/vnBxCJqKtC7HQHpZ2Veq+w3kpHPKJKvxVcR
 26QPQwej01zo49ygvzMLIoMpT+/avmTeBo0662fkRouod+AXn+z+AZaSLbe2Z/kIgg5F
 YnV1pRRbpCcp4ADJMaJKq+oGm1kox4auDdrUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770080802; x=1770685602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnNEYpkjuEueHUfW6WtSNxiqpw/p7C2dutLz9zUfMrY=;
 b=wdemJfBMlZ+L4spp6vPnhSAdJSWOaEn3xmk4HtlPDUtpr08Fy5imtn5RpUMEfbV1fU
 U93Ccai+rib7JVWOcHaeC7oDc0cS8/yDF9qA73nn4/ah9R78ZXonSNrliRajU2NA6Wgq
 CkHzpY7FGqOXanOArUFtW9HMBw5WkppVIFrCpRxuZaNMy/dduWFRiiAZj/x67ZpfWcJt
 cJ5fyiG1gVILKVtI++OBPAbLNDUO/x6BhHKS0AgxxvFK73FuEQyQEfG+xvCR2VW58VS6
 rjzl8ptRHzDvtzX3LY7t3aLFspTLrxy3MGnPGS4B8TLxyHVXIF8/rWeP4GEFSxhC1Ndd
 NHxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfBdTaXSsWAXmy35hEDI9+tJJKJmIGwjyo/fbRxZyeLxRbQOcJe3wjhV9nc3wfKm2xNZ+JUMg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3FCJzGD7q+qy56gIKKC2+O9ghWWK+uVBrp4K7WvANavZMQgeN
 N1Zkb3nzZaqsoZ0Gz1W8m77EN3MqXhDvgPYQPNfGfZVPMuDHvVHxmv3eDEJ2P8i5uew=
X-Gm-Gg: AZuq6aI4TgpgAuR/tyUp3FeGuAvoY7v449xMPn4weUiCHJB5AUcHMY0rcnHV2wqqiSV
 orK9oi4Du2pIHBG1siHsiuxVXWShPyTZzjxszQD0UV+vp9Sl98yCj3Fy1KV+HNoP7zcfnKPeYbj
 49vQDcc7QVejhkAnP9Co0vWXVsjlqHgWHNJj0uEdMHxwhltt4EvzmBkopVlJMpvGzRuKDDKUqMI
 Ie9DomhMxLG/svZG0TWixx1HOXx95hQPGEROlmsqmqkp3OfG9WMGXyhmv4k96rZGkvQf2gQh9ND
 vF0jTbhwnCNSYZ8N5gSg6kTHsWwD0TQtnnHN5KIdkleLygYMX+GAZcsdHHjDuCoL0ogjFXC4ICe
 IGPxZ8t+p4xPQ7FhUQhxsbCK25Sby0lWkZaynXtCdzSdq7J+h8zQDGhxK7D3lWDaj4huSOVQkDw
 hQ1/5QQhGysZRJ24+n6zuQiRebbQrZEaQ+cHIhni6iT3HaKneewXE+Gs4BjbOoUTVnK4zaBi9Lc
 IPIKr/Bh8DJom2ButWs679SElMI4OLI+sPmxpo=
X-Received: by 2002:a05:6808:1b2a:b0:45e:f09f:6359 with SMTP id
 5614622812f47-45f34d405edmr6722342b6e.53.1770080802443; 
 Mon, 02 Feb 2026 17:06:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095752ef7bsm12542004fac.16.2026.02.02.17.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 17:06:41 -0800 (PST)
Date: Mon, 2 Feb 2026 19:06:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH 1/3] gpio: Add GPIO delay driver
Message-ID: <20260203010638.GF2603314@bill-the-cat>
References: <cover.1769086229.git.michal.simek@amd.com>
 <6a6cd2da427e13bc69d2e0ae4070b715791be02e.1769086229.git.michal.simek@amd.com>
 <aXxb7L03qQ3jdnuT@shlinux89>
 <de5823b9-2214-47ae-9b4c-77cd413e34f1@amd.com>
 <aYFRE69oIA9Dk1WH@nxa18884-linux.ap.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ebMtu0/XPCfv6xKa"
Content-Disposition: inline
In-Reply-To: <aYFRE69oIA9Dk1WH@nxa18884-linux.ap.freescale.net>
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


--ebMtu0/XPCfv6xKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 09:36:19AM +0800, Peng Fan wrote:
> Hi Michal,
>=20
> On Fri, Jan 30, 2026 at 09:29:49AM +0100, Michal Simek wrote:
> >
> >
> >>=20
> >> Add an entry for SPL?
> >
> >Why? I don't have a need for it and someone should test it if this shoul=
d be
> >used in SPL. That can be done on the top of this when tested.
>=20
> I see.=20
>=20
> >
> >
> >> > #
> >> > + * Copyright (C) 2025 - 2026, Advanced Micro Devices, Inc.
> >>=20
> >> Drop 2025?
> >
> >Why? Driver was developed in 2025 but upstreaming happens in 2026.
>=20
> I think the year should start from the day of upstreaming. Not sure.
> Tom may comment.

I saw https://daniel.haxx.se/blog/2023/01/08/copyright-without-years/ go
by around January 1st and it's somewhere on my TODO list to ask what SFC
thinks about it.

So to be clear, I don't have an opinion either way on what date this
uses when upstreaming. But it might be good for the project if we can
just drop the years, which is very clearly out of scope for this patch.

--=20
Tom

--ebMtu0/XPCfv6xKa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYFKGwAKCRAr4qD1Cr/k
CgV8AP9aQ4tYl05Wk98gRYEjEO0uJRA++RRbDlEXHh+BTXlWkgEA11DwxpVG1Fwm
cpH7YnaCd178FCyglfcCm/g5DxQEUwA=
=4wJS
-----END PGP SIGNATURE-----

--ebMtu0/XPCfv6xKa--
