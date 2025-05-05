Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCBBC3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE60820E1;
	Mon,  5 May 2025 15:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="xWuWr+sn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2805F820E1; Mon,  5 May 2025 15:31:00 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1505082076
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7220064b2c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545B3Itx025904;
 Mon, 5 May 2025 15:30:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 1NuI3+dnIC0odN7Fmh/oPgsIP3b5c1GPYh6jvuLfVyc=; b=xWuWr+snhM7dspId
 037QVts56EsXZjiz8Yk5f5lHwFGhAJ+isVyyynB+0xb5PT2GGVhJfaHYdnsL8g7k
 m5lnZChn94zjLVEZs/xx6vknBjul/bw8gRxIE2q7V+nP7YXSkkGMV6O4rDIH5B5b
 g1DvFlHxFK3cYHHD53w3EClZI+vUfe3cVUFGwtk0K2aA0g+6r+QCC6YJYnyKDQGm
 YBYNIqb6NoG7PisMpymMm14LYP9AAwe/MqugYYZ7bt1OrMYK8ImTLOBxbr2H2kXC
 eeh30w7bWgnYUC90gWv9ivdq9N6CE1uf51oiRGlJBSGUSwPL+V/i7MIkohKx6z9R
 aOpdlQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46dvq3vuwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 15:30:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2014D4002D;
 Mon,  5 May 2025 15:29:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E4B26ABE7B5;
 Mon,  5 May 2025 15:28:57 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 15:28:57 +0200
Message-ID: <f345a3e0-7e14-41c7-9bfc-ac6aa042959a@foss.st.com>
Date: Mon, 5 May 2025 15:28:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] board: st: common: fix dfu alt buffer clearing
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 <u-boot@lists.denx.de>
CC: Jassi Brar <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Michal Simek
 <michal.simek@amd.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
 <20250407170529.893307-3-vincent.stehle@arm.com>
 <0e7b0b06-d100-4db5-aa84-9eb9767f4e0d@foss.st.com>
Content-Language: en-US
In-Reply-To: <0e7b0b06-d100-4db5-aa84-9eb9767f4e0d@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_06,2025-05-05_01,2025-02-21_01
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



On 4/22/25 09:32, Patrice CHOTARD wrote:
> 
> 
> On 4/7/25 19:05, Vincent Stehlé wrote:
>> The set_dfu_alt_info() function calls the ALLOC_CACHE_ALIGN_BUFFER()
>> macro to declare a `buf' variable pointer into an array allocated on the
>> stack. It then calls the memset() function to clear the useable portion
>> of the array using the idiomatic expression `sizeof(buf)'.
>>
>> While this would indeed work fine for an array, in the present case we
>> end up clearing only the size of a pointer.
>> Fix this by specifying the explicit size `DFU_ALT_BUF_LEN' instead.
>>
>> Fixes: ec2933e543df ("board: stm32mp1: move set_dfu_alt_info in st common directory")
>> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Marek Vasut <marex@denx.de>
>> ---
>>  board/st/common/stm32mp_dfu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu.c
>> index 1db8e45480e..8c1f80b678a 100644
>> --- a/board/st/common/stm32mp_dfu.c
>> +++ b/board/st/common/stm32mp_dfu.c
>> @@ -105,7 +105,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>>  	if (env_get("dfu_alt_info"))
>>  		return;
>>  
>> -	memset(buf, 0, sizeof(buf));
>> +	memset(buf, 0, DFU_ALT_BUF_LEN);
>>  
>>  	snprintf(buf, DFU_ALT_BUF_LEN,
>>  		 "ram 0=%s", CONFIG_DFU_ALT_RAM0);
> 
> Hi Vincent,
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
Applied to u-boot-stm32/master

Thanks
Patrice
