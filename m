Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB2AC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAAF7409FA;
	Tue, 28 Jul 2026 12:12:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iNHWd5FtvIay; Tue, 28 Jul 2026 12:12:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C109409AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785240751;
	bh=bRzb01WgIq+rHUC65p+a4JU5hlZly5Xl6Q79RNMn8HY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A4Z0ki47i9fFEuItpk2buhgMrmKgU6/b39dEjs4XLNsQMD+rVPGWVznQSAjTBXvVg
	 RyN0kTPbt5tB0HvuEULCCKD5ZtTE8uneoMN26AlWjbuxafLkw/3yVNkpQs86f2Cqnv
	 UVEKXWiIhsfcDuic5Aq4y3DolPWVks1R1BIj/MhKptCr6NbfBaDIa/SjvkcTZfYCAo
	 ZOt0wHL8EFJOpLUkJZXVG5/HcOipI+zwHIVUoFofzg3pkBBNkrDOVok8hT5lENmgOK
	 WmYR+/dRnZ1a9VUR9hug4hjswk6Nso8xASR/EJ+APlM4m8ASkRa7jay1gTealrlElB
	 PwbCykgikwEbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C109409AA;
	Tue, 28 Jul 2026 12:12:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3314A490
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18BD4409AA
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:12:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VhcUDcdsSJ0T for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:12:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9C2EF409A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C2EF409A2
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C2EF409A2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:12:28 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5b021916bd3so4035910e87.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785240746; cv=none;
 d=google.com; s=arc-20260327;
 b=j6/nbAIUFcQXy1ub0URF4+8PYLohVINVwHRf4ljJFlDucMkg4/u/Pt26xt1M59sPLh
 DrrGP9aAc76p0kgME2R4GtlrIfRoIGpb8RqNyn75CENY1QFxjXegDoctjMPTy2EWExUu
 rAk81B/bkmoKsYyTCQqQvzAJUE/rl5oVgGi4YTCxA7JpeaYYpdu4SrZ+gVKmfoCRiech
 zX9AzYGMdcemalPI3TW+q6EudY8ALDh84PXEleU+Cw0bwlxQ/Va9BAEi2UbUaKcIR/lm
 cd9HvORRCp6+qolzUEEn6MLHgqAQr+ToEuEAhzEB0qntg9kY27I4xqKKxCrdTXxmKUQp
 ocgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bRzb01WgIq+rHUC65p+a4JU5hlZly5Xl6Q79RNMn8HY=;
 fh=otXNJu7/TA+NuG+XdSxtLZKlZucNX+AZyyA53ZMNJ88=;
 b=RVqJMDO+Z8bhhoRe/wSedQw8SkSifV78cZliOOvPzz4V+jV+ah8KkWotoPnnXmY7sM
 St8+O9tocB7viiUDPHPITOdl7vtbGmtGXuz0bRfqHX23xVASDGBNhBBu2eD2D6EBTJB8
 O0hugollLIN98Tz6cpkDCXE1H3RMIY+jMNq0ZAjkCbUImO+YSnDLEcK5AEHSSlP15Ici
 KWZxeKZZ9wlmMrb8mawOjbn9oevZekAyCm8dSmP4fwIEW38X8W1hKFgojWgWUg7cdnXW
 9CscYCGIbF2ABueiRTBHVJHVlI0ERCU60feEjZH7+qA6nkSLenfrg68FHZO8GSDHUBSe
 8Xtw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785240746; x=1785845546;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bRzb01WgIq+rHUC65p+a4JU5hlZly5Xl6Q79RNMn8HY=;
 b=Bt+D0AobQo2uN0kvUOPfh1If6UDN0GQXRQA53pPgY2YAXKhmIufrtelgwjRn5LuYx1
 lQJ/R8o3rqTK0niX2DuwQFaCzwcmA7n/t8SQYd9DvScEMszZXqZhGpqhoGYhyLswZnwE
 q1RXlTX6GPnjEbmy7Nf4gnpjr47R5JetHdQiwRViC1702zWFb+FVwieehoiMWEtnDuvZ
 NGOUifYSw9Fa8UdOGpIkkSi0qutcfTHkWeDKviYOokd14ixdZ16YwtEePgUENyIJEvWH
 wmvGPOC2PUIL3wNo3w8sFJWOEPZIYcRnWvKcxpoKvECvvSQM/abU/ly5fQ7irxIaxfy0
 yr8g==
