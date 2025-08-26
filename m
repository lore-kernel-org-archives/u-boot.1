Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3D1CA0FE9
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 12:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EF18830B4;
	Tue, 26 Aug 2025 14:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="qnyv+eyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B45DF83102; Tue, 26 Aug 2025 14:01:30 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77CDD830A0
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 14:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0333a46499=raphael.gallais-pou@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QBCJls019114;
 Tue, 26 Aug 2025 14:01:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 0FRrXFOpniyR4NZ7tR64hr27gtWsu+h/2xP3DO6XnJ4=; b=qnyv+eyBkRz0rCoO
 Hvy3+u6bzIGJ4vl8X6VizLk+kWqvRBbmzklDrpPopBD2cLHekelDTNOxDNxviJyG
 HLhVuwR9n4PPi7Nz/Op9f0whAMiDreOrlXkCXfIh9KCGaN9Y0oqGZN+iRIA6tX5Q
 a9OTHkEmVpwJvT77OEmuYMPzVlHkFZXNX/+mlqDvC9Vm3ZX7YTn4cqNxB0HJcjSH
 l77/cdYsOUqY9/BizKM5Pbx5L9RgBdPiTJyPYdzhE9j5ghLwYbOpONvKbuq5MVys
 HnXJq5VVNr794bfzrMbR3mWOg0cPJzR0FSDlP9MUP4CxdJRigG98g43jzCcPufWM
 O2kWlQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48qrkmgndm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 14:01:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 713F840053;
 Tue, 26 Aug 2025 14:00:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC23B6C6479;
 Tue, 26 Aug 2025 14:00:08 +0200 (CEST)
Received: from [10.130.74.180] (10.130.74.180) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 14:00:08 +0200
Message-ID: <0e4b1f64-8c6e-418d-9c1d-77625aa9e58c@foss.st.com>
Date: Tue, 26 Aug 2025 14:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] ARM: dts: stm32: remove panel property in
 stm32mp257f-ev1-u-boot
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>, Dillon Min
 <dillon.minfei@gmail.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250820-master-v1-0-fc76f18ab2fd@foss.st.com>
 <20250820-master-v1-7-fc76f18ab2fd@foss.st.com>
 <b071f211-38a8-4eef-94ce-e1b3d02ef929@foss.st.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <b071f211-38a8-4eef-94ce-e1b3d02ef929@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.130.74.180]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
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



On 8/25/25 15:54, Patrice CHOTARD wrote:
>
> On 8/20/25 18:17, Raphael Gallais-Pou wrote:
>> SCMI regulators are not yet implemented in OP-TEE.  This leads to an
>> invalid argument error when retrieving the 'power-supply' property.
>> Ultimately this chains into the panel not probing and makes the whole
>> display pipe fail.
>>
>> Remove the property in the upstream device-tree to allow display pipe to
>> boot.
>>
>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>> ---
>>  arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
>> index 9a566e18d3fd9b0cf4e21605f2cb060b49fadcb6..7a4b623664a1e167ccc0f4c73a979a083337d7a2 100644
>> --- a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
>> @@ -12,6 +12,10 @@
>>  	};
>>  };
>>  
>> +&panel_lvds {
>> +	/delete-property/ power-supply;
>> +};
>> +
>>  &usart2 {
>>  	bootph-all;
>>  };
>>
> This patch is a temporary patch right ?
> If yes, i am not in favor to applied this patch, i prefer to see that there is something missing.
>
> Thanks

Hi Patrice,

Yes it is temporary.  I will remove this patch from the upcoming series.
I understand your intention, just mind that the display pipe won't work until
STM32 OP-TEE gets SCMI regulators implemented.

Best regards,
Raphaël
