Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1D7C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 16:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B15A488657;
	Wed, 10 Jul 2024 18:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bzKW91qJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8188D88667; Wed, 10 Jul 2024 18:30:04 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAC7885F5
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 18:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a77cc73d35fso197134266b.0
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720629001; x=1721233801; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GPDfwEyeTeSSJWgDxEsWfCGhyTGBvUiBsXH4D0RcQCs=;
 b=bzKW91qJMnhoKQ13nOWszban0ADgnAXdoFzsm5DvYcSXQRmL9Y6JAhJRf7XM8Vw/jZ
 tnInjyfKfnyzAjm+6d/9xwmXKc5UxOTEVISJGWn1XrqTHUiWiP9XphOomKoW10e37GR0
 JoM0uFae+F1vBpR6dGCiP9I1pEoGkmwDNRlK7lnO+OxiWibDUbruPMecPorI4yAox+RB
 eS6ImOWOqHGV2VWGUCroLei0AxWJqJsaH4jUl5kxakYwMAXr71yrlArftkQgseEXfRCn
 4hf2CIa95EZjlnZpHGNK+N0B4UkIM3idpSH34E18iq3v9+Lrts+O7H6ESRDBIFFBDY7x
 QzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720629001; x=1721233801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GPDfwEyeTeSSJWgDxEsWfCGhyTGBvUiBsXH4D0RcQCs=;
 b=FhZgQO0E3p+S5IcVX+96eJ9GzT7IfdjPKnyMVnlbnyQotqSF0ez6xyZ8SFKdOs4kaz
 cNj2+a2kMa8hEnhmCrNt4oYvp1JXtZDrFehZxZLfw19dUtNcJvUxhVSHsiWorBnyOEOX
 pjsx0RpW6Bligz0GyZOqd2b4cr1BW3jn9fFAKGRgBBhp34B56vZzwkaKOjlUN+k/J2ny
 A9HLQFPMeIZphplsONDKC6TH7mvIGArIcQhcEtsYVZSaN5f1GyibjZAQLiZhsh+Kr2Pc
 SyYdtDGpHWQKVKn813U98QXSJl3dvOLZr+rFy2P88k/KtzkNKVJDJSkdLlDjtANWGH2O
 3kzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSfBqzhUoD4j5rigiVzwBXBnTR1WsI0aR2NMZ7t0+ClfdEbAJ/RMflphErH9t2A/Td1qp3GG7Ut5qKMrXA+pYyP2sjHA==
X-Gm-Message-State: AOJu0Yw/dnTysitR+fCNlWFHDUVXch0fyUaiYRJDMNGDQ+/1PStoxhY0
 Uz2Ca+kZJvO7s81fcevup1zC1pl2pyCJTBKp1Nb5em7tynczpFngm1V6kQ9kReg=
X-Google-Smtp-Source: AGHT+IEsjGZZz90fD7fXHe4z+73g6TLw83SamH4QC2k5ag9DoOkwyMroaRqim36TAR3BuFurVAQVjw==
X-Received: by 2002:a17:906:3e4d:b0:a72:afd9:6109 with SMTP id
 a640c23a62f3a-a798a2b25e3mr11365766b.16.1720629001314; 
 Wed, 10 Jul 2024 09:30:01 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7ff7c7sm172187766b.100.2024.07.10.09.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 09:30:00 -0700 (PDT)
Message-ID: <46851b9b-290e-4905-887f-2f4f92c943de@linaro.org>
Date: Wed, 10 Jul 2024 18:29:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/21] qcom: rpmh core and regulator support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
 <CAFA6WYM+GEBF3oUa+tk_Ss5mP_rVjavDE1chdpMkGSU1OsHehA@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYM+GEBF3oUa+tk_Ss5mP_rVjavDE1chdpMkGSU1OsHehA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 10/07/2024 13:33, Sumit Garg wrote:
> Hi Caleb,
> 
> On Tue, 9 Jul 2024 at 15:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> This series introduces support for the RPMh (Resource Power Manager
>> (hardened)) co-processor and associated regulator driver found on most
>> modern Qualcomm platforms (since ~2017).
>>
>> Even though most regulators are controlled via SPMI, the specific
>> regions on the PMICs for controlling the regulators are restricted and
>> can't be accessed by the Applications Processor (AP/HLOS). Instead,
>> these resources are proxied via the RPMh where they can be voted on by
>> multiple subsystems (Linux, the modem, and the other DSPs). This is done
>> for security (to protect clocks, power domains, and regulators that are
>> specifically relevant for the trustzone) as well as to simplify the
>> management of shared peripherals and to allow for handover of
>> peripherals like the USB controller.
>>
>> For U-Boot, our main concern is the regulators. Since all regulators on
>> the system are controlled via the RPMh, it is necessary to support it to
>> enable USB VBUS on some platforms, and may be needed for other
>> peripherals in the future.
>>
>> Communicating with the RPMh additional requires accessing the cmd-db
>> shared memory region, this contains key/value maps to determine the
>> address of specific resources on the RPMh.
>>
>> Introduce support for the cmd-db, the RPMh framework, and some of the
>> regulators that are necessary to enable USB VBUS on the RB5 development
>> board.
>>
>> These drivers are taken from Linux, then modified and simplified for
>> U-Boot. The original Linux drivers contain heavy optimisations related
>> to multithreading and asynchronous probing, as well as support for idle
>> and suspend states which we don't need to deal with here. This unused
>> code is removed before finally adjusting the drivers to properly build
>> for U-Boot and use its device model.
>>
>> The U-Boot version of the driver supports a single ACTIVE_ONLY TCS and
>> waits for it to be cleared after use. We don't support programming
>> low power states.
>>
>> ---
>> Changes in v4:
>> - Denote original Linux version in bitmap.h patch
>> - Rebased on Linux 6.10-rc6 and re-apply U-Boot changes preserving git
>>    history. Allowing for future changes to the Linux drivers to be ported
>>    over more easily.
>> - Add missing check to wait for the TCS to be cleared after use (seems
>>    we were just racing the RPMh before, oops!).
>> - Fix missing n_modes in pmic5_pldo regulator.
>> - Link to v3: https://lore.kernel.org/r/20240708-b4-qcom-rpmh-v3-0-846cc6c5b728@linaro.org
> 
> Thanks for doing this, this looks much better from a maintainability
> perspective. Although I am seeing a lot of patches saying adjustments
> and build fixes, I think you should have taken care of commits
> bisect-ability such that individual commits don't cause any build
> errors.

