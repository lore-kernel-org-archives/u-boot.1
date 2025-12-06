Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9318AD339BC
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 17:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA6A7836D1;
	Sat,  6 Dec 2025 18:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KWhlk86e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B53683837; Sat,  6 Dec 2025 18:40:37 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 659668352B
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 18:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c75387bb27so1392461a34.1
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 09:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765042830; x=1765647630; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/cZ+uzBDPkPAWe2B6Bwp2WSoqE7O2YZ1/zcj2+r+WeA=;
 b=KWhlk86ebsa5zMpbrjSWmCK2YLNH1/ODTFRi/oMS7CdjvHARpPTBzJTSwoP1cYGRnl
 neb2yNAKws6EdcETK2va9Fo3M+Nh9hwHEOokkjt81LEI0Bf6Vs/Lj8Wzd1nta1+PfwYz
 EEypWOzRVe5DQot6pvn1FEAWfFQfsuD2ydZjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765042830; x=1765647630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cZ+uzBDPkPAWe2B6Bwp2WSoqE7O2YZ1/zcj2+r+WeA=;
 b=xIQ6VoxHb5y2rfc1bLATeJiPtZCJJuZw5nZ2f3FUm66ZQIuSOYgdNo1XRvL87kWVVR
 8vvsmqgXJpAI339cT0iVrtcJqVNQclofdpygUltWFR7XZVPIp53WJ4FGJQpGNETjdMZS
 KN01TT2oycaPQUh22HRWp8rZmWLpcDMXvakeKopqDeWFmeiqShq01AuP6bRpI+ZZN1LM
 9j0BGsVszfnsUB8JVWWGr+C1Ju8hUxIM7JdhhwlOgK/MVPvoL9tMq5U7G0nLxDwltO8k
 FqtzVgZ5LFDTxIcUySm6ELZSzXqT7+fpCo0nFW3fE4uuIugJSjhbL1h+gF3xKoBLJQnR
 UEUg==
X-Gm-Message-State: AOJu0Yxuj1bFjwutWQJTsbSc6oLsvhui3dzOIuHHElCG7VwfZyTureIu
 zIjqkZQVC8W/Dfj6BcMTM/C8ga81GNIwz6rrduuVjrYarM1WuXl8sLrIha8UWlHnhUc=
X-Gm-Gg: ASbGncuu/BUEZEy3rx+G65PQWWs5KQq3lQNNrkAzJsSWc700m5K6kGxnsughjQEtiRT
 kzQ/V/3EK102hcS/rDxTA7GtGFxfcOwVanfewjTgPHktnaxBdiPb7EBNZ3mhvlsQYLpUHuUXF+y
 jH+WLSe8ua7WEikNhRdOfGCQFabfLddmIeo+rE2N0qXibBu3k/2r4RxFy5mItdMVER4xNprPnE0
 sG4BAE6nanPDUA81X5ZqjVsckHlAyRomq7Sv8kZL5+fJrhkTz7gKAC32Qqysf6bGRSJQeVIcCqC
 lTwk5IqJbtGG92lH36yZgKkPKKxOWMG21thtcXISfXKj9Gl8/qK0ToR9KJp3W0ZzcPpCXGWsvE4
 D0aa0Mg8nfC+mb3fArzP71osJET4WVSfUIANcbu1xNdTtj5gQdzG4wqAOqkMO1osEloIeG4TxPq
 TPs7nQ2UlIDnlgDRB2ZQkDIYtzG0Vx91RvFjWfau/pSStPyIYrBZgkTBSRR2ZG
X-Google-Smtp-Source: AGHT+IHw/PCQtfUZFCpP/fVDiuJMSVbx4RpAriBqmhMVdMHka4wD+McqMiYqBOkL/zJeLPKIGKqo8w==
X-Received: by 2002:a05:6830:254b:b0:7c7:6e32:dc7f with SMTP id
 46e09a7af769-7c970696abcmr1931557a34.0.1765042830035; 
 Sat, 06 Dec 2025 09:40:30 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95ac85170sm6245180a34.15.2025.12.06.09.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 09:40:29 -0800 (PST)
Date: Sat, 6 Dec 2025 11:40:27 -0600
From: Tom Rini <trini@konsulko.com>
To: yegorslists@googlemail.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] bus: ti-sysc: select CLK_TI_CTRL driver
Message-ID: <20251206174027.GM303283@bill-the-cat>
References: <20251117093954.1580394-1-yegorslists@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oJ4zV3VlFhY5oz/0"
Content-Disposition: inline
In-Reply-To: <20251117093954.1580394-1-yegorslists@googlemail.com>
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


--oJ4zV3VlFhY5oz/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:39:54AM +0100, yegorslists@googlemail.com wrote:

> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> The TI System Controller (TI_SYSC) driver utilizes clock management
> functions provided by the TI Clock Controller (CLK_TI_CTRL) driver.
>=20
> Specifically, the TI_SYSC driver relies on the 'ti,syscon' support,
> which is used to access system registers for tasks like reset control
> and power management. These operations often involve manipulating
> clock-gating or reset signals managed by the underlying clock hardware.
>=20
> Therefore, to ensure that the necessary register access and clock
> manipulation functions are available for the System Controller
> operations, CLK_TI_CTRL must be selected when TI_SYSC is enabled.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  drivers/bus/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index a786fe430e4..05492c63bf0 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -15,6 +15,7 @@ config TI_SYSC
>  	bool "TI sysc interconnect target module driver"
>  	depends on DM && ARCH_OMAP2PLUS
>  	select CLK
> +	select CLK_TI_CTRL
>  	help
>  	  Generic driver for Texas Instruments interconnect target module
>  	  found on many TI SoCs.

This leads to failure to build on:
igep00x0 sniper am3517_evm omap35_logic omap35_logic_somlv omap3_logic
omap3_logic_somlv omap3_evm devkit8000 am57xx_evm am57xx_hs_evm
am57xx_hs_evm_usb dra7xx_evm dra7xx_hs_evm dra7xx_hs_evm_usb

--=20
Tom

--oJ4zV3VlFhY5oz/0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTRqiAAKCRAr4qD1Cr/k
Cr3wAQD3hGbKZRQciC3fL+MF6X4UQoBHZuIicwNxMB87+zFRSQD/YNrfuR9cJRtg
KHxaCia1pzakXuvy6SrFCJ7vpeQt6gk=
=dLWJ
-----END PGP SIGNATURE-----

--oJ4zV3VlFhY5oz/0--
