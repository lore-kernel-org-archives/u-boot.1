Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04740C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC5ED887E7;
	Fri, 19 Apr 2024 14:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="snBLdHe7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5CE887FA; Fri, 19 Apr 2024 14:17:33 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1795887D9
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J8Eere031243; Fri, 19 Apr 2024 14:17:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=eyW4zfe8UDNJ3nF63z/6myHs0jAtXesHH19xeUwMVz4=; b=sn
 BLdHe7ZZ/LCXmci17TcyjjP1yEsPaDvaIRoO1nBLDm5f9LzTu7H8EMi/CF67UkkE
 o1UiDUDlM9eEos9WlSraHZNnPvMaj2FUp2EO2oCZYtxtpUdUOQ5kmlaa549Q/4GX
 U1uPPVmsxibnUYAop5V4h+bfTD7OC61OxVp0b5bn4v6yCQ5XmKBNZSEgzM3iGS4G
 zRbD1+brxozS4qIgHeSp1RrC11X8qMVljZYqc8VZlVpJ77wOGqGNd32Z2yp0UfdF
 0ujT3v2CSnOJo7FMSytW0oCVmLMJfPp6q/J8F0DYZIdYJ9bmxk6hMmA/Jw0s29Pl
 SsbAFoU+g1rcgSRpny+Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xfhcx44et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:17:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E82E140045;
 Fri, 19 Apr 2024 14:17:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 48E6A2194FA;
 Fri, 19 Apr 2024 14:17:10 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:17:09 +0200
Message-ID: <ec2be059-6aa4-4f48-ae90-632cddc06165@foss.st.com>
Date: Fri, 19 Apr 2024 14:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/25] ARM: dts: stm32: Don't probe led-red/led-blue at
 boot for stm32mp135f-dk-u-boot
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Tom Rini <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-9-patrice.chotard@foss.st.com>
 <c7cd7bb9-d0a9-4e25-92d3-51aba895a54b@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <c7cd7bb9-d0a9-4e25-92d3-51aba895a54b@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
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



On 4/17/24 11:06, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/9/24 17:01, Patrice Chotard wrote:
>> led-red and button dedicated to fastboot share the same gpio GPIOA13.
>> led-blue and button dedicated to stm32prog share the same gpio GPIOA14.
>> Led driver is probed early so the corresponding gpio is taken and
>> configured in output which forbid fastboot and stm32prog button usage.
>>
>> To avoid this, remove the "default-state" property from led-red and
>> led-blue led's node.
>>
>> This will avoid to trigger the led driver probe() to configure the led
>> default state during startup.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp135f-dk-u-boot.dtsi | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied on u-boot-stm32/master 
