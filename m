Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9C606A33E
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pfKZbuY7;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jKavjda3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77DCE81443;
	Thu, 19 Nov 2026 16:08:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i2u-s8-c2m5u; Thu, 19 Nov 2026 16:08:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B3B0C81447
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795104483;
	b=SuajTnAxC5T+W6KZFk57/6jPG70jOB24YpAUKHuYXMI06o+Kzb61ao6dKwZBMdPnyOyU
	 vCz4dCaDVhr/IAltF08hw5NLYq7fSsW8Cvs8Gw4t0EyngS5jxkHAeNuaeaAnmwX3on24j
	 y5yojj2tx9v4vHSsEehnDzE9MuxxisyTPx8KFRKngMX/tjJMIo+zd+twGqvIMtpDpBZBD
	 S/HhRxQ6z9yL7D1WL3VKclV3dnUcd0+vC60DLaa+rJSU4xKKRg+xf2j/QhDXbTRuYmU8D
	 0jrEIFv5sYN3Ht1Igo7BNyvooS0tnYrP7JvbMGTRacU5vp9E9euOk8uuCBFYX5AmhpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795104483;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jSvrYzoGjCCw1TAcslxsXXfST6BoMDAPk7mjSbg53qg=;
	b=rAADedQtzVQafOsgH4tSJQPakSK9ZTiB0mcoVHwHZnrPDZ/DjL7f8q7U7LktfXZDmjWs
	 28nkwzpAGhL8mydSHCS5Y8pvwIFqKdPB4VG11MIB74epYXqUyjxfUnbrSLcYoX05gVJsR
	 ukyPpdHHPvflYDyfEcczDThvme3Zs0U6pBDL0YcVeA64xtIoj1PALdkba6qdaAemqR5CC
	 aWJu2LSQpGHnzYy1sCCIRU+7SvxFDRwmM0PtnF6KqRDmHx1cRvvjsDdvfaa+VD+89XVuz
	 5u9cwbAaIDCtz9c5xLVkPpp/HlVef/CqZ9RyJlpDodNbsdfk8D6ECWQ18NspUFdooxw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795104483;
	bh=jSvrYzoGjCCw1TAcslxsXXfST6BoMDAPk7mjSbg53qg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pfKZbuY74dC1GVUgfLPTQpZfU/V8AsIEBZ1T1xyFVkPf/z1o9qmJ7YBrzKlaYQzkx
	 EU3uwwmdIbDfTlTV3+ZQOnPV62+kpR6Mmb3PedaJwh8842tJnC1Wc72fBRwHQ4SJ+9
	 pd4QGWtHgHupu3uaCrggY9ytpOfhxM86SWnPf5lQ6k05MZJjtwNhgXQGFi/aC0zHHp
	 KRIllzuvZh0FN4JQ+V4u4dPIf2ReTLlR1BigDbnldN0otD9xlAaoZIoyvwls6rwN1Q
	 2Rpjyh6offL81IGR9H0MmCDW7nyTBeyTWx3y6bmzSg6X2aTWjwbeFU+OJG5NGVp0rS
	 5vcUTnICBQC4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3B0C81447;
	Thu, 19 Nov 2026 16:08:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4624465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5C0C40556
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:08:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GrV4EzNx6-pC for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 16:08:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8E232400E6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jKavjda3
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E232400E6
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:08:00 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5c126f80426so2181723e87.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 08:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795104478; x=1795709278;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jSvrYzoGjCCw1TAcslxsXXfST6BoMDAPk7mjSbg53qg=;
 b=jKavjda3wZqb1JBBTnIVIaSRU+5HqM7vukbdhFh28An6S5l75fRDUZy0DCEuqU9hV3
 clkVHWG2StTA06CrNS+5kovK4fJBBF2H+iutbd03NUN/IXABHSHmdpuSYac/W9LuF4zy
 WRDWdfIsOgz9SLl0EHThGA3eqJ6vOQHxPDtlTA1Lt2UslziSOwMZh79EOPNXQ38To55U
 5FAkG1fERDIKrw7k1CVCiqGsKYSBXNw3dzqeMsaHSF1zyf5imxdnCoZH1CJ5EQ6ZA8sl
 w/mniJ1cW3o30WbLGxWp5H1Oalal0jl8XtXmodZmgoMy/wjW07oOTRLMpZXVk+FcBkft
 c/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795104478; x=1795709278;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jSvrYzoGjCCw1TAcslxsXXfST6BoMDAPk7mjSbg53qg=;
 b=pzfdR4HMh03Cqssl83jBa/Qm768eParbAKdBzVkduxmP/Wx7iucjvM3VVLF6VB0PrB
 4TsbDska/rg7a200QdaXkUUIpKJSUiiW0eUldcTWjpRU4TuNI94R4suRi5pV39Ek0EBd
 PJh1ZWlz2fQY00n8smURj6MrkbE1YvCRcUJafQmqyVRdMtp4+VgIWOdFiTcp3OjpNbDx
 1DOR39LZ3mwn7PRLVkQI6kHE8K3YFcGvLL+fV8/2NTGErjjU+aQVM/X/+PmcXpVG2nLL
 I3e6odkNTFxX2JMSYGVWWcUPhajuV4ijHVHRWGKj/f0YNT9Ars/3B7KP76DF+49ArnyM
 CYTA==
