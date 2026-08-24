Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0C9C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:40:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2129605F9;
	Mon, 24 Aug 2026 16:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xl96v-VZv48B; Mon, 24 Aug 2026 16:40:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589605;
	bh=MHKX0eG+OC0TyAm9dbImzzKX9PmgxLSjcLOswUv8H88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UpqZEYtgQko88qOsG7SS9Gv8tfs93NZq4puEDCu66tqlJjBjomA+bNnYdJhx7OtE8
	 UE6H/53dis92JHB57XrUAjQarStbMaqWpXpO92bcFZlt6h12r89b82T0R/vfTBy5XE
	 Tdwb2ieEUMjkpVMbHj4tcGP3o2qQrRVmDPveZNERxP8naq8Pd7evT+tTQwzyhCuPvS
	 uvU/H1XWjcdiI2lAIxIUwyznkP4F0wOLHZHF/2bQ9NuROGaCfrgQvCv7bmSG7lKlzX
	 m7GzqAPK5qbRqCSWt3dht4KK/3MOaWwV0TA2TZIaMgXeQdspLp0kJ6tgcmjxIH3giz
	 a+SYT++TqvX/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F12FB60606;
	Mon, 24 Aug 2026 16:40:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 32F92386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10F0960606
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:40:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UJ92dZVPXJbI for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 16:40:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UXEE2NbW
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E487605F9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:40:01 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-44aeefa1c00so133045fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787589601; x=1788194401;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MHKX0eG+OC0TyAm9dbImzzKX9PmgxLSjcLOswUv8H88=;
 b=UXEE2NbWQ0zKZ/WjMvjWfnBmVGvD1hh3ZL1GiBXQaEn95H+Oz5hHEda/1NbIyaVdYg
 Ru92QV2zvl6XtiUBGJ1V8HZDjj1DhD3fK1WTLaT6PetigCepu2ztQbgP5BUTk08PLiGI
 VcGKSS36BGsX1//IS1u/k+34biv7NtPpWZlEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787589601; x=1788194401;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MHKX0eG+OC0TyAm9dbImzzKX9PmgxLSjcLOswUv8H88=;
 b=EwmCSpmVeUk+YW+2aXxtN/SK3B1HS1Rt1DmZ2F+TppIrBVA5LgUIFOCiT2JRUklviY
 ugZ527l4hMHeHZRzJPBpQvjTWGEox9dRdAGQxJgIClCjt5i6Cq9XIC/XOUFGvYtWz80f
 t0jkLm8/DFC6keZcYmJkjAwZZ43ZEHEOFzxETV3jTv/d77wdjjrNGzolILC/I1t73kP/
 ZoOKltYI4A7fXMOPI9E63mf16iTQzCRtvizEYkaIyYV4EcLu2Md1PlbrKH1hLcYWg2Xs
 RC70TLSG5tUYDMT7lJjEwjlag8HoZMjePCjHBhoZmOq1amgDRjTNQaBR4nT6wctVi7dK
 c7aw==
X-Gm-Message-State: AFuF++kkhKOHVuEGkPFFK4ogmVtRNmjRXY4iL4IXFd8kaYDpycLHQa7f
 wyubKmp6KTFBOWeqSOV1C2dHh5UOdBeuoF9IV7YrlEMAEiVk5KsuqTjOS8qRwBeKe+0=
X-Gm-Gg: AR+sD11j3QmSr54rwZkPLW4xOk418ZJ8voOfbkhS343zhhWsf39nIKEHTtdOtCqlajb
 dW+Cx3BzEBdvMSu+EZRuNuY9u4e56JyPC2eZZbJgPeysQygDot23J+Rt5UrplEcog0bd03C0dWw
 YHhbGu/Xz5fmpbhRAP5+6CXYgGu9G6rPkdhodejnE1iVOBMJJDBmYgVk7A9BOtA8eIW15gpC1bR
 rY/X94VzpG4KrgVgNdJa5R2qtJx3K7T1UyHXYqygltjt2jFAy2YQz9F+BeFYQzRL6zlOShgatlM
 AQIzxjGsrATVeCJh4WvnMi+pLxeYHRVr/DNOcsh8Zgb8ErEqFT+AaGkti1sPoikBeRgFo7kO950
 +j0BIW0kV75eV7+jBLQPUmZUhIQKqW1KvhLM85qHgifeX1ctcJmyp60/kaCmGEMxVwz4TXm/HMC
 tAISR3OF5tj067U+ouem6O88rB4NehrCxTyMC2anASxnAufyZKD34isrWGrJKytiXCmIEOtjPVz
 AHcaJK1wL1JoUDF+7hwlUHNM4EKQZF1fX6BY2Zle2SijNs6g99skthEZrgtkVpmNgvAujojiOKm
 YpnXLZSf5w==
X-Received: by 2002:a05:6870:b289:b0:43b:516f:5f0e with SMTP id
 586e51a60fabf-46448da7a64mr328241fac.9.1787589600003; 
 Mon, 24 Aug 2026 09:40:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-463831af959sm5650103fac.5.2026.08.24.09.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:39:59 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:39:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 "moderated list:ARM STM STM32MP" <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 2/2] Clean up emails from non-existing domains
Message-ID: <20260824163956.GH523975@bill-the-cat>
References: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
 <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FT6aLn/Xw5yipqMs"
Content-Disposition: inline
In-Reply-To: <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--FT6aLn/Xw5yipqMs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 10:32:52AM +0200, Michal Simek wrote:

> There are 5 domains which no longer exist. Remove all email addresses that
> reference them. Where such an address was the board's only maintainer, ma=
rk
> the board as Orphan.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

This is generally good idea, however:
> diff --git a/arch/arm/dts/sun9i-a80-cx-a99.dts b/arch/arm/dts/sun9i-a80-c=
x-a99.dts
> index cf126bbd2c57..0642161ec969 100644
> --- a/arch/arm/dts/sun9i-a80-cx-a99.dts
> +++ b/arch/arm/dts/sun9i-a80-cx-a99.dts
> @@ -1,7 +1,7 @@
>  /*
>   * sun9i-a80-cx-a99.dts - Device Tree file for the Sunchip CX-A99 board.
>   *
> - * Copyright (C) 2017 Rask Ingemann Lambertsen <rask@formelder.dk>
> + * Copyright (C) 2017 Rask Ingemann Lambertsen
>   *
>   * This file is dual-licensed: you can use it either under the terms
>   * of the GPL or the X11 license, at your option. Note that this dual

I don't think we should be taking email addresses out of headers. This
kind of information is useful in looking in to history and trying to
track people down.

--=20
Tom

--FT6aLn/Xw5yipqMs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoxz2AAKCRAr4qD1Cr/k
CqWZAQDIjUOQeep6zCta6KQpDRYIIcmjjFOVZpPbDFuVmwddgQD/VcnV+KtXiuwz
f/OlxU/znJtWJsFsY1p8awHcxZDAhAw=
=FAzq
-----END PGP SIGNATURE-----

--FT6aLn/Xw5yipqMs--
