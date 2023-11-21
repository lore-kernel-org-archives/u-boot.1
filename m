Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B22C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D16DB871CD;
	Tue, 21 Nov 2023 20:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S1ZFJXLj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C25387448; Tue, 21 Nov 2023 20:08:59 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C11ED871CD
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 20:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77a453eb01cso384139185a.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700593734; x=1701198534; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vJC3zlc2fNdqRpjW+HhV2jqGevdSajVxeAgCJpswsJk=;
 b=S1ZFJXLjaesndG5EQJOTtCQ4PxSe1JT2dVVC2GZ4rUEskMaxT0PeOWEe/pwcEPlUQG
 vu4XyD1NE9viBThzU4r9fSi01UxUPxXzK2N/hbEMQInehYWbu6GXbdpdR+B5mrBWA99k
 JMtThAi5IIACkvzJ0w2rR+KxAfSQ2bCQg+vnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700593734; x=1701198534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJC3zlc2fNdqRpjW+HhV2jqGevdSajVxeAgCJpswsJk=;
 b=OPAjNmPzEznCpOIEFHJcgb+cJry6Hc1pdBm9OhHcGGTmZUDQggrUX8nLaoO99/LWmu
 63X+pn1RgcfaGghoV+SQdv7nqgOat8FF05eYcKpUe5HDiVs4ZjWbjXGdaY5gaQS0FyJF
 7a/j5briQzZxGAFiySWFYKjolErTIe2JDZNq+hcr8VDaYwW5MXUVbTIVjQx3XW36DSXm
 xspOEunYoxxpssJyBMIrNA5qsNiggUB/PW+ZkmZGv/k/zSHxK6dP9xhlDYUkaBOUyzGl
 JKimKOEyFIal04HqvukyVX9DWlvtbw/dQA3zAuFtPGWSmLDXeiH9CE4qYNKSRwb8xxe5
 WCuA==
X-Gm-Message-State: AOJu0YyuaWU5yyl5ni5NwDUoCxRcgiMCCRscqNuAM6hTEnU42COm6zHe
 T1hWjp/Jn+bEu0ybA1PKfx04pA==
X-Google-Smtp-Source: AGHT+IFDap28mdL3TjKKBser8ZPXwuiIkN11r+bjxXxBCVcfv8hKex5TBPM/ycHa6z9QLPfvQ7ssUQ==
X-Received: by 2002:a05:620a:86c1:b0:77d:55e7:aa96 with SMTP id
 pr1-20020a05620a86c100b0077d55e7aa96mr4353226qkn.18.1700593734595; 
 Tue, 21 Nov 2023 11:08:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a05620a27c300b007778503ebf4sm3866108qkp.16.2023.11.21.11.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 11:08:53 -0800 (PST)
Date: Tue, 21 Nov 2023 14:08:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 09/21] configs: add dragonboard410c_chainloaded_defconfig
Message-ID: <20231121190851.GE2513409@bill-the-cat>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <20231121-b4-qcom-common-target-v1-9-9492198e0c15@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sr5XEzqqF+kBiseX"
Content-Disposition: inline
In-Reply-To: <20231121-b4-qcom-common-target-v1-9-9492198e0c15@linaro.org>
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


--Sr5XEzqqF+kBiseX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 05:09:32PM +0000, Caleb Connolly wrote:

> Revive support for booting db410c using the Linux kernel header, this
> allows for testing the board more easily via `fastboot`.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  board/qualcomm/dragonboard410c/MAINTAINERS    |  1 +
>  configs/dragonboard410c_chainloaded_defconfig | 75 +++++++++++++++++++++=
++++++
>  2 files changed, 76 insertions(+)

How different is this from the regular defconfig, and assuming this is
also a partial answer to my question about "why not select?", why is
this not just a config fragment instead of a whole new defconfig to keep
in sync?

--=20
Tom

--Sr5XEzqqF+kBiseX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVdAEMACgkQFHw5/5Y0
tyyhxAv/Qdnn1YYMhgdTJozWJgnE18z7frOUG927IQa7QGVyNy5I7A0/adqEoncj
MazTyuE0ACxGe01dEQ2+Pp+eHGWGJw34iGfouKfvMRfqAQPqPmJ29q/D9xZD7IGL
K+IMzn/Apq0fQCePniHT6Is0wC9NNkmNr5zaNo40PIJyc2jio/h9l1ThSdEqLcpi
ANqhwZ18X0YES0yRB0japFnWyMS+SDHxeEbMUBbd1tuPmZa3levvlJZSNR+/M6Ud
HmFXDejofcyEcHEIwOmnkXsq3WWWwcEANebsPBA1W4nresP6MMcyz3C+TPazmOnh
VYZhvvs8KJLRBqT+8bamvzN/n2MSDTj1ShdD43VWqBIi8pGsvFEP06TvOs2JoLHW
kLuGxi/iCpHploJpITxkUzN+s9iTPYi+t76juYtgEjUWOwhbQzoo6DYJ8+UiRHnk
l7slGyzue3CE+oT2ACXqXwEVcudCqnaE2wM9PFfyUm9WUxl82jNqYgZCeQ0EYSqb
9h/lDatk
=sDaM
-----END PGP SIGNATURE-----

--Sr5XEzqqF+kBiseX--
