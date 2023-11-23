Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904CAC5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 04:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8237687600;
	Thu, 23 Nov 2023 05:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tm5Vh5pf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E525587600; Thu, 23 Nov 2023 05:24:48 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F1E875AF
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 05:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4OghP077778;
 Wed, 22 Nov 2023 22:24:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700713482;
 bh=lzOOXzXKkSwgES1iSOCGu774s3tNIqpJyBgyQ9ZOUgM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=tm5Vh5pf5nm2IhRMLBEEQ1Ftq5y5TAiDbSFdAVeWF/isQPee64l1xWiRwDV5z2IwF
 gt/F4ER0Erudt4wV6fEERZlhVI9a6N5sMyhrUYQ78uhKtpPjKxisqOkxTetAsVyDMh
 j23lPyUPtk7vrMZKg9MJPaToCV6XNlxXakECrQOw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AN4OgIK003387
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Nov 2023 22:24:42 -0600
Received: from flwvowa02.ent.ti.com (10.64.41.53) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 22:24:41 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by flwvowa02.ent.ti.com
 (10.64.41.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 22:24:41 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 22:24:41 -0600
Received: from [172.24.227.36] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4Odr9070851;
 Wed, 22 Nov 2023 22:24:40 -0600
Message-ID: <74dd3f8b-4e2b-4a38-bf75-ec827b82ef95@ti.com>
Date: Thu, 23 Nov 2023 09:54:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] ufs: Correct the UFS terminlogy
To: Bin Meng <bmeng@tinylab.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-2-bmeng@tinylab.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231011131552.14665-2-bmeng@tinylab.org>
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

Hi Bin,

On 11/10/23 18:45, Bin Meng wrote:
> UFS stands for Universal Flash Storage, not Subsytem.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
> 
> (no changes since v1)
> 
>   cmd/Kconfig              | 2 +-
>   drivers/ufs/ufs-uclass.c | 2 +-
>   drivers/ufs/ufs.c        | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 6470b138d2..a59c67e333 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1536,7 +1536,7 @@ config CMD_TSI148
>   	  Turndra tsi148 device. See the command help for full details.
>   
>   config CMD_UFS
> -	bool "Enable UFS - Universal Flash Subsystem commands"
> +	bool "Enable UFS - Universal Flash Storage commands"
>   	depends on UFS
>   	help
>   	  "This provides commands to initialise and configure universal flash
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index ceea30c4a9..ffae811d46 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /**
> - * ufs-uclass.c - Universal Flash Subsystem (UFS) Uclass driver
> + * ufs-uclass.c - Universal Flash Storage (UFS) Uclass driver
>    *
>    * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
>    */
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 7c48d57f99..f534d6e29f 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /**
> - * ufs.c - Universal Flash Subsystem (UFS) driver
> + * ufs.c - Universal Flash Storage (UFS) driver
>    *
>    * Taken from Linux Kernel v5.2 (drivers/scsi/ufs/ufshcd.c) and ported
>    * to u-boot.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