X-Forwarded-Encrypted: i=1;
 AL+hErH73h1hr+ABEua4MmJAgQPwBABo3m1zXN/l79taYOUv2XdHobFaWnbV2/qXSnH4MGYX5SONfus=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/14LKhAj9ENpCGzyLPpHvsCYiyiL0ZMt+j2cTlsYfO/5IqRDKQ
 PBFo+jC5qYH7E6TTsYHtdluWr791oiGF4miFAoraGc6m0tQbUB7oSVg2IuR3r+rO9Mg=
X-Gm-Gg: AYBFou3wONUHsbeywvBIrEv+tkV3fJRGIe5WZ1w/SO9fGtbWJ5V2o57XmxH5ct8Xk6e
 G/Qavhjm7PTQ4dftgfBtnSp3U20s8a7lEdaKGx/8cSfxX3m8f/F1q0Nj3xYpecVUguE6zNxeTa1
 4NVB+nYQ7GzdtuKyBr8aNge8N1DNdEJnksoInc+ZYgDmFMm60R7mqCksNK8xrAHg4gMb3V/8PSi
 wTj9/Mx49hZ2RTMl0ux4H3AIHf/GND/qnwZbpMDFSqFChA5L/DlDGF8hCKXO4BjWH+5TjXhhnom
 a8m5wXqZZHlISKkQ9RptFPtfHGzV+j0Os2CnY3NZ531iiojDEbFi/hO3MWXZNMYw7ZU9YI/OcV7
 HoWLgcGe+hVPM6iVCHc3md97Wv4bhqTQpomKjPFXlWCbDaLekHpNil660dXmrYu3jSnoSQmzfFk
 Spo0sDGujzr9WpP6rbw3gQzTfeaxNsFKe+0MKtHQWEw6dx2XgeOcM78zN/gJnFIjgBFQQyytIq/
 C5INWchgDQgzLdBMnjsiv2MUZRZV1GIdAURl7PjrKH3TdQ245zYl+lXPGzBp+Kf9yVcMk/SPjD0
 vYYeLtrvmi62292O8zqwVGK8Cx2QIr8kXXUqqPFbDJyQLQlsegmpKU/8vOtk6qkLUURiAreiqWN
 4Dn8=
X-Received: by 2002:ac2:4c49:0:b0:5c1:4cd0:9a81 with SMTP id
 2adb3069b0e04-5c1bc8a4b71mr30001e87.62.1795104477870; 
 Thu, 19 Nov 2026 08:07:57 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:43e1:bc37:7497:58db?
 ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1aa772c50sm1733487e87.40.2026.11.19.08.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 08:07:57 -0800 (PST)
