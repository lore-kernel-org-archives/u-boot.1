Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4ACC531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 08:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E3D7605CA;
	Thu, 23 Jul 2026 08:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6u_Najca4eX; Thu, 23 Jul 2026 08:48:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 515FF60602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784796505;
	bh=U1hp6ZtnzPCBvDBXGRJ8fDKIaQW1esJsupq39xB+3JM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=TyMN5h3Y5a2oH5DpcwjPyFcD9qZJmdWjxV6KmrswQtFDcFxpbgWvz+uN9KvLt2oJm
	 LGkZJ1C+K0LquEGE7Zfa6di0/YSfz2bqf7n+2hUf0F1ET1V7RNsVg30K8pf3m1lDpD
	 q0oEzyIkOMymTkKx5at+F4kmq8nDSYzzfUUJR9hX23vpxFibX/qtE1Cgbji1tSI3s+
	 ni4xImvyHQJ4bc/zeVr+1a6KVAcxqDWNs3pIXWezM39jfxt/jEQR4FUVvgXWgDf+Al
	 pu/57Tej+/a715ALLHK3E/HFAZX45ep75OcpVXCgeq+MPRITXpeUgszsGoyv/7kvsW
	 AHLEqU5mMVUzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 515FF60602;
	Thu, 23 Jul 2026 08:48:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D499039E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA2AF40743
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0D8GTljbnaya for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 08:48:22 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 42A164056E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42A164056E
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42A164056E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:48:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C8888404D; Thu, 23 Jul 2026 10:48:20 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 147A9803F6
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 10:48:17 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so3072145e9.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 01:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784796496; x=1785401296;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U1hp6ZtnzPCBvDBXGRJ8fDKIaQW1esJsupq39xB+3JM=;
 b=QBgh38hJCTUcm21fZ44clZiz4L3SGiEGPPUNB6wT6t8gK5+t5xsJRyhXtNGlmaxo+S
 RPqnQcIY8MvPR+x4W3JLFwwp9mdMQP1hibconWat9iKT1Zq1grE0Br829TA2MR5R2z7S
 5s4VgI7Wyp4z/3VIMe3qFZWn+gSdQxwt3FtFHZmlTIPPMbNd7w7DxRNe8YUf5BTcOs5U
 5n5Emdak/3UBVBOnbw20DbIZRbnzXodAgHryR5jdj/Eu6ZzAQaXR7QKH8yMxGTwdChcG
 mA2v0QnnznS4pgi/hKGhRdA9a2haQ4/L+G3MiQYrK4EBhuP7W5LSAbfbf17oz2RINtTy
 BgIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxPHpO0wWAvYItL69h/wgzGSPA1tJ3DStV1ZSiXUyFdih8UzwWTI1LlmmQGqaZv4vRtT5JQRE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy88B4vHK8TeyqKO/KsJ/CwidRMApPWOM8HrfZuEbneN9dIMzZR
 CPSWOXQhoMYQ19c2B2caXkTI4vbEFBhXcZeuiywitIeW7IFNsIvz9sqw+i6WBscdWVA=
X-Gm-Gg: AR+sD12QGH+a5PMRgZFIamW9yU87dC/U9drhm/8VtLncbF1W0x9RC1PLQG3oNpVKbcH
 U60jnyFACK/zO79Y2NFWRDRpes901CWW9cqTIeAJzaHcvVJdVYAct95wsmMdi7wJS8CYuKivhmE
 CDKP8VP4MZ+s76WmySqMgtjAwxQDTD8Jz9quuj2FuQAv7lvPOxJuul/yw+nlN2lph1rYAT8sz7c
 i6nxRlZVBdmHAD5em3C9NAt9wIV6270YrIIkyaBvH8km7BKcqrJqVu5lGfAbIt+BFk2nL88dN2u
 VSSZ9cMu+j+nkOE6uFCiw/Rmmrw7RVGIidR/oFa0Db5th5O7LuZ4oSTrIBOjRgm8FJxQ8ERetAp
 I/fzN5CQNE40+1/fvsnIC/0TvKG5PBMquQDh7ZbcJuq1g63XMzh91jDqPhqGLoGq2DwVDf/X6X9
 MgWLrZFQ1Mbq6s0AFxXRyHVHqAujXWutsxzAakO6UAeG7pkihb//QmyUSyXQ==
