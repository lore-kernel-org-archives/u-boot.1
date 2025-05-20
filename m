Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AB4C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 11:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CFA282B00;
	Tue, 20 May 2025 13:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TH2VDknZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C80B82B31; Tue, 20 May 2025 13:48:02 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD97F82A8D
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 13:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54e8e5d2cf0so7130306e87.2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 04:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747741679; x=1748346479; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXTiJPuScwyiplDjI5AmYlRgkIM9i1xO+3bd6SrsOxo=;
 b=TH2VDknZtOLA7h8M3/ElWH8Jb3EqniziYs9dM/1Rs6KbXf40FGG6NJ8WhWkVNqpIKi
 FK9AAmhpa504xeKPAZgEOhWXUjOUFeBAFyVsax1V1Zbs0PHLTyqviOZrtGCljp3UzlDU
 s7zd8V18+RV/eHC/PJ+qD5PIcK71yiA+3aPAmAKaGegnDStxTRwEf8tKlasji1hh9b8E
 IocbyCLaxA5Rn8QDDTFpF5MfZroznJb1oLYCgvTwZ9yXp3Z09XINZMf0Dcr0UozmxY7V
 P/qIpGpC0YjqowFT/haNQYM5sFBIaS0GSqvah8X4u63aZ0UgXvSLGn+9+W33PHENqnul
 jZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747741679; x=1748346479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXTiJPuScwyiplDjI5AmYlRgkIM9i1xO+3bd6SrsOxo=;
 b=gzGmnBhmSH3di8/yDWY3RQz5JEl9HDXK6EU4UQPCny0EQE5eOW4m0ln6QHKn5MEpuB
 rbjTG85IOT+oALkyL/eKUkTEcBqhwS6f3EVjYUUSOOx9ikQTQuQ+d//4TcLi5R00vDTY
 V7lvJViPL615h4WVGdyk9vWfHHazkZkuyFJkckeeWDpqNM45/DOQTrgQErj3Kl4vqFxY
 ziWf7TkaZF0/9Or4H8Uf5rPJgWoIjTh7cy+AAiRyC2Msj3TMLfALtZaGQ5IZsZB8hVS7
 g1ZLaiSCeDMtiMMNgcusMT0f4eB+827Dl5h4zEmmFsve0s+qWhSc9NbAAgfGfSdJj0B2
 Qjkg==
X-Gm-Message-State: AOJu0YysplZsLYoOIvYy4UNE6vUdmgGGv/dPG72B9k+lpYTQlo6xB0Wk
 yrI9B+Bzs76sSfWDdhUOJuBzhATwfOp90UP/aUesNNPyXCOJwBbNSSPFuHSi4zalC2R+a1GV85K
 tC/Qy75nyHrWJ1Oezi7+YH0hdn20iWZt2zg==
X-Gm-Gg: ASbGncvrYSXBug1h9YBW89qe+09J5IevQYXwfEqtG2ck9zkuvSHCrXlkF8DFktlndQY
 7INrFtwfEhHp1AdRFWCjo6WlPgsp4GyJzHfBPBwEQVRebvOiWECnLK4S2FI4vcsL6WRK1xaOn1e
 FXWg8RLQdkT4glhAF5z4C3CDxX4xnUkzV3DL+vZXliOpZjEtPxl/0wpQqIJIszNONRXkuynrEem
 Q==
X-Google-Smtp-Source: AGHT+IHmuImMMTRFYDuBLicJN15IbqVdXT4iL4sPsXVb/j3im8IlkXH91eI+OQIZONEKDmsdq5Z0L7QrxUVBF7JCvPo=
X-Received: by 2002:a05:6512:428b:b0:550:e5c4:b0a1 with SMTP id
 2adb3069b0e04-550e977f264mr3872940e87.11.1747741677232; Tue, 20 May 2025
 04:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250513163633.1803464-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250513163633.1803464-1-dario.binacchi@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 20 May 2025 08:47:42 -0300
X-Gm-Features: AX0GCFta0FghQTGSP29Ho3R0XsCbppHfiXRO4TGila0MEUPqtN0TUctCfZMGPek
Message-ID: <CAOMZO5D1Ss0TX6Rf9u1qqSr6hoSVCwDiuxBx=0E+79sSxqLWZQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] board: bsh: imx6ulz_smm_m2: Match SPL DDR settings to
 DCD table
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Bode <michael.bode@bshg.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Simon Holesch <simon.holesch@bshg.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Wolfgang Birkner <wolfgang.birkner@bshg.com>
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

