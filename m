Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3508EC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 15:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74C6D86591;
	Fri, 25 Aug 2023 17:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="lZwlhfvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD453865D1; Fri, 25 Aug 2023 17:44:39 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E80D18642C
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 17:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6601d42974=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37PEChVQ023316
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 17:44:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=f5FvRRkfwBrqhXSm+V9Rzjhj2i2rKL+kK6Y3tR0aQJI=; b=lZ
 wlhfvNkQN5g7cBlU1/8lr6bGo+eLE2/VB0Sp+d+T74fGi81GZRTykm4d3jv1mce5
 oicLkPqyupT0Aqh40uEn3bSeIyvgMCt/zHjxg8dTTmt3uWtE5EibZiBPDOvL3WPH
 LjtwY7SEsePkjIvN87U7W6Yxy0ynOD/wL9DmyESBG8RPWTl5Pt7ttrjKgITBopRz
 8uZOqccea2fAgQaT+Y21S55KrS7Ke/6eXiTKOznz4yu7Ko6/WyWrPweYT1EKcg4Z
 6JGxvd7rJeJfjKPKHOAsSVScVfrUCioyx3nGjPymng4oQyzrRjGSPw9e77exfHxv
 FxIBnA6VxTwAKWaiew+A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3spmhyjknx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 17:44:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 829C710004F
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 17:44:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6556023BDFA
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 17:44:35 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 25 Aug
 2023 17:44:35 +0200
Message-ID: <306921d6-54d4-3c11-8dea-7879ffd9faa2@foss.st.com>
Date: Fri, 25 Aug 2023 17:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] dfu: mtd: fix the trace when limit is reached
Content-Language: en-US
To: <u-boot@lists.denx.de>
References: <20230605075208.55221-1-patrick.delaunay@foss.st.com>
 <20230605095147.v3.1.I442ff110f3340ab844d07bfaa40ad621f1217b03@changeid>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230605095147.v3.1.I442ff110f3340ab844d07bfaa40ad621f1217b03@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
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



On 6/5/23 09:52, Patrick Delaunay wrote:
> The offset variable = 'off' used in the error trace when limit is reach
> on erase operation is incorect as 'erase_op.addr' is used in the loop.
> This patch corrects the copy paste issue between the erase loop and
> the write loop.
> 
> This patch also adds the 'remaining' information to allow to debug of
> limit issues.
> 
> Fixes: 6015af28ee6d ("dfu: add backend for MTD device")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  drivers/dfu/dfu_mtd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dfu/dfu_mtd.c b/drivers/dfu/dfu_mtd.c
> index c7075f12eca9..b764f091786d 100644
> --- a/drivers/dfu/dfu_mtd.c
> +++ b/drivers/dfu/dfu_mtd.c
> @@ -86,8 +86,8 @@ static int mtd_block_op(enum dfu_op op, struct dfu_entity *dfu,
>  
>  		while (remaining) {
>  			if (erase_op.addr + remaining > lim) {
> -				printf("Limit reached 0x%llx while erasing at offset 0x%llx\n",
> -				       lim, off);
> +				printf("Limit reached 0x%llx while erasing at offset 0x%llx, remaining 0x%llx\n",
> +				       lim, erase_op.addr, remaining);
>  				return -EIO;
>  			}
>  

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
