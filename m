Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0198E8B397
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 18:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF5083AA4;
	Wed,  4 Feb 2026 19:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c3YhOuqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF60B83AA4; Wed,  4 Feb 2026 19:19:02 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCEAC83A47
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 19:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso1134755e9.0
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 10:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770229139; x=1770833939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7G/VeGnvSn++YYkUOT1FtpaOeyTE/ZnEWlXFrXp7Dco=;
 b=c3YhOuqG2shyi52uA4ViX5MlC0Sql8Yp8ilBw8TgHe8hHj79DCzZGsQV3Ci/TaMsaF
 c41ss3We4bcRR2ggVcLHShpWT8vYarBe+JETz/v+Xhtq8CrnSrAB2ETpE493NpjLIVCF
 IF5i2jAWvniS5qzfpjsF23WNjNzmCa7r8RUrbm6Fc6a9mEFWmzQCewJJGaLrkKZSMfjW
 v3DUuJ7FsxV0m+LAEJ8utvLf+hLM4bY1r7w/N+FVcTSGRGrLbinV0YTOaRgV5tuIlHF6
 lmk0Q9FumclT1g6xlAsYHRINLlpajskWGFniBxh8Q/psXyCKwSeAG7eSOlv0mgZa7mIJ
 9DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229139; x=1770833939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7G/VeGnvSn++YYkUOT1FtpaOeyTE/ZnEWlXFrXp7Dco=;
 b=deV4xntLr8ZUVzZUQrSqoA6jaWPM92/vePZRPCQFkpS6jD0Q3I+6f2gDvl8/SxCQUt
 +2E1VohGHNAMnh5A5X30a8H2v808QUMNJ2Mkc6ZfH7lKw2ytllovA3hJ0RpdTzkn82IC
 1n7DC+FYdjXZ313pXXCFgn6N6a1cbbwpS6VWIhqeKj0CTfXRO9zlpUaGEtkKb1w3K3nm
 XYtT2i5X/jtniDmT/0zouyXkjwUr+aYMj+gGdC9pH7eDtZEMRgznMVuT8tYH7CdFuB9+
 pIaMJWrwT34y3ccpSw6G+ND2ACWfYtfCW5FjLxI99zl3iQxyNekNlr5CmxGc4p3/vmdY
 f5hw==
X-Gm-Message-State: AOJu0Yx2RunKtIARbPseS6l28N3IFK4WJ637X4CEQVFh9RwnIv92pxlc
 rxkxzCXW+27MUOWh7u4h8byE/Kfu0fIAk18U+G3ti3OVGtCdbi2Q/JzrTCjgik5j
X-Gm-Gg: AZuq6aJw881nHYoQAjMyZ2a0SwUpHSHbPbsU6TuTmP16E2Gn/xd2UqUsxcgUCcUOnsR
 w6rbw3i38q67Nv5pVpXI8+A3bogUpdhLxhAhsV9u8ikmONOwFMvzA1sVUdOA0f+3Z8pOQUOmk/8
 pJy4dDzUNd14wV3d0uuFcbCYuX7/qhfDAOyArjeG8f018vvoqz0YwB8uyb2vA5BvAsVufAFd1n9
 1MOD2WBDgKuxXEfD8/nd+i94sgzqs94bsabAsHsXc3hA0/FFIBZzzfAbl52nIr2og4eK91VLAHz
 5GFmEjKYWNY6HONjvSY2snyGa9aF/oyWXJ6G8R3gtJ2H/YuHoNkq+sxfNYoNj9vMggbxtTWHkBx
 EcQpu6x+NjMk9QuZ5/7jp10IgKZIj5lvhnUosopuf+8XtZSLjC+GLfOTaYs6tHBACOHal+ztlTJ
 5KuUqYmmDwTzzq9xQ2OqGqOPeFD7WP8ZKRehcI32tSHvaKIPX7e8hw5U1w7BjjmV68Cjg4
X-Received: by 2002:a05:600c:5304:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-4830e8d1f1cmr52047225e9.0.1770229139172; 
 Wed, 04 Feb 2026 10:18:59 -0800 (PST)
