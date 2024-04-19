Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74813C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C0C8879F;
	Fri, 19 Apr 2024 14:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="s7jtaVqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F146788767; Fri, 19 Apr 2024 14:15:56 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67F7887C9
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J7tg74027245; Fri, 19 Apr 2024 14:15:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Hr7ZHTQzUsZB3ySGO7CATEB1iwLEvn4qm7TONJoZFRU=; b=s7
 jtaVqqTD7nM5ZG5iYtDPnz/n+EDyWEdToBGIq/xg7c5FuKtHkKmlu39sX6mPIcHj
 VI4VRvh4FfliDc2HeYb5xbFrhvuzMlgbiQvXK0aBmavF6nWHMjDuVppNpiEZPQuX
 WjT7LyzXL+CkaudZSZ6WXgHPMHW0FGkCajka3eMqsl5S3Pzob1K7fjdszJpqr26B
 Nqb7U42xB4OJUQO0XGqV3YYm3hsHZ4imgbn0GR2hNbT+SMfHGP6OQpgaEXqWoRsg
 LQwjLiGIuwVpuo3GZBuYjEf4cT7M2tHplBAVZ06LC6edo5CWMQ4m+U3jr3ZmXM95
 QYbFIoLluGVok7fIuqig==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m12915-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:15:53 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 68D5D4002D;
 Fri, 19 Apr 2024 14:15:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B2DCC21A204;
 Fri, 19 Apr 2024 14:15:32 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:15:32 +0200
Message-ID: <6c95bb23-fe56-494e-94c2-20fe42031ad6@foss.st.com>
Date: Fri, 19 Apr 2024 14:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp: cmd_stm32prog: add dependencies with
 USB_GADGET_DOWNLOAD
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@foundries.io>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240207141154.1.If0aa2d32c2ffde32ed1d87ab8a088db67bc2d25c@changeid>
 <CAL6CDMHrdnw1yZ6gB3ZQz-ivVERiMExnzfhPUjrLBC9-9dcFVg@mail.gmail.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAL6CDMHrdnw1yZ6gB3ZQz-ivVERiMExnzfhPUjrLBC9-9dcFVg@mail.gmail.com>
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



On 2/7/24 16:59, Igor Opaniuk wrote:
> On Wed, Feb 7, 2024 at 2:12 PM Patrick Delaunay
> <patrick.delaunay@foss.st.com> wrote:
>>
>> This patch avoids compilation issue when CONFIG_USB_GADGET is deactivated
>> in defconfig, with undefined reference to run_usb_dnl_gadget and to
>> g_dnl_set_product.
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>>  arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
>> index 8f91db4b46b9..589276282e44 100644
>> --- a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
>> +++ b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
>> @@ -17,6 +17,7 @@ config CMD_STM32PROG
>>  config CMD_STM32PROG_USB
>>         bool "support stm32prog over USB"
>>         depends on CMD_STM32PROG
>> +       depends on USB_GADGET_DOWNLOAD
>>         default y
>>         help
>>                 activate the command "stm32prog usb" for STM32MP soc family
>> --
>> 2.25.1
>>
> 
> Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

Applied on u-boot-stm32/master 
