Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92570C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 16:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2EA18806E;
	Wed, 20 Mar 2024 17:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="s58fGwqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABF5F880A6; Wed, 20 Mar 2024 17:33:14 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA66087F3F
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 17:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3809a22167=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42KC11kp010576; Wed, 20 Mar 2024 17:33:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Od8oFifrnhejK5VS1xIeabyS/8N/WbflqddAmmV3xdM=; b=s5
 8fGwqbKz1IaLeHKXFw+9LYB7rxT1nppFpuIGpiWf/pA4velMzpvXIpbrEaaIYaM2
 RFvgEaCbO4Sr8gThSKbOxyqKSGKDHQTVPw/FOvkpd5Yn4DNgIQFs/DJIPdXrfXMV
 YfEC+M5ErT268XKXvHIgL8hhxVdPnPi/WKMz2XcoMjqhjUpuOgwdKUoC39Hyjwzd
 Yk/Q+fDKOT5vv+OnRzLTN+Ja2LPersxNmiFmfDUIv/x4WOwmIBGlY4dfXZlK+DeW
 N56+FckRn/KFZEjOxMrsIvAR64p55Ttg9vAE1VPaRBXGdmLzuM+Se95eLmIetwmk
 P4x7Vft/LL8jWsxT+Grg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ww36htdgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 17:33:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C31FE40048;
 Wed, 20 Mar 2024 17:33:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2EA3326BB43;
 Wed, 20 Mar 2024 17:32:44 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Mar
 2024 17:32:43 +0100
Message-ID: <597273b3-8a68-43fb-ae2d-3dd889334e55@foss.st.com>
Date: Wed, 20 Mar 2024 17:32:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Add absolute path to EFI_VAR_FILE_NAME
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: <u-boot@lists.denx.de>, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240320113051.1.If084ef69b9da34900391d0f0acc13475b250ce9f@changeid>
 <CAC_iWj+1j+WR0aCTLA9Z21j347FpT95t3iWZnJoPFhH5E9jScQ@mail.gmail.com>
 <84a8915f-ec97-4a1a-9acb-edae56ae5c97@gmx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <84a8915f-ec97-4a1a-9acb-edae56ae5c97@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.71]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
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



On 3/20/24 14:05, Heinrich Schuchardt wrote:
> On 20.03.24 12:53, Ilias Apalodimas wrote:
>> Hi Patrice,
>>
>> On Wed, 20 Mar 2024 at 12:31, Patrice Chotard
>> <patrice.chotard@foss.st.com> wrote:
>>>
>>> If the ESP partition is formatted in ext4, we got the following error :
>>>
>>> STM32MP>  setenv -e -nv -bs -rt -v OsIndications =0x0000000000000004
>>> GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
>>> Attributes: 0x7
>>> Value:
>>>      00000000: 04 00 00 00 00 00 00 00                          ........
>>> File System is consistent
>>> Please supply Absolute path
>>
>> This error message comes from ext4_common.c and it's ext4 specific. Do
>> you have any idea why this exists?
>> What happens to other filesystems? IOW does this change the behavior
>> of the existing code if it tries to write a file in FAT?
> 
> When reading a file with the ext4 driver leading '/' are ignored by
> removing them in ext4fs_find_file1(). It is really inconsistent that
> when writing a leading '/' is required.
> 
> We can simply remove the check in ext4fs_get_parent_inode_num(). I found
> no issues when saving to an ext4 file system with the check removed.
> 
> I will send a patch.

Ok thanks ;-)

> 
> Best regards
> 
> Heinrich
> 
>>
>> Thanks
>> /Ilias
>>
>>> ** Error ext4fs_write() **
>>> ** Unable to write file ubootefi.var **
>>> Failed to persist EFI variables
>>>
>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> ---
>>>
>>>   include/efi_variable.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/efi_variable.h b/include/efi_variable.h
>>> index 805e6c5f1e0..8d507460b20 100644
>>> --- a/include/efi_variable.h
>>> +++ b/include/efi_variable.h
>>> @@ -92,7 +92,7 @@ efi_status_t efi_query_variable_info_int(u32 attributes,
>>>                                           u64 *remaining_variable_storage_size,
>>>                                           u64 *maximum_variable_size);
>>>
>>> -#define EFI_VAR_FILE_NAME "ubootefi.var"
>>> +#define EFI_VAR_FILE_NAME "/ubootefi.var"
>>>
>>>   #define EFI_VAR_BUF_SIZE CONFIG_EFI_VAR_BUF_SIZE
>>>
>>> -- 
>>> 2.25.1
>>>
> 