X-Gm-Message-State: AOJu0YwbYHFWNwIuThQ1MfLDVR2umPgNmGAbLNp40SvVk1FT1BPxf9JE
 yedr7qDUZc9vyYGcts+e+wAgN0bYeHOGtCIduPTUisT7bGfbf4OWU8va6t/5PUjsK4Yo1SkM8mw
 KSIXiX8jKiC1CHJBn3oBy/qwrZZbKmw4=
X-Gm-Gg: AR+sD10J4poMDxUetkwdUU+QZJe+yFDsR9HGXbGKXAutsokYtBtk823xsP1NchKiywf
 ye6naAqTaXb8MM1GLnCGWMUp3dMNWdmfEJA96WB3mSUuxVKyH1CmsNxR7EB0z/sX6clAhFxCDwz
 eJAKATbYoS8Itmh32i0BWEKkrM0gmfGE2/+SdrpsMqkQZq0rpmcBCp5x7nQtJ+24yEirMJPd80M
 CJ0GG3v6TNTPjUyZx0ZzV/e2dZG76kf+vDob5oLrtxDHX8tg33BzytP99P/LAL3SnIhNewhSpRt
 6QIQodfuOQ4WRa9OJHEoHPYDi+s0SULJPAyz5a4bIBnlu0TvbXFbkkHx+030gA==
X-Received: by 2002:a05:6512:3402:b0:5b1:5e05:31df with SMTP id
 2adb3069b0e04-5b2d020c337mr525328e87.13.1785240745780; Tue, 28 Jul 2026
 05:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260723134051.452817-1-krzysztof@kd-solutions.pl>
 <20260723134051.452817-3-krzysztof@kd-solutions.pl>
In-Reply-To: <20260723134051.452817-3-krzysztof@kd-solutions.pl>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 Jul 2026 09:12:13 -0300
X-Gm-Features: AUfX_my2oJkZckFl-Vk5nLC2V-uKI-HtA0hOOB-3wyU24U4yxmvM06R_IynuoZk
Message-ID: <CAOMZO5ATg_8Ts6oY3ougg9ZDgaEP+YwW9-14KdhHEt6gYHFzig@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: regulator: ADD PMIC PF9453 support
To: =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 jh80.chung@samsung.com, peng.fan@nxp.com, Joy Zou <joy.zou@nxp.com>, 
 Ye Li <ye.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785240746; x=1785845546;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bRzb01WgIq+rHUC65p+a4JU5hlZly5Xl6Q79RNMn8HY=;
 b=atdv+8867F1vTB9pr7RuEQyuj1h98aMzvmR+VEsWJqnEOCxduVtlkmKKuvOMXxcpZq
 N5JwKOHBJCwY7gBNdyc/SFo0uiPEc6sx74G5rXzWbcyBCfAR1x5nLJOKuvGQEt53Z+0X
 4PTJ/V4cRUhcwGGTblDOsYcFuqFOhq39voXpEH1wWo7T8wvp+8xCXkHmTOLLYyekS+71
 vXxEljpg50peQZdcmV6b63LXzU3zdzQFJzQ4xmEYB7tdohRRBtGtd8Y1MqOmCJo3lXe1
 LxJ3Wef/2t1VGfKbvsDJaLGahhwS8kGvHt719IEkZ8e4Ll8u6cc/5l5hyWsAO784VDtl
 y5cA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=atdv+886
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Krzysztof,

Nitpick: No need to spell "Add" in all capital letters in the Subject line.

On Thu, Jul 23, 2026 at 10:49=E2=80=AFAM Krzysztof Drobi=C5=84ski
<krzysztof@kd-solutions.pl> wrote:
>
> From: Joy Zou <joy.zou@nxp.com>
>
> Add regulator support for NXP PMIC pf9453 for imx91 qsb.

This patch does not touch imx91 qsb, so please remove its reference.

It would be nice to add the pf9453 support to any board, as a separate
patch, though.

Thanks


