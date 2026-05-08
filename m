Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC4ACD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 788C084E64;
	Sat,  9 May 2026 02:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="vatnyzbB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E2484CF3; Fri,  8 May 2026 23:41:31 +0200 (CEST)
Received: from mxd-1-a0f.seznam.cz (mxd-1-a0f.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E57E084CE5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 23:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-lmwqj
 (smtpc-mxd-5f4d8d5f6f-lmwqj [2a02:598:128:8a00::1000:a0f])
 id 25a186dc7eafd2b524084a82; Fri, 08 May 2026 23:40:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778276449; bh=BFCasuzNhU8KlhxU7Sg1XQkqFqfG2V3hX0geT0cowKo=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=vatnyzbBA64WfVBkY1uZXNcmWjBBx7O3yLdnfLlyN3dB2mpbLFE69hAAXwbDsR/th
 3bHuOtOT6DSSTwz3t+RG2/LskFkKDqkRdMm36vHc83BOpwKNEHqyMUxOZMsMLjLbJK
 zISZbg7ri6JseXXNel6UewsyubqQFZ46xkEYEn8ZY4axwRdImB9bzHTi15hLUb9jx1
 OlmkEhpGbPmCpuun0XmBzX8ORZMG+Xq39hHKskjkUU6/ivUmvU7h4s7X/dw2yiLXLV
 zPhFLx7F0dAKQ4GmSUAwI9rcx2hdEGvbilRcyf4wVhMPVcmImaRPdG6fksoOwOUpm8
 Px2aIxm0ShHdQ==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-7c7c659656-xkdqp (szn-email-smtpd/2.0.72) with ESMTPA
 id 48959f6a-691e-4625-8211-27b551afb80a;
 Fri, 08 May 2026 23:39:48 +0200
Message-ID: <e48fd644-3ba1-4ebf-96d7-ba287604e817@seznam.cz>
Date: Fri, 8 May 2026 23:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/11] mach-snapdragon: boot0.h: split out
 msm8916_boot0.h
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260508-qcom_spl-v6-0-aaac1ab17b50@seznam.cz>
 <20260508-qcom_spl-v6-4-aaac1ab17b50@seznam.cz>
 <CAFLszTiMG3z6TqGc3D5=NdTVXgUFNekhKMyZNyKQPbVL4gL-1Q@mail.gmail.com>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <CAFLszTiMG3z6TqGc3D5=NdTVXgUFNekhKMyZNyKQPbVL4gL-1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:31 +0200
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

On 5/8/26 18:49, Simon Glass wrote:
> Hi Michael,
>
> On 2026-05-08T00:33:28, Michael Srba <michael.srba@seznam.cz> wrote:
>> mach-snapdragon: boot0.h: split out msm8916_boot0.h
>>
>> Prepare for supporting alternative boot0.h per-SoC by splitting out
>> the existing msm8916-specific code.
>>
>> There is now a selection mechanism to choose a specific boot0.h
>> in the Kconfig. BOOT0_MSM8916_PSCI_WORKAROUND is the only option
>> right now, but more can be added. The toplevel boot0.h additionally
>> enables conditionally performing the include only in u-boot proper,
>> or only in SPL.
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>>
>> arch/arm/mach-snapdragon/Kconfig                   | 16 ++++++
>>   arch/arm/mach-snapdragon/include/mach/boot0.h      | 60 +++-------------------
>>   .../mach-snapdragon/include/mach/msm8916_boot0.h   | 54 +++++++++++++++++++
>>   configs/dragonboard410c_defconfig                  |  1 +
>>   4 files changed, 79 insertions(+), 52 deletions(-)
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
>> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
>> @@ -11,6 +11,7 @@ CONFIG_ENV_OFFSET=0x0
>>   CONFIG_DEFAULT_DEVICE_TREE='qcom/apq8016-sbc'
>>   CONFIG_OF_LIBFDT_OVERLAY=y
>>   CONFIG_SYS_LOAD_ADDR=0x80080000
>> +CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND=y
>>   CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
> Do you need to see CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND=y in
> hmibsc_defconfig too? It looks like hmibsc_defconfig is also an
> apq8016 (msm8916) board with CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y, so it
> currently relies on the same PSCI workaround and will silently lose it
> after this patch. If not, it is worth mentioning in the commit
> message.
My bad, didn't realize that, will add it.
>> diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
>> @@ -1,54 +1,10 @@
>>   /* SPDX-License-Identifier: GPL-2.0+ */
>> -/*
>> - * Workaround for "PSCI bug" on DragonBoard 410c
> ...
>> +#if defined(CONFIG_SPL_BUILD)
>>        b       reset
>> -
>> -     .align  3
>> -el1_system_param:
>> -     .quad   0, 0, 0, 0, 0, 0, 0, 0, 0       /* el1_x0-x8 */
>> -     .quad   reset                           /* el1_elr */
>> -el1_system_param_end:
>> +#else
>> +#if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
>> +#include 'msm8916_boot0.h'
>> +#else
>> +     b       reset
>> +#endif
>> +#endif
> You could flatten this with #elif - which would make it more obvious
> that the SPL path is intentionally a stub.
>
>      #if defined(CONFIG_SPL_BUILD)
>          b       reset
>      #elif defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
>      #include 'msm8916_boot0.h'
>      #else
>          b       reset
>      #endif
It's not going to be a stub after the followup commit that adds the sdm845
behavior which should only be enabled in SPL though. It's a nested if
(sadly the code style for macros does't really make it obvious),
basically:

```

#if defined(CONFIG_SPL_BUILD)
     ... spl-only workarounds ...
#else
     ... u-boot-proper-only workarounds ...
#endif

```

I wonder if using CONFIG_IS_ENABLED would be cleaner, even though
in most cases the config option would only exist either with or without
the SPL_ prefix.
> Regards,
> Simon

