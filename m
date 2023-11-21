Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C27C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70CF875E5;
	Tue, 21 Nov 2023 20:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LK4Yvrgr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E700586BFA; Tue, 21 Nov 2023 20:31:39 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3EF487616
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 20:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-77d631aab99so7758685a.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700595095; x=1701199895; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tk08R67i33ZD+vttE38+RBxdRRr9Dtu4nj+CJcKuSQ0=;
 b=LK4YvrgrciUh0MksApN9nJqIo6ob9Fn+JbPUNEqGOYWLmXw31/diCOgM50AAzk1FEZ
 X37zeEtI5SbXZTBhA7LdghAH6LM4LTLKcGKKYaR9DRiJItbfEpCsTrXH/nGT5ykas64i
 KRw+naNmvHEY2d7uXcppjx2EYlv1h8PDayP9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700595095; x=1701199895;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tk08R67i33ZD+vttE38+RBxdRRr9Dtu4nj+CJcKuSQ0=;
 b=Hvi2vorz9BcZRp0CJHG4ozE8tgEcVvTXM3BjtdYf7dkxx0qkvW84Sm4KkjlXSFtcar
 xBpIRlR6UFkUvbdxPXL11Yimj8O32AeCeiJC9AP8u03mclMvF1INK5196Lc9nMB83+k+
 pfOcJZwE7l8DGT51Lrhc6Pg65trXCKl4LGCeMjKw9b6MyODFWdg7UvBb0T2y1h6pYPEe
 cJXIhq7K9zS6YM6MBgwKQJ4yVv/im4/m3w60J7ZOwWl6K8+CsvUeEhknphYr9oXJ9r7x
 +SZg1zH8SVc5VpD6QZ55qGOiRwK6+h+jSJrcZHKChKXc62xDfs39isikHKw4CAeji1Ub
 OJyA==
X-Gm-Message-State: AOJu0YxWMwVTASCXLforB5BygpfA17iM1MNwqK6W+SZH47tU5ZKsr34i
 tIki2hW6RKiVDwCXVEslo3fEVg==
X-Google-Smtp-Source: AGHT+IGo6grL8iBYctkUe5iqzmGpkoZxI0NL6oXN3dKru/70OWcQ1A0w7qTwJXX0++QpwxxuE2wKMg==
X-Received: by 2002:a05:622a:d3:b0:423:6e89:a540 with SMTP id
 p19-20020a05622a00d300b004236e89a540mr199264qtw.9.1700595095702; 
 Tue, 21 Nov 2023 11:31:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 p2-20020ac84602000000b00419801b1094sm3836396qtn.13.2023.11.21.11.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 11:31:35 -0800 (PST)
Date: Tue, 21 Nov 2023 14:31:33 -0500
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
Subject: Re: [PATCH 21/21] MAINTAINERS: Qualcomm: add some missing paths
Message-ID: <20231121193133.GG2513409@bill-the-cat>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <20231121-b4-qcom-common-target-v1-21-9492198e0c15@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VxcEV98mjPIJG+n8"
Content-Disposition: inline
In-Reply-To: <20231121-b4-qcom-common-target-v1-21-9492198e0c15@linaro.org>
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


--VxcEV98mjPIJG+n8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 05:09:44PM +0000, Caleb Connolly wrote:

> Add board/qualcomm and the SoC/PMIC DTSI files.
> Adjust the driver paths to use globs rather than hardcoding every
> specific driver.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
[snip]
> +F:	arch/arm/dts/msm8*.dtsi
> +F:	arch/arm/dts/pm8???.dtsi
> +F:	arch/arm/dts/pms405.dtsi
> +F:	arch/arm/dts/sdm845.dtsi
>  F:	arch/arm/mach-snapdragon/
> +F:	board/qualcomm

Maybe:
N:	qualcomm
N:	qcom

>  F:	configs/qcom_defconfig
>  F:	doc/board/qualcomm
> -F:	drivers/button/button-qcom-pmic.c
> -F:	drivers/clk/qcom/
> +F:	drivers/*/*/pm8???-*
> +F:	drivers/*/*/qcom*
> +F:	drivers/*/*/qcom/
> +F:	drivers/*/*qcom*
> +F:	drivers/*/qcom/
>  F:	drivers/gpio/msm_gpio.c
>  F:	drivers/mmc/msm_sdhci.c
>  F:	drivers/phy/msm8916-usbh-phy.c
> -F:	drivers/pinctrl/qcom/
>  F:	drivers/serial/serial_msm.c
>  F:	drivers/serial/serial_msm_geni.c
>  F:	drivers/smem/msm_smem.c

What about drivers/usb/host/ehci-msm.c drivers/rng/msm_rng.c and
drivers/phy/qcom/msm8916-usbh-phy.c ?

--=20
Tom

--VxcEV98mjPIJG+n8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVdBZUACgkQFHw5/5Y0
tyx4bQv/fs6EXw0nreq4+mlMXSUjceGj1ieIqS1KP0Q7F3+RgzZ+HrO/PIE/6uxZ
V8jcFfnSXHao9HY+KcqGmEnVRsh4v0DztIt/bvuxaxyz4zri67TnsmQliQk2Br9o
IzruZa1EiKgvkm+SEti1QHlRhD+lpnICWfKNN+6mreJW8DC4jyPAIKirneBlWVwe
1igKWKWVOH9doS1rqSkzBRRikaSyFurS/g0UpQtZT08Fz8TjP5W23i2+pWHTSCMQ
ogIoxVUWz77zqiSZ+qv8rvuM1RIsRHwH3W5YFHwXmZwHNeFfT7ev9ejlL2dqiwI2
hg4UWUPQDb8/zKr92aqryzqcJ7UAUSsbSnVs0FpX9u1MgcR7obaFbWTL0PbxYoV5
It9YrKKUDSoWX6HuoGkV11eGbrAZjVJ1NjJekE9dPHHx+zlvxSd7roZRjf1lTL6Q
/NCkDDCfAhcs19C+ZXrqIIQ1igE2Si0spO8dapf5jZFu5xAMo8reB4+GWNjVpgK/
uA+IrlP4
=x/Q+
-----END PGP SIGNATURE-----

--VxcEV98mjPIJG+n8--
