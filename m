Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DB4C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECB57800C2;
	Wed, 15 Jan 2025 14:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="tvscjRQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F7FA80214; Wed, 15 Jan 2025 14:09:28 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6749680040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3110841290=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FAcavA014666;
 Wed, 15 Jan 2025 14:09:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 p6l2VJzcvD/YkZ3iEEOu/34LQtXHhFKnIgghrRQhS0s=; b=tvscjRQkSUq74ZG+
 5vtDZ2THjJJXvbqTbJHshiGxXBlXdsgpaBirUW208rdCFyWZ9Uv0AzOEIDIo8fw2
 JWkysb4vLHbrJn9jYc0fXwIhFTsh4K5OXQXABdwXQaAyCpykkKX3vB/QGBZKL3KX
 jm83UvQTAF5QoDBBxmjWjCYbfTrE3W8rCRCpm1bP7GZCtYCByBHBFJbVgE5TVrW8
 kIxO5wf3uGHk2o5SnPgyztQz5ArSMPo7Q0glsL9NnPwjO2fMGl/11Og2ZGi/5aJw
 4uz1axDH6nGz2zhECJL+lEOV0bchulhdHn23V2olXp66vyeeZgwm301CHqZNOGC0
 JekIPw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4466tjswr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 14:09:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 08B854004A;
 Wed, 15 Jan 2025 14:08:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 80FC224FBFA;
 Wed, 15 Jan 2025 14:07:44 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 15 Jan
 2025 14:07:43 +0100
Message-ID: <cd370701-ffe6-4840-b5d9-63d8aaeb4fc3@foss.st.com>
Date: Wed, 15 Jan 2025 14:07:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] usb: dwc3-generic: Add STih407 support
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
 <20250114144528.1612168-5-patrice.chotard@foss.st.com>
 <366cef60-e32f-4557-9830-b1b642f0683f@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <366cef60-e32f-4557-9830-b1b642f0683f@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
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



On 1/14/25 15:53, Marek Vasut wrote:
> On 1/14/25 3:45 PM, Patrice Chotard wrote:
> 
>> +    /* glue init */
>> +    reg = readl(glue_base + CLKRST_CTRL);
>> +
>> +    reg |= AUX_CLK_EN | EXT_CFG_RESET_N | XHCI_REVISION;
>> +    reg &= ~SW_PIPEW_RESET_N;
>> +
>> +    writel(reg, glue_base + CLKRST_CTRL);
>> +
>> +    /* configure mux for vbus, powerpresent and bvalid signals */
>> +    reg = readl(glue_base + USB2_VBUS_MNGMNT_SEL1);
>> +
>> +    reg |= SEL_OVERRIDE_VBUSVALID(USB2_VBUS_UTMIOTG) |
>> +           SEL_OVERRIDE_POWERPRESENT(USB2_VBUS_UTMIOTG) |
>> +           SEL_OVERRIDE_BVALID(USB2_VBUS_UTMIOTG);
>> +
>> +    writel(reg, glue_base + USB2_VBUS_MNGMNT_SEL1);
> setbits_le32() , please fix globally.

Ok

> 
> Also, I am wondering if we're not overstuffing the dwc3-generic.c with too many disparate glue code shreds, and whether it isn't just about time to split the glue code parts out of it, into separate .c files. Thoughts ?

OK i will introduce a specific dwc3-sti.c glue wrapper. I just notice that dwc3-am62.c or dwc3-uniphier.c are typically what i have to do.
By the same occasion, it removes the need of patch 06/10 with REGMAP/SYSCON dependencies

Thanks
Patrice
