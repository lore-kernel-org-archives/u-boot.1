Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765E8C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 11:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62AD8784E;
	Fri, 15 Dec 2023 12:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="dBpZV+8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25BE987A8C; Fri, 15 Dec 2023 12:58:07 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC868782F
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0713fbabb1=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BF9hv5X018594; Fri, 15 Dec 2023 12:58:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=n4JCG+nxJsygtROkWxYjTijXeNsI8zsKB4TLL0KQ/8U=; b=dB
 pZV+8ODtjO3YT6MmTNtBv39LnvHMMnNuR1Qdq2V/r0koSW/+zer+uBapajWBSUTW
 z4YBvqCsoxW7BJfnmKe4R93rzV1hJzqDZm8HPyZFiELQFF7dHDXgTGH1ms2JuKqL
 /LueBtBPD+xMkcLisUXDJ6ugmJXOTh6WG3ifcHw/kCUNZeZCEXCEoYtWW3Q9A8TN
 Q3KDgaYjwuMHf0Cg0JuB/63WEmMNB4ldXlSSaa3IrIbC8pe3cgPeqGavbCSD1CHm
 ME4bu7SCXJd9MQNT8QSceZdyUW4WmRUvn0+G80bLIPh8uxw9RRIoiMRZAPKpWprt
 p8h1bnPBobCDTM+xcZ1A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uyb2k9jnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 12:58:01 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8021C100052;
 Fri, 15 Dec 2023 12:58:00 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 772BE215BFD;
 Fri, 15 Dec 2023 12:58:00 +0100 (CET)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 12:57:59 +0100
Message-ID: <d6c9f0fa-863f-4e21-8a6e-d16b982ff5b7@foss.st.com>
Date: Fri, 15 Dec 2023 12:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/21] stm32: Use bootm_run() and bootz_run()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sean Anderson <sean.anderson@seco.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-16-sjg@chromium.org>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20231214165112.2182274-16-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_06,2023-12-14_01,2023-05-22_02
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

Hi,

On 12/14/23 17:50, Simon Glass wrote:
> Use the new bootm/z_run() functions to avoid having to create an
> argument list for the stm32prog code.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   .../cmd_stm32prog/cmd_stm32prog.c             | 20 ++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
> index 8670535844d3..3ed393b7199f 100644
> --- a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
> +++ b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <common.h>
> +#include <bootm.h>
>   #include <command.h>
>   #include <dfu.h>
>   #include <image.h>
> @@ -125,12 +126,10 @@ static int do_stm32prog(struct cmd_tbl *cmdtp, int flag, int argc,
>   		char dtb_addr[20];
>   		char initrd_addr[40];
>   		char *fdt_arg, *initrd_arg;
> -		char *bootm_argv[5] = {
> -			"bootm", boot_addr_start,
> -		};
>   		const void *uimage = (void *)data->uimage;
>   		const void *dtb = (void *)data->dtb;
>   		const void *initrd = (void *)data->initrd;
> +		struct bootm_info bmi;
>   
>   		fdt_arg = dtb_addr;
>   		if (!dtb)
> @@ -141,7 +140,7 @@ static int do_stm32prog(struct cmd_tbl *cmdtp, int flag, int argc,
>   		snprintf(boot_addr_start, sizeof(boot_addr_start) - 1,
>   			 "0x%p", uimage);
>   
> -		initrd_arg = "-";
> +		initrd_arg = NULL;
>   		if (initrd) {
>   			snprintf(initrd_addr, sizeof(initrd_addr) - 1,
>   				 "0x%p:0x%zx", initrd, data->initrd_size);
> @@ -149,15 +148,18 @@ static int do_stm32prog(struct cmd_tbl *cmdtp, int flag, int argc,
>   		}
>   
>   		printf("Booting kernel at %s %s %s...\n\n\n", boot_addr_start,
> -		       initrd_arg, fdt_arg);
> -		bootm_argv[2] = initrd_arg;
> -		bootm_argv[3] = fdt_arg;
> +		       initrd_arg ?: "-", fdt_arg);
> +
> +		bootm_init(&bmi);
> +		bmi.addr_fit = boot_addr_start;
> +		bmi.conf_ramdisk = initrd_arg;
> +		bmi.conf_fdt = fdt_arg;
>   
>   		/* Try bootm for legacy and FIT format image */
>   		if (genimg_get_format(uimage) != IMAGE_FORMAT_INVALID)
> -			do_bootm(cmdtp, 0, 4, bootm_argv);
> +			bootm_run(&bmi);
>   		else if (IS_ENABLED(CONFIG_CMD_BOOTZ))
> -			do_bootz(cmdtp, 0, 4, bootm_argv);
> +			bootz_run(&bmi);
>   	}
>   	if (data->script)
>   		cmd_source_script(data->script, NULL, NULL);



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