X-Received: by 2002:a05:600c:3111:b0:493:cc25:9c0e with SMTP id
 5b1f17b1804b1-49573c996e7mr22920185e9.14.1784796496181; 
 Thu, 23 Jul 2026 01:48:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:f234:5e35:82ba:6d6c?
 ([2a01:e0a:106d:1080:f234:5e35:82ba:6d6c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm210671775e9.3.2026.07.23.01.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 01:48:15 -0700 (PDT)
Message-ID: <871bc7a2-0db3-4349-b0ee-6909147cac57@linaro.org>
Date: Thu, 23 Jul 2026 10:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 4/5] optee: rename rpmb.c to rpmb_legacy.c
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, trini@konsulko.com,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 shawn.lin@rock-chips.com, igor.belwon@mentallysanemainliners.org,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, padmarao.begari@amd.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, dlechner@baylibre.com, u-boot@lists.denx.de
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-5-jorge.ramirez@oss.qualcomm.com>
 <f73c5fb0-881a-49bf-a5ff-a0120ab3e3b2@linaro.org> <amCRWI7K4Jj_psYp@trex>
 <CALeDE9PV=1-8sgWZn7n3w9A2p6A_TDus1gHyjetaT_oR5uA0Cw@mail.gmail.com>
 <c4846039-2d4d-4436-a4bd-3baf16547319@linaro.org> <amDVFDwma9_JZ2cN@trex>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <amDVFDwma9_JZ2cN@trex>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784796496; x=1785401296; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U1hp6ZtnzPCBvDBXGRJ8fDKIaQW1esJsupq39xB+3JM=;
 b=UHHKy3JXi8fWkq2L6TmIOS6KeBE4FWISHVwed55tVm7az32lUxfNxe231P46ShHw8l
 MWoGj9LowjORAgUIeFYg+vZ4OkfsiKidekZoTsJ3szDIn1fNu79n0WcIHs2ZAB0r7a2G
 COBy7aphFeuHxWDCLSd40P/gFGNWtGJTdeyu+ppZj/cYCMIt3rtSI4Zm0jBJ5WfNyEZk
 o4ge7rdneDezEQmpGmSrOFf7K4cAkHNIzkcIdgN12JrLVcQy91HCtwPes0em6jNFzjJg
 SFbncDBwEQAquSDxPRT9IeSt+YPfUiyoWNuajdPhzPaSbbcY31t7jFDEj+vGZhp9feXS
 WyVw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=UHHKy3JX
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="UHHKy3JX"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/22/26 16:35, Jorge Ramirez wrote:
> On 22/07/26 15:10:16, Neil Armstrong wrote:
>> Hi,
>>
>> On 7/22/26 14:33, Peter Robinson wrote:
>>> On Wed, 22 Jul 2026 at 10:46, Jorge Ramirez via U-Boot
>>> <u-boot@lists.u-boot-project.org> wrote:
>>>>
>>>> On 22/07/26 10:27:22, neil.armstrong@linaro.org wrote:
>>>>> On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
>>>>>> This file implements the legacy single-command OPTEE_MSG_RPC_CMD_RPMB
>>>>>> supplicant (eMMC only). Rename it to rpmb_legacy.c so the primary rpmb.c
>>>>>> name is free for the RPMB subsystem interface added next; pure rename plus
>>>>>> its Makefile object, no functional change.
>>>>>>
>>>>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
>>>>>> ---
>>>>>>     drivers/tee/optee/Makefile                  | 2 +-
>>>>>>     drivers/tee/optee/{rpmb.c => rpmb_legacy.c} | 0
>>>>>>     2 files changed, 1 insertion(+), 1 deletion(-)
>>>>>>     rename drivers/tee/optee/{rpmb.c => rpmb_legacy.c} (100%)
>>>>>>
>>>>>> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
>>>>>> index 36ac085ef42..8321cf53a19 100644
>>>>>> --- a/drivers/tee/optee/Makefile
>>>>>> +++ b/drivers/tee/optee/Makefile
>>>>>> @@ -3,4 +3,4 @@
>>>>>>     obj-$(CONFIG_OPTEE) += core.o
>>>>>>     obj-y += supplicant.o
>>>>>>     obj-$(CONFIG_DM_I2C) += i2c.o
>>>>>> -obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
>>>>>> +obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
>>>>>> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_legacy.c
>>>>>> similarity index 100%
>>>>>> rename from drivers/tee/optee/rpmb.c
>>>>>> rename to drivers/tee/optee/rpmb_legacy.c
>>>>>
>>>>> Why not rpmb_emmc ?
>>>>>
>>>>> Neil
>>>>
>>>> right this is what is confusing about the current abstraction; op-tee has two modes:
>>>>
>>>>     1. Legacy mode (legacy_operation = true)
>>>
>>> Does the spec refer to this as legacy mode? Presumably it's RPMB on
>>> eMMC vs RPMB on UFS (or presumably also NVME) or the revisions have
>>> actual version numbers. Maybe name it after the interface that
>>> supports the revision, or the actual revision of the RPMB spec, as
>>> opposed to just legacy. What happens when next version comes along, to
>>> we rename legacy to old_legacy so we can have new, legacy and
>>> old_legacy?
> 
> yeah, Neil addressed this below. I agree with you Peter but sometimes
> legacy can be appropiately used (I believed that this to be one of
> those binary instances).
> 
>>
>> So I did a small dig and both commands are still referenced in OP-TEE
>> and the TEE supplicant.
>>
>> But indeed the OPTEE_RPC_CMD_RPMB command is only used in the userspace
>> TEE supplicant _and_ U-Boot, while Linux uses the other RPMB Frames
>> command like this implementation.
>>
>> In OPTEE the usage of OPTEE_RPC_CMD_RPMB it's explicited as "legacy" in
>> https://github.com/OP-TEE/optee_os/blob/991587c721a603e831cad228626078289adad159/core/tee/tee_rpmb_fs.c#L486
>> so we can describe it as "Legacy", even if it's not described as legacy
>> on in the OP-TEE headers nor in the TEE supplicant.
>>
>> But, I'll stick to my proposal to rename as rpmb_emmc and rpmb_ufs and
>> add a comment in the rpmb_emmc explaining it uses the OPTEE_RPC_CMD_RPMB
>> and may need to be add support for the FRAMES commands.
>> And the other way around add a small comment in the UFS implementation
>> explaining it only supports the FRAMES commands.
> 
> 
> I'll push back (one last time), my point being that I expect rpmb_legacy
> to disappear where as rpmb_mmc or rpmb_ufs will not (and I see no reason
> to keep them in separate files): hence the pursue of a single rpmb.c
> 
> if after this you still want to separate rpmb_ufs and rpmb_mmc I'll go
> ahead (but we will lose that temporary hint to the op-tee dependency)
> 

Well I'm not sure it's "legacy" as we speak because it's very probable
some OP-TEE binaries used in production right now uses the OPTEE_RPC_CMD_RPMB,
so ultimately we need to support both on any storages to support any OP-TEE
versions.

My point is after your changeset, one file is hardcoding eMMC support and
the other is hardcoding UFS and there's no dynamic Device Model way to
dynamically register an RPMB partition for any storage.

So ultimately, this should be implemented using Driver Model and the
eMMC code should live in eMMC subsystem, same for UFS, by registering
an RPMB subdevice like this is done on the Linux side.

But for now, rename the file relative to it's content to avoid any confusion.

Neil
