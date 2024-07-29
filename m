Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA9FC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 05:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B700887BF;
	Mon, 29 Jul 2024 07:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JOo3H+3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85643887C0; Mon, 29 Jul 2024 07:38:30 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 533498875B
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 07:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4281d812d3eso4387675e9.3
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 22:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722231508; x=1722836308; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BV6sv1Sc0js2CXQ1SP5zEzAZOT70i9UlJiSxozGf8vA=;
 b=JOo3H+3CDOp1ZripkenaNcv9q0gBryUH5P2LpXKfAUtvMkjUmYrfOi/G47cptEiNxI
 CEhchmaqA/xJ3NCTBA2Nxr65i0tYw271OuJORamYj6tyTv63DMLlXCJXvg3KTBvjJvk8
 WXQBxRTsdz9GcAwt+mLo45//GEQ0syxlBAgTkyPeUICkwsA/QugpmJLBfGipqtohGAoD
 cKA7ZwtT4BXEFlkBwMYh9Ln/kftcYZbiVego369VPQc8QW12NaZv2EwErj+vupBc+lOe
 UINNvwwVoYSzKFAtZt8NlknYqLTBiLCXvuKET5lagoLhn4CYba/wI1CDuATbMTmB3TcC
 6Zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722231508; x=1722836308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BV6sv1Sc0js2CXQ1SP5zEzAZOT70i9UlJiSxozGf8vA=;
 b=gfXhJPD37QoazK+K8sdfGrogocF81z7TCtCsaCWfjFn5lQga5dTA3SGuG1rGDgWg86
 Pbn6Ob8V2G4hw8J+ZNma9DxIVhEyeOEi2ZGbqX/tadViWT4wRThIfl4SxDRq7NcI0eAb
 EOLU8Oun+FzfBdEKMRSTycBl7Idmb5BX0DlhYSCzJ15BhaEsxZVeOKoorkV+6Hst92x5
 voqvtlfMNl+tUTOE31WPT2YXQIuZkDLp40Qru7R1HIvaYNTwTis4ysJ1gJ9oUN82/RR1
 53fNn+hbrSSIgrqpmlStXHBkdMRLFxv0kPuwRcYXz81fRI/9DnXNI08SZtah/g24h5e4
 XvfA==
X-Gm-Message-State: AOJu0YzIMx7lBO+Z3vBF81E+duI4QRBtbCE5zDEWWozSmF/OPxCoc008
 OCyp1gT0PlOlB5m4f73eQIm71iJmJ3UbFtTcGc+i0IA5WIXUASijEWvaxpCvfY43ILJQAKzR2v0
 AWvtlPvsnkYR/tSD4YDxpsRgnoGA=
X-Google-Smtp-Source: AGHT+IHT44al5r0UdpMklyhSCYH4GPq/eN6Dk/tPMoetdPvEwnxmcMX2xQlgooxAtDe9L5MsG5PnWKT/238DUbKdmAY=
X-Received: by 2002:a5d:6d83:0:b0:368:78d0:c240 with SMTP id
 ffacd0b85a97d-36b5d0929eamr5837222f8f.35.1722231507398; Sun, 28 Jul 2024
 22:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
 <CAPVz0n0C6TPdBRUEvJmgAUGAKoetuzr1j=0cMXweP2EqMTwn=g@mail.gmail.com>
 <0910419d-e8ab-4bf9-a083-dc2783afaca1@denx.de>
 <4D07A6E5-F156-44C3-A26D-0F2D913CE92D@gmail.com>
 <18d84528-d2e5-41d6-ae1d-109ee30853b2@denx.de>
In-Reply-To: <18d84528-d2e5-41d6-ae1d-109ee30853b2@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 29 Jul 2024 08:38:16 +0300
Message-ID: <CAPVz0n2Jzfih0Z85TSQbnz-8OrX4D6UN=anKGTJ=hckRt8f3xA@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 uboot-stm32@st-md-mailman.stormreply.com
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

=D0=BD=D0=B4, 28 =D0=BB=D0=B8=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 23:08 Mare=
k Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 7/28/24 9:02 PM, Svyatoslav wrote:
>
> Hi,
>
> I'm trimming the CC because I keep getting ML blockage due to large CC
> list. If someone has been removed too hastily, sorry.
>
> > 28 =D0=BB=D0=B8=D0=BF=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 21:35:27 GMT+03:=
00, Marek Vasut <marex@denx.de> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(=
-=D0=BB=D0=B0):
> >> On 7/28/24 7:55 PM, Svyatoslav Ryhel wrote:
> >>> =D0=BD=D0=B4, 28 =D0=BB=D0=B8=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 19:3=
8 Marek Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
> >>>>
> >>>> On 6/27/24 1:55 AM, Marek Vasut wrote:
> >>>>> In case a regulator DT node contains regulator-always-on or regulat=
or-boot-on
> >>>>> property, make sure the regulator gets correctly configured by U-Bo=
ot on start
> >>>>> up. Unconditionally probe such regulator drivers. This is a prepara=
tory patch
> >>>>> for introduction of .regulator_post_probe() which would trigger the=
 regulator
