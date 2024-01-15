Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED706C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 13:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6377086FC9;
	Mon, 15 Jan 2024 14:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QEk7y94T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E26786FC9; Mon, 15 Jan 2024 14:09:04 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 457C3876E8
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 14:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d49635=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40F8tel2001615; Mon, 15 Jan 2024 14:09:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Hdyeplw1ohYjLHu0OGlfqfGOLQZpZ+BuKK7Zcj2p2fs=; b=QE
 k7y94T9kiooyycWMBoGTEaQC6NBgVhWoDA8lOpw9xp/Ufv9v6oB0NpLJiq+6vjrl
 zCNG2fSAdHyM5rdNuldYZfBPVD222MHJUn9mXY8O+L1ud7zPxXkoPUzRcLLjmEQO
 RykftH5porKF+Lb00LnOz5kUbc2X3mvVZqLdA9R1TIFE7W4K2PDMwXqN2pfs+yMg
 7FUWfr2leXSuCfc0W6KE+G+GOBhAo4+5A++KCnIEQovywZijDMAK3vpqJySESN38
 a0h6/vGsjI7G95yeJxDLw92rFLaDikLdvC1oLWosV8dubKCGAhB0XbBmxjVM98Nh
 YNVsfU5B4oSONWUSIBhw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vm4y4pcrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 14:08:48 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0180510002A;
 Mon, 15 Jan 2024 14:08:48 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ECE4E2815EE;
 Mon, 15 Jan 2024 14:08:47 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 14:08:47 +0100
Message-ID: <4115c90f-fa8e-4bdf-aa3a-537a9495deb5@foss.st.com>
Date: Mon, 15 Jan 2024 14:08:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] board: st: stm32mp2: add checkboard
Content-Language: en-US
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240115124657.39109-1-patrick.delaunay@foss.st.com>
 <20240115134642.11.I266d8c1df18ce288bebb30c6b14cbdfa9cc6edd1@changeid>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240115134642.11.I266d8c1df18ce288bebb30c6b14cbdfa9cc6edd1@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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



On 1/15/24 13:46, Patrick Delaunay wrote:
> Implement the weak function checkboard to identify the used board with
> compatible in device tree for the support of stm32mp2 STMicroelectronics
> boards.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
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
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
