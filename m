Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A815CC41535
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 11:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 000BC87B72;
	Fri, 15 Dec 2023 12:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="rNPZVFav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B55BD87B7D; Fri, 15 Dec 2023 12:55:31 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A6987A8C
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0713fbabb1=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3BF9TPlT028431; Fri, 15 Dec 2023 12:55:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=hgA0eV11jaXcGZ7e8+JT7bkmRBrNECNx33RV0tU0pos=; b=rN
 PZVFavaFVNBB/ijyWC3J6x+Aa9mS9cS8MYbrojdJyJIMTEbhHJYVOiHs48tCcU55
 srMgSColigfbiSyY25XEVBah04tnoW8cDH6k0oVK8SFdGJN/iXvH/WHvlgHYSiTX
 G+0rEbGjoMeUpCAy9cY+AZUf+DacjG9vFo1DI25BJkHVlEr1GhR2r3XJ0ELQQDS2
 HeMO8eBU8UX9w/nCPj6Vbn6CKocj7cb9CO5NFGWVW1GdV4avfbDtbH71z2+48nsz
 yaQw6yFR58iQ1NAmqJweZ5hecYIm31zfuu608IVFJzYzjmFdC1xfE8bIZ0Knn0/+
 uJYuZV26aPU3lnUVYJHQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvehmt3tn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 12:55:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DCE0100052;
 Fri, 15 Dec 2023 12:55:27 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4657B215158;
 Fri, 15 Dec 2023 12:55:27 +0100 (CET)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 12:55:26 +0100
Message-ID: <12cbbbc1-83b9-4508-bcee-b344ccb5bb0a@foss.st.com>
Date: Fri, 15 Dec 2023 12:55:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/21] stm32: Use local vars in stm32prog for initrd
 and fdt
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sean Anderson <sean.anderson@seco.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-14-sjg@chromium.org>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20231214165112.2182274-14-sjg@chromium.org>
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
> Rather than assigning to the bootm_argv[] array multiple times, use
> local variables for the two things that can change and assign them at
> the end.
>
> This makes it easier to drop the array eventually.
>
> Tidu up an overly short line while we are here.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   .../cmd_stm32prog/cmd_stm32prog.c             | 23 +++++++++++--------
>   1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
> index 2411bcf06d8f..8670535844d3 100644
> --- a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
> +++ b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
> @@ -124,30 +124,35 @@ static int do_stm32prog(struct cmd_tbl *cmdtp, int flag, int argc,
>   		char boot_addr_start[20];
>   		char dtb_addr[20];
>   		char initrd_addr[40];
> +		char *fdt_arg, *initrd_arg;
>   		char *bootm_argv[5] = {
> -			"bootm", boot_addr_start, "-", dtb_addr, NULL
> +			"bootm", boot_addr_start,
>   		};
>   		const void *uimage = (void *)data->uimage;
>   		const void *dtb = (void *)data->dtb;
>   		const void *initrd = (void *)data->initrd;
>   
> +		fdt_arg = dtb_addr;
>   		if (!dtb)
> -			bootm_argv[3] = env_get("fdtcontroladdr");
> +			fdt_arg = env_get("fdtcontroladdr");
>   		else
> -			snprintf(dtb_addr, sizeof(dtb_addr) - 1,
> -				 "0x%p", dtb);
> +			snprintf(dtb_addr, sizeof(dtb_addr) - 1, "0x%p", dtb);
>   
>   		snprintf(boot_addr_start, sizeof(boot_addr_start) - 1,
>   			 "0x%p", uimage);
>   
> +		initrd_arg = "-";
>   		if (initrd) {
> -			snprintf(initrd_addr, sizeof(initrd_addr) - 1, "0x%p:0x%zx",
> -				 initrd, data->initrd_size);
> -			bootm_argv[2] = initrd_addr;
> +			snprintf(initrd_addr, sizeof(initrd_addr) - 1,
> +				 "0x%p:0x%zx", initrd, data->initrd_size);
> +			initrd_arg = initrd_addr;
>   		}
>   
> -		printf("Booting kernel at %s %s %s...\n\n\n",
> -		       boot_addr_start, bootm_argv[2], bootm_argv[3]);
> +		printf("Booting kernel at %s %s %s...\n\n\n", boot_addr_start,
> +		       initrd_arg, fdt_arg);
> +		bootm_argv[2] = initrd_arg;
> +		bootm_argv[3] = fdt_arg;
> +
>   		/* Try bootm for legacy and FIT format image */
>   		if (genimg_get_format(uimage) != IMAGE_FORMAT_INVALID)
>   			do_bootm(cmdtp, 0, 4, bootm_argv);



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

