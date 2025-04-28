Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959E9C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DB9482AFC;
	Mon, 28 Apr 2025 15:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="7+wsyFNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D5A482724; Mon, 28 Apr 2025 15:25:23 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B90182AFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7213f5eaf8=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9ODOF012474;
 Mon, 28 Apr 2025 15:25:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 NudUiI4B28FfiSCo9oTubfgP9t4peeJAb3rc317r8G8=; b=7+wsyFNkuqEi3Tsb
 TMD5I38Sa4l/RfrS4ak2W9ZfUBTuOBq9ZKx4ckKqprDvUmuVzmiSgseACPhb/LqX
 EvcpbRfHwIeqMIqWEaL9yoCw7C1CYuNpfhZO3GtCe4kyFfwhifYuqI0wfkZxWAk/
 tb7WKyDK8MHN8iedIZj6FcN2hCcE0BLe2YjRmGwPojcwa0MUjJ1Azdc6n/wM3gpX
 5yiuNZiVYjINUItyqu+EAS+vxx4AZfM88vmPvsAcUUtqMgBRayhoFSzKfLcSfyaP
 61jJwadQTo4Edgp0+lcyXumKPZmLZPFjSap2BJntleWW5ZqhIOvbKA+vh/cHbaWh
 rcp2bw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 468mwky7dh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 15:25:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CBD1E4002D;
 Mon, 28 Apr 2025 15:24:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 46D98A7FB62;
 Mon, 28 Apr 2025 15:24:08 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 15:24:07 +0200
Message-ID: <5d3efe4a-29d6-4552-bfbe-e61c22b1b892@foss.st.com>
Date: Mon, 28 Apr 2025 15:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/22] arm: stm32mp: add helper function
 stm32mp_is_closed()
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>,
 Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
 Tom Rini <trini@konsulko.com>
References: <20250425131533.392747-1-patrice.chotard@foss.st.com>
 <20250425131533.392747-20-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250425131533.392747-20-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
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



On 4/25/25 15:15, Patrice Chotard wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Add the helper function stm32mp_is_closed() to check the "closed" state in
> product life cycle, when product secrets have  been provisioned into the
> device, by "secure secret provisioning" tools (SSP) for example.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-stm32mp/cmd_stm32key.c          | 22 +++++++++++++++++++
>  .../arm/mach-stm32mp/include/mach/sys_proto.h |  7 ++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/arch/arm/mach-stm32mp/cmd_stm32key.c b/arch/arm/mach-stm32mp/cmd_stm32key.c
> index d6bf72d8e32..6bfa67859e1 100644
> --- a/arch/arm/mach-stm32mp/cmd_stm32key.c
> +++ b/arch/arm/mach-stm32mp/cmd_stm32key.c
> @@ -618,3 +618,25 @@ U_BOOT_CMD_WITH_SUBCMDS(stm32key, "Manage key on STM32", stm32key_help_text,
>  	U_BOOT_SUBCMD_MKENT(read, 2, 0, do_stm32key_read),
>  	U_BOOT_SUBCMD_MKENT(fuse, 3, 0, do_stm32key_fuse),
>  	U_BOOT_SUBCMD_MKENT(close, 2, 0, do_stm32key_close));
> +
> +/*
> + * Check the "closed" state in product life cycle, when product secrets have
> + * been provisioned into the device, by SSP tools for example.
> + * On closed devices, authentication is mandatory.
> + */
> +bool stm32mp_is_closed(void)
> +{
> +	struct udevice *dev;
> +	bool closed;
> +	int ret;
> +
> +	ret = get_misc_dev(&dev);
> +	if (ret)
> +		return false;
> +
> +	ret = read_close_status(dev, false, &closed);
> +	if (ret)
> +		return false;
> +
> +	return closed;
> +}
> diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> index bf1c39742c1..19073668497 100644
> --- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> +++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> @@ -120,3 +120,10 @@ u32 get_otp(int index, int shift, int mask);
>  
>  uintptr_t get_stm32mp_rom_api_table(void);
>  uintptr_t get_stm32mp_bl2_dtb(void);
> +
> +/* helper function: check "closed" state in product "Life Cycle" */
> +#ifdef CONFIG_CMD_STM32KEY
> +bool stm32mp_is_closed(void);
> +#else
> +static inline bool stm32mp_is_closed(void) { return false; }
> +#endif
Applied to u-boot-stm32/master

Thanks
Patrice
