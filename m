Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28804E9B368
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 11:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 471E283EC6;
	Mon,  2 Mar 2026 12:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="duWfl952";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFFDC83F0A; Mon,  2 Mar 2026 12:13:53 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8329F83CDF
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 12:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso66136815e9.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 03:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772450031; x=1773054831; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U9SKma+k3uAdJ2Zh2X9X3sCtyVMd0cIblDh2g+leL8c=;
 b=duWfl952vnl8LLp8XsF8wg4hz9/3vGm6LCHnSY6TPFVI4iKw/w+8UEnon1PEWu+rF8
 31N789e6M56XX84vo+bk+AOi9wnSELPhznOjvpuiOeRC+kmE0eSEMZyfgM/anASDNrJf
 IAKi7ZPmZ8flB0vQgtn2vlcvD+DHe2tsJkG7q+gCQAsSiluD2H4RC9sTztnFucqSsRAt
 fX76ncH+XVwIxvLrOktzfFuCfmVa3sxYDZ3UB4ik//0pNbK5ozUkUubUi1jrLi8Q+6P8
 7vKNI3njZf0vk2RXHukjQOP4e/yBLKpnUH1fjlGQo8KPeDYzqvwisdPDY4RqHAl1iPKx
 sR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772450031; x=1773054831;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U9SKma+k3uAdJ2Zh2X9X3sCtyVMd0cIblDh2g+leL8c=;
 b=f2oBWRapkppKwJTVd+koI60oBzszg7flaKrcJ76tsRaKcq5oK+6kZHadBNP6KlGq7Q
 DSe3tyU/OaPa94sssKcVV8vbVZd6Zt3SzSRz344dviYFd041dHMwL+KqcStW1pdS9NOr
 wOXSjB/MkX3pVgBarQfvwoctnZhaB4eMrji9yHnzjybgGfvfFQAHh9ObNDevm7DMVkdk
 unYJL/Kva1Z3AeyU8zvRkoENuzZIeEkt++HDwNKBdaZUNhnXk6eQMfNqAQ92Hr0jNaUw
 wlK+Xhi/PvhobPFJYuaFAHfgg1LhbvqYSQRjo4OKKN0Vz4soFk3K8GJQqJ6tCmKBMVdx
 BnNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBJnzBJ4k9G2GFCe1oApOLkwBe6zc/mvc10vGyDXdcXTWhoKo+mR2qnCA177TiA58PCgJp5dc=@lists.denx.de
X-Gm-Message-State: AOJu0YxZlbWvYVDqrJ53Pt8xqNolludj4pTr9Lygb7MpWYefZf+kvD0l
 FwY3LNc7Hp+KvPdBaTAWaiNzMiqKVoWFGlrImXnzrsUkApMBxVB/NS+U
X-Gm-Gg: ATEYQzz9uDuFkH32bgDDphagIs7X4j5+t9qwf9k/I0+Yv1djhzxNSHEWgEg//5a2df2
 tp6yry7L8Zsc8zFsdimIK+KxQ8sSmgqmo66eNSXnkNKittx8iHLvKiUxmOZp9gGuFkEDmlgOPdZ
 +M+aClbcUWh92Fmwn1a8M0H1KWMP/Nj7xpAESRwna6lIn23Yw/jpsyoJxq4skDKbZj93RX3NKLi
 0HP4h8TuTnstZvH6gtuARSKe5F7TZaG7dq7LyDbDUmK3hyxBrnOLcV4gjOiP9Key3Eo7UhgeEle
 6P6vX+RRi0s03kzMUa+wuJQrr4M7hFafsgRZpZgjo8C1HFHkwZUH50u+8ADTxVgJSF9ag5A1nSS
 WDYWBylPZvDO89VCz2pLk3PS1J3O1ek/EbNcT4jj+3kIp9as3/t/N1HcLdQYacJDYbI605FCJH4
 F+ncgtRF7eyrzwJUoWvuamNIImHoljb9oSlmUx4So1FspPEc4rNcAXaOLYbqzO8NWlaU5rTQ==
X-Received: by 2002:a05:600c:6388:b0:480:4a90:1af2 with SMTP id
 5b1f17b1804b1-483c9c2c2damr221142585e9.35.1772450030543; 
 Mon, 02 Mar 2026 03:13:50 -0800 (PST)
