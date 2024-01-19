Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EE7C47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E4987D29;
	Fri, 19 Jan 2024 17:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YCjwSkVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612CE87D23; Fri, 19 Jan 2024 17:08:44 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59FF087D0E
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5f2d4aaa2fdso10016307b3.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680521; x=1706285321; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a4OSk98jVd7Fl+5ZwUKN5eQuega+O7kHFcJ2VQJgkEc=;
 b=YCjwSkVeJjCUgvf4NZM4KXf8ZEfr7oA48mr0hp0J2oPzFnoOJ+vp2wcXJympyPuJs4
 2sZvvh6F44itZUQzj1HqktsB/+nTrf/1oG+5oqyszYAXUNAiIZeneIpjv2MdN3yM8bqB
 s200+cyjhxdOBGnvrBKCr3wpTMxeKCW4i8OKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680521; x=1706285321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4OSk98jVd7Fl+5ZwUKN5eQuega+O7kHFcJ2VQJgkEc=;
 b=qzOkfsdpZqBgTxrng4uQ1jcmmfdBsYinM4x0vGHYu50dbbt/yvtYeJOwT0j6sO/t6J
 6Mb847KqRI88W8dO1IiZmFPJND1SzbMlcyiChQYeoJWwOH9Rxeq1DYwq2El6vCgFSdl9
 9/VaxotTcPQzj9oRcou32pkxsiTyNg/siTT/rA/EAgitXfA2V2u3IWtWZl7J/EVdXxaq
 nAhzPeYRK4H3LSeZzCX6ti144VLU3jvKwLsDOxJQtuQDdC/t8brsBNhNX8cuzMq6h7L0
 LlJtnw5/q1zoJXMDlbUSE38hUTypojrD10l5NaRflpbZUTkwS0OX/svK+/WjjC+NlmoC
 YHxg==
X-Gm-Message-State: AOJu0YwZMtL3ZBz3RaCLZfeycRoD23Cm5j/7seqg8E4vLnWXGP3l0tLZ
 bGu5B13dFR5V3i4QuktKk25bgkYlEXWgu97ubz/AsqZRtqyVonDBc5zc5hLZSdk=
X-Google-Smtp-Source: AGHT+IEDWeZhAJkMn5dJZ75u2yxyPJor2Ml3NlgKgDHplBjIGcyd2vuPXa0T/0PYxUPRaaj494/lHg==
X-Received: by 2002:a81:4883:0:b0:5ff:9a11:ac01 with SMTP id
 v125-20020a814883000000b005ff9a11ac01mr95547ywa.64.1705680521143; 
 Fri, 19 Jan 2024 08:08:41 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 j2-20020a816e02000000b005ff9c1373ddsm531571ywc.88.2024.01.19.08.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:08:40 -0800 (PST)
Date: Fri, 19 Jan 2024 11:08:38 -0500
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: sjg@chromium.org, vigneshr@ti.com, bb@ti.com, m-chawdhry@ti.com,
 alpernebiyasak@gmail.com, nm@ti.com, u-boot@lists.denx.de,
 vishalm@ti.com, jonas@kwiboo.se, sughosh.ganu@linaro.org,
 lukas.funke@weidmueller.com, fr0st61te@gmail.com, u-kumar1@ti.com
Subject: Re: [PATCH v2 2/2] tools: binman: ti_board_cfg: Check for linting
 problems
Message-ID: <20240119160838.GP12635@bill-the-cat>
References: <20240105113917.1117945-1-n-francis@ti.com>
 <20240105113917.1117945-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gtjTpDz7lTUG5Iqp"
Content-Disposition: inline
In-Reply-To: <20240105113917.1117945-3-n-francis@ti.com>
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


--gtjTpDz7lTUG5Iqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 05:09:17PM +0530, Neha Malcom Francis wrote:

> Use yamllint for checking whether YAML configuration files are adhering
> to default yamllint rules.
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Suggested-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--gtjTpDz7lTUG5Iqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnoYACgkQFHw5/5Y0
tywySwv/blRmCQhrcLBwG7GjQ1ZpMJzemgVX+MgK1Da3mtoUNAIcSUFXGe30JVGy
zzVsf12qbBj/KMVui4A2r70kIn5ckVh4Yega+YPYq53TI5sRR9iEvkVZWDFCPkq1
S6DGDUegYUm/a/T2O1ukXmPTQlMHGeHMBiC4z5/aUUW4vZ9TQoMjkUf+a4rVow2O
t3E38SA4EX+yDVmKCZ17fncup9X086uyPfQql5zuBLF64JiKObUWiPOkpANlK87m
g+8kCsm1GL/PHCjhCeCRgFMXKbr2UfvKf34XEmAM8ZWhwUuY+jIn/E18hOkXlu7j
QSGlnZ9uAbE3Ix6eNNojFY6XZZFE2xywyTOLW79TgbCHSy/Ex8kW+Eh08abhrt5M
ggMnTZOjnHlFLIP+wH3/FlsgNg0uAet9PvIJJ2mV0O5PIDYaWe2w/XN9ZHpsu/f2
qoADmHEnQUH+B+gLcsIie1dRduUKz+NZi9jC15OCg9WXNCtPWpQ7bGSMp0CX7UTC
wUTKKDQa
=G0wL
-----END PGP SIGNATURE-----

--gtjTpDz7lTUG5Iqp--
