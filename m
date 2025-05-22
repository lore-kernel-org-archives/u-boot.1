Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD39C54EDA
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 07:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C12482FC8;
	Thu, 22 May 2025 09:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="utjDHytv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD6C883010; Thu, 22 May 2025 09:54:57 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95D8A82F67
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 09:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54M7ssFZ1742917;
 Thu, 22 May 2025 02:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747900494;
 bh=Rt8M1KOwqN90wpNwufzLgRBhAk5ZYNlFDGyQhoin6Xw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=utjDHytvsOQV27TOdjEMrFTxfl7JN5RKkKWqEc34TNLLEjMeDPbvPlWZBcXdtKbG1
 Mw+hLGbiZbi3xMNJoMN2NyqJT5MqajLhEGlw+VBj0BkGibHq4qfxg0+0rlAwQwtmCP
 TBgMHPi/RdIlUr9eWbymOo0vlulOjMOXmZmkBcDU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54M7ssNC1306985
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 22 May 2025 02:54:54 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 May 2025 02:54:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 May 2025 02:54:53 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54M7soZZ114157;
 Thu, 22 May 2025 02:54:51 -0500
Message-ID: <17079bac-2f5a-4d04-bbd9-1127c66729f9@ti.com>
Date: Thu, 22 May 2025 13:24:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] board: ti: j7*: Add firmware for MCU R5 core1
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>, <u-boot@lists.denx.de>
References: <20250522071828.285462-1-b-padhi@ti.com>
 <20250522071828.285462-5-b-padhi@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250522071828.285462-5-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

