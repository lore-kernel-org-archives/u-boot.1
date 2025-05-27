Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FF0C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 11:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 152228303C;
	Tue, 27 May 2025 13:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mcL5QyFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3EED83045; Tue, 27 May 2025 13:50:23 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D22B82B7C
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 13:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RA60ir027752;
 Tue, 27 May 2025 13:49:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 sZXe1hRznVvomhT0D0Zh9WpmzwMlyHOTOftd/CMNdsU=; b=mcL5QyFpLgCSKeQq
 dZ9NiNXHscHkDDLQXvp7VS0xrk7uRsBhHz5Z4qjdezg5nXfcYtVgmRdqIjM3AyCF
 fcrfVgOUNjE8XmSeW9n+rkZki6Pm7YlygeBKYii9ZQEtbTR2ooHowDuaqlOFUD5f
 zc5B4DnnHwpQ/A1OIwJPmcMTbI57Q+1I/pWsVOvVLTqRB3XwDlx8QDB8NyqfWK89
 w89seGbcwH+eCNu08mvV/rBQr/7eVZN7kg+iP9mUR8ExJfjoGGgoUY3cZExbWz28
 D5tbkh9HUU2Sd+8a8US9owMfLTIJ9AEz7Rjp4n9c8yk/XWiEmrKYUhOjVn6UDDvI
 iDqVlg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46uqp4hnj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 13:49:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BD46D40046;
 Tue, 27 May 2025 13:47:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F35C1A473E5;
 Tue, 27 May 2025 13:45:59 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 13:45:58 +0200
Message-ID: <60be33dc-0833-45c9-adad-b7e2fe7b3eaf@foss.st.com>
Date: Tue, 27 May 2025 13:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/13] reset: stm32mp25: add stm32mp25 reset driver
To: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Greg Malysa <malysagreg@gmail.com>, Huan Zhou <me@per1cycle.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Joseph Chen
 <chenjh@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>, Leo Yu-Chi
 Liang <ycliang@andestech.com>, Marek Vasut <marex@denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Robert Marko
 <robert.marko@sartura.hr>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>, Tom Rini
 <trini@konsulko.com>
References: <20250521134117.2828335-1-patrice.chotard@foss.st.com>
 <20250521134117.2828335-12-patrice.chotard@foss.st.com>
 <ad156150-a116-4b85-92a5-9764a53166bc@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ad156150-a116-4b85-92a5-9764a53166bc@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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



On 5/22/25 09:10, Gabriel FERNANDEZ wrote:
> 
> On 5/21/25 15:41, Patrice Chotard wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> Implement STM32MP25 reset drivers using stm32-core-reset API.
>> This reset stm32-reset-core API and will be able to use DT binding
>> index started from 0.
>>
>> This patch also moves legacy reset into stm32 directory reset.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>

[...]

>> +    RESET(ADC12_R,        RCC_ADC12CFGR,        0,    0),
>> +    RESET(ADC3_R,        RCC_ADC3CFGR,        0,    0),
>> +    RESET(ETH1_R,        RCC_ETH1CFGR,        0,    0),
>> +    RESET(ETH2_R,        RCC_ETH2CFGR,        0,    0),
>> +    RESET(USBH_R,        RCC_USB2CFGR,        0,    0),
> 
> RCC_USBHCFGR

Ok

> 
> Best regards
> 
> Gabriel
> 
>> +    RESET(USB2PHY1_R,    RCC_USB2PHY1CFGR,    0,    0),
>> +    RESET(USB2PHY2_R,    RCC_USB2PHY2CFGR,    0,    0),
>> +    RESET(USB3DR_R,        RCC_USB3DRCFGR,        0,    0),
>> +    RESET(USB3PCIEPHY_R,    RCC_USB3PCIEPHYCFGR,    0,    0),
>> +    RESET(USBTC_R,        RCC_UCPDCFGR,        0,    0),
>> +    RESET(ETHSW_R,        RCC_ETHSWCFGR,        0,    0),
>> +    RESET(SDMMC1_R,        RCC_SDMMC1CFGR,        0,    0),
>> +    RESET(SDMMC1DLL_R,    RCC_SDMMC1CFGR,        16,    0),
>> +    RESET(SDMMC2_R,        RCC_SDMMC2CFGR,        0,    0),
>> +    RESET(SDMMC2DLL_R,    RCC_SDMMC2CFGR,        16,    0),

