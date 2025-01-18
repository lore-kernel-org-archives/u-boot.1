Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F629C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 08:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C888063E;
	Sat, 18 Jan 2025 09:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mre3HEl9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80C8C8070C; Sat, 18 Jan 2025 09:17:21 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D276E80312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 09:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so489533866b.2
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 00:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737188237; x=1737793037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eBwN5WPDB0kxSU4SNmk6NPLEEyaV6MB3pLBqLv61y7g=;
 b=Mre3HEl9eQdxJAg63BZ0sHc/8wK3czTM7ZaFxCY09WNbVqzVgCugTdE6rsWQL4GP7Q
 kVnWwcqi6b0Q+SiG8DO+/dzm/u+74dlJEaXR5FTxnH1WISM+zr7+5xx7eRMpTzPMD9xY
 lRq5dJtoDKELgSy2Ae/saWQYBL5Md7ASA+2f3Sw1Ml6MpC8PBotoTlxlySNmu3OpE43r
 gYCyF2uTllc6PVB0I3diUf9zEKwEYViWLSuSXg7Gwqzp3ZXkyIR6lTqGbFQzrGMcUAAE
 n+b9Q9WkKgd0R/hWJ6wDVgO8zuLEKRcAaLhnXkKXo/Qvc3kT5yzgeMqsywetu4Tc2QlM
 qLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737188237; x=1737793037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eBwN5WPDB0kxSU4SNmk6NPLEEyaV6MB3pLBqLv61y7g=;
 b=fMR65nKTqAbk1WRhaNBiXVVaiYRaUWLG2vh4cj2S2R8Er+JKr/1KamYs84dpR4uY7x
 woxrA1DGmMj+q4jxPH9zsGdztawApyTBO56d77eXbOEiuptdEi4zxo7pZ89TculHsmel
 M1AVZv8Zu1SiE+Pg82xfaTba4E7AD9rdb1i2akJkqnTUSt/pXoK281FHTz3EjfEg4B5C
 3RDJcG82B05PEN0ISz7FYlAVgLUVoUjQVxwFZsPbh36lrd92iS8CGoCuEeuBcGsK2hLP
 PcwKpJU4cAQ8rRUoD9uTEFPK1RUP3BcG6ZEmIwzqdDBqHjwFBiMrZ4RNw1WlZKmqwass
 QxpQ==
X-Gm-Message-State: AOJu0YyGcdGLBk9jyyHvIrBysbuS+t0mcqBCNtau2A1oufWgp+klBLKP
 HHUwKgvWXrP428yRngb8BSAeH4JWwVU56oqmN0lZcO2K7A028j/Y8dJo3A==
X-Gm-Gg: ASbGncsnaEQqv61cdF/DxSZEDbDjlg4RkZB1lYGaclnv7+yX92agO0Xo4BQIYje+Avf
 Mxgf78mFrmG3eZqYyNV3WN4CYSf8xu90yg7AVEyL7lnj+2c47+DkM0A3qLlH4y5KRekkD/W1Wzn
 3xMc61nPLDCMVP1xgLhqU6ivWcm0xFpb4vqGOmB1ubCsBHNmsHuJaNHhAW1cRKrUyjp4GRdkyFY
 FC4MhXcW8PbIiwp3B98hqV7P+17V6bXnc9/WB0eDlggYOWKI1aY8kMHEIW19xIghQ0ZCr73oonv
 0A4gA31tkkXSQ78=
X-Google-Smtp-Source: AGHT+IE3oztlU+PgQ8yF4nuegfWlOMxrfGsTq2cznlkw5iqmrwkJkgsFhuuEW/KFpWornwV9zax9vA==
X-Received: by 2002:a17:907:8691:b0:aa6:7470:8efe with SMTP id
 a640c23a62f3a-ab38b10cf47mr455451266b.13.1737188236556; 
 Sat, 18 Jan 2025 00:17:16 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f860f9sm298104766b.136.2025.01.18.00.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 00:17:15 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Simon Glass <sjg@chromium.org>, linux-sunxi@lists.linux.dev,
 Parthiban <parthiban@linumiz.com>
Subject: Re: [PATCH 7/8] sunxi: A133: add DRAM init code [WIP!]
Date: Sat, 18 Jan 2025 09:17:14 +0100
Message-ID: <23798710.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20250117014537.22513-8-andre.przywara@arm.com>
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <20250117014537.22513-8-andre.przywara@arm.com>
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

Dne petek, 17. januar 2025 ob 02:45:36 Srednjeevropski standardni =C4=8Das =
je Andre Przywara napisal(a):
> From: Cody Eksal <masterr3c0rd@epochal.quest>
>=20
> This adds preliminary support for the DRAM controller in the Allwinner
> A100/A133 SoCs.
> This is work in progress, and has rough edges, but works on at least
> three different boards. It contains support for DDR4 and LPDDR4.

Since this is clearly WIP and SoF missing, just some comments below.

