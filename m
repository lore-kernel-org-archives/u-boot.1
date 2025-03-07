Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8097BC282DE
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 15:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B791481298;
	Fri,  7 Mar 2025 16:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mBamf2F4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3878E81335; Fri,  7 Mar 2025 16:57:46 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 076358122F
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 16:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6fece18b3c8so1559457b3.3
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 07:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741363063; x=1741967863; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eVt609Wr1f7gYWRN/Sa0i1msZkurUVJV3/5HWGz8QdE=;
 b=mBamf2F4FF5fHNIhQep1sIk3myYHfrAjKljTqRFFMJ66p7UhWb3uzzlHIAlyXAvJJ6
 /fHjgpFK9m2cDjlD5hNEi4VPR+L6NS+YLqHhLIcvIoVqGpnPjaLkxLAPwnss7+ZBmZdx
 6UKnoGLQti4YBdFXRwQYX2vmlVDYFd2hSU+z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741363063; x=1741967863;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVt609Wr1f7gYWRN/Sa0i1msZkurUVJV3/5HWGz8QdE=;
 b=sgPXoDviY77k/MWwRvhtzAoyam1OfgEuQmKilzY1l4JbsYncqeKs0DPMZfthPtlLul
 Wk0Tm26nw/vwqmL76NTCe7g/RoXLuMxm9basZMhzzhCTeAz9FJFqxZ2FVJHN02reRnMm
 jrQYsyrgPAtfjOtMP/nO/5EvhvD3Zkq7TT5DD8iG5Db+i1HzhVNsBq9MVNPfkSg3hjOE
 KKn1xmkx26i+q5WiE4k6/pLx9JrLplEDQF6+jtEXCSXK0LSjD5DufpAuX2h5WFOC8HY/
 dhzvEzKEJlQm8WfAJK4hxki8Sd0dJG3JS2lnxd0MBRDWR81ePyoBl1WkHWqsxUCEnhRk
 ERJQ==
X-Gm-Message-State: AOJu0YwRLiIE36g+R8mPZlo3vFo3xPwIdLNkIk24VxlWTHbrwyiilp7S
 s0/IaApC//yij0H5hhqUkZD5X4eOIpEylvw4mgsdIyxBztq6+qmW6o7VGMdFe2M=
X-Gm-Gg: ASbGncvEDUEt46+ihmBs0QoWQOJ4HL3WnMR9JvJjr6i+A/9uHh9HGUJtFYjOdSJN1Gr
 dVszx1XAZGYaTCK1pV/7wdNnGWrLJsC5FgCC7aM4n2VTQ/juBbq9dtbBLAUXpPeQ1E8AGCijtoa
 yb0npR1GYEK0o1jUPAhLf9xIOeo6zzGoWTJG/f7FBr1U7pnaiLCrhrg29adozkI1+jaqTjQfkFB
 jqVwqPVmU3XOKVFnUIb6vkRao1wLj9lF3fpAlP7NVdBppGsV9s4Rgon+5FmHdhFQXxKzBw2O0Gr
 J3s4p/NfDYHlO3UiJmVE5FRzWy1pRxCBK8949w0jM2ccng==
X-Google-Smtp-Source: AGHT+IHUuqXGqwc6FW27zOTCrm/1US6dudpp/be7Pn95QWGaChCI0t3/6OTSbWaLzPIJd7xCVK7/uw==
X-Received: by 2002:a05:690c:6c02:b0:6fd:4702:d7f with SMTP id
 00721157ae682-6febf3b70a4mr57460757b3.32.1741363062886; 
 Fri, 07 Mar 2025 07:57:42 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2c2e885sm7759437b3.70.2025.03.07.07.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:57:42 -0800 (PST)
Date: Fri, 7 Mar 2025 09:57:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com
Subject: Re: [PATCH 08/10] configs: ti_armv7_common: add cfgs for SPI falcon
 boot
Message-ID: <20250307155739.GQ2640854@bill-the-cat>
References: <20250307075541.2571104-1-anshuld@ti.com>
 <20250307075541.2571104-9-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RWrwWDZCcZmpsKMv"
Content-Disposition: inline
In-Reply-To: <20250307075541.2571104-9-anshuld@ti.com>
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


--RWrwWDZCcZmpsKMv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 01:25:36PM +0530, Anshul Dalal wrote:

> When booting from SPI, only the tispl.bin and tiboot3.bin is loaded from
> the SPI. tiboot3.bin is located by the ROM and tispl.bin's offset is
> specified by CONFIG_SYS_SPI_U_BOOT_OFFS.
>=20
> The kernel and args however are loaded from the eMMC or SD and not SPI,
> therefore we don't actually make use of these config values at runtime,
> they are added to avoid compile time 'undefined identifier' errors when
> building with SPL_OS_BOOT enabled.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  include/configs/ti_armv7_common.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/include/configs/ti_armv7_common.h b/include/configs/ti_armv7=
_common.h
> index 3def7b1027e..f101d10992a 100644
> --- a/include/configs/ti_armv7_common.h
> +++ b/include/configs/ti_armv7_common.h
> @@ -119,6 +119,12 @@
>  /* FAT */
> =20
>  /* RAW SD card / eMMC */
> +
> +/* SPI */
> +#define CFG_SYS_SPI_KERNEL_OFFS	0
> +#define CFG_SYS_SPI_ARGS_OFFS	0
> +#define CFG_SYS_SPI_ARGS_SIZE	0
> +
>  #endif

We need to refactor the code and migrate these to Kconfig as well.

--=20
Tom

--RWrwWDZCcZmpsKMv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLF3MACgkQFHw5/5Y0
tyyW3Qv/bwjT9wcXgvXOgge4sfReWcmrpbpwN8Qzw03WAiNcV2/0f0GeoIY2ANOL
zy3Wx87aief8Ka5OgLUsp9CX5NgY0U1GfMDpfCw6yB2IiC/lMNiZV+Biq7tj7pNw
Bcn5elJ9vQu5qjtAyf0g3K12dLhwnbMxOuIuuN2+lqhgDY8DA6aDpK3et0d3EKbY
i4/1aijH8sVh7Zji37jYLQEJOoXHhb6hVwATKS51cR/tyCrKxrmBdiMhVkWPfrjJ
kwH36LkqsGK2mwdELe6oXUIndiaE5NsP2oY8GSCooXzkr+OPU4TBtQA3MyaP6282
eQVmS4MZUyU5sDsUUKqiaTtz2UvjJB73vZUHNCls4L5iq1O+RUspnWJq3cpfHF2x
1ZBHlsKNbHP8xUopemSYQ+fqhIIpLsQ6ijtJBDE8TnS+aWxgerjr8iaU9tjXuqvB
s94KfDaXvoVc883OEXWIadt8G3/k3SxzauucgNNhzwzfoAgSzXPjXXGcaLXMbWQA
Td102u8L
=tJxc
-----END PGP SIGNATURE-----

--RWrwWDZCcZmpsKMv--
