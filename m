Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3B2CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2071E8469F;
	Sat, 23 May 2026 14:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RH3fwrWm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RHWG3XJo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC336846CF; Sat, 23 May 2026 14:11:41 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8347E83E81
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64N51sRT492287
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 12:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7+1FYiLpfeOi5o5D2e3Wg9EFCiUX/4aR1jIcl3FnjQw=; b=RH3fwrWmSo1Zp9br
 +761t3kxqzhUDLJnJcCOxh+eCKd2f8LlBBVuD0iEu9klKxczmSkzkPVseqgRgBx7
 DYimBLxrt5zo75Md4vT/TwR/fYU2i7t18K5cHmx366YeB1dVrTjz6QKXVf8m75Wu
 2aFedBCDriPO9fEQrWCjUYTxNXwFvHns09pjpL7k+coUckw/3WhYqd+H8dpS/O1S
 T664HWD5y+9oTuFzjFGlOmwDHlAIyoasdWvVfFiwAV+oTPMdj9j5QXeK8F5pCWLR
 Q+S5VA6/bWMh7AJST1PZgdNOj7ct5vrgGCM3MXfEnkGz+B1Cb1NhpAIQKu+MafLN
 hQpMbw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4asrup9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 12:11:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-365e70c39d0so7775473a91.0
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779538294; x=1780143094; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7+1FYiLpfeOi5o5D2e3Wg9EFCiUX/4aR1jIcl3FnjQw=;
 b=RHWG3XJogETRUURAhqWhBwOdLbQ77Xlrd4vAc7xqjI9REQZs1H8CND1qygSobMQf/L
 ksDC4ig9ZDe1MZBWAAlKUjdoAMI5z+NNpqVm0FoA9+xLfBufNHId3RftyYH4Pr9NV3Gg
 0n8ThnbXFx2ssj5UnCTQxqVo+TPyuQojDUCSmxiDOO4vCWoO8fRwGCYUFD950xgI7Hhu
 2G8sZiorZ1bTJcZ6MShHQ1N9BzJ/mfpMQYufPE+moGCxXRaC+dEP2hAuwtSrfOF0oc38
 ABs2oXBw1tM3qfdyZqsu4eYbsUsB8njuJ+IY8eQr3evzzpdjURp9nG3GxRBzlDW+/Qr5
 +khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779538294; x=1780143094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7+1FYiLpfeOi5o5D2e3Wg9EFCiUX/4aR1jIcl3FnjQw=;
 b=eu7U0QIVYejqD8yILhdwUWgN9aNpvNTCeeoUuXA46nmF89owd3pGlTiotEHARIDcAz
 yoIyZxG0pHC4lE222YU0u7H6IPWAdXQmp0J66j2qrf+QiTmaI9HqgU54sUiudtoQ4l3t
 UPGC2+JOqwReawYB55b63SZ5jm6q0fztWx1bf5QhRT6PKwGeDqGEv6JmaPRJIBJMBXk0
 kKHep9+aQkRh5ke0bD1N/roIyZcXJuse2GpwnrR6P8qDqXSKTimT6p6YlTFeQpXH5evX
 0qmPH8R1OAgJW7BElnBV5hir9L2Kso3/RJGjBz/96zULRUcVginvqAmau/TSi3OGc68d
 qOFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DKV9rsYHAwW5B4NcuZdzLj7XgbwOWqix82n7CjuaqW6pjT+fHSXor/eEX4XjQRySI76Qy35I=@lists.denx.de
X-Gm-Message-State: AOJu0YwZU2oRCeejq/Ethq/RDrKF+IFiMyweGSe322UiLIM73FEQzHKU
 wsWHut79Go2SJf4imrsDDtdxjKS3cIXXBZV/X79WiSV8Rc6mK5g6Qi2/zLuucluwjioV/yOaBhh
 5E2o4hJRv9dvaFw3HAIs9Fb6HR0tsnptIhiYSb5ALK1zyjC6MRFZTehVx
X-Gm-Gg: Acq92OE0zvquVAjVZWpxp6qvWy7AG+5vmw/2BDQ75A2DRoiiBmbcpjyl14HXU6z4ype
 T5HiljwqEZX6RlcqjLSWbNI6UKAuifDUqC7+DB+qa18JPHbz+BQOLV7uxJOiX5lrNxf1+YYDSHR
 CecFx0Lar0W1RpbIFZO+lZfBlmJPBntpgvjkyIpzV7b5+X4AbHDSmuVw1Dizp/Haa3NTAmikJBY
 vrGAcLEg1I66dpcEaeuCcyG6HMElB4Bt2oaGBxFGTK4UHk4iY3pRynn4pknAVUI1cj8hi/lJsfG
 arMX4aGlJco+0nhSwY6yAUViFLwAtey9j+Ak9rwW38xhlwi0Y2f8M79XAYoDiSsHt12QL8kzYm6
 OG8S9bqVkerSKSLU+tFQSrF/vNYq0zjB+3nt8ZUj3cvsdOAigs3YnV8o6CjMytA==
X-Received: by 2002:a17:90b:4b51:b0:369:971:4883 with SMTP id
 98e67ed59e1d1-36a674f49bemr7099708a91.17.1779538293319; 
 Sat, 23 May 2026 05:11:33 -0700 (PDT)
X-Received: by 2002:a17:90b:4b51:b0:369:971:4883 with SMTP id
 98e67ed59e1d1-36a674f49bemr7099682a91.17.1779538292593; 
 Sat, 23 May 2026 05:11:32 -0700 (PDT)
Received: from [192.168.29.107] ([49.37.194.159])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a725d0109sm6030894a91.17.2026.05.23.05.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 May 2026 05:11:32 -0700 (PDT)
Message-ID: <37b24004-5080-43cd-923d-8db6d09f40ed@oss.qualcomm.com>
Date: Sat, 23 May 2026 17:41:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <20260522-capsule-v1-1-ff0ac9978d48@oss.qualcomm.com>
 <CAC_iWj+VQyO1Zy+mPqcQJY91aEFsrwXFT4dbObejar0fDpCaSg@mail.gmail.com>
 <a4b3eeed-0789-4bec-b29f-d13e3e3b3016@oss.qualcomm.com>
 <CAC_iWjLQxOVb7H-Mib7NAYLmzumhL5uBi8dZ_ufCksJMrcQ8OQ@mail.gmail.com>
 <89329f38-d2c5-4014-a1e1-44ccfd09b3bd@linaro.org>
 <242ab545-c274-4b65-afa9-2c3ab056a918@oss.qualcomm.com>
 <CAC_iWjK_U_TtNJsXjgVggXa28iHb9212tEQEdQn8wK2XqXmJiQ@mail.gmail.com>
 <19959cc3-40f6-4e9e-801d-8f7c40edbf70@oss.qualcomm.com>
 <CAC_iWjJSNekv73X0n3G-qPjh60F88R=CHybxHzBUo1DDgGzrqg@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CAC_iWjJSNekv73X0n3G-qPjh60F88R=CHybxHzBUo1DDgGzrqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDEyNSBTYWx0ZWRfX+nlSi9mbTeqq
 ToLeGC1pnDSM+upuLo3TFsVetRlP0hQ4dKBf0lMArhzeydqQums4wxbhUmov7sWi3wsZowfEhnO
 8W53Lfd1cj0n/kgYgqjJxpryztLh8i7KMYi4EaLsapr2Rw9h1jCX2xuwWZ0qNsYgDKExorSwpAP
 44rFbUZQaT6e0w2JDMjs06qAc6D5nUAyOSCzklqG2dJ6EpblX56dLd2is2mgZBkUzRKwmOkOEs7
 p5ORyaHLdYzdo77sRKipyEn0kVJSRgnLafg+SfQeKWbg/qAAEhzX9pnMesTGlBgMbApVC+0U+MG
 I2G2AS7W90fQ5L7ERbdLDa86aM1Obq/HLnWZzSlTrkxkmdxd//iMlotY6iVNk+PnyyBslyGQv0j
 64JVK/q0C7RT8sI8WjXDexNe9ja1QPictNyPzPzIc7SCIeN4Esd0j4vbRdTm6pszyTotgx7pnQm
 +b33/7/CsMxnuT9fcyg==
