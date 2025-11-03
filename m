Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C752CCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 12:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9B5836D1;
	Mon,  3 Nov 2025 13:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IbUcIVzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD52B83700; Mon,  3 Nov 2025 13:31:52 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BDDA8331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 13:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-475d9de970eso29275315e9.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 04:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762173110; x=1762777910; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7u4drtkIvQ7XcT9xzz9kQ3R63BETh+M3iFtxEbTsGrc=;
 b=IbUcIVzn3Syhuzdc3P+uWW3SLrPCh+qTQ6XS9MkGZeDCXVxDX+xZCcGFATR3zTGece
 JBvIiSy2kbjNM9Q/AfoA5a4QWObCzAoBVbUb7n9xoUmtX0yrD3N/Aui+HaXkaKFxDXoR
 H0ePWUYDMRrXjokEq+XMEUFL8BZ9G9ms1xoTrcOJx8OJTpCBWkwVLtwCSYnaBud1KKPv
 SMzXdpAPz2Sm5DFTGuEaCh7P7fx0IqdWQoCjF61M1Oz1VZHGdkX0fr/GSbXPzhDrSQyD
 6uZmKdF6rya5tfyTng8xy+HCOO0cTKQf0XOzeNCTlffmYH4zyFPs0AvF3I4Mx9wzR+7K
 LqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762173110; x=1762777910;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7u4drtkIvQ7XcT9xzz9kQ3R63BETh+M3iFtxEbTsGrc=;
 b=nUGdkowyYlM+LdSc9xwVMG+lUmunGVfkMGQok8AxwBU79TA5LyLSox8ldJMTr2aDMO
 0ACKXJuTwKYVNvs9EQS/KejZTyzbAe4k1N/giTDJmW38yZ1C6zkOuqJO/X8rdgnEMn4C
 lkZTDBCTTB8pwOcClW0RmF+LH8Hl38hkGmSlQFYdvlXBthHYT5/lawWYPnPxTgXRpFE7
 SDZUOAq27M61FdpkvqwwOAKk3Q1B2fU7HdhuMTIDX6zfFnBv4KAj6eUuKXw+HK7/F5yM
 LsIpIPTdYIYdKYZIluaLGWpt7ICVXIdlOxJO3hLK7xh2eG161gvMGV3OdNEyBHvClKjb
 IjBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdtJYyd3Ux9lqFndQG+vwSke9Go6gvGveM6C1KP7B6q4OP6GTLu9rT3KVgEU9mHggsjXbsrs8=@lists.denx.de
X-Gm-Message-State: AOJu0YyUcIapmNYmYgMcLHLTM24u6vsvomtT+hSXvHm7fpjiR+uUoMT9
 JvLCuSctRK/zeg69aqgIq2Bgz7mW4zCtokSxFpbPRMybjNhmPK9Sn51ffvEvNglpswo=
X-Gm-Gg: ASbGncvrXEUGFgolreSTXqsVxVE3jNjoeFu6mnQCN35J6XMYpRQvhdenvdrHHbwl5Sc
 /9LYdSvRLGP6o1TXt/qOnhH8KO0ifr+VofnCgmfbHnx/P7Nth2hMq//MaXGXsiIZSo0ez8OcCgp
 go8WG9JbGemaBgkHUU4RqYgi3vdntrc77fJLhl2nSPl/PQspOzQDQFSuvJBAs+TByvDJfYlXUCw
 HhGum5kwRtQjL6iirx1yMA06nYoTmRvOrh8GpeTLA24qanWXovl3RxGnX5dDkdVyCKhCVy8VQ1j
 6xcd7LL2Uq3Pd5E1AL7TgaeaOpIajdPJfdDtqYHpSOgFcM0BCVWsB1FDHX/p6A9rRWKt/UBjI73
 diduxmB656yKOqwyXuoAOob46P+dMd4gypkCbafLrlxn+aHVcnAYxaa55upNYl1o3TuCbTCCc+a
 7I5Fbe5TJZ2Uz903xjBFf9CLDUy6fzjKNLnu7jXkjaPCgdxQ/eHTY=
X-Google-Smtp-Source: AGHT+IGlk1Nlr4IUnE3eSswuNbVOQbyaaGVM4m4h6DTk5Gda157Tor4/ui3MpgBBoUW8aSTpAFf5Zg==
X-Received: by 2002:a05:600c:a48:b0:475:dd04:1289 with SMTP id
 5b1f17b1804b1-4773086d50dmr103040055e9.20.1762173109746; 
 Mon, 03 Nov 2025 04:31:49 -0800 (PST)
