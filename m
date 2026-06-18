Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A10CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 10:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41ADF8460E;
	Thu, 18 Jun 2026 12:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lmZLilUz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VuWwS5O9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACCB58495C; Thu, 18 Jun 2026 12:41:14 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 125AC80287
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 12:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8DgJ2692789
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 10:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jJUzhKwxX8efdtWVH5Xnl8HrrTSTg7bF1DaafRCbhFA=; b=lmZLilUzBmm8igRj
 jKD/OtwaSQdK+6K1jpuFOlQTof8zobrXpXHpCuVlJYLZ7iKxflaHhFwzeduudgBl
 /Qic0hPhLRvSJDpJafx+e4zSNfHWt4dzFDv0wxYM+uY5i8hf35tuZ19s48Wo9Izm
 1+5Pv7w2U/R8nWB1ix1JijKdvTxuomi7XjVU0t1monDK1lskRLgFCxpLYl2a7oSb
 8ztyXVz+UAGDMPLPkMuT1uevX90QPL/pgsDy9CScaRZrErDAUBWE4Zm6t52trzXk
 vGbSUx0oq9EAuQWJTdx6AHyE+Y5mdfRQN3na7DnzwXsV6L+ujHpBXVU2kDIx3G4Z
 eItvzQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2cc4yy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 10:41:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36bbcd40642so524701a91.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781779269; x=1782384069; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jJUzhKwxX8efdtWVH5Xnl8HrrTSTg7bF1DaafRCbhFA=;
 b=VuWwS5O9Tt6swenzM7ixvgRGzCxEwq8wjquhx6aAIJRZkT1/ZbPqxZz7HxzZiMc5VC
 uTinp3H4l5SYvywO52GHLDfe4LViGrjMLbbThv5/m1K1ooQd357KOBO01MZTaBcQIAzd
 BXLn0GVn9Qwd+0sFoCzezFhuoRT8HPU4ulmmFDRj+CGnhElJ8OEtaFIRuTPGt0HZ47Tf
 zW9TF9jrXhO3UgahYmCb/mvzRm1eP7tgp7Fc1TnliqKNdr8s6iuJgCsbx4bALBjjBGVc
 mWRoFVdTaxD5ua5cjWFs5pHJD+wi8K7Ky37Om4Z8qcrLaMDCM3Xkk8d5A1aZLO1NxeNd
 kApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779269; x=1782384069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jJUzhKwxX8efdtWVH5Xnl8HrrTSTg7bF1DaafRCbhFA=;
 b=SW6nsUvlAs0cj/LwSKGdabN/Tspgrl9jM8axZD1arJyz2/NkOlY/XA+eUnOrvR/oOT
 UO47XJuOVYSTZnGZh/Zg271NEGqn679+BHYqEmIUaGDTTB/nubp1I1QRm3F+beEO6DmT
 9okOxPuDG1q5vUzU2+9xvZvROb0nRybk14TPUOGE59tKMftw5HdXODsktKpT+6iRqFjx
 IeJ68Vx8Gu15m+u4RDYe9fZv+NCwdWNTv7VWNOTJx5My/hof9eX12ysjs6WXMEMLoHBQ
 mOGnTEKKN8z2HqgF+ePnZWwCimWPVfJrr3I72KGTyU17Kc5rwUBGQPoFG1VuAokjhks0
 ScWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cTWwHkPeTnf1vtINAfpA4gFhWZLqi6wQ5N4ohvYawSrLtSPwd3QvwGM41zpOLMc8zXVzE3Ro=@lists.denx.de
X-Gm-Message-State: AOJu0YxMEUjSHcYeQaqK6Sitr3oMoIdmR4l4im78xkjLLe85H8ooq8eh
 WTzevGkstMYvRU7KzssFN7QZjfSXOjHCvlQekD7XS2KGUn0dFXvw/fq//t5chWU6p2pMcat7hD/
 KPpZit6ro8zPlg51nwtNbH4ltxvk7Vfnu0VYb/yHqfgAb4omvGzOonDM0