I'll send a v5 which holds off on adding the Kconfig/Makefile parts 
until after the code is adjusted, this will prevent breaking bisection 
and still make it easy for us to cherry-pick commits from Linux with 
some git magic.
> 
> FWIW, for the series:
> 
> Acked-by: Sumit Garg <sumit.garg@linaro.org>

Thanks,
> 
> -Sumit
> 
>>
>> Changes in v3:
>> - Don't call dm_scan_fdt_dev(), since DM core will scan.
>> - Link to v2: https://lore.kernel.org/r/20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org
>>
>> Changes in v2:
>> - Implement Neil's suggestions and fixes for SM8[56]50
>> - Slightly refactor cmd_db_init() for better abstraction.
>> - Improve logging (printf -> log_err/dev_err)
>> - Add missing error check in rpmh_regulators_bind()
>> - Link to v1: https://lore.kernel.org/r/20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org
>>
>> ---
>> Caleb Connolly (21):
>>        linux/bitmap.h: add bitmap_empty helper
>>        soc: qcom: import rpmh and cmd-db drivers from Linux
>>        soc: qcom: cmd-db: adjust headers for U-Boot
>>        soc: qcom: cmd-db: drop unused functions
>>        soc: qcom: cmd-db: replace cmd_db_ready() with cmd_db_init()
>>        soc: qcom: cmd-db: adjust for U-Boot API
>>        soc: qcom: rpmh-rsc: drop unused multi-threading and non-active TCS support
>>        soc: qcom: rpmh-rsc: adjust headers for U-Boot
>>        soc: qcom: rpmh-rsc: adjust probe for U-Boot
>>        soc: qcom: rpmh-rsc: remaining U-Boot API changes
>>        soc: qcom: rpmh: adjust headers for U-Boot
>>        soc: qcom: rpmh: drop unused functions
>>        soc: qcom: rpmh: U-Boot API changes
>>        power: regulator: import qcom-rpmh-regulator from Linux
>>        power: regulator: adjust headers for U-Boot
>>        power: regulator: qcom-rpmh-regulator: port over lineage_range helpers
>>        power: regulator: adjust structs for U-Boot
>>        power: regulator: qcom-rpmh-regulator: remove unused regulators
>>        power: regulator: qcom-rpmh-regulator: port ops to U-Boot
>>        power: regulator: qcom-rpmh-regulator: adjust probe for U-Boot
>>        qcom_defconfig: enable rpmh regulators
>>
>>   configs/qcom_defconfig                        |   5 +
>>   drivers/power/regulator/Kconfig               |   8 +
>>   drivers/power/regulator/Makefile              |   1 +
>>   drivers/power/regulator/qcom-rpmh-regulator.c | 544 ++++++++++++++++++++++++++
>>   drivers/soc/Kconfig                           |   1 +
>>   drivers/soc/Makefile                          |   1 +
>>   drivers/soc/qcom/Kconfig                      |  27 ++
>>   drivers/soc/qcom/Makefile                     |   4 +
>>   drivers/soc/qcom/cmd-db.c                     | 213 ++++++++++
>>   drivers/soc/qcom/rpmh-internal.h              | 138 +++++++
>>   drivers/soc/qcom/rpmh-rsc.c                   | 518 ++++++++++++++++++++++++
>>   drivers/soc/qcom/rpmh.c                       | 110 ++++++
>>   include/linux/bitmap.h                        |   8 +
>>   include/soc/qcom/cmd-db.h                     |  33 ++
>>   include/soc/qcom/rpmh.h                       |  28 ++
>>   include/soc/qcom/tcs.h                        |  81 ++++
>>   16 files changed, 1720 insertions(+)
>> ---
>> change-id: 20240611-b4-qcom-rpmh-fcfd32ac2940
>> base-commit: 50adc932e7aa34e6d9c738ec13ed09382a9d109a
>>
>> // Caleb (they/them)
>>

-- 
// Caleb (they/them)
