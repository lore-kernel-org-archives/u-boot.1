Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3139C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 08:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97AA480F95;
	Fri, 31 Jan 2025 09:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="E4B8hJbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3F282145; Fri, 31 Jan 2025 09:08:58 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D54F280F0E
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 09:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41261629dd=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V80xfh004473;
 Fri, 31 Jan 2025 09:08:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 tzqB2D+gPWA1/DHDXKjsqKp7TJoarHmh+8pXKgMuqow=; b=E4B8hJbwSh+71CiR
 xrLbnUr52yp0+C5sN1h8iCmDT0ZMAAUJYpOlIasQbV8C+6y9xMjE9HwpKwVtum8N
 4eCmtRZ3cKF9aVt/PTPvWi/rBD1VuonEWGEshEkmUnDnJw4KLXZpPVcKPdv0G+GK
 Ue978DJX7H9zywPZkwDskDrfgnXzb3ll4J2h1/DYzlY6t7vpBB/2h+0GzdQh5ZPS
 otDyItEnyCYSZh+XewT1IT5RWApf1qhQuXPDZ/DlTdqoATgFdxWSwK+TXKe2q3Ap
 kFNsKbdgE7uCTfVtAmxEiiUgnAhSaPJ/5khxHbJ5kBCsXyCHcEoHLV4mVmQfNwOl
 powyEg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gf7dsu02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 09:08:52 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 29D064002D;
 Fri, 31 Jan 2025 09:08:02 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 712222B2E3C;
 Fri, 31 Jan 2025 09:05:22 +0100 (CET)
Received: from [10.252.27.7] (10.252.27.7) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 31 Jan
 2025 09:05:21 +0100
Message-ID: <9d8f52df-01a6-4075-ab9b-e9e481783bb1@foss.st.com>
Date: Fri, 31 Jan 2025 09:05:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: st: stm32mp1: Clean env_get_location()
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marex@denx.de>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20241129124857.443093-1-patrice.chotard@foss.st.com>
 <b4006420-b89c-488b-8148-5af4740f34bb@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <b4006420-b89c-488b-8148-5af4740f34bb@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.27.7]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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



On 12/5/24 13:48, Patrick DELAUNAY wrote:
> Hi,
> 
> On 11/29/24 13:48, Patrice Chotard wrote:
>> ENV_IS_IN_EXT4 flag is no more used in any STM32 defconfig,
>> remove the related code.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   board/st/stm32mp1/stm32mp1.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
>> index d5e5e776d2a..15fb9e4b062 100644
>> --- a/board/st/stm32mp1/stm32mp1.c
>> +++ b/board/st/stm32mp1/stm32mp1.c
>> @@ -751,8 +751,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
>>       case BOOT_FLASH_EMMC:
>>           if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
>>               return ENVL_MMC;
>> -        else if (CONFIG_IS_ENABLED(ENV_IS_IN_EXT4))
>> -            return ENVL_EXT4;
>>           else
>>               return ENVL_NOWHERE;
>>   
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/master

Thanks
Patrice
