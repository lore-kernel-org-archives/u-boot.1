Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F33E92FE4
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 05:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D0F886A51;
	Fri,  6 Oct 2023 07:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BWPhGb94";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7DED86B42; Fri,  6 Oct 2023 07:25:52 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5E7C86A2B
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 07:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=n-jain1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3965Pklc004574;
 Fri, 6 Oct 2023 00:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696569947;
 bh=v+Gcoo5SSfkUsWI0oEZI3cuHuUc4C7eO8S3eXfrKoBs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=BWPhGb94oThpVJ51I+2uUx30eVyGr77I/CArNod2ygcPprqAROP9+u6DkMeRaK9A4
 3RobtCFLKvvcdTCWytkXx2V5Imx5fp25XEGpBQc9nVmhNcTrhl6UArLGLWdlG4+gn8
 WEjoDT/Bk7wA3SPLTH88m3dc+tzqT4Lav4vbRzWY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3965PkxN062385
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 6 Oct 2023 00:25:46 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Oct 2023 00:25:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Oct 2023 00:25:46 -0500
Received: from [172.24.227.70] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3965Pgkp107478;
 Fri, 6 Oct 2023 00:25:43 -0500
Message-ID: <f3e4eb39-acff-4cc4-88b0-c1263091936d@ti.com>
Date: Fri, 6 Oct 2023 10:55:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] configs: j721s2_evm_r5_defconfig: Increase malloc
 pool size in DRAM
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
References: <20231006-b4-upstream-j721s2-r5-pinmux-v7-0-5d31f765dd2c@ti.com>
 <20231006-b4-upstream-j721s2-r5-pinmux-v7-1-5d31f765dd2c@ti.com>
Content-Language: en-US
From: Nikhil Jain <n-jain1@ti.com>
In-Reply-To: <20231006-b4-upstream-j721s2-r5-pinmux-v7-1-5d31f765dd2c@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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


On 06/10/23 10:15, Manorit Chawdhry wrote:
> From: Udit Kumar <u-kumar1@ti.com>
>
> The malloc capacity in DRAM at R5 SPL is set to 1MB which isn't
> sufficient to load the new tispl.bin to
> enable loading of tispl.bin the size is increased by 256KB to 1.25MB.
>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  configs/j721s2_evm_r5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
Reviewed-by: Nikhil M Jain <n-jain1@ti.com>
> diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
> index 1e66ac23d05b..e2b83b337809 100644
> --- a/configs/j721s2_evm_r5_defconfig
> +++ b/configs/j721s2_evm_r5_defconfig
> @@ -42,6 +42,7 @@ CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
>  CONFIG_SPL_BOARD_INIT=y
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>  CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x140000
>  CONFIG_SPL_SEPARATE_BSS=y
>  CONFIG_SYS_SPL_MALLOC=y
>  CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
>
