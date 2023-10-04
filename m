Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC26BE8FDDB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2802286E9A;
	Wed,  4 Oct 2023 11:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="6Y2fmJ3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F3A86E98; Wed,  4 Oct 2023 11:20:51 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B8A86E9E
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864180acd4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3946Hg4I022073; Wed, 4 Oct 2023 11:20:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=NviQFOQcOj9Vptizu29+26UOOma/dSlYJSZ6r8TkDdY=; b=6Y
 2fmJ3ZaPZruoh79BN+kgzCZrl+XJ6rNKFZOQt9rYRtgCsVAwLsmz3tzAsa+jZbA9
 3WEMqsJag9sh9Vblfo97RmPMOpkb3D7il79vXgWPWuUsr20UhFlR0VqdID04g75V
 PzzlxfdmINTqmtO1v1xFof6KTulSZLP0J44SNpt4k+imP3p0e7c2gBcVf0k7EEBu
 5wWBh42uIOeknZfedDthZx3sKQHY2s/t42GLcPlzriQ/oIzRXqaPTEEokcVxmzjS
 S5HZ5Po52L7qjv/hBWPPFWPLQZvKY4OWSDQP7g9yuBIQ12/pbyaEBoDeOYOjzNuj
 hNoEXExlpEtPED4uUR8g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3teajd05gm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 11:20:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D985D100053;
 Wed,  4 Oct 2023 11:20:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D1A5122A6E4;
 Wed,  4 Oct 2023 11:20:48 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 11:20:48 +0200
Message-ID: <b0bf1057-2bcf-2ea6-3a2d-fcaeab751d0b@foss.st.com>
Date: Wed, 4 Oct 2023 11:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] ram: stm32mp1: Only print RAM config with
 CONFIG_SPL_DISPLAY_PRINT
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Harald Seiler <hws@denx.de>, <u-boot@lists.denx.de>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
References: <20230927124440.247726-1-hws@denx.de>
 <e4619de5-27cd-d0d5-ec2d-2accde958dd3@foss.st.com>
In-Reply-To: <e4619de5-27cd-d0d5-ec2d-2accde958dd3@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
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



On 10/4/23 11:11, Patrice CHOTARD wrote:
> 
> 
> On 9/27/23 14:44, Harald Seiler wrote:
>> Ensure that the RAM configuration line is only printed when
>> CONFIG_SPL_DISPLAY_PRINT is set.
>>
>> Signed-off-by: Harald Seiler <hws@denx.de>
>> ---
>>  drivers/ram/stm32mp1/stm32mp1_ram.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ram/stm32mp1/stm32mp1_ram.c b/drivers/ram/stm32mp1/stm32mp1_ram.c
>> index a6c19af9722..2808d07c3ae 100644
>> --- a/drivers/ram/stm32mp1/stm32mp1_ram.c
>> +++ b/drivers/ram/stm32mp1/stm32mp1_ram.c
>> @@ -126,7 +126,8 @@ static int stm32mp1_ddr_setup(struct udevice *dev)
>>  		dev_dbg(dev, "no st,mem-name\n");
>>  		return -EINVAL;
>>  	}
>> -	printf("RAM: %s\n", config.info.name);
>> +	if (CONFIG_IS_ENABLED(DISPLAY_PRINT))
>> +		printf("RAM: %s\n", config.info.name);
>>  
>>  	for (idx = 0; idx < ARRAY_SIZE(param); idx++) {
>>  		ret = ofnode_read_u32_array(node, param[idx].name,
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice

Apply on stm32/next

Thanks