> ---
>  .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |    4 +
>  arch/arm/include/asm/arch-sunxi/dram.h        |    2 +
>  .../include/asm/arch-sunxi/dram_sun50i_a133.h |  210 +++
>  arch/arm/mach-sunxi/Kconfig                   |  184 ++-
>  arch/arm/mach-sunxi/Makefile                  |    2 +
>  arch/arm/mach-sunxi/dram_sun50i_a133.c        | 1217 +++++++++++++++++
>  arch/arm/mach-sunxi/dram_timings/Makefile     |    2 +
>  arch/arm/mach-sunxi/dram_timings/a133_ddr4.c  |   80 ++
>  .../arm/mach-sunxi/dram_timings/a133_lpddr4.c |  102 ++
>  9 files changed, 1795 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
>  create mode 100644 arch/arm/mach-sunxi/dram_sun50i_a133.c
>  create mode 100644 arch/arm/mach-sunxi/dram_timings/a133_ddr4.c
>  create mode 100644 arch/arm/mach-sunxi/dram_timings/a133_lpddr4.c
>=20
> diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h b/arch/arm/i=
nclude/asm/arch-sunxi/cpu_sun50i_h6.h
> index 8a3f465545a..2a9b086991c 100644
> --- a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
> +++ b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
> @@ -29,6 +29,10 @@
>  #define SUNXI_DRAM_COM_BASE		0x047FA000
>  #define SUNXI_DRAM_CTL0_BASE		0x047FB000
>  #define SUNXI_DRAM_PHY0_BASE		0x04800000
> +#elif CONFIG_MACH_SUN50I_A133
> +#define SUNXI_DRAM_COM_BASE		0x04810000
> +#define SUNXI_DRAM_CTL0_BASE		0x04820000
> +#define SUNXI_DRAM_PHY0_BASE		0x04830000
>  #endif
> =20
>  #define SUNXI_TWI0_BASE			0x05002000
> diff --git a/arch/arm/include/asm/arch-sunxi/dram.h b/arch/arm/include/as=
m/arch-sunxi/dram.h
> index 9d21b492418..0708ae3ee3b 100644
> --- a/arch/arm/include/asm/arch-sunxi/dram.h
> +++ b/arch/arm/include/asm/arch-sunxi/dram.h
> @@ -31,6 +31,8 @@
>  #include <asm/arch/dram_sun50i_h6.h>
>  #elif defined(CONFIG_MACH_SUN50I_H616)
>  #include <asm/arch/dram_sun50i_h616.h>
> +#elif defined(CONFIG_DRAM_SUN50I_A133)
> +#include <asm/arch/dram_sun50i_a133.h>
>  #elif defined(CONFIG_MACH_SUNIV)
>  #include <asm/arch/dram_suniv.h>
>  #else
> diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h b/arch/ar=
m/include/asm/arch-sunxi/dram_sun50i_a133.h
> new file mode 100644
> index 00000000000..8e5b86ba492
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier:	GPL-2.0+
> +/*
> + * A133 dram controller register and constant defines
> + *
> + * (C) Copyright 2024  MasterR3C0RD <masterr3c0rd@epochal.quest>
> + */
> +
> +#ifndef _SUNXI_DRAM_SUN50I_A133_H
> +#define _SUNXI_DRAM_SUN50I_A133_H
> +
> +#include <stdbool.h>
> +#ifndef __ASSEMBLY__
> +#include <linux/bitops.h>
> +#endif
> +
> +enum sunxi_dram_type {
> +	SUNXI_DRAM_TYPE_DDR3 =3D 3,
> +	SUNXI_DRAM_TYPE_DDR4,
> +	SUNXI_DRAM_TYPE_LPDDR3 =3D 7,
> +	SUNXI_DRAM_TYPE_LPDDR4
> +};
> +
> +static inline int ns_to_t(int nanoseconds)
> +{
> +	const unsigned int ctrl_freq =3D CONFIG_DRAM_CLK / 2;
> +
> +	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
> +}
> +
> +/* MBUS part is largely the same as in H6, except for one special regist=
er */
> +struct sunxi_mctl_com_reg {
> +	u32 cr; 		/* 0x000 control register */
> +	u8 reserved_0x004[4]; 	/* 0x004 */
> +	u32 unk_0x008; 		/* 0x008 */
> +	u32 tmr; 		/* 0x00c timer register */
> +	u8 reserved_0x010[4]; 	/* 0x010 */
> +	u32 unk_0x014; 		/* 0x014 */
> +	u8 reserved_0x018[8]; 	/* 0x018 */
> +	u32 maer0; 		/* 0x020 master enable register 0 */
> +				/* NOTE: This register has the same importance as mctl_ctl->clken in=
 H616 */
> +	u32 maer1; 		/* 0x024 master enable register 1 */
> +	u32 maer2; 		/* 0x028 master enable register 2 */
> +	u8 reserved_0x02c[468]; /* 0x02c */
> +	u32 bwcr; 		/* 0x200 bandwidth control register */
> +	u8 reserved_0x204[12];	/* 0x204 */
> +	/*
> +   	 * The last master configured by BSP libdram is at 0x49x, so the
> +   	 * size of this struct array is set to 41 (0x29) now.
> +   	*/
> +	struct {
> +		u32 cfg0; 		/* 0x0 */
> +		u32 cfg1; 		/* 0x4 */
> +		u8 reserved_0x8[8];	/* 0x8 */
> +	} master[41]; 		/* 0x210 + index * 0x10 */
> +	u8 reserved_0x4a0[96];	/* 0x4a0 */
> +	u32 unk_0x500;		/* 0x500 */
> +};
> +check_member(sunxi_mctl_com_reg, unk_0x500, 0x500);
> +
> +/*
> + * Controller registers seems to be the same or at least very similar
> + * to those in H6.
> + */
> +struct sunxi_mctl_ctl_reg {
> +	u32 mstr; 			/* 0x000 */
> +	u32 statr; 			/* 0x004 unused */
> +	u32 mstr1; 			/* 0x008 unused */
> +	u32 clken; 			/* 0x00c */
> +	u32 mrctrl0; 			/* 0x010 unused */
> +	u32 mrctrl1; 			/* 0x014 unused */
> +	u32 mrstatr; 			/* 0x018 unused */
> +	u32 mrctrl2; 			/* 0x01c unused */
> +	u32 derateen; 			/* 0x020 unused */
> +	u32 derateint; 			/* 0x024 unused */
> +	u8 reserved_0x028[8]; 		/* 0x028 */
> +	u32 pwrctl; 			/* 0x030 unused */
> +	u32 pwrtmg; 			/* 0x034 unused */
> +	u32 hwlpctl; 			/* 0x038 unused */
> +	u8 reserved_0x03c[20];		/* 0x03c */
> +	u32 rfshctl0;			/* 0x050 unused */
> +	u32 rfshctl1;			/* 0x054 unused */
> +	u8 reserved_0x058[8];		/* 0x05c */
> +	u32 rfshctl3;			/* 0x060 */
> +	u32 rfshtmg;			/* 0x064 */
> +	u8 reserved_0x068[104];		/* 0x068 */
> +	u32 init[8];			/* 0x0d0 */
> +	u32 dimmctl;			/* 0x0f0 unused */
> +	u32 rankctl;			/* 0x0f4 */
> +	u8 reserved_0x0f8[8];		/* 0x0f8 */
> +	u32 dramtmg[17];		/* 0x100 */
> +	u8 reserved_0x144[60];		/* 0x144 */
> +	u32 zqctl[3];			/* 0x180 */
> +	u32 zqstat;			/* 0x18c unused */
> +	u32 dfitmg0;			/* 0x190 */
> +	u32 dfitmg1;			/* 0x194 */
> +	u32 dfilpcfg[2];		/* 0x198 unused */
> +	u32 dfiupd[3];			/* 0x1a0 */
> +	u32 reserved_0x1ac;		/* 0x1ac */
> +	u32 dfimisc;			/* 0x1b0 */
> +	u32 dfitmg2;			/* 0x1b4 unused */
> +	u32 dfitmg3;			/* 0x1b8 unused */
> +	u32 dfistat;			/* 0x1bc */
> +	u32 dbictl;			/* 0x1c0 */
> +	u8 reserved_0x1c4[60];		/* 0x1c4 */
> +	u32 addrmap[12];		/* 0x200 */
> +	u8 reserved_0x230[16];		/* 0x230 */
> +	u32 odtcfg;			/* 0x240 */
> +	u32 odtmap;			/* 0x244 */
> +	u8 reserved_0x248[8];		/* 0x248 */
> +	u32 sched[2];			/* 0x250 */
> +	u8 reserved_0x258[180]; 	/* 0x258 */
> +	u32 dbgcmd;			/* 0x30c unused */
> +	u32 dbgstat;			/* 0x310 unused */
> +	u8 reserved_0x314[12];		/* 0x314 */
> +	u32 swctl;			/* 0x320 */
> +	u32 swstat;			/* 0x324 */
> +	u8 reserved_0x328[7768];	/* 0x328 */
> +	u32 unk_0x2180;			/* 0x2180 */
> +	u8 reserved_0x2184[188];	/* 0x2184 */
> +	u32 unk_0x2240;			/* 0x2240 */
> +	u8 reserved_0x2244[3900];	/* 0x2244 */
> +	u32 unk_0x3180;			/* 0x3180 */
> +	u8 reserved_0x3184[188];	/* 0x3184 */
> +	u32 unk_0x3240;			/* 0x3240 */
> +	u8 reserved_0x3244[3900];	/* 0x3244 */
> +	u32 unk_0x4180;			/* 0x4180 */
> +	u8 reserved_0x4184[188];	/* 0x4184 */
> +	u32 unk_0x4240;			/* 0x4240 */
> +};
> +
> +check_member(sunxi_mctl_ctl_reg, swstat, 0x324);
> +check_member(sunxi_mctl_ctl_reg, unk_0x4240, 0x4240);
> +
> +#define MSTR_DEVICETYPE_DDR3	BIT(0)
> +#define MSTR_DEVICETYPE_LPDDR2	BIT(2)
> +#define MSTR_DEVICETYPE_LPDDR3	BIT(3)
> +#define MSTR_DEVICETYPE_DDR4	BIT(4)
> +#define MSTR_DEVICETYPE_LPDDR4	BIT(5)
> +#define MSTR_DEVICETYPE_MASK	GENMASK(5, 0)
> +#define MSTR_GEARDOWNMODE	BIT(0)		/* Same as MSTR_DEVICETYPE_DDR3, only =
used for DDR4 */
> +#define MSTR_2TMODE		BIT(10)
> +#define MSTR_BUSWIDTH_FULL	(0 << 12)
> +#define MSTR_BUSWIDTH_HALF	(1 << 12)
> +#define MSTR_ACTIVE_RANKS(x)	(((x =3D=3D 1) ? 3 : 1) << 24)
> +#define MSTR_BURST_LENGTH(x)	(((x) >> 1) << 16)
> +#define MSTR_DEVICECONFIG_X32	(3 << 30)
> +
> +#define TPR10_CA_BIT_DELAY	BIT(16)
> +#define TPR10_DX_BIT_DELAY0	BIT(17)
> +#define TPR10_DX_BIT_DELAY1	BIT(18)
> +#define TPR10_WRITE_LEVELING	BIT(20)
> +#define TPR10_READ_CALIBRATION	BIT(21)
> +#define TPR10_READ_TRAINING	BIT(22)
> +#define TPR10_WRITE_TRAINING	BIT(23)
> +
> +/* MRCTRL constants */
> +#define MRCTRL0_MR_RANKS_ALL	(3 << 4)
> +#define MRCTRL0_MR_ADDR(x)	(x << 12)
> +#define MRCTRL0_MR_WR		BIT(31)
> +
> +#define MRCTRL1_MR_ADDR(x)	(x << 8)
> +#define MRCTRL1_MR_DATA(x)	(x)
> +
> +/* TODO: Remove unused fields */
> +struct dram_para {
> +	uint32_t clk;
> +	enum sunxi_dram_type type;
> +	uint32_t dx_odt;
> +	uint32_t dx_dri;
> +	uint32_t ca_dri;
> +	uint32_t para0;
> +	uint32_t para1;
> +	uint32_t para2;
> +	uint32_t mr0;
> +	uint32_t mr1;
> +	uint32_t mr2;
> +	uint32_t mr3;
> +	uint32_t mr4;
> +	uint32_t mr5;
> +	uint32_t mr6;
> +	uint32_t mr11;
> +	uint32_t mr12;
> +	uint32_t mr13;
> +	uint32_t mr14;
> +	uint32_t mr16;
> +	uint32_t mr17;
> +	uint32_t mr22;
> +	uint32_t tpr1;
> +	uint32_t tpr2;
> +	uint32_t tpr3;
> +	uint32_t tpr6;
> +	uint32_t tpr10;
> +	uint32_t tpr11;
> +	uint32_t tpr12;
> +	uint32_t tpr13;
> +	uint32_t tpr14;

para0 - para2 are not needed once auto size, width, rank and (in case of
DDR4) bank groups is implemented.

Mode registers, or MR for short, don't need to be parameterized. They are
constant for specific type of DRAM, except ones that are clock dependent.
Those are overriden in code anyway.

TPR13 is not needed. It holds bits which tell if detection of size, rank
and width is needed and similar things. Those are (or should be) done anywa=
y.

> +};
> +
> +void mctl_set_timing_params(const struct dram_para *para);
> +
> +struct dram_config {
> +	u8 cols;		/* Column bits */
> +	u8 rows;		/* Row bits */
> +	u8 ranks;		/* Rank bits (different from H616!) */
> +	u8 banks;		/* Bank bits */
> +	u8 bankgrps;		/* Bank group bits */
> +	u8 bus_full_width;	/* 1 =3D x32, 0 =3D x16 */
> +};
> +
> +#endif /* _SUNXI_DRAM_SUN50I_A133_H */
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 78fd74f3f28..ccf0c9a403e 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -51,7 +51,13 @@ config DRAM_SUN50I_H616
>  	  Select this dram controller driver for some sun50i platforms,
>  	  like H616.
> =20
> -if DRAM_SUN50I_H616
> +config DRAM_SUN50I_A133
> +	bool
> +	help
> +	  Select this dram controller driver for some sun50i platforms,
> +	  like A133.
> +
> +if DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>  config DRAM_SUNXI_DX_ODT
>  	hex "DRAM DX ODT parameter"
>  	help
> @@ -73,18 +79,144 @@ config DRAM_SUNXI_ODT_EN
>  	help
>  	  ODT EN value from vendor DRAM settings.
> =20
> +config DRAM_SUNXI_PARA0
> +	hex "DRAM PARA0 parameter"
> +	depends on DRAM_SUN50I_A133
> +	help
> +	  PARA0 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_PARA1
> +	hex "DRAM PARA1 parameter"
> +	help
> +	  PARA1 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_PARA2
> +	hex "DRAM PARA2 parameter"
> +	help
> +	  PARA2 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR0
> +	hex "DRAM MR0 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR0 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR1
> +	hex "DRAM MR1 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR1 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR2
> +	hex "DRAM MR2 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR2 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR3
> +	hex "DRAM MR3 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR3 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR4
> +	hex "DRAM MR4 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR4 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR5
> +	hex "DRAM MR5 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR5 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR6
> +	hex "DRAM MR6 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR6 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR11
> +	hex "DRAM MR11 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR11 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR12
> +	hex "DRAM MR12 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR12 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR13
> +	hex "DRAM MR13 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR13 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR14
> +	hex "DRAM MR14 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR14 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR16
> +	hex "DRAM MR16 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR16 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR17
> +	hex "DRAM MR17 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR17 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR22
> +	hex "DRAM MR22 parameter"
> +	depends on !DRAM_SUN50I_A133

I guess exclamation point is a mistake here, but this config shouldn't
be needed (see above.)

> +	default 0x0
> +	help
> +	  MR22 value from vendor DRAM settings.
> +
>  config DRAM_SUNXI_TPR0
>  	hex "DRAM TPR0 parameter"
>  	default 0x0
>  	help
>  	  TPR0 value from vendor DRAM settings.
> =20
> +config DRAM_SUNXI_TPR1
> +	hex "DRAM TPR1 parameter"
> +	default 0x0
> +	help
> +	  TPR1 value from vendor DRAM settings.
> +
>  config DRAM_SUNXI_TPR2
>  	hex "DRAM TPR2 parameter"
>  	default 0x0
>  	help
>  	  TPR2 value from vendor DRAM settings.
> =20
> +config DRAM_SUNXI_TPR3
> +	hex "DRAM TPR3 parameter"
> +	default 0x0
> +	help
> +	  TPR3 value from vendor DRAM settings.
> +
>  config DRAM_SUNXI_TPR6
>  	hex "DRAM TPR6 parameter"
>  	default 0x3300c080
> @@ -109,6 +241,20 @@ config DRAM_SUNXI_TPR12
>  	help
>  	  TPR12 value from vendor DRAM settings.
> =20
> +config DRAM_SUNXI_TPR13
> +	hex "DRAM TPR13 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  TPR13 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_TPR14
> +	hex "DRAM TPR14 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  TPR14 value from vendor DRAM settings.
> +

Most of new configs are not needed, as discussed above.

