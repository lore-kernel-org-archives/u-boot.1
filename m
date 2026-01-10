Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717FBD277D1
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 08:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC24B8416E;
	Sat, 10 Jan 2026 09:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MlK23pHp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OysAxlPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE412841FF; Sat, 10 Jan 2026 09:30:16 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC7C84166
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 09:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60A4lW0T2489610
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 08:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Mv4+sex+0roVNsM++WASXOPdExzmz/giH/ejeEnIrq0=; b=MlK23pHpg6Jjh6fh
 oFCDtOgUG6ioWfYXk95DR2P2ef3B5WrqYRdqwdlhBv4zaUiN381PkX01Q/pfuDO8
 6pdzTEySVs5yijpQpLYI02vh09xTos7lDxlqiatZZdrSg+17jp/A5eIhTC6X6MNC
 6ITKbihs2ue/fIq66U5nF/ScW6LsfNq2qMCukUuN5jqlurpJ29vMDR3H0xWT67ke
 neu0l3+R01Hr7FuZtO0N7eDVmrjbqwfM8UVo2vx9JVqkIGrTOzfceW6sBCow/cFw
 mPvvUByIYS5MGXpgLQOoq+Hxj1ZsXQIG8RLLMR4wPK3MQbvV1oveQI5ATKZ1b9Le
 cL7dlw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkg25g91q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 08:30:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a0e952f153so122464895ad.0
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768033811; x=1768638611; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mv4+sex+0roVNsM++WASXOPdExzmz/giH/ejeEnIrq0=;
 b=OysAxlPRs1UIuIvWslv8aCFLdqva6dzucp/3XFijUpqez6pVWExiWlU1d3yCI/8DNU
 glcH+kEyT2nAwHjVrfrH3MuWFTJMVbzwc1CNphJMxZIzNWSH2ivgLBbV7m6TNxGJ1DLx
 +CyGrpV2laSVQuga2/6Io/XxABhDojTJ36LpMxpCC2uWTRTZclf41zQR0Wzn4UPuLg/O
 WOhy+xXDh/5Za1kPaBqWK97e+bM2KrXT46GZrcKF6c+HIwUM8OVRLu4I55XD0Gb7yrKr
 8XbLIQjFvpnzrKyLST5KvL8UXCeIsK4DpMaHDVC49wOiWqCOlb/vCDm4H89iTbCt/e2o
 JcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768033811; x=1768638611;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mv4+sex+0roVNsM++WASXOPdExzmz/giH/ejeEnIrq0=;
 b=ndVKnKY7mK0Zh6vNXdbghdxwg48oDDt7AR/1JwTewpQhx5HNZO6q+Zw5rRjZV9RFsZ
 xA46PC9lpHTyn7bkfQeScf7CLYxx9jlDTOwW83kszlpsMv+pnWVMmP12Ud8jBsGkX1YG
 MeyEx4zowsuonb1inG+PBpNM8jwNkmTReMfgaX8haOo4aVp0QuhJokw2iOepmt3TsjOi
 OaDt/bHzyu1FTHcDnX00YRVZg7ErMBwtrFBx2nxVFelGJ2jLqUeYtp6xa/fP0cgbd5Ok
 bUJ2iy6+d58SldOg//08A5Q50IuDCClQQQpvYkN3nCxd30+XPJjBb/amK6+JUyO67Scu
 L3vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Ry78YJnUs/GSqNJvsi3E9NQdHkGL4KEcG2Xn0vULaz9wUKT+oKdUXzBL001SNSrneGEmC2g=@lists.denx.de
X-Gm-Message-State: AOJu0YyEQggKDQA+PKhG9Uumv1uA2U4ePMuFnh5YXakQII1HOznX0GxV
 N9LyKa4ZNHBvfNfaXEx8EO2oYuh1YPIuz0CiRz3XoAJLkGTbXDB8b4kyozpadO/3gCaHvUoT4bL
 3VAsqsQNJ6X5hBECCfH9NeetAERh0iJQybK+oJEE1bRZ0yS+vHXYI9fsw