On Tue, May 13, 2025 at 1:36=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> From: Michael Trimarchi <michael@amarulasolutions.com>
>
> When using SPL on i.mx6 we frequently notice some DDR initialization
> mismatches between the SPL code and the non-SPL code.
>
> As the non-SPL code have been tested for long time and proves to be
> reliable, let's configure the DDR in the exact same way as the non-SPL
> case.
>
> The idea is simple: just use the DCD table and write directly to the DDR
> registers.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
>  arch/arm/include/asm/arch-mx6/mx6-ddr.h |   2 +
>  arch/arm/mach-imx/mx6/ddr.c             |   3 +
>  board/bsh/imx6ulz_smm_m2/spl.c          | 235 +++++++++++++++++-------
>  3 files changed, 178 insertions(+), 62 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-mx6/mx6-ddr.h b/arch/arm/include/a=
sm/arch-mx6/mx6-ddr.h
> index ad9c1ac906a3..bd3ff65bcd96 100644
> --- a/arch/arm/include/asm/arch-mx6/mx6-ddr.h
> +++ b/arch/arm/include/asm/arch-mx6/mx6-ddr.h
> @@ -457,6 +457,8 @@ struct mx6_mmdc_calibration {
>         u32 p1_mpwrdlctl;
>         /* lpddr2 zq hw calibration */
>         u32 mpzqlp2ctl;
> +       /* MDC Duty Cycle Control Register */
> +       u32 mpdccr;
>  };
>
>  /* configure iomux (pinctl/padctl) */
> diff --git a/arch/arm/mach-imx/mx6/ddr.c b/arch/arm/mach-imx/mx6/ddr.c
> index 5a1258e002d2..749ceee0cdbf 100644
> --- a/arch/arm/mach-imx/mx6/ddr.c
> +++ b/arch/arm/mach-imx/mx6/ddr.c
> @@ -1444,6 +1444,9 @@ void mx6_ddr3_cfg(const struct mx6_ddr_sysinfo *sys=
info,
>         mmdc0->mpdgctrl1 =3D calib->p0_mpdgctrl1;
>         mmdc0->mprddlctl =3D calib->p0_mprddlctl;
>         mmdc0->mpwrdlctl =3D calib->p0_mpwrdlctl;
> +       if (calib->mpdccr)
> +               mmdc0->mpdccr =3D calib->mpdccr;
> +
>         if (sysinfo->dsize > 1) {
>                 MMDC1(mpwldectrl0, calib->p1_mpwldectrl0);
>                 MMDC1(mpwldectrl1, calib->p1_mpwldectrl1);
> diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/sp=
l.c
> index 724841b57456..0fa510446813 100644
> --- a/board/bsh/imx6ulz_smm_m2/spl.c
> +++ b/board/bsh/imx6ulz_smm_m2/spl.c
> @@ -31,70 +31,184 @@ static void setup_iomux_uart(void)
>         imx_iomux_v3_setup_multiple_pads(uart4_pads, ARRAY_SIZE(uart4_pad=
s));
>  }
>
> -static struct mx6ul_iomux_grp_regs mx6_grp_ioregs =3D {
> -       .grp_addds              =3D 0x00000028,
> -       .grp_ddrmode_ctl        =3D 0x00020000,
> -       .grp_b0ds               =3D 0x00000028,
> -       .grp_ctlds              =3D 0x00000028,
> -       .grp_b1ds               =3D 0x00000028,
> -       .grp_ddrpke             =3D 0x00000000,
> -       .grp_ddrmode            =3D 0x00020000,
> -       .grp_ddr_type           =3D 0x000c0000,
> +struct dram_cfg_param {
> +       unsigned int reg;
> +       unsigned int val;
>  };

static struct.


>
> -static struct mx6ul_iomux_ddr_regs mx6_ddr_ioregs =3D {
> -       .dram_dqm0              =3D 0x00000028,
> -       .dram_dqm1              =3D 0x00000028,
> -       .dram_ras               =3D 0x00000028,
> -       .dram_cas               =3D 0x00000028,
> -       .dram_odt0              =3D 0x00000028,
> -       .dram_odt1              =3D 0x00000028,
> -       .dram_sdba2             =3D 0x00000000,
> -       .dram_sdclk_0           =3D 0x00000028,
> -       .dram_sdqs0             =3D 0x00000028,
> -       .dram_sdqs1             =3D 0x00000028,
> -       .dram_reset             =3D 0x000c0028,
> +struct dram_timing_info {
> +       const struct dram_cfg_param *ddrc_cfg;
> +       unsigned int ddrc_cfg_num;

static struct.

Please check globally in the series where the definitions can be made stati=
c.

> +static const struct dram_cfg_param ddr_ddrc_cfg_128mb[] =3D {
> +       // IOMUX
> +
> +       //DDR IO TYPE:

Please use the standard C comment style:

/* For single line comment */

/*
 * Or this style,
 * For multi-line comments.
 */

Also, please put a space before DDR.  The same applies everywhere in
this series.

> +       //Write calibration
> +       { 0x021b0850, 0x4040362E },     // MPWRDLCTL PHY0
> +
> +       //read data bit delay: 3 is the reccommended default value, altho=
ugh out of reset value is 0

Typo: recommended

> +       //MMDC init:
> +       { 0x021b0004, 0x0002002D },     // MMDC0_MDPDC
> +       { 0x021b0008, 0x1B333030 },     // MMDC0_MDOTC
> +       { 0x021b000c, 0x2B2F52F3 },     // MMDC0_MDCFG0
> +       { 0x021b0010, 0xB66D0B63 },     // MMDC0_MDCFG1
> +       { 0x021b0014, 0x01FF00DB },     // MMDC0_MDCFG2
> +
> +       //MDMISC: RALAT kept to the high level of 5.
> +       //MDMISC: consider reducing RALAT if your 528MHz board design all=
ow that.
> +       //Lower RALAT benefits:
> +       //a. better operation at low frequency, for LPDDR2 freq < 100MHz,=
 change RALAT to 3
> +       //b. Small performence improvement

Typo: performance

> +       //    {0x021b001c,0x0200803A}, // MMDC0_MDSCR, MR2 write, CS1
> +       //    {0x021b001c,0x0000803B}, // MMDC0_MDSCR, MR3 write, CS1
> +       //    {0x021b001c,0x00048039}, // MMDC0_MDSCR, MR1 write, CS1
> +       //    {0x021b001c,0x15208038}, // MMDC0_MDSCR, MR0write, CS1
> +       //    {0x021b001c,0x04008048}, // MMDC0_MDSCR, ZQ calibration com=
mand sent to device on CS1

Please don't add the comment code. Please remove these commented code lines=
.

> +static void ddr_cfg_write(const struct dram_timing_info *dram_timing_inf=
o)
> +{
> +       int i =3D 0;

You don't need to initialize i.
