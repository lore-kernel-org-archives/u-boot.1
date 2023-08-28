Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F62C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 16:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A46864BA;
	Mon, 28 Aug 2023 18:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WdViYON9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2802805C9; Mon, 28 Aug 2023 18:41:05 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBFF8864F2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 18:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SGf0NZ068771;
 Mon, 28 Aug 2023 11:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693240860;
 bh=WEXrBsCucLPgDz2Cw42+oqZABUFSHwbdLvcoQACFacE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WdViYON90ajJWtBR2WBITeibpqTsHOtPmbyjgzEaHerRocpmVZ2ARo0ZQdQihWUaz
 bn79+eIyFJNJoMyoNZdymWJIlNz0H1yHx+6gJTrTX58i0loX48NPJtMMmBXCifMSEJ
 xbu9sIPkMM6GDaSnaV5Nyikdxy6NsI/0e9DBJ4fU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SGf0QM051161
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 11:41:00 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 11:41:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 11:41:00 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SGf0E6009896;
 Mon, 28 Aug 2023 11:41:00 -0500
Date: Mon, 28 Aug 2023 11:41:00 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>,
 Andrew Davis <afd@ti.com>, Nikhil M Jain <n-jain1@ti.com>
Subject: Re: [PATCH v2 1/6] configs: j721s2_evm_r5_defconfig: Increase malloc
 pool size in DRAM
Message-ID: <20230828164100.4ikllm2oqbc7ebae@estate>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v2-1-a5f141be40bc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-1-a5f141be40bc@ti.com>
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

On 16:46-20230825, Manorit Chawdhry wrote:
> From: Udit Kumar <u-kumar1@ti.com>
> 
> The malloc capacity in DRAM at R5 SPL is set to 1MB which isn't
> sufficient to load the new tispl.bin to
> enable loading of tispl.bin the size is increased by 256KB to 1.25MB.
> 
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  configs/j721s2_evm_r5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
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

Though this makes me curious who AM62x did'nt need this.. but anyways..


Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
