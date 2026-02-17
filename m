Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84155E9A037
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 19:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1327E83C32;
	Tue, 17 Feb 2026 20:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RGsBVGie";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J4w3YwJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B1683D2E; Tue, 17 Feb 2026 20:07:04 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBC9683AC5
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 20:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61HDqv0t2960656
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 19:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nv/Cpg+uMQgeys5kEYuG2gfOxmjWGIfEY0xwkhwNEQM=; b=RGsBVGieXfx15/JS
 oxDeBdJJoTkgKqoN1LkIDJZISwFdDkXvgMmKPPvX3Vr3ZxjE3bj7DY0N/HZcqIbi
 Ri/Rco8e1mqLUUaqEoinNNViDN72SQPB6Zumv4whR7zaTDmAbxU1PgsTNvNV8zf5
 Kz90H1wifTms9LeWSwQX7o07rRjX3z0Jf1qH64WBaPbJOeVx7ht/F/Z7lsgpK0iG
 VvjL4FD5LlB459RGZ7Bz6VaRn30CED56/nnqF4VFt31N/hZZj735uBPP8c8Nn+WC
 3MBZK4zIuBjjZ/Tx8rsdfETyUQliicRseTNL2KDE9DhCxO/5JLbLxO78AZJcsJr+
 jZ/OEQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6tmbgs4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 19:07:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c56848e6f53so2973079a12.0
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 11:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771355219; x=1771960019; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nv/Cpg+uMQgeys5kEYuG2gfOxmjWGIfEY0xwkhwNEQM=;
 b=J4w3YwJmBVwrzJpnEk3axIy3aEewz8mohEPZL38Djto8fyhrVG03wp6Qp9dYgjV5iD
 2yIzB0oeFf6c0BcEDGc2ANY1VRwGgf6q14yTdq2pi69aGXrVgqacc/CtI8DvnSN8zkjr
 7BwMWSLrd1geu8cxAmgdfgsvnlLLdPDddR05m//mG8A9aNKabPnwf4BBislizVGFlZrf
 y33e6rNHwPjcQ2y3f4mbgGRs2j5CohCc3ZziwbY3EOW07qsxndeYmQpE2C2WxWMge9Zo
 x2hJo1r5ncSnBHaCR9p9fx9Q1AehAoQKKI9VagNtcezt2rL6Q9x8Wwc56JY2Gc3dxGqE
 RoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771355219; x=1771960019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nv/Cpg+uMQgeys5kEYuG2gfOxmjWGIfEY0xwkhwNEQM=;
 b=Q6kzDcIp7SIIXL4u2ifNvaMWW4DljVl+yY0c0gogIa+9Zs14YSYTuOzQVBZ4aeiQSN
 /+/awCjO53oI6oCcwJhyg/oEfklE+411OSUu3tJk/tzuKHhWAErG9vpqrZo0na1O8wYF
 mv7JvLdyWVPPUGp3LoDfeX5l1IeYMGYb+L/Wu5vxfdZT0z11cEIaIOvKOd3Ob2VbX3E+
 XCF+M/bQkhS4sgh56dMB1xNgVfSyRBjyZsQ+o/ujA8U3Q/gi0+Pl3JrFf5qAP2Me2nDf
 rEJw3o15HjsaAGB79PqzrD8IjnRFMpUkwif+e2TlBXmm9EqjHtUrDDiZZOQ92VOMADe2
 MDng==
X-Gm-Message-State: AOJu0YwTToIFbuKIylpLHUnG4O4YEe3eb52foBuh/87jiiNZFYcvfMbN
 vBexjB66suBKwY569ppGdpUao3xIavrRsuwz0FcVZkeEcKuLhyp3lCG6pBLLpVexPq154DFvddr
 nlAXbPZeGWmL5XM/BCcVOjfN0rA4lQ9AE01sVUym9Pflz/G4+svdztpMS
