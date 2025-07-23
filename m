Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68651C83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 15:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF49E834E4;
	Wed, 23 Jul 2025 17:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Pb1/XK2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7449183542; Wed, 23 Jul 2025 17:19:11 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36DE1832FE
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 17:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=929994e5a7=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NFCEUr021312;
 Wed, 23 Jul 2025 17:19:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 xzTCIpHIE5O5/jRfHS+H/o1KzGHHR6i8qSlA79FbiwM=; b=Pb1/XK2gq7BzzjmR
 x5si6Ia5Zf85O1ObESEGnDePp1e/rfkv/5m37Q4kZy/OM5XrH7wZMfaNrjekuYqp
 vN4v82t6wa5/CO0Oqyg6cnNDVL1E3PAVjS8SNXHOYnvhdyw3GZK0h3XdAXm1zITS
 egWYROj+bZY8XSBkaoQe6gZ4YOTd8RFD/CLCVO5NkJRsKs6qrnuflF2Zhd1DvzUX
 f4W79JUR82Pro5zBmu8LA6W4GflrbjVDL4neAAnO7i4by//ISJp451XRLC8nHZm6
 Qd4AH+xg+w2n2qeMN6858jhA7J+maDx/zJEXMnBx+VqYDVQiMTvqeSmFdEQ8dKvP
 wSzaxw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48028gc5ms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Jul 2025 17:19:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C74A74005F;
 Wed, 23 Jul 2025 17:18:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 119A47A4CA0;
 Wed, 23 Jul 2025 17:17:40 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 17:17:39 +0200
Message-ID: <6afd5864-dc54-44a0-965c-029e982091cf@foss.st.com>
Date: Wed, 23 Jul 2025 17:17:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ums command broken since commit c5d685b8993c ("usb: dwc2: Unify
 flush and reset logic with v4.20a support")
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 <seashell11234455@gmail.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>
References: <16f6e5bf-f7fd-4e5b-95fe-1388975484b6@foss.st.com>
 <5cf111d7-a209-4669-921e-10b6729cca26@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <5cf111d7-a209-4669-921e-10b6729cca26@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
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

Hi,

On 6/9/25 15:41, Patrice CHOTARD wrote:
> +U-Boot mailing list i forgot to set.
>
> On 6/9/25 14:40, Patrice CHOTARD wrote:
>> Hi all
>>
>> Since commit c5d685b8993c ("usb: dwc2: Unify flush and reset logic with v4.20a support") on next branch
>> "ums" command is broken, we got the following issue on STM32MP157c-DK2 and STM32MP135f-DK boards:
>>
>>
>> STM32MP> ums 0 mmc 0
>>
>> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1dacc00
>> \dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> |dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> |dwc2_core_reset: Waiting for GINTSTS_CURM_HOST timeout
>> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> \dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> dwc2_core_reset: Waiting for GINTSTS_CURE_HOST timeout
>> dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> /c2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> -dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> -dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> /dwc2_core_reset: Waiting for GINTSTS_CURM_HOST timeout
>> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>> /dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout
>>
>>
>> Thanks
>> Patrice


I think I found the root cause of the issue in the serir, I push the 
next fixes:

[PATCH] usb: dwc2: fix reset logic in dwc2_core_reset

https://patchwork.ozlabs.org/project/uboot/list/?series=466391

Tested on STM32MP13F-DK for device mode (forced).


Regards

Patrick