X-Proofpoint-ORIG-GUID: 9STOPggJkIkRusvBBpHP1upNJ_6qU6EY
X-Proofpoint-GUID: 9STOPggJkIkRusvBBpHP1upNJ_6qU6EY
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a119976 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=czfGDYr5FNGaVIOEFowgsA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=5Sx-rYHGYh4nBGlp2GsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605230125
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

Hi Ilias,

On 5/23/2026 5:06 PM, Ilias Apalodimas wrote:
> On Sat, 23 May 2026 at 12:49, Balaji Selvanathan
> <balaji.selvanathan@oss.qualcomm.com> wrote:
>> Hi Ilias,
>>
>> On 5/23/2026 1:36 PM, Ilias Apalodimas wrote:
>>> Hi Balaji,
>>>
>>> On Sat, 23 May 2026 at 08:26, Balaji Selvanathan
>>> <balaji.selvanathan@oss.qualcomm.com> wrote:
>>>> Hi Ilias, Casey,
>>>>
>>>> On 5/22/2026 7:09 PM, Casey Connolly wrote:
>>>>> On 22/05/2026 10:58, Ilias Apalodimas wrote:
>>>>>> Hi Balaji,
>>>>>>
>>>>>> On Fri, 22 May 2026 at 11:46, Balaji Selvanathan
>>>>>> <balaji.selvanathan@oss.qualcomm.com> wrote:
>>>>>>> Hi Ilias,
>>>>>>>
>>>>>>> On 5/22/2026 12:18 PM, Ilias Apalodimas wrote:
>>>>>>>> Hi Balaji,
>>>>>>>>
>>>>>>>>
>>>>>>>> On Fri, 22 May 2026 at 09:09, Balaji Selvanathan
>>>>>>>> <balaji.selvanathan@oss.qualcomm.com> wrote:
>>>>>>>>> Add comprehensive FIT capsule update support for Qualcomm platforms
>>>>>>>>> alongside existing RAW capsule implementation. The new FIT support
>>>>>>>>> enables multi-partition firmware updates with automatic partition
>>>>>>>>> discovery.
>>>>>>>> I am not sure I am following this one? What are you trying to achieve
>>>>>>>> here? Have a single capsule for all hardware?
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>> /Ilias
>>>>>>> Current qcom capsule update codes (in mach-snapdragon/capsule_update.c)
>>>>>>> has support to update only U-Boot partition (so the capsule's payload
>>>>>>> just has U-boot binary).
>>>>>>>
>>>>>>> We want to extend that support to update multiple partitions, not just
>>>>>>> U-Boot. We want to achieve this by using existing FIT based framework
>>>>>>> (in efi_firmware.c).
>>>>>>>
>>>>>>> So, we create a fit with each node of the FIT containing binaries of a
>>>>>>> firmware. This fit we will place in the capsule's payload.
>>>>>> Yes but the question is why FIT specifically? The efi capsule code for
>>>>>> raw images can do the same thing and they better adhere to the UEFI
>>>>>> spec. All you have to do is define those extra partitions and their
>>>>>> respective dfu command. We already have examples of boards updating
>>>>>> multiple partitions.
>>>>> Agreed, this was something I considered when implementing this
>>>>> originally. The partition detection code of course needs changes for
>>>>> this but there's no reason to use FIT here.
>>>> Hi Ilias, Casey,
>>>>
>>>> Thanks for the feedback. I would like to highlight following advantages
>>>> I see with the approach introduced in this series:
>>>>
>>>> 1. Based on your comments and my analysis of the code, I understand that
>>>> RAW capsules can handle multi-partition updates by creating multiple
>>>> separate capsule files - one capsule per firmware partition. Each
>>>> capsule would have:
>>>>
>>>> - Its own unique GUID (identifying the target partition)
>>>> - A single binary payload
>>>> Is this understanding correct? If so, this would require users to manage
>>>> and deploy multiple capsule files (e.g., uefi_a.capsule, tz_a.capsule,
>>>> xbl_a.capsule, etc.).
>>> No that's not correct. A single capsule can contain as many GUIDs you
>>> want during the capsule creation
>> While the UEFI capsule format theoretically supports multiple images via
>> payload_item_count, the current efi_firmware_raw_set_image()
>> implementation doesn't parse multiple image headers - it expects a
>> single binary payload. Also , using the current mkeficapsule tool, we
>> can create a capsule using only 1 firmware image.
>>
>> To support multi-image RAW capsules, we would need to:
>>
>> 1. Enhance mkeficapsule to create multi-image capsules?
> There's an equivalent tool in EDKII that can produce a capsule with
> multiple payloads. There were also patches posted for mkeficapsule,
> but need some minor tweaks to merge them
Can you please point me those patches? I did a search myself, but 
couldnt find those patches.
>
>> 2. Enhance efi_firmware_raw_set_image() to parse FMP capsule headers and
>> extract multiple binaries?
> That's already supported
Ohokay, will check the codes.
>
>>>> In contrast, the FIT-based capsule approach uses a single capsule file
>>>> to update multiple firmware binaries simultaneously, with the FIT image
>>>> serving as a container that bundles all firmware components together.
>>>>
>>>> 2. The FIT approach (introduced in this series) eliminates hardcoded
>>>> partition names: the current Qualcomm RAW capsule update code (in
>>>> capsule_update.c) hardcodes partition names like "uefi" in the source
>>>> and searches for matching partitions on the device, whereas the
>>>> FIT-based method stores partition names as FIT node names within the
>>>> capsule itself, allowing the same U-Boot binary to work with different
>>>> partition naming schemes without code modification.
>>> The UEFI spec does't use names during the update. That's an artificial
>>> limitation of your current implementation. The capsule code just looks
>>> at the index and the DFU command to update the proper partitions.
>> You're correct that the capsule code uses index and DFU commands.
>> However, in the current Qualcomm implementation, the DFU string itself
>> is built by searching for hardcoded partition names like 'uefi' in the code:
>> if (!strncmp(info.name, "uefi_", strlen("uefi_"))) {
>>       // Build DFU string with this partition
>> }
> I haven't looked at the code but that sounds like an implementation
> detail, that's used to *build* the dfu string dynamically for Qualcomm
> platforms. You'll still need that regardless of FIT/RAW capsules,
> since you have to define the dfu command. OTOH, you can statically
> define that dfu string per platform and remove that part.

Okay, will look into this.

Thanks,

Balaji

