Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A44C61DB2
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07AFB82B95;
	Mon,  9 Jun 2025 10:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="u4tpIH3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A7A682B3D; Mon,  9 Jun 2025 10:57:49 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9026182B7C
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82553fdf62=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5597m4AQ007906;
 Mon, 9 Jun 2025 10:57:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 T8+05bSLnhd84vQW5aWKgFheFmwDZeW9eZafwhc2iJU=; b=u4tpIH3GhXiru0xG
 Kp51Li5F3JM0UI5Db963shKy8xznzI6esFCQVsQUbEkzQwiCAjJ4z3g/aXJkkBbj
 B57ryVn95BtY5rD+fzGVehaxzUqOcUdiV+XgE9T9/mFZmB4RUpXowzWFWeqrfg9R
 FypwHul0zmnL0Wspb2zx2yJgogn0HBS87y4ShaZ4Bif6lsSq/zMHuYWLVmElry0c
 9fw5s7Ks88dU/5DIMyivY/1kLJAPaQRanUPPbEvGvop7BxXrvT4K6KfVRrIKvj0l
 SdgzEntmcbLf+2V/LXT5bYY+cBfOCKVefk4L2QDCb0hwF4VZ6vh+tA/ht+xNBGXA
 GNTNRQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474y04v5th-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 10:57:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5676140050;
 Mon,  9 Jun 2025 10:56:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1DD0EB7ED03;
 Mon,  9 Jun 2025 10:55:31 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 10:55:30 +0200
Message-ID: <a1b14b92-c239-4eb0-a708-1c332ca116db@foss.st.com>
Date: Mon, 9 Jun 2025 10:55:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: stm32mp13: Fix typo in STM32MP13 RCC driver
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Sean Anderson
 <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250512165147.148396-1-marek.vasut@mailbox.org>
 <79702444-0703-4695-8b90-c9942e5236f0@foss.st.com>
Content-Language: en-US
In-Reply-To: <79702444-0703-4695-8b90-c9942e5236f0@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_03,2025-06-05_01,2025-03-28_01
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



On 5/21/25 16:40, Patrice CHOTARD wrote:
> 
> 
> On 5/12/25 18:51, Marek Vasut wrote:
>> Fix basic typo, missing t in security . No functional change .
>>
>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Sean Anderson <seanga2@gmail.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>  drivers/clk/stm32/clk-stm32mp13.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
>> index 362dba10252..11dc40383a4 100644
>> --- a/drivers/clk/stm32/clk-stm32mp13.c
>> +++ b/drivers/clk/stm32/clk-stm32mp13.c
>> @@ -497,7 +497,7 @@ static const struct stm32_div_cfg stm32mp13_dividers[LAST_DIV] = {
>>  	DIV_CFG(DIV_ETH2PTP, RCC_ETH12CKSELR, 12, 4, 0, NULL),
>>  };
>>  
>> -struct clk_stm32_securiy {
>> +struct clk_stm32_security {
>>  	u16	offset;
>>  	u8	bit_idx;
>>  };
>> @@ -566,7 +566,7 @@ enum securit_clk {
>>  		.bit_idx	= _bit_idx, \
>>  	}
>>  
>> -static const struct clk_stm32_securiy stm32mp13_security[] = {
>> +static const struct clk_stm32_security stm32mp13_security[] = {
>>  	SECF(SECF_LPTIM2, RCC_APB3SECSR, RCC_APB3SECSR_LPTIM2SECF),
>>  	SECF(SECF_LPTIM3, RCC_APB3SECSR, RCC_APB3SECSR_LPTIM3SECF),
>>  	SECF(SECF_VREF, RCC_APB3SECSR, RCC_APB3SECSR_VREFSECF),
>> @@ -776,7 +776,7 @@ static int stm32mp13_check_security(void __iomem *base,
>>  	int secured = 0;
>>  
>>  	if (sec_id != SECF_NONE) {
>> -		const struct clk_stm32_securiy *secf;
>> +		const struct clk_stm32_security *secf;
>>  
>>  		secf = &stm32mp13_security[sec_id];
>>  		secured = !!(readl(base + secf->offset) & BIT(secf->bit_idx));
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
Applied to u-boot-stm32/next

Thanks
Patrice
