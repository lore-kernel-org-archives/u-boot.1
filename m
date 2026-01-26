Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA7ED1951B
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 21:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05C5D83BFE;
	Mon, 26 Jan 2026 22:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nmUqRo5z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aSqmlAAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74ECA83D0F; Mon, 26 Jan 2026 22:50:34 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE7283B27
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 22:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f0MfG670zz9v4H;
 Mon, 26 Jan 2026 22:50:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769464230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7W4vu2kUEwGToeJKqCp0yTZhPdP3cmdx3JTLzbPnV0=;
 b=nmUqRo5zxCwy9vj7FkawLC4+rmG+s6ArI8udyfk/Le75Vd5xzT+U6vA0uEkRVzhtbyzyL1
 5MpWsOirff0lUJdMLsYrRSeXza5Me+kVqvIfNWfSsGhGskDcJgxGaHIWVwUx+Sdi3E0Xww
 J34dqWJtI7t4F1rWGFfqtirHIEpZ8ItVYRj4XxJ1NtXhYbzNRgTrrMXEfD7pxmYG7zMmMn
 x4dzpMf+qLKc326bcojwq+Tnm8hrNjfVPkKcxIP2PbfH+rRDGbPQyXYAXMzxezO7J/2d3z
 8zNfC8bUa6P6QvruDPv0gn1qI8nPD0RPsw94S4EIIB4mbFCTuek3/ykNj8TZgg==
Message-ID: <6896afd5-76fa-4b1a-abbd-0798f19185ba@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769464228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7W4vu2kUEwGToeJKqCp0yTZhPdP3cmdx3JTLzbPnV0=;
 b=aSqmlAAFbT4UxGPdnzRLTCTmtmwPS3Casw//PHEH6K1tC0zbsOM9R1oapy+XuIjn5UdL6s
 LfCES/23/kFRvcvT+MyIc+ZceS7MSLxs3tdm6/JMZvGuHrd1OOMBZCB3GZ4DjOjaZI8Imv
 jKKQZndDyGKfCLLOgr6UgDTk0s1oRZcTSEZAEqvl2L+tGgL4WEgt81q6bXWm5NfK8pRlwK
 pt1JNn5s95ECbgZ5KepQ3eejzWo+Mh1eY1vxWImKzhHy2W+j8bd/6vfjHRkAcRlqxVhJ4/
 u/sLQ5zvUzxADXKrv9NvzSRtQ6vpDVMY/yVTtOMOwLJx0E3TvpPz9n5hzjEWpQ==
Date: Mon, 26 Jan 2026 22:50:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Sean Anderson <sean.anderson@seco.com>, Anshul Dalal <anshuld@ti.com>,
 Beleswar Prasad Padhi <b-padhi@ti.com>, Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, afd@ti.com,
 nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, bb@ti.com,
 praneeth@ti.com, u-boot@lists.denx.de
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
 <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
 <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
 <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
 <ab3a8a36-eaa2-4030-ba18-6c75647455b6@seco.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ab3a8a36-eaa2-4030-ba18-6c75647455b6@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8t1mzsx1fk7ixoqc6u9be5x45nkohwyo
X-MBO-RS-ID: f81e63855d40aed6ea7
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

On 1/26/26 6:38 PM, Sean Anderson wrote:
> On 1/23/26 05:51, Marek Vasut wrote:
>> On 1/23/26 11:40 AM, Anshul Dalal wrote:
>>> Hi Marek,
>>>
>>> On Fri Jan 23, 2026 at 3:57 PM IST, Marek Vasut wrote:
>>>> On 1/23/26 4:32 AM, Beleswar Prasad Padhi wrote:
>>>>>
>>>>> On 23/01/26 00:33, Marek Vasut wrote:
>>>>>> On 1/22/26 6:45 PM, Tom Rini wrote:
>>>>>>> On Thu, Jan 22, 2026 at 10:52:47PM +0530, Beleswar Padhi wrote:
>>>>>>>
>>>>>>>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>>>>>>>> packed inside the multidtb.fit FIT image. While the individual DTBs
>>>>>>>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>>>>>>>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>>>>>>>>
>>>>>>>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>>>>>>>> setup_multi_dtb_fit() when locating the next available DTB within the
>>>>>>>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>>>>>>>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
>>>>>>>> version v1.7.2-35-g52f07dcca47c")
>>>>>>>>
>>>>>>>> The mkimage tool already supports enforcing this alignment via the -B
>>>>>>>> option, but users would have to specify it explicitly. This change
>>>>>>>> makes 8-byte alignment the default when using -b.
>>>>>>>>
>>>>>>>> Reported-by: Anshul Dalal <anshuld@ti.com>
>>>>>>>> Closes: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2fu%2dboot%2fDFJ950O0QM0D.380U0N16ZO19E%40ti.com&umid=003810bd-b0e0-4a71-9348-75ffbe5cbae5&rct=1769167692&auth=d807158c60b7d2502abde8a2fc01f40662980862-3859cf23dac8d65722a0a9ed4c40c98c98a297de
>>>>>>>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
>>>>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>>>>
>>>>>>> Tested-by: Tom Rini <trini@konsulko.com>
>>>>>> Doesn't this enable 8-byte alignment for everything in case a DT is specified on mkimage command line ? That doesn't seem right ?
>>>>>>
>>>>>> If I do mkimage -f auto -b ...dtb ... , then I only want the DTB to be 8-byte aligned, all the other blobs can be 4 byte aligned just fine .
>>>>>
>>>>>
>>>>> All the mkimage flags are parsed at once and populated in the params
>>>>> data structure in one shot in the code. There is no separation of code
>>>>> specifically for generating a FIT for a DTB vs for anything else.
>>>>
>>>> That does not seem to be true ?
>>>>
>>>> $ git grep -p '\<bl_len\>' tools/
>>>> tools/fit_image.c=static int fit_extract_data(struct image_tool_params
>>>> *params, const char *fname)
>>>> tools/fit_image.c:      align_size = params->bl_len ? params->bl_len : 4;
>>>> ...
>>>>
>>>> So something like that may work ?
>>>>
>>>> "
>>>> diff --git a/tools/fit_image.c b/tools/fit_image.c
>>>> index 0306333141e..0c606ba4cc3 100644
>>>> --- a/tools/fit_image.c
>>>> +++ b/tools/fit_image.c
>>>> @@ -642,9 +642,15 @@ static int fit_extract_data(struct
>>>> image_tool_params *params, const char *fname)
>>>>            for (node = fdt_first_subnode(fdt, images);
>>>>                 node >= 0;
>>>>                 node = fdt_next_subnode(fdt, node)) {
>>>> -               const char *data;
>>>> +               const char *data, *type;
>>>>                    int len;
>>>>
>>>> +               if (align_size < 8) {
>>>> +                       type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
>>>> +                       if (type && !strcmp(type, "flat_dt"))
>>>> +                               align_size = 8;
>>>> +               }
>>>> +
>>>>                    data = fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
>>>>                    if (!data)
>>>>                            continue;
>>>> "
>>>>
>>>
>>> I just ran a quick test with this diff and it seems to fix the issue for
>>> us. If it's okay can we take the change as is.
>> I think the strcmp needs to be some strncmp and check the 'len' too.
>>
>> Let's see what others think.
> 
> strcmp is fine when one of the strings is a constant
> 
> If type is shorter than "flat_dt" then there is no risk of overflow.

What exact data would you be comparing here , the constant and something 
read from possibly past the user supplied "type" buffer ?

Some validation of "len" has to be done before it is fed into strcmp() here.
