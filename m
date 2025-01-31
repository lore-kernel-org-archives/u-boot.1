Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B7FC0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 08:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AD308219C;
	Fri, 31 Jan 2025 09:12:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="t2TMver1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC28882161; Fri, 31 Jan 2025 09:12:28 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C7680F0E
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 09:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41261629dd=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V80x0F012218;
 Fri, 31 Jan 2025 09:12:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 GbtZJtF87sth6hNjqBnp2VKlL8FyNtCr1H5nANwsYbM=; b=t2TMver1c9XBwVgD
 gaNjQAIE7gS1ZTWYqanfENBFJJv1mbQt2j9/tyYQvsigTG3AuEp0JMz47XM32vDN
 hIhPTr87MUDpSNj8D1BYggIH+tccJbHPSKUciepIuPH0/6aqx/JTCoPIy+XTJoD+
 FlqIQ837T7zIaLooNts02Tm5EhqoDInQ95M17jgJbRYyftsqmM4XB/04uicRM+Dj
 YQo6tAVFNoIqoRvHw6zqBOfJgQG8VX1DbdW40/r+jTahe55kgbwZcimmx+g+3Bjd
 3DgTBk+UjY1auE9POsjlaAbrs8xfb9dXKzMK7kumdNcXaayfXuGvgCqaAN/xNn+1
 qQ5IZQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gf7d9sqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 09:12:26 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7B7DD4006D;
 Fri, 31 Jan 2025 09:11:42 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 374422BB0BA;
 Fri, 31 Jan 2025 09:07:53 +0100 (CET)
Received: from [10.252.27.7] (10.252.27.7) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 31 Jan
 2025 09:07:52 +0100
Message-ID: <ebc338ea-5097-41a3-8f2a-49e0ef0bf108@foss.st.com>
Date: Fri, 31 Jan 2025 09:07:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: stm32: Update ck_flexgen_08 frequency.
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Tom Rini <trini@konsulko.com>
References: <20250109102148.1733810-1-patrice.chotard@foss.st.com>
 <20250109102148.1733810-3-patrice.chotard@foss.st.com>
 <2214355c-e1b3-4bab-af47-f06030e7a540@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <2214355c-e1b3-4bab-af47-f06030e7a540@foss.st.com>
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



On 1/30/25 11:52, Patrick DELAUNAY wrote:
> Hi,
> 
> On 1/9/25 11:21, Patrice Chotard wrote:
>> Spurious characters are displayed on U-Boot console.
>> Usart2 clock is ck_flexgen_08 and its frequency is set
>> to an incorrect value.
>>
>> Update ck_flexgen_08 frequency from 100MHz to 64MHz.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> ---
>>
>>   arch/arm/dts/stm32mp251.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/stm32mp251.dtsi b/arch/arm/dts/stm32mp251.dtsi
>> index 44eb664fb51..e2d1c88a57f 100644
>> --- a/arch/arm/dts/stm32mp251.dtsi
>> +++ b/arch/arm/dts/stm32mp251.dtsi
>> @@ -38,7 +38,7 @@
>>           ck_flexgen_08: ck-flexgen-08 {
>>               #clock-cells = <0>;
>>               compatible = "fixed-clock";
>> -            clock-frequency = <100000000>;
>> +            clock-frequency = <64000000>;
>>           };
>>             ck_flexgen_51: ck-flexgen-51 {
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
Applied to u-boot-stm32/master

Thanks
Patrice
