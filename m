Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32853C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74B5E887F0;
	Fri, 19 Apr 2024 14:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="OA6X3niR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6956A887E9; Fri, 19 Apr 2024 14:17:18 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87341887E6
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43JAuZ1E020533; Fri, 19 Apr 2024 14:17:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Cn7Bu06685UEHkCZNavB9QL7x1ok/4NgYL7DF/NZCpk=; b=OA
 6X3niRsdiPIqIVoMiAfCp7BDczOjZuyNdEj3R7XcNNHHHaY8QJYuheecSI/EmU/O
 OL1kF+N6HAiPOlSzTEy3BIJinwvzL7bLLiNKnXuK4oIkftVMJNCe5XK7EXna+KLn
 WMyTo6EfD/19fGFRo3Lts0l8ySEP3lllm5gQd9aDcFwpU8anaQadWbLIhSmY27Zp
 gwxL93QSj/apS9G/lgqVCXOhULx5Uv0QQWbfPcZqGzCPdxF8R4pbrsFLiQWlOs6t
 hQAp2NRWVryShdnzLAoBEH22KzbX7C0cyPBeRmV38bGmJ+9YLYiJwwiMlpAS201d
 wppcNu6Z7SUB9s5N+GSA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m129cx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:17:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7B3E740047;
 Fri, 19 Apr 2024 14:17:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7FF6B21A204;
 Fri, 19 Apr 2024 14:16:46 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:16:45 +0200
Message-ID: <7b86b471-0379-4e1b-9fa2-99fcc46cc36e@foss.st.com>
Date: Fri, 19 Apr 2024 14:16:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/25] configs: stm32mp1: Enable BUTTON_GPIO flag for
 stm32mp13_defconfig
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@gmail.com>
CC: <u-boot@lists.denx.de>, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-6-patrice.chotard@foss.st.com>
 <CAByghJZG403R9g0S+Q+aDgiCh74j_JzY+CXydv33mLCjSwFjLg@mail.gmail.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAByghJZG403R9g0S+Q+aDgiCh74j_JzY+CXydv33mLCjSwFjLg@mail.gmail.com>
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



On 4/18/24 13:48, Igor Opaniuk wrote:
> On Tue, Apr 9, 2024 at 5:05 PM Patrice Chotard
> <patrice.chotard@foss.st.com> wrote:
>>
>> Enable BUTTON_GPIO flag for STM32MP15.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>  configs/stm32mp13_defconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
>> index db09e63100e..caaabf39ef3 100644
>> --- a/configs/stm32mp13_defconfig
>> +++ b/configs/stm32mp13_defconfig
>> @@ -52,6 +52,8 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>  CONFIG_SYS_MMC_ENV_DEV=-1
>>  CONFIG_ENV_MMC_USE_DT=y
>> +CONFIG_BUTTON=y
>> +CONFIG_BUTTON_GPIO=y
>>  CONFIG_CLK_SCMI=y
>>  CONFIG_SET_DFU_ALT_INFO=y
>>  CONFIG_USB_FUNCTION_FASTBOOT=y
>> --
>> 2.25.1
>>
> 
> Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Applied on u-boot-stm32/master 