X-Gm-Gg: AY/fxX7CCBA+oO6pSdClSSqSAgXDYzVtj/z+4RQIgYmHIAGx+KwKELfQMYeqYAPl4HX
 hJLKHiUBzSU1a+s/firhYFiuwNgSc3YF+U5Crys19BsFIXgdwUYv0Gf8fbqSHE7WNtFS2wfrYZU
 ahNcekNeQPsMrMaKVnJHf8tcsojZUbwOsMtUpDPopwKBPaMiSmYtHb0tZbmIqGOejo0hYKeJGqd
 hQLvMEBnIkeT8bTOphrFCyh4/hz7NZGL77KqY/gg499xEQmEySpdfHqzmfPG7Q666LRwkTQTxIF
 j1rhzVkzd3Lu/kuVb8zoie4nUdf6pXivGoSYHEhCj7bGmB8mRcEVzC9wDqbi5ywJ3ySyXGerVN1
 KOgwcLi9l4DCaKsMX5e7m8puCmh/UweCFMgAHKM2rCc6zR+zo8mNirjBWwxer6fcPYWybpcfRJt
 2m
X-Received: by 2002:a17:903:4b4f:b0:295:3d5d:fe37 with SMTP id
 d9443c01a7336-2a3ee49a383mr128277275ad.41.1768033811357; 
 Sat, 10 Jan 2026 00:30:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOhqopjY4IP1dPMUPLWaDSnWqbFK7RaW1tPaO9AGpqJOEuDy2rpktiJGnqsbCITBSpkk/nhg==
X-Received: by 2002:a17:903:4b4f:b0:295:3d5d:fe37 with SMTP id
 d9443c01a7336-2a3ee49a383mr128276965ad.41.1768033810829; 
 Sat, 10 Jan 2026 00:30:10 -0800 (PST)
