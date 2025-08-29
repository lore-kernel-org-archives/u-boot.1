Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DEFCA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4064C837A7;
	Fri, 29 Aug 2025 16:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KDxt9FLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03682836F0; Fri, 29 Aug 2025 16:32:07 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D41448367F
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 16:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57TEW1i82262230;
 Fri, 29 Aug 2025 09:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756477921;
 bh=s71sf6/5/Rgap/YZKeo3ZibYyH2ORvZF5Ju5M2W0oLM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KDxt9FLBxlpAKLzkqlekHkSmMNxggrk7tooK5WclaSfdPe0cQ3UyeTy/ltIRHciSI
 6SR7BqKRuotXZsQQ0KcI96EZMjfwWdpQb8sZXKMbVA+Man/s0R2dBmKM3rXvz6drzk
 66aAQSLZg37AIBufTEnchvGZpLDiklua/rp4fnhY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57TEW1cK613028
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 29 Aug 2025 09:32:01 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 09:32:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 09:32:01 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57TEW04t2485866;
 Fri, 29 Aug 2025 09:32:00 -0500
Message-ID: <2937fb1b-1f40-4edc-af4a-e02946b5bf8f@ti.com>
Date: Fri, 29 Aug 2025 09:32:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Revert "remoteproc: Tighten some remoteproc driver
 dependencies"
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250829053451.3615976-1-b-padhi@ti.com>
 <20250829053451.3615976-2-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250829053451.3615976-2-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 8/29/25 12:34 AM, Beleswar Padhi wrote:
> This reverts commit 548ae9d1a537464254afac63f802179a24c645d6.
> 
> The IPU remote processor is only present in TI OMAP SoCs. Remove the
> ARCH_K3 dependency from Kconfig. This driver builds just fine without
> ARCH_K3 config.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   drivers/remoteproc/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index e9f19a69433..a3ecea05e20 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -125,7 +125,6 @@ config REMOTEPROC_TI_PRU
>   config REMOTEPROC_TI_IPU
>   	bool "Support for TI's K3 based IPU remoteproc driver"
>   	select REMOTEPROC
> -	depends on ARCH_K3

The original commit seems to indicate there are some platforms
were this does not build, maybe depend on ARCH_OMAP2PLUS

Andrew

>   	depends on DM
>   	depends on SPL_DRIVERS_MISC
>   	depends on SPL_FS_LOADER

