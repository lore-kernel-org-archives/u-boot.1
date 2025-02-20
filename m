Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57583C021AD
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 08:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F65801DE;
	Thu, 20 Feb 2025 09:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VVmK/ylm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E00980C98; Thu, 20 Feb 2025 09:21:58 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 603A9801CF
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740039714; x=1740644514; i=xypron.glpk@gmx.de;
 bh=sAfKXro8h3CNQSwNySWh9uVZRBcA/gtKafJbNrT7NJc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VVmK/ylmfaSbKmAnlT3nJNpNtgsiffALjKapwl4A+R/oHXm/nv60rkcw/ui5vFOD
 /B7GxLIXQYS9KMGAlH3psw9Vx5G8u6FA/oYS1ndL/PPTdEPofs6hG2cCRcTBp1ZNN
 vTHQ7sFR3LT5+7Z46OEVMSLrH0yPMFzFKqSIriOaSZkcdS6B9QBoud7cs3TH6gad/
 GoVHuRw/xapkp/fcWFx42r5TjEtM4ZTG1pbNSf5pR66AICkZVcDchYNLkDI/6WbcJ
 3uj6k3XjRg6O59EpLmtwJZO18lpAGV5Kn73qHsoy4pcmRh2QcV9HvkEIK/Up42Cm1
 StMTeKWGLYE3e4mHBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQj7-1tZByp0g2P-003ixN; Thu, 20
 Feb 2025 09:21:54 +0100
Message-ID: <6416d1a7-3221-4ea5-a88b-944f26af534f@gmx.de>
Date: Thu, 20 Feb 2025 09:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Make FDT extra space configurable
To: Pawel Kochanowski <pkochanowski@sii.pl>
Cc: u-boot@lists.denx.de, Gabriel Nesteruk <gnesteruk@sii.pl>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250210160727.30993-1-pkochanowski@sii.pl>
 <CAC_iWjKLOw9gUxt+KE1iSTVsTawBPDXy40exTH97s7=+Bf3HRQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKLOw9gUxt+KE1iSTVsTawBPDXy40exTH97s7=+Bf3HRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:prnRJyoY5cZY+7CyrTCcw00sf7y5b3GS1mJtBVfGeIvLBmp4EXd
 kUB5hPeB45wMTbScxXojnpfh5qCEEvDGIMLdr1Aw6JCiMA3lgbxjWQLoILdRbW8H0uJIYe8
 Uk8Xl3DCcl1nTjwdLCfvTdmdGv9HrxoCpw6WT/rNY/dpZ1G0IDdUe3X4ZSIe4HfElQw3Cm/
 vI44h84sTGEgY3oDR3o3g==
UI-OutboundReport: notjunk:1;M01:P0:pUzAYL6y4oE=;o532H0gWTbq0KyadsD1YL940RAG
 TFu1pgSDPwsvJipXRamLkb/H2ARIpGEsnDZV52iNVcpiy9mIp6vk/g66RkjYEmC8Q1tFNJVog
 L/z+7M10RV+hqAjOjDQiiTaq21jdhX843DZe5ZAM7r7AHBJ2TK961Dc1v2rt/YQFEJ17pEirJ
 Zgf/o2VUSrQdfPo1ZBYsYX8zVyTKOTMJGcieLGN8P3JvxlytapAYf3sHdmO4lQ6dNgoKnPRLp
 /I4F1KLQlGaJzlJBzS7jUH3V+ETGs0lG2VGTcSHIvL/kh4xpqtIUmbnw2gUA5Z3TMijWOcUr7
 zPgOO0tG8/dsH+r3h3czALjok9Tx3KFybX6yzl+E+E35NiAJXDOaSBd8f0c4sPlnlypDrQ9Qs
 Q5LmAhhxuIgr17RUuwvw1mUPjIuFuH/1ox2SfGNGnoLfOykyrxjHj6R7CNcoknuq2/QeX05s+
 X9FV88hIS0yEB6xOJiU4St+dGkV6wl0ZBHMjfgQN4KTXNE7FvQBN6Bevl6pYX5V8MRd/3xaJC
 CKc+rCJcyNhrJrUypFs9o9iLPSbl48Qwo87J07NYMmjVcqcSFiuESnab36/sTFQB7ALGWwplz
 UdiDdPO/Y7V9COe3Qr5DLapXyrroEEWlyEMsiKh6oUe8ejgQ1MajAeXbdHw86w9goc3u5S/zp
 XmBCCWeZOMeIdcK2kbA+KPTpU8FF2bEwxCLH+Vc5/0AuP0bCnHbnUuz/QQsyAOuqFe/PFmLIk
 0NNJAlQXvER4nyXzQAZw5y+p4CZbl08OWd1aUMG6Cj2ZTvfnJuWbU00i25RlUkIRBPo8LnKiG
 0JdRyUegeQwKgeqcqVJ7t7Plo8fhk75WcXZKQB4mZPNg73tBFap5qhkT6v5vUoCQbZPhqDvKF
 h8URZpE4q8PoEOqJCV/52uW5XuUJBfKI2TXpjcPyuUumS99a8pe1c0xA315HTv2vsG7LvI+P2
 0nACnDtDEH/YY5WsJBrW2VEjApQnxYlKCuSR2PBrnMXymNt95EDJ2d0aC7/zZxkwUXmc3ZngY
 L3TUz3ZpP8TgWeM1nxpn7nslHYFXQPps3wIeOe4FBRIq3wgbFk42fA8fItGYK7Mldf5P/Us99
 /16+gNh8eDxdP4ENcNloDC7bNuHvV4VJlpoe3s34jdSUUpq6Hc5j/vJeZSSMtcDUwEPNBy/85
 U3nOnA5G9+CuHoT4U6+5Ji+sMpt9kOUHoKvoQxrLtm1aXuQZrA1aBhi1zDB4vH5S1Yq7BusYn
 y3DEq7MxSi4Om9JuB4eiUK77PGdjoeDTr8DOkAprN2ugLRIWtACCd2CxGZkf11VelU0jWxu+G
 6Ig4zN50EAcBDcZL3oHeM+LrFPmjVGkXSZHk1Fbgzp1YXLwaDPAUOpdWN3yuiQFI3mOCGPH6g
 ijZLa3YdP67eCgaowXV4rbbof3EhCOcqSRTuCEEAnn7TmDgnwdLumm8aN9
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