Received: from ?IPV6:2401:4900:889f:bdb2:8bb:58f5:b796:f2b5?
 ([2401:4900:889f:bdb2:8bb:58f5:b796:f2b5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2dd4sm121728145ad.47.2026.01.10.00.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 00:30:10 -0800 (PST)
Message-ID: <597c246c-113c-4b88-93bb-22ec5b525b55@oss.qualcomm.com>
Date: Sat, 10 Jan 2026 14:00:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/3] efi_loader: Introduce platform hook for FDT
 selection
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, adrianox@gmail.com,
 paul.liu@linaro.org, sjg@chromium.org, wolfgang.wallner@at.abb.com,
 javier.tia@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sGQ4EXe2uRItnIwdJC73pFDV2Qm9D447
X-Authority-Analysis: v=2.4 cv=P5g3RyAu c=1 sm=1 tr=0 ts=69620e14 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=XH6LIMRW9a-gzn3HtfQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=DjxkImh8gWEA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: sGQ4EXe2uRItnIwdJC73pFDV2Qm9D447
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEwMDA2OSBTYWx0ZWRfX2Jss3lDs+cB1
 1L/R7ku8sGGY/GovCVwycT95A53T/ih/O/1Mf3D8W7KIgSB+WtxmEMFyMPsju/VUxfIuGShfBNx
 iW2LFX2r3BgzlXaE9BL5t5oepRMvq96F4OD8h8sWxFZVP5hKHny1EvfkY42SOT1aRlFnnKsEqLo
 Bln5wwvmtSvQak/7ya+IstuN/UvT0v2P9zCuFflHqXE/om+3SJmke/Pe3XxRG61zKOQOZiYdns6
 nmvb0NcwpMpC6yhEVHXxsbdfyam28eiD3bN8eA5l8w/vCgUY1WfH5MI6AQM+lxDKYM1rXDxyH+F
 UseVMG7Ie6x6Y0SMPdTticITFrUgRCexzEczt0DxN2BtWBMXVEDIIRSrRiQOqbUk0sYE5WOJAp+
 0Afbk4cloj46ZW1hUvv9vL+jnMKvgB7q56kIgsRiJCjR/brmAARRqrNl/kYwl2HaM1vm9hQF6U9
 chE/svS+pS2Sp4oOIBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-10_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601100069
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

Thanks everyone for all the valuable feedback. I appreciate the detailed 
reviews and want to address the concerns raised.

I should have been clearer upfront about what makes Qualcomm platforms 
different here. Qualcomm has its own combined-dtb format that's been 
used across Linux products. The format is documented in [1] and the 
combined dtb file is placed in a separate dtb partition

The combined-dtb file contains multiple DTBs concatenated together as a 
single dtb file, each with Qualcomm-specific properties:
- qcom,msm-id (platform ID and SoC revision)
- qcom,board-id (board variant and subtype)
- qcom,pmic-id (PMIC models - up to 4)

At runtime, we read hardware info from SMEM (shared memory interface 
with the firmware) and match it against these properties to pick the 
right DTB.

*Why Existing Approaches Don't Quite Fit*

After reviewing the feedback from Heinrich, Ilias, Simon & Sumith, I 
realize the core issue is that all the existing U-Boot mechanisms assume 
separate DTB files on the ESP:

VisionFive2 approach: Uses EEPROM detection in SPL and sets `$fdtfile` 
to point to individual files like `dtb/starfive/jh7110-milkv-mars.dtb`, 
`dtb/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb`

eficonfig and distro boot: These mechanisms work great for selecting 
between multiple DTB files.

The common thread is they all expect individual DTB files, while 
Qualcomm's deployment model uses a single combined-dtb.dtb file that 
requires parsing and extraction. This is the fundamental gap we're 
trying to bridge.

  I agree with Simon that using the weak function approach is not an 
ideal solution. we should be avoiding adding hooks in the EFI loader. 
Instead, we need to handle this at the board level and work with the 
existing `$fdtfile` mechanism.

*Proposed Approach*

Based on all the feedback, here's the revised plan:
For v2:
1. In board code: Parse combined-dtb.dtb, extract the matching DTB, 
write to ESP as `dtb/qcom-<board>.dtb`
3. Set `$fdtfile` to point to the extracted file
4. Let standard EFI mechanisms handle the rest
5. Drop the weak function approach entirely

Does this approach address the concerns raised, or suggest a different 
direction? I'm particularly interested in feedback on runtime DTB 
extraction to ESP is acceptable, or if there's a better way to bridge 
between our combined-dtb format and U-Boot's expectations.

[1] 
https://docs.qualcomm.com/doc/80-70023-27/topic/configure_and_secure_boot_with_systemd_boot_and_uki.html#multi-dtb-support

Thanks,
Aswin

On 1/6/2026 5:51 PM, Aswin Murugan wrote:
> This RFC patch series introduces a weak function hook to allow platforms to
> provide custom device tree selection logic while keeping common EFI
> loader code generic.
>
> Background:
> Currently, EFI loader supports loading a single DTB file.
> Qualcomm platforms require special multi-DTB selection logic that:
> - Reads hardware information from SMEM (Shared Memory)
> - Selects the appropriate device tree from a combined DTB file based on:
>    * Platform ID (SoC variant)
>    * Board variant and subtype
>    * PMIC configuration
>    * SoC revision.
>
> Solution:
> Introduce `efi_load_platform_fdt()` as a weak function:
> - Weak implementation in lib/efi_loader/efi_fdt.c (defaults to no-op)
> - Called from efi_bootmgr_run() after efi_load_distro_fdt()
> - Qualcomm override in arch/arm/mach-snapdragon/efi_fdt_qcom.c
>
> Aswin Murugan (3):
>    efi_loader: Add platform hook for FDT loading
>    soc: qcom: smem: Added socinfo header file
>    mach-snapdragon: Implement Qualcomm multi-DTB selection
>
>   arch/arm/mach-snapdragon/Makefile       |   1 +
>   arch/arm/mach-snapdragon/efi_fdt_qcom.c | 339 ++++++++++++++++++++++++
>   include/soc/qcom/socinfo.h              | 114 ++++++++
>   lib/efi_loader/efi_fdt.c                |  34 +++
>   4 files changed, 488 insertions(+)
>   create mode 100644 arch/arm/mach-snapdragon/efi_fdt_qcom.c
>   create mode 100644 include/soc/qcom/socinfo.h
>