X-Gm-Gg: AfdE7cmyzxtEXjDKgE0pZbuWy+mFJn8s8jpRrN5c6OSa4230AFvdpm+/4IkERGsCPOr
 X9xK0Q0DeGqDvsBA+oUq1HvweL/D3JLjNknanlXMexRrMpASjdYCLqO3WydXcB/L3vt2mP5h+cT
 oHUEMhhw369Bc7z4xxhBd9PvmF7iRlVzbDQAjUBFDKXjic1Te+ACxV83t7+/TsvyEMgOUlvWUDo
 IzB4SQwUck/zgsUfxcnRjF5aCYHTNCCVTXp2BA2v8YgZtYastrIYFBcims/WgVRZavGho1bqJAi
 z1rnPmgW954kUpd98W4f9sDZmqYefqjxqaMGkcbPo3sLzlFBfP7XnQce0Xg+aL7jLd427uIu84o
 J+aX7Zx+1T1qAMh+wjOMASuiBOCexNyHnzkFZ1J/ObxTQ6nsA
X-Received: by 2002:a17:90b:558c:b0:36d:81b3:61a1 with SMTP id
 98e67ed59e1d1-37c930d223cmr8262625a91.7.1781779269331; 
 Thu, 18 Jun 2026 03:41:09 -0700 (PDT)
X-Received: by 2002:a17:90b:558c:b0:36d:81b3:61a1 with SMTP id
 98e67ed59e1d1-37c930d223cmr8262574a91.7.1781779268790; 
 Thu, 18 Jun 2026 03:41:08 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866325d1d3sm16852880a12.11.2026.06.18.03.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:41:08 -0700 (PDT)
Message-ID: <76a72a67-6f36-493d-a5ea-b016b57ff0f1@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:11:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm: snapdragon: Add snagboot support for
 Lemans-EVK
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
 <64718934-b054-4c47-9d01-dc6fac01dbd7@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <64718934-b054-4c47-9d01-dc6fac01dbd7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5OSBTYWx0ZWRfX6vYKj8/Dm7uE
 0hBBUoIfMBdjouscEGoTyoygFJELedMPiTlasGADm7xfvUmH0pTrGtL/1/UOE4CtOWxg+fWyM4G
 PTB693AX0osJtprUlK5AA3Ut1+0MbXSwulmW8CYXr16iW7n9Kf1P0nDAHousPRP++dJWeFcCU0z
 Fh107+8fXdk2yFnYLiMd3cdKz1mh8lB/B8Yqcbl32aesI+Qz4Gg6jUdtwIzC1DRmWeV8NaIdL2x
 Ab6osUkWfte4UZgwL2D2y6T6qYVkukP/dWFgogAe1fU+kIFW1kCwuiJ0W0BprYfOd2INHckqVe+
 QJ8g1iN5vtATcYrI9v+zoVksgXI3iFwkRRQWgEHq+HVcK2/dXY2iccvAO23klmHY9/LzRDVsUum
 g6mhZqxPQptd+Yf5renCGC7e3m6U+mLa1g+bQxZCQTqwcq1r4Qa9A2eobbR4IOHBKBTZjSVoVvK
 saKV4Hjbo/fQ2FQNUtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5OSBTYWx0ZWRfX2H6kD4rVzndr
 4ZunueQ2PBmvsPtCHMhQDHkgf/5lZTghhJn8A7s97S5U01sgLRSIHPWkxibxzDghnzCbB1C0ywm
 plt7mAM45zc9TL5fIJUhCyRiTYiIkNQ=
X-Proofpoint-GUID: CVFwCkNIZ1hol1FU6ts8TyO2fDhM0W38
X-Proofpoint-ORIG-GUID: CVFwCkNIZ1hol1FU6ts8TyO2fDhM0W38
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a33cb46 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9pKMZOE_xSYK30fAqCMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180099
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

Hi Casey,

On 6/16/2026 5:56 PM, Casey Connolly wrote:
> Hi Balaji,
>
> On 16/06/2026 11:22, Balaji Selvanathan wrote:
>> This series adds support for running U-Boot in snagboot mode on
>> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.
> You didn't respond to my reply on v2 of this series.
Sorry, missed replying to you regarding v3 series.
>> Snagboot is an open-source, scriptable flashing framework that provides
>> an alternative to the proprietary Firehose protocol for device
>> provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
>> Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
>> and execute bootloaders. However, instead of using the proprietary
>> Firehose programmer, Snagboot loads U-Boot into DDR and uses the
>> standard fastboot protocol for device flashing.
> Glad to have some more info here. Please also add a doc page with this
> information as well as a list of supported platforms.
Sure, will include a patch having documentation in v4 respin.
>
> I would hope that this support will be expanded to other platforms, and
> I'll make that assumption with my feedback.
Yes, currently we are supporting for Lemans EVK. The plan is to to 
support other platforms in future.
>
>> The framework consists of three modular components: snagrecover
>> (downloads XBL/QCLib to initialize DDR and load U-Boot into RAM),
>> snagflash (communicates with U-Boot over USB using fastboot to flash
>> system images), and snagfactory (orchestrates parallel factory
>> flashing tasks).
>>
>> In the snagboot execution flow, ROM code in recovery mode loads
> recovery mode?? Please be consistent and just say EDL or boot ROM.

