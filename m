Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EF9CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 06:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8029B88D15;
	Mon,  7 Oct 2024 08:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ILz53pKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BBE688D54; Mon,  7 Oct 2024 08:04:18 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BF0187B77
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 08:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49764EvY099596;
 Mon, 7 Oct 2024 01:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728281054;
 bh=MmDU/MbDtHjzmmbMLjpTAa7Y7KkFkGf1BGXZ97PMMSw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ILz53pKUXYgDzOhonfPC0wkJQKowYa4b31hwD3TqOCqekqcWYEEdUm1SfmWjF29Y/
 R/PJneThmQPuJSMAyBGT3U+bmkXh2imWDAzTAVYFFxjeGayoa//+1Hmu2nSVANYeeP
 PVxy2qcW6c1nP1owIMfP4J3QnY+qYf7Hr73kbIqE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49764EPi066814;
 Mon, 7 Oct 2024 01:04:14 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 01:04:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 01:04:13 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49764DeO070113;
 Mon, 7 Oct 2024 01:04:13 -0500
Date: Mon, 7 Oct 2024 11:34:12 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>
Subject: Re: [PATCH v4 7/7] configs: j721s2_evm_r5_defconfig: Add AVS Configs
Message-ID: <20241007060412.zxl6pluad4bs2mu6@uda0497581>
References: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
 <20241004-b4-upstream-j721s2-avs-v4-7-6d71c6bab9f4@ti.com>
 <20241004113047.byyl7ms7yr7hkq72@footgear>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241004113047.byyl7ms7yr7hkq72@footgear>
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

Hi Nishanth,

On 06:30-20241004, Nishanth Menon wrote:
> On 11:54-20241004, Manorit Chawdhry wrote:
> > Add AVS and PMIC regulator configs
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >  configs/am68_sk_r5_defconfig    | 4 ++++
> >  configs/j721s2_evm_r5_defconfig | 6 ++++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/configs/am68_sk_r5_defconfig b/configs/am68_sk_r5_defconfig
> > index e9b6882c1f68..f4800ef1b8ac 100644
> > --- a/configs/am68_sk_r5_defconfig
> > +++ b/configs/am68_sk_r5_defconfig
> > @@ -5,6 +5,10 @@ CONFIG_ARCH_K3=y
> >  CONFIG_SOC_K3_J721S2=y
> >  CONFIG_TARGET_J721S2_R5_EVM=y
> >  
> > +CONFIG_K3_AVS0=n
> > +CONFIG_DM_REGULATOR_TPS65941=n
> > +CONFIG_PMIC_TPS65941=n
> > +
> >  CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-r5-base-board"
> >  CONFIG_SPL_OF_LIST="k3-am68-sk-r5-base-board"
> >  CONFIG_OF_LIST="k3-am68-sk-r5-base-board"
> > diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
> > index b6adb6a77d7e..ad7653c8f99b 100644
> > --- a/configs/j721s2_evm_r5_defconfig
> > +++ b/configs/j721s2_evm_r5_defconfig
> > @@ -112,6 +112,7 @@ CONFIG_DM_MAILBOX=y
> >  CONFIG_K3_SEC_PROXY=y
> >  CONFIG_FS_LOADER=y
> >  CONFIG_SPL_FS_LOADER=y
> > +CONFIG_K3_AVS0=y
> >  CONFIG_SUPPORT_EMMC_BOOT=y
> >  CONFIG_SPL_MMC_HS400_SUPPORT=y
> >  CONFIG_MMC_SDHCI=y
> > @@ -141,6 +142,11 @@ CONFIG_SPL_PINCTRL=y
> >  CONFIG_PINCTRL_SINGLE=y
> >  CONFIG_POWER_DOMAIN=y
> >  CONFIG_TI_POWER_DOMAIN=y
> > +CONFIG_DM_PMIC=y
> > +CONFIG_PMIC_TPS65941=y
> > +CONFIG_DM_REGULATOR=y
> > +CONFIG_SPL_DM_REGULATOR=y
> > +CONFIG_DM_REGULATOR_TPS65941=y
> >  CONFIG_K3_SYSTEM_CONTROLLER=y
> >  CONFIG_REMOTEPROC_TI_K3_ARM64=y
> >  CONFIG_RESET_TI_SCI=y
> 
> 
> Why are we mixing two different boards?
> 

AM68 includes J721s2 defconfig for re-usability so if some board related
feature is being enabled on J721s2, that needs to be taken care that it
doesn't get enabled on AM68 if it doesn't support.

Regards, 
Manorit

> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
