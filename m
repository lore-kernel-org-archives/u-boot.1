Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F13DC5B542
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 12:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F5083013;
	Tue, 27 May 2025 14:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="O1Xq38y2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E31B8301F; Tue, 27 May 2025 14:03:48 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1404283010
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 14:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R8tWia030822;
 Tue, 27 May 2025 14:03:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 tBQShpcuc6wGv92S+q904eI1fNtkZcz9CHuQRA2G2MM=; b=O1Xq38y2tiauUCB+
 904wRajnkfkXRBmMro0lNZYF021h6bKhf2itEwC3dWpr51EFT4sP6e374w7q/zPr
 x/Go8a0jR0zdSZzOmXddrRLlaYYbtppMfJiVIB8RrY4WMLpVwkTlZXa+DjrLRWjZ
 99o3NB3mST+AlQAAqaOSXxoWTUusslKulprT2uAjnU4O7oOH1cI5gmgHohPJYgt1
 KD4zLxHYuzgew2DGz2AmmEJM4DKJB+X42uoCs/mugqMcy1SUH6DfPNQ19H+8g8j+
 zStpY9WBo6ezQpE6UlZRNVKuVrddaUreXFVkAfCGmdOzI3dtwAxCNJ8dGW6/yg07
 /4lIXQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46w54hjaun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 14:03:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0059340054;
 Tue, 27 May 2025 14:02:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8DEECA7F83A;
 Tue, 27 May 2025 14:02:28 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 14:02:28 +0200
Message-ID: <fb71475a-17df-4e53-96f5-2a33bd3fd79a@foss.st.com>
Date: Tue, 27 May 2025 14:02:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/13] clk: stm32mp25: Add clock driver support
To: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Valentin Caron
 <valentin.caron@foss.st.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20250521134117.2828335-1-patrice.chotard@foss.st.com>
 <20250521134117.2828335-3-patrice.chotard@foss.st.com>
 <b4c857a8-141a-43d4-b2d3-15427997c3d0@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <b4c857a8-141a-43d4-b2d3-15427997c3d0@foss.st.com>
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



On 5/22/25 09:08, Gabriel FERNANDEZ wrote:
> 
> On 5/21/25 15:41, Patrice Chotard wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> Add clock driver support for STM32MP25 SoCs.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Lukasz Majewski <lukma@denx.de>
>> Cc: Sean Anderson <seanga2@gmail.com>
>> ---

[...]

>> +    GATE_UART7,
>> +    GATE_UART8,
>> +    GATE_UART9,
>> +    GATE_USART1,
>> +    GATE_USART2,
>> +    GATE_USART3,
>> +    GATE_USART6,
>> +    GATE_USB2,
> please rename GATE_USB2 into GATE_USBH to be conform with last reference manual

Ok

>> +    GATE_USB2PHY1,
>> +    GATE_USB2PHY2,
>> +    GATE_USB3DR,
>> +    GATE_USB3PCIEPHY,
>> +    GATE_USBTC,
>> +    GATE_VDEC,
>> +    GATE_VENC,
>> +    GATE_VREF,
>> +    GATE_WWDG1,
>> +    GATE_WWDG2,

[...]

>> +    GATE_CFG(GATE_ETH2,        RCC_ETH2CFGR,        5,    0),
>> +    GATE_CFG(GATE_ETH2TX,        RCC_ETH2CFGR,        8,    0),
>> +    GATE_CFG(GATE_ETH2RX,        RCC_ETH2CFGR,        10,    0),
>> +    GATE_CFG(GATE_USB2,        RCC_USB2CFGR,        1,    0),
> 
>     GATE_CFG(GATE_USBH,        RCC_USBHCFGR,        1,    0),

Ok

> 
>> +    GATE_CFG(GATE_USB2PHY1,        RCC_USB2PHY1CFGR,    1,    0),
>> +    GATE_CFG(GATE_USB2PHY2,        RCC_USB2PHY2CFGR,    1,    0),
>> +    GATE_CFG(GATE_USB3DR,        RCC_USB3DRCFGR,        1,    0),
>> +    GATE_CFG(GATE_USB3PCIEPHY,    RCC_USB3PCIEPHYCFGR,    1,    0),
>> +    GATE_CFG(GATE_PCIE,        RCC_PCIECFGR,        1,    0),

[...]


>> +    STM32_COMPOSITE_NODIV(CK_KER_USB2PHY1, "ck_ker_usb2phy1", 0,
>> +                  SECF_NONE, GATE_USB2PHY1, MUX_USB2PHY1),
>> +
>> +    /* USBH */
>> +    STM32_GATE(CK_BUS_USB2OHCI, "ck_icn_m_usb2ohci", "ck_icn_hsl", 0, GATE_USB2, SECF_NONE),
>> +    STM32_GATE(CK_BUS_USB2EHCI, "ck_icn_m_usb2ehci", "ck_icn_hsl", 0, GATE_USB2, SECF_NONE),
> 
> STM32_GATE(CK_BUS_USB2OHCI, "ck_icn_m_usb2ohci", "ck_icn_hsl", 0, GATE_USBH, SECF_NONE),
> STM32_GATE(CK_BUS_USB2EHCI, "ck_icn_m_usb2ehci", "ck_icn_hsl", 0, GATE_USBH, SECF_NONE),
> 
>> +
>> +    /* USB2PHY2 */
>> +    STM32_COMPOSITE_NODIV(CK_KER_USB2PHY2EN, "ck_ker_usb2phy2_en", 0,
>> +                  SECF_NONE, GATE_USB2PHY2, MUX_USB2PHY2),
>> +
>> +    /* USB3 PCIe COMBOPHY */

[...]

>> +#define RCC_ADC12CFGR                0x7E8
>> +#define RCC_ADC3CFGR                0x7EC
>> +#define RCC_ETH1CFGR                0x7F0
>> +#define RCC_ETH2CFGR                0x7F4
>> +#define RCC_USB2CFGR                0x7FC
> 
> #define RCC_USBHCFGR


Ok

> 
> Best regards,
> 
> Gabriel
> 
>> +#define RCC_USB2PHY1CFGR            0x800
>> +#define RCC_USB2PHY2CFGR            0x804
>> +#define RCC_USB3DRCFGR                0x808
>> +#define RCC_USB3PCIEPHYCFGR            0x80C
>> +#define RCC_PCIECFGR                0x810