Sure.

Thanks,

Balaji

>
>> snagrecover, which downloads XBL to internal memory. XBL executes
>> and initializes DDR, then snagrecover downloads U-Boot into DDR and
>> transfers control to it. At this point, XBL has left the MMU enabled
>> with its own page tables and has not initialized PSCI firmware or
>> populated the Command DB. U-Boot must handle this non-standard boot
>> environment to enter fastboot mode for device flashing.
>>
>> This series addresses the specific requirements of the snagboot flow:
>>
>> Patch 1 changes SYSRESET_PSCI from 'select' to 'imply' so it can
>> be disabled on platforms where PSCI firmware is unavailable.
>>
>> Patch 2 guards show_psci_version() and qcom_psci_fixup() with
>> CONFIG_ARM_SMCCC to prevent build failures when SMCCC is disabled.
>>
>> Patch 3 adds CONFIG_QCOM_SNAGBOOT_SUPPORT option to enable snagboot
>> mode support on Qualcomm platforms.
>>
>> Patch 4 disables the MMU and invalidates TLBs at the earliest entry
>> point to clear stale page tables left by previous bootloader
>> before U-Boot sets up its own MMU.
>>
>> Patch 5 adds QCOM_COMMAND_DB_OPTIONAL to allow the CMD DB driver to
>> bind successfully when CMD DB data is not populated by XBL, logging
>> a warning instead of failing.
>>
>> Patch 6 adds qcom_lemans_snagboot_defconfig for Lemans-EVK, based
>> on qcom_defconfig with snagboot-specific settings.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v3:
>> - Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
>>    ifdef condition
>> - Moved the MMU disable codes to a new seperate file
>> - Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
>>    of #ifdef
>> - Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
>>    and SKIP_RELOCATE as they are now automatically enabled by
>>    QCOM_SNAGBOOT_SUPPORT selection
>> - Removed updating MAINTAINERS as the defconfig file is picked up by
>>    the "N: qcom" line
>> - Link to v2: https://lore.kernel.org/u-boot/20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com/
>>
>> Changes in v2:
>> - Changed SYSRESET_PSCI from 'select' to 'imply'
>> - Guard show_psci_version() and qcom_psci_fixup() with CONFIG_ARM_SMCCC
>> - Disables the MMU and invalidates TLBs at the earliest entry point
>> - Add qcom_lemans_snagboot_defconfig for Lemans-EVK
>> - Link to v1: https://lore.kernel.org/u-boot/20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com/
>>
>> ---
>> Balaji Selvanathan (6):
>>        arm: snapdragon: Make SYSRESET_PSCI optional
>>        arm: snapdragon: Guard PSCI functions with CONFIG_ARM_SMCCC
>>        arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_SUPPORT option
>>        arm: snapdragon: Disable MMU early before U-Boot reset vector
>>        soc: qcom: cmd-db: Allow boot without CMD DB data
>>        configs: add qcom_lemans_snagboot_defconfig for Lemans-EVK
>>
>>   arch/arm/Kconfig                                   |  2 +-
>>   arch/arm/mach-snapdragon/Kconfig                   | 13 ++++++
>>   arch/arm/mach-snapdragon/board.c                   |  6 +++
>>   arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 +
>>   .../mach-snapdragon/include/mach/snagboot_boot0.h  | 53 ++++++++++++++++++++++
>>   configs/qcom_lemans_snagboot_defconfig             | 45 ++++++++++++++++++
>>   drivers/soc/qcom/Kconfig                           | 18 ++++++++
>>   drivers/soc/qcom/cmd-db.c                          | 14 +++++-
>>   8 files changed, 150 insertions(+), 3 deletions(-)
>> ---
>> base-commit: e1c3db1f788ed8106840e81b795e030cbe0020b7
>> change-id: 20260616-sngboot-760714938d18
>>
>> Best regards,
