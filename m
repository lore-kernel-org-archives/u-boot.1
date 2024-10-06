Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9D2CFB43F
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 21:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEDC488744;
	Sun,  6 Oct 2024 23:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pz7JM7f2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D318888DD; Sun,  6 Oct 2024 23:23:41 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05FCC88744
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 23:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4584a719ff5so33801471cf.0
 for <u-boot@lists.denx.de>; Sun, 06 Oct 2024 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728249818; x=1728854618; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gn137AYXOQ3xIFhONPc6F8+p3t6fHxqsvlfLx7WqxzI=;
 b=Pz7JM7f2yyl1RHUFo15kSXYknSPXbxJrs3qR5VP92mUg1zJk+Gbj+BCRwA74J35Ryo
 VNZWdAt6kNsM5DkaaH8D0Py3HklfaKscvilMjWW2ak9F8PPqJH+8CmZSzsieSL0EHB9t
 v7g2CAVgvKbjnSXl9K8+wrkBDRsre2Qz231h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728249818; x=1728854618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gn137AYXOQ3xIFhONPc6F8+p3t6fHxqsvlfLx7WqxzI=;
 b=K5FtytrM00u+wVI5JfwtL/9oWUiN4BujBcQLNdBssp1bOX52Qp6mrBPiMqsonFVE7T
 xw5Y/cee5hy5Pfe+Lxacq6UU3856pf7D8khfCtIAvM4IErz0gHOKFDRTWInrL8h7Mon8
 4bzeaVZY/YHiu4WsenqS1eS1UJcaAzFc5DPqexRj+2KUSEqu+I4QYB5Cha2do1Qu+BnE
 lnlnw4lSiapQC2UHrAJ8L93oXW9s6E9CvP5ctq7Vzm6fSSFZL2EVCpYD86kb5By2N0+0
 4YizTw3bRybvh8bTE7iwbK6Zj2x/Kebmf45wfQI+XtVxkVm+kiK7sIeotWW6FqWM+8HH
 3ixw==
X-Gm-Message-State: AOJu0YzXMsjoHziE7DlWwrIB6nzOidfBrDmUig5s6X/xrM6EqJFYJ9LJ
 OYqDWACWRrwo+2j+H7XQPdWGm7MS04H7o4nASoSyQHj7edMJotQxzhFeCophw+g=
X-Google-Smtp-Source: AGHT+IHqPEsm7Sj3S0MbpD1br4L03P0sX4dFOzRLS7FSc2hGomF81t3DlXOBIGz0kaJVXSpwzGrzmQ==
X-Received: by 2002:a05:622a:410:b0:458:3207:4a13 with SMTP id
 d75a77b69052e-45d9bb2a86amr156963361cf.50.1728249817763; 
 Sun, 06 Oct 2024 14:23:37 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da76453c4sm20017151cf.92.2024.10.06.14.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Oct 2024 14:23:36 -0700 (PDT)
Date: Sun, 6 Oct 2024 15:23:32 -0600
From: Tom Rini <trini@konsulko.com>
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, sbabic@denx.de, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+renesas@mailbox.org,
 peng.fan@nxp.com, fedor.ross@ifm.com, ye.li@nxp.com,
 seanga2@gmail.com, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
Message-ID: <20241006212332.GQ4737@bill-the-cat>
References: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g7PcwiYK8nFQfmmO"
Content-Disposition: inline
In-Reply-To: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
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


--g7PcwiYK8nFQfmmO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2024 at 07:31:16AM +0800, alice.guo@oss.nxp.com wrote:

> From: Peng Fan <peng.fan@nxp.com>
>=20
> Make CONFIG_IMX8_ROMAPI could be configured in defconfig.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>  arch/arm/mach-imx/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 134e42028c..9d3aafd2f8 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -179,7 +179,8 @@ config DDRMC_VF610_CALIBRATION
>  	  the ddrmc_cr_setting on relevant board file.
> =20
>  config IMX8_ROMAPI
> -	def_bool y
> +	bool "Enable i.MX ROMAPI"
> +	default y
>  	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9

Since there's no help here, is this truly configurable, or is this
something that should be select'd based on the SoC and presumably some
of the newer IMX9 parts cannot use this?

--=20
Tom

--g7PcwiYK8nFQfmmO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcC/80ACgkQFHw5/5Y0
tyyKEwwAiZJvLqBgLcU7ycoxSDdv2xlWsDb3sg9b4i84rLDZayvrI8RmNKrwTpUp
Z+JA9z8ZcFQsfoT2k8DqP/3jHGa+usTvyFdysXt252zKpqH+2Lf0EGPXZjzVsENM
vocHZMYIY7Aq19KS1fipcU2TlckTxWjAerc6HeKQM5tc9lWBosV6nbC4DexfonNS
4bUDCHNXo6y19U4BiVDu1B2ehighwe7phxkosNoP/8BinY9G5QP3aItin1EmFisY
lAs4GUovkIHKGt2iV9Ox61VdaENF/eVBhy/ioKyPydGHToHnp7AVIrifsMfS0Q49
hCmERHcHpnuoxCh9p8M9/zqcA5iqV7k3WO0v3E5bJku9mq5NimUGxvuVNPNz1ohH
FYdwHMsaWJrqGIwYj3/JYRralG+yBB+DhkkuZqKIxa7irC/Qkhvf2vTr5SyV5Z3I
jFNOqzTZ+EgV9w1wZhbSFHT4TKep09++GhsPZ92ksZc7VX6B7xLH0BVnogm9ZmtJ
/EF20Ks5
=Ggw+
-----END PGP SIGNATURE-----

--g7PcwiYK8nFQfmmO--