On 2/20/25 07:58, Ilias Apalodimas wrote:
> On Mon, 10 Feb 2025 at 18:07, Pawel Kochanowski <pkochanowski@sii.pl> wr=
ote:
>>
>> From: Gabriel Nesteruk <gnesteruk@sii.pl>
>>
>> U-Boot currently reserves only 0x3000 bytes when copying the FDT
>> in `copy_fdt()`, which may not be sufficient if additional nodes
>> (such as FMAN firmware) are added later.
>>
>> This patch introduces a new `CONFIG_FDT_EXTRA_SPACE` Kconfig option
>> to allow users to define the amount of extra space reserved for FDT
>> expansion. The default remains 0x3000.
>>
>> This change prevents potential corruption when resizing FDT after
>> EFI boot, especially when firmware like FMAN requires additional
>> space.
>>
>> Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
>> Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
>> ---
>>   lib/efi_loader/Kconfig      | 9 +++++++++
>>   lib/efi_loader/efi_helper.c | 2 +-
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index d4f6b56afaa..bd2cbe995c9 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -586,6 +586,15 @@ config BOOTEFI_TESTAPP_COMPILE
>>            No additional space will be required in the resulting U-Boot=
 binary
>>            when this option is enabled.
>>
>> +config EFI_FDT_EXTRA_SPACE
>> +    hex "Extra space to allocate for FDT expansion"

Hello Pawel,

Is this problem really EFI specific? Wouldn't you have a similar problem
when booting via booti?

>> +    default 0x3000
>> +    help
>> +      Defines additional space (in bytes) reserved for expanding the
>> +      Flattened Device Tree (FDT) when passed to the EFI system.
>> +      Increase this value if your firmware (e.g., FMAN) needs to add
>> +      more data to the device tree after U-Boot relocation.
>> +
>>   endif
>>
>>   source "lib/efi/Kconfig"
>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
>> index 04b2efc4a3b..91b2a5b8653 100644
>> --- a/lib/efi_loader/efi_helper.c
>> +++ b/lib/efi_loader/efi_helper.c
>> @@ -477,7 +477,7 @@ static efi_status_t copy_fdt(void **fdtp)
>>           * needs to be expanded later.
>>           */
>>          fdt =3D *fdtp;
>> -       fdt_pages =3D efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
>> +       fdt_pages =3D efi_size_in_pages(fdt_totalsize(fdt) + CONFIG_EFI=
_FDT_EXTRA_SPACE);

This is not the only place where the configuration value needs to be
considered:

lib/efi_loader/efi_dt_fixup.c:171:
                               0x3000;

Could you, please, send a new revision of your patch.

Best regards

Heinrich

>>          fdt_size =3D fdt_pages << EFI_PAGE_SHIFT;
>>
>>          ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
>> --
>> 2.43.0
>>
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

