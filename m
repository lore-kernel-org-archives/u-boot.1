Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137FAEE49A5
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AD4780702;
	Thu, 24 Aug 2023 17:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="o4ljli7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6625D86667; Thu, 24 Aug 2023 17:09:30 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43418056D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=66005a8e49=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37O9XZsA012404; Thu, 24 Aug 2023 17:09:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=WXAyHRK0Xj6u5vqUEQLmFyRGmne+QOxd98ebCx4zNz0=; b=o4
 ljli7jG8EEjutz55obC3jAz8n+ZdQMkq7VMyFy6c70zrmUVm+HYNNf90A9yqnm8C
 L/TzIIQ1jnFHa4vBOCNEl/MIsiFgmiVUyLc+/sv2RbR5pVVQRJbslxyF077Rvyak
 lrTQ1xgH5vXU8WHmhyxxjUnKFjNpyBukYGIMaoOtsMvaL+459xlbxNYXZ8mZFftF
 kzulwcefJ5U5MUEu2eDFgQF/0w4LZwuiGWdb8WX4o2UebriLHVkJhvxCmyqPunOn
 4EJhFdP60CvFDnE1p5mxAYINwlPOxbgtp8crdlSJj9n0yml+GfTibtM5AQhk+rZo
 pkUPhk7QtWoJn9IYzdHA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sn1y7gcqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Aug 2023 17:09:26 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2ACAD100059;
 Thu, 24 Aug 2023 17:09:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 13F16242AD3;
 Thu, 24 Aug 2023 17:09:26 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 24 Aug
 2023 17:09:25 +0200
Message-ID: <93ef967c-8e9b-fbab-5186-4b1e3f11428f@foss.st.com>
Date: Thu, 24 Aug 2023 17:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: remove Vikas Manocha
To: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: Michael Walle <michael@walle.cc>, <u-boot@lists.denx.de>
References: <20230824074436.2929639-1-michael@walle.cc>
 <20230824135441.GJ3953269@bill-the-cat>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230824135441.GJ3953269@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
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

On 8/24/23 15:54, Tom Rini wrote:
> On Thu, Aug 24, 2023 at 09:44:36AM +0200, Michael Walle wrote:
> 
>> The mails are bouncing with
>>   550 5.1.1 User Unknown (in reply to RCPT TO command)
>>
>> Remove the entry and mark the ARM STM STV0991 arch as Orphan.
>>
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>> CCing other ST people, maybe someone want to take over instead.
>> ---
>>  MAINTAINERS | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 84de9de531..57ede4bea9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -641,8 +641,7 @@ N:	stm32
>>  
>>  
>>  ARM STM STV0991
>> -M:	Vikas Manocha <vikas.manocha@st.com>
>> -S:	Maintained
>> +S:	Orphan
>>  F:	arch/arm/cpu/armv7/stv0991/
>>  F:	arch/arm/include/asm/arch-stv0991/
> 
> This misses board/st/stv0991/MAINTAINERS where he's also listed.  So,
> someone needs to step up to maintain it all, or we should look at
> dropping it.  Thanks!
> 


Hi 

Unfortunately, the last significant update on this board was done in 2015. 
On our side, Patrick Delaunay and I, we never worked on stv0991,
we don't have any hardware and we have enough work with STM32 platforms ;-)

So we will not oppose to drop stv0991 platform.

Patrice
