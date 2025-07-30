Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94CDC87FCC
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 11:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C441B81E13;
	Wed, 30 Jul 2025 13:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HL3OcHto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CF1C80050; Wed, 30 Jul 2025 13:20:45 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A88B82F00
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 13:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-55b829c7f1aso367344e87.2
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 04:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753874439; x=1754479239; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEhQPX9cLaDbTr0bTJav4oQrxCs4Kc2YKD00tqJpPpA=;
 b=HL3OcHtoaiQW0UVelifvGQNLtUBADMRKFIvirW777ISm8XacBgEhgQmL67CYyrzIYv
 7Y9VdrI4hyq5nTeZr4blC7l4JSjBf6pn0bY/USpDVxyLra/yHCySpKb49yu+n7IUDAsA
 NFGnp0Aanf5jc1P7xC742NIVWPMa6V/LR4HxWmVzMelWrzaDE4NzacpBZSpcp5KMOWwk
 ZUllfBwcuWV4n4mdgIeyMttFSoCSVS42XPHLPWCCyjO8F4GHeOW6sIfp4jljWVRWY+re
 y1YJ+IlMmlO2xCndr3Neynlb5T8EMiuZLGw7I/y307BWEcfOM6m3pwe4XkjQoXQJpYKx
 GJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753874439; x=1754479239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IEhQPX9cLaDbTr0bTJav4oQrxCs4Kc2YKD00tqJpPpA=;
 b=PetJbWdYk1YH7i4JR1x48MU4GEdNwLb0iN367CPFKNnIF5IsRfZz3E7Ne8XhbnRBf5
 q/r86kyLQZGkjoFB+eGpvaCzUHFQaM7lQArFewZCkNT5OaEV2T10y0FOdI88JOZ7rfnd
 g+Bd///KPphD+aaHL8dewskw3Cvfzg9WQjMApDMv2k/WX3dUrQUD6tM3gVod3Tk7iMuR
 sbbvwdPspY2nXClFVaSCaqumADX34lQI4tjRLe5Df80uSFkCte5skn407rsbHlaIX2WT
 ahlFYpuiPbzHFyxaUxKVzq0n6gbIE8ecHIGf2bB6yp64Mzgin5u6ZTj46rEANzySBZ/F
 ZmnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFG7civRjgudJUKs/s4jEh9SRA02HWyKyzneDcfcNpfn3Q0SB6Ty92OmQfDS+fctt/V+sfZuE=@lists.denx.de
X-Gm-Message-State: AOJu0YwaqpUT4GTiCTHKMrBCiuRGixISYDqcQ0clgpBKy9EwJKsxXRpk
 1JGa7u0q+h8AWT5K6KBBL1Z7PZFwwFNHd4MockrT+zNoXVom07We5FAh5sn6cN+TPMPMaQG5epo
 1bT3ffYeilxoHsS/HlShzFgyLAB0JeMWfciKi
X-Gm-Gg: ASbGncuN1+/2Rm89t+2SMo8xXM04WMKxbiEXbWjBbuucbAjAd2u8kO8TaG0I9yu9iDx
 kt+sGRhuRk+VTZOPYQfFqeSyar2ZsOr4Q1/bcsdY+EXhE7pXwCJu1fSB+g6hw02T4lfQwKNKru3
 t3VfntBCzYZu77TWMXflOgTW6A6GAzp8O53WX65OFKpDKjJWiWn0deOQAKjTSINh55JTm1pi4ra
 /0KQDKmUSs3QufcY8Lio+dzs25pRFGzonMrTqsA1Y0vk6uRgw==
X-Google-Smtp-Source: AGHT+IHJwrIgb8MRFr5wM93Kf6bbbwGxd7R5l296fxc23S+MtJtd7mpctVL3BSgmAH8qlbtwN8yYHrDa+5sVK71by3c=
X-Received: by 2002:ac2:4bc1:0:b0:55b:574c:6c18 with SMTP id
 2adb3069b0e04-55b7c08273cmr1021594e87.32.1753874439148; Wed, 30 Jul 2025
 04:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
 <20250728-ddr-imx-v1-3-73da75bb33d3@nxp.com>
