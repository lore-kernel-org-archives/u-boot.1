Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81387C369BD
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 13:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5C718298E;
	Sat, 19 Apr 2025 15:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a+RRWZwL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2473829F5; Sat, 19 Apr 2025 15:16:11 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F2A82977
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 15:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53JDG4iv1204589
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Apr 2025 08:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745068564;
 bh=qgn3htALVfFmuTMaxptWY25xYoEs5ILFtS9Zm+fyo6U=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=a+RRWZwLkS3zxgpHUO6zAxV3a4CP2yZs+VjPuU70Yc/P1rkcBRsqblQrmautaVzWM
 rKLjOVFYGhQiBQjMDUplvdBoL+LZLwXwveKpWm+sS5R7B3jxYUvJczy62z59g1H0mQ
 1OEUO3FEccIjsFfMzKtZVCqvdZUQFN2sulJ7wPGM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53JDG3XF090330
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 19 Apr 2025 08:16:04 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 19
 Apr 2025 08:16:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 19 Apr 2025 08:16:03 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53JDFxbn037157;
 Sat, 19 Apr 2025 08:16:00 -0500
Message-ID: <cb2e9c5a-e0c3-4078-8a85-f7de24de23cf@ti.com>
Date: Sat, 19 Apr 2025 18:45:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/9] beagle: beagley-ai: env: Enable DFU env options
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20250418193943.953952-1-nm@ti.com>
 <20250418193943.953952-6-nm@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250418193943.953952-6-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Nishanth

On 4/19/2025 1:09 AM, Nishanth Menon wrote:
> We just have sd/mmc, so set things up for the same
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes Since v1:
> - None
>
> V1: https://lore.kernel.org/r/20250411225717.3117370-6-nm@ti.com
>
>   board/beagle/beagley-ai/beagley-ai.env | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/board/beagle/beagley-ai/beagley-ai.env b/board/beagle/beagley-ai/beagley-ai.env
> index 16a03acfca3c..26f12c8814cc 100644
> --- a/board/beagle/beagley-ai/beagley-ai.env
> +++ b/board/beagle/beagley-ai/beagley-ai.env
> @@ -1,5 +1,6 @@
>   #include <env/ti/ti_common.env>
>   #include <env/ti/mmc.env>
> +#include <env/ti/k3_dfu.env>
>   
>   #if CONFIG_CMD_REMOTEPROC
>   #include <env/ti/k3_rproc.env>
> @@ -20,5 +21,6 @@ mmcdev=1
>   bootpart=1:2
>   bootdir=/boot
>   rd_spec=-
> +dfu_alt_info=${dfu_alt_info_mmc}

IMO  dfu_alt_info_ram could be another valid target for DFU ,

Other platform, set this dfu_alt_info variable before using,

Can we consider this as similar to other platforms ?


>   
>   rproc_fw_binaries= 0 /lib/firmware/j722s-mcu-r5f0_0-fw 2 /lib/firmware/j722s-main-r5f0_0-fw 3 /lib/firmware/j722s-c71_0-fw 4 /lib/firmware/j722s-c71_1-fw
