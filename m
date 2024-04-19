Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218C6C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A886E887E0;
	Fri, 19 Apr 2024 14:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="xXQyLr76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA0BD887DF; Fri, 19 Apr 2024 14:17:06 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9785887D9
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J9VfCb030184; Fri, 19 Apr 2024 14:17:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=5xrVbsIQfDnasUkpmSCcvgBgO5h80twGS3DNuF5LRdU=; b=xX
 QyLr76EuCHt8o3IdIiLY3aPmDG+dZZUGxxWnhlCHHvndw0Kn4hNMSeZ4hboqTxN3
 XGa8wFwN3qejJoVAN+TjRTnU8xb8fltaNTEnrrgfaKdTzQVHSeAsBoM8js4usbvd
 cNQMkODRsWD4M5VJ2oauDNK8t9xDhsKmrppmY/ODV5PlHpy12/wQmP96UgbRoSpj
 9LvCRIYR/jBVqwpbL6ICEvkgPmMkjSaEpW8sPzdiQ1oLg5w5uKE/Fm9rQOFrjFaQ
 xIuowTrCuvgNGVF37fUZEIvevDbRBHnSjJeDkw0QBk7AsRYYZi8B2qZSODwtCAyt
 yGboKiSimm+sy3MJ2MiQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecyrbj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:17:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CB13540044;
 Fri, 19 Apr 2024 14:16:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9CDB021A200;
 Fri, 19 Apr 2024 14:16:38 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:16:38 +0200
Message-ID: <de2a436b-8d98-49c8-9311-a896dc13cc16@foss.st.com>
Date: Fri, 19 Apr 2024 14:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/25] configs: stm32mp1: Enable BUTTON_GPIO flag for
 stm32mp15_trusted_defconfig
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Grzegorz Szymaszek <gszymaszek@short.pl>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-5-patrice.chotard@foss.st.com>
 <af1c7071-3dc2-451b-aed6-61d6b2ea3e4a@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <af1c7071-3dc2-451b-aed6-61d6b2ea3e4a@foss.st.com>
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



On 4/17/24 11:04, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/9/24 17:01, Patrice Chotard wrote:
>> Enable BUTTON_GPIO flag for STM32MP15.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   configs/stm32mp15_trusted_defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
>> index 84b0854b557..74deaaba2e4 100644
>> --- a/configs/stm32mp15_trusted_defconfig
>> +++ b/configs/stm32mp15_trusted_defconfig
>> @@ -70,6 +70,8 @@ CONFIG_TFTP_TSIZE=y
>>   CONFIG_USE_SERVERIP=y
>>   CONFIG_SERVERIP="192.168.1.1"
>>   CONFIG_STM32_ADC=y
>> +CONFIG_BUTTON=y
>> +CONFIG_BUTTON_GPIO=y
>>   CONFIG_CLK_SCMI=y
>>   CONFIG_SET_DFU_ALT_INFO=y
>>   CONFIG_USB_FUNCTION_FASTBOOT=y
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 

Applied on u-boot-stm32/master 
