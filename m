Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258A0C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 13:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80A2887C9D;
	Fri, 19 Jan 2024 14:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="K7+SfB/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D8A687CA0; Fri, 19 Jan 2024 14:27:36 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5519887BBC
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 14:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=17487c629f=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40JB3MEs031162; Fri, 19 Jan 2024 14:27:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=pynr4B4rn307gw+j3DWE2tmqwSOF6TRnoTWrW88EHb0=; b=K7
 +SfB/rbrUTCFmC//wpFmOb6ie+CDmN4qM6o9UfflhDRGWyAgjtMNmOeB/jQ4H+4a
 KZ7jxMAWoIgQa/ZMpzWU8ncjWTAMyCS0mczc974CdQborqNKGqIYT17+pkCSvREb
 2au95z+ybhvxGjFb86DBZ/IV/r5MA717s8twE2sSmP+JTKjGIoNfmyo6yyeKCcLa
 AU3vJW7SYA3qczXgWIetiSgad5ji2zYhcL05WVVZztqn6yKEbz3XSlAAX1QuEbLD
 1VQX8fKFjJaggV0PDOSZ4dYTyVLGWHm1+AuHvhi3IZ+vMGUaLzttL0xrMLhwI8TN
 Ujpi83UAtaQCpfg5HGnQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vnbqckdj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 14:27:33 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7611A100083;
 Fri, 19 Jan 2024 14:27:33 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7098024B89A;
 Fri, 19 Jan 2024 14:27:33 +0100 (CET)
Received: from [10.252.4.250] (10.252.4.250) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Jan
 2024 14:27:32 +0100
Message-ID: <d9996de7-6f68-424a-9757-f8ee6de3a428@foss.st.com>
Date: Fri, 19 Jan 2024 14:27:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] board: st: stm32mp2: add checkboard
Content-Language: en-US
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
 <20240115150451.v2.11.I266d8c1df18ce288bebb30c6b14cbdfa9cc6edd1@changeid>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240115150451.v2.11.I266d8c1df18ce288bebb30c6b14cbdfa9cc6edd1@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.4.250]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_08,2024-01-19_02,2023-05-22_02
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



On 1/15/24 15:05, Patrick Delaunay wrote:
> Implement the weak function checkboard to identify the used board with
> compatible in device tree for the support of stm32mp2 STMicroelectronics
> boards.
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  board/st/stm32mp2/stm32mp2.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
> index c97a7efff46e..9a881583d904 100644
> --- a/board/st/stm32mp2/stm32mp2.c
> +++ b/board/st/stm32mp2/stm32mp2.c
> @@ -8,14 +8,28 @@
>  #include <config.h>
>  #include <env.h>
>  #include <fdt_support.h>
> +#include <log.h>
>  #include <asm/global_data.h>
>  #include <asm/arch/sys_proto.h>
> +#include <dm/ofnode.h>
>  
>  /*
>   * Get a global data pointer
>   */
>  DECLARE_GLOBAL_DATA_PTR;
>  
> +int checkboard(void)
> +{
> +	const char *fdt_compat;
> +	int fdt_compat_len;
> +
> +	fdt_compat = ofnode_get_property(ofnode_root(), "compatible", &fdt_compat_len);
> +
> +	log_info("Board: stm32mp2 (%s)\n", fdt_compat && fdt_compat_len ? fdt_compat : "");
> +
> +	return 0;
> +}
> +
>  /* board dependent setup after realloc */
>  int board_init(void)
>  {
Applied to u-boot-stm32/master

Thanks
Patrice
