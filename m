Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794D4C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 17:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A93D382C2F;
	Tue, 20 May 2025 19:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="okPrm7fP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8881F82C55; Tue, 20 May 2025 19:07:30 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CBB982B00
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 19:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-231d4679580so39516105ad.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747760846; x=1748365646;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMHH4euMz2HwCo6uMn7bWI3AEAiFE8CzaIaVrqQiO/U=;
 b=okPrm7fPkDhj3muPlZD7IMmoFHkpPvwb/C5UaEfwwqrcxHW0qC4P92DPEpl3YacfwZ
 iIiudz06CWWoxyHShTKojCxbrCCe3bd8cbv660GZuYKI4Sug25ngfM9S7MFOQxpoGeGv
 lf8hrIkIhXTWyp7EDNKZSx2NbS9yesXrR9ekE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760846; x=1748365646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMHH4euMz2HwCo6uMn7bWI3AEAiFE8CzaIaVrqQiO/U=;
 b=f89KtNGkZ4A66BwfGIyHIFzPhSfGyrnGhtfQ7ZI6ij/XNNE1LmxdjpJnJBadXGXb9/
 taBjcBrifmqMMFyL0Nm6V9e2V1GDIrWUn6Euq8jAUCPk/roQYHgCuc+KMysgxBYgZ10m
 aD0jgQza+DIEdM6424TD2Dhfsc6ufE6bqKMXa+isyD9/bo09204a4UwFzX3XJJwaQ9Bu
 Fmn1PTs/gDOGderVMV2sUL+T/LwHnt1TGUDgfQ0Mzdp1aoMpbLaNsqykhCCX77M40BZs
 Ovw8V1wm8YiXwTYHVvJJL6SZjcadyNcPGMfDTsmWjchjTuN3SBvhoL68J6f6Z9ddspLY
 x1ug==
X-Gm-Message-State: AOJu0YzXfGICjYETv3tlGlAVPknLxB49Mq/FFb/PI5aqbzdZYs/MUpES
 VmibDpdI+L+zGJpUcM3wpgBUPI9K7tXq3yY78Aak/QuhsC7yuK/967nEujRMFpa4z3+vKaueaO0
 vk/jRhx5UO1HVBnWJ+R8L5dRwy7EslTvsgvVoS5WjxAT5m+r9a6Vf8IfyMA==
X-Gm-Gg: ASbGncsnjVAA1HVM9feH267uS5LoWTAidD3CuLRxfNj5bIQMrQyxxB8+JSq8xfryQES
 Nn1mLcmGEYfvKP0DpGIh5CG+UiSINpOB8xX4ME5hiKihBJVvkMO1iW0Iv6zCiNqCQVtpKZpVPep
 nM0yTSWIg9zqTBfh2LuCPg/F6XAqOrNed2
X-Google-Smtp-Source: AGHT+IGS6UAjxWsejglaKavnMcj37XdIZtvrpGmg9syCaYf+C3mRJ09RWBnClBeIzgZ6sMxIL78Gfw0+ZEd68oI4VjA=
X-Received: by 2002:a17:902:ea05:b0:22e:4a2e:8ae7 with SMTP id
 d9443c01a7336-231d451db06mr284289535ad.22.1747760845754; Tue, 20 May 2025
 10:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250520150709.988904-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250520150709.988904-1-dario.binacchi@amarulasolutions.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 20 May 2025 19:07:13 +0200
X-Gm-Features: AX0GCFtJKcp_bx9ZVbek331pLjW9kjnAawR_cO6uDiOHltIMBf11mGFI_F-5ltI
Message-ID: <CAOf5uwneOWNoHyOUSt_8Wadsu0go+pz6wAzJwdhr1GRp6UT2yw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] board: bsh: imx6ulz_smm_m2: Match SPL DDR settings
 to DCD table
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Michael Bode <michael.bode@bshg.com>, 
 linux-amarula@amarulasolutions.com, Simon Holesch <simon.holesch@bshg.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, 
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

Hi Dario

On Tue, May 20, 2025 at 5:07=E2=80=AFPM Dario Binacchi
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
>
> ---
>
> Changes in v2:
> - Add 'static struct' globally in the module where the definitions
>   can mabe static.
> - Use standard C comment style
>
>  arch/arm/include/asm/arch-mx6/mx6-ddr.h |   2 +
>  arch/arm/mach-imx/mx6/ddr.c             |   3 +
>  board/bsh/imx6ulz_smm_m2/spl.c          | 260 ++++++++++++++++++------
>  3 files changed, 203 insertions(+), 62 deletions(-)
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

