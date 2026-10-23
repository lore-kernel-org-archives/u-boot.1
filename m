Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF769606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yb50Qh1b;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=R9V6I76/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB0DD813EC;
	Fri, 23 Oct 2026 14:02:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k-kX8x3R1YpH; Fri, 23 Oct 2026 14:02:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1656A813F1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792764170;
	b=LiXArOtifoOU3zDREEy6nCfGjgvvTxl7yM6PF+pOHaEq67AX4iEuR+INfhBimKw+E4IT
	 rJhwYraW5H2MhVlWsaJXKeDnTzGlFDoI1LKrJZdJ6I7eC9lfU//GQEZce9w4lQoWcpQSg
	 l2zwRRcMdojP9S5hG9s2m+p8jci7GiffIohqrDdgLzAJmFY7oPvHTnGqxHkFKwSFHXqMj
	 CWnk12eyBnfRBHdDcFymzn+hUn7Wf7T7JgwnQEyPCPW0n77praqGYIpihGaWaQjPhyupi
	 4OMp9Tb3a7yI0RJApHyVeEGUBWnE9MqzlSZEaP0hH4dc12kqmMLazgPfxfiFur7p82w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792764170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fo/JuFe70XspyH36Dmk6DtS9wxGE9SpiubUjyY+1FGs=;
	b=Ksr7M20wQi8EWYJT3mHktExXJezzk4ec5DkhpNCaRwWvGMaXAzV3pknGJaMvgikUarR3
	 dVtSl1Wzd7u6YKMqmmLzY93vO4Aw3wnE8Nse4kMPt9HV+W7wM1YQqEFrqFo1m+sZz3pAG
	 8EDrMsInnrOvzIqMvozKy1utc2SL61z5iFV1n98sDlzMLuHV0qGSECrZvNsVsUpzYFW1q
	 FvtwwJQ+xPQs3cmssBPoXzGnXW1Tvoxc/koFWmzYL8nyEQgIqitC1aH3GhKs6q7NA5qbf
	 lDohxLekxtB/KUX2MzAcgbnykuXiImonZGtBskSp/NkHllm2/fblPlpgN+CbzBSJynA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792764170;
	bh=fo/JuFe70XspyH36Dmk6DtS9wxGE9SpiubUjyY+1FGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yb50Qh1b4Wgpg2JZFYDY4rPbEdnBU6im9WtDGpPJVwH85H0QEvZ1pVqZe+T6godSB
	 4W3HWAkjtQn+RYAgjly+VobSIB59wh2rAsPfiwPMlJXP1t1+jyncH79gG11TGW2Q3H
	 GZWVrHAim7LI0EgcWvllqzp0lUU3jWe5FQ6/rliB+ORCgQutnJ0b9sdhVvQI4WFyHQ
	 t89egOt8LTu5bJ2v75UZEjEfJTPI+MZwzApn70cQgFskwOR0yQlo8MDASvKTyJnDGd
	 qWxdaDqnjdMKpHL0MgABuu+CrKoXx/HuO6ZyoegYRFx0gHk1ugdioSxM8MBYeo3sCX
	 5/JhqVtlsuj3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1656A813F1;
	Fri, 23 Oct 2026 14:02:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5504312C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 465176069A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lgSdI2T_vC_C for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 681C360660
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792764167;
 b=kTL4ENBftJi0TTh8HuYjdODhQSPwTpZCI54rYMLDY4E1atS1yrtJrFrj1YQtTUCrW9os
 y/gub4Vc2rMjnXCAkgrqP1ZoZ7O7Q8CYoKA7TiUlL9iTu7C9jmQ6Xq/mIl54GFHh8OxYq
 c4IJHjsPrj7zMVwILcGs4H9v4zaJYeM52Ryp3RKFlchz2tJrZQBKg6I7NRVds8vUlgn+Q
 OfRZCL009Pv8CuyWxTeZZ8NgmAAAR8NWdHVeBARww/igBekyZ+H2H7D5opC1Pdfr4mxel
 wUZAA710jM4Ku3P9v0igApOtdnVozAlZnaphFIkJqnX5Ur5HtHnZU+tKT+Fxk+Bdb3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792764167;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=fo/JuFe70XspyH36Dmk6DtS9wxGE9SpiubUjyY+1FGs=;
 b=QdQE4emebgSMrsno+S/gp8V2XoaDQObmIbK99TZzydFgMf5HsCqG6BnCgmibHJlnPelc
 UeI9eVHMMORGGdToT3FTmSqPhqvvPlnS9a3kKP0EG1K/XLI9gAJPhL1DSdM5wdCUvq61+
 rYyu4JmKNxrZyP1VDwXRrYGV37ED3Q6f5gCn5V+XnnG0RWiHx5ti4Iy+9mb+ELPaz0EPV
 0RAYVHqI6HbLmeNDVBkzFQRkUW9rB4rs64Y1gg+3beqg9bOw8+fZmkhiF/SUN7eU6I/yK
 6tJ5w4NtMZFCZQ0JrX0y/RjBFF+h0pIszMPiJB6sAzB9F5I+QF7sSWxhu+IpIQr9hlA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="R9V6I76/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=R9V6I76/
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 681C360660
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:02:47 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6aa9606ddadso634033eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792764166; x=1793368966;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fo/JuFe70XspyH36Dmk6DtS9wxGE9SpiubUjyY+1FGs=;
 b=R9V6I76/3FxgeKmdO0bGrdU2SOWNG1g3Fqj/QXCGdlJCOVVeX48A+tBJWbybewoXn/
 38YqYSmrNL1RwnsuonvJb2k0PUwWz4uAYz5YaNUNbVbXygf5N6OooM30gxnRbRUdPtar
 4ZLCwFTXGOZpKzRwN/KL+sTz13CPRy5ICsC28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764166; x=1793368966;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fo/JuFe70XspyH36Dmk6DtS9wxGE9SpiubUjyY+1FGs=;
 b=vyiWXR9XVfKrrEh1sRYqMPa3wNbAGKcXPqcM5hBzEqoI2Ef3o4FXHgYHSJFLw6aPNr
 YliGkvp6bQUOUSWd7Rr7eLkeER0ZpWWqgAACDFG9hB4GpwMm/izKx1nL1NIu244BDel/
 WPJo9MySVvHfzsESxaxvO9ve//dN3R/Mug5mahaFIwy2omKk1p3ULsvQXRcdSTuZn/0T
 2xT/La9RvLsEkBblqEZFyQ8J/0UlhCYGWdAm7VcIirfqoIapCbdpln8TKWHJ2q1PAYC1
 Yl8GEy1XmBfyJLSWp46gYCPqrNuhJ6DZ/G+qkCKKGyiJuLp+VRa/oxnj06LIYOQnPyxq
 hl/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxV+n0So3YV6Ot3z/ccztn/U1L0/CQbUpNOYnplh+sOoOydwlVA64hUT0rsCuYF8zKL7cB5DaI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJjgxgMf+LXG0xux0KZ7iQLCsbEUWvGVqU/R4gYNNUZfStfIKyx
 A41Jk4G3laT02sT56Mq+kAZyxakTfrPBIac4UziSMcIqn6TmtIHgBw2J6qrlt252fZ0=