>  choice
>  	prompt "DRAM PHY pin mapping selection"
>  	default DRAM_SUNXI_PHY_ADDR_MAP_0
> @@ -116,7 +262,8 @@ choice
>  config DRAM_SUNXI_PHY_ADDR_MAP_0
>  	bool "DRAM PHY address map 0"
>  	help
> -	  This pin mapping selection should be used by the H313, H616, H618.
> +	  This pin mapping selection should be used by the H313, H616, H618,
> +	  and A133, R818 SoCs.
> =20
>  config DRAM_SUNXI_PHY_ADDR_MAP_1
>  	bool "DRAM PHY address map 1"
> @@ -497,7 +644,7 @@ config ARM_BOOT_HOOK_RMR
>  	This allows both the SPL and the U-Boot proper to be entered in
>  	either mode and switch to AArch64 if needed.
> =20
> -if SUNXI_DRAM_DW || DRAM_SUN50I_H6 || DRAM_SUN50I_H616
> +if SUNXI_DRAM_DW || DRAM_SUN50I_H6 || DRAM_SUN50I_H616 || DRAM_SUN50I_A1=
33
>  config SUNXI_DRAM_DDR3
>  	bool
> =20
> @@ -510,6 +657,9 @@ config SUNXI_DRAM_LPDDR3
>  config SUNXI_DRAM_LPDDR4
>  	bool
> =20
> +config SUNXI_DRAM_DDR4
> +	bool
> +
>  choice
>  	prompt "DRAM Type and Timing"
>  	default SUNXI_DRAM_DDR3_1333 if !MACH_SUN8I_V3S
> @@ -518,6 +668,7 @@ choice
>  config SUNXI_DRAM_DDR3_1333
>  	bool "DDR3 1333"
>  	select SUNXI_DRAM_DDR3
> +	depends on !DRAM_SUN50I_A133
>  	---help---
>  	This option is the original only supported memory type, which suits
>  	many H3/H5/A64 boards available now.
> @@ -525,6 +676,7 @@ config SUNXI_DRAM_DDR3_1333
>  config SUNXI_DRAM_LPDDR3_STOCK
>  	bool "LPDDR3 with Allwinner stock configuration"
>  	select SUNXI_DRAM_LPDDR3
> +	depends on !DRAM_SUN50I_A133
>  	---help---
>  	This option is the LPDDR3 timing used by the stock boot0 by
>  	Allwinner.
> @@ -548,7 +700,7 @@ config SUNXI_DRAM_H6_DDR3_1333
>  config SUNXI_DRAM_H616_LPDDR3
>  	bool "LPDDR3 DRAM chips on the H616 DRAM controller"
>  	select SUNXI_DRAM_LPDDR3
> -	depends on DRAM_SUN50I_H616
> +	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>  	help
>  	  This option is the LPDDR3 timing used by the stock boot0 by
>  	  Allwinner.
> @@ -556,7 +708,7 @@ config SUNXI_DRAM_H616_LPDDR3
>  config SUNXI_DRAM_H616_LPDDR4
>  	bool "LPDDR4 DRAM chips on the H616 DRAM controller"
>  	select SUNXI_DRAM_LPDDR4
> -	depends on DRAM_SUN50I_H616
> +	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>  	help
>  	  This option is the LPDDR4 timing used by the stock boot0 by
>  	  Allwinner.
> @@ -564,11 +716,27 @@ config SUNXI_DRAM_H616_LPDDR4
>  config SUNXI_DRAM_H616_DDR3_1333
>  	bool "DDR3-1333 boot0 timings on the H616 DRAM controller"
>  	select SUNXI_DRAM_DDR3
> -	depends on DRAM_SUN50I_H616
> +	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>  	help
>  	  This option is the DDR3 timing used by the boot0 on H616 TV boxes
>  	  which use a DDR3-1333 timing.
> =20
> +config SUNXI_DRAM_A133_DDR4
> +	bool "DDR4 boot0 timings on the A133 DRAM controller"
> +	select SUNXI_DRAM_DDR4
> +	depends on DRAM_SUN50I_A133
> +	help
> +	  This option is the DDR4 timing used by the boot0 on A133 devices
> +	  which use a DDR4 timing.
> +
> +config SUNXI_DRAM_A133_LPDDR4
> +	bool "LPDDR4 boot0 timings on the A133 DRAM controller"
> +	select SUNXI_DRAM_LPDDR4
> +	depends on DRAM_SUN50I_A133
> +	help
> +	  This option is the LPDDR4 timing used by the boot0 on A133 devices
> +	  which use an LPDDR4 timing.
> +
>  config SUNXI_DRAM_DDR2_V3S
>  	bool "DDR2 found in V3s chip"
>  	select SUNXI_DRAM_DDR2
> @@ -596,7 +764,7 @@ config DRAM_CLK
>  		       MACH_SUN8I_V3S
>  	default 672 if MACH_SUN50I
>  	default 744 if MACH_SUN50I_H6
> -	default 720 if MACH_SUN50I_H616
> +	default 720 if MACH_SUN50I_H616 || MACH_SUN50I_A133
>  	---help---
>  	Set the dram clock speed, valid range 240 - 480 (prior to sun9i),
>  	must be a multiple of 24. For the sun9i (A80), the tested values
> @@ -613,7 +781,7 @@ endif
> =20
>  config DRAM_ZQ
>  	int "sunxi dram zq value"
> -	depends on !MACH_SUN50I_H616
> +	depends on !MACH_SUN50I_H616 && !MACH_SUN50I_A133
>  	default 123 if MACH_SUN4I || MACH_SUN5I || MACH_SUN6I || \
>  		       MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_A83T
>  	default 127 if MACH_SUN7I
> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
> index eb6a49119a1..9b38f1d8663 100644
> --- a/arch/arm/mach-sunxi/Makefile
> +++ b/arch/arm/mach-sunxi/Makefile
> @@ -45,4 +45,6 @@ obj-$(CONFIG_DRAM_SUN50I_H6)	+=3D dram_sun50i_h6.o
>  obj-$(CONFIG_DRAM_SUN50I_H6)	+=3D dram_timings/
>  obj-$(CONFIG_DRAM_SUN50I_H616)	+=3D dram_sun50i_h616.o
>  obj-$(CONFIG_DRAM_SUN50I_H616)	+=3D dram_timings/
> +obj-$(CONFIG_DRAM_SUN50I_A133)	+=3D dram_sun50i_a133.o
> +obj-$(CONFIG_DRAM_SUN50I_A133)	+=3D dram_timings/
>  endif
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_a133.c b/arch/arm/mach-sunxi=
/dram_sun50i_a133.c
> new file mode 100644
> index 00000000000..1221244cbb6
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/dram_sun50i_a133.c
> @@ -0,0 +1,1217 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * sun50i A133 platform dram controller driver
> + *
> + * Controller and PHY appear to be quite similar to that of the H616;
> + * however certain offsets, timings, and other details are different eno=
ugh that
> + * the original code does not work as expected. Some device flags and ca=
librations
> + * are not yet implemented, and configuration aside from DDR4 have not b=
een tested.
> + *
> + * (C) Copyright 2024 MasterR3C0RD <masterr3c0rd@epochal.quest>
> + *
> + * Uses code from H616 driver, which is
> + * (C) Copyright 2020 Jernej Skrabec <jernej.skrabec@siol.net>
> + *
> + */
> +
> +#define DEBUG

This should go away in final version.