Received: from jernej-laptop.localnet (178-79-79-213.dynamic.telemach.net.
 [178.79.79.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d835f0sm953745e9.14.2026.02.04.10.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 10:18:58 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Paul Kocialkowski <contact@paulk.fr>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <paulk@sys-base.io>
Subject: Re: [PATCH v2 1/3] sunxi: a133: dram: Add NSI arbiter configuration
 support
Date: Wed, 04 Feb 2026 18:33:29 +0100
Message-ID: <5961927.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20260128235727.1322861-1-contact@paulk.fr>
References: <20260128235727.1322861-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne =C4=8Detrtek, 29. januar 2026 ob 00:57:15 Srednjeevropski standardni =
=C4=8Das je Paul Kocialkowski napisal(a):
> From: Paul Kocialkowski <paulk@sys-base.io>
>=20
> In previous generations of Allwinner SoCs, the memory bus (MBUS) access
> arbitration was configured as part of the DRAM top registers. This is no
> longer the case starting with the A133, which has a dedicated base
> address for the bus arbiter that is now called NSI instead of MBUS.
>=20
> NSI appears to be a later iteration of MBUS design, with new dedicated
> registers that resemble the previous MBUS ones. Despite NSI not being
> documented in the manual, the A133 BSP includes a nsi driver with some
> description of the registers. Like previous generations, it implements
> port arbitration priority for DRAM access and also supports an optional
> QoS mode based on bandwidth limits.
>=20
> Configuring port arbitration priority is especially important to make
> sure that critical masters are not starved by other less important
> ones. This is especially the case with the display engine that needs
> to be able to fetch pixels in time for scanout and can easily be
> starved by CPU or GPU access.
>=20
> This introduces support for the NSI arbiter in the A133 DRAM init
> code. The list and order of available ports are highly SoC-specific
> and the default config values are set to match the BSP's defaults.
>=20
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> Sponsored-by: MEC Electronics GmbH <https://www.mec.at/>

This code looks good in general. However, since NSI seems common
thing for newer SoCs (like A523, which is already included in U-Boot),
I think it would be better to make some kind of NSI module instead of
duplicating definitions for each SoCs.

I dislike current MBUS approach, but that was done due to organic code
growth without planning. Let's not repeat that here.

Best regards,
Jernej

> ---
>  .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |  4 ++
>  .../include/asm/arch-sunxi/dram_sun50i_a133.h | 36 ++++++++++
>  arch/arm/mach-sunxi/dram_sun50i_a133.c        | 67 ++++++++++++++++++-
>  3 files changed, 106 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h b/arch/arm/i=
nclude/asm/arch-sunxi/cpu_sun50i_h6.h
> index 2a9b086991c3..8e80c520706b 100644
> --- a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
> +++ b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
> @@ -16,6 +16,10 @@
> =20
>  #define SUNXI_GIC400_BASE		0x03020000
> =20
> +#ifdef CONFIG_MACH_SUN50I_A133
> +#define SUNXI_NSI_BASE			0x03100000
> +#endif
> +
>  #ifdef CONFIG_MACH_SUN50I_H6
>  #define SUNXI_DRAM_COM_BASE		0x04002000
>  #define SUNXI_DRAM_CTL0_BASE		0x04003000
> diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h b/arch/ar=
m/include/asm/arch-sunxi/dram_sun50i_a133.h
> index a5fc6ad36560..eadec74cc2b6 100644
> --- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
> +++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
> @@ -24,6 +24,42 @@ static inline int ns_to_t(int nanoseconds)
>  	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
>  }
> =20
> +#define SUNXI_NSI_MODE_REG(i)		((i) * 0x200 + 0x10)
> +#define SUNXI_NSI_PRI_CFG_REG(i)	((i) * 0x200 + 0x14)
> +#define SUNXI_NSI_PRI_CFG_RD(v)		(((v) & 0x3) << 2)
> +#define SUNXI_NSI_PRI_CFG_WR(v)		((v) & 0x3)
> +#define SUNXI_NSI_PRI_CFG_LOWEST	0
> +#define SUNXI_NSI_PRI_CFG_LOW		1
> +#define SUNXI_NSI_PRI_CFG_HIGH		2
> +#define SUNXI_NSI_PRI_CFG_HIGHEST	3
> +#define SUNXI_NSI_IO_CFG_REG(i)		((i) * 0x200 + 0x18)
> +#define SUNXI_NSI_IO_CFG_QOS_SEL_OUTPUT	0
> +#define SUNXI_NSI_IO_CFG_QOS_SEL_INPUT	1
> +#define SUNXI_NSI_ENABLE_REG(i)		((i) * 0x200 + 0xc0)
> +
> +enum sunxi_nsi_port {
> +	SUNXI_NSI_PORT_CPU	=3D 0,
> +	SUNXI_NSI_PORT_GPU,
> +	SUNXI_NSI_PORT_SD1,
> +	SUNXI_NSI_PORT_MSTG,
> +	SUNXI_NSI_PORT_GMAC0,
> +	SUNXI_NSI_PORT_GMAC1,
> +	SUNXI_NSI_PORT_USB0,
> +	SUNXI_NSI_PORT_USB1,
> +	SUNXI_NSI_PORT_NDFC,
> +	SUNXI_NSI_PORT_DMAC,
> +	SUNXI_NSI_PORT_CE,
> +	SUNXI_NSI_PORT_DE0,
> +	SUNXI_NSI_PORT_DE1,
> +	SUNXI_NSI_PORT_VE,
> +	SUNXI_NSI_PORT_CSI,
> +	SUNXI_NSI_PORT_ISP,
> +	SUNXI_NSI_PORT_G2D,
> +	SUNXI_NSI_PORT_EINK,
> +	SUNXI_NSI_PORT_IOMMU,
> +	SUNXI_NSI_PORT_CPUS,
> +};
> +
>  /* MBUS part is largely the same as in H6, except for one special regist=
er */
>  #define MCTL_COM_UNK_008	0x008
>  /* NOTE: This register has the same importance as mctl_ctl->clken in H61=
6 */
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_a133.c b/arch/arm/mach-sunxi=
/dram_sun50i_a133.c
> index 1496f99624dd..204810aecf2a 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_a133.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_a133.c
> @@ -69,6 +69,66 @@ static const u8 phy_init[] =3D {
>  };
>  #endif
> =20
> +static void nsi_configure_port(unsigned int port, u8 pri, u8 qos_sel)
> +{
> +	void *base =3D (void *)SUNXI_NSI_BASE;
> +	u32 pri_cfg;
> +
> +	/* QoS with bandwidth limits is not supported, disable it. */
> +	writel(0, base + SUNXI_NSI_MODE_REG(port));
> +	writel(0, base + SUNXI_NSI_ENABLE_REG(port));
> +
> +	/*
> +	 * QoS direction selection should not be in use, but set it nevertheless
> +	 * to match the BSP behavior (in case it has some other meaning).
> +	 */
> +	writel(qos_sel, base + SUNXI_NSI_IO_CFG_REG(port));
> +
> +	/* Port priority is always active. */
> +	pri_cfg =3D SUNXI_NSI_PRI_CFG_RD(pri) | SUNXI_NSI_PRI_CFG_WR(pri);
> +
> +	writel(pri_cfg, base + SUNXI_NSI_PRI_CFG_REG(port));
> +}
> +
> +#define NSI_CONF(port, pri, qos_sel) \
> +	{ SUNXI_NSI_PORT_ ## port, SUNXI_NSI_PRI_CFG_ ## pri, \
> +	  SUNXI_NSI_IO_CFG_QOS_SEL_ ## qos_sel }
> +
> +static void nsi_set_master_priority(void)
> +{
> +	struct {
> +		unsigned int port;
> +		u8 pri;
> +		u8 qos_sel;
> +	} ports[] =3D {
> +		NSI_CONF(CPU,	LOWEST,		INPUT),
> +		NSI_CONF(GPU,	LOWEST,		INPUT),
> +		NSI_CONF(SD1,	LOWEST,		OUTPUT),
> +		NSI_CONF(MSTG,	LOWEST,		OUTPUT),
> +		NSI_CONF(GMAC0,	LOWEST,		OUTPUT),
> +		NSI_CONF(GMAC1,	LOWEST,		OUTPUT),
> +		NSI_CONF(USB0,	LOWEST,		OUTPUT),
> +		NSI_CONF(USB1,	LOWEST,		OUTPUT),
> +		NSI_CONF(NDFC,	LOWEST,		OUTPUT),
> +		NSI_CONF(DMAC,	LOWEST,		OUTPUT),
> +		NSI_CONF(CE,	LOWEST,		OUTPUT),
> +		NSI_CONF(DE0,	HIGH,		INPUT),
> +		NSI_CONF(DE1,	HIGH,		INPUT),
> +		NSI_CONF(VE,	LOWEST,		INPUT),
> +		NSI_CONF(CSI,	HIGH,		INPUT),
> +		NSI_CONF(ISP,	HIGH,		INPUT),
> +		NSI_CONF(G2D,	LOWEST,		INPUT),
> +		NSI_CONF(EINK,	LOWEST,		OUTPUT),
> +		NSI_CONF(IOMMU,	HIGHEST,	INPUT),
> +		NSI_CONF(CPUS,	LOWEST,		OUTPUT),
> +	};
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ports); i++)
> +		nsi_configure_port(ports[i].port, ports[i].pri,
> +				   ports[i].qos_sel);
> +}
> +
>  static void mctl_clk_init(u32 clk)
>  {
>  	void * const ccm =3D (void *)SUNXI_CCM_BASE;
> @@ -1184,6 +1244,7 @@ static const struct dram_para para =3D {
>  unsigned long sunxi_dram_init(void)
>  {
>  	struct dram_config config;
> +	unsigned long size;
> =20
>  	/* Writing to undocumented SYS_CFG area, according to user manual. */
>  	setbits_le32(0x03000160, BIT(8));
> @@ -1200,5 +1261,9 @@ unsigned long sunxi_dram_init(void)
>  	      1U << config.bankgrps, 1U << config.ranks,
>  	      16U << config.bus_full_width);
> =20
> -	return calculate_dram_size(&config);
> +	size =3D calculate_dram_size(&config);
> +
> +	nsi_set_master_priority();
> +
> +	return size;
>  }
>=20