On 22/05/25 12:48, Beleswar Padhi wrote:
> Link the default firmware in the environment variable for MCU R5 core1
> for all J7 platforms.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>  board/ti/j7200/j7200.env   | 2 +-
>  board/ti/j721e/j721e.env   | 2 +-
>  board/ti/j721s2/j721s2.env | 2 +-
>  board/ti/j784s4/j784s4.env | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/board/ti/j7200/j7200.env b/board/ti/j7200/j7200.env
> index 6cc92bf0d8d..292fc72fd58 100644
> --- a/board/ti/j7200/j7200.env
> +++ b/board/ti/j7200/j7200.env
> @@ -36,5 +36,5 @@ main_cpsw0_qsgmii_phyinit=
>  #endif
>  
>  #if CONFIG_TARGET_J7200_A72_EVM
> -rproc_fw_binaries=2 /lib/firmware/j7200-main-r5f0_0-fw 3 /lib/firmware/j7200-main-r5f0_1-fw
> +rproc_fw_binaries= 1 /lib/firmware/j7200-mcu-r5f0_1-fw 2 /lib/firmware/j7200-main-r5f0_0-fw 3 /lib/firmware/j7200-main-r5f0_1-fw
>  #endif
> diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
> index e5b4225b3ce..ead7fbdb212 100644
> --- a/board/ti/j721e/j721e.env
> +++ b/board/ti/j721e/j721e.env
> @@ -38,5 +38,5 @@ main_cpsw0_qsgmii_phyinit=
>  #endif
>  
>  #if CONFIG_TARGET_J721E_A72_EVM
> -rproc_fw_binaries=2 /lib/firmware/j7-main-r5f0_0-fw 3 /lib/firmware/j7-main-r5f0_1-fw 4 /lib/firmware/j7-main-r5f1_0-fw 5 /lib/firmware/j7-main-r5f1_1-fw 6 /lib/firmware/j7-c66_0-fw 7 /lib/firmware/j7-c66_1-fw 8 /lib/firmware/j7-c71_0-fw
> +rproc_fw_binaries= 1 /lib/firmware/j7-mcu-r5f0_1-fw 2 /lib/firmware/j7-main-r5f0_0-fw 3 /lib/firmware/j7-main-r5f0_1-fw 4 /lib/firmware/j7-main-r5f1_0-fw 5 /lib/firmware/j7-main-r5f1_1-fw 6 /lib/firmware/j7-c66_0-fw 7 /lib/firmware/j7-c66_1-fw 8 /lib/firmware/j7-c71_0-fw
>  #endif
> diff --git a/board/ti/j721s2/j721s2.env b/board/ti/j721s2/j721s2.env
> index a6b22550809..abd4faea6ee 100644
> --- a/board/ti/j721s2/j721s2.env
> +++ b/board/ti/j721s2/j721s2.env
> @@ -24,6 +24,6 @@ name_mcur5f0_0fw=/lib/firmware/j7-mcu-r5f0_0-fw
>  #endif
>  rd_spec=-
>  
> -rproc_fw_binaries= 2 /lib/firmware/j721s2-main-r5f0_0-fw 3 /lib/firmware/j721s2-main-r5f0_1-fw 4 /lib/firmware/j721s2-main-r5f1_0-fw 5 /lib/firmware/j721s2-main-r5f1_1-fw 6 /lib/firmware/j721s2-c71_0-fw 7 /lib/firmware/j721s2-c71_1-fw
> +rproc_fw_binaries= 1 /lib/firmware/j721s2-mcu-r5f0_1-fw 2 /lib/firmware/j721s2-main-r5f0_0-fw 3 /lib/firmware/j721s2-main-r5f0_1-fw 4 /lib/firmware/j721s2-main-r5f1_0-fw 5 /lib/firmware/j721s2-main-r5f1_1-fw 6 /lib/firmware/j721s2-c71_0-fw 7 /lib/firmware/j721s2-c71_1-fw
>  
>  
> diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
> index 9e1741be424..2f1a5f549d1 100644
> --- a/board/ti/j784s4/j784s4.env
> +++ b/board/ti/j784s4/j784s4.env
> @@ -21,7 +21,7 @@ bootdir=/boot
>  rd_spec=-
>  
>  #if CONFIG_TARGET_J784S4_A72_EVM
> -rproc_fw_binaries= 2 /lib/firmware/j784s4-main-r5f0_0-fw 3 /lib/firmware/j784s4-main-r5f0_1-fw 4 /lib/firmware/j784s4-main-r5f1_0-fw 5 /lib/firmware/j784s4-main-r5f1_1-fw 6 /lib/firmware/j784s4-main-r5f2_0-fw 7 /lib/firmware/j784s4-main-r5f2_1-fw 8 /lib/firmware/j784s4-c71_0-fw 9 /lib/firmware/j784s4-c71_1-fw 10 /lib/firmware/j784s4-c71_2-fw 11 /lib/firmware/j784s4-c71_3-fw
> +rproc_fw_binaries= 1 /lib/firmware/j784s4-mcu-r5f0_1-fw 2 /lib/firmware/j784s4-main-r5f0_0-fw 3 /lib/firmware/j784s4-main-r5f0_1-fw 4 /lib/firmware/j784s4-main-r5f1_0-fw 5 /lib/firmware/j784s4-main-r5f1_1-fw 6 /lib/firmware/j784s4-main-r5f2_0-fw 7 /lib/firmware/j784s4-main-r5f2_1-fw 8 /lib/firmware/j784s4-c71_0-fw 9 /lib/firmware/j784s4-c71_1-fw 10 /lib/firmware/j784s4-c71_2-fw 11 /lib/firmware/j784s4-c71_3-fw
>  #elif CONFIG_TARGET_J742S2_A72_EVM
> -rproc_fw_binaries= 2 /lib/firmware/j742s2-main-r5f0_0-fw 3 /lib/firmware/j742s2-main-r5f0_1-fw 4 /lib/firmware/j742s2-main-r5f1_0-fw 5 /lib/firmware/j742s2-main-r5f1_1-fw 6 /lib/firmware/j742s2-main-r5f2_0-fw 7 /lib/firmware/j742s2-main-r5f2_1-fw 8 /lib/firmware/j742s2-c71_0-fw 9 /lib/firmware/j742s2-c71_1-fw 10 /lib/firmware/j742s2-c71_2-fw
> +rproc_fw_binaries= 1 /lib/firmware/j742s2-mcu-r5f0_1-fw 2 /lib/firmware/j742s2-main-r5f0_0-fw 3 /lib/firmware/j742s2-main-r5f0_1-fw 4 /lib/firmware/j742s2-main-r5f1_0-fw 5 /lib/firmware/j742s2-main-r5f1_1-fw 6 /lib/firmware/j742s2-main-r5f2_0-fw 7 /lib/firmware/j742s2-main-r5f2_1-fw 8 /lib/firmware/j742s2-c71_0-fw 9 /lib/firmware/j742s2-c71_1-fw 10 /lib/firmware/j742s2-c71_2-fw
>  #endif

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
