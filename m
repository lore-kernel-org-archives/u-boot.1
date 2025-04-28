Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AC5C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A6D82893;
	Mon, 28 Apr 2025 15:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZlAjjTCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22D4C82948; Mon, 28 Apr 2025 15:28:52 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 202CB82724
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7213f5eaf8=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9aHZG021436;
 Mon, 28 Apr 2025 15:28:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 6KdrvMpj6I8HBP6/FnLr7zMaAS901r+5RYh2NWX5DYM=; b=ZlAjjTCFrcC7h7Iy
 D4FmNPaYGlMp+gCYoyHvfCMzvD3KSzBrpNcY2hhKUb1XCQ0cAx705TiX/q4A7iUO
 +Bo8aGOOdWZ6cQBY6d3dph//JvKv4Lpv/28LXFwm9BNqSjqeVxZt8pPzYSB/GFNK
 lzqJpEemMBXkAJyI3JG6853gjNJDQLz2r8kU8wetQeb5s8eLdPdV9j8pjBp2pvKR
 hP0vrydeqI3OoDrYgSpRPnQgrr8l9Jgik3ox6fXDgrVkN/l36dK0em248+H3ayrd
 AxftmwwVlqcxvXBVCJBEVmKiTQBHLMcbPpKYjw+HJ1b3m7jwaf4U3G1zjqFqO1s5
 NJknWA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 468mm9exnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 15:28:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 437B04004D;
 Mon, 28 Apr 2025 15:27:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 354DFA47069;
 Mon, 28 Apr 2025 15:24:24 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 15:24:23 +0200
Message-ID: <abe102c4-5dfb-47f2-bb69-616256b38042@foss.st.com>
Date: Mon, 28 Apr 2025 15:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/22] arm: stm32mp: stm32prog: add support rootfs-a
 for OTA
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
References: <20250425131533.392747-1-patrice.chotard@foss.st.com>
 <20250425131533.392747-22-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250425131533.392747-22-patrice.chotard@foss.st.com>
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
> Add support of "rootfs-a" name to allow support of A/B mechanism for OTA
> on rootfs.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
> index f6395bad0ec..5b027fad048 100644
> --- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
> +++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
> @@ -1157,7 +1157,8 @@ static int create_gpt_partitions(struct stm32prog_data *data)
>  
>  			/* partition UUID */
>  			uuid_bin = NULL;
> -			if (!rootfs_found && !strcmp(part->name, "rootfs")) {
> +			if (!rootfs_found && (!strcmp(part->name, "rootfs") ||
> +					      !strcmp(part->name, "rootfs-a"))) {
>  				mmc_id = part->dev_id;
>  				rootfs_found = true;
>  				if (mmc_id < ARRAY_SIZE(uuid_mmc))
Applied to u-boot-stm32/master

Thanks
Patrice