> >>>>> configuration.
> >>>>>
> >>>>> Parsing of regulator-always-on and regulator-boot-on DT property ha=
s been
> >>>>> moved to regulator_post_bind() as the information is required early=
, the
> >>>>> rest of the DT parsing has been kept in regulator_pre_probe() to av=
oid
> >>>>> slowing down the boot process.
> >>>>
> >>>> Is there anything blocking this series from being applied ?
> >>>
> >>> This patchset causes PMIC regulators probe too early which results in
> >>> i2c line setup failure. These patches MUST NOT be applied in this for=
m
> >>> since they will break at least 15 Tegra 3 devices which use DM PMIC,
> >>> maybe more.
> >>
> >> Thank you for testing. I do not have any tegra 3 devices, but this pat=
chset does not do anything with pinmuxing. If a regulator is probed, all of=
 its dependencies (i2c bus, pinmux configuration, etc.) should be probed as=
 well. Can you have a look at what the problem with pinmuxing is on tegra 3=
? It seems it might be unrelated to this patchset and would eventually show=
 up elsewhere?
> >
> > Pinmux? Wdym, I wrote about a PMIC which is usually located on i2c line=
.
> >
> > <https://patchwork.ozlabs.org/project/uboot/patch/20231003062126.42026-=
4-clamor95@gmail.com/>
> >
> > This is a similar patch.
> >
> > You may be able to reproduce the issue I face if you have a device whic=
h uses SPL and has DM PMIC with regulators that need always-on/boot-on prop=
erties.
>
> I actually do use:
>
> configs/imx8mp_dhcom_pdk3_defconfig:CONFIG_DM_PMIC=3Dy
> configs/imx8mp_dhcom_pdk3_defconfig:CONFIG_DM_PMIC_PCA9450=3Dy
> configs/imx8mp_dhcom_pdk3_defconfig:CONFIG_SPL_DM_PMIC_PCA9450=3Dy
>
> which is one of the devices I test this on.
>
> The PMIC is on I2C, DM_PMIC enabled in SPL, both buck4 and buck5
> regulators are enabled in SPL, have regulator-always-on and
> regulator-boot-on and bootph-pre-ram properties.
>
> This seems similar enough, right ?
>
Yes, though SPL must remain as small as possible and you propose add
there i2c driver,  PMIC driver, PMIC regulator drivers, PMIC GPIO
drivers along with relocation of all this stuff. It is not optimal at
all.

> What is the problem you observe on tegra 3 ?
i2c line fails since it probes in spl with your patch, but it does not
relocate and then probes once more after relocation. Probe fails along
with all devices on same line.

Even with
CONFIG_SPL_I2C=3Dy
CONFIG_SPL_PMIC_PALMAS=3Dy
CONFIG_SPL_DM_REGULATOR_PALMAS=3Dy
CONFIG_SPL_PALMAS_GPIO=3Dy
and all bootph-pre-ram; set I still get i2c failure

Here is log
(bootloader) read error from device: bd26f8e0 register: 0x37!
(bootloader) read error from device: bd26f8e0 register: 0x3b!
(bootloader) read error from device: bd26f8e0 register: 0x61!
(bootloader) read error from device: bd26f8e0 register: 0x65!
(bootloader) Core:  177 devices, 27 uclasses, devicetree: separate
(bootloader) MMC:   sdhci@78000400: 1, sdhci@78000600: 0
(bootloader) Loading Environment from MMC... Reading from MMC(0)... ***
(bootloader) Warning - bad CRC, using default environment
(bootloader)
(bootloader) read error from device: bd26f8e0 register: 0x53!
(bootloader) read error from device: bd26f8e0 register: 0x2f!
(bootloader) tegra_dsi_bridge_probe: Cannot get panel: error -5
(bootloader) tegra_dsi_bridge_probe: Cannot get panel: error -114
(bootloader) In:    serial,usbkbd,button-kbd
(bootloader) Out:   serial,vidconsole
(bootloader) Err:   serial,vidconsole
(bootloader) Net:   No ethernet found.