> +
> +#include <asm/arch/clock.h>
> +#include <asm/arch/cpu.h>
> +#include <asm/arch/dram.h>
> +#include <asm/arch/prcm.h>
> +#include <asm/io.h>
> +#include <init.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <log.h>
> +
> +#ifdef CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1
> +static const u8 phy_init[] =3D {
> +#ifdef CONFIG_SUNXI_DRAM_DDR3
> +	0x0c, 0x08, 0x19, 0x18, 0x10, 0x06, 0x0a, 0x03, 0x0e,
> +	0x00, 0x0b, 0x05, 0x09, 0x1a, 0x04, 0x13, 0x16, 0x11,
> +	0x01, 0x15, 0x0d, 0x07, 0x12, 0x17, 0x14, 0x02, 0x0f
> +#elif CONFIG_SUNXI_DRAM_DDR4
> +	0x19, 0x1a, 0x04, 0x12, 0x09, 0x06, 0x08, 0x0a, 0x16,
> +	0x17, 0x18, 0x0f, 0x0c, 0x13, 0x02, 0x05, 0x01, 0x11,
> +	0x0e, 0x00, 0x0b, 0x07, 0x03, 0x14, 0x15, 0x0d, 0x10
> +#elif CONFIG_SUNXI_DRAM_LPDDR3
> +	0x08, 0x03, 0x02, 0x00, 0x18, 0x19, 0x09, 0x01, 0x06,
> +	0x17, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11,
> +	0x12, 0x13, 0x14, 0x15, 0x16, 0x04, 0x05, 0x07, 0x1a
> +#elif CONFIG_SUNXI_DRAM_LPDDR4
> +	0x01, 0x05, 0x02, 0x00, 0x19, 0x03, 0x06, 0x07, 0x08,
> +	0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11,
> +	0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x04, 0x1a
> +#endif
> +};
> +#else
> +static const u8 phy_init[] =3D {
> +#ifdef CONFIG_SUNXI_DRAM_DDR3
> +	0x03, 0x19, 0x18, 0x02, 0x10, 0x15, 0x16, 0x07, 0x06,
> +	0x0e, 0x05, 0x08, 0x0d, 0x04, 0x17, 0x1a, 0x13, 0x11,
> +	0x12, 0x14, 0x00, 0x01, 0x0c, 0x0a, 0x09, 0x0b, 0x0f
> +#elif CONFIG_SUNXI_DRAM_DDR4
> +	0x13, 0x17, 0x0e, 0x01, 0x06, 0x12, 0x14, 0x07, 0x09,
> +	0x02, 0x0f, 0x00, 0x0d, 0x05, 0x16, 0x0c, 0x0a, 0x11,
> +	0x04, 0x03, 0x18, 0x15, 0x08, 0x10, 0x0b, 0x19, 0x1a
> +#elif CONFIG_SUNXI_DRAM_LPDDR3
> +	0x05, 0x06, 0x17, 0x02, 0x19, 0x18, 0x04, 0x07, 0x03,
> +	0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11,
> +	0x12, 0x13, 0x14, 0x15, 0x16, 0x08, 0x09, 0x00, 0x1a
> +#elif CONFIG_SUNXI_DRAM_LPDDR4
> +	0x01, 0x03, 0x02, 0x19, 0x17, 0x00, 0x06, 0x07, 0x08,
> +	0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11,
> +	0x12, 0x13, 0x14, 0x15, 0x16, 0x04, 0x18, 0x05, 0x1a
> +#endif
> +};
> +#endif
> +
> +static void mctl_clk_init(u32 clk)
> +{
> +	struct sunxi_ccm_reg *ccm =3D (struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
> +
> +	/* Place all DRAM blocks into reset */
> +	clrbits_le32(&ccm->mbus_cfg, MBUS_ENABLE);
> +	clrbits_le32(&ccm->mbus_cfg, MBUS_RESET);
> +	clrbits_le32(&ccm->dram_gate_reset, BIT(GATE_SHIFT));
> +	clrbits_le32(&ccm->dram_gate_reset, BIT(RESET_SHIFT));
> +	clrbits_le32(&ccm->pll5_cfg, CCM_PLL5_CTRL_EN);
> +	clrbits_le32(&ccm->dram_clk_cfg, DRAM_MOD_RESET);
> +	udelay(5);
> +
> +	/* Set up PLL5 clock, used for DRAM */
> +	clrsetbits_le32(&ccm->pll5_cfg, 0xff03,
> +			CCM_PLL5_CTRL_N((clk * 2) / 24) | CCM_PLL5_CTRL_EN);
> +	setbits_le32(&ccm->pll5_cfg, BIT(24));
> +	clrsetbits_le32(&ccm->pll5_cfg, 0x3,
> +			CCM_PLL5_LOCK_EN | CCM_PLL5_CTRL_EN | BIT(30));
> +	clrbits_le32(&ccm->pll5_cfg, 0x3 | BIT(30));
> +	mctl_await_completion(&ccm->pll5_cfg, CCM_PLL5_LOCK, CCM_PLL5_LOCK);
> +
> +	/* Enable DRAM clock and gate*/
> +	clrbits_le32(&ccm->dram_clk_cfg, BIT(24) | BIT(25));
> +	clrsetbits_le32(&ccm->dram_clk_cfg, 0x1f, BIT(1) | BIT(0));
> +	setbits_le32(&ccm->dram_clk_cfg, DRAM_CLK_UPDATE);
> +	setbits_le32(&ccm->dram_gate_reset, BIT(RESET_SHIFT));
> +	setbits_le32(&ccm->dram_gate_reset, BIT(GATE_SHIFT));
> +
> +	/* Re-enable MBUS and reset the DRAM module */
> +	setbits_le32(&ccm->mbus_cfg, MBUS_RESET);
> +	setbits_le32(&ccm->mbus_cfg, MBUS_ENABLE);
> +	setbits_le32(&ccm->dram_clk_cfg, DRAM_MOD_RESET);
> +	udelay(5);
> +}
> +
> +static void mctl_set_odtmap(const struct dram_para *para,
> +			    const struct dram_config *config)
> +{
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =3D
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	u32 val, temp1, temp2;
> +
> +	/* Set ODT/rank mappings*/
> +	if (config->bus_full_width)
> +		writel(0x0201, &mctl_ctl->odtmap);
> +	else
> +		writel(0x0303, &mctl_ctl->odtmap);
> +
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		val =3D 0x06000400;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		/* TODO: What's the purpose of these values? */
> +		temp1 =3D para->clk * 7 / 2000;
> +		if (para->clk < 400)
> +			temp2 =3D 0x3;
> +		else
> +			temp2 =3D 0x4;
> +
> +		val =3D 0x400 | (temp2 - temp1) << 16 | temp1 << 24;
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		val =3D 0x400 | (para->mr4 << 10 & 0x70000) |
> +		      (((para->mr4 >> 12) & 1) + 6) << 24;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		val =3D 0x4000400;
> +		break;
> +	}
> +
> +	writel(val, &mctl_ctl->odtcfg);
> +	/* Documented as ODTCFG_SHADOW */
> +	writel(val, &mctl_ctl->unk_0x2240);
> +	/* Offset's interesting; additional undocumented shadows? */
> +	writel(val, &mctl_ctl->unk_0x3240);
> +	writel(val, &mctl_ctl->unk_0x4240);
> +}
> +
> +/*
> + * Note: Unlike the H616, config->ranks is the number of rank *bits*, no=
t the number of ranks *present*.
> + * For example, if `ranks =3D 0`, then there is only one rank. If `ranks=
 =3D 1`, there are two.
> + *
> + * If this is deemed an issue during review, fixing this off-by-one is n=
o problem, but this matches how
> + * boot0 handles these values.
> + */
> +static void mctl_set_addrmap(const struct dram_config *config)
> +{
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =3D
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	u8 bankgrp_bits =3D config->bankgrps;
> +	u8 bank_bits =3D config->banks;
> +	u8 rank_bits =3D config->ranks;
> +	u8 col_bits =3D config->cols;
> +	u8 row_bits =3D config->rows;
> +	bool bus_full_width =3D config->bus_full_width;
> +
> +	u8 addrmap_bank_bx =3D bankgrp_bits + col_bits - 2;
> +	u8 addrmap_row_bx =3D (bankgrp_bits + bank_bits + col_bits) - 6;
> +
> +	if (!bus_full_width)
> +		col_bits -=3D 1;
> +
> +	/* Ordered from LSB to MSB: */
> +	/* Bank groups */
> +	switch (bankgrp_bits) {
> +	case 0:
> +		writel(0x3f3f, &mctl_ctl->addrmap[8]);
> +		break;
> +	case 1:
> +		writel(0x01 | 0x3f << 8, &mctl_ctl->addrmap[8]);
> +		break;
> +	case 2:
> +		writel(0x01 | 0x01 << 8, &mctl_ctl->addrmap[8]);
> +		break;
> +	default:
> +		panic("Unsupported dram configuration (bankgrp_bits =3D %d)",
> +		      bankgrp_bits);
> +	}
> +
> +	/* Columns */
> +	writel(bankgrp_bits | bankgrp_bits << 8 | bankgrp_bits << 16 |
> +		       bankgrp_bits << 24,
> +	       &mctl_ctl->addrmap[2]);
> +
> +	switch (col_bits) {
> +	case 8:
> +		writel(bankgrp_bits | bankgrp_bits << 8 | 0x1f << 16 |
> +			       0x1f << 24,
> +		       &mctl_ctl->addrmap[3]);
> +		writel(0x1f | 0x1f << 8, &mctl_ctl->addrmap[4]);
> +		break;
> +	case 9:
> +		writel(bankgrp_bits | bankgrp_bits << 8 | bankgrp_bits << 16 |
> +			       0x1f << 24,
> +		       &mctl_ctl->addrmap[3]);
> +		writel(0x1f | 0x1f << 8, &mctl_ctl->addrmap[4]);
> +		break;
> +	case 10:
> +		writel(bankgrp_bits | bankgrp_bits << 8 | bankgrp_bits << 16 |
> +			       bankgrp_bits << 24,
> +		       &mctl_ctl->addrmap[3]);
> +		writel(0x1f | 0x1f << 8, &mctl_ctl->addrmap[4]);
> +		break;
> +	case 11:
> +		writel(bankgrp_bits | bankgrp_bits << 8 | bankgrp_bits << 16 |
> +			       bankgrp_bits << 24,
> +		       &mctl_ctl->addrmap[3]);
> +		writel(bankgrp_bits | 0x1f << 8, &mctl_ctl->addrmap[4]);
> +		break;
> +	case 12:
> +		writel(bankgrp_bits | bankgrp_bits << 8 | bankgrp_bits << 16 |
> +			       bankgrp_bits << 24,
> +		       &mctl_ctl->addrmap[3]);
> +		writel(bankgrp_bits | bankgrp_bits << 8, &mctl_ctl->addrmap[4]);
> +		break;
> +	default:
> +		panic("Unsupported dram configuration (col_bits =3D %d)",
> +		      col_bits);
> +	}
> +
> +	/* Banks */
> +	if (bank_bits =3D=3D 3) {
> +		writel(addrmap_bank_bx | addrmap_bank_bx << 8 |
> +			       addrmap_bank_bx << 16,
> +		       &mctl_ctl->addrmap[1]);
> +	} else {
> +		writel(addrmap_bank_bx | addrmap_bank_bx << 8 | 0x3f << 16,
> +		       &mctl_ctl->addrmap[1]);
> +	}
> +
> +	/* Rows */
> +	writel(addrmap_row_bx | addrmap_row_bx << 8 | addrmap_row_bx << 16 |
> +		       addrmap_row_bx << 24,
> +	       &mctl_ctl->addrmap[5]);
> +
> +	switch (row_bits) {
> +	case 14:
> +		writel(addrmap_row_bx | addrmap_row_bx << 8 | 0x0f << 16 |
> +			       0x0f << 24,
> +		       &mctl_ctl->addrmap[6]);
> +		writel(0x0f | 0x0f << 8, &mctl_ctl->addrmap[7]);
> +		break;
> +	case 15:
> +		if ((rank_bits =3D=3D 1 && col_bits =3D=3D 11) ||
> +		    (rank_bits =3D=3D 2 && col_bits =3D=3D 10)) {
> +			writel(addrmap_row_bx | (addrmap_row_bx + 1) << 8 |
> +				       (addrmap_row_bx + 1) << 16 | 0x0f << 24,
> +			       &mctl_ctl->addrmap[6]);
> +		} else {
> +			writel(addrmap_row_bx | addrmap_row_bx << 8 |
> +				       addrmap_row_bx << 16 | 0x0f << 24,
> +			       &mctl_ctl->addrmap[6]);
> +		}
> +		writel(0x0f | 0x0f << 8, &mctl_ctl->addrmap[7]);
> +		break;
> +	case 16:
> +		if (rank_bits =3D=3D 1 && col_bits =3D=3D 10) {
> +			writel((addrmap_row_bx + 1) |
> +				       (addrmap_row_bx + 1) << 8 |
> +				       (addrmap_row_bx + 1) << 16 |
> +				       (addrmap_row_bx + 1) << 24,
> +			       &mctl_ctl->addrmap[6]);
> +		} else {
> +			writel(addrmap_row_bx | addrmap_row_bx << 8 |
> +				       addrmap_row_bx << 16 |
> +				       addrmap_row_bx << 24,
> +			       &mctl_ctl->addrmap[6]);
> +		}
> +		writel(0x0f | 0x0f << 8, &mctl_ctl->addrmap[7]);
> +		break;
> +	case 17:
> +		writel(addrmap_row_bx | addrmap_row_bx << 8 |
> +			       addrmap_row_bx << 16 | addrmap_row_bx << 24,
> +		       &mctl_ctl->addrmap[6]);
> +		writel(addrmap_row_bx | 0x0f << 8, &mctl_ctl->addrmap[7]);
> +		break;
> +	case 18:
> +		writel(addrmap_row_bx | addrmap_row_bx << 8 |
> +			       addrmap_row_bx << 16 | addrmap_row_bx << 24,
> +		       &mctl_ctl->addrmap[6]);
> +		writel(addrmap_row_bx | addrmap_row_bx << 8,
> +		       &mctl_ctl->addrmap[7]);
> +		break;
> +	default:
> +		panic("Unsupported dram configuration (row_bits =3D %d)",
> +		      row_bits);
> +	}
> +
> +	/* Ranks */
> +	if (rank_bits =3D=3D 0) {
> +		writel(0x1f, &mctl_ctl->addrmap[0]);
> +	} else if ((rank_bits + col_bits + row_bits) =3D=3D 27) {
> +		writel(addrmap_row_bx + row_bits - 2, &mctl_ctl->addrmap[0]);
> +	} else {
> +		writel(addrmap_row_bx + row_bits, &mctl_ctl->addrmap[0]);
> +	}
> +}
> +
> +static void mctl_com_init(const struct dram_para *para,
> +			  const struct dram_config *config)
> +{
> +	struct sunxi_mctl_com_reg *mctl_com =3D
> +		(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =3D
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	/* Might control power/reset of DDR-related blocks */
> +	clrsetbits_le32(&mctl_com->unk_0x008, BIT(24), BIT(25) | BIT(9));
> +
> +	/* Unlock mctl_ctl registers */
> +	setbits_le32(&mctl_com->maer0, BIT(15));
> +
> +	if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR4)
> +		setbits_le32(0x03102ea8, BIT(0));
> +
> +	clrsetbits_le32(&mctl_ctl->sched[0], 0xff << 8, 0x30 << 8);
> +	if (!(para->tpr13 & BIT(28)))
> +		clrsetbits_le32(&mctl_ctl->sched[0], 0xf, BIT(0));
> +
> +	writel(0, &mctl_ctl->hwlpctl);
> +
> +	/* Master settings */
> +	u32 mstr_value =3D MSTR_DEVICECONFIG_X32 |
> +			 MSTR_ACTIVE_RANKS(config->ranks);
> +
> +	if (config->bus_full_width)
> +		mstr_value |=3D MSTR_BUSWIDTH_FULL;
> +	else
> +		mstr_value |=3D MSTR_BUSWIDTH_HALF;
> +
> +	/*
> +	 * Geardown and 2T mode are always enabled here, but is controlled by a=
 flag in boot0;
> +	 * it has not been a problem so far, but may be suspect if a particular=
 board isn't booting.
> +	 */
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		mstr_value |=3D MSTR_DEVICETYPE_DDR3 | MSTR_BURST_LENGTH(8) |
> +			      MSTR_2TMODE;
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		mstr_value |=3D MSTR_DEVICETYPE_DDR4 | MSTR_BURST_LENGTH(8) |
> +			      MSTR_GEARDOWNMODE | MSTR_2TMODE;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		mstr_value |=3D MSTR_DEVICETYPE_LPDDR3 | MSTR_BURST_LENGTH(8);
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		mstr_value |=3D MSTR_DEVICETYPE_LPDDR4 | MSTR_BURST_LENGTH(16);
> +		break;
> +	}
> +
> +	writel(mstr_value, &mctl_ctl->mstr);
> +
> +	mctl_set_odtmap(para, config);
> +	mctl_set_addrmap(config);
> +	mctl_set_timing_params(para);
> +
> +	writel(0, &mctl_ctl->pwrctl);
> +
> +	/* Disable automatic controller updates + automatic controller update r=
equests */
> +	setbits_le32(&mctl_ctl->dfiupd[0], BIT(31) | BIT(30));
> +	setbits_le32(&mctl_ctl->zqctl[0], BIT(31) | BIT(30));
> +	setbits_le32(&mctl_ctl->unk_0x2180, BIT(31) | BIT(30));
> +	setbits_le32(&mctl_ctl->unk_0x3180, BIT(31) | BIT(30));
> +	setbits_le32(&mctl_ctl->unk_0x4180, BIT(31) | BIT(30));
> +
> +	/*
> +	 * Data bus inversion
> +	 * Controlled by a flag in boot0, enabled by default here.
> +	 */
> +//	if (para->type =3D=3D SUNXI_DRAM_TYPE_DDR4 ||
> +//	    para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR4)
> +//		setbits_le32(&mctl_ctl->dbictl, BIT(2));
> +}
> +
> +static void mctl_drive_odt_config(const struct dram_para *para)
> +{
> +	u32 val;
> +	u64 base;
> +	u32 i;
> +
> +	/* DX drive */
> +	for (i =3D 0; i < 4; i++) {
> +		base =3D SUNXI_DRAM_PHY0_BASE + 0x388 + 0x40 * i;
> +		val =3D (para->dx_dri >> (i * 8)) & 0x1f;
> +
> +		writel(val, base);
> +		if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR4) {
> +			if (para->tpr3 & 0x1f1f1f1f)
> +				val =3D (para->tpr3 >> (i * 8)) & 0x1f;
> +			else
> +				val =3D 4;
> +		}
> +		writel(val, base + 4);
> +	}
> +
> +	/* CA drive */
> +	for (i =3D 0; i < 2; i++) {
> +		base =3D SUNXI_DRAM_PHY0_BASE + 0x340 + 0x8 * i;
> +		val =3D (para->ca_dri >> (i * 8)) & 0x1f;
> +
> +		writel(val, base);
> +		writel(val, base + 4);
> +	}
> +
> +	/* DX ODT */
> +	for (i =3D 0; i < 4; i++) {
> +		base =3D SUNXI_DRAM_PHY0_BASE + 0x380 + 0x40 * i;
> +		val =3D (para->dx_odt >> (i * 8)) & 0x1f;
> +
> +		if (para->type =3D=3D SUNXI_DRAM_TYPE_DDR4 ||
> +		    para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR3)
> +			writel(0, base);
> +		else
> +			writel(val, base);
> +
> +		if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR4)
> +			writel(0, base + 4);
> +		else
> +			writel(val, base + 4);
> +	}
> +}
> +
> +static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *p=
ara)
> +{
> +	u32 val, i;
> +	u32 *ptr;
> +
> +	if (para->tpr10 & BIT(31)) {
> +		val =3D para->tpr2;
> +	} else {
> +		val =3D ((para->tpr10 << 1) & 0x1e) |
> +		      ((para->tpr10 << 5) & 0x1e00) |
> +		      ((para->tpr10 << 9) & 0x1e0000) |
> +		      ((para->tpr10 << 13) & 0x1e000000);
> +
> +		if (para->tpr10 >> 29 !=3D 0)
> +			val <<=3D 1;
> +	}
> +
> +	ptr =3D (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x780);
> +	for (i =3D 0; i < 32; i++)
> +		writel((val >> 8) & 0x3f, &ptr[i]);
> +
> +	writel(val & 0x3f, SUNXI_DRAM_PHY0_BASE + 0x7dc);
> +	writel(val & 0x3f, SUNXI_DRAM_PHY0_BASE + 0x7e0);
> +
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		writel((val >> 16) & 0x3f, SUNXI_DRAM_PHY0_BASE + 0x7b8);
> +		writel((val >> 24) & 0x3f, SUNXI_DRAM_PHY0_BASE + 0x784);
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		writel((val >> 16) & 0x3f, SUNXI_DRAM_PHY0_BASE + 0x784);
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		writel((val >> 16) & 0x3f, SUNXI_DRAM_PHY0_BASE + 0x788);
> +		writel((val >> 24) & 0x3f, SUNXI_DRAM_PHY0_BASE + 0x790);
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		writel((val >> 16) & 0x3f, SUNXI_DRAM_PHY0_BASE + 0x790);
> +		writel((val >> 24) & 0x3f, SUNXI_DRAM_PHY0_BASE + 0x78c);
> +		break;
> +	}
> +}
> +
> +static void mctl_phy_init(const struct dram_para *para,
> +			  const struct dram_config *config)
> +{
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =3D
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +	const struct sunxi_prcm_reg *prcm =3D
> +		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
> +	struct sunxi_mctl_com_reg *mctl_com =3D
> +		(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
> +
> +	u32 val, val2, i;
> +	u32 *ptr;
> +
> +	/* Disable auto refresh. */
> +	setbits_le32(&mctl_ctl->rfshctl3, BIT(0));
> +
> +	/* Set "phy_dbi_mode" to mark the DFI as implementing DBI functionality=
 */
> +	writel(0, &mctl_ctl->pwrctl);
> +	clrbits_le32(&mctl_ctl->dfimisc, 1);
> +	writel(0x20, &mctl_ctl->pwrctl);
> +
> +	/* PHY cold reset */
> +	clrsetbits_le32(&mctl_com->unk_0x008, BIT(24), BIT(9));
> +	udelay(1);
> +	setbits_le32(&mctl_com->unk_0x008, BIT(24));
> +
> +	/* Not sure what this gates the power of. */
> +	clrbits_le32(&prcm->sys_pwroff_gating, BIT(4));
> +
> +	if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR4)
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x4, BIT(7));
> +
> +	/* Note: Similar enumeration of values is used during read training */
> +	if (config->bus_full_width)
> +		val =3D 0xf;
> +	else
> +		val =3D 0x3;
> +
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x3c, 0xf, val);
> +
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		val =3D 13;
> +		val2 =3D 9;
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		val =3D 13;
> +		val2 =3D 10;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		val =3D 14;
> +		val2 =3D 8;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		if (para->tpr13 & BIT(28))
> +			val =3D 22;
> +		else
> +			val =3D 20;
> +		val2 =3D 10;
> +		break;
> +	}
> +
> +	writel(val, SUNXI_DRAM_PHY0_BASE + 0x14);
> +	writel(val, SUNXI_DRAM_PHY0_BASE + 0x35c);
> +	writel(val, SUNXI_DRAM_PHY0_BASE + 0x368);
> +	writel(val, SUNXI_DRAM_PHY0_BASE + 0x374);
> +	writel(0, SUNXI_DRAM_PHY0_BASE + 0x18);
> +	writel(0, SUNXI_DRAM_PHY0_BASE + 0x360);
> +	writel(0, SUNXI_DRAM_PHY0_BASE + 0x36c);
> +	writel(0, SUNXI_DRAM_PHY0_BASE + 0x378);
> +	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x1c);
> +	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x364);
> +	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x370);
> +	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x37c);
> +
> +	/* boot0 does this in "phy_set_address_remapping". Seems odd for an add=
ress map table, though. */
> +	ptr =3D (u32 *)(SUNXI_DRAM_PHY0_BASE + 0xc0);
> +	for (i =3D 0; i < ARRAY_SIZE(phy_init); i++)
> +		writel(phy_init[i], &ptr[i]);
> +
> +	/* Set VREF */
> +	val =3D 0;
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		val =3D para->tpr6 & 0xff;
> +		if (val =3D=3D 0)
> +			val =3D 0x80;
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		val =3D (para->tpr6 >> 8) & 0xff;
> +		if (val =3D=3D 0)
> +			val =3D 0x80;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		val =3D (para->tpr6 >> 16) & 0xff;
> +		if (val =3D=3D 0)
> +			val =3D 0x80;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		val =3D (para->tpr6 >> 24) & 0xff;
> +		if (val =3D=3D 0)
> +			val =3D 0x33;
> +		break;
> +	}
> +	writel(val, SUNXI_DRAM_PHY0_BASE + 0x3dc);
> +	writel(val, SUNXI_DRAM_PHY0_BASE + 0x45c);
> +
> +	mctl_drive_odt_config(para);
> +
> +	if (para->tpr10 & TPR10_CA_BIT_DELAY)
> +		mctl_phy_ca_bit_delay_compensation(para);
> +
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		val =3D 2;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		val =3D 3;
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		val =3D 4;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		val =3D 5;
> +		break;
> +	}
> +
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x4, 0x7, val | 8);
> +
> +	if (para->clk <=3D 672)
> +		writel(0xf, SUNXI_DRAM_PHY0_BASE + 0x20);
> +
> +	if (para->clk > 500) {
> +		val =3D 0;
> +		val2 =3D 0;
> +	} else {
> +		val =3D 0x80;
> +		val2 =3D 0x20;
> +	}
> +
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x144, 0x80, val);
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x14c, 0xe0, val2);
> +
> +	clrbits_le32(&mctl_com->unk_0x008, BIT(9));
> +	udelay(1);
> +	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x14c, BIT(3));
> +
> +	mctl_await_completion((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x180), BIT(2),
> +			      BIT(2));
> +
> +	/* This is controlled by a tpr13 flag in boot0; doesn't hurt to always =
do it though. */
> +	udelay(1000);
> +	writel(0x37, SUNXI_DRAM_PHY0_BASE + 0x58);
> +
> +	setbits_le32(&prcm->sys_pwroff_gating, BIT(4));
> +}
> +
> +/* Helpers for updating mode registers */
> +static inline void mctl_mr_write(u32 mrctrl0, u32 mrctrl1)
> +{
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =3D
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	writel(mrctrl1, &mctl_ctl->mrctrl1);
> +	writel(mrctrl0 | MRCTRL0_MR_WR | MRCTRL0_MR_RANKS_ALL,
> +	       &mctl_ctl->mrctrl0);
> +	mctl_await_completion(&mctl_ctl->mrctrl0, MRCTRL0_MR_WR, 0);
> +}
> +
> +static inline void mctl_mr_write_lpddr4(u8 addr, u8 value)
> +{
> +	mctl_mr_write(0, MRCTRL1_MR_ADDR(addr) | MRCTRL1_MR_DATA(value));
> +}
> +
> +static inline void mctl_mr_write_lpddr3(u8 addr, u8 value)
> +{
> +	/* Bit [7:6] are set by boot0, but undocumented */
> +	mctl_mr_write(BIT(6) | BIT(7),
> +		      MRCTRL1_MR_ADDR(addr) | MRCTRL1_MR_DATA(value));
> +}
> +
> +static void mctl_dfi_init(const struct dram_para *para)
> +{
> +	struct sunxi_mctl_com_reg *mctl_com =3D
> +		(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =3D
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	/* Unlock DFI registers? */
> +	setbits_le32(&mctl_com->maer0, BIT(8));
> +
> +	/* Enable dfi_init_complete signal and trigger PHY init start request */
> +	writel(0, &mctl_ctl->swctl);
> +	setbits_le32(&mctl_ctl->dfimisc, BIT(0));
> +	setbits_le32(&mctl_ctl->dfimisc, BIT(5));
> +	writel(1, &mctl_ctl->swctl);
> +	mctl_await_completion(&mctl_ctl->swstat, BIT(0), BIT(0));
> +
> +	/* Stop sending init request and wait for DFI initialization to complet=
e. */
> +	writel(0, &mctl_ctl->swctl);
> +	clrbits_le32(&mctl_ctl->dfimisc, BIT(5));
> +	writel(1, &mctl_ctl->swctl);
> +	mctl_await_completion(&mctl_ctl->swstat, BIT(0), BIT(0));
> +	mctl_await_completion(&mctl_ctl->dfistat, BIT(0), BIT(0));
> +
> +	/* Enter Software Exit from Self Refresh */
> +	writel(0, &mctl_ctl->swctl);
> +	clrbits_le32(&mctl_ctl->pwrctl, BIT(5));
> +	writel(1, &mctl_ctl->swctl);
> +	mctl_await_completion(&mctl_ctl->swstat, BIT(0), BIT(0));
> +	mctl_await_completion(&mctl_ctl->statr, 0x3, 1);
> +
> +	udelay(200);
> +
> +	/* Disable dfi_init_complete signal */
> +	writel(0, &mctl_ctl->swctl);
> +	clrbits_le32(&mctl_ctl->dfimisc, BIT(0));
> +	writel(1, &mctl_ctl->swctl);
> +	mctl_await_completion(&mctl_ctl->swstat, BIT(0), BIT(0));
> +
> +	/* Write mode registers */
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		mctl_mr_write(MRCTRL0_MR_ADDR(0), para->mr0);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(1), para->mr1);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(2), para->mr2);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(3), para->mr3);
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		mctl_mr_write(MRCTRL0_MR_ADDR(0), para->mr0);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(1), para->mr1);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(2), para->mr2);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(3), para->mr3);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(4), para->mr4);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(5), para->mr5);
> +
> +		mctl_mr_write(MRCTRL0_MR_ADDR(6), para->mr6 | BIT(7));
> +		mctl_mr_write(MRCTRL0_MR_ADDR(6), para->mr6 | BIT(7));
> +		mctl_mr_write(MRCTRL0_MR_ADDR(6), para->mr6 & (~BIT(7)));
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		mctl_mr_write_lpddr3(1, para->mr1);
> +		mctl_mr_write_lpddr3(2, para->mr2);
> +		mctl_mr_write_lpddr3(3, para->mr3);
> +		mctl_mr_write_lpddr3(11, para->mr11);
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		mctl_mr_write_lpddr4(0, para->mr0);
> +		mctl_mr_write_lpddr4(1, para->mr1);
> +		mctl_mr_write_lpddr4(2, para->mr2);
> +		mctl_mr_write_lpddr4(3, para->mr3);
> +		mctl_mr_write_lpddr4(4, para->mr4);
> +		mctl_mr_write_lpddr4(11, para->mr11);
> +		mctl_mr_write_lpddr4(12, para->mr12);
> +		mctl_mr_write_lpddr4(13, para->mr13);
> +		mctl_mr_write_lpddr4(14, para->mr14);
> +		mctl_mr_write_lpddr4(22, para->tpr1);
> +		break;
> +	}
> +
> +	writel(0, SUNXI_DRAM_PHY0_BASE + 0x54);
> +
> +	/* Re-enable controller refresh */
> +	writel(0, &mctl_ctl->swctl);
> +	clrbits_le32(&mctl_ctl->rfshctl3, BIT(0));
> +	writel(1, &mctl_ctl->swctl);
> +}
> +
> +/* Slightly modified from H616 driver */
> +static bool mctl_phy_read_calibration(const struct dram_config *config)
> +{
> +	bool result =3D true;
> +	u32 val, tmp;
> +
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0x30, 0x20);
> +
> +	setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 1);
> +
> +	if (config->bus_full_width)
> +		val =3D 0xf;
> +	else
> +		val =3D 3;
> +
> +	while ((readl(SUNXI_DRAM_PHY0_BASE + 0x184) & val) !=3D val) {
> +		if (readl(SUNXI_DRAM_PHY0_BASE + 0x184) & 0x20) {
> +			result =3D false;
> +			break;
> +		}
> +	}
> +
> +	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 1);
> +
> +	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0x30);
> +
> +	if (config->ranks =3D=3D 1) {
> +		clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0x30, 0x10);
> +
> +		setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 1);
> +
> +		while ((readl(SUNXI_DRAM_PHY0_BASE + 0x184) & val) !=3D val) {
> +			if (readl(SUNXI_DRAM_PHY0_BASE + 0x184) & 0x20) {
> +				result =3D false;
> +				break;
> +			}
> +		}
> +
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 1);
> +	}
> +
> +	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0x30);
> +
> +	val =3D readl(SUNXI_DRAM_PHY0_BASE + 0x274) & 7;
> +	tmp =3D readl(SUNXI_DRAM_PHY0_BASE + 0x26c) & 7;
> +	if (val < tmp)
> +		val =3D tmp;
> +	tmp =3D readl(SUNXI_DRAM_PHY0_BASE + 0x32c) & 7;
> +	if (val < tmp)
> +		val =3D tmp;
> +	tmp =3D readl(SUNXI_DRAM_PHY0_BASE + 0x334) & 7;
> +	if (val < tmp)
> +		val =3D tmp;
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x38, 0x7, (val + 2) & 7);
> +
> +	setbits_le32(SUNXI_DRAM_PHY0_BASE + 4, 0x20);
> +
> +	return result;
> +}
> +
> +static inline void mctl_phy_dx_delay1_inner(u32 *base, u32 val1, u32 val=
2)
> +{
> +	u32 *ptr =3D base;
> +
> +	for (int i =3D 0; i < 9; i++) {
> +		writel(val1, ptr);
> +		writel(val1, ptr + 0x30);
> +		ptr +=3D 2;
> +	}
> +
> +	writel(val2, ptr + 1);
> +	writel(val2, ptr + 49);
> +	writel(val2, ptr);
> +	writel(val2, ptr + 48);
> +}
> +
> +static inline void mctl_phy_dx_delay0_inner(u32 *base1, u32 *base2, u32 =
val1,
> +					    u32 val2)
> +{
> +	u32 *ptr =3D base1;
> +	for (int i =3D 0; i < 9; i++) {
> +		writel(val1, ptr);
> +		writel(val1, ptr + 0x30);
> +		ptr +=3D 2;
> +	}
> +
> +	writel(val2, base2);
> +	writel(val2, base2 + 48);
> +	writel(val2, ptr);
> +	writel(val2, base2 + 44);
> +}
> +
> +/* This might be somewhat transferable to H616; whether or not people li=
ke the design is another question */
> +static void mctl_phy_dx_delay_compensation(const struct dram_para *para)
> +{
> +	if (para->tpr10 & TPR10_DX_BIT_DELAY1) {
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x60, 1);
> +		setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, BIT(3));
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x190, BIT(4));
> +
> +		if (para->type =3D=3D SUNXI_DRAM_TYPE_DDR4)
> +			clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x4, BIT(7));
> +
> +		mctl_phy_dx_delay1_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x484),
> +					 para->tpr11 & 0x3f,
> +					 para->para0 & 0x3f);
> +		mctl_phy_dx_delay1_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x4d8),
> +					 (para->tpr11 >> 8) & 0x3f,
> +					 (para->para0 >> 8) & 0x3f);
> +		mctl_phy_dx_delay1_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x604),
> +					 (para->tpr11 >> 16) & 0x3f,
> +					 (para->para0 >> 16) & 0x3f);
> +		mctl_phy_dx_delay1_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x658),
> +					 (para->tpr11 >> 24) & 0x3f,
> +					 (para->para0 >> 24) & 0x3f);
> +
> +		setbits_le32(SUNXI_DRAM_PHY0_BASE + 0x60, 1);
> +	}
> +
> +	if (para->tpr10 & TPR10_DX_BIT_DELAY0) {
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x54, BIT(7));
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x190, BIT(2));
> +
> +		mctl_phy_dx_delay0_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x480),
> +					 (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x528),
> +					 para->tpr12 & 0x3f,
> +					 para->tpr14 & 0x3f);
> +
> +		mctl_phy_dx_delay0_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x4d4),
> +					 (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x52c),
> +					 (para->tpr12 >> 8) & 0x3f,
> +					 (para->tpr14 >> 8) & 0x3f);
> +
> +		mctl_phy_dx_delay0_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x600),
> +					 (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x6a8),
> +					 (para->tpr12 >> 16) & 0x3f,
> +					 (para->tpr14 >> 16) & 0x3f);
> +
> +		mctl_phy_dx_delay0_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x6ac),
> +					 (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x528),
> +					 (para->tpr12 >> 24) & 0x3f,
> +					 (para->tpr14 >> 24) & 0x3f);
> +
> +		setbits_le32(SUNXI_DRAM_PHY0_BASE + 0x54, BIT(7));
> +	}
> +}
> +
> +static bool mctl_calibrate_phy(const struct dram_para *para,
> +			       const struct dram_config *config)
> +{
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =3D
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	int i;
> +
> +	/* TODO: Implement write levelling */
> +	if (para->tpr10 & TPR10_READ_CALIBRATION) {
> +		for (i =3D 0; i < 5; i++)
> +			if (mctl_phy_read_calibration(config))
> +				break;
> +		if (i =3D=3D 5) {
> +			debug("read calibration failed");
> +			return false;
> +		}
> +	}
> +
> +	/* TODO: Implement read training leveling */
> +	/* TODO: Implement write training */
> +
> +	mctl_phy_dx_delay_compensation(para);
> +	/* TODO: Implement DFS */
> +	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x60, BIT(0));
> +	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x54, 7);
> +
> +	/* Q: Does self-refresh get disabled by a calibration? */
> +	writel(0, &mctl_ctl->swctl);
> +	clrbits_le32(&mctl_ctl->rfshctl3, BIT(1));
> +	writel(1, &mctl_ctl->swctl);
> +	mctl_await_completion(&mctl_ctl->swstat, BIT(0), BIT(0));
> +
> +	return true;
> +}
> +
> +static bool mctl_core_init(const struct dram_para *para,
> +			   const struct dram_config *config)
> +{
> +	mctl_clk_init(para->clk);
> +	mctl_com_init(para, config);
> +	mctl_phy_init(para, config);
> +	mctl_dfi_init(para);
> +
> +	return mctl_calibrate_phy(para, config);
> +}
> +
> +/* Heavily inspired from H616 driver. UNUSED */
> +/* static */ void auto_detect_ranks(const struct dram_para *para,
> +				    struct dram_config *config)
> +{
> +	int i;
> +	bool found_config;
> +
> +	config->cols =3D 9;
> +	config->rows =3D 14;
> +	config->ranks =3D 0;
> +	config->banks =3D 0;
> +	config->bankgrps =3D 0;
> +
> +	/* Test ranks */
> +	found_config =3D false;
> +	for (i =3D 1; i >=3D 0; i--) {
> +		config->ranks =3D i;
> +		config->bus_full_width =3D true;
> +		debug("Testing ranks =3D %d, 32-bit bus\n", i);
> +		if (mctl_core_init(para, config)) {
> +			found_config =3D true;
> +			break;
> +		}
> +
> +		config->bus_full_width =3D false;
> +		debug("Testing ranks =3D %d, 16-bit bus\n", i);
> +		if (mctl_core_init(para, config)) {
> +			found_config =3D true;
> +			break;
> +		}
> +	}
> +
> +	debug("Found ranks =3D %d\n", config->ranks);
> +}
> +
> +/* UNUSED? */

