Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2EFE77188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 07:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E325F8033D;
	Thu, 16 Jan 2025 08:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="YozBpGub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E6A080658; Thu, 16 Jan 2025 08:01:29 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4123D80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 08:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3111215904=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FJknFE008409;
 Thu, 16 Jan 2025 08:01:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 iId8J6+V4r89/XZmfa+aFRz6ZShH7Lwzcl/YTmCqMiY=; b=YozBpGubZRgUkNyk
 v4R5RaqB+FWwNQJXht6VNt1KZJzolYrIp9OWQxWrqWLNteB3HT0GThW5PfuG+W3G
 BXmXnYjdkRkI7Hv1l7LywpWl09grPjNUqAsd8zxMxDKMRnh5wLALQTebFYqzWRtb
 GM7OzmPrXsA2aCL6xoHextrRLGj5FZ64A3i606Z/WILNtgXg+24kw8PC6+h3wHKa
 HWNr5dBAoSFxeWBfWxy9Xj2pEPZuTjPJ3VBx7buMVRXgQOD7x3inbAqEH7caOK8+
 sIV1kE2b+u75YpsCwe3WNZMcZDIXvwuXmzgtTTl/XtDxdKuIVYW2lw5Isfnbufc6
 +JgmhQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 446kfg1k5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 08:01:20 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 352B640046;
 Thu, 16 Jan 2025 08:00:02 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9BDEC2839D7;
 Thu, 16 Jan 2025 07:59:37 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 16 Jan
 2025 07:59:37 +0100
Message-ID: <5885696e-f083-42ef-9828-a23bf4f52fb1@foss.st.com>
Date: Thu, 16 Jan 2025 07:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] dw3-generic: Add dependencies whith SYSCON and
 REGMAP
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Sjoerd Simons <sjoerd@collabora.com>, Tom Rini
 <trini@konsulko.com>
References: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
 <20250114144528.1612168-7-patrice.chotard@foss.st.com>
 <de9e66e1-ab5a-4d46-9ec9-b19627f4ea9b@denx.de>
 <cbb93a24-4b4e-4254-b031-39c1abfa67ba@foss.st.com>
 <21b58bc6-df13-4639-86e8-8f44c6439e5d@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <21b58bc6-df13-4639-86e8-8f44c6439e5d@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_02,2025-01-15_02,2024-11-22_01
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



On 1/15/25 20:29, Marek Vasut wrote:
> On 1/15/25 11:43 AM, Patrice CHOTARD wrote:
>>
>>
>> On 1/14/25 15:54, Marek Vasut wrote:
>>> On 1/14/25 3:45 PM, Patrice Chotard wrote:
>>>> Since addition of STiH407 support in dwc3-generic, SYSCON and REGMAP
>>>> support are needed.
>>>>
>>>> Add dependencies with SPL_REGMAP and SPL_SYSCON for:
>>>> qcm6490, imx8mp_evk, phycore-imx8mp, librem5, qcom,
>>>> xilinx_versal_net_virt, amd_versal2_virt, xilinx_zynqmp_kria
>>>> xilinx_zynqmp_virt.
>>>>
>>>> Add dependencies with SPL_REGMAP and SPL_SYSCON for am57xx_hs_evm_usb.
>>>>
>>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>> Cc: Marek Vasut <marex@denx.de>
>>>> ---
>>>>
>>>>    drivers/usb/dwc3/Kconfig | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
>>>> index 0100723a68b..ef82a3e9626 100644
>>>> --- a/drivers/usb/dwc3/Kconfig
>>>> +++ b/drivers/usb/dwc3/Kconfig
>>>> @@ -26,6 +26,10 @@ config USB_DWC3_OMAP
>>>>    config USB_DWC3_GENERIC
>>>>        bool "Generic implementation of a DWC3 wrapper (aka dwc3 glue)"
>>>>        depends on DM_USB && USB_DWC3 && MISC
>>>> +    select SPL_REGMAP if SPL
>>>> +    select SPL_SYSCON if SPL
>>>> +    select REGMAP
>>>> +    select SYSCON
>>> Why was this not needed so far ? Or is this a bugfix ?
>>
>> My comment lacks of detail.
>> By adding stih407 support, i am using syscon_regmap_lookup_by_phandle() which
>> need that REGMAP and SYSCOn support are enabled.
> I suspect this will now be specific to the stih glue driver , right?

Right it's specific to STi glue driver. But as i said in my reply of patch 04/10, 
the rework of patch 04/10 will remove the need of patch 06/10.

Thanks
Patrice