X-Gm-Gg: AYBFou0fu2O3JJb/rfbfXma+1uJTf1xdMLgMBtNlDoaS0i6M/qHIehdsfd2RsbrvDFJ
 Q4ZrVyH6GVa1YGsfBVor972zSsX/DxQbSARz0mK3dS4lsCM6bWvTODzRfGMd4N5R0npIwIFZ+GF
 CNzqyP69qXaxhD7mbj+ZxsN57F6WUWKEBTIijjyK5FdvPM0QWAQ0FxRpDviwVbTP/XCuIcAK9uC
 CYQHB7BfAPJx4I+sRfMgI4mSHsbKhy3iT/Xp+FCTmBx7GCFdOZSzz0wtcFEdDikiFpy3RgPM5hv
 Hb5K3Lsds/yVjv7juugWnmtNDr9D7DIDuh0fpn+OknAdRSG4djj3u0xD589Hmi2wa8zuc278pJH
 0pP5rYV1/sUA5zWp/oB05/9JBeN5BI3yQMtLQZbe/SO9r2briQnxkDvfSBTo/XON/MWxY5VmkKb
 04uoaU9Ph40sDeb+RdQlbDC5uC91lT6aCDrv5j8U2/6z/w+ob65dRfTeFT+bvx2nElklncIyFpT
 kUz4Nw3rawxiP75Fj+I2vV+wkzTnZcbQjsyIIG4agu6unlKCcfu1Tu/6qnuDhkMAiVJ7QGgXVaN
 jrCfAsRGj0s9hT1uiqwBY4VdA8udFRHxDaLFum22ijSGKGtmkK0oCkNmf4Sh1LeL6CMxgXQZfMl
 8SwF4Y6+Cq5aUEGyUNe317w==
