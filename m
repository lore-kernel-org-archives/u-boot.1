Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA2BCA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 14:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC2558307F;
	Mon, 25 Aug 2025 16:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="lAalALpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A204883093; Mon, 25 Aug 2025 16:55:30 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED5583020
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 16:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0332a41ace=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PEn0Sx011055;
 Mon, 25 Aug 2025 16:55:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Xy1BVsRmOPVRI+fkqlCz035H/h35ZfPH0eFcWaJ++3s=; b=lAalALpCHTsPqwiU
 aSpjgkp8pu743+UCRULsmxQki/dCpbjgRMIf0TjMczCEog3esF/XZzt8bQoqt4Hi
 vKqh+nEl2TfO1bhp0uvW1m/YM8QViQEiy5XPJSPgTPmb4cR3a0AQzYrbMRv0FOjI
 SzJtdO9pRnIDZSJnlzPApQrWNqmnuAKjOfdVCVSCp0UTMKgdMd006wyRGMoAHfUQ
 5gX/+CJTZtYSeZDmKj7xN6adVvGp4LSbzyFryAmxfu9hXX2/FRkWaAQZXgKnsjYc
 7G2Qy6pzBZW8Lz+kHerII4xf0xp5FpxYu5WfV761IqRpeAjjLPnPDyN/rcHldWDc
 CbgxlQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q626evjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 16:55:26 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3923C40044;
 Mon, 25 Aug 2025 16:54:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8C1496C25EF;
 Mon, 25 Aug 2025 16:53:59 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 25 Aug
 2025 16:53:58 +0200
Message-ID: <476e3428-254b-4df2-8ff1-37d28fc0eb1d@foss.st.com>
Date: Mon, 25 Aug 2025 16:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: stm32mp25: Enable OF_UPSTREAM_BUILD_VENDOR
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Cheick Traore
 <cheick.traore@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250814120938.1358059-1-patrice.chotard@foss.st.com>
 <a10f97cf-72d8-4f82-870f-cb845e5cb72e@mailbox.org>
 <626aac73-10f5-4514-a6ea-0b67a7b2d45b@foss.st.com>
 <81059c20-971d-43ce-ac98-421329efe938@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <81059c20-971d-43ce-ac98-421329efe938@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
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



On 8/19/25 12:54, Marek Vasut wrote:
> On 8/14/25 5:23 PM, Patrice CHOTARD wrote:
>>
>>
>> On 8/14/25 15:37, Marek Vasut wrote:
>>> On 8/14/25 2:09 PM, Patrice Chotard wrote:
>>>> Initially, only one STM32MP25 based board was available, the
>>>> stm32mp257f-ev1 board which was set by default in stm32mp25_defconfig.
>>>>
>>>> Since commit 79f3e77133bd ("Subtree merge tag 'v6.16-dts' of dts repo [1] into dts/upstream")
>>>> we inherited of a second MP25 based board which is the stm32mp257f-dk board.
>>>>
>>>> Enable OF_UPSTREAM_BUILD_VENDOR and set OF_UPSTREAM_VENDOR to allow all
>>>> STMicroelectronics DT compilation.
>>> If I build stm32mp25_defconfig , I can run the result on both EV1 and DK now ?
>>>
>>
>> With this patch yes
>>
>>> It seems only the EV1 DT is built into the binary, so why compile all DTs ?
>>
>> By default yes, only EV1 DT is built. that's why OF_UPSTREAM_BUILD_VENDOR is needed to
>> allow all other st/*.dtb to be built.
>>
>>>
>>> $ grep TREE configs/stm32mp25_defconfig
>>> CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp257f-ev1"
>>>
>>
>> Currently if you try to build U-Boot for stm32mp257f-dk board using the following commands:
>>
>> make stm32mp25_defconfig
>> make DEVICE_TREE=st/stm32mp257f-dk
> 
> Please introduce defconfig for each board instead of this hackage .
> 
> Look at this example on how to use #include in defconfig files, it even supports multiple levels of config structure for deduplication purposes:


I know, but in downstream we already use only one defconfig for all our STM32MP/13/15/25 SoCs.
It has impact on our internal build process and we prefer to keep the same for all our SoCs family 

Patrice

> 
> $  git grep include configs/imx*dh*
> configs/imx6_dhcom_drc02_defconfig:#include <configs/dh_imx6.config>
> configs/imx6_dhcom_pdk2_defconfig:#include <configs/dh_imx6.config>
> configs/imx6_dhcom_picoitx_defconfig:#include <configs/dh_imx6.config>
> configs/imx8mp_dhcom_drc02_defconfig:#include <configs/imx8mp_dhsom.config>
> configs/imx8mp_dhcom_pdk2_defconfig:#include <configs/imx8mp_dhsom.config>
> configs/imx8mp_dhcom_pdk3_defconfig:#include <configs/imx8mp_dhsom.config>
> configs/imx8mp_dhcom_picoitx_defconfig:#include <configs/imx8mp_dhsom.config>
> configs/imx8mp_dhsom.config:#include <configs/imx_dhsom.config>
> configs/imx_dhsom.config:#include <configs/dhsom.config>
> 
