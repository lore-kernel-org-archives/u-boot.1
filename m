Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC146E8FDCA
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 05:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73FB487056;
	Wed,  4 Oct 2023 07:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OOCCE7Ds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D5B87056; Wed,  4 Oct 2023 07:13:52 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF1F786E9F
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 07:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3945DTWb091413;
 Wed, 4 Oct 2023 00:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696396409;
 bh=K92ZqUbR9xLpagcXbSYpoa7or3rgGWH13mFF7FdyWNE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=OOCCE7Dsm/iynyUL+/wCxeMpkGF8O0WG3He+oawxyeChGbQgWkalmicXhZTohcmLE
 SO2/dnC4uUlNS+9jt+UwsHjEVAhttnffIE4XqVlyXrOE7v5rDGrMLHr0SH7Y1CXIb3
 iwc1ZZjIgAF+LjNOdquQ7/5cWKAYVWSq7Uxvervk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3945DTHf023099
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Oct 2023 00:13:29 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 00:13:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 00:13:29 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3945DRNf011174;
 Wed, 4 Oct 2023 00:13:28 -0500
Date: Wed, 4 Oct 2023 10:43:27 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v4 02/16] arm: mach-k3: Add basic support for J784S4 SoC
 definition
Message-ID: <20231004051327.jvatwiwpmdz4lykd@ula0497581>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <20231001165545.494212-3-a-nandan@ti.com>
 <20231002160156.pacy7j53bbtx766e@reboot>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231002160156.pacy7j53bbtx766e@reboot>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Nishanth,

On 11:01-20231002, Nishanth Menon wrote:
> > diff --git a/arch/arm/mach-k3/j784s4_init.c b/arch/arm/mach-k3/j784s4_init.c
[..]
> > +struct fwl_data infra_cbass0_fwls[] = {
> > +	{ "PSC0", 5, 1 },
> > +	{ "PLL_CTRL0", 6, 1 },
> > +	{ "PLL_MMR0", 8, 26 },
> > +	{ "CTRL_MMR0", 9, 16 },
> > +	{ "GPIO0", 16, 1 },
> > +}, wkup_cbass0_fwls[] = {
> > +	{ "WKUP_PSC0", 129, 1 },
> > +	{ "WKUP_PLL_CTRL0", 130, 1 },
> > +	{ "WKUP_CTRL_MMR0", 131, 16 },
> > +	{ "WKUP_GPIO0", 132, 1 },
> > +	{ "WKUP_I2C0", 144, 1 },
> > +	{ "WKUP_USART0", 160, 1 },
> > +}, mcu_cbass0_fwls[] = {
> > +	{ "MCU_R5FSS0_CORE0", 1024, 4 },
> > +	{ "MCU_R5FSS0_CORE0_CFG", 1025, 3 },
> > +	{ "MCU_R5FSS0_CORE1", 1028, 4 },
> > +	{ "MCU_R5FSS0_CORE1_CFG", 1029, 1 },
> > +	{ "MCU_FSS0_CFG", 1032, 12 },
> > +	{ "MCU_FSS0_S1", 1033, 8 },
> > +	{ "MCU_FSS0_S0", 1036, 8 },
> > +	{ "MCU_PSROM49152X32", 1048, 1 },
> > +	{ "MCU_MSRAM128KX64", 1050, 8 },
> > +	{ "MCU_MSRAM128KX64_CFG", 1051, 1 },
> > +	{ "MCU_TIMER0", 1056, 1 },
> > +	{ "MCU_TIMER9", 1065, 1 },
> > +	{ "MCU_USART0", 1120, 1 },
> > +	{ "MCU_I2C0", 1152, 1 },
> > +	{ "MCU_CTRL_MMR0", 1200, 8 },
> > +	{ "MCU_PLL_MMR0", 1201, 3 },
> > +	{ "MCU_CPSW0", 1220, 2 },
> > +}, cbass_rc_cfg0_fwls[] = {
> > +	{ "EMMCSD4SS0_CFG", 2400, 4 },
> > +}, cbass_hc2_fwls[] = {
> > +	{ "PCIE0", 2547, 24 },
> > +}, cbass_hc_cfg0_fwls[] = {
> > +	{ "PCIE0_CFG", 2577, 7 },
> > +	{ "EMMC8SS0_CFG", 2579, 4 },
> > +	{ "USB3SS0_CORE", 2580, 4 },
> > +	{ "USB3SS1_CORE", 2581, 1 },
> > +}, navss_cbass0_fwls[] = {
> > +	{ "NACSS_VIRT0", 6253, 1 },
> > +};

[..]
> > +void board_init_f(ulong dummy)
> > +{
[..]
> > +
> > +		remove_fwl_configs(cbass_hc_cfg0_fwls, ARRAY_SIZE(cbass_hc_cfg0_fwls));
> > +		remove_fwl_configs(cbass_hc2_fwls, ARRAY_SIZE(cbass_hc2_fwls));
> > +		remove_fwl_configs(cbass_rc_cfg0_fwls, ARRAY_SIZE(cbass_rc_cfg0_fwls));
> > +		remove_fwl_configs(infra_cbass0_fwls, ARRAY_SIZE(infra_cbass0_fwls));
> > +		remove_fwl_configs(mcu_cbass0_fwls, ARRAY_SIZE(mcu_cbass0_fwls));
> > +		remove_fwl_configs(wkup_cbass0_fwls, ARRAY_SIZE(wkup_cbass0_fwls));
> > +		remove_fwl_configs(navss_cbass0_fwls, ARRAY_SIZE(navss_cbass0_fwls));
> 
> Why do you need this? firewall configuration was coming in via OIDs in 
> https://lore.kernel.org/all/CAPnjgZ14Uy+gBC8kgqVA7m9NXN_WiXFffu5Ob=vz=E76rMDMPQ@mail.gmail.com/
> 

These are required to remove the firewall configurations that are done
by ROM, those are not the ones that are being handled by OIDs. The
current series that is being worked on is to add additional firewalling
support with OIDs that TIFS will be handling. The above patch is
essentially added to have the same development experience on GP devices
similar to HS after the secure boot is done so that people don't end up
hitting random firewall exceptions that the ROM had configured.

Regards,
Manorit

> 
> > +	}
> > +
[..]