Received: from [172.18.195.54] (ip-185-104-138-158.ptr.icomera.net.
 [185.104.138.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c5647e1sm153585285e9.15.2025.11.03.04.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 04:31:48 -0800 (PST)
Message-ID: <caea13ec-4b90-4a7e-85f7-023e42365a7a@linaro.org>
Date: Mon, 3 Nov 2025 13:31:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] mach-snapdragon: fixup power-domains
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, trini@konsulko.com,
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
 <20251027113312.3815169-4-aswinm@qti.qualcomm.com>
 <ea83aa0d-9db8-4a7a-8b4e-bf32c9aa4ffc@linaro.org>
 <3af79816-26e0-4403-988f-29858bf569d3@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <3af79816-26e0-4403-988f-29858bf569d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 10/31/25 11:12, Aswin Murugan wrote:
> 
> On 10/28/2025 6:32 PM, neil.armstrong@linaro.org wrote:
>> On 10/27/25 12:33, Aswin Murugan wrote:
>>> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>>
>>> RPMH power domain properties were initially removed from the
>>> device tree due to the absence of driver support. Since RPMH
>>> power domain driver is added now, the fixups are removed.
>>>
>>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>> ---
>>> v5:
>>> - No changes to this patch in v5
>>>
>>> v4:
>>> - Reverted the inclusion of qcom-rpmpd.h header in pervious versions.
>>>
>>> v3:
>>> - Removed OF_LIVE_SA8775P config, since there is no SA8775P specific 
>>> fixups are done
>>>
>>> v2:
>>> - Removed the power domain fixups, since the power domains are 
>>> handled in qcom-rpmhpd driver
>>> ---
>>>   arch/arm/mach-snapdragon/of_fixup.c | 31 -----------------------------
>>>   1 file changed, 31 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach- 
>>> snapdragon/of_fixup.c
>>> index eec2c0c757e..93c16821e54 100644
>>> --- a/arch/arm/mach-snapdragon/of_fixup.c
>>> +++ b/arch/arm/mach-snapdragon/of_fixup.c
>>> @@ -116,36 +116,6 @@ static void fixup_usb_nodes(struct device_node 
>>> *root)
>>>       }
>>>   }
>>>   -/* Remove all references to the rpmhpd device */
>>> -static void fixup_power_domains(struct device_node *root)
>>> -{
>>> -    struct device_node *pd = NULL, *np = NULL;
>>> -    struct property *prop;
>>> -    const __be32 *val;
>>> -
>>> -    /* All Qualcomm platforms name the rpm(h)pd "power-controller" */
>>> -    for_each_of_allnodes_from(root, pd) {
>>> -        if (pd->name && !strcmp("power-controller", pd->name))
>>> -            break;
>>> -    }
>>> -
>>> -    /* Sanity check that this is indeed a power domain controller */
>>> -    if (!of_find_property(pd, "#power-domain-cells", NULL)) {
>>> -        log_err("Found power-controller but it doesn't have #power- 
>>> domain-cells\n");
>>> -        return;
>>> -    }
>>> -
>>> -    /* Remove all references to the power domain controller */
>>> -    for_each_of_allnodes_from(root, np) {
>>> -        if (!(prop = of_find_property(np, "power-domains", NULL)))
>>> -            continue;
>>> -
>>> -        val = prop->value;
>>> -        if (val[0] == cpu_to_fdt32(pd->phandle))
>>> -            of_remove_property(np, prop);
>>> -    }
>>> -}
>>> -
>>>   #define time_call(func, ...) \
>>>       do { \
>>>           u64 start = timer_get_us(); \
>>> @@ -158,7 +128,6 @@ static int qcom_of_fixup_nodes(void * 
>>> __maybe_unused ctx, struct event *event)
>>>       struct device_node *root = event->data.of_live_built.root;
>>>         time_call(fixup_usb_nodes, root);
>>> -    time_call(fixup_power_domains, root);
>>
>> I think the fixup should be removed only if QCOM_POWER_DOMAIN is 
>> enabled, no ?
>>
>> Neil

Hi Aswin,

>>
>> In line with the previous review comment in thread Re: [PATCH v1 0/4] 
>> Added QCOM RPMH Power Domain Driver - Casey Connolly <https:// 
>> lore.kernel.org/u-boot/5afbdafa-a0f9-4146- 
>> b64e-8869f68bc7f8@linaro.org/#t>, which recommended the complete 
>> removal of the fixup code, we have removed it accordingly, also the 
>> QCOM_POWER_DOMAIN config is enabled by default in qcom_defconfig
>> Please let us know if you would like any further changes or adjustments.

Yes ideally the fixup code would be removed, but we support platforms 
like msm8916 (apq8064) which use rpm (no H) which are not supported by 
your series.

So I think the fixup code needs to stay, and we likely need some kind of 
runtime check (best I can think of right now is checking if the 
compatible string ends in "rpmpd" or "pmhpd" and only doing the fixups 
for non-rpmh platforms).

Sorry if this wasn't communicated very clearly, hopefully it makes sense 
now(?).

Ideally we'd be able to have ARCH_SNAPDRAGON select the rpmh pd driver, 
but since it isn't needed on some platforms it doesn't make much sense 
to do that I guess.

Kind regards,
Casey (she/they)

>>
>> Thanks,
>> Aswin
>>
>>>         return 0;
>>>   }
>>

