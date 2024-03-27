Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2E7C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 07:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3EEF8803B;
	Wed, 27 Mar 2024 08:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bvGbOLym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3599A8802E; Wed, 27 Mar 2024 08:37:03 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C84A879F6
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 08:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=38162bd5ef=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42R3h4qd016250; Wed, 27 Mar 2024 08:36:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=anYEZaI7cauvymeNjcAhUEDssn6FOs1OH2tD7xgAlII=; b=bv
 GbOLymmOSvC3mSDk/F/DsHvdcraHCCX021EYgSjtg0RYc1OILrAOp++D1zPr3dH4
 btDn4g4jvXzJYX6RS+/XY+EqvpruaTUJvlRdoeoP+aEJP1y4OP1E50LhlGP3HkEw
 azs1fQHVbO/3vy7c8lZ+bH7K0NJhAeRpW3bnH7TXuNLuFoQyGE+vDm54L4obgpy3
 +fxmHzwThhSexn4LS8hbtYCBtGI6L7JdK0F8mf3K05SIIXeKqoMYUMlZLzfRJqGb
 qajyL/bGwCytEsatobQzGnIjXUD4xUC28NG4hQCfqMGh79L54a5Fq3rUb+Az9S96
 ivHdeOfJlmok/fGxNLaQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1pugh61y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 08:36:51 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 185164002D;
 Wed, 27 Mar 2024 08:36:47 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1AB4F20D402;
 Wed, 27 Mar 2024 08:36:26 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Mar
 2024 08:36:25 +0100
Message-ID: <abb5338e-205a-46d3-ae11-cdb6aca5cec8@foss.st.com>
Date: Wed, 27 Mar 2024 08:36:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Default dfu_alt_info for STM32MP13xx SPI NOR
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240319024430.103196-1-marex@denx.de>
 <f2ab30e8-e65a-4025-a203-639d7ff1b01e@foss.st.com>
 <7ed56763-f494-4d19-82a0-05f0cc557241@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <7ed56763-f494-4d19-82a0-05f0cc557241@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.71]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_04,2024-03-21_02,2023-05-22_02
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



On 3/26/24 18:08, Marek Vasut wrote:
> On 3/19/24 11:22 AM, Patrice CHOTARD wrote:
>>
>>
>> On 3/19/24 03:44, Marek Vasut wrote:
>>> Define dfu_alt_info with SPI NOR layout to make it easy to
>>> install or update bootloader in the SPI NOR using dfu-util.
>>>
>>> Use the following U-Boot commands to start DFU mode:
>>> "
>>> => sf probe && dfu 0 mtd
>>> "
>>>
>>> Use the following dfu-util invocation on Host PC to install binaries:
>>> "
>>> $ dfu-util -w -a 0 -D build/stm32mp1/release/tf-a-stm32mp135f-dhcor-dhsbc.stm32
>>> $ dfu-util -w -a 1 -D build/stm32mp1/release/tf-a-stm32mp135f-dhcor-dhsbc.stm32
>>> $ dfu-util -w -a 2 -D build/stm32mp1/release/fip.bin
>>> "
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: u-boot@dh-electronics.com
>>> Cc: u-boot@lists.denx.de
>>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>>> ---
>>>   include/configs/stm32mp13_common.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/configs/stm32mp13_common.h b/include/configs/stm32mp13_common.h
>>> index 5b0658ced92..d6e4f8fd915 100644
>>> --- a/include/configs/stm32mp13_common.h
>>> +++ b/include/configs/stm32mp13_common.h
>>> @@ -63,6 +63,7 @@
>>>       "fi;\0"
>>>     #define STM32MP_EXTRA \
>>> +    "dfu_alt_info=mtd nor0=fsbl1 raw 0x0 0x40000;fsbl2 raw 0x40000 0x40000;uboot raw 0x80000 0x160000\0" \
>>>       "env_check=if env info -p -d -q; then env save; fi\0" \
>>>       "boot_net_usb_start=true\0"
>>>   
>>
>>
>> Hi Marek
>>
>> On our STM32 board, the dfu_alt_info is build dynamically, we have CONFIG_SET_DFU_ALT_INFO enable
>> Can you add the dfu_alt_info in a specific stm32mp13_dhxx.common.h instead ?
> 
> You can drop this patch.


Ok thanks

Patrice
