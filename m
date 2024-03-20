Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6ECC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 16:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56A988065;
	Wed, 20 Mar 2024 17:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="7Fii+H53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DA108809E; Wed, 20 Mar 2024 17:32:37 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60FD879A0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 17:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3809a22167=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42KDQoSK027012; Wed, 20 Mar 2024 17:32:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=bwtz1ROjTY6rYcA0j+0/WZs4Zcs2r4O/sESEVRrr+bw=; b=7F
 ii+H53rZuso23jtDF5JdVtF63O0AgoMWQu4hKPNV+BEwdX1IpsaAuSQdUuNijN/x
 FYXHOR4lz/D3fQb+mp0jY4g4UAQPVqJMTGd91HlwRwZk6+HCaUK5TV0j0YOBz1ia
 iMHlHj3CroyA+zpouCHMfDSPM/m7vtGbSuuQhyEI24iRZOPSqM2tMXzOpxCLppZ8
 ZZ3cZxEkJ/l52ysmo1Ev10/XkT7VU5TMjRf0uYSKWBSY2n5bx5dHvOZU9dENCOBt
 ungaAnrkMpzxD/w/LTRmDQZh8b1+PNkQEsXjVCcvQ4BMB0XiIeSqGneRUYBKJHL5
 mUgkFNONz/CeHtPRrKZg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ww36htde3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 17:32:31 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CA62C4002D;
 Wed, 20 Mar 2024 17:32:27 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2599A26BB4A;
 Wed, 20 Mar 2024 17:32:07 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Mar
 2024 17:32:06 +0100
Message-ID: <61f43273-21fe-47c8-9b75-1a6766edab83@foss.st.com>
Date: Wed, 20 Mar 2024 17:32:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Add absolute path to EFI_VAR_FILE_NAME
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
References: <20240320113051.1.If084ef69b9da34900391d0f0acc13475b250ce9f@changeid>
 <CAC_iWj+1j+WR0aCTLA9Z21j347FpT95t3iWZnJoPFhH5E9jScQ@mail.gmail.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAC_iWj+1j+WR0aCTLA9Z21j347FpT95t3iWZnJoPFhH5E9jScQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 3/20/24 12:53, Ilias Apalodimas wrote:
> Hi Patrice,
> 
> On Wed, 20 Mar 2024 at 12:31, Patrice Chotard
> <patrice.chotard@foss.st.com> wrote:
>>
>> If the ESP partition is formatted in ext4, we got the following error :
>>
>> STM32MP>  setenv -e -nv -bs -rt -v OsIndications =0x0000000000000004
>> GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
>> Attributes: 0x7
>> Value:
>>     00000000: 04 00 00 00 00 00 00 00                          ........
>> File System is consistent
>> Please supply Absolute path
> 
> This error message comes from ext4_common.c and it's ext4 specific. Do
> you have any idea why this exists?
> What happens to other filesystems? IOW does this change the behavior
> of the existing code if it tries to write a file in FAT?

I made a try in FAT with this patch, and there is no issue.

Thanks
Patrice

> 
> Thanks
> /Ilias
> 
>> ** Error ext4fs_write() **
>> ** Unable to write file ubootefi.var **
>> Failed to persist EFI variables
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>  include/efi_variable.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/efi_variable.h b/include/efi_variable.h
>> index 805e6c5f1e0..8d507460b20 100644
>> --- a/include/efi_variable.h
>> +++ b/include/efi_variable.h
>> @@ -92,7 +92,7 @@ efi_status_t efi_query_variable_info_int(u32 attributes,
>>                                          u64 *remaining_variable_storage_size,
>>                                          u64 *maximum_variable_size);
>>
>> -#define EFI_VAR_FILE_NAME "ubootefi.var"
>> +#define EFI_VAR_FILE_NAME "/ubootefi.var"
>>
>>  #define EFI_VAR_BUF_SIZE CONFIG_EFI_VAR_BUF_SIZE
>>
>> --
>> 2.25.1
>>