In-Reply-To: <20250728-ddr-imx-v1-3-73da75bb33d3@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Jul 2025 08:20:27 -0300
X-Gm-Features: Ac12FXydOntqimFnECYWt4UEJwI5N7tWWNFDcpzswhIdL9j3BPO7EEoU7TzSNHI
Message-ID: <CAOMZO5A5hZHb4OF4F1JoZThSNFCxXnuRvNXDrYK+d1bmb7yGBw@mail.gmail.com>
Subject: Re: [PATCH 3/9] ddr: imx9: Wait until dram initialization complete
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, "Tom.zheng" <haidong.zheng@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Jul 27, 2025 at 11:14=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: "Tom.zheng" <haidong.zheng@nxp.com>

No need to enclose the name with " and put a dot between the names.

>
> If the DDR data INIT bit is set, and ddr is running at low frequency,
> need to make sure DDR initialization complete before continue.
> Otherwise, unpredictable behavior when inline ECC id enabled.
>
> Signed-off-by: Tom.zheng <haidong.zheng@nxp.com>

Tom Zheng (without the dot in the middle).

> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/include/asm/arch-imx9/ddr.h |  1 +
>  drivers/ddr/imx/imx9/ddr_init.c      | 18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/=
arch-imx9/ddr.h
> index a8e3f7354c7b3557b14e6f81c93d7c719171aa4d..31c420198f667f0dd334c896f=
e9ab0b06797641e 100644
> --- a/arch/arm/include/asm/arch-imx9/ddr.h
> +++ b/arch/arm/include/asm/arch-imx9/ddr.h
> @@ -19,6 +19,7 @@
>  #define REG_DDRDSR_2                   (DDR_CTL_BASE + 0xB24)
>  #define REG_DDR_TIMING_CFG_0   (DDR_CTL_BASE + 0x104)
>  #define REG_DDR_SDRAM_CFG              (DDR_CTL_BASE + 0x110)
> +#define REG_DDR_SDRAM_CFG2             (DDR_CTL_BASE + 0x114)
>  #define REG_DDR_TIMING_CFG_4   (DDR_CTL_BASE + 0x160)
>  #define REG_DDR_DEBUG_19               (DDR_CTL_BASE + 0xF48)
>  #define REG_DDR_SDRAM_CFG_3    (DDR_CTL_BASE + 0x260)
> diff --git a/drivers/ddr/imx/imx9/ddr_init.c b/drivers/ddr/imx/imx9/ddr_i=
nit.c
> index 7bade70bd0a1ca4d205ff4fb8525511188cb504f..5a134dda78a331c21d4a75b23=
69c5b9314028bbc 100644
> --- a/drivers/ddr/imx/imx9/ddr_init.c
> +++ b/drivers/ddr/imx/imx9/ddr_init.c
> @@ -342,9 +342,11 @@ int ddr_init(struct dram_timing_info *dram_timing)
>         unsigned int initial_drate;
>         struct dram_timing_info *saved_timing;
>         void *fsp;
> -       int ret;
> +       int i, ret;
>         u32 mr12, mr14;
>         u32 regval;
> +       struct dram_cfg_param *ddrc_cfg;
> +       unsigned int ddrc_cfg_num;
>
>         debug("DDRINFO: start DRAM init\n");
>
> @@ -387,6 +389,20 @@ int ddr_init(struct dram_timing_info *dram_timing)
>
>         check_ddrc_idle();
>
> +       /* if DRAM Data INIT set, wait it be completed */
> +       ddrc_cfg =3D dram_timing->ddrc_cfg;
> +       ddrc_cfg_num =3D dram_timing->ddrc_cfg_num;
> +       for (i =3D 0; i < ddrc_cfg_num; i++) {
> +               if (ddrc_cfg->reg =3D=3D REG_DDR_SDRAM_CFG2) {
> +                       if (ddrc_cfg->val & 0x10) {
> +                               while (readl(REG_DDR_SDRAM_CFG2) & 0x10)
> +                                       ;

Consider using readl_poll_timeout() here as well.
