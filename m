Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FD6CFB442
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 06:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F01B688D1A;
	Mon,  7 Oct 2024 08:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uL9fjkTE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD9E88D1A; Mon,  7 Oct 2024 08:05:30 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D13587B77
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 08:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49765QtS071217;
 Mon, 7 Oct 2024 01:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728281126;
 bh=ttl8Odse0lCCzU0c1sc83nmrOfTH4O4lll+fMV/2yIU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=uL9fjkTEkAJ2hm1FQkl/Ji9bUbFKpV+eVO7AM23txEmMEmwGifLS+K0+UqlJPC4qH
 SBmACupCrHArQWabKA0x3RNlw2JDXSVwCYHCHrmDGOxHobHEQJtcGgJQcvkgEYdsGR
 VRy7+cNFqHCbTTpFsJ/rhZ6laM7vXQRly+je1aPs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49765Q5q028688
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Oct 2024 01:05:26 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 01:05:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 01:05:25 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49765Oql071656;
 Mon, 7 Oct 2024 01:05:25 -0500
Date: Mon, 7 Oct 2024 11:35:24 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>
Subject: Re: [PATCH v4 7/7] configs: j721s2_evm_r5_defconfig: Add AVS Configs
Message-ID: <20241007060524.gpmik3rsitjqehbe@uda0497581>
References: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
 <20241004-b4-upstream-j721s2-avs-v4-7-6d71c6bab9f4@ti.com>
 <20241004113047.byyl7ms7yr7hkq72@footgear>
 <20241007060412.zxl6pluad4bs2mu6@uda0497581>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007060412.zxl6pluad4bs2mu6@uda0497581>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 11:34-20241007, Manorit Chawdhry wrote:
> Hi Nishanth,
> 
> On 06:30-20241004, Nishanth Menon wrote:
> > On 11:54-20241004, Manorit Chawdhry wrote:
> > > Add AVS and PMIC regulator configs
> > > 
> > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > > ---
> > >  configs/am68_sk_r5_defconfig    | 4 ++++
> > >  configs/j721s2_evm_r5_defconfig | 6 ++++++
> > >  2 files changed, 10 insertions(+)
> > > 
> > > diff --git a/configs/am68_sk_r5_defconfig b/configs/am68_sk_r5_defconfig
> > > index e9b6882c1f68..f4800ef1b8ac 100644
> > > --- a/configs/am68_sk_r5_defconfig
> > > +++ b/configs/am68_sk_r5_defconfig
> > > @@ -5,6 +5,10 @@ CONFIG_ARCH_K3=y
> > >  CONFIG_SOC_K3_J721S2=y
> > >  CONFIG_TARGET_J721S2_R5_EVM=y
> > >  
> > > +CONFIG_K3_AVS0=n
> > > +CONFIG_DM_REGULATOR_TPS65941=n
> > > +CONFIG_PMIC_TPS65941=n
> > > +
> > >  CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-r5-base-board"
> > >  CONFIG_SPL_OF_LIST="k3-am68-sk-r5-base-board"
> > >  CONFIG_OF_LIST="k3-am68-sk-r5-base-board"
> > > diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
> > > index b6adb6a77d7e..ad7653c8f99b 100644
> > > --- a/configs/j721s2_evm_r5_defconfig
> > > +++ b/configs/j721s2_evm_r5_defconfig
> > > @@ -112,6 +112,7 @@ CONFIG_DM_MAILBOX=y
> > >  CONFIG_K3_SEC_PROXY=y
> > >  CONFIG_FS_LOADER=y
> > >  CONFIG_SPL_FS_LOADER=y
> > > +CONFIG_K3_AVS0=y
> > >  CONFIG_SUPPORT_EMMC_BOOT=y
> > >  CONFIG_SPL_MMC_HS400_SUPPORT=y
> > >  CONFIG_MMC_SDHCI=y
> > > @@ -141,6 +142,11 @@ CONFIG_SPL_PINCTRL=y
> > >  CONFIG_PINCTRL_SINGLE=y
> > >  CONFIG_POWER_DOMAIN=y
> > >  CONFIG_TI_POWER_DOMAIN=y
> > > +CONFIG_DM_PMIC=y
> > > +CONFIG_PMIC_TPS65941=y
> > > +CONFIG_DM_REGULATOR=y
> > > +CONFIG_SPL_DM_REGULATOR=y
> > > +CONFIG_DM_REGULATOR_TPS65941=y
> > >  CONFIG_K3_SYSTEM_CONTROLLER=y
> > >  CONFIG_REMOTEPROC_TI_K3_ARM64=y
> > >  CONFIG_RESET_TI_SCI=y
> > 
> > 
> > Why are we mixing two different boards?
> > 
> 
> AM68 includes J721s2 defconfig for re-usability so if some board related
> feature is being enabled on J721s2, that needs to be taken care that it
> doesn't get enabled on AM68 if it doesn't support.

Board related in the sense that AVS requires PMIC support but that isn't
available yet so can't add the support for the same.

Regards,
Manorit

> 
> Regards, 
> Manorit
> 
> > -- 
> > Regards,
> > Nishanth Menon
> > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
