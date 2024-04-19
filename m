Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B2BC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11475887F2;
	Fri, 19 Apr 2024 14:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="C5pXkIXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4569C887ED; Fri, 19 Apr 2024 14:17:10 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60CDE887D2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43JAnGLM026843; Fri, 19 Apr 2024 14:17:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=flzRXeFzBTyzHDBcpShRTKRYvht2i71vtAXYSFBRrpg=; b=C5
 pXkIXiNvhQZ5ElH52wltozllImWBslrqMWrT2+IfDwpi5l4mXzNBt0SJhOiV4np8
 pyPycd7IUmX3QeQbgqs6lbgdk+yymmtDRHfZ+EbhxeOkhC9X/I+s3xSeZRbH0ihv
 3db3U/t/7JEwbb+trNzQ1QFUikfyaJKgRTprY06MaE3+mqqIECGeN8oqNY/Vs+Gg
 1E/u90B0yQYEzlyfUS19J3KTUFv9q2v5EyMcaeXS2tW9ONi1h5AAbvj7xTsiO1be
 /GsyvnXIDRX73w3kD7G8QFVshiWj5ySZXpBm5Vz2zBMIMeqQckPVrppy9umv6JAQ
 IZqRdA5MdJUI4N08vAiw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xfhcx44cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:17:06 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EA82840045;
 Fri, 19 Apr 2024 14:17:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 274932194FF;
 Fri, 19 Apr 2024 14:16:32 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:16:31 +0200
Message-ID: <6aff48e7-0b7e-4bae-a1fc-3a219350727a@foss.st.com>
Date: Fri, 19 Apr 2024 14:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/25] configs: stm32mp1: Enable BUTTON_GPIO flag for
 stm32mp15_basic_defconfig
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Grzegorz Szymaszek <gszymaszek@short.pl>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-4-patrice.chotard@foss.st.com>
 <3d9a3897-e454-43f9-a2af-202fd035a36a@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <3d9a3897-e454-43f9-a2af-202fd035a36a@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
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



On 4/17/24 11:04, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/9/24 17:01, Patrice Chotard wrote:
>> Enable BUTTON_GPIO flag for STM32MP15.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   configs/stm32mp15_basic_defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
>> index 005f1d55f80..2e22bf86000 100644
>> --- a/configs/stm32mp15_basic_defconfig
>> +++ b/configs/stm32mp15_basic_defconfig
>> @@ -97,6 +97,8 @@ CONFIG_TFTP_TSIZE=y
>>   CONFIG_USE_SERVERIP=y
>>   CONFIG_SERVERIP="192.168.1.1"
>>   CONFIG_STM32_ADC=y
>> +CONFIG_BUTTON=y
>> +CONFIG_BUTTON_GPIO=y
>>   CONFIG_SET_DFU_ALT_INFO=y
>>   CONFIG_USB_FUNCTION_FASTBOOT=y
>>   CONFIG_FASTBOOT_BUF_ADDR=0xC0000000
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 

Applied on u-boot-stm32/master 