> Reviewed-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Rebased [1] on main and LDO SNVS access / checkpatch fixed. See also [2]
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20240930035531.27079=
-4-peng.fan@oss.nxp.com/
> [2] https://lists.u-boot-project.org/pipermail/u-boot/2026-July/625613.ht=
ml
> Signed-off-by: Krzysztof Drobi=C5=84ski <krzysztof@kd-solutions.pl>
> ---
>  drivers/power/regulator/Kconfig  |  15 ++
>  drivers/power/regulator/Makefile |   1 +
>  drivers/power/regulator/pf9453.c | 256 +++++++++++++++++++++++++++++++
>  3 files changed, 272 insertions(+)
>  create mode 100644 drivers/power/regulator/pf9453.c
>
> diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kc=
onfig
> index c3dc5d6f97b..00a25acfdf9 100644
> --- a/drivers/power/regulator/Kconfig
> +++ b/drivers/power/regulator/Kconfig
> @@ -103,6 +103,21 @@ config SPL_DM_REGULATOR_PCA9450
>           This config enables implementation of driver-model regulator uc=
lass
>           features for regulators on ROHM PCA9450 in SPL.
>
> +config DM_REGULATOR_PF9453
> +       bool "Enable Driver Model for NXP PF9453 regulators"
> +       depends on DM_REGULATOR && DM_PMIC_PF9453
> +       help
> +         This config enables implementation of driver-model regulator uc=
lass
> +         features for regulators on NXP PF9453 PMICs. PF9453 contains 6 =
bucks
> +         and 5 LDOS. The driver implements get/set api for value and ena=
ble.
> +
> +config SPL_DM_REGULATOR_PF9453
> +       bool "Enable Driver Model for NXP PF9453 regulators in SPL"
> +       depends on DM_REGULATOR_PF9453 && SPL
> +       help
> +         This config enables implementation of driver-model regulator uc=
lass
> +         features for regulators on ROHM PF9453 in SPL.
> +
>  config DM_REGULATOR_DA9063
>         bool "Enable Driver Model for REGULATOR DA9063"
>         depends on DM_REGULATOR && DM_PMIC_DA9063
> diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/M=
akefile
> index 3a148545387..a40c9d340d9 100644
> --- a/drivers/power/regulator/Makefile
> +++ b/drivers/power/regulator/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_DM_REGULATOR_NPCM8XX) +=3D npcm8xx_regulat=
or.o
>  obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PFUZE100) +=3D pfuze100.o
>  obj-$(CONFIG_$(PHASE_)DM_REGULATOR_BD71837) +=3D bd71837.o
>  obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PCA9450) +=3D pca9450.o
> +obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PF9453) +=3D pf9453.o
>  obj-$(CONFIG_$(PHASE_)REGULATOR_PWM) +=3D pwm_regulator.o
>  obj-$(CONFIG_$(PHASE_)DM_REGULATOR_FAN53555) +=3D fan53555.o
>  obj-$(CONFIG_$(PHASE_)DM_REGULATOR_COMMON) +=3D regulator_common.o
> diff --git a/drivers/power/regulator/pf9453.c b/drivers/power/regulator/p=
f9453.c
> new file mode 100644
> index 00000000000..6ecde09bafa
> --- /dev/null
> +++ b/drivers/power/regulator/pf9453.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * NXP PF9453 regulator driver
> + * Copyright 2024 NXP
> + */
> +
> +#include <dm.h>
> +#include <errno.h>
> +#include <log.h>
> +#include <linux/bitops.h>
> +#include <power/pf9453.h>
> +#include <power/pmic.h>
> +#include <power/regulator.h>
> +
> +/**
> + * struct pf9453_vrange - describe linear range of voltages
> + *
> + * @min_volt:  smallest voltage in range
> + * @step:      how much voltage changes at each selector step
> + * @min_sel:   smallest selector in the range
> + * @max_sel:   maximum selector in the range
> + */
> +struct pf9453_vrange {
> +       unsigned int    min_volt;
> +       unsigned int    step;
> +       u8              min_sel;
> +       u8              max_sel;
> +};
> +
> +/**
> + * struct pf9453_plat - describe regulator control registers
> + *
> + * @name:      name of the regulator. Used for matching the dt-entry
> + * @enable_reg:        register address used to enable/disable regulator
> + * @enablemask:        register mask used to enable/disable regulator
> + * @volt_reg:  register address used to configure regulator voltage
> + * @volt_mask: register mask used to configure regulator voltage
> + * @ranges:    pointer to ranges of regulator voltages and matching regi=
ster
> + *             values
> + * @numranges: number of voltage ranges pointed by ranges
> + */
> +struct pf9453_plat {
> +       const char              *name;
> +       u8                      enable_reg;
> +       u8                      enablemask;
> +       u8                      volt_reg;
> +       u8                      volt_mask;
> +       struct pf9453_vrange    *ranges;
> +       unsigned int            numranges;
> +};
> +
> +#define PCA_RANGE(_min, _vstep, _sel_low, _sel_hi) \
> +{ \
> +       .min_volt =3D (_min), .step =3D (_vstep), \
> +       .min_sel =3D (_sel_low), .max_sel =3D (_sel_hi), \
> +}
> +
> +#define PCA_DATA(_name, enreg, enmask, vreg, vmask, _range, _numranges) =
\
> +{ \
> +       .name =3D (_name), .enable_reg =3D (enreg), .enablemask =3D (enma=
sk), \
> +       .volt_reg =3D (vreg), .volt_mask =3D (vmask), .ranges =3D (_range=
), \
> +       .numranges =3D _numranges \
> +}
> +
> +static struct pf9453_vrange pf9453_buck134_vranges[] =3D {
> +       PCA_RANGE(600000, 25000, 0, 0x7f),
> +};
> +
> +static struct pf9453_vrange pf9453_buck2_vranges[] =3D {
> +       PCA_RANGE(600000, 12500, 0, 0x7f),
> +};
> +
> +static struct pf9453_vrange pf9453_ldo1_vranges[] =3D {
> +       PCA_RANGE(800000, 25000, 0x0, 0x64),
> +};
> +
> +static struct pf9453_vrange pf9453_ldo2_vranges[] =3D {
> +       PCA_RANGE(500000, 25000, 0x0, 0x3a),
> +};
> +
> +static struct pf9453_vrange pf9453_ldosnvs_vranges[] =3D {
> +       PCA_RANGE(800000, 25000, 0x0, 0x58),
> +};
> +
> +static struct pf9453_plat pf9453_reg_data[] =3D {
> +       PCA_DATA("BUCK1", PF9453_BUCK1CTRL, PF9453_EN_MODE_MASK,
> +                PF9453_BUCK1OUT, PF9453_BUCK_RUN_MASK,
> +                pf9453_buck134_vranges, ARRAY_SIZE(pf9453_buck134_vrange=
s)),
> +       PCA_DATA("BUCK2", PF9453_BUCK2CTRL, PF9453_EN_MODE_MASK,
> +                PF9453_BUCK2OUT, PF9453_BUCK_RUN_MASK,
> +                pf9453_buck2_vranges, ARRAY_SIZE(pf9453_buck2_vranges)),
> +       PCA_DATA("BUCK3", PF9453_BUCK3CTRL, PF9453_EN_MODE_MASK,
> +                PF9453_BUCK3OUT, PF9453_BUCK_RUN_MASK,
> +                pf9453_buck134_vranges, ARRAY_SIZE(pf9453_buck134_vrange=
s)),
> +       PCA_DATA("BUCK4", PF9453_BUCK4CTRL, PF9453_EN_MODE_MASK,
> +                PF9453_BUCK4OUT, PF9453_BUCK_RUN_MASK,
> +                pf9453_buck134_vranges, ARRAY_SIZE(pf9453_buck134_vrange=
s)),
> +       /* LDOs */
> +       PCA_DATA("LDO1", PF9453_LDO1CFG, PF9453_EN_MODE_MASK,
> +                PF9453_LDO1OUT_H, PF9453_LDO1_MASK,
> +                pf9453_ldo1_vranges, ARRAY_SIZE(pf9453_ldo1_vranges)),
> +       PCA_DATA("LDO2", PF9453_LDO2CFG, PF9453_EN_MODE_MASK,
> +                PF9453_LDO2OUT, PF9453_LDO2_MASK,
> +                pf9453_ldo2_vranges, ARRAY_SIZE(pf9453_ldo2_vranges)),
> +       PCA_DATA("LDO-SNVS", PF9453_LDOSNVS_CFG2, PF9453_EN_MODE_MASK,
> +                PF9453_LDOSNVS_CFG1, PF9453_LDOSNVS_MASK,
> +                pf9453_ldosnvs_vranges, ARRAY_SIZE(pf9453_ldosnvs_vrange=
s)),
> +};
> +
> +static int vrange_find_value(struct pf9453_vrange *r, unsigned int sel,
> +                            unsigned int *val)
> +{
> +       if (!val || sel < r->min_sel || sel > r->max_sel)
> +               return -EINVAL;
> +
> +       *val =3D r->min_volt + r->step * (sel - r->min_sel);
> +       return 0;
> +}
> +
> +static int vrange_find_selector(struct pf9453_vrange *r, int val,
> +                               unsigned int *sel)
> +{
> +       int ret =3D -EINVAL;
> +       int num_vals =3D r->max_sel - r->min_sel + 1;
> +
> +       if (val >=3D r->min_volt &&
> +           val <=3D r->min_volt + r->step * (num_vals - 1)) {
> +               if (r->step) {
> +                       *sel =3D r->min_sel + ((val - r->min_volt) / r->s=
tep);
> +                       ret =3D 0;
> +               } else {
> +                       *sel =3D r->min_sel;
> +                       ret =3D 0;
> +               }
> +       }
> +       return ret;
> +}
> +
> +static int pf9453_get_enable(struct udevice *dev)
> +{
> +       struct pf9453_plat *plat =3D dev_get_plat(dev);
> +       int val;
> +
> +       val =3D pmic_reg_read(dev->parent, plat->enable_reg);
> +       if (val < 0)
> +               return val;
> +
> +       return (val & plat->enablemask);
> +}
> +
> +static int pf9453_set_enable(struct udevice *dev, bool enable)
> +{
> +       int val =3D 0;
> +       struct pf9453_plat *plat =3D dev_get_plat(dev);
> +
> +       if (enable)
> +               val =3D plat->enablemask;
> +
> +       return pmic_clrsetbits(dev->parent, plat->enable_reg, plat->enabl=
emask,
> +                              val);
> +}
> +
> +static int pf9453_get_value(struct udevice *dev)
> +{
> +       struct pf9453_plat *plat =3D dev_get_plat(dev);
> +       unsigned int reg, tmp;
> +       int i, ret;
> +
> +       ret =3D pmic_reg_read(dev->parent, plat->volt_reg);
> +       if (ret < 0)
> +               return ret;
> +
> +       reg =3D ret;
> +       reg &=3D plat->volt_mask;
> +
> +       for (i =3D 0; i < plat->numranges; i++) {
> +               struct pf9453_vrange *r =3D &plat->ranges[i];
> +
> +               if (!vrange_find_value(r, reg, &tmp))
> +                       return tmp;
> +       }
> +
> +       pr_err("Unknown voltage value read from pmic\n");
> +
> +       return -EINVAL;
> +}
> +
> +static int pf9453_set_value(struct udevice *dev, int uvolt)
> +{
> +       struct pf9453_plat *plat =3D dev_get_plat(dev);
> +       unsigned int sel;
> +       int i, found =3D 0;
> +
> +       for (i =3D 0; i < plat->numranges; i++) {
> +               struct pf9453_vrange *r =3D &plat->ranges[i];
> +
> +               found =3D !vrange_find_selector(r, uvolt, &sel);
> +               if (found) {
> +                       unsigned int tmp;
> +
> +                       /*
> +                        * We require exactly the requested value to be
> +                        * supported - this can be changed later if neede=
d
> +                        */
> +                       found =3D !vrange_find_value(r, sel, &tmp);
> +                       if (found && tmp =3D=3D uvolt)
> +                               break;
> +                       found =3D 0;
> +               }
> +       }
> +
> +       if (!found)
> +               return -EINVAL;
> +
> +       return pmic_clrsetbits(dev->parent, plat->volt_reg,
> +                              plat->volt_mask, sel);
> +}
> +
> +static int pf9453_regulator_probe(struct udevice *dev)
> +{
> +       struct pf9453_plat *plat =3D dev_get_plat(dev);
> +       int i, type;
> +
> +       type =3D dev_get_driver_data(dev_get_parent(dev));
> +
> +       if (type !=3D NXP_CHIP_TYPE_PF9453) {
> +               debug("Unknown PMIC type\n");
> +               return -EINVAL;
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(pf9453_reg_data); i++) {
> +               if (strcmp(dev->name, pf9453_reg_data[i].name))
> +                       continue;
> +               *plat =3D pf9453_reg_data[i];
> +               return 0;
> +       }
> +
> +       pr_err("Unknown regulator '%s'\n", dev->name);
> +
> +       return -ENOENT;
> +}
> +
> +static const struct dm_regulator_ops pf9453_regulator_ops =3D {
> +       .get_value      =3D pf9453_get_value,
> +       .set_value      =3D pf9453_set_value,
> +       .get_enable     =3D pf9453_get_enable,
> +       .set_enable     =3D pf9453_set_enable,
> +};
> +
> +U_BOOT_DRIVER(pf9453_regulator) =3D {
> +       .name           =3D PF9453_REGULATOR_DRIVER,
> +       .id             =3D UCLASS_REGULATOR,
> +       .ops            =3D &pf9453_regulator_ops,
> +       .probe          =3D pf9453_regulator_probe,
> +       .plat_auto      =3D sizeof(struct pf9453_plat),
> +};
> --
> 2.53.0
>