Received: from [192.168.68.74] (93-34-120-147.ip49.fastwebnet.it.
 [93.34.120.147]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb87067sm132235365e9.12.2026.03.02.03.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 03:13:50 -0800 (PST)
Message-ID: <55ddc7bf-f48e-4767-8d57-8a8b5215a6aa@gmail.com>
Date: Mon, 2 Mar 2026 12:13:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
To: Tom Rini <trini@konsulko.com>
Cc: "Francis, Neha" <n-francis@ti.com>,
 Stefan Eichenberger <eichest@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>, stefan.eichenberger@toradex.com,
 s-k6@ti.com, w.egorov@phytec.de, emanuele.ghidoli@toradex.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de
References: <20250314100734.23777-1-eichest@gmail.com>
 <20260226070502.GA6701@francesco-nb> <20260226142345.GB1593142@bill-the-cat>
 <20260226160901.GA29510@francesco-nb> <aaB1DifzODCVv4SU@eichest-laptop>
 <20260226163117.GJ1593142@bill-the-cat>
 <c8e7db77-5c9f-490c-a5e5-30607fde09aa@ti.com>
 <34966334-4658-4fe2-8b6f-550969c1f91f@gmail.com>
 <20260227173922.GV1593142@bill-the-cat>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <20260227173922.GV1593142@bill-the-cat>
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



On 2/27/26 18:39, Tom Rini wrote:
> On Fri, Feb 27, 2026 at 11:39:44AM +0100, Emanuele Ghidoli wrote:
>>
>>
>> On 2/27/26 11:13, Francis, Neha wrote:
>>>
>>>
>>> On 2/26/2026 10:01 PM, Tom Rini wrote:
>>>> On Thu, Feb 26, 2026 at 05:30:06PM +0100, Stefan Eichenberger wrote:
>>>>> Hi Francesco and Tom,
>>>>>
>>>>> On Thu, Feb 26, 2026 at 05:11:49PM +0100, Francesco Dolcini wrote:
>>>>>> +Emanuele
>>>>>>
>>>>>> Hello Tom,
>>>>>>
>>>>>> On Thu, Feb 26, 2026 at 08:23:45AM -0600, Tom Rini wrote:
>>>>>>> On Thu, Feb 26, 2026 at 08:05:02AM +0100, Francesco Dolcini wrote:
>>>>>>>> Hello Tom,
>>>>>>>>
>>>>>>>> On Fri, Mar 14, 2025 at 11:06:49AM +0100, Stefan Eichenberger wrote:
>>>>>>>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>>>>>>>
>>>>>>>>> The get_ram_size() function fails to restore the original RAM data when
>>>>>>>>> the data cache is enabled. This issue was observed on an AM625 R5 SPL
>>>>>>>>> with 512MB of RAM and is a regression that became visible with
>>>>>>>>> commit bc07851897bd ("board: ti: Pull redundant DDR functions to a common
>>>>>>>>> location and Fixup DDR size when ECC is enabled").
>>>>>>>>>
>>>>>>>>> Observed boot failure messages:
>>>>>>>>>   Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>>>>>>>>>   Authentication passed
>>>>>>>>>   Starting ATF on ARM64 core...
>>>>>>>>>
>>>>>>>>> The system then hangs. This indicates that without a data cache flush,
>>>>>>>>> data in the cache is not coherent with RAM, preventing the system from
>>>>>>>>> booting. This was verified by printing the content of this address when
>>>>>>>>> the issue occurs.
>>>>>>>>>
>>>>>>>>> Add a data cache flush after each restore operation to resolve this
>>>>>>>>> issue.
>>>>>>>>>
>>>>>>>>> Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
>>>>>>>>> Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when cache is enabled")
>>>>>>>>> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>>>>>>
>>>>>>>> Tom, can we merge this?
>>>>>>>> This is the last bit to solve the regression reported here,
>>>>>>>> https://lore.kernel.org/all/20260224152405.GD340942@francesco-nb/
>>>>>>>
>>>>>>> I wasn't happy with this at the time, and Stefan's last email in the
>>>>>>> thread left me with the impression more investigation was needed and
>>>>>>> likely something else was the root cause.
>>>>>>
>>>>>> I believe that this patch is needed.
>>>>>>
>>>>>> On AM62 what is happening is the following.
>>>>>>
>>>>>> We have a cortex-R5 that is the first core booting (there is also a
>>>>>> cortex-m4, but it's not relevant for this discussion).
>>>>>>
>>>>>> It runs from internal memory and it configures the DDR ram
>>>>>>
>>>>>> We load to DDR memory various pieces of firmware (TFA, U-Boot for the
>>>>>> cortex A53, ...)
>>>>>>
>>>>>> We do execute get_ram_size(), that read/write the memory, and it is
>>>>>> supposed to restore it back the original content
>>>>>>
>>>>>> However when we have the cache enabled, we might miss to write back the
>>>>>> original memory content, where the other pieces of firmware are.
>>>>>>
>>>>>> And after that we start the cortex A53, running in DDR, and there the
>>>>>> memory content might not be correct, because there is no cache coherency
>>>>>> between the cortex-A and the cortex-R. And because of that we have
>>>>>> crashes.
>>>>>>
>>>>>> Stefan: any comment here? Can you help?
>>>>>
>>>>> I think what you wrote summarises the issue well. If I recall correctly,
>>>>> I "fixed" the issue last time by simply calling get_ram_size() once
>>>>> before enabling the cache. This was in commit 4164289db882e. The SPL
>>>>> then informs U-Boot of the memory size via fdt fixup. However, something
>>>>> has probably changed now (possibly in the R5 SPL), meaning the cache is
>>>>> enabled earlier, so the cache is enabled again when get_ram_size() is
>>>>> called.
>>>>>
>>>>> For the AMP use case, either "get_ram_size" should not be called once
>>>>> the cache is enabled, or a similar patch to the one I proposed is
>>>>> required.
>>>>
>>>> I would lean towards the former if at all possible.
>>>>
>>>
>>> Just trying to understand, what is the reasoning behind ensuring get_ram_size is
>>> not called if cache is not enabled? Wasn't get_ram_size written with the
>>> possibility of cache being enabled (existence of dcache_en logic); then this
>>> patch is a valid fix right?
>>>
>>> In parallel, I do agree we need to have a code analysis w.r.t dram_init, we are
>>> making certain cache and dram calls spuriously making this confusing.
>>>
>>
>> Hello Tom,
>> I agree with Francis.
>>
>> When I proposed commit 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size()
>> when cache is enabled"), I was not considering the presence of other actors
>> (other cores, DMA engines, etc.).
>>
>> That patch fixes what I had overlooked at the time. We need to restore the
>> actual RAM contents, not only what is perceived by the core executing
>> get_ram_size().
>>
>> To me this patch sounds intrinsically correct.
> 
> Alright. Can I please get some Reviewed / Tested by tags? Thanks.
> 

Reviewed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
