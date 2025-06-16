Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86946C71155
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 11:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E95F81E18;
	Mon, 16 Jun 2025 13:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="WoiVUQxc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2270829F5; Mon, 16 Jun 2025 13:35:17 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9466B81760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 13:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82620602e9=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8ZS3T015545;
 Mon, 16 Jun 2025 13:35:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 O+WmDO/XWLrEOW1f3iXQ8dq5Q8lUrpNDFHDRmzvt59I=; b=WoiVUQxcsOpSfAJ1
 8Th4aSU2rjD3HC6Gq02zRAW1LfLeR3Cfm/NB8oPh4BavCBbadBZJqbjTANq15GBx
 UJJUS06FlxZomcoidtIco84Kn55Iqld6Pz2VRsbuLGNPY/LHJkWi+LsUYWosHxoZ
 pIHGqz+yvQ/dSVQ598fhs3F5Kd32SiZQZU7FOJ1m70dDs2CucEpuXrGbHtZJ06+b
 c/mVWvcPwM9QDtN9HZJ3v35tMF4MfHgWWG/lU0WwMbV3eXiT7IIE/wIceW7ygyLD
 y+QPmzWoa0VuH6CUJeLf/WIOjw3xffKXi5uDikOtcc1RJlfFfFFRtUDkOwyP91Ve
 AJMXIw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47afw1gyyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 13:35:06 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E928040048;
 Mon, 16 Jun 2025 13:33:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED8C4AFAF09;
 Mon, 16 Jun 2025 13:33:16 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 13:33:15 +0200
Message-ID: <81ca59a9-361b-4712-a79d-ff6a856839e9@foss.st.com>
Date: Mon, 16 Jun 2025 13:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Restore support of short name for type UUID
 parameter
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <caleb.connolly@linaro.org>,
 <ilias.apalodimas@linaro.org>, <jerome.forissier@linaro.org>,
 <patrice.chotard@foss.st.com>, Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250602135935.232370-1-patrick.delaunay@foss.st.com>
 <20250612175836.GA237915@bill-the-cat>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250612175836.GA237915@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_05,2025-06-13_01,2025-03-28_01
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

On 6/12/25 19:58, Tom Rini wrote:
> On Mon, Jun 02, 2025 at 03:59:31PM +0200, Patrick Delaunay wrote:
>
>> V3 version solve issue for "ESP" support when
>> CONFIG_CMD_EFIDEBUG and CONFIG_EFI is not activated
>> for example for test with qemu-arm-sbsa defconfig
>>
>> Fix and add documentation/tests for selection by string for known
>> partition type GUID introduced by bcb41dcaefac ("uuid: add
>> selection by string for known partition type GUID"):
>>
>> - split list_guid for short name (used also for partiton
>>    description with type parameter) and full name to display
>>    information
>>
>> - as the function are uuid_str_to_bin() / uuid_guid_get_str()
>>    are no more under CONFIG_PARTITION_TYPE_GUID,  since commit
>>    31ce367cd100 ("lib/uuid.c: change prototype of uuid_guid_get_str()")
>>    and commit c1528f324c60 ("lib: compile uuid_guid_get_str if
>>    CONFIG_LIB_UUID=y") move the content of array under EFI_PARTITION
>>    and linker will remove it is not used it (in SPL)
>>
>> - Add and fix documentation for gpt command
>>
>> - Add test test_gpt_write_part_type to test "type=" parameters
>>
>> This first patch solves an issue for the "system" shortcut for ESP,
>> removed by commit d54e1004b8b1 ("lib/uuid.c: use unique name
>> for PARTITION_SYSTEM_GUID") but used in 2 location (at least):
>>
>> 1- board/samsung/e850-96/e850-96.env:10:
>>
>> partitions=name=esp,start=512K,size=128M,bootable,type=system;
>> partitions+=name=rootfs,size=-,bootable,type=linux
>>
>> 2- arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:1151
>>
>> 			case PART_ESP:
>> 				/* EFI System Partition */
>> 				type_str = "system"
>> ....
>> 			offset += snprintf(buf + offset,
>> 					   buflen - offset,
>> 					   ",type=%s", type_str);
>>
>>
>> Changes in v3:
>> - The definition for ESP = "system" partition in list_guid[]
>>    is no more under CONFIG_CMD_EFIDEBUG or CONFIG_EFI flags,
>>    and restore the initial level (always support for display)
>>    as it is done for MBR partition or when U-Boot is a UEFI
>>    loader (CONFIG_CMD_BOOTEFI).
> This still has CI failures:
> https://source.denx.de/u-boot/u-boot/-/jobs/1168239

Sorry for the remaining side effect.

After my last "24 HOURS OF LE MANS" week, I pushed a V4 series with 
correction in tests.

https://patchwork.ozlabs.org/project/uboot/list/?series=461114

To be sure, I also check the CI result, and now it is OK

https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/26699


Thanks,

