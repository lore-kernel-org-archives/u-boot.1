Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EBDCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 16:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F187784248;
	Fri, 10 Oct 2025 18:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tqWtq3Y2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9C1C8424E; Fri, 10 Oct 2025 18:05:19 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E4183FA7
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 18:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c0e357ab51so1830908a34.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760112316; x=1760717116; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fG4I2vcU9I6tSI3c26uRblUV9baIA/HmjMIybbd4bUM=;
 b=tqWtq3Y2dewAN9hFMUtvLtiti/PTuWisZh91W8sRX0JvhJDN4uxJrBGlwNxp25LK4u
 MqEZBqBmIxVPMI9b4Ig0Q1IoRt3yOUrApH06KEynREPxJzubXlzO7pQBHToFif6rF7F7
 RGeDgoWbuuS7pSJGpR1qZWyvVxO1tNUhSguwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760112316; x=1760717116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fG4I2vcU9I6tSI3c26uRblUV9baIA/HmjMIybbd4bUM=;
 b=PtMWwXHEhCcWs0RPJPnifuWkT2jmBbMLfimF+khys/hud49WhDkbsXTHlJ1cMEjHBq
 XJ/CzLzumxMHywwxX2mPWmv7gh+/s8U4BJDbCE7AzM/WoWa7zUvPz2/FP/UvztF+Jnmz
 3XREEmOSauQ9SARKorPQqnXRF1jnAMPUFDZ5t2PSoxqyMmGsPSGh1anBO6L70g2bh2Mh
 ZGdkWboL31zazCRINyeQtYzBucjsU5ccbwbj6eta9xT/taOQcjmsOc/bdcievo6BdfGa
 iKwM2ZmehocakJEXOTkCNL6o6K6sCd4XEyHBqnTG+SlDSDAMtxrfKN7QNLwAYED9N6QS
 i66Q==
X-Gm-Message-State: AOJu0Ywd79/9sR4SD5tzjnZWBVIgVLN7Ij8UjRKk55zpQ5+nXauRjWSE
 xUXQ3ty6neZVoL47iPcz7wZLCScAQsEkNeMArW0vJ3+GzSZVi6xXK4llW4lT97HDqgI=
X-Gm-Gg: ASbGncsfRRdzDa7aRgx37BU8zZyTMtb8JhbSYF5W1lD+7AUhGRAuEtLEr4wJGsBamq8
 VvVnxr2khH90h3LRCwt68Vw7m8F4Wy+XX65Djd1/TN/1z8H+LQoH0vr7t9BxSGZNDMd6Y0EZhkQ
 0b0rQxpQRAyynqA6iT8yrYh/Nt3yqH59B6RnId1go92K1yCo49DyCLBtaa3lJ4Pg6Qx8FU0Baip
 jGN+RcKMFupxWefs9EgmSph4gQyCdEjl5RrD5D27vjxjXRF7tjmgG74P/e200wgKxCnsy+C6dMh
 JU9lj69gNs2RhCGuhNeHilL00lhH0m/bN5KlXXDdswBRh8S12d/AIOJDvwE63UgnSv1FUiRzaJG
 r29YzGddbM40J5mc3LAhjOZ7ffYXlE5C9iHaIyYlZQO2IAwXQm9gKilTtCqGEywxBgKu60IO2k3
 1HhG3ULn3/j0Omd3U=
X-Google-Smtp-Source: AGHT+IHHD/x6NUVDg+JHARPwnrHakxWrlwBjJpnrgDdVLYa9RSqXysDBXYicjgKQRiqx9dVBlLUCIg==
X-Received: by 2002:a05:6830:3901:b0:79e:9b7f:5666 with SMTP id
 46e09a7af769-7c0df7941e9mr7752678a34.14.1760112315671; 
 Fri, 10 Oct 2025 09:05:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f90fb75fsm960775a34.24.2025.10.10.09.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 09:05:14 -0700 (PDT)
Date: Fri, 10 Oct 2025 10:05:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v1 3/5] arm: mach-k3: enable support for falcon mode
Message-ID: <20251010160512.GE298503@bill-the-cat>
References: <20251010131829.3737258-1-anshuld@ti.com>
 <20251010131829.3737258-4-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2jWd3yqtgS/jGDEb"
Content-Disposition: inline
In-Reply-To: <20251010131829.3737258-4-anshuld@ti.com>
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


--2jWd3yqtgS/jGDEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 06:48:25PM +0530, Anshul Dalal wrote:

> With CONFIG_SPL_OS_BOOT enabled, U-Boot checks for the return value of
> spl_start_uboot to select between falcon or the regular boot flow. With
> a return value of 0 implying falcon mode.
>=20
> This patch overrides the weak definition form common/spl/spl.c to allow
> K3 devices to use falcon mode with SPL_OS_BOOT enabled.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/common.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 5483ac9906c..41c96cbd4c5 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -425,3 +425,10 @@ release_proc_ctrl:
>  	proc_ops->proc_release(ti_sci, PROC_ID_MCU_R5FSS0_CORE1);
>  	return ret;
>  }
> +
> +#if CONFIG_IS_ENABLED(OS_BOOT)
> +int spl_start_uboot(void)
> +{
> +	return 0;
> +}
> +#endif

I've seen this in other parts of the series too, sorry.
CONFIG_IS_ENABLED(OS_BOOT) doesn't make sense, it should be
IS_ENABLED(CONFIG_SPL_OS_BOOT) or just a regular #ifdef. Also for this
example please add a comment to the function explaining why it's always
enabling falcon mode.

--=20
Tom

--2jWd3yqtgS/jGDEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOkuuAAKCRAr4qD1Cr/k
ChKNAP4gQc4WIOu4Ozr08DwTQp4zKbvV4pKUIRplapS/aup56AD/Q5uZUaFhgQQK
+L/oXbuJtbXAA7ZNjCdAnNfyYSCVUAM=
=rIgA
-----END PGP SIGNATURE-----

--2jWd3yqtgS/jGDEb--