Message-ID: <c84de235-1480-4747-9509-65af404cc9d4@baylibre.com>
Date: Thu, 19 Nov 2026 10:07:53 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: mediatek: enable the caches in SPL
To: Steffen Dirkwinkel <lists@steffen.cc>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 Chris Chen <chris-qj.chen@mediatek.com>
References: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
 <20261109-std-upstream-mt8188-spl-caches-v2-1-78cfb3e90c55@beckhoff.com>
 <26e0a77c-5188-47c1-a1e5-4caca8fd082d@baylibre.com>
 <a8d398c2-dc1e-470c-b194-b2fc606fd8dd@baylibre.com>
 <64e14026167e62b077a4999dd6283f96869f8a5a.camel@dirkwinkel.cc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <64e14026167e62b077a4999dd6283f96869f8a5a.camel@dirkwinkel.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 6:23 AM, Steffen Dirkwinkel wrote:
> On Mon, 2026-11-16 at 10:43 -0600, David Lechner wrote:
>> On 11/9/26 3:46 PM, David Lechner wrote:
>>> On 11/9/26 9:13 AM, Steffen Dirkwinkel wrote:
>>>> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>>>>
>>
>> ...
>>
>>>> +/*
>>>> + * MMU and caches before U-Boot sets up its final page tables
>>>> + */
>>>> +
>>>> +#include <cpu_func.h>
>>>> +#include <asm/global_data.h>
>>>> +#include <asm/system.h>
>>>> +#include <asm/arch/misc.h>
>>>> +#include <linux/sizes.h>
>>>> +
>>>> +DECLARE_GLOBAL_DATA_PTR;
>>>> +
>>>> +#define EARLY_TLB_SIZE	SZ_32K
>>>
>>> Can we get a comment that explains why this size was chosen?
>>>
>>>> +
>>>> +static u8 early_tlb[EARLY_TLB_SIZE] __section(".data") __aligned(SZ_4K);
>>>> +
>> I was doing some testing with this and adding this to the .data section
>> makes the image too big for the SPL download agent that Carlo has added
>> recently. So we might need to use a different way to allocate this memory
>> in SPL vs. U-Boot proper.
> 
> Yes, I also ran into it with the SPL of the U-Boot download agent and have
> explored some options last week, but didn't really get to a conclusion:
> 
> 1. A patch adding "CONFIG_SPL_MTK_EARLY_CACHES is not set" in mt8370-genio-da-
> uboot-fastboot.config. This works and only makes the fastboot usecase slightly
> slower

This sounds fine to me. We could end up running into problems still though
with Genio 720 SPL download agent since it has to enable much more features
though.


Getting off topic:

Carlo, For Genio 720, I was not able to make a U-Boot proper download agent
that fit so I'm wondering if we just just drop it on 700 so that there is
just SPL download agent on all targets to keep things simple and consistent.


Back on topic:

> 
> 2. Using malloc_f: This works, but seemed quite complex to me. We'd have to
> manage the sizes for all boards and might want to handle it differently in SPL
> and U-Boot proper.  Increasing SYS_MALLOC_F_LEN breaks the stack offset check on
> Genio 700 and the fastboot configs.
> I also looked into moving the cache setup earlier as with your DRAM handoff
> series fdtdec_setup takes around 400ms without caches (would use something like
> "ARCH_VERY_EARLY_INIT"), requiring malloc_f would limit how early it could be. 
> 
> 3. Going back to v1 (fixed address used): This has the smallest image and no
> allocations but we'd have to avoid reusing the address range for something else
> in early boot

I would be OK with this option too. I think Carlo's objection was more about
hard-coding the address than the concept in general, is that right?

So a config option for it like MTK_EARLY_TLB_ADDR that is chosen to be an
address that works for both SPL and U-Boot proper (or make it per phase if
there isn't a good address that works for both, but simpler is usually
better).

My best guess for a safe address here is 0x401f8000. 

= DDR base (0x4000000) + 2MiB - EARLY_TLB_SIZE (32KiB)

This is well after SPL stack and just before where other things start
putting images, e.g. if we ever enable falcon mode in SPL.

