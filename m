Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF120D72379
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18DDE839DF;
	Fri, 23 Jan 2026 12:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lxEkLq1/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="csm9j3I5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1556D83A6A; Fri, 23 Jan 2026 12:28:03 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DF08397D
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dyFzL4Mprz9trL;
 Fri, 23 Jan 2026 12:27:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769167678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9uB9t9zh9M/BpAbgkR+tcOIGV/6LRySd/BuA4rYTnE=;
 b=lxEkLq1/36aSjjwMWKWk9XNk5d60szOhlT8SIauKMPSg5KK+PB72AvkoT0rEpAvrGhuhHr
 LApf+z9rWGuocDZtb2iGxrUqDUVVv3ecNFLolNTUfDKcdNy7N+pCGosQtwt/ckbw4PWuQG
 EKT+0ZVa2ZqJqUfH9ePN5JnUWGBG9d6uDh56jdB3eqsi1jgE9E+6+Mkjrr19ANF6H+iXQL
 +Av5Ntjr1dLnTuBDryR5qKxuAs+dMZm9abz7SjUGmK9mUXj1nQ4Vv3gyN0Z34afyLaTsz8
 dFWLg7QTXcBceTyj2sXu9qRrfAxf1jjb1W6LiTii52TVqMWzKXSPQjicAx9qZg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=csm9j3I5;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769167676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9uB9t9zh9M/BpAbgkR+tcOIGV/6LRySd/BuA4rYTnE=;
 b=csm9j3I5co+Dd1A6o9NQlrz258dpggZ9Eolhek0MUx7EcFsXjCc3T+3cMidZHRqo5kwYqw
 JZCipxB4IODNycBySdJissCVH1uB4hz+bTYOsQyVz+j65b13f7Rxs8Kjx23lc9ys1lr6ig
 4tHi+0bypo3iudI8uttV9gzc4xe/Phzp9enUAe2R6ikkpwY8q8mQXFku9XUhE8IqQDV4pm
 JuN7v9zfz6y5r7v/LddH5t3+4qSN1xRzrwxBFvQSD6mI9PjNI0U5hlnvc75dW61k7YnYA0
 8tP07JRFE1fIh1GAzBoPDujN/nDCOl+mrWXOC/U+wbrff59CAo+ykR9CemHb4g==
Date: Fri, 23 Jan 2026 11:51:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Anshul Dalal <anshuld@ti.com>, Beleswar Prasad Padhi <b-padhi@ti.com>,
 Tom Rini <trini@konsulko.com>
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: twrabqqp7sd5hyx8gdtmhrpfxiky569f
X-MBO-RS-ID: 30ce5fb3522f9c187ab
X-Rspamd-Queue-Id: 4dyFzL4Mprz9trL
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

On 1/23/26 11:40 AM, Anshul Dalal wrote:
> Hi Marek,
> 
> On Fri Jan 23, 2026 at 3:57 PM IST, Marek Vasut wrote:
>> On 1/23/26 4:32 AM, Beleswar Prasad Padhi wrote:
>>>
>>> On 23/01/26 00:33, Marek Vasut wrote:
>>>> On 1/22/26 6:45 PM, Tom Rini wrote:
>>>>> On Thu, Jan 22, 2026 at 10:52:47PM +0530, Beleswar Padhi wrote:
>>>>>
>>>>>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>>>>>> packed inside the multidtb.fit FIT image. While the individual DTBs
>>>>>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>>>>>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>>>>>>
>>>>>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>>>>>> setup_multi_dtb_fit() when locating the next available DTB within the
>>>>>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>>>>>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
>>>>>> version v1.7.2-35-g52f07dcca47c")
>>>>>>
>>>>>> The mkimage tool already supports enforcing this alignment via the -B
>>>>>> option, but users would have to specify it explicitly. This change
>>>>>> makes 8-byte alignment the default when using -b.
>>>>>>
>>>>>> Reported-by: Anshul Dalal <anshuld@ti.com>
>>>>>> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
>>>>>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
>>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>>
>>>>> Tested-by: Tom Rini <trini@konsulko.com>
>>>> Doesn't this enable 8-byte alignment for everything in case a DT is specified on mkimage command line ? That doesn't seem right ?
>>>>
>>>> If I do mkimage -f auto -b ...dtb ... , then I only want the DTB to be 8-byte aligned, all the other blobs can be 4 byte aligned just fine .
>>>
>>>
>>> All the mkimage flags are parsed at once and populated in the params
>>> data structure in one shot in the code. There is no separation of code
>>> specifically for generating a FIT for a DTB vs for anything else.
>>
>> That does not seem to be true ?
>>
>> $ git grep -p '\<bl_len\>' tools/
>> tools/fit_image.c=static int fit_extract_data(struct image_tool_params
>> *params, const char *fname)
>> tools/fit_image.c:      align_size = params->bl_len ? params->bl_len : 4;
>> ...
>>
>> So something like that may work ?
>>
>> "
>> diff --git a/tools/fit_image.c b/tools/fit_image.c
>> index 0306333141e..0c606ba4cc3 100644
>> --- a/tools/fit_image.c
>> +++ b/tools/fit_image.c
>> @@ -642,9 +642,15 @@ static int fit_extract_data(struct
>> image_tool_params *params, const char *fname)
>>           for (node = fdt_first_subnode(fdt, images);
>>                node >= 0;
>>                node = fdt_next_subnode(fdt, node)) {
>> -               const char *data;
>> +               const char *data, *type;
>>                   int len;
>>
>> +               if (align_size < 8) {
>> +                       type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
>> +                       if (type && !strcmp(type, "flat_dt"))
>> +                               align_size = 8;
>> +               }
>> +
>>                   data = fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
>>                   if (!data)
>>                           continue;
>> "
>>
> 
> I just ran a quick test with this diff and it seems to fix the issue for
> us. If it's okay can we take the change as is.
I think the strcmp needs to be some strncmp and check the 'len' too.

Let's see what others think.