X-Gm-Gg: AZuq6aIAhnkNBOEBoGSXFvO0JQl4O6EMmpJbonkVxmUT0sEXJy+3dUMlYCPPaK3joDG
 fCXvBn09m5m7ZjOMrKeENONwKrw6xlWsBu6b/OUjQ9adMvwrOlepf+KUZAAxgoj0Y82tu/FAoG3
 n1VhEIdljiIPoiHvY2x+NxR+lnEH4dpifKj7AUjdOGDVIUozeCo/59Q8hNVtQxcfXOYujEpFUEJ
 rfbKuem8ilKkVroxemlDU1MJt4vIxF03VWTBbgppvd1nkFbIXLZ6RqLLs7LToaC64eMRxR9tCDP
 4qS/eWIUe74dv8tTvtQEMXkauX2dDU8PPP9nVzEY/3OnXsBUX0idvGLKL9o144u9f8/u/3+fCuM
 0NRyFEQkjGgmPCnfkraot/plYiHA0HcuarvUYsM4EoTGm6NDDobeo8w==
X-Received: by 2002:a17:903:1109:b0:2a7:a5b3:bf51 with SMTP id
 d9443c01a7336-2ab50519037mr154225385ad.5.1771355219200; 
 Tue, 17 Feb 2026 11:06:59 -0800 (PST)
X-Received: by 2002:a17:903:1109:b0:2a7:a5b3:bf51 with SMTP id
 d9443c01a7336-2ab50519037mr154225095ad.5.1771355218691; 
 Tue, 17 Feb 2026 11:06:58 -0800 (PST)
