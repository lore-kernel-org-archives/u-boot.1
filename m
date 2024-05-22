Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FE8C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 08:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93EFC88476;
	Wed, 22 May 2024 10:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="iXPpl7fr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EFF8857E; Wed, 22 May 2024 10:38:41 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F184588473
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 10:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716367119; x=1718959119;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ft7Qp7GedcNd3bNPR7R03BmPZrCwIK3nkB+5znbZkUE=;
 b=iXPpl7frSGEIn1Vhg4dV1hn8QNyEkk6WUkLlcS6VmfIhVPxBdVc3O8zGrbFS8s3K
 yQQHwHzSwqeqgKv1L1mx07gB2minIE3dJhCLiyjgxUMPWgXXsYkvyOjfrJ6NO7LK
 jAM1/2q0l0NtCfpITKobZQDU6HCuM/wnf0fwWM47GCY=;
X-AuditID: ac14000a-03e52700000021bc-b9-664daf0f9365
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 02.61.08636.F0FAD466;
 Wed, 22 May 2024 10:38:39 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 10:38:39 +0200
Message-ID: <0b9dc73f-f391-4598-bec1-7f0501d36c00@phytec.de>
Date: Wed, 22 May 2024 10:38:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 5/6] board: phytec: common: k3: Set MAC
To: Daniel Schultz <d.schultz@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
References: <20240522061827.601699-1-d.schultz@phytec.de>
 <20240522061827.601699-6-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240522061827.601699-6-d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWyRpKBR5d/vW+awc+f+hZv93ayW3S/U3dg
 8jh7ZwejR393C2sAUxSXTUpqTmZZapG+XQJXxr2PbSwFd3kqJu2vamDs4Opi5OSQEDCRmLxu
 LnsXIxeHkMASJokFByexQDh3GSXaNk5n7WLk4OAVsJG4NCMFpIFFQFVi85PZbCA2r4CgxMmZ
 T1hAbFEBeYn7t2awg9jCAm4SMyZdAouLCMRJrNv1mgnEFhLIlHi5ajMziM0sIC5x68l8sDib
 gLrEnQ3fWEFsTgEriaUHP7JA1FhILH5zkB3ClpfY/nYOM8QceYkXl5azQDwgLzHt3GtmCDtU
 YuuX7UwTGIVmITlvFpJ1s5CMnYVk7AJGllWMQrmZydmpRZnZegUZlSWpyXopqZsYQUEtwsC1
 g7FvjschRiYOxkOMEhzMSiK80St904R4UxIrq1KL8uOLSnNSiw8xSnOwKInzru4IThUSSE8s
 Sc1OTS1ILYLJMnFwSjUwagvz39Td/sFJ6uUst17j0//5ZF9w312nF7VxW//VNOkdr16/cGDb
 ZT61Jdjl2W6p/ROn9ca92fQ+zLDCeTG34ZdNwhnu3Fu/qvzTedT0QOuDwObCt0pPAsNZvha/
 an26TOeart1jvtOpBz4aC5VwXWFiXWakLamwOc6m47KPLOsT8+Tt/07PUWIpzkg01GIuKk4E
 ACjH4y9YAgAA
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



Am 22.05.24 um 08:18 schrieb Daniel Schultz:
> Read the EEPROM API v3 content and set all available
> MAC-Addresses to the environment.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>   board/phytec/common/k3/board.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
> index 9cb168c36cb..f21e154d4fe 100644
> --- a/board/phytec/common/k3/board.c
> +++ b/board/phytec/common/k3/board.c
> @@ -8,6 +8,8 @@
>   #include <spl.h>
>   #include <asm/arch/hardware.h>
>   
> +#include "../am6_som_detection.h"
> +
>   #if IS_ENABLED(CONFIG_ENV_IS_IN_FAT) || IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
>   int mmc_get_env_dev(void)
>   {
> @@ -68,6 +70,27 @@ int board_late_init(void)
>   		break;
>   	};
>   
> +	if (IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)) {
> +		struct phytec_api3_element *block_element;
> +		struct phytec_eeprom_data data;
> +		int ret;
> +
> +		ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
> +		if (ret || !data.valid)
> +			return 0;

Don't you want to return an error or at least print a warning?

Apart from that,

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> +
> +		PHYTEC_API3_FOREACH_BLOCK(block_element, &data) {
> +			switch (block_element->block_type) {
> +			case PHYTEC_API3_BLOCK_MAC:
> +				phytec_blocks_add_mac_to_env(block_element);
> +				break;
> +			default:
> +				debug("%s: Unknown block type %i\n", __func__,
> +				      block_element->block_type);
> +			}
> +		}
> +	}
> +
>   	return 0;
>   }
>   #endif