> Cheers
> /Ilias
>> Regards,
>>
>> Balaji
>>
>>> Thanks
>>> /Ilias
>>>> Regards,
>>>>
>>>> Balaji
>>>>
>>>>>> Thanks
>>>>>> /Ilias
>>>>>>> Regards,
>>>>>>>
>>>>>>> Balaji
>>>>>>>
>>>>>>>>> Refactor qcom_configure_capsule_updates() to use compile-time
>>>>>>>>> mutual exclusivity between CONFIG_EFI_CAPSULE_FIRMWARE_FIT and
>>>>>>>>> CONFIG_EFI_CAPSULE_FIRMWARE_RAW using #elif preprocessor directives.
>>>>>>>>>
>>>>>>>>> Add board-specific FIT capsule GUIDs for QCS615, QCS6490, and Lemans
>>>>>>>>> platforms with automatic board detection from device tree compatible
>>>>>>>>> strings. Each board uses a unique GUID to prevent cross-board
>>>>>>>>> flashing accidents.
>>>>>>>>>
>>>>>>>>> The FIT implementation discovers all SCSI/eMMC partitions across
>>>>>>>>> multiple devices, applies A/B selection logic based on GPT vendor
>>>>>>>>> attributes, and generates a comprehensive DFU string for
>>>>>>>>> multi-partition updates.
>>>>>>>>>
>>>>>>>>> A single ESRT entry represents all partitions for simplified firmware
>>>>>>>>> management.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>>>>>>>> ---
>>>>>>>>>      arch/arm/mach-snapdragon/capsule_update.c | 740 ++++++++++++++++++++++++++++--
>>>>>>>>>      arch/arm/mach-snapdragon/qcom-priv.h      |  23 +
>>>>>>>>>      2 files changed, 712 insertions(+), 51 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
>>>>>>>>> index 586682434b7..d803c46f38d 100644
>>>>>>>>> --- a/arch/arm/mach-snapdragon/capsule_update.c
>>>>>>>>> +++ b/arch/arm/mach-snapdragon/capsule_update.c
>>>>>>>>> @@ -8,30 +8,55 @@
>>>>>>>>>
>>>>>>>>>      #define pr_fmt(fmt) "QCOM-FMP: " fmt
>>>>>>>>>
>>>>>>>>> -#include <dm/device.h>
>>>>>>>>> -#include <dm/uclass.h>
>>>>>>>>> +#include <command.h>
>>>>>>>>>      #include <efi.h>
>>>>>>>>>      #include <efi_loader.h>
>>>>>>>>>      #include <malloc.h>
>>>>>>>>>      #include <mmc.h>
>>>>>>>>> -#include <scsi.h>
>>>>>>>>>      #include <part.h>
>>>>>>>>> +#include <scsi.h>
>>>>>>>>> +#include <dm/device.h>
>>>>>>>>> +#include <dm/uclass.h>
>>>>>>>>>      #include <linux/err.h>
>>>>>>>>> -
>>>>>>>>>      #include "qcom-priv.h"
>>>>>>>>>
>>>>>>>>>      /*
>>>>>>>>> - * To handle different variants like chainloaded U-Boot here we need to
>>>>>>>>> - * build the fw_images array dynamically at runtime. These are the possible
>>>>>>>>> - * implementations:
>>>>>>>>> - *
>>>>>>>>> - * - Devices with U-Boot on the uefi_a/b partition
>>>>>>>>> - * - Devices with U-Boot on the boot (a/b) partition
>>>>>>>>> - * - Devices with U-Boot on the xbl (a/b) partition
>>>>>>>>> - *
>>>>>>>>> - * Which partition actually has U-Boot on it is determined based on the
>>>>>>>>> - * qcom_boot_source variable and additional logic in find_target_partition().
>>>>>>>>> + * Capsule update support with conditional FIT vs RAW implementation:
>>>>>>>>> + * - FIT capsules: Comprehensive partition discovery with dynamic fw_images
>>>>>>>>> + * - RAW capsules: Existing single-partition approach with static fw_images
>>>>>>>>>       */
>>>>>>>>> +
>>>>>>>>> +#ifdef CONFIG_EFI_CAPSULE_FIRMWARE_FIT
>>>>>>>>> +#define MAX_DFU_STRING_SIZE 2048
>>>>>>>>> +#define MAX_PARTITION_GROUPS 64
>>>>>>>>> +#define MAX_PARTITIONS_PER_LUN 64
>>>>>>>>> +#define MAX_PARTITIONS_TO_SCAN 128
>>>>>>>>> +#define MAX_LUN_GROUPS 16
>>>>>>>>> +
>>>>>>>>> +struct qcom_partition_info {
>>>>>>>>> +       char name[32];              /* "uefi_a", "boot_b", etc. */
>>>>>>>>> +       char base_name[32];         /* "uefi", "boot", etc. */
>>>>>>>>> +       char slot_suffix[4];        /* "_a", "_b", or "" */
>>>>>>>>> +       int lun;                    /* SCSI LUN number */
>>>>>>>>> +       int partition_num;          /* Partition number within LUN */
>>>>>>>>> +       bool is_active;             /* From GPT vendor attributes */
>>>>>>>>> +       bool is_bootable;           /* From GPT vendor attributes */
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +struct partition_group {
>>>>>>>>> +       char base_name[32];
>>>>>>>>> +       struct qcom_partition_info *a_slot;
>>>>>>>>> +       struct qcom_partition_info *b_slot;
>>>>>>>>> +       struct qcom_partition_info *no_slot;
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +struct lun_group {
>>>>>>>>> +       int lun_number;
>>>>>>>>> +       struct qcom_partition_info *partitions[MAX_PARTITIONS_PER_LUN];  /* Max partitions per LUN */
>>>>>>>>> +       int partition_count;
>>>>>>>>> +};
>>>>>>>>> +#endif /* CONFIG_EFI_CAPSULE_FIRMWARE_FIT */
>>>>>>>>> +
>>>>>>>>>      struct efi_fw_image fw_images[] = {
>>>>>>>>>             {
>>>>>>>>>                     .image_index = 1,
>>>>>>>>> @@ -39,18 +64,26 @@ struct efi_fw_image fw_images[] = {
>>>>>>>>>      };
>>>>>>>>>
>>>>>>>>>      struct efi_capsule_update_info update_info = {
>>>>>>>>> -       /* Filled in by configure_dfu_string() */
>>>>>>>>> +       /* Filled in by qcom_configure_capsule_updates() */
>>>>>>>>>             .dfu_string = NULL,
>>>>>>>>>             .num_images = ARRAY_SIZE(fw_images),
>>>>>>>>>             .images = fw_images,
>>>>>>>>>      };
>>>>>>>>>
>>>>>>>>> +#ifdef CONFIG_EFI_CAPSULE_FIRMWARE_RAW
>>>>>>>>>      enum target_part_type {
>>>>>>>>>             TARGET_PART_UEFI = 1,
>>>>>>>>>             TARGET_PART_XBL,
>>>>>>>>>             TARGET_PART_BOOT,
>>>>>>>>>      };
>>>>>>>>>
>>>>>>>>> +enum ab_slot {
>>>>>>>>> +       SLOT_NONE,
>>>>>>>>> +       SLOT_A,
>>>>>>>>> +       SLOT_B,
>>>>>>>>> +};
>>>>>>>>> +#endif /* CONFIG_EFI_CAPSULE_FIRMWARE_RAW */
>>>>>>>>> +
>>>>>>>>>      /* LSB first */
>>>>>>>>>      struct part_slot_status {
>>>>>>>>>             u16: 2;
>>>>>>>>> @@ -61,26 +94,6 @@ struct part_slot_status {
>>>>>>>>>             u16 tries_remaining : 4;
>>>>>>>>>      };
>>>>>>>>>
>>>>>>>>> -enum ab_slot {
>>>>>>>>> -       SLOT_NONE,
>>>>>>>>> -       SLOT_A,
>>>>>>>>> -       SLOT_B,
>>>>>>>>> -};
>>>>>>>>> -
>>>>>>>>> -static enum ab_slot get_part_slot(const char *partname)
>>>>>>>>> -{
>>>>>>>>> -       int len = strlen(partname);
>>>>>>>>> -
>>>>>>>>> -       if (partname[len - 2] != '_')
>>>>>>>>> -               return SLOT_NONE;
>>>>>>>>> -       if (partname[len - 1] == 'a')
>>>>>>>>> -               return SLOT_A;
>>>>>>>>> -       if (partname[len - 1] == 'b')
>>>>>>>>> -               return SLOT_B;
>>>>>>>>> -
>>>>>>>>> -       return SLOT_NONE;
>>>>>>>>> -}
>>>>>>>>> -
>>>>>>>>>      /* Shamelessly copied from lib/efi_loader/efi_device_path.c @ 33 */
>>>>>>>>>      /*
>>>>>>>>>       * Determine if an MMC device is an SD card.
>>>>>>>>> @@ -98,6 +111,25 @@ static bool is_sd(struct blk_desc *desc)
>>>>>>>>>             return IS_SD(mmc) != 0U;
>>>>>>>>>      }
>>>>>>>>>
>>>>>>>>> +#ifdef CONFIG_EFI_CAPSULE_FIRMWARE_RAW
>>>>>>>>> +/*
>>>>>>>>> + * RAW Capsule Support
>>>>>>>>> + */
>>>>>>>>> +
>>>>>>>>> +static enum ab_slot get_part_slot(const char *partname)
>>>>>>>>> +{
>>>>>>>>> +       int len = strlen(partname);
>>>>>>>>> +
>>>>>>>>> +       if (partname[len - 2] != '_')
>>>>>>>>> +               return SLOT_NONE;
>>>>>>>>> +       if (partname[len - 1] == 'a')
>>>>>>>>> +               return SLOT_A;
>>>>>>>>> +       if (partname[len - 1] == 'b')
>>>>>>>>> +               return SLOT_B;
>>>>>>>>> +
>>>>>>>>> +       return SLOT_NONE;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>      /*
>>>>>>>>>       * Determine which partition U-Boot is flashed to based on the boot source (ABL/XBL),
>>>>>>>>>       * the slot status, and prioritizing the uefi partition over xbl if found.
>>>>>>>>> @@ -156,7 +188,7 @@ static int find_target_partition(int *devnum, enum uclass_id *uclass,
>>>>>>>>>                              * flags might not be set so we assume the A partition unless the B
>>>>>>>>>                              * partition is active.
>>>>>>>>>                              */
>>>>>>>>> -                       if (!strncmp(info.name, "uefi", strlen("uefi"))) {
>>>>>>>>> +                       if (!strncmp(info.name, "uefi_", strlen("uefi_"))) {
>>>>>>>>>                                     /*
>>>>>>>>>                                      * If U-Boot was chainloaded somehow we can't be flashed to
>>>>>>>>>                                      * the uefi partition
>>>>>>>>> @@ -263,7 +295,7 @@ static int find_target_partition(int *devnum, enum uclass_id *uclass,
>>>>>>>>>             }
>>>>>>>>>
>>>>>>>>>             /* Found no candidate partitions */
>>>>>>>>> -       return -1;
>>>>>>>>> +       return -ENOENT;
>>>>>>>>>
>>>>>>>>>      found:
>>>>>>>>>             if (desc) {
>>>>>>>>> @@ -278,18 +310,7 @@ found:
>>>>>>>>>             return partnum;
>>>>>>>>>      }
>>>>>>>>>
>>>>>>>>> -/**
>>>>>>>>> - * qcom_configure_capsule_updates() - Configure the DFU string for capsule updates
>>>>>>>>> - *
>>>>>>>>> - * U-Boot is flashed to the boot partition on Qualcomm boards. In most cases there
>>>>>>>>> - * are two boot partitions, boot_a and boot_b. As we don't currently support doing
>>>>>>>>> - * full A/B updates, we only support updating the currently active boot partition.
>>>>>>>>> - *
>>>>>>>>> - * So we need to find the current slot suffix and the associated boot partition.
>>>>>>>>> - * We do this by looking for the boot partition that has the 'active' flag set
>>>>>>>>> - * in the GPT partition vendor attribute bits.
>>>>>>>>> - */
>>>>>>>>> -void qcom_configure_capsule_updates(void)
>>>>>>>>> +static void configure_raw_capsule_updates(void)
>>>>>>>>>      {
>>>>>>>>>             int ret = 0, partnum = -1, devnum;
>>>>>>>>>             static char dfu_string[32] = { 0 };
>>>>>>>>> @@ -297,7 +318,6 @@ void qcom_configure_capsule_updates(void)
>>>>>>>>>             enum uclass_id dev_uclass;
>>>>>>>>>
>>>>>>>>>             if (IS_ENABLED(CONFIG_SCSI)) {
>>>>>>>>> -               /* Scan for SCSI devices */
>>>>>>>>>                     ret = scsi_scan(false);
>>>>>>>>>                     if (ret) {
>>>>>>>>>                             debug("Failed to scan SCSI devices: %d\n", ret);
>>>>>>>>> @@ -339,7 +359,625 @@ void qcom_configure_capsule_updates(void)
>>>>>>>>>                     debug("Unsupported storage uclass: %d\n", dev_uclass);
>>>>>>>>>                     return;
>>>>>>>>>             }
>>>>>>>>> -       log_debug("DFU string: '%s'\n", dfu_string);
>>>>>>>>>
>>>>>>>>> +       log_debug("RAW DFU string: '%s'\n", dfu_string);
>>>>>>>>> +
>>>>>>>>> +       /* Set RAW configuration state */
>>>>>>>>> +       update_info.dfu_string = dfu_string;
>>>>>>>>> +       update_info.images = fw_images;
>>>>>>>>> +       update_info.num_images = ARRAY_SIZE(fw_images);
>>>>>>>>> +
>>>>>>>>> +       log_info("RAW capsule update configured (single partition: %s)\n",
>>>>>>>>> +                target_part_type == TARGET_PART_UEFI ? "uefi" :
>>>>>>>>> +                target_part_type == TARGET_PART_XBL ? "xbl" : "boot");
>>>>>>>>> +}
>>>>>>>>> +#endif /* CONFIG_EFI_CAPSULE_FIRMWARE_RAW */
>>>>>>>>> +
>>>>>>>>> +#ifdef CONFIG_EFI_CAPSULE_FIRMWARE_FIT
>>>>>>>>> +/*
>>>>>>>>> + * FIT Capsule Support - Implementation
>>>>>>>>> + */
>>>>>>>>> +
>>>>>>>>> +static void parse_partition_name(const char *full_name, char *base_name, char *slot_suffix)
>>>>>>>>> +{
>>>>>>>>> +       char *underscore = strrchr(full_name, '_');
>>>>>>>>> +
>>>>>>>>> +       if (underscore && (strcmp(underscore, "_a") == 0 || strcmp(underscore, "_b") == 0)) {
>>>>>>>>> +               /* Has A/B suffix */
>>>>>>>>> +               size_t base_len = underscore - full_name;
>>>>>>>>> +
>>>>>>>>> +               strlcpy(base_name, full_name, base_len + 1);
>>>>>>>>> +               strcpy(slot_suffix, underscore);
>>>>>>>>> +       } else {
>>>>>>>>> +               /* No A/B suffix */
>>>>>>>>> +               strcpy(base_name, full_name);
>>>>>>>>> +               slot_suffix[0] = '\0';
>>>>>>>>> +       }
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static void parse_partition_info(struct qcom_partition_info *part,
>>>>>>>>> +                                struct disk_partition *info,
>>>>>>>>> +                                int lun, int partnum)
>>>>>>>>> +{
>>>>>>>>> +       struct part_slot_status *slot_status;
>>>>>>>>> +
>>>>>>>>> +       strlcpy(part->name, info->name, sizeof(part->name));
>>>>>>>>> +       part->lun = lun;
>>>>>>>>> +       part->partition_num = partnum;
>>>>>>>>> +
>>>>>>>>> +       /* Parse slot status from GPT vendor attributes */
>>>>>>>>> +       slot_status = (struct part_slot_status *)&info->type_flags;
>>>>>>>>> +       part->is_active = slot_status->active;
>>>>>>>>> +       part->is_bootable = !slot_status->unbootable;
>>>>>>>>> +
>>>>>>>>> +       /* Extract base name and slot suffix */
>>>>>>>>> +       parse_partition_name(part->name, part->base_name, part->slot_suffix);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static struct partition_group *find_or_create_group(struct partition_group *groups,
>>>>>>>>> +                                                   int *group_count,
>>>>>>>>> +                                                   const char *base_name)
>>>>>>>>> +{
>>>>>>>>> +       /* Find existing group */
>>>>>>>>> +       for (int i = 0; i < *group_count; i++) {
>>>>>>>>> +               if (strcmp(groups[i].base_name, base_name) == 0)
>>>>>>>>> +                       return &groups[i];
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Create new group */
>>>>>>>>> +       if (*group_count >= MAX_PARTITION_GROUPS) {
>>>>>>>>> +               log_err("Too many partition groups\n");
>>>>>>>>> +               return NULL;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       struct partition_group *new_group = &groups[*group_count];
>>>>>>>>> +
>>>>>>>>> +       strcpy(new_group->base_name, base_name);
>>>>>>>>> +       new_group->a_slot = NULL;
>>>>>>>>> +       new_group->b_slot = NULL;
>>>>>>>>> +       new_group->no_slot = NULL;
>>>>>>>>> +
>>>>>>>>> +       (*group_count)++;
>>>>>>>>> +       return new_group;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static struct qcom_partition_info *select_ab_target(struct qcom_partition_info *a_slot,
>>>>>>>>> +                                                   struct qcom_partition_info *b_slot)
>>>>>>>>> +{
>>>>>>>>> +       /* Priority: Active slot > A slot (fallback) */
>>>>>>>>> +
>>>>>>>>> +       if (a_slot && a_slot->is_active) {
>>>>>>>>> +               log_debug("Selected %s (active)\n", a_slot->name);
>>>>>>>>> +               return a_slot;
>>>>>>>>> +       }
>>>>>>>>> +       if (b_slot && b_slot->is_active) {
>>>>>>>>> +               log_debug("Selected %s (active)\n", b_slot->name);
>>>>>>>>> +               return b_slot;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Both inactive - prefer A slot as fallback */
>>>>>>>>> +       struct qcom_partition_info *fallback = a_slot ? a_slot : b_slot;
>>>>>>>>> +
>>>>>>>>> +       if (fallback)
>>>>>>>>> +               log_debug("Selected %s (fallback - both inactive)\n", fallback->name);
>>>>>>>>> +       return fallback;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int discover_all_partitions(struct qcom_partition_info **all_parts, int *all_count)
>>>>>>>>> +{
>>>>>>>>> +       struct udevice *dev;
>>>>>>>>> +       struct blk_desc *desc;
>>>>>>>>> +       struct qcom_partition_info *partition_list;
>>>>>>>>> +       int partition_count = 0;
>>>>>>>>> +       int max_partitions = 256;
>>>>>>>>> +       bool have_ufs = false;
>>>>>>>>> +
>>>>>>>>> +       /* Allocate partition list */
>>>>>>>>> +       partition_list = calloc(max_partitions, sizeof(struct qcom_partition_info));
>>>>>>>>> +       if (!partition_list) {
>>>>>>>>> +               log_err("Failed to allocate partition list\n");
>>>>>>>>> +               return -ENOMEM;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       if (IS_ENABLED(CONFIG_SCSI)) {
>>>>>>>>> +               if (scsi_scan(false)) {
>>>>>>>>> +                       log_debug("Failed to scan SCSI devices\n");
>>>>>>>>> +                       free(partition_list);
>>>>>>>>> +                       return -EIO;
>>>>>>>>> +               }
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /*
>>>>>>>>> +        * Check to see if we have UFS storage, if so firmware MUST be on it and we can skip
>>>>>>>>> +        * all non-UFS block devices
>>>>>>>>> +        */
>>>>>>>>> +       uclass_foreach_dev_probe(UCLASS_UFS, dev) {
>>>>>>>>> +               have_ufs = true;
>>>>>>>>> +               break;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Discover partitions with UFS-priority logic */
>>>>>>>>> +       uclass_foreach_dev_probe(UCLASS_BLK, dev) {
>>>>>>>>> +               if (device_get_uclass_id(dev) != UCLASS_BLK)
>>>>>>>>> +                       continue;
>>>>>>>>> +
>>>>>>>>> +               desc = dev_get_uclass_plat(dev);
>>>>>>>>> +               if (!desc)
>>>>>>>>> +                       continue;
>>>>>>>>> +
>>>>>>>>> +               if (have_ufs) {
>>>>>>>>> +                       if (device_get_uclass_id(dev->parent->parent) != UCLASS_UFS)
>>>>>>>>> +                               continue;
>>>>>>>>> +               } else {
>>>>>>>>> +                       /* If we don't have UFS, look at eMMC (but skip SD cards) */
>>>>>>>>> +                       if (desc->uclass_id == UCLASS_MMC) {
>>>>>>>>> +                               if (IS_ENABLED(CONFIG_MMC) && is_sd(desc)) {
>>>>>>>>> +                                       log_debug("Skipped SD-Card (devnum %d)\n", desc->devnum);
>>>>>>>>> +                                       continue;
>>>>>>>>> +                               }
>>>>>>>>> +                       } else if (desc->uclass_id != UCLASS_SCSI) {
>>>>>>>>> +                               /* Not MMC and not SCSI, skip it */
>>>>>>>>> +                               continue;
>>>>>>>>> +                       }
>>>>>>>>> +               }
>>>>>>>>> +
>>>>>>>>> +               int lun = desc->devnum;
>>>>>>>>> +
>>>>>>>>> +               /* Scan all partitions on this device */
>>>>>>>>> +               for (int partnum = 1; partnum <= MAX_PARTITIONS_TO_SCAN; partnum++) {
>>>>>>>>> +                       struct disk_partition info;
>>>>>>>>> +
>>>>>>>>> +                       if (part_get_info(desc, partnum, &info) != 0)
>>>>>>>>> +                               break;
>>>>>>>>> +
>>>>>>>>> +                       if (partition_count >= max_partitions) {
>>>>>>>>> +                               log_warning("Too many partitions discovered, truncating at %d\n",
>>>>>>>>> +                                           max_partitions);
>>>>>>>>> +                               break;
>>>>>>>>> +                       }
>>>>>>>>> +
>>>>>>>>> +                       /* Parse and store partition info */
>>>>>>>>> +                       parse_partition_info(&partition_list[partition_count], &info, lun, partnum);
>>>>>>>>> +                       partition_count++;
>>>>>>>>> +               }
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       *all_parts = partition_list;
>>>>>>>>> +       *all_count = partition_count;
>>>>>>>>> +
>>>>>>>>> +       log_debug("Discovered %d partitions across all %s devices\n",
>>>>>>>>> +                 partition_count, have_ufs ? "UFS" : "eMMC");
>>>>>>>>> +       return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int select_target_partitions(struct qcom_partition_info *all_parts, int all_count,
>>>>>>>>> +                                   struct qcom_partition_info **selected_parts,
>>>>>>>>> +                                   int *selected_count)
>>>>>>>>> +{
>>>>>>>>> +       struct partition_group groups[MAX_PARTITION_GROUPS];
>>>>>>>>> +       struct qcom_partition_info *target_list;
>>>>>>>>> +       int group_count = 0;
>>>>>>>>> +       int target_count = 0;
>>>>>>>>> +
>>>>>>>>> +       memset(groups, 0, sizeof(groups));
>>>>>>>>> +
>>>>>>>>> +       /* Allocate target list */
>>>>>>>>> +       target_list = calloc(all_count, sizeof(struct qcom_partition_info));
>>>>>>>>> +       if (!target_list) {
>>>>>>>>> +               log_err("Failed to allocate target partition list\n");
>>>>>>>>> +               return -ENOMEM;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Group partitions by base name */
>>>>>>>>> +       for (int i = 0; i < all_count; i++) {
>>>>>>>>> +               struct qcom_partition_info *part = &all_parts[i];
>>>>>>>>> +               struct partition_group *group = find_or_create_group(groups, &group_count,
>>>>>>>>> +                                                                    part->base_name);
>>>>>>>>> +
>>>>>>>>> +               if (!group) {
>>>>>>>>> +                       log_err("Failed to create group for %s\n", part->base_name);
>>>>>>>>> +                       continue;
>>>>>>>>> +               }
>>>>>>>>> +
>>>>>>>>> +               if (strcmp(part->slot_suffix, "_a") == 0) {
>>>>>>>>> +                       if (!group->a_slot) {
>>>>>>>>> +                               group->a_slot = part;
>>>>>>>>> +                       } else {
>>>>>>>>> +                               log_info("Duplicate A-slot partition detected\n");
>>>>>>>>> +                               log_info("  Keeping: %s (LUN %d, partition %d) [first discovered]\n",
>>>>>>>>> +                                        group->a_slot->name, group->a_slot->lun,
>>>>>>>>> +                                        group->a_slot->partition_num);
>>>>>>>>> +                               log_info("  Ignoring: %s (LUN %d, partition %d) [duplicate]\n",
>>>>>>>>> +                                        part->name, part->lun, part->partition_num);
>>>>>>>>> +                       }
>>>>>>>>> +               } else if (strcmp(part->slot_suffix, "_b") == 0) {
>>>>>>>>> +                       if (!group->b_slot) {
>>>>>>>>> +                               group->b_slot = part;
>>>>>>>>> +                       } else {
>>>>>>>>> +                               log_info("Duplicate B-slot partition detected\n");
>>>>>>>>> +                               log_info("  Keeping: %s (LUN %d, partition %d) [first discovered]\n",
>>>>>>>>> +                                        group->b_slot->name, group->b_slot->lun,
>>>>>>>>> +                                        group->b_slot->partition_num);
>>>>>>>>> +                               log_info("  Ignoring: %s (LUN %d, partition %d) [duplicate]\n",
>>>>>>>>> +                                        part->name, part->lun, part->partition_num);
>>>>>>>>> +                       }
>>>>>>>>> +               } else {
>>>>>>>>> +                       if (!group->no_slot) {
>>>>>>>>> +                               group->no_slot = part;
>>>>>>>>> +                       } else {
>>>>>>>>> +                               log_info("Duplicate non-A/B partition detected\n");
>>>>>>>>> +                               log_info("  Keeping: %s (LUN %d, partition %d) [first discovered]\n",
>>>>>>>>> +                                        group->no_slot->name, group->no_slot->lun,
>>>>>>>>> +                                        group->no_slot->partition_num);
>>>>>>>>> +                               log_info("  Ignoring: %s (LUN %d, partition %d) [duplicate]\n",
>>>>>>>>> +                                        part->name, part->lun, part->partition_num);
>>>>>>>>> +                       }
>>>>>>>>> +               }
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       log_debug("Created %d partition groups for selection\n", group_count);
>>>>>>>>> +
>>>>>>>>> +       /* Select target partition for each group */
>>>>>>>>> +       for (int i = 0; i < group_count; i++) {
>>>>>>>>> +               struct partition_group *group = &groups[i];
>>>>>>>>> +               struct qcom_partition_info *target = NULL;
>>>>>>>>> +
>>>>>>>>> +               if (group->no_slot) {
>>>>>>>>> +                       /* Non-A/B partition */
>>>>>>>>> +                       target = group->no_slot;
>>>>>>>>> +                       log_debug("Group %s: selected non-A/B partition %s\n",
>>>>>>>>> +                                 group->base_name, target->name);
>>>>>>>>> +               } else {
>>>>>>>>> +                       /* A/B partition - apply selection logic */
>>>>>>>>> +                       target = select_ab_target(group->a_slot, group->b_slot);
>>>>>>>>> +                       if (target) {
>>>>>>>>> +                               log_debug("Group %s: selected %s from A/B pair\n",
>>>>>>>>> +                                         group->base_name, target->name);
>>>>>>>>> +                       }
>>>>>>>>> +               }
>>>>>>>>> +
>>>>>>>>> +               if (target) {
>>>>>>>>> +                       /* Copy selected partition to target list */
>>>>>>>>> +                       memcpy(&target_list[target_count], target,
>>>>>>>>> +                              sizeof(struct qcom_partition_info));
>>>>>>>>> +                       target_count++;
>>>>>>>>> +               } else {
>>>>>>>>> +                       log_info("No target selected for group %s\n", group->base_name);
>>>>>>>>> +               }
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       *selected_parts = target_list;
>>>>>>>>> +       *selected_count = target_count;
>>>>>>>>> +
>>>>>>>>> +       log_debug("Selected %d target partitions from %d discovered\n", target_count, all_count);
>>>>>>>>> +       return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int group_partitions_by_lun(struct qcom_partition_info *selected_parts, int selected_count,
>>>>>>>>> +                                  struct lun_group **lun_groups, int *group_count)
>>>>>>>>> +{
>>>>>>>>> +       struct lun_group *groups;
>>>>>>>>> +       int max_groups = MAX_LUN_GROUPS;
>>>>>>>>> +       int current_groups = 0;
>>>>>>>>> +
>>>>>>>>> +       /* Allocate LUN groups array */
>>>>>>>>> +       groups = calloc(max_groups, sizeof(struct lun_group));
>>>>>>>>> +       if (!groups) {
>>>>>>>>> +               log_err("Failed to allocate LUN groups array\n");
>>>>>>>>> +               return -ENOMEM;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Group partitions by LUN */
>>>>>>>>> +       for (int i = 0; i < selected_count; i++) {
>>>>>>>>> +               struct qcom_partition_info *part = &selected_parts[i];
>>>>>>>>> +               struct lun_group *target_group = NULL;
>>>>>>>>> +
>>>>>>>>> +               /* Find existing group for this LUN */
>>>>>>>>> +               for (int j = 0; j < current_groups; j++) {
>>>>>>>>> +                       if (groups[j].lun_number == part->lun) {
>>>>>>>>> +                               target_group = &groups[j];
>>>>>>>>> +                               break;
>>>>>>>>> +                       }
>>>>>>>>> +               }
>>>>>>>>> +
>>>>>>>>> +               /* Create new group if not found */
>>>>>>>>> +               if (!target_group) {
>>>>>>>>> +                       if (current_groups >= max_groups) {
>>>>>>>>> +                               log_err("Too many LUN groups (max %d)\n", max_groups);
>>>>>>>>> +                               free(groups);
>>>>>>>>> +                               return -ENOSPC;
>>>>>>>>> +                       }
>>>>>>>>> +
>>>>>>>>> +                       target_group = &groups[current_groups];
>>>>>>>>> +                       target_group->lun_number = part->lun;
>>>>>>>>> +                       target_group->partition_count = 0;
>>>>>>>>> +                       current_groups++;
>>>>>>>>> +               }
>>>>>>>>> +
>>>>>>>>> +               /* Add partition to group */
>>>>>>>>> +               if (target_group->partition_count >= 64) {
>>>>>>>>> +                       log_err("Too many partitions in LUN %d (max 64)\n", part->lun);
>>>>>>>>> +                       free(groups);
>>>>>>>>> +                       return -ENOSPC;
>>>>>>>>> +               }
>>>>>>>>> +
>>>>>>>>> +               target_group->partitions[target_group->partition_count] = part;
>>>>>>>>> +               target_group->partition_count++;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +               /* Sort groups by LUN number for consistent output */
>>>>>>>>> +               for (int i = 0; i < current_groups - 1; i++) {
>>>>>>>>> +                       for (int j = i + 1; j < current_groups; j++) {
>>>>>>>>> +                               if (groups[i].lun_number > groups[j].lun_number) {
>>>>>>>>> +                                       struct lun_group temp = groups[i];
>>>>>>>>> +
>>>>>>>>> +                                       groups[i] = groups[j];
>>>>>>>>> +                                       groups[j] = temp;
>>>>>>>>> +                               }
>>>>>>>>> +                       }
>>>>>>>>> +               }
>>>>>>>>> +
>>>>>>>>> +       *lun_groups = groups;
>>>>>>>>> +       *group_count = current_groups;
>>>>>>>>> +
>>>>>>>>> +       log_debug("Grouped %d partitions into %d LUN groups\n", selected_count, current_groups);
>>>>>>>>> +       return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int generate_dfu_string(struct qcom_partition_info *selected_parts, int selected_count,
>>>>>>>>> +                              char *dfu_string, size_t buffer_size)
>>>>>>>>> +{
>>>>>>>>> +       struct lun_group *lun_groups = NULL;
>>>>>>>>> +       struct udevice *dev;
>>>>>>>>> +       struct blk_desc *desc;
>>>>>>>>> +       int group_count = 0;
>>>>>>>>> +       char *dfu_ptr = dfu_string;
>>>>>>>>> +       int remaining = buffer_size;
>>>>>>>>> +       int ret;
>>>>>>>>> +       bool is_mmc = false;
>>>>>>>>> +
>>>>>>>>> +       /* Clear the buffer */
>>>>>>>>> +       memset(dfu_string, 0, buffer_size);
>>>>>>>>> +
>>>>>>>>> +       /* Determine storage type by checking the first partition's device */
>>>>>>>>> +       if (selected_count > 0) {
>>>>>>>>> +               uclass_foreach_dev_probe(UCLASS_BLK, dev) {
>>>>>>>>> +                       if (device_get_uclass_id(dev) != UCLASS_BLK)
>>>>>>>>> +                               continue;
>>>>>>>>> +
>>>>>>>>> +                       desc = dev_get_uclass_plat(dev);
>>>>>>>>> +                       if (!desc)
>>>>>>>>> +                               continue;
>>>>>>>>> +
>>>>>>>>> +                       if (desc->devnum == selected_parts[0].lun) {
>>>>>>>>> +                               if (desc->uclass_id == UCLASS_MMC) {
>>>>>>>>> +                                       is_mmc = true;
>>>>>>>>> +                                       log_debug("Detected MMC/eMMC storage for DFU string generation\n");
>>>>>>>>> +                               } else if (desc->uclass_id == UCLASS_SCSI) {
>>>>>>>>> +                                       is_mmc = false;
>>>>>>>>> +                                       log_debug("Detected SCSI/UFS storage for DFU string generation\n");
>>>>>>>>> +                               }
>>>>>>>>> +                               break;
>>>>>>>>> +                       }
>>>>>>>>> +               }
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Group partitions by LUN/device */
>>>>>>>>> +       ret = group_partitions_by_lun(selected_parts, selected_count, &lun_groups, &group_count);
>>>>>>>>> +       if (ret != 0) {
>>>>>>>>> +               log_err("Failed to group partitions by LUN: %d\n", ret);
>>>>>>>>> +               return ret;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Generate DFU string with appropriate format for storage type */
>>>>>>>>> +       for (int i = 0; i < group_count; i++) {
>>>>>>>>> +               struct lun_group *group = &lun_groups[i];
>>>>>>>>> +               int written;
>>>>>>>>> +
>>>>>>>>> +               /* Add device group separator for non-first groups */
>>>>>>>>> +               if (i > 0) {
>>>>>>>>> +                       written = snprintf(dfu_ptr, remaining, "&");
>>>>>>>>> +                       dfu_ptr += written;
>>>>>>>>> +                       remaining -= written;
>>>>>>>>> +               }
>>>>>>>>> +
>>>>>>>>> +               if (is_mmc) {
>>>>>>>>> +                       /* MMC format: "mmc X=" */
>>>>>>>>> +                       written = snprintf(dfu_ptr, remaining, "mmc %d=", group->lun_number);
>>>>>>>>> +               } else {
>>>>>>>>> +                       /* SCSI format: "scsi X=" */
>>>>>>>>> +                       written = snprintf(dfu_ptr, remaining, "scsi %d=", group->lun_number);
>>>>>>>>> +               }
>>>>>>>>> +               dfu_ptr += written;
>>>>>>>>> +               remaining -= written;
>>>>>>>>> +
>>>>>>>>> +               /* Add partitions within this device group */
>>>>>>>>> +               for (int j = 0; j < group->partition_count; j++) {
>>>>>>>>> +                       struct qcom_partition_info *part = group->partitions[j];
>>>>>>>>> +
>>>>>>>>> +                       /* Add partition separator for non-first partitions in group */
>>>>>>>>> +                       if (j > 0) {
>>>>>>>>> +                               written = snprintf(dfu_ptr, remaining, ";");
>>>>>>>>> +                               dfu_ptr += written;
>>>>>>>>> +                               remaining -= written;
>>>>>>>>> +                       }
>>>>>>>>> +
>>>>>>>>> +                       if (is_mmc) {
>>>>>>>>> +                               /* MMC format: "partition_name part dev_num partition_num" */
>>>>>>>>> +                               written = snprintf(dfu_ptr, remaining, "%s part %d %d",
>>>>>>>>> +                                                  part->name, group->lun_number, part->partition_num);
>>>>>>>>> +                       } else {
>>>>>>>>> +                               /* SCSI format: "partition_name part partition_num" */
>>>>>>>>> +                               written = snprintf(dfu_ptr, remaining, "%s part %d",
>>>>>>>>> +                                                  part->name, part->partition_num);
>>>>>>>>> +                       }
>>>>>>>>> +                       dfu_ptr += written;
>>>>>>>>> +                       remaining -= written;
>>>>>>>>> +
>>>>>>>>> +                       if (remaining <= 10) {
>>>>>>>>> +                               log_err("DFU string buffer overflow at partition %s\n", part->name);
>>>>>>>>> +                               free(lun_groups);
>>>>>>>>> +                               return -ENOSPC;
>>>>>>>>> +                       }
>>>>>>>>> +               }
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Clean up */
>>>>>>>>> +       free(lun_groups);
>>>>>>>>> +
>>>>>>>>> +       log_debug("Generated %s DFU string (%zu chars): %s\n",
>>>>>>>>> +                 is_mmc ? "MMC" : "SCSI", strlen(dfu_string), dfu_string);
>>>>>>>>> +       return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +/**
>>>>>>>>> + * get_board_fit_capsule_guid - Get board-specific FIT capsule GUID
>>>>>>>>> + *
>>>>>>>>> + * Detect the board type from device tree and return the appropriate GUID
>>>>>>>>> + * for FIT capsule updates.
>>>>>>>>> + *
>>>>>>>>> + * @guid: Pointer to store the GUID
>>>>>>>>> + * Return: 0 on success, negative error code on failure
>>>>>>>>> + */
>>>>>>>>> +static int get_board_fit_capsule_guid(efi_guid_t *guid)
>>>>>>>>> +{
>>>>>>>>> +       const char *compatible;
>>>>>>>>> +
>>>>>>>>> +       if (!guid)
>>>>>>>>> +               return -EINVAL;
>>>>>>>>> +
>>>>>>>>> +       compatible = ofnode_read_string(ofnode_root(), "compatible");
>>>>>>>>> +       if (!compatible) {
>>>>>>>>> +               log_err("Failed to read board compatible string\n");
>>>>>>>>> +               return -ENODEV;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Check for QCS615 or Talos */
>>>>>>>>> +       if (strstr(compatible, "qcs615") || strstr(compatible, "talos")) {
>>>>>>>>> +               log_debug("Detected QCS615/Talos board\n");
>>>>>>>>> +               *guid = (efi_guid_t)QCOM_QCS615_FIT_CAPSULE_GUID;
>>>>>>>>> +               return 0;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Check for QCS6490 */
>>>>>>>>> +       if (strstr(compatible, "qcs6490")) {
>>>>>>>>> +               log_debug("Detected QCS6490 board\n");
>>>>>>>>> +               *guid = (efi_guid_t)QCOM_QCS6490_FIT_CAPSULE_GUID;
>>>>>>>>> +               return 0;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Check for Lemans */
>>>>>>>>> +       if (strstr(compatible, "lemans") || strstr(compatible, "qcs9100")) {
>>>>>>>>> +               log_debug("Detected Lemans board\n");
>>>>>>>>> +               *guid = (efi_guid_t)QCOM_LEMANS_FIT_CAPSULE_GUID;
>>>>>>>>> +               return 0;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       log_err("Unsupported board for capsule updates: %s\n", compatible);
>>>>>>>>> +       return -EINVAL;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +/*
>>>>>>>>> + * For creating FIT-based capsule images from FvUpdate.xml files, see:
>>>>>>>>> + *   - Tool: tools/fvupdate_to_fit.py
>>>>>>>>> + *   - Documentation: doc/develop/fvupdate_to_fit.rst
>>>>>>>>> + */
>>>>>>>>> +static void configure_fit_capsule_updates(void)
>>>>>>>>> +{
>>>>>>>>> +       struct qcom_partition_info *all_partitions = NULL;
>>>>>>>>> +       struct qcom_partition_info *selected_partitions = NULL;
>>>>>>>>> +       int all_count = 0, selected_count = 0;
>>>>>>>>> +       static char dfu_string[MAX_DFU_STRING_SIZE] = { 0 };
>>>>>>>>> +       static struct efi_fw_image single_fw_image;
>>>>>>>>> +       efi_guid_t board_guid;
>>>>>>>>> +       int ret;
>>>>>>>>> +
>>>>>>>>> +       /* Step 1: Discover all partitions across all SCSI LUNs */
>>>>>>>>> +       ret = discover_all_partitions(&all_partitions, &all_count);
>>>>>>>>> +       if (ret != 0) {
>>>>>>>>> +               log_err("Failed to discover SCSI partitions: %d\n", ret);
>>>>>>>>> +               return;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       if (all_count == 0) {
>>>>>>>>> +               log_warning("No SCSI partitions discovered\n");
>>>>>>>>> +               goto cleanup;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Step 2: Apply A/B selection logic to choose target partitions */
>>>>>>>>> +       ret = select_target_partitions(all_partitions, all_count,
>>>>>>>>> +                                      &selected_partitions, &selected_count);
>>>>>>>>> +       if (ret != 0) {
>>>>>>>>> +               log_err("Failed to select target partitions: %d\n", ret);
>>>>>>>>> +               goto cleanup;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       if (selected_count == 0) {
>>>>>>>>> +               log_warning("No target partitions selected\n");
>>>>>>>>> +               goto cleanup;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Step 3: Generate DFU string from selected partitions */
>>>>>>>>> +       ret = generate_dfu_string(selected_partitions, selected_count,
>>>>>>>>> +                                 dfu_string, sizeof(dfu_string));
>>>>>>>>> +       if (ret != 0) {
>>>>>>>>> +               log_err("Failed to generate DFU string: %d\n", ret);
>>>>>>>>> +               goto cleanup;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Step 4: Get board-specific GUID */
>>>>>>>>> +       ret = get_board_fit_capsule_guid(&board_guid);
>>>>>>>>> +       if (ret != 0) {
>>>>>>>>> +               log_err("Failed to get board-specific GUID: %d\n", ret);
>>>>>>>>> +               goto cleanup;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       /* Step 5: Create SINGLE fw_image entry for ESRT */
>>>>>>>>> +       memset(&single_fw_image, 0, sizeof(single_fw_image));
>>>>>>>>> +       single_fw_image.fw_name = QCOM_FIT_CAPSULE_NAME;  /* Same name for all boards */
>>>>>>>>> +       single_fw_image.image_index = 1;
>>>>>>>>> +       single_fw_image.image_type_id = board_guid;
>>>>>>>>> +
>>>>>>>>> +       /* Step 6: Configure update_info */
>>>>>>>>>             update_info.dfu_string = dfu_string;
>>>>>>>>> +       update_info.images = &single_fw_image;
>>>>>>>>> +       update_info.num_images = 1;
>>>>>>>>> +
>>>>>>>>> +       log_info("FIT capsule configured successfully:\n");
>>>>>>>>> +       log_info("  Name: %ls\n", QCOM_FIT_CAPSULE_NAME);
>>>>>>>>> +       log_info("  GUID: %pUl\n", &board_guid);
>>>>>>>>> +       log_info("  Partitions in DFU string: %d\n", selected_count);
>>>>>>>>> +       log_info("  ESRT entries: 1 (single entry for all partitions)\n");
>>>>>>>>> +
>>>>>>>>> +cleanup:
>>>>>>>>> +       free(all_partitions);
>>>>>>>>> +       free(selected_partitions);
>>>>>>>>> +}
>>>>>>>>> +#endif /* CONFIG_EFI_CAPSULE_FIRMWARE_FIT */
>>>>>>>>> +
>>>>>>>>> +/**
>>>>>>>>> + * qcom_configure_capsule_updates() - Configure capsule updates
>>>>>>>>> + *
>>>>>>>>> + * Configures either FIT or RAW capsule updates based on compile-time configuration.
>>>>>>>>> + */
>>>>>>>>> +void qcom_configure_capsule_updates(void)
>>>>>>>>> +{
>>>>>>>>> +#if defined(CONFIG_EFI_CAPSULE_FIRMWARE_FIT)
>>>>>>>>> +       log_info("Configuring FIT capsule updates\n");
>>>>>>>>> +       configure_fit_capsule_updates();
>>>>>>>>> +#elif defined(CONFIG_EFI_CAPSULE_FIRMWARE_RAW)
>>>>>>>>> +       log_info("Configuring RAW capsule updates\n");
>>>>>>>>> +       configure_raw_capsule_updates();
>>>>>>>>> +#else
>>>>>>>>> +       log_warning("No capsule firmware configuration enabled\n");
>>>>>>>>> +#endif
>>>>>>>>> +
>>>>>>>>> +       /* Final state logging */
>>>>>>>>> +       if (update_info.dfu_string) {
>>>>>>>>> +               log_info("Capsule update configured successfully with %d image(s)\n",
>>>>>>>>> +                        update_info.num_images);
>>>>>>>>> +       } else {
>>>>>>>>> +               log_warning("Capsule update configuration failed\n");
>>>>>>>>> +       }
>>>>>>>>>      }
>>>>>>>>> +
>>>>>>>>> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
>>>>>>>>> index b8bf574e8bb..d664c22ae96 100644
>>>>>>>>> --- a/arch/arm/mach-snapdragon/qcom-priv.h
>>>>>>>>> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
>>>>>>>>> @@ -18,6 +18,29 @@ enum qcom_boot_source {
>>>>>>>>>      extern enum qcom_boot_source qcom_boot_source;
>>>>>>>>>
>>>>>>>>>      #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>>>>>>>>> +/*
>>>>>>>>> + * Capsule Update GUIDs for FIT capsules
>>>>>>>>> + * Each board has a unique GUID to prevent cross-board flashing
>>>>>>>>> + */
>>>>>>>>> +
>>>>>>>>> +/* QCS615 FIT Capsule GUID: 9fd379d2-670e-4bb3-86a1-40497e6e17b0 */
>>>>>>>>> +#define QCOM_QCS615_FIT_CAPSULE_GUID \
>>>>>>>>> +       EFI_GUID(0x9fd379d2, 0x670e, 0x4bb3, 0x86, 0xa1, \
>>>>>>>>> +                0x40, 0x49, 0x7e, 0x6e, 0x17, 0xb0)
>>>>>>>>> +
>>>>>>>>> +/* QCS6490 FIT Capsule GUID: 6f25bfd2-a165-468b-980f-ac51a0a45c52 */
>>>>>>>>> +#define QCOM_QCS6490_FIT_CAPSULE_GUID \
>>>>>>>>> +       EFI_GUID(0x6f25bfd2, 0xa165, 0x468b, 0x98, 0x0f, \
>>>>>>>>> +                0xac, 0x51, 0xa0, 0xa4, 0x5c, 0x52)
>>>>>>>>> +
>>>>>>>>> +/* Lemans FIT Capsule GUID: 78462415-6133-431c-9fae-48f2bafd5c71 */
>>>>>>>>> +#define QCOM_LEMANS_FIT_CAPSULE_GUID \
>>>>>>>>> +       EFI_GUID(0x78462415, 0x6133, 0x431c, 0x9f, 0xae, \
>>>>>>>>> +                0x48, 0xf2, 0xba, 0xfd, 0x5c, 0x71)
>>>>>>>>> +
>>>>>>>>> +/* Common name for FIT capsule (same for all boards) */
>>>>>>>>> +#define QCOM_FIT_CAPSULE_NAME u"QCOM_FIT_CAPSULE"
>>>>>>>>> +
>>>>>>>>>      void qcom_configure_capsule_updates(void);
>>>>>>>>>      #else
>>>>>>>>>      void qcom_configure_capsule_updates(void) {}
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> 2.34.1
>>>>>>>>>