Received: from [192.168.1.10] ([223.178.81.193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a9d5bc8sm107392205ad.60.2026.02.17.11.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 11:06:57 -0800 (PST)
Message-ID: <174996d6-a4c2-4cf2-b25d-b59a9d7dd767@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 00:36:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] firmware: psci: Refactor EFI runtime PSCI reset
 handling
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org,
 u-boot-qcom@groups.io, trini@konsulko.com, xypron.glpk@gmx.de,
 sjg@chromium.org, michal.simek@amd.com, gabriel.dalimonte@gmail.com,
 jan.kiszka@siemens.com, paul.liu@linaro.org, j-humphreys@ti.com,
 neil.armstrong@linaro.org, me@samcday.com, marek.vasut+renesas@mailbox.org
References: <20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com>
 <20260213110527.1254098-2-aswin.murugan@oss.qualcomm.com>
 <CAC_iWjKzr_nYSJft_HbkHB+F5UKiPBr3sdEZ5vc=gTT-p+WFMA@mail.gmail.com>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <CAC_iWjKzr_nYSJft_HbkHB+F5UKiPBr3sdEZ5vc=gTT-p+WFMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7VLdhxqDRfco4HlWzVckyXcL-Utj1jG8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1NiBTYWx0ZWRfXy79e3M8a/eJK
 eG3pHUHTTYaRZ0Tzt5Ay/6Ms+s/NxE6Zz5a+KDqSkXyH2Pr3J3/JCQ2JI0QutkbHxoFX0GT1oqe
 fDmA2YtezAT8tJTbl0S84IENJqmgEsZvNjRS6FoQ2HDCgmiuLPyiieJiwa2fVfRkHUllEuZwHXi
 hpE4vthFmV+5n5lEyUTc0q6yOm6z2okuPgJKeMSrYaSE/PhRNur5OknUueEuNOzbZ3LDu5kK6Ut
 /n6c9SuBi5u6KHQCqZPJyEmutq1rXWGZEerA1Px9FtcQMivh2FgZfaACxokx/YrvvoDQdZ8Iz3X
 j5Bq9wXGDSQglbE4aNpkzKXXVSlTQgoY2TAlhq1pc4Oykic/NiSvE+SOtSrTwagmnQ2b4MahMNm
 09YbBya9Zk+kjZ2S5+FzVbZA5raMThfkRo7M1lyK6psu4opr4ch9VoPZXgo5vTIjDmgDgi/IqlM
 VANrJL7F7ttGqgWulJQ==
X-Proofpoint-ORIG-GUID: 7VLdhxqDRfco4HlWzVckyXcL-Utj1jG8
X-Authority-Analysis: v=2.4 cv=IOoPywvG c=1 sm=1 tr=0 ts=6994bc54 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=8sQKdzLGWpe9X/dURiXpGA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7fsWOBP1pj9A8UCweA4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170156
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


On 2/13/2026 4:55 PM, Ilias Apalodimas wrote:
> Hi Ashwin
>
> On Fri, 13 Feb 2026 at 13:06, Aswin Murugan
> <aswin.murugan@oss.qualcomm.com> wrote:
>> The current PSCI-based EFI runtime reset implementation is always enabled
>> when CONFIG_PSCI_RESET is set, but it does not support the extra arguments
>> required for specialized reset modes. As a result, reboot requests such as
>> bootloader mode or EDL mode are ignored and fall back to a normal reboot.
>>
>> Add CONFIG_EFI_PSCI_RESET_RUNTIME to give platforms explicit control over
> Is there anything missing and you can't use EFI_HAVE_RUNTIME_RESET?
Thanks for the feedback, Ilias
This is a kernel‑level limitation based on drivers/firmware/efi/reboot.c 
[1] implementation in Linux. The efi_reboot function intentionally 
ignores the reboot data string and always passes NULL to ResetSystem. As 
a result, special reboot modes like "bootloader" or "recovery" aren’t 
forwarded through EFI_HAVE_RUNTIME_RESET.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/efi/reboot.c?h=v6.13#n46

>
>> the PSCI-specific EFI runtime reset path. This allows a platform to disable
>> U-Boot's PSCI reset handler when needed so that the kernel can perform the
>> reset with the correct arguments for special reboot modes.
>>
>> The option defaults to enabled to maintain backward compatibility with the
>> existing behavior.
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>> Changes in v3:
>> - Commit message has been updated, no change in code
>>
>> Changes in v2:
>> - As per review comments made default y for EFI_PSCI_RESET_RUNTIME config
>> ---
>>   drivers/firmware/psci.c | 4 ++--
>>   lib/efi_loader/Kconfig  | 8 ++++++++
>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index 2e3223e1c32..009c6153d0c 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -244,7 +244,7 @@ static void __maybe_unused do_psci_probe(void)
>>          uclass_get_device_by_name(UCLASS_FIRMWARE, DRIVER_NAME, &dev);
>>   }
>>
>> -#if IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET)
>> +#if IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME)
>>   efi_status_t efi_reset_system_init(void)
>>   {
>>          do_psci_probe();
>> @@ -266,7 +266,7 @@ void __efi_runtime EFIAPI efi_reset_system(enum efi_reset_type reset_type,
>>          while (1)
>>                  ;
>>   }
>> -#endif /* IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET) */
>> +#endif /* IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME) */
> You also have to adjust the RT config table in
> lib/efi_loader/efi_runtime.c, but I really think we should reuse
> EFI_HAVE_RUNTIME_RESET
EFI_HAVE_RUNTIME_RESET is enabled by default & depends on PSCI_RESET config,
So even if i disabled EFI_HAVE_RUNTIME_RESET  on defconfig it was 
overridden, since PSCI_RESET is enabled it was auto enabling it, hence 
introduced a new config CONFIG_EFI_PSCI_RESET_RUNTIME to control psci 
based EFI runtime reset control.

Thanks,
Aswin
>
> Cheers
> /Ilias
>>   #ifdef CONFIG_PSCI_RESET
>>   void reset_misc(void)
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index 13e44be1d06..3882de273bb 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -106,6 +106,14 @@ config EFI_HAVE_RUNTIME_RESET
>>          depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
>>                     SANDBOX || SYSRESET_SBI || SYSRESET_X86
>>
>> +config EFI_PSCI_RESET_RUNTIME
>> +       bool "EFI Runtime PSCI Reset Support"
>> +       default y if EFI_LOADER && PSCI_RESET
>> +       depends on ARM_PSCI_FW
>> +       help
>> +         Enable PSCI-based reset implementation for EFI runtime services.
>> +         This allows the OS to reset the system through EFI runtime calls.
>> +
>>   endmenu
>>
>>   menu "UEFI Variables"
>> --
>> 2.34.1
>>
