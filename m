Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CF8C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 07:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC18A80F70;
	Fri, 31 Jan 2025 08:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="1VsGQpOa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70FE980EB6; Fri, 31 Jan 2025 08:59:47 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7012E80F0E
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 08:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41261629dd=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V7ox6b029612;
 Fri, 31 Jan 2025 08:59:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 WBkgGQDCM5OuxuBnDLjVSPkKFFSrAW8lPe56tvYwIOM=; b=1VsGQpOaegDIWGSI
 TF/ZgLWfkwfddbnkSwbirrJ9dVfT9EYSeE709uuY8pjV6Gy1nqPcUT9uwMdTkMwk
 gteWLYNV3nJPgcHWYHPmVpVhxYG5dHSUo0FgmgmzmWiSAAAKtsucEfTBEe0vz5qq
 AMeIYY3IB+5nDcLh7WF7XGfowBsBUeYl59cpy+WVoFgzv9Ii3U2dpHrI5BCi7Top
 m3OpsMEBO44vxwOgdjJ9egUKCxcIuKJbyE/t8DRKD2xKlMUYs6cnbSewGD5YcZmR
 22dLbqU0KiqW5hZGMxQt0nFxzYJQ5dYrNk9Dzuh4MAkfy0GPdDoT3c0fXxFeuszr
 6x6URA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gf7e1r13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 08:59:44 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A2ABD4005A;
 Fri, 31 Jan 2025 08:58:51 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0DC192A8750;
 Fri, 31 Jan 2025 08:56:53 +0100 (CET)
Received: from [10.252.27.7] (10.252.27.7) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 31 Jan
 2025 08:56:52 +0100
Message-ID: <7c4266ba-2ea4-44f8-bb52-d1d763d3def6@foss.st.com>
Date: Fri, 31 Jan 2025 08:56:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] arm: stm32mp: stm32prog: update multiplier is
 part-size is above SZ_1G
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20241129122711.411917-1-patrice.chotard@foss.st.com>
 <20241129122711.411917-4-patrice.chotard@foss.st.com>
 <aede5c04-b1bd-42da-93e4-8c2cc7a5a9a1@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <aede5c04-b1bd-42da-93e4-8c2cc7a5a9a1@foss.st.com>
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



On 1/8/25 19:49, Patrick DELAUNAY wrote:
> Hi
> 
> On 11/29/24 13:27, Patrice Chotard wrote:
>> Set multiplier to 'G' if part->size if above SZ_1G.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
>> index f0e019e8da1..353aecc09de 100644
>> --- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
>> +++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
>> @@ -1229,7 +1229,10 @@ static int stm32prog_alt_add(struct stm32prog_data *data,
>>       char multiplier,  type;
>>         /* max 3 digit for sector size */
>> -    if (part->size > SZ_1M) {
>> +    if (part->size > SZ_1G) {
>> +        size = (u32)(part->size / SZ_1G);
>> +        multiplier = 'G';
>> +    } else if (part->size > SZ_1M) {
>>           size = (u32)(part->size / SZ_1M);
>>           multiplier = 'M';
>>       } else if (part->size > SZ_1K) {
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
