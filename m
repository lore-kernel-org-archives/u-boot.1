Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F780C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E8B2887F5;
	Fri, 19 Apr 2024 14:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Jn6Le0TH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F8B887D9; Fri, 19 Apr 2024 14:34:33 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEDF6887F5
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43JACAjC030287; Fri, 19 Apr 2024 14:34:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=rmwMjaOFjwQ/vpl1nmqGFIKW9BnSQAeTR5larCs56ak=; b=Jn
 6Le0THiOeihRnzgTO2FMix1i5qsDfPtwf/Brd9i24o0vQoPD3DNiZqARKZKQttj2
 ZAAMPDIsSyRhVw2vDENt/8UcDlr8IZzav0Nckbod7bMmSBC+MPQAZ1oVHtiBkMEm
 oJyGUuU4Zsft59ZLkrF0OKUJ93N4WwsfSV5ItZZmGbaja/cr4aYIjdaJj3Cw4D3w
 dKgzgvT8/HgD0gnzusGFdB/L9dv+rEEoMf9xLdbY6ENKMaU5v5VTkCvF92MTcRkc
 UVc1I8KVbW5348n+d9aw43l2xNpjxYs9lp6wXSWA/PkxVf3QEcyBNaqiI3zUppQ2
 d494u2yrDPyv2lxkRLXw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xff64uvkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:34:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E05E24002D;
 Fri, 19 Apr 2024 14:34:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36CC021ADC0;
 Fri, 19 Apr 2024 14:33:51 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:33:50 +0200
Message-ID: <d588152f-15ad-4ed3-93ae-14cf8597ae2f@foss.st.com>
Date: Fri, 19 Apr 2024 14:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: stm32: Fix partition node name for
 stm32mp15xx-dhcom-u-boot
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>, <u-boot@dh-electronics.com>
References: <20240308135009.2621719-1-patrice.chotard@foss.st.com>
 <20240308135009.2621719-3-patrice.chotard@foss.st.com>
 <9577dc11-5018-4b12-913c-27d00ce92dee@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <9577dc11-5018-4b12-913c-27d00ce92dee@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_08,2024-04-19_01,2023-05-22_02
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



On 4/17/24 11:00, Patrick DELAUNAY wrote:
> Hi,
> 
> On 3/8/24 14:50, Patrice Chotard wrote:
>> Fix flash@0 partition node name with correct offset.
>>
>> Fixes: 90f992e6a58c ("arm: dts: stm32: Add partitions in flash0 and nand
>> node for stm32mp15xx-dhcom/dhcor")
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
>> index 2f70b0690d2..1b445619325 100644
>> --- a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
>> @@ -106,15 +106,15 @@
>>               label = "fsbl2";
>>               reg = <0x00040000 0x00040000>;
>>           };
>> -        partition@500000 {
>> +        partition@80000 {
>>               label = "uboot";
>>               reg = <0x00080000 0x00160000>;
>>           };
>> -        partition@900000 {
>> +        partition@1e0000 {
>>               label = "env1";
>>               reg = <0x001E0000 0x00010000>;
>>           };
>> -        partition@980000 {
>> +        partition@1f0000 {
>>               label = "env2";
>>               reg = <0x001F0000 0x00010000>;
>>           };
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 

Applied on u-boot-stm32/master 
