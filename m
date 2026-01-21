Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C93C44501
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 10:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A1D8341A;
	Wed, 21 Jan 2026 11:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZfYWgnHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6630E8397D; Wed, 21 Jan 2026 11:38:59 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B1182A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 11:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so3483011f8f.3
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 02:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768991934; x=1769596734; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ahPr90ZMOI+Dnjy7W60Oj5hhkKI1N7j1HZSwyWG6eEI=;
 b=ZfYWgnHRinKOdJ9WXHiujZnXcNYlc4ymYIe3Yv/KyKe8fI/Vd37M0/6ihClK3dxjcF
 fWwO/CvI6TRlogl81rH+TVLqlizsnE4FEdveiVVozjoEUN5dFGtUX4Jy2LR/okoxqLf7
 0Icj6KsezdqSCosfuSIWlX/QFUc4miLrevB209sTkhJFZOhjIig1w8gmpqyc5vHY1g5j
 BydaXUlZn/MTDcdt6eC9bEbwvsfOxWS/iYATCaqQ96MHw/XSDuwRszKsog/34OHsrb3R
 B8rYyjqpnZIbJLRtUc5du2BzgGKOgHZeJtNSxXBmWZvuLuNgVm3yzVBYDqGgGESfSPYe
 jq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768991934; x=1769596734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ahPr90ZMOI+Dnjy7W60Oj5hhkKI1N7j1HZSwyWG6eEI=;
 b=TRBnL+Nmgh8ccTdld8sPYwJnX0FKVTEf1VubY3i1B02l+WNPp7qFXhS5wqBn14KNVx
 5ausp+jennyvHm8SdSgtgDk4oJf0ABOm9lFr6EIcYwPjfUyWirH5owSIp4iSUIsp2rOY
 2DGIDbxLYDH7+DnGjPOJWGNfeNCTsVDE4rM87hz7clIOXoewKdXioddf9US4AeHghDUA
 VxPFiKSYbw5lfdZ8es50xJN3FxIBi4H2Zynm38PlY1TfiWXctU9s0fWcfdfyCTWa/E8n
 s9lRrVxvd9bzVFknsKTm4hdORcwGN0lnitcLJcE9dO8xr76H+clz8Mp2Sss7K1N9MecF
 zTPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeXYpMJOnKp9eXzJopjapmsqfUt1otFGehqOZmT5vE8vu/oj+gNKZpEvwv3AdCtSLIcI5dTkU=@lists.denx.de
X-Gm-Message-State: AOJu0YxWvQCmHG6j6bRMHNcw9TQLUB4jsPGBONjCj3O8z8ZNf53oa+vT
 8XUZ++4vvDq/8RDWwz2D0SsmAFg84IoD/0O7vFZX6LYVi6oLsDy5mhFufP5spzTDJZk=
X-Gm-Gg: AZuq6aJb3OMNLOsiXmhu/30x7GXgR9tsw3kiFZ32+KcGh9xIW4jXnL/KTDtE8i3yzzj
 NlTGx+3x3Cd2u7FksPX3ufM5RImWnZzWcooeswGs4A3yvC+qqyRMvFlSIuaRd0EEiOCgJev5xcJ
 tna3/qCl+EPL/1GYAFwm6VDTW+0EsaYvvQyG4YeaIFM+MaCcWElfzOWDiiMMXUogZw4frlJqb6+
 i8LZUA/z3vhlv4j6vixuwhb6qHPR6FFiwmHsgwYdJIa8WltLwzMTDQdUE2dRNt1VC9ZPupi/F//
 t+ZmUtMkZautkVBgBfgCbVLG8pLw9XOQ5IBN9+MFkykkxn36X5ipUvBKKks1i6UenSLhjGaxpzT
 c6/fcAKHpVBjv497yjUwLIHT+Xdou3KyZOKDuedzq1QabvH8sxlFrKgdv8vYE4B/noSMsS8pb69
 K17ILCDlDR+a4qvbAANQO5TdpHumClQr4uYoxFiCxOLcQ1DngvkTCDMGVtSsEUDKxx
