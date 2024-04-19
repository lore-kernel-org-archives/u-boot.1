Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7DBC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D06887E1;
	Fri, 19 Apr 2024 14:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="FiG+PiR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC38887D7; Fri, 19 Apr 2024 14:34:15 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB98388811
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43JAnTDb006062; Fri, 19 Apr 2024 14:34:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=xVY2qhAycv0ruaeiWuv46IpyNvVnZbegJ5Uirru5/eI=; b=Fi
 G+PiR2vGPzD8Nls9BxLdpzsXhMoPSJtxOIh1KqQf/vKI1gBF4XBiISVoTWGk8olU
 m2YCGLE2W9JC1Ds41rpm7PQaurBu47kacdp39N4HWbip0F1Xvt8AbrdhSqfBE5LO
 5M2fBOcjx4Se+RTdVk/+DPnKIzEh3L6KkCm75PXtBGvecnJM7lChxAgecTxVGxP2
 OLC50I+jOXHoiGlQbeb7t3iUG1cOTmhcZXrTTArnPNR2duGIbrjxfoVRQTsQW5oD
 EWDtNN9kKojrO+GubL/oDIEGaSGrETYMbGuzzJ4Mec2JkmGYnS0JVdF1hILhssJI
 7dc16tCFryYQn1v/Genw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m12bgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:34:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 46FEB4002D;
 Fri, 19 Apr 2024 14:34:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 95C9921ADC6;
 Fri, 19 Apr 2024 14:33:43 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:33:43 +0200
Message-ID: <9a17c368-191b-4b1c-ad02-92fd2dbda680@foss.st.com>
Date: Fri, 19 Apr 2024 14:33:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ARM: dts: stm32: Fix partition node name for
 stm32mp157c-ev1-u-boot
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marex@denx.de>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20240308135009.2621719-1-patrice.chotard@foss.st.com>
 <480ef8f6-2cc0-4014-8025-19b5c48a14fd@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <480ef8f6-2cc0-4014-8025-19b5c48a14fd@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_09,2024-04-19_01,2023-05-22_02
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



On 4/17/24 10:59, Patrick DELAUNAY wrote:
> Hi,
> 
> On 3/8/24 14:50, Patrice Chotard wrote:
>> Fix flash@0 and nand@0 partition node name with correct offset.
>>
>> Fixes: e91d3c61767b ("arm: dts: stm32: Add partitions in flash0 and nand
>> node for stm32mp15xx-ev1")
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi b/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi
>> index 139940bd5d4..3515347e91d 100644
>> --- a/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi
>> @@ -33,11 +33,11 @@
>>               label = "fsbl1";
>>               reg = <0x00000000 0x00040000>;
>>           };
>> -        partition@80000 {
>> +        partition@40000 {
>>               label = "fsbl2";
>>               reg = <0x00040000 0x00040000>;
>>           };
>> -        partition@100000 {
>> +        partition@80000 {
>>               label = "ssbl";
>>               reg = <0x00080000 0x00200000>;
>>           };
>> @@ -58,7 +58,7 @@
>>               label = "fsbl2";
>>               reg = <0x00040000 0x00040000>;
>>           };
>> -        partition@100000 {
>> +        partition@80000 {
>>               label = "fip";
>>               reg = <0x00080000 0x00400000>;
>>           };
>> @@ -112,7 +112,7 @@
>>                       label = "fip2";
>>                       reg = <0x00600000 0x00400000>;
>>                   };
>> -                partition@1200000 {
>> +                partition@a00000 {
>>                       label = "UBI";
>>                       reg = <0x00a00000 0x3f600000>;
>>                   };
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
Applied on u-boot-stm32/master 
