Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF19EE92725
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 18:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5077D86BDB;
	Thu,  5 Oct 2023 20:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PCUJpTX3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B8186CC9; Thu,  5 Oct 2023 20:30:35 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 348408692B
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 20:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395IUTjv103086;
 Thu, 5 Oct 2023 13:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696530629;
 bh=TA2RZlCyLeI3fdAA4rfEx7wFTIk4v8SpNxyQuhndIxE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=PCUJpTX3deweInx5OoDuqU8UqPskGB9d2nfuATbbdVaB/1NBGo+UxWO+TqXMvOnPQ
 lAeuuKmO/aHSbsiiCrFEBbeWcJjdakCCT12i8i97E0pwT7ILS2Y/ZLJcm/mscnWmb+
 57Ppy9e4FUmJCTexNc0ABuEivODg3i21xUs2b9y0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395IUTEo026122
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 13:30:29 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 13:30:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 13:30:29 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395IUTnj019945;
 Thu, 5 Oct 2023 13:30:29 -0500
Date: Thu, 5 Oct 2023 13:30:29 -0500
From: Nishanth Menon <nm@ti.com>
To: Reid Tonking <reidt@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [PATCH v5 2/2] arm: dts: j7200: dts sync with Linux 6.6-rc1
Message-ID: <20231005183029.2zlrs2e2rm4s2zys@vitality>
References: <20231005181258.1004539-1-reidt@ti.com>
 <20231005181258.1004539-3-reidt@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231005181258.1004539-3-reidt@ti.com>
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

On 13:12-20231005, Reid Tonking wrote:
> Sync j7200 dts with Linux 6.6-rc1
> 
> - k3-j7200-r5-common-proc-board.dts now inherits from
>   k3-j7200-common-proc-board.dts instead of k3-j7200-som-p0.dtsi. This
>   allows us to trim down the r5 file considerably by using existing
>   properties
> 
> - remove pimux nodes from r5 file
> 
> - remove duplicate nodes & node properties from r5/u-boot files
> 
> - mcu_timer0 now used instead of timer1
> 
>   mcu_timer0 device id added to dev-data.c file in order to work
> 
> - remove cpsw node
> 
>   This node is no longer required since the compatible is now fixed
> 
> - remove dummy_clock_19_2_mhz
> 
>   This node wasn't being used anyhere, so it was removed
> 
> - remove dummy_clock_200mhz
> 
>   main_sdhci0 & main_sdhci1 no longer need dummy clock for eMMC/SD
> 
> - fix secure proxy node
> 
>   mcu_secproxy changed to used secure_prxy_mcu which is already
>   defined in k3-j7200-mcu-wakeup.dtsi
> 
> - removed &mcu_ringacc property override since they're present in
>   v6.6-rc1
> 
> Signed-off-by: Reid Tonking <reidt@ti.com>

Reviewed-by: Nishanth Menon <nm@ti.com>
[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