X-Received: by 2002:a05:6000:2481:b0:42f:9f18:8f40 with SMTP id
 ffacd0b85a97d-43569bc6d7cmr24201188f8f.42.1768991934066; 
 Wed, 21 Jan 2026 02:38:54 -0800 (PST)
Received: from [192.168.1.36] (p4fc3dfd7.dip0.t-ipconnect.de. [79.195.223.215])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597ae9f37sm6045177f8f.8.2026.01.21.02.38.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 02:38:53 -0800 (PST)
Message-ID: <eeeeb92b-112d-4f44-b8ff-9741b204c7fb@linaro.org>
Date: Wed, 21 Jan 2026 11:38:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: Add generic qcom_tfa_optee_defconfig
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, jens.wiklander@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <aWjc04IqdiZPR1e4@sumit-xelite>
 <1d162515-9bf3-4bf4-90fe-6d2cc37cacfc@linaro.org>
 <aWjrLF9DUPTaSA1c@sumit-xelite>
 <63eb28ff-7a52-4c60-a206-e79af508f112@linaro.org>
 <aWnhdIwtgqclaTVq@sumit-xelite>
 <dc3c2b6d-16fe-4a52-ba9b-35bfd268c5e2@linaro.org>
 <aWnujB7lF3dqnmpe@sumit-xelite>
 <6a34ddeb-d3b3-4d7f-a91e-0c40e6ec9a2d@linaro.org>
 <aWosSZA2Qw8mXeIe@sumit-xelite>
 <1c0bf780-0d45-4d2a-abc8-bcdd1fd83aa2@linaro.org>
 <aXB-g6Tb0ihXWAet@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aXB-g6Tb0ihXWAet@sumit-xelite>
Content-Type: text/plain; charset=UTF-8
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



On 21/01/2026 08:21, Sumit Garg wrote:
> On Fri, Jan 16, 2026 at 06:46:16PM +0100, Casey Connolly wrote:
>> Hi Sumit,
>>
>> (Top-posting since this thread is getting a bit busy)
>>
>> I'm not sure if Neil and I properly conveyed why we don't agree with your
>> proposal here: essentially it is an inversion of logic. CONFIG_OPTEE doesn't
>> indicate that the board IS running OP-TEE, it just builds in support for
>> OP-TEE. In general U-Boot is trying to trend away from using kconfig to
>> dictate behaviour in this way.
> 
> OP-TEE as TZ is an optional feature for any arm64 SoC. And even with
> U-Boot SPL as the initial boot-loader you get to decide via a Kconfig
> option whether to support OP-TEE or not. Similarly with TF-A BL31, you
> have to specify "spd=opteed" during build time if OP-TEE is supported or
> not. So indeed it's a build time configuration for firmware to support
> OP-TEE or not.

Right, but I would not expect that enabling CONFIG_OPTEE in U-Boot would
result in DT fixups being applied since I may actually be running QTEE,
or plain TF-A without OP-TEE. CONFIG_OPTEE does not tell U-Boot that
OPTEE is being used, it simply enables the OP-TEE drivers in U-Boot.

An additional kconfig option like "CONFIG_OPTEE_DT_FIXUP" would make
more sense here but would still be an imho hard to justify hack.

> 
>>
>> Adjacently, for Qualcomm support in U-Boot we are trying to improve upon the
>> status quo: we don't do board-specific code, we limit hardcoding
>> functionality or build-time configuration in favour of runtime checks as
>> much as possible.
> 
> Not sure why you consider the OP-TEE feature being added here to be
> board specific. It is rather extending the qcom_defconfig to support
> OP-TEE based security features. For sure, we need to support similar
> board agnostic config fragments to enable UEFI secure boot with EFI
> runtime varibales based on OP-TEE RPMB storage.
> 
>>
>> With that perspective in mind, I would much prefer that switching from QTEE
>> to TF-A/OP-TEE on the rb3gen2 (or any other qcom board) not require flashing
>> a bespoke U-Boot build, the same build should just work on both.
> 
> The bespoke U-Boot build is already required for QTEE based flows, see:
> - qcm6490_defconfig
> - qcs9100_defconfig
> - qcom_ipq5424_mmc_defconfig
> - so on..

