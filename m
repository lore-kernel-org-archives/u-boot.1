Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE641C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC53588819;
	Fri, 19 Apr 2024 14:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="7YEhdfeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 716D88881C; Fri, 19 Apr 2024 14:30:55 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2CF58881E
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J9Drd2009768; Fri, 19 Apr 2024 14:30:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=qrPf81bX61yZ5Mp44A0UbcOXQUzUQ76+r05qn65rzY4=; b=7Y
 EhdfeSKH148foBGeNKwQFS2xHvmp4Ocdu2XV332F5QTQ32BgLIx/H+7pnO0B0oQN
 2dBKtUZanOcBNCfUO4hcqr6QURlRNpr7O/TLHlshA1K/iVps/A4WHUTMgibOEX0O
 qfd+iDkCZjSIBdhFSYs/QNCHEQfHe2zZM4xpb29kQb+4VkG8h9anSOcHGC63zcSN
 4tfb3voing9ivf24hO/piOf/eLwdEnl1J3BjWmlanN3zroywPx8tDcPFgyIt9jhq
 wDXGPPPsrU0kGbbMm8J8LQMjKkkPqPw0CFmWaIBK6FroXQCMbvSQfvN2+6ZYe0hY
 pHA2tq6yedTxc9ZZcGlg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xff64uv6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:30:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0518F40045;
 Fri, 19 Apr 2024 14:30:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A64C521ADA7;
 Fri, 19 Apr 2024 14:30:33 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:30:33 +0200
Message-ID: <8884ff8c-8f35-4ffd-a8b7-7e1f096c1276@foss.st.com>
Date: Fri, 19 Apr 2024 14:30:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 23/25] ARM: dts: stm32: Don't probe red led at boot for
 stm32mp157c-ed1-scmi-u-boot
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-24-patrice.chotard@foss.st.com>
 <ad7bf212-046c-46ec-b9ac-0b9e64236faf@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ad7bf212-046c-46ec-b9ac-0b9e64236faf@foss.st.com>
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



On 4/17/24 11:13, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/9/24 17:02, Patrice Chotard wrote:
>> red led and button dedicated to fastboot share the same gpio GPIOA13.
>> Led driver is probed early so the corresponding gpio is taken and
>> configured in output which forbid fastboot and stm32prog button usage.
>>
>> To avoid this, remove the "default-state" property from red led node.
>>
>> This will avoid to trigger the led driver probe() to configure the led
>> default state during startup.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp157c-ed1-scmi-u-boot.dtsi | 1 -
>>   1 file changed, 1 deletion(-)
>>
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 

Applied on u-boot-stm32/master 
