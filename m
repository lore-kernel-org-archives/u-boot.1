Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF526C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 13:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307598205A;
	Mon,  2 Jun 2025 15:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="0sVSOrPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1A3D82102; Mon,  2 Jun 2025 15:23:05 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36EE581D6A
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 15:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8248ff287b=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552AAUIp025771;
 Mon, 2 Jun 2025 15:22:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 NFRzpONjkzxInKD6B71SZTPTAP9ulp7F6Zl0fnX7Mg4=; b=0sVSOrPfhKoTz837
 u0XOy9CimrInU43HPqcAnbkDJqc+t6RPMRBzF5iOGw0NJXiAbhSeK06VcSyx0rxl
 e+YfspcJSgQr2PlfvwnIJH+uCsmHZpTZ9NQ+yLHzFkyYxk2vGQ9DYNgauECJD49m
 tv49kbVwcaM4EJmxYYDZobqzZsWwvIiQOn3CAP7awqz3BkIxFbzSMy+Y/+QNSekX
 7cSJXXR2p3omrENru/BQdqADBpbWdhv47AN2Ft3TXse+mATP6kEkGdI6pdMz/tcG
 dc6YvaI8678I94CsfwYJBal7b8TD72/ypSrDGBLGl2e4jJkx1UyprwUvNH/MpLKk
 tiIdUQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46yrngxsmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Jun 2025 15:22:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AB4CE40058;
 Mon,  2 Jun 2025 15:21:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EEF8BB5FE4D;
 Mon,  2 Jun 2025 15:20:27 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 15:20:27 +0200
Message-ID: <59d147bd-7772-4d49-8236-e2be61930bb0@foss.st.com>
Date: Mon, 2 Jun 2025 15:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Restore support of short name for type UUID
 parameter
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <caleb.connolly@linaro.org>,
 <jerome.forissier@linaro.org>, <ilias.apalodimas@linaro.org>,
 <patrice.chotard@foss.st.com>, Adriano Cordova <adrianox@gmail.com>, Casey
 Connolly <casey.connolly@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon
 Glass <sjg@chromium.org>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250523091140.149298-1-patrick.delaunay@foss.st.com>
 <20250530202740.GA4068177@bill-the-cat>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250530202740.GA4068177@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-06-02_01,2025-03-28_01
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

On 5/30/25 22:27, Tom Rini wrote:
> On Fri, May 23, 2025 at 11:11:37AM +0200, Patrick Delaunay wrote:
>
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
> This leads to failure in CI:
> https://source.denx.de/u-boot/u-boot/-/jobs/1151511
>

Hi, I understood problem,

it is the definition for "system" "EFI system partiton" under too 
restrictif compilation flag

so the test is OK only  if one flag is activated in:

- CONFIG_CMD_EFIDEBUG or

- CONFIG_EFI (for "U-Boot as UEFI application"=> "Support running U-Boot 
from EFI")


but not activated for QEMU or for nomal use case,

when U-Boot is a just EFI loader with CONFIG_CMD_BOOTEFI


my error on EFI compilation flags: CONFIG_EFI <=> CONFIG_CMD_BOOTEFI


I will send a V3  with a update to solve the issue


Patrick



