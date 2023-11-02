Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D658CC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 06:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A719F86F5B;
	Thu,  2 Nov 2023 07:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vUPi8H8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A810186F32; Thu,  2 Nov 2023 07:25:17 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0971A86F32
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 07:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A26P5IZ060037;
 Thu, 2 Nov 2023 01:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698906305;
 bh=BqdYDMNS3Cx6XOIsn9nOBv0MqxqC81QEBA2fOBsWGy8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=vUPi8H8xQC03aM5Ik9c7m76ScP81G6BZfvtuY4wfbXNx5YWGVxQ2dZ6fFDAcSldwM
 0f33LUy5qnCv0o4v0+BpKLtUnpy7Qg6mBDUYsbMlWs42yV+KI575yBx+hawL4Jft9t
 ikm2o/YuYDHSh1TZ48zTiiUGnsgfIAxVTN30g9ko=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A26P5JC022263
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 01:25:05 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 01:25:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 01:25:05 -0500
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A26P08B077509;
 Thu, 2 Nov 2023 01:25:01 -0500
Message-ID: <84e2d5ff-1b9c-4149-a9db-2f4c591c3ee0@ti.com>
Date: Thu, 2 Nov 2023 11:55:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] board: ti: Add dependency from TARGET selection to SOC
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>, Le Jin
 <le.jin@siemens.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: <u-boot@lists.denx.de>
References: <20231101203530.80359-1-afd@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231101203530.80359-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Hi Andrew,

On 02/11/23 02:05, Andrew Davis wrote:
> Currently the K3 selection for TARGET boards does not depend on the SoC
> for which it is based. This leds to the odd ability to select for instance
> both SOC_K3_AM625 and TARGET_J721E_A72_EVM.
> 
> To fix this the target choice should depend on the matching SOC config.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   board/siemens/iot2050/Kconfig     | 2 +-
>   board/ti/am62ax/Kconfig           | 1 +
>   board/ti/am62x/Kconfig            | 1 +
>   board/ti/am64x/Kconfig            | 1 +
>   board/ti/am65x/Kconfig            | 1 +
>   board/ti/j721e/Kconfig            | 1 +
>   board/ti/j721s2/Kconfig           | 1 +
>   board/toradex/verdin-am62/Kconfig | 1 +
>   8 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/board/siemens/iot2050/Kconfig b/board/siemens/iot2050/Kconfig
> index a6170aae807..737cda64744 100644
> --- a/board/siemens/iot2050/Kconfig
> +++ b/board/siemens/iot2050/Kconfig
> @@ -8,8 +8,8 @@
>   
>   config TARGET_IOT2050_A53
>   	bool "IOT2050 running on A53"
> +	depends on SOC_K3_AM654
>   	select ARM64
> -	select SOC_K3_AM654
>   	select BOARD_LATE_INIT
>   	select SYS_DISABLE_DCACHE_OPS
>   	select BINMAN
> diff --git a/board/ti/am62ax/Kconfig b/board/ti/am62ax/Kconfig
> index 61f289faccd..30e1a068660 100644
> --- a/board/ti/am62ax/Kconfig
> +++ b/board/ti/am62ax/Kconfig
> @@ -5,6 +5,7 @@
>   
>   choice
>   	prompt "TI K3 AM62Ax based boards"
> +	depends on SOC_K3_AM62A7
>   	optional
>   
>   config TARGET_AM62A7_A53_EVM
> diff --git a/board/ti/am62x/Kconfig b/board/ti/am62x/Kconfig
> index cd17e939e5a..b4b70337d18 100644
> --- a/board/ti/am62x/Kconfig
> +++ b/board/ti/am62x/Kconfig
> @@ -5,6 +5,7 @@
>   
>   choice
>   	prompt "TI K3 AM62x based boards"
> +	depends on SOC_K3_AM625
>   	optional
>   
>   config TARGET_AM625_A53_EVM
> diff --git a/board/ti/am64x/Kconfig b/board/ti/am64x/Kconfig
> index fb596e4adfc..2dbc6197b75 100644
> --- a/board/ti/am64x/Kconfig
> +++ b/board/ti/am64x/Kconfig
> @@ -4,6 +4,7 @@
>   
>   choice
>   	prompt "K3 AM64 based boards"
> +	depends on SOC_K3_AM642
>   	optional
>   
>   config TARGET_AM642_A53_EVM
> diff --git a/board/ti/am65x/Kconfig b/board/ti/am65x/Kconfig
> index 5fd19d652a6..7c1bcfc899c 100644
> --- a/board/ti/am65x/Kconfig
> +++ b/board/ti/am65x/Kconfig
> @@ -5,6 +5,7 @@
>   
>   choice
>   	prompt "K3 AM65 based boards"
> +	depends on SOC_K3_AM654
>   	optional
>   
>   config TARGET_AM654_A53_EVM
> diff --git a/board/ti/j721e/Kconfig b/board/ti/j721e/Kconfig
> index e6cb21f77bd..23867ad8e04 100644
> --- a/board/ti/j721e/Kconfig
> +++ b/board/ti/j721e/Kconfig
> @@ -5,6 +5,7 @@
>   
>   choice
>   	prompt "K3 J721E based boards"
> +	depends on SOC_K3_J721E
>   	optional
>   
>   config TARGET_J721E_A72_EVM
> diff --git a/board/ti/j721s2/Kconfig b/board/ti/j721s2/Kconfig
> index f6d1cb57653..a4a5d16ba21 100644
> --- a/board/ti/j721s2/Kconfig
> +++ b/board/ti/j721s2/Kconfig
> @@ -5,6 +5,7 @@
>   
>   choice
>   	prompt "K3 J721S2 board"
> +	depends on SOC_K3_J721S2
>   	optional
>   
>   config TARGET_J721S2_A72_EVM
> diff --git a/board/toradex/verdin-am62/Kconfig b/board/toradex/verdin-am62/Kconfig
> index e7522244070..abc2984f250 100644
> --- a/board/toradex/verdin-am62/Kconfig
> +++ b/board/toradex/verdin-am62/Kconfig
> @@ -5,6 +5,7 @@
>   
>   choice
>   	prompt "Toradex Verdin AM62 based boards"
> +	depends on SOC_K3_AM625
>   	optional
>   
>   config TARGET_VERDIN_AM62_A53

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