X-Received: by 2002:a05:6820:8584:10b0:6d7:8f37:8b99 with SMTP id
 006d021491bc7-70b885c5045mr1138220eaf.0.1792764166053; 
 Fri, 23 Oct 2026 07:02:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9ad1c6fbsm121455eaf.2.2026.10.23.07.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:02:45 -0700 (PDT)
Date: Fri, 23 Oct 2026 08:02:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, kr.sowmiya@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 2/2] mach-snapdragon: Kconfig: add CDT configs
Message-ID: <20261023140242.GF3596691@bill-the-cat>
References: <20261023084019.3722376-1-abhilash.v@oss.qualcomm.com>
 <20261023084019.3722376-3-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="08gUezfV/EHONBEN"
Content-Disposition: inline
In-Reply-To: <20261023084019.3722376-3-abhilash.v@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--08gUezfV/EHONBEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 01:40:19AM -0700, Abhilash V wrote:

> From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>=20
> Added CDT related config definition as part of feature enablement.
>=20
> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/Kconfig | 47 ++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/=
Kconfig
> index 9e23d6d8948..8ad9feb50a7 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -76,6 +76,53 @@ config QCOM_HWDETECT
>  	  Hardware parameter detection from SMEM and TCSR for
>  	  DTB selection and other platform subsystems.
> =20
> +config QCOM_SPL_CDT_SUPPORTED
> +	bool "Enable CDT support in SPL"
> +	depends on SPL
> +	help
> +	  Enable support for reading the CDT off the boot medium during
> +	  SPL and staging it in IMEM, so that QCLIB can pick it up via
> +	  the interface table.
> +
> +if QCOM_SPL_CDT_SUPPORTED
> +
> +config QCOM_SPL_CDT_PARTITION_NAME
> +	string "CDT GPT partition name"
> +	default "cdt"
> +	help
> +	  Name of the GPT partition on the boot medium containing the CDT
> +	  (Config/Chip Data Table) data.
> +
> +config QCOM_SPL_CDT_PARTITION_GUID
> +	string "CDT GPT partition type GUID"

This should have a default, yes?

> +	help
> +	  GPT partition type GUID identifying the CDT (Config/Chip Data
> +	  Table) partition on the boot medium.

These two should be in a choice with a reasonable default.

> +config QCOM_SPL_CDT_MMC_PARTITION_NUM
> +	int "eMMC hardware partition containing the CDT partition"
> +	default 0
> +	help
> +	  eMMC hardware partition number (0 =3D default user data area) on
> +	  which the CDT GPT partition is located. Ignored for non-MMC boot
> +	  media.
> +
> +config QCOM_SPL_BOOTIMEM_CDT_BASE
> +	hex "IMEM address to stage the CDT contents at"
> +	help
> +	  Address within BOOTIMEM where the CDT contents read from the boot
> +	  medium are staged, to be consumed by QCLIB via the interface
> +	  table.
> +
> +config QCOM_SPL_BOOTIMEM_CDT_SIZE
> +	hex "Maximum number of bytes to stage for the CDT"
> +	default 0x200
> +	help
> +	  Maximum number of bytes read from the CDT partition and staged at
> +	  CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE.
> +
> +endif # QCOM_SPL_CDT_SUPPORTED
> +
>  config QCOM_TMEL_ELF
>  	string "TME Elf to concatenate with U-Boot SPL MBN image"
>  	depends on SPL && QCOM_GENERATE_MBN
> --=20
> 2.34.1
>=20

--=20
Tom

--08gUezfV/EHONBEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCattpAgAKCRAr4qD1Cr/k
CqgaAP0djuRO/XHArAzJnX4MfMRLo4yL2M9anMyAAvyetedxVAEA/cgpbWpL0jDH
UxAnvha+HzpGuElQYx7L0gzw9TksHgw=
=3R1A
-----END PGP SIGNATURE-----

--08gUezfV/EHONBEN--