These defconfigs are not "bespoke" for QTEE, they will work just fine if
you're using TF-A like on a Chromebook.

> 
> vs
> 
> U-Boot build with OP-TEE flow:
> - qcom_defconfig + OP-TEE config fragment
> 
> And the resulting u-boot.bin gets used as BL33 for fip.bin as shown
> here [1].
> 
> [1] https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/rb3gen2.html
> 
>>
>> There are several ways it might be possible to check for OP-TEE at runtime,
>> arguably the simplest is the SMC call I proposed (which could be restricted
>> to just kodiak),
> 
> This is going to be board specific logic and not scalable.

I think this is where I'm getting a bit stuck, can you substantiate this
a bit? iirc normal SIP calls aren't used for talking with TA's in QTEE

I just gave this a go on SM8650 HDK and it does just return an error:

Trying OPTEE_GET_OS_UUID call
res: 0xffffffffffffffff 0x0 0x0 0x0

So why isn't this appropriate or "scalable"?

> 
>> the other idea that comes to mind is populating the x2
>> register with a magic number when jumping to U-Boot, or even using the
>> functionality already in place for passing data between bootloader stages
>> (assuming the necessary bits are upstream in both projects).
> 
> Having a generic mechanism for passing data among bootloader stages is
> the way to go here. Firmware handoff spec here [2] provides a good
> reference for that. Although I don't see a specific bloblist tag which
> can be used to detect OP-TEE presence.
> 
> Not sure why blocking this OP-TEE feature to be supported on Qcom
> platforms is a good idea until that firmware handoff mechanism get's
> realized on Qcom platforms. Also, even when the same U-Boot build can't
> be used for both QTEE and OP-TEE.
> 
> [2] https://github.com/FirmwareHandoff/firmware_handoff

If firmware handoff is being used, then an SMC call can certainly be
used to check if OP-TEE is present!

> 
>>
>> You say that making that SMC call on QTEE is undefined behaviour, but surely
>> it doesn't break stuff? I'd hope that simply seeing what happens would be
>> enough to define it, maybe checking with the boot team too.
> 
> As I said it's going to be hit and trial approach using SMC calls which
> isn't scalable.
> 
>>
>> Your patch also mentions the EFI DT fixup protocol, but there is no
>> corresponding code for that. iirc there are other DT changes needed for
>> everything to work properly on rb3gen2 with OP-TEE, is the plan to get those
>> changes done in such a way that the same DT will work with both OP-TEE and
>> QTEE?
> 
> With OP-TEE, we would be booting Linux in EL2 and there is corresponding
> DT work going on for QTEE with *_el2.dtso being added. So essentially
> the plan is to reuse same DT with *_el2.dtso overlay which is
> independent of whether OP-TEE or QTEE is running.
> 
> However, even without that we have a functional boot to shell system
> that can be used for OP-TEE based use-cases development.

Ok I see, that's good to know!

I think we're running into the limits of email with this discussion,
maybe we can organise a call to sort this out? I don't suppose you'll be
at FOSDEM this year?

Kind regards,

