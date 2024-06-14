Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208C3C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 09:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7144A88995;
	Fri, 14 Jun 2024 11:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="jJJFltBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 399B788996; Fri, 14 Jun 2024 11:33:54 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46DAC88991
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 11:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6895721e93=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E7uqHt014919;
 Fri, 14 Jun 2024 11:33:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Rxn50EVHSTMPLDkZzQ0R08E+8Wuw78OUmsqWkaRQVNw=; b=jJJFltBxApob9WML
 NWgB/B4Ao0jHMbSaShw7af8pGGVloColN0iU7oUZNV7epVRtaH4IIa9KTydpaOEH
 IoCkasGVrAzLbMG6183Pgj38Mpoyn5N9o9w0h+W6QzVi3B79AsPDk12SAx+Cj9C+
 YEZRBiRcfLAqDnqfgLW5EXEEtIHI0X9eNgIT3FijCdBHbRCJO2nRmQwbJoxHq17H
 KZFfpfSi2ao4+PgNIlKDz9KIa+B6pgjRG+13H0xDzPK5RKrK0NUoqdnSsJTqnAcM
 Nyzvf3jysRtVGG6YxBA07DRM0tciFab2OjuVRLRg7YEazYl8KUXpcgQ6WvSEzbQh
 scvQFg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp502rr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 11:33:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CE39640045;
 Fri, 14 Jun 2024 11:33:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E215C2115E8;
 Fri, 14 Jun 2024 11:33:34 +0200 (CEST)
Received: from [10.252.18.60] (10.252.18.60) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 11:33:34 +0200
Message-ID: <d7b11fc6-41af-4056-a506-73546464eb80@foss.st.com>
Date: Fri, 14 Jun 2024 11:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] stm32mp1: spl: Update optee_get_reserved_memory()
 return value
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20240611095239.16026-1-patrice.chotard@foss.st.com>
 <20240611095239.16026-2-patrice.chotard@foss.st.com>
 <53f4d52c-0b87-4bae-91f4-9529321cc549@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <53f4d52c-0b87-4bae-91f4-9529321cc549@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.18.60]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
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



On 6/14/24 09:59, Patrick DELAUNAY wrote:
> Hi Patrice
> 
> On 6/11/24 11:52, Patrice Chotard wrote:
>> In case node "/reserved-memory/optee" is not found, return -ENOENT
>> instead of 0.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/stm32mp1/spl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
>> index 10abbed87f0..beda69f3359 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
>> @@ -118,7 +118,7 @@ static int optee_get_reserved_memory(uint32_t *start, uint32_t *size)
>>         node = ofnode_path("/reserved-memory/optee");
>>       if (!ofnode_valid(node))
>> -        return 0;
>> +        return -ENOENT;
>>         fdt_start = ofnode_get_addr_size(node, "reg", &fdt_mem_size);
>>       *start = fdt_start;
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
> 
Applied to u-boot-stm32/master

Thanks
Patrice