This should be in this patch? Don't think so

Michael

>         if (sysinfo->dsize > 1) {
>                 MMDC1(mpwldectrl0, calib->p1_mpwldectrl0);
>                 MMDC1(mpwldectrl1, calib->p1_mpwldectrl1);
> diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/sp=
l.c
> index 724841b57456..936e54662e98 100644
> --- a/board/bsh/imx6ulz_smm_m2/spl.c
> +++ b/board/bsh/imx6ulz_smm_m2/spl.c
> @@ -31,70 +31,209 @@ static void setup_iomux_uart(void)
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
>  };
>
> -static struct mx6_mmdc_calibration mx6_mmcd_calib =3D {
> -       .p0_mpwldectrl0         =3D 0x00000000,
> -       .p0_mpwldectrl1         =3D 0x00100010,
> -       .p0_mpdgctrl0           =3D 0x414c014c,
> -       .p0_mpdgctrl1           =3D 0x00000000,
> -       .p0_mprddlctl           =3D 0x40403a42,
> -       .p0_mpwrdlctl           =3D 0x4040342e,
> -};
> +static const struct dram_cfg_param ddr_ddrc_cfg_128mb[] =3D {
> +       /* IOMUX */
> +
> +       /* DDR IO Type: */
> +       {0x020e04b4, 0x000C0000},       /* IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE=
 */
> +       {0x020e04ac, 0x00000000},       /* IOMUXC_SW_PAD_CTL_GRP_DDRPKE *=
/
> +
> +       /* Clock: */
> +       {0x020e027c, 0x00000028},       /* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDC=
LK_0 */
> +
> +       /* Address: */
> +       {0x020e0250, 0x00000028},       /* IOMUXC_SW_PAD_CTL_PAD_DRAM_CAS=
 */
> +       {0x020e024c, 0x00000028},       /* IOMUXC_SW_PAD_CTL_PAD_DRAM_RAS=
 */
> +       {0x020e0490, 0x00000028},       /* IOMUXC_SW_PAD_CTL_GRP_ADDDS */
> +
> +       /* Control: */
> +       {0x020e0288, 0x000C0028},       /* IOMUXC_SW_PAD_CTL_PAD_DRAM_RES=
ET */
> +
> +       {0x020e0270, 0x00000000},       /*
> +                                        * IOMUXC_SW_PAD_CTL_PAD_DRAM_SDB=
A2 - DSE can be configured
> +                                        * using Group Control Register: =
IOMUXC_SW_PAD_CTL_GRP_CTLDS
> +                                        */
> +
> +       {0x020e0260, 0x00000028},       /* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDO=
DT0 */
> +       {0x020e0264, 0x00000028},       /* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDO=
DT1 */
> +       {0x020e04a0, 0x00000028},       /* IOMUXC_SW_PAD_CTL_GRP_CTLDS */
> +
> +       /* Data Strobes: */
> +       {0x020e0494, 0x00020000},       /* IOMUXC_SW_PAD_CTL_GRP_DDRMODE_=
CTL */
> +       {0x020e0280, 0x00000028},       /* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQ=
S0 */
> +       {0x020e0284, 0x00000028},       /* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQ=
S1 */
> +
> +       /* Data: */
> +       {0x020e04b0, 0x00020000},       /* IOMUXC_SW_PAD_CTL_GRP_DDRMODE =
*/
> +       {0x020e0498, 0x00000028},       /* IOMUXC_SW_PAD_CTL_GRP_B0DS */
> +       {0x020e04a4, 0x00000028},       /* IOMUXC_SW_PAD_CTL_GRP_B1DS */
> +
> +       {0x020e0244, 0x00000028},       /* IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM=
0 */
> +       {0x020e0248, 0x00000028},       /* IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM=
1 */
> +
> +       /*
> +        * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +        * DDR Controller Registers
> +        * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +        * Manufacturer:ISSI
> +        * Device Part Number:IS43TR16640BL-125JBLI
> +        * Clock Freq.: 400MHz
> +        * Density per CS in Gb: 1
> +        * Chip Selects used:1
> +        * Number of Banks:8
> +        * Row address:    13
> +        * Column address: 10
> +        * Data bus width16
> +        * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +        */
> +
> +       {0x021b001c, 0x00008000}, /*
> +                                  * MMDC0_MDSCR, set the Configuration r=
equest bit during
> +                                  * MMDC set up
> +                                  */
> +
> +       /*
> +        * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +        * Calibration setup
> +        * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +        */
> +
> +       {0x021b0800, 0xA1390003}, /*
> +                                  * DDR_PHY_P0_MPZQHWCTRL, enable both o=
ne-time & periodic
> +                                  * HW ZQ calibration.
> +                                  */
> +
> +       /*
> +        * For target board, may need to run write leveling calibration t=
o fine tune these
> +        * settings.
> +        */
> +       {0x021b080c, 0x00000000},
> +
> +       /* Read DQS Gating calibration */
> +       {0x021b083c, 0x41480148},       /* MPDGCTRL0 PHY0 */
> +
> +       /* Read calibration */
> +       {0x021b0848, 0x40403A3E},       /* MPRDDLCTL PHY0 */
> +
> +       /* Write calibration */
> +       {0x021b0850, 0x4040362E},       /* MPWRDLCTL PHY0 */
> +
> +       /*
> +        * Read data bit delay: 3 is the recommended default value, altho=
ugh out of reset
> +        * value is 0
> +        */
> +       {0x021b081c, 0x33333333},       /* MMDC_MPRDDQBY0DL */
> +       {0x021b0820, 0x33333333},       /* MMDC_MPRDDQBY1DL */
> +
> +       /* Write data bit delay: */
> +       {0x021b082c, 0xF3333333},       /* MMDC_MPWRDQBY0DL */
> +       {0x021b0830, 0xF3333333},       /* MMDC_MPWRDQBY1DL */
> +
> +       /* DQS&CLK Duty Cycle */
> +       {0x021b08c0, 0x00944009},       /* [MMDC_MPDCCR] MMDC Duty Cycle =
Control Register */
> +
> +       /* Complete calibration by forced measurement: */
> +       {0x021b08b8, 0x00000800},       /* DDR_PHY_P0_MPMUR0, frc_msr */
>
> -static struct mx6_ddr_sysinfo ddr_sysinfo =3D {
> -       .dsize                  =3D 0,
> -       .cs1_mirror             =3D 0,
> -       .cs_density             =3D 32,
> -       .ncs                    =3D 1,
> -       .bi_on                  =3D 1,
> -       .rtt_nom                =3D 1,
> -       .rtt_wr                 =3D 0,
> -       .ralat                  =3D 5,
> -       .walat                  =3D 1,
> -       .mif3_mode              =3D 3,
> -       .rst_to_cke             =3D 0x23, /* 33 cycles (JEDEC value for D=
DR3) - total of 500 us */
> -       .sde_to_rst             =3D 0x10, /* 14 cycles (JEDEC value for D=
DR3) - total of 200 us */
> -       .refsel                 =3D 1,
> -       .refr                   =3D 3,
> +       /*
> +        * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +        * Calibration setup end
> +        * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +        */
> +
> +       /* MMDC init: */
> +       {0x021b0004, 0x0002002D},       /* MMDC0_MDPDC */
> +       {0x021b0008, 0x1B333030},       /* MMDC0_MDOTC */
> +       {0x021b000c, 0x2B2F52F3},       /* MMDC0_MDCFG0 */
> +       {0x021b0010, 0xB66D0B63},       /* MMDC0_MDCFG1 */
> +       {0x021b0014, 0x01FF00DB},       /* MMDC0_MDCFG2 */
> +
> +       /*
> +        * MDMISC: RALAT kept to the high level of 5.
> +        * MDMISC: consider reducing RALAT if your 528MHz board design al=
low that.
> +        * Lower RALAT benefits:
> +        * a. better operation at low frequency, for LPDDR2 freq < 100MHz=
, change RALAT to 3
> +        * b. Small performance improvement
> +        */
> +       {0x021b0018, 0x00211740},       /* MMDC0_MDMISC */
> +       {0x021b001c, 0x00008000},       /*
> +                                        * MMDC0_MDSCR, set the Configura=
tion request
> +                                        * bit during MMDC set up
> +                                        */
> +       {0x021b002c, 0x000026D2},       /* MMDC0_MDRWD */
> +       {0x021b0030, 0x002F1023},       /* MMDC0_MDOR */
> +       {0x021b0040, 0x00000043},       /* Chan0 CS0_END */
> +       {0x021b0000, 0x82180000},       /* MMDC0_MDCTL */
> +
> +       {0x021b0890, 0x00400000},       /* MPPDCMPR2 */
> +
> +       /* Mode register writes */
> +       {0x021b001c, 0x02808032},       /* MMDC0_MDSCR, MR2 write, CS0 */
> +       {0x021b001c, 0x00008033},       /* MMDC0_MDSCR, MR3 write, CS0 */
> +       {0x021b001c, 0x00048031},       /* MMDC0_MDSCR, MR1 write, CS0 */
> +       {0x021b001c, 0x15208030},       /* MMDC0_MDSCR, MR0write, CS0 */
> +       {0x021b001c, 0x04008040},       /*
> +                                        * MMDC0_MDSCR, ZQ calibration co=
mmand sent to
> +                                        * device on CS0
> +                                        */
> +       {0x021b0020, 0x00007800},       /* MMDC0_MDREF */
> +
> +       {0x021b0818, 0x00000227},       /* DDR_PHY_P0_MPODTCTRL */
> +
> +       {0x021b0004, 0x0002552D},       /* MMDC0_MDPDC now SDCTL power do=
wn enabled */
> +
> +       {0x021b0404, 0x00011006},       /*
> +                                        * MMDC0_MAPSR ADOPT power down e=
nabled,
> +                                        * MMDC will enter automatically =
to self-refresh
> +                                        * while the number of idle cycle=
 reached.
> +                                        */
> +
> +       {0x021b001c, 0x00000000},       /*
> +                                        * MMDC0_MDSCR, clear this regist=
er
> +                                        * (especially the configuration =
bit as initialization
> +                                        * is complete)
> +                                        */
>  };
>
> -static struct mx6_ddr3_cfg mem_ddr =3D {
> -       .mem_speed              =3D 1333,
> -       .density                =3D 2,
> -       .width                  =3D 16,
> -       .banks                  =3D 8,
> -       .rowaddr                =3D 13,
> -       .coladdr                =3D 10,
> -       .pagesz                 =3D 2,
> -       .trcd                   =3D 1350,
> -       .trcmin                 =3D 4950,
> -       .trasmin                =3D 3600,
> +static struct dram_timing_info dram_timing_128mb =3D {
> +       .ddrc_cfg =3D ddr_ddrc_cfg_128mb,
> +       .ddrc_cfg_num =3D ARRAY_SIZE(ddr_ddrc_cfg_128mb),
>  };
>
> +static void ddr_cfg_write(const struct dram_timing_info *dram_timing_inf=
o)
> +{
> +       int i;
> +       const struct dram_cfg_param *ddrc_cfg =3D dram_timing_info->ddrc_=
cfg;
> +       const int ddrc_cfg_num =3D dram_timing_info->ddrc_cfg_num;
> +
> +       for (i =3D 0; i < ddrc_cfg_num; i++) {
> +               debug("Writing 0x%x to register 0x%x\n", ddrc_cfg->val,
> +                     ddrc_cfg->reg);
> +               writel(ddrc_cfg->val, ddrc_cfg->reg);
> +               ddrc_cfg++;
> +       }
> +}
> +
> +static void spl_dram_init(void)
> +{
> +       struct mmdc_p_regs *mmdc0 =3D (struct mmdc_p_regs *)MMDC_P0_BASE_=
ADDR;
> +
> +       clrbits_le32(&mmdc0->mdctl, 1 << 31);   /* clear SDE_0 */
> +       clrbits_le32(&mmdc0->mdctl, 1 << 30);   /* clear SDE_1 */
> +
> +       ddr_cfg_write(&dram_timing_128mb);
> +}
> +
>  static void ccgr_init(void)
>  {
>         struct mxc_ccm_reg *ccm =3D (struct mxc_ccm_reg *)CCM_BASE_ADDR;
> @@ -108,20 +247,17 @@ static void ccgr_init(void)
>         writel(0xFFFFFFFF, &ccm->CCGR6);
>  }
>
> -static void imx6ul_spl_dram_cfg(void)
> -{
> -       mx6ul_dram_iocfg(mem_ddr.width, &mx6_ddr_ioregs, &mx6_grp_ioregs)=
;
> -       mx6_dram_cfg(&ddr_sysinfo, &mx6_mmcd_calib, &mem_ddr);
> -}
> -
>  void board_init_f(ulong dummy)
>  {
>         ccgr_init();
> +
> +       /* DDR initialization */
> +       spl_dram_init();
> +
>         arch_cpu_init();
>         timer_init();
>         setup_iomux_uart();
>         preloader_console_init();
> -       imx6ul_spl_dram_cfg();
>  }
>
>  void reset_cpu(void)
> --
> 2.43.0
>
> base-commit: eeb5ff1a468b2303efa9deb2483b5edbebb568c6
> branch: bsh-202505-RAM



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