> 
> -Sumit
> 
>>
>> - Casey
>>
>> On 1/16/26 13:17, Sumit Garg wrote:
>>> On Fri, Jan 16, 2026 at 10:53:15AM +0100, Neil Armstrong wrote:
>>>> On 1/16/26 08:53, Sumit Garg wrote:
>>>>> On Fri, Jan 16, 2026 at 08:34:33AM +0100, Neil Armstrong wrote:
>>>>>> On 1/16/26 07:57, Sumit Garg wrote:
>>>>>>> On Thu, Jan 15, 2026 at 02:35:23PM +0100, Neil Armstrong wrote:
>>>>>>>> On 1/15/26 14:27, Sumit Garg wrote:
>>>>>>>>> On Thu, Jan 15, 2026 at 02:03:29PM +0100, Neil Armstrong wrote:
>>>>>>>>>> On 1/15/26 13:25, Sumit Garg wrote:
>>>>>>>>>>> + Jens (OP-TEE driver author in U-Boot)
>>>>>>>>>>>
>>>>>>>>>>> On Thu, Jan 15, 2026 at 11:49:49AM +0100, neil.armstrong@linaro.org wrote:
>>>>>>>>>>>> On 1/15/26 07:10, Sumit Garg wrote:
>>>>>>>>>>>>> On Wed, Jan 14, 2026 at 03:56:02PM +0100, Casey Connolly wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 09/01/2026 12:02, Sumit Garg wrote:
>>>>>>>>>>>>>>> On Thu, Jan 08, 2026 at 05:41:42PM +0100, Casey Connolly wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 29/12/2025 12:43, Sumit Garg wrote:
>>>>>>>>>>>>>>>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Recently upstream TF-A/OP-TEE has started gaining support for Qcom
>>>>>>>>>>>>>>>>> platforms. RB3Gen2 being the first one and more to come. U-Boot in
>>>>>>>>>>>>>>>>> corresponding boot flow is packaged as a position independent executable.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> So, lets add a generic U-Boot defconfig for Qcom platforms to support
>>>>>>>>>>>>>>>>> TF-A/OP-TEE based TrustZone stack. Build command:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> $ make qcom_tfa_optee_defconfig
>>>>>>>>>>>>>>>>> $ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> This would be better suited as a config fragment rather than a new
>>>>>>>>>>>>>>>> defconfig imo.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> That's fine with me to add it as a config fragment.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> But more importantly, enabling OPTEE support in U-Boot doesn't imply
>>>>>>>>>>>>>>>> that it will be used, just that it's supported.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> There are real use-cases of OP-TEE in U-Boot for Qcom platforms like
>>>>>>>>>>>>>>> secure EFI variables based on OP-TEE secure storage. Have a look here [1].
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> And sure there will be more such use-cases like fTPM, KASLR etc. can be
>>>>>>>>>>>>>>> supported based on OP-TEE.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I was referring literally to the fact that CONFIG_OPTEE being enabled
>>>>>>>>>>>>>> doesn't imply that OP-TEE is running, it's faulty logic to assume that's
>>>>>>>>>>>>>> the case and add nodes to the DT.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I don't disagree here as having a runtime check is always a better
>>>>>>>>>>>>> choice then a compile time config option. However, there isn't a common
>>>>>>>>>>>>> info method from properietary firmware that says if QTEE is running
>>>>>>>>>>>>> instead of OP-TEE.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I just checked and there is an SMC call that tells you the UUID for the
>>>>>>>>>>>>>> trusted OS, referred to as OPTEE_SMC_CALL_GET_OS_UUID in U-Boot and
>>>>>>>>>>>>>> OPTEE_ABI_CALL_GET_OS_UUID in OP-TEE. Presumably this identifies OP-TEE
>>>>>>>>>>>>>> specifically.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Also, we don't know how the QTEE will react to this OP-TEE specific SMC
>>>>>>>>>>>>> call given it's different variants running on legacy and the newer SoCs.
>>>>>>>>>>>>> So I would suggest to better gate OP-TEE presence behind a compile time
>>>>>>>>>>>>> check only.
>>>>>>>>>>>>
>>>>>>>>>>>> So you say it's fine to add the optee node, and the driver will bail out if
>>>>>>>>>>>> OPTEE is not present, but it's not good to call OPTEE_SMC_CALL_GET_OS_UUID
>>>>>>>>>>>> in the fixup code to enable OPTEE only if present ?
>>>>>>>>>>>>
>>>>>>>>>>>> It's literally the same, my point in https://lore.kernel.org/all/b60d5ee7-fa27-4dc1-8a09-964912ec5654@linaro.org/
>>>>>>>>>>>> was exactly that, just call OPTEE_SMC_CALL_GET_OS_UUID and add the OPTEE
>>>>>>>>>>>> node only if present _AND_ if CONFIG_OPTEE is enabled.
>>>>>>>>>>>>
>>>>>>>>>>>> Move the CONFIG_OPTEE enable in a fragment and we're done, you will only
>>>>>>>>>>>> select OPTEE explicitly on desired platforms, and won't run the naughty
>>>>>>>>>>>> OPTEE_SMC_CALL_GET_OS_UUID on old crappy platforms.
>>>>>>>>>>>
>>>>>>>>>>> I am still trying to understand what benefit does invoking
>>>>>>>>>>> OPTEE_SMC_CALL_GET_OS_UUID from platform code provides us. Surely it
>>>>>>>>>>> can't be used to detect OP-TEE not present when QTEE is running due to
>>>>>>>>>>> unknown behaviour with QTEE.
>>>>>>>>>>
>>>>>>>>>> Sorry but what exactly do you expect that will happen if you enable the OPTEE
>>>>>>>>>> driver when running with QTEE ?
>>>>>>>>>
>>>>>>>>> The OP-TEE SMC calls are not at all supported with QTEE, so the expected
>>>>>>>>> behaviour is undefined. IOW, the OP-TEE SMC ABI is not compatible with
>>>>>>>>> QTEE. However, it's going to be hit and trial method to see what QTEE
>>>>>>>>> responds to OP-TEE SMC calls. So it's not a reliable source of
>>>>>>>>> information we can use to detect which TEE is present or not.
>>>>>>>>
>>>>>>>> So until we know, this change is a no go, we can't just add the /optee node
>>>>>>>> and hope the person building uboot did the right thing.
>>>>>>>
>>>>>>> Not sure why you think Qualcomm platforms are special in this regards
>>>>>>> when similar OP-TEE node additions based on CONFIG_OPTEE exist for other
>>>>>>> platforms, see example here [1] [2] [3].
>>>>>>>
>>>>>>> The OP-TEE configs will surely be part of a separate config fragment and
>>>>>>> I can add comments there for developer's awareness.
>>>>>>>
>>>>>>> [1] arch/arm/dts/imx8mm-u-boot.dtsi:10
>>>>>>> [2] arch/arm/dts/imx8mn-u-boot.dtsi:10
>>>>>>> [3] arch/arm/dts/imx8mp-u-boot.dtsi:11
>>>>>>>
>>>>>>>>
>>>>>>>> I propose an alternate way, is to check for QTEE and then test for OPTEE.
>>>>>>>
>>>>>>> There are more combinations rather than just QTEE or OP-TEE as follows:
>>>>>>> - Older targets have support for QSEECOM
>>>>>>> - Newer targets with QTEE support
>>>>>>> - Chrome targets without any TEE support
>>>>>>> - IoT targets with OP-TEE support
>>>>>>>
>>>>>>> Do you have any particular mechanism in mind for detecting OP-TEE
>>>>>>> presence at runtime? And surely that has to be well supported on variety
>>>>>>> of SoC where U-Boot is supported as of now.
>>>>>>
>>>>>> OPTEE_SMC_CALL_GET_OS_UUID which works fine on like all the other ARM based
>>>>>> platforms.
>>>>>
>>>>> Can you share at-least one example of other Arm based platform where this
>>>>> SMC call is used to add OP-TEE DT node?
>>>>
>>>> AFAIK no other platforms does that, I never said it was a standard thing,
>>>> I said it would be necessary to avoid messing with the qualcomm proprietary
>>>> boot chain.
>>>>
>>>>>
>>>>>>
>>>>>> It's the only way, and only Qualcomm engineers can answer how to determine
>>>>>> without any risk which TEE is running on the system.
>>>>>
>>>>> The fact that you keep ignoring my responses that OP-TEE SMC ABI is not
>>>>> compatible with QTEE/QSEECOM SMC ABI is not going to change (see [1]).
>>>>>
>>>>> I am not sure why it's a blocker to use CONFIG_OPTEE for OP-TEE DT node
>>>>> addition on Qcom platforms when the same criteria is being used for imx8*
>>>>> platforms already.
>>>>
>>>> It is not, if the node is present the it's fine. I'm concerned by adding
>>>> the node when CONFIG_OPTEE is enabled.
>>>>
>>>> Usually, the ARM64 platforms are shipped with a well-known or compatible
>>>> boot chain like TF-A, and OPTEE is present or not. Those platforms
>>>> will add the optee node knowing it can be present, and knowing other TEE
>>>> won't crash if OPTEE_SMC_CALL_GET_OS_UUID is called.
>>>>
>>>> You propose the other way, adding the optee node when config is present,
>>>> not knowing exactly if the current system has optee or a qualcomm proprietary
>>>> TEE that could not survive a OPTEE_SMC_CALL_GET_OS_UUID call.
>>>
>>> Maybe I should have provided reference to the overall open boot stack [1]
>>> early which is being planned for IoT platforms to begin with. The PR for
>>> meta-qcom is here [2]. We are mostly waiting for the OEM only signing
>>> feature for TZ image to be available in XBL_SEC such that any developer
>>> can excercise that stack:
>>>
>>> PBL (ROM) -> XBL -> TF-A BL2 -> TF-A BL31 -> BL33 -> Linux kernel
>>>                                      |
>>>                                       --> OP-TEE as BL32
>>>
>>> TF-A and OP-TEE are going to be supported in a similar fashion on Qcom
>>> platforms as any other ARM64 platform.
>>>
>>> [1] https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/rb3gen2.html
>>> [2] https://github.com/qualcomm-linux/meta-qcom/pull/1172
>>>
>>>>
>>>> So my suggestion is:
>>>> - ask the boot team a sequence/way to determine exactly which TEE is loaded (using SMC, smem or whatever)
>>>> - only add the optee node if OPTEE or a compatible TEE is present
>>>>
>>>> Then if CONFIG_OPTEE is enabled & the node is present the driver will
>>>> be able to communicate with OPTEE.
>>>
>>> Hence, OP-TEE is going to be supported in a developer controlled
>>> environment only like any other ARM64 platform. So there is intention to
>>> reuse the same workflows here. Since it's an open source boot stack then
>>> it should be possible to use generic methodology if community comes up
>>> with that later in future. That's why we should avoid Qcom specifc
>>> platform code to enable such a feature apart from what others do.
>>>
>>> -Sumit
>>>
>>>>
>>>>>
>>>>> [1] https://lore.kernel.org/all/aWjrLF9DUPTaSA1c@sumit-xelite/.
>>>>>
>>>>> -Sumit
>>>>>
>>>>>>
>>>>>> Without this, all this discussions is pointless.
>>>>>>
>>>>>>>
>>>>>>> Also, there is added complexity for targets where the developer can't
>>>>>>> change the TZ firmware themselves on Qcom SoCs due to QTI signing
>>>>>>> requirement.
>>>>>>>
>>>>>>> -Sumit
>>>>>>>
>>>>>>>>
>>>>>>>> Neil
>>>>>>>>
>>>>>>>>>
>>>>>>>>> -Sumit
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Jens,
>>>>>>>>>>>
>>>>>>>>>>> Will it be fine with you to expose is_optee_api() from the OP-TEE driver
>>>>>>>>>>> for the platform code to invoke it independently? Just for the sake of this
>>>>>>>>>>> discussion in case people still insist on it being the right thing to do.
>>>>>>>>>>>
>>>>>>>>>>> -Sumit
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Neil
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> My suggestion would be to make this SMC call if CONFIG_OPTEE is enabled
>>>>>>>>>>>>>> in qcom_psci_fixup(), compare the UUID and add the node if it matches.
>>>>>>>>>>>>>
>>>>>>>>>>>>> That's exactly the first SMC call that U-Boot and Linux OP-TEE driver
>>>>>>>>>>>>> does to compare the UUID here [1] and bail out of the driver. I don't
>>>>>>>>>>>>> see a value of a redundant invoke in the Qcom specific platform code.
>>>>>>>>>>>>>
>>>>>>>>>>>>> [1] drivers/tee/optee/core.c:823:   if (!is_optee_api(pdata->invoke_fn))
>>>>>>>>>>>>>
>>>>>>>>>>>>> -Sumit
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> [1] lib/efi_loader/efi_variable_tee.c
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> So I think the more appropriate patch here would be to just enable
>>>>>>>>>>>>>>>> OP-TEE in qcom_defconfig (assuming the binary size isn't significantly
>>>>>>>>>>>>>>>> affected).
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The OP-TEE driver in U-Boot itself is probed based on DT and it's not
>>>>>>>>>>>>>>> only specific to Qcom platforms but every other platform using OP-TEE.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Considering the other patch is based on this assumption that if OP-TEE
>>>>>>>>>>>>>>>> support is enabled then the board must be using it, a different approach
>>>>>>>>>>>>>>>> is definitely needed.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Yeah that's true even with TF-A boot flow, there is possibility to boot
>>>>>>>>>>>>>>> without OP-TEE as well. However, TF-A generally doesn't provide a
>>>>>>>>>>>>>>> generic option to detect whether OP-TEE is running or not.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> When I was looking into this last year I remember discussing this same
>>>>>>>>>>>>>>>> issue from the Linux side, there is a good argument to be made that
>>>>>>>>>>>>>>>> OP-TEE support in Linux shouldn't be based on the devicetree -
>>>>>>>>>>>>>>>> particularly in the Qualcomm case where whether or not OP-TEE is used is
>>>>>>>>>>>>>>>> a simple software change, nothing to do with hardware.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Sadly it's true for every other silicon vendor too. But OP-TEE support
>>>>>>>>>>>>>>> based on DT has become an ABI unless migration for OP-TEE support based
>>>>>>>>>>>>>>> on FF-A comes into picture.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> So in general I'm not particularly keen on this approach, I think it
>>>>>>>>>>>>>>>> /might/ be acceptable for U-Boot to have some fixup code to add the
>>>>>>>>>>>>>>>> OP-TEE node if OP-TEE is in use with the idea of phasing that out in
>>>>>>>>>>>>>>>> favour of runtime detection in the OS itself. I'd also expect that fixup
>>>>>>>>>>>>>>>> code to go in the generic U-Boot DT fixup code that runs before we jump
>>>>>>>>>>>>>>>> to the OS (like the EFI DT fixup function).
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The EFI DT fixup code is already there based on U-Boot DT. Have a look
>>>>>>>>>>>>>>> here:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> boot/image-fdt.c:627:   fdt_ret = optee_copy_fdt_nodes(blob);
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> In general on Arm platforms there isn't any SMC bus to detect
>>>>>>>>>>>>>>> dynamically if there is support for OP-TEE or not. That's why
>>>>>>>>>>>>>>> platform bus was choosen for the U-Boot and Linux OP-TEE driver. It's
>>>>>>>>>>>>>>> similar to how we have the SCM DT node for Qcom platforms.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> FF-A bus tries to solve that problem to unify that approach for future
>>>>>>>>>>>>>>> platform but U-Boot hasn't yet gained support for FF-A based OP-TEE
>>>>>>>>>>>>>>> driver too.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Anyhow, this is the sanest way I can come up with to enable OP-TEE
>>>>>>>>>>>>>>> support in a general way for all the Qcom platforms. This is aligned
>>>>>>>>>>>>>>> with how OP-TEE support is detected for other silicon vendors too.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> -Sumit
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Kind regards,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> For more information refer here:
>>>>>>>>>>>>>>>>> https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/rb3gen2.html
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>        configs/qcom_tfa_optee_defconfig | 7 +++++++
>>>>>>>>>>>>>>>>>        1 file changed, 7 insertions(+)
>>>>>>>>>>>>>>>>>        create mode 100644 configs/qcom_tfa_optee_defconfig
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> diff --git a/configs/qcom_tfa_optee_defconfig b/configs/qcom_tfa_optee_defconfig
>>>>>>>>>>>>>>>>> new file mode 100644
>>>>>>>>>>>>>>>>> index 00000000000..c398521770f
>>>>>>>>>>>>>>>>> --- /dev/null
>>>>>>>>>>>>>>>>> +++ b/configs/qcom_tfa_optee_defconfig
>>>>>>>>>>>>>>>>> @@ -0,0 +1,7 @@
>>>>>>>>>>>>>>>>> +# Configuration for building a generic U-Boot image
>>>>>>>>>>>>>>>>> +# with support for TF-A/OP-TEE based Arm TrustZone stack.
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +#include "qcom_defconfig"
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +CONFIG_TEE=y
>>>>>>>>>>>>>>>>> +CONFIG_OPTEE=y
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> -- 
>>>>>>>>>>>>>>>> // Casey (she/her)
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -- 
>>>>>>>>>>>>>> // Casey (she/her)
>>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>

-- 
// Casey (she/her)

