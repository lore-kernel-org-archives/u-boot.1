Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD74CF3942
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 135E582A9E;
	Wed, 19 Nov 2025 16:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hn1UU1MQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B498388D; Wed, 19 Nov 2025 16:52:10 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BCA281D6A
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-657230e45e8so365281eaf.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 07:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763567527; x=1764172327; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CAj+3OtU79RK2AfBKvnT/Z4Ne5/uW6Eml0EiCIm1JoY=;
 b=Hn1UU1MQhHbQfCtLVhX+6wvj93XZKsa7riPBacDtD9O3EIxfUwaqQWQRumI47cazuR
 koptIL5G0xlxuBqQ2bkNSMXcnPevUe+46TEaybDd7ABh5mvf7bwsDUWhY1uG9v9XYgyV
 E/nLUPrTMkHXhegrX2FxQ+m/2VZU9W0IJDwTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763567527; x=1764172327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAj+3OtU79RK2AfBKvnT/Z4Ne5/uW6Eml0EiCIm1JoY=;
 b=renw9UAcQUMnapa5Hv87A3FCUOeZOgmtKq8jfeVww3bnAs2apx0AsZ7CZ22uDt+Mw7
 mIFEufHA97zEClrhAJYHufG7CUk0otnZhl2LafLgTeWsLkd0xuL/Ve1YgtuiWokSwV5i
 1OGoaJDyWEnacezU6LXwOaUW/meFrgB729PWb/AyobbHB3i40EAVk962krnBuTYDrNzg
 8sJQyOxJoiKbiZM7KSHUi5BkHY7FdbEyW5BdhaCtBrDWE06AlIhZAiQcVUbe4z/MWwRe
 9+oYSCjzANofWjSkEkur3PyRh7Lwxc4Vn5bUPUMcgVNqmrCLB/tgLQGV0iNcEEu7vx+A
 g+5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/n5yaz6RYgQfCz8T5I+sc1iGMJH/CFVxSJX9CrDxIvd8yxll9xd9l3x4eN45P/HOVtKajQD0=@lists.denx.de
X-Gm-Message-State: AOJu0YxIzJD47KlDYxDn/sozFkrhopgy087Iq+WqZ/XZJjtXEGEcXleY
 KWOTzb8D/fzSjfOgGc+DeSAAjCcI2SYpJ4AwrQcOPr/MWt7R4mFTYhGOlxXQms1OIrU=
X-Gm-Gg: ASbGnculs7oYC+lDrRufjpL8ci1lUjeAEVu63a7TFH7k6WRvNNwmtxWLe3MRMjV0XAf
 GyLCWyNVkooIPEUxuuBLlSKNb6k0KskCgc0GCdeM5F0nDa6I8kP0QooR33bk2iG3xBd5yUA9ffQ
 OlCNaWO9WR8AuJnJ559egLjMQFPUc9M9TOWJdP3WZsZ7QbD/49lMws7aGtMslVgTtlbWYRfs97q
 05u5+wwi+eqhf1CnSGazRPiPSdrGq0j7Bh8gbPpsxuAgmQ53GpDLaFYViFdCDK6BHI+qyldT9sC
 nTA93Roa/KoHYENVDFDtLEdJYQeuJKY+xLowuu+kbL8hIWIMpGRwkEYsR+z43GanwehDeDK+m15
 pEZ3Y/oLOaG+gZtb7UKLeOtcz0GbN13JnwHRwlOacf1RZNMnbEZf/bUSDTKA7w0lBmLbsGDCY0m
 i8MKXFmywJlckHO3afUTQOyrnhXB7kCERv+MD9msviSnATkwlSpw==
X-Google-Smtp-Source: AGHT+IHMFOSvKSw6BV9gsz05bZHvi1Ns9dSFMd5fAookNVSmqROjzp0QKuDW9/6tqFgPT9Vak7a7gA==
X-Received: by 2002:a05:6870:65a1:b0:3e8:4730:bcb4 with SMTP id
 586e51a60fabf-3ec8349170bmr1313428fac.1.1763567527244; 
 Wed, 19 Nov 2025 07:52:07 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e88e72dfccsm4894970fac.8.2025.11.19.07.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 07:52:06 -0800 (PST)
Date: Wed, 19 Nov 2025 09:52:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, rui.silva@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 mkorpershoek@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 3/6] drivers: phy: qcom: Add QMP USB3-DP Combo PHY
 driver
Message-ID: <20251119155203.GA2125796@bill-the-cat>
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
 <20251119152530.4175628-4-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lH3Qsrf7vyIAg4T9"
Content-Disposition: inline
In-Reply-To: <20251119152530.4175628-4-balaji.selvanathan@oss.qualcomm.com>
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


--lH3Qsrf7vyIAg4T9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 08:55:27PM +0530, Balaji Selvanathan wrote:

> Add support for the Qualcomm QMP USB3-DP Combo PHY found on
> SC7280 and QCM6490 platforms. This driver currently implements
> USB3 super-speed functionality of the combo PHY.
>=20
> The QMP Combo PHY is a dual-mode PHY
> that can operate in either USB3 mode or DisplayPort mode. This
> initial implementation focuses on USB3 mode to enable Super-Speed
> USB support.
>=20
> This is a port of the upstream Linux files to U-Boot:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/phy/qualcomm/phy-qcom-qmp-combo.c?id=3D3d25d46a255a83f94d7d4d421=
6f38aafc8e116b0
>=20
> Enabled and tested the driver on Qualcomm RB3 Gen2 (QCS6490) board.
>=20
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
[snip]
> +config PHY_QCOM_QMP_COMBO
> +	tristate "Qualcomm QMP USB3-DP Combo PHY driver"

Tristate is wrong in the U-Boot context, we can only use bool.

Checkpatch also asks if MAINTAINERS needs updating, does it?  And please
wait for any substantial feedback before doing the next iteration,
thanks!

--=20
Tom

--lH3Qsrf7vyIAg4T9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR3noAAKCRAr4qD1Cr/k
CptPAQDw2YULLNwgdTkUD1CoXsftYp+rLpZOEK1+OKvAQbMRCwEAmA/3WCnKIYEa
uZ8szjuvTyTQ3crl+AINcOaWyBB10wA=
=1xSG
-----END PGP SIGNATURE-----

--lH3Qsrf7vyIAg4T9--
