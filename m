Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C8DC54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 13:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D168287F4F;
	Wed, 20 Mar 2024 14:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cVSTIPoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FBAA87F4F; Wed, 20 Mar 2024 14:06:05 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559FC87E47
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710939960; x=1711544760; i=xypron.glpk@gmx.de;
 bh=B8mZfqkX1hF7Z/GcUQCfZ8oOcGH6nEQGxZbUmcKufVI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=cVSTIPoK0F2wgTx1U76WX+TXiuHgHsAxR7TashQ9WueDNyerWMKenQbMaIour1Wm
 cQXnJm/x7bqhfmLZIPx4sEN33G8HVcFnGXiSQHgCVKvID5CncC4835hVhw13Hrs3P
 Tf+qQWGL+hNu2roA9fFNZkBwTqOQ8dr3mSTmgJi84jATFmRMSi1ZhTu16IqaYY8s/
 HwdaM/jm4Ymw4jPZVDAbrDAWMPkgz63VzGniqDj51DRcpHnIWFa7Z0i/K+G0IRrf1
 eyihk4ODqgggLrT/gGuj37BFAEBJvqt1W3nILVfbqQpu+LkrcP8TNoMjJPEvtnYCF
 +/rmVEzA9wyrhgnMaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MulqD-1qveGS3TUZ-00rltH; Wed, 20
 Mar 2024 14:05:59 +0100
Message-ID: <84a8915f-ec97-4a1a-9acb-edae56ae5c97@gmx.de>
Date: Wed, 20 Mar 2024 14:05:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Add absolute path to EFI_VAR_FILE_NAME
Content-Language: en-US
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240320113051.1.If084ef69b9da34900391d0f0acc13475b250ce9f@changeid>
 <CAC_iWj+1j+WR0aCTLA9Z21j347FpT95t3iWZnJoPFhH5E9jScQ@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWj+1j+WR0aCTLA9Z21j347FpT95t3iWZnJoPFhH5E9jScQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:14sbWp/bE87MiEGfvwZ0pSYEWmZ3W5jTeFYAM/dAygdkK7or80Q
 cyOOXlK9QTTP/wHVps/RgUn5cKXI7hpmzKVbhcNualeRk8eWi+Ceei5o7/oN64g2ep5K4Hp
 4y9TPWRdJWAPherwUmlTvB+XczCvFhr10PW5c7fBGj/BIQD12uC7UfbEIxqltqJ7Q5QI0nX
 x2T3nO0EKR13oV98T9sfg==
UI-OutboundReport: notjunk:1;M01:P0:GyuGqn7qc2A=;ksGssXRchmSTmV/4+oydjHnIDCH
 l7bcSeR8jdfciPPJpAu4AuGVhuoqivlS7orBQHabyuQ3dM1ayxrnUMfeuIoPUOVtBv7Lx9nTd
 zBfZqITu1x/E/+fUX7VRVnB68Ybg5a9pj5F3gU8kACHbEaDV8feKD0XKoA0+BajytOGoPlNqW
 JOmN7L76hkp7NZ4lDw95z/W2kQss7ZuLdHmb+348aUBlax/0475YMmtJJSvK7o0Rlr6487OID
 gN/C+8Rov6MpIMcRVBznwe72c99wJgLYTQLgPCfoHJjE9F7lk4RUzVx7cwtjy+2yfCPwbHYu0
 LjU+X8G5Jv0B2xe+o7168L5i4at+gzEaU3MwpQHfvKGk1CbI2D7irGwu/P4etkYcakeQb8SH7
 vlWcByb0Vz2pTs6iWAj56xnTa7PcDJoJ26Y5X8aHxCBQwOsBT07U4fwmSUA/jsRVRpUf19zQM
 aI2kVSKZmwSF38Qaf3sv+ItweBc2jTSmQis85Ru1Sj5SNeO2PROWMUtrfvdAyanAGS4+9fhmK
 0UMb/UsUOl42Ggbnt1IJW+mEmISrOq7hdZFJ54y+kYZX0v3FINlm7qL7IbGGKSDJk0apkDddo
 f+U9SEhjv9dcTT+cxRSix6eGml4jLReiEcbFgc8A9d69D4Faou8JE+OCSItwFPVUWa1xHqSoU
 tQfk2w9AJIow951ksHPTiPWfCggvkbN8c9hnWIepdIIHpXdvFzBqG5ns5zmAHowWZqVrMXYSN
 qi+AdCCaVgG1D/uW1YHroYEDERtUMUGdI5fKBHGuQxV1gsmDY0W+nl2MizMFkwNila/TOlWlx
 rBXN17fqfFSCxdNQ4ilMu46Rm6ZAYaUVPETZOsFVIqfUc=
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

On 20.03.24 12:53, Ilias Apalodimas wrote:
> Hi Patrice,
>
> On Wed, 20 Mar 2024 at 12:31, Patrice Chotard
> <patrice.chotard@foss.st.com> wrote:
>>
>> If the ESP partition is formatted in ext4, we got the following error :
>>
>> STM32MP>  setenv -e -nv -bs -rt -v OsIndications =3D0x0000000000000004
>> GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
>> Attributes: 0x7
>> Value:
>>      00000000: 04 00 00 00 00 00 00 00                          .......=
.
>> File System is consistent
>> Please supply Absolute path
>
> This error message comes from ext4_common.c and it's ext4 specific. Do
> you have any idea why this exists?
> What happens to other filesystems? IOW does this change the behavior
> of the existing code if it tries to write a file in FAT?

When reading a file with the ext4 driver leading '/' are ignored by
removing them in ext4fs_find_file1(). It is really inconsistent that
when writing a leading '/' is required.

We can simply remove the check in ext4fs_get_parent_inode_num(). I found
no issues when saving to an ext4 file system with the check removed.

I will send a patch.

Best regards

Heinrich

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
>>   include/efi_variable.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/efi_variable.h b/include/efi_variable.h
>> index 805e6c5f1e0..8d507460b20 100644
>> --- a/include/efi_variable.h
>> +++ b/include/efi_variable.h
>> @@ -92,7 +92,7 @@ efi_status_t efi_query_variable_info_int(u32 attribut=
es,
>>                                           u64 *remaining_variable_stora=
ge_size,
>>                                           u64 *maximum_variable_size);
>>
>> -#define EFI_VAR_FILE_NAME "ubootefi.var"
>> +#define EFI_VAR_FILE_NAME "/ubootefi.var"
>>
>>   #define EFI_VAR_BUF_SIZE CONFIG_EFI_VAR_BUF_SIZE
>>
>> --
>> 2.25.1
>>