Needless to say, instead of relying on hardcoded values, it's better to use
autodetection in order to cover multiple version of same board with differe=
nt
DRAM sizes.

Best regards,
Jernej

> +/* static */ void mctl_auto_detect_dram_size(const struct dram_para *par=
a,
> +					     struct dram_config *config)
> +{
> +	unsigned int shift;
> +
> +	/* max config for bankgrps, minimum for everything else */
> +	config->bankgrps =3D 2;
> +	config->cols =3D 8;
> +	config->banks =3D 0;
> +	config->rows =3D 14;
> +	mctl_core_init(para, config);
> +
> +	shift =3D config->bus_full_width + 1;
> +
> +	/* detect bank group address bits */
> +	for (config->bankgrps =3D 0; config->bankgrps < 2; config->bankgrps++) {
> +		writel(config->bankgrps, CFG_SYS_SDRAM_BASE);
> +		for (long i =3D 0; i < 0x100; i +=3D 4) {
> +			debug("[%lx] =3D %x\n", i, readl(CFG_SYS_SDRAM_BASE + i));
> +		}
> +		if (mctl_mem_matches(3ULL << (config->bankgrps + shift + 1)))
> +			break;
> +	}
> +
> +	debug("detected %u bank groups\n", config->bankgrps);
> +
> +	/* reconfigure to make sure all active columns are accessible */
> +	config->cols =3D 12;
> +	mctl_core_init(para, config);
> +
> +	/* detect column address bits */
> +	shift +=3D config->bankgrps;
> +	for (config->cols =3D 8; config->cols < 12; config->cols++) {
> +		if (mctl_mem_matches(1ULL << (config->cols + shift)))
> +			break;
> +	}
> +	debug("detected %u columns\n", config->cols);
> +
> +	/* reconfigure to make sure that all active banks are accessible */
> +	config->banks =3D 3;
> +	mctl_core_init(para, config);
> +	debug("detected %u banks\n", config->bankgrps);
> +
> +	/* detect bank bits */
> +	shift +=3D config->cols;
> +	for (config->banks =3D 0; config->banks < 3; config->banks++) {
> +		if (mctl_mem_matches(1ULL << (config->banks + shift)))
> +			break;
> +	}
> +
> +	/* reconfigure to make sure that all active rows are accessible */
> +	config->rows =3D 18;
> +	mctl_core_init(para, config);
> +
> +	/* detect row address bits */
> +	shift +=3D config->banks;
> +	for (config->rows =3D 14; config->rows < 18; config->rows++) {
> +		if (mctl_mem_matches(1ULL << (config->rows + shift)))
> +			break;
> +	}
> +	debug("detected %u rows\n", config->rows);
> +}
> +
> +/* Modified from H616 driver, UNUSED? */
> +/* static */ void auto_detect_size(const struct dram_para *para,
> +				   struct dram_config *config)
> +{
> +	/* detect row address bits */
> +	config->cols =3D 8;
> +	config->rows =3D 18;
> +	config->banks =3D 0;
> +	config->bankgrps =3D 0;
> +	mctl_core_init(para, config);
> +
> +	for (config->rows =3D 14; config->rows < 18; config->rows++) {
> +		/* 8 banks, 8 bit per byte and 16/32 bit width */
> +		if (mctl_mem_matches((1 << (config->bankgrps + config->banks +
> +					    config->cols + config->rows +
> +					    config->bus_full_width + 1))))
> +			break;
> +	}
> +
> +	/* detect column address bits */
> +	config->cols =3D 12;
> +	mctl_core_init(para, config);
> +
> +	for (config->cols =3D 8; config->cols < 12; config->cols++) {
> +		/* 8 bits per byte and 16/32 bit width */
> +		if (mctl_mem_matches(1 << (config->bankgrps + config->banks +
> +					   config->cols +
> +					   config->bus_full_width + 1)))
> +			break;
> +	}
> +
> +	/* detect bank address bits */
> +	config->banks =3D 3;
> +	mctl_core_init(para, config);
> +
> +	for (config->banks =3D 0; config->banks < 3; config->banks++) {
> +		if (mctl_mem_matches(1 << (config->banks + config->bankgrps +
> +					   config->cols +
> +					   config->bus_full_width + 1)))
> +			break;
> +	}
> +
> +	/* TODO: This needs further testing on devices with different numbers o=
f banks! */
> +	/* detect bank group address bits */
> +	config->bankgrps =3D 2;
> +	mctl_core_init(para, config);
> +	for (config->bankgrps =3D 0; config->bankgrps < 2; config->bankgrps++) {
> +		if (mctl_mem_matches_base(3 << (config->bankgrps + 2 +
> +						config->bus_full_width),
> +					  CFG_SYS_SDRAM_BASE + 0x10))
> +			break;
> +	}
> +}
> +
> +/* Modified from H616 driver to add banks and bank groups */
> +static unsigned long calculate_dram_size(const struct dram_config *confi=
g)
> +{
> +	/* Bootrom only uses x32 or x16 bus widths */
> +	u8 width =3D config->bus_full_width ? 4 : 2;
> +
> +	return (1ULL << (config->cols + config->rows + config->banks +
> +			 config->bankgrps)) *
> +	       width * (1ULL << config->ranks);
> +}
> +
> +static const struct dram_para para =3D {
> +	.clk =3D CONFIG_DRAM_CLK,
> +#ifdef CONFIG_SUNXI_DRAM_DDR3
> +	.type =3D SUNXI_DRAM_TYPE_DDR3,
> +#elif defined(CONFIG_SUNXI_DRAM_DDR4)
> +	.type =3D SUNXI_DRAM_TYPE_DDR4,
> +#elif defined(CONFIG_SUNXI_DRAM_LPDDR3)
> +	.type =3D SUNXI_DRAM_TYPE_LPDDR3,
> +#elif defined(CONFIG_SUNXI_DRAM_LPDDR4)
> +	.type =3D SUNXI_DRAM_TYPE_LPDDR4,
> +#endif
> +	/* TODO: Populate from config */
> +	.dx_odt =3D CONFIG_DRAM_SUNXI_DX_ODT,
> +	.dx_dri =3D CONFIG_DRAM_SUNXI_DX_DRI,
> +	.ca_dri =3D CONFIG_DRAM_SUNXI_CA_DRI,
> +	.para0 =3D CONFIG_DRAM_SUNXI_PARA0,
> +	.para1 =3D CONFIG_DRAM_SUNXI_PARA1,
> +	.para2 =3D CONFIG_DRAM_SUNXI_PARA2,
> +	.mr0 =3D CONFIG_DRAM_SUNXI_MR0,
> +	.mr1 =3D CONFIG_DRAM_SUNXI_MR1,
> +	.mr2 =3D CONFIG_DRAM_SUNXI_MR2,
> +	.mr3 =3D CONFIG_DRAM_SUNXI_MR3,
> +	.mr4 =3D CONFIG_DRAM_SUNXI_MR4,
> +	.mr5 =3D CONFIG_DRAM_SUNXI_MR5,
> +	.mr6 =3D CONFIG_DRAM_SUNXI_MR6,
> +	.mr11 =3D CONFIG_DRAM_SUNXI_MR11,
> +	.mr12 =3D CONFIG_DRAM_SUNXI_MR12,
> +	.mr13 =3D CONFIG_DRAM_SUNXI_MR13,
> +	.mr14 =3D CONFIG_DRAM_SUNXI_MR14,
> +	.mr16 =3D CONFIG_DRAM_SUNXI_MR16,
> +	.mr17 =3D CONFIG_DRAM_SUNXI_MR17,
> +	.tpr1 =3D CONFIG_DRAM_SUNXI_TPR1,
> +	.tpr2 =3D CONFIG_DRAM_SUNXI_TPR2,
> +	.tpr3 =3D CONFIG_DRAM_SUNXI_TPR3,
> +	.tpr6 =3D CONFIG_DRAM_SUNXI_TPR6,
> +	.tpr10 =3D CONFIG_DRAM_SUNXI_TPR10,
> +	.tpr11 =3D CONFIG_DRAM_SUNXI_TPR11,
> +	.tpr12 =3D CONFIG_DRAM_SUNXI_TPR12,
> +	.tpr13 =3D CONFIG_DRAM_SUNXI_TPR13,
> +	.tpr14 =3D CONFIG_DRAM_SUNXI_TPR14,
> +};
> +
> +/* TODO: Remove, copied and modified slightly from aodzip repo as tempor=
ary sanity check */
> +static int libdram_dramc_simple_wr_test(uint32_t dram_size, uint32_t tes=
t_range)
> +{
> +	uint32_t *dram_memory =3D (uint32_t *)CFG_SYS_SDRAM_BASE;
> +	uint32_t step =3D dram_size / 8;
> +
> +	for (unsigned i =3D 0; i < test_range; i++) {
> +		dram_memory[i] =3D i + 0x1234567;
> +		dram_memory[i + step] =3D i - 0x1234568;
> +	}
> +
> +	for (unsigned i =3D 0; i < test_range; i++) {
> +		uint32_t *ptr;
> +		if (dram_memory[i] !=3D i + 0x1234567) {
> +			ptr =3D &dram_memory[i];
> +			goto fail;
> +		}
> +		if (dram_memory[i + step] !=3D i - 0x1234568) {
> +			ptr =3D &dram_memory[i + step];
> +			goto fail;
> +		}
> +		continue;
> +fail:
> +		debug("DRAM simple test FAIL----- address %p =3D %d\n", ptr,
> +		      readl(ptr));
> +		return 1;
> +	}
> +
> +	debug("DRAM simple test OK.\n");
> +	return 0;
> +}
> +
> +unsigned long sunxi_dram_init(void)
> +{
> +	unsigned long size;
> +
> +	/* Keeping for now as documentation of where different parameters come =
from */
> +	struct dram_config config =3D {
> +		.cols =3D (para.para1 & 0xF),
> +		.rows =3D (para.para1 >> 4) & 0xFF,
> +		.banks =3D (para.para1 >> 12) & 0x3,
> +		.bankgrps =3D (para.para1 >> 14) & 0x3,
> +		.ranks =3D ((para.tpr13 >> 16) & 3),
> +		.bus_full_width =3D !((para.para2 >> 3) & 1),
> +	};
> +
> +	/* Writing to undocumented SYS_CFG area, according to user manual. */
> +	setbits_le32(0x03000160, BIT(8));
> +	clrbits_le32(0x03000168, 0x3f);
> +
> +	/* TODO: Figure out how to catch bank group errors. */
> +	// auto_detect_ranks(&para, &config);
> +	// mctl_auto_detect_dram_size(&para, &config);
> +
> +	if (!mctl_core_init(&para, &config))
> +		return 0;
> +
> +	debug("cols =3D %d, rows =3D %d, banks =3D %d, bankgrps =3D %d, ranks =
=3D %d, full_width =3D %d\n",
> +	      config.cols, config.rows, config.banks, config.bankgrps,
> +	      config.ranks, config.bus_full_width);
> +
> +	size =3D calculate_dram_size(&config);
> +
> +	/* TODO: This is just a sanity check for now. */
> +	if (libdram_dramc_simple_wr_test(size, 4096))
> +		return 0;
> +
> +	return size;
> +}
> diff --git a/arch/arm/mach-sunxi/dram_timings/Makefile b/arch/arm/mach-su=
nxi/dram_timings/Makefile
> index 5f203419240..4dc1f29fc08 100644
> --- a/arch/arm/mach-sunxi/dram_timings/Makefile
> +++ b/arch/arm/mach-sunxi/dram_timings/Makefile
> @@ -6,3 +6,5 @@ obj-$(CONFIG_SUNXI_DRAM_H6_DDR3_1333)	+=3D h6_ddr3_1333.o
>  obj-$(CONFIG_SUNXI_DRAM_H616_DDR3_1333)	+=3D h616_ddr3_1333.o
>  obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR3)	+=3D h616_lpddr3.o
>  obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR4)	+=3D h616_lpddr4_2133.o
> +obj-$(CONFIG_SUNXI_DRAM_A133_DDR4)	+=3D a133_ddr4.o
> +obj-$(CONFIG_SUNXI_DRAM_A133_LPDDR4)	+=3D a133_lpddr4.o
> diff --git a/arch/arm/mach-sunxi/dram_timings/a133_ddr4.c b/arch/arm/mach=
=2Dsunxi/dram_timings/a133_ddr4.c
> new file mode 100644
> index 00000000000..1bfc1f7a3af
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/dram_timings/a133_ddr4.c
> @@ -0,0 +1,80 @@
> +#include <asm/arch/cpu.h>
> +#include <asm/arch/dram.h>
> +
> +void mctl_set_timing_params(const struct dram_para *para)
> +{
> +	struct sunxi_mctl_ctl_reg *const mctl_ctl =3D
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	u8 txsr =3D 4;
> +	u8 tccd =3D 3;
> +	u8 rd2wr =3D 5;
> +	u8 tmrd =3D 4;
> +	u8 tmrw =3D 0;
> +	u8 wrlat =3D 5;
> +	u8 rdlat =3D 7;
> +	u8 wr2pre =3D 14;
> +	u8 dfi_tphy_wrlat =3D 6;
> +	u8 dfi_trddata_en =3D 10;
> +
> +	u8 tfaw =3D ns_to_t(35);
> +	u8 trrd =3D max(ns_to_t(8), 2);
> +	u8 txp =3D max(ns_to_t(6), 2);
> +	u8 tmrd_pda =3D max(ns_to_t(10), 8);
> +	u8 trp =3D ns_to_t(15);
> +	u8 trc =3D ns_to_t(49);
> +	u8 wr2rd_s =3D max(ns_to_t(3), 1) + 7;
> +	u8 tras_min =3D ns_to_t(34);
> +	u16 trefi_x32 =3D ns_to_t(7800) / 32;
> +	u16 trfc_min =3D ns_to_t(350);
> +	u16 txs_x32 =3D ns_to_t(360) / 32;
> +	u16 tmod =3D max(ns_to_t(15), 12);
> +	u8 tcke =3D max(ns_to_t(5), 2);
> +	u8 tcksrx =3D max(ns_to_t(10), 3);
> +	u8 txs_abort_x32 =3D ns_to_t(170) / 32;
> +	u8 tras_max =3D ns_to_t(70200) / 1024;
> +
> +	u8 rd2pre =3D (trp < 5 ? 9 - trp : 4);
> +	u8 wr2rd =3D trrd + 7;
> +	u8 tckesr =3D tcke + 1;
> +	u8 trcd =3D trp;
> +	u8 trrd_s =3D txp;
> +	u8 tcksre =3D tcksrx;
> +
> +	writel(tras_min | tras_max << 8 | tfaw << 16 | wr2pre << 24,
> +	       &mctl_ctl->dramtmg[0]);
> +	writel(trc | rd2pre << 8 | txp << 16, &mctl_ctl->dramtmg[1]);
> +	writel(wr2rd | rd2wr << 8 | rdlat << 16 | wrlat << 24,
> +	       &mctl_ctl->dramtmg[2]);
> +	writel(tmod | tmrd << 12 | tmrw << 20, &mctl_ctl->dramtmg[3]);
> +	writel(trp | trrd << 8 | tccd << 16 | trcd << 24,
> +	       &mctl_ctl->dramtmg[4]);
> +	writel(tcke | tckesr << 8 | tcksre << 16 | tcksrx << 24,
> +	       &mctl_ctl->dramtmg[5]);
> +	writel((txp + 2) | 0x20 << 16 | 0x20 << 24,
> +	       &mctl_ctl->dramtmg[6]);
> +	writel(txs_x32 | 0x10 << 8 | txs_abort_x32 << 16 | txs_abort_x32 << 24,
> +	       &mctl_ctl->dramtmg[8]);
> +	writel(wr2rd_s | trrd_s << 8 | 0x2 << 16, &mctl_ctl->dramtmg[9]);
> +	writel(0xe0c05, &mctl_ctl->dramtmg[10]);
> +	writel(0x440c021c, &mctl_ctl->dramtmg[11]);
> +	writel(tmrd_pda, &mctl_ctl->dramtmg[12]);
> +	writel(0xa100002, &mctl_ctl->dramtmg[13]);
> +	writel(txsr, &mctl_ctl->dramtmg[14]);
> +
> +	clrsetbits_le32(&mctl_ctl->init[0], 0xc0000fff, 1008);
> +	writel(0x1f20000, &mctl_ctl->init[1]);
> +	clrsetbits_le32(&mctl_ctl->init[2], 0xff0f, 0xd05);
> +	writel(0, &mctl_ctl->dfimisc);
> +
> +	writel(para->mr0 << 16 | para->mr1, &mctl_ctl->init[3]);
> +	writel(para->mr2 << 16 | para->mr3, &mctl_ctl->init[4]);
> +	writel(para->mr4 << 16 | para->mr5, &mctl_ctl->init[6]);
> +	writel(para->mr6, &mctl_ctl->init[7]);
> +
> +	clrsetbits_le32(&mctl_ctl->rankctl, 0xff0, 0x660);
> +	writel((dfi_tphy_wrlat - 1) | 0x2000000 | (dfi_trddata_en - 1) << 16 |
> +	       0x808000, &mctl_ctl->dfitmg0);
> +	writel(0x100202, &mctl_ctl->dfitmg1);
> +	writel(trfc_min | trefi_x32 << 16, &mctl_ctl->rfshtmg);
> +}
> diff --git a/arch/arm/mach-sunxi/dram_timings/a133_lpddr4.c b/arch/arm/ma=
ch-sunxi/dram_timings/a133_lpddr4.c
> new file mode 100644
> index 00000000000..7b06d428b6a
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/dram_timings/a133_lpddr4.c
> @@ -0,0 +1,102 @@
> +#include <asm/arch/cpu.h>
> +#include <asm/arch/dram.h>
> +
> +void mctl_set_timing_params(const struct dram_para *para)
> +{
> +	struct sunxi_mctl_ctl_reg *const mctl_ctl =3D
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	bool tpr13_flag1 =3D para->tpr13 & BIT(28);
> +	bool tpr13_flag2 =3D para->tpr13 & BIT(3);
> +	bool tpr13_flag3 =3D para->tpr13 & BIT(5);
> +
> +	u8 tccd		=3D 4;
> +	u8 tfaw		=3D ns_to_t(40);
> +	u8 trrd		=3D max(ns_to_t(10), 2);
> +	u8 trcd		=3D max(ns_to_t(18), 2);
> +	u8 trc		=3D ns_to_t(65);
> +	u8 txp		=3D max(ns_to_t(8), 2);
> +
> +	u8 trp		=3D ns_to_t(21);
> +	u8 tras_min	=3D ns_to_t(42);
> +	u16 trefi_x32	=3D ns_to_t(3904) / 32;
> +	u16 trfc_min	=3D ns_to_t(180);
> +	u16 txsr	=3D ns_to_t(190);
> +
> +	u8 tmrw		=3D max(ns_to_t(14), 5);
> +	u8 tmrd		=3D max(ns_to_t(14), 5);
> +	u8 tmod		=3D 12;
> +	u8 tcke		=3D max(ns_to_t(15), 2);
> +	u8 tcksrx	=3D max(ns_to_t(2), 2);
> +	u8 tcksre	=3D max(ns_to_t(5), 2);
> +	u8 tckesr	=3D max(ns_to_t(15), 2);
> +	u8 tras_max	=3D (trefi_x32 * 9) / 32;
> +	u8 txs_x32	=3D 4;
> +	u8 txsabort_x32 =3D 4;
> +
> +	u8 wrlat        =3D 5;
> +	u8 wr2rd_s      =3D 8;
> +	u8 trrd_s       =3D 2;
> +	u8 tmrd_pda     =3D 8;
> +
> +	u8 wr2pre       =3D 24;
> +	u8 rd2pre       =3D 4;
> +	u8 wr2rd        =3D 14 + max(ns_to_t(tpr13_flag1 ? 10 : 12), 4);
> +	u8 rd2wr        =3D 17 + ns_to_t(4) - ns_to_t(1);
> +	u8 tphy_wrlat	=3D 5;
> +
> +	u8 rdlat	=3D 10;
> +	u8 trddata_en	=3D 17;
> +
> +	if (tpr13_flag1) {
> +		rdlat =3D 11;
> +		trddata_en =3D 19;
> +	}
> +
> +	writel(tras_min | tras_max << 8 | tfaw << 16 | wr2pre << 24,
> +	       &mctl_ctl->dramtmg[0]);
> +	writel(trc | rd2pre << 8 | txp << 16, &mctl_ctl->dramtmg[1]);
> +	writel(wr2rd | rd2wr << 8 | rdlat << 16 | wrlat << 24,
> +	       &mctl_ctl->dramtmg[2]);
> +	writel(tmod | tmrd << 12 | tmrw << 20, &mctl_ctl->dramtmg[3]);
> +	writel(trp | trrd << 8 | tccd << 16 | trcd << 24,
> +	       &mctl_ctl->dramtmg[4]);
> +	writel(tcke | tckesr << 8 | tcksre << 16 | tcksrx << 24,
> +	       &mctl_ctl->dramtmg[5]);
> +	writel((txp + 2) | 0x20 << 16 | 0x20 << 24, &mctl_ctl->dramtmg[6]);
> +	writel(txs_x32 | 0x10 << 8 | txsabort_x32 << 16 | txsabort_x32 << 24,
> +	       &mctl_ctl->dramtmg[8]);
> +	writel(wr2rd_s | trrd_s << 8 | 0x2 << 16, &mctl_ctl->dramtmg[9]);
> +	writel(0xe0c05, &mctl_ctl->dramtmg[10]);
> +	writel(0x440c021c, &mctl_ctl->dramtmg[11]);
> +	writel(tmrd_pda, &mctl_ctl->dramtmg[12]);
> +	writel(0xa100002, &mctl_ctl->dramtmg[13]);
> +	writel(txsr, &mctl_ctl->dramtmg[14]);
> +
> +	clrsetbits_le32(&mctl_ctl->init[0], 0xc0000fff, 1008);
> +
> +	if (tpr13_flag2)
> +		writel(0x420000, &mctl_ctl->init[1]);
> +	else
> +		writel(0x1f20000, &mctl_ctl->init[1]);
> +
> +	clrsetbits_le32(&mctl_ctl->init[2], 0xff0f, 0xd05);
> +	writel(0, &mctl_ctl->dfimisc);
> +
> +	writel(para->mr1 << 16 | para->mr2, &mctl_ctl->init[3]);
> +	writel(para->mr3 << 16, &mctl_ctl->init[4]);
> +	writel(para->mr11 << 16 | para->mr12, &mctl_ctl->init[6]);
> +	writel(para->tpr1 << 16 | para->mr14, &mctl_ctl->init[7]);
> +
> +	clrsetbits_le32(&mctl_ctl->rankctl, 0xff0, 0x660);
> +	if (!tpr13_flag3) {
> +		tphy_wrlat -=3D 1;
> +		trddata_en -=3D 1;
> +	}
> +
> +	writel(tphy_wrlat | trddata_en << 16 | 0x808000 | 0x2000000,
> +	       &mctl_ctl->dfitmg0);
> +	writel(0x100202, &mctl_ctl->dfitmg1);
> +
> +	writel(trfc_min | trefi_x32 << 16, &mctl_ctl->rfshtmg);
> +}
>=20




