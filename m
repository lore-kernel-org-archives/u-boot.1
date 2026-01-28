Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414D8D3F080
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 15:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AAE983FC6;
	Wed, 28 Jan 2026 16:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sp/5BmVH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FmUnyMw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D37583FEC; Wed, 28 Jan 2026 16:42:57 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1E383EC8
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 16:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f1RPB4X8vz9sml;
 Wed, 28 Jan 2026 16:42:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769614974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w276ihC5I+yjSwVPOMU8JE0a57Ihwq64CoeuyLnLcJc=;
 b=sp/5BmVH4V5Xm17VhkRb/SPvY+0+XmntRrFW6Owk39Z6ydXuklcM7hlwh/6yZhj2ReDOEA
 GHkV/MpK68D9m+hAdNa1An8EUqnaUIlBNrE1DuFeZpPgNoPTgcdMzNpnydXhP8m1JvdMnH
 p6UG01gGbwHbOip8utCO3RP7iu87nyEJoffYlRUYK1/DtYoh7tHPkSgV44tl1KfRbKNqIw
 74D3iLbOGOpj4WogPdVlWRFs00ITcTp/qqO7UcMAnE2OOUqagT1W0TejH7gsXf5ln+0Bjv
 hgy88DjFv0h0dE8D0Hn42rXJw8IMJAJBFkfDM8VlRlMO1rwZ95XF2Qvt8FoanA==
Message-ID: <3be6cbf5-9a54-424a-9a8e-f43867cb5a3a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769614972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w276ihC5I+yjSwVPOMU8JE0a57Ihwq64CoeuyLnLcJc=;
 b=FmUnyMw0RSF9BEUd94vxhlxFHbh0+cj+6cDyS//z5JrpHJ6M/owDAGofkPB4mMhOv8f7yA
 Uz6EHUwDhDCMEDwQGoFe3+d9U13GtaTH3Pkoawtlqy6QKZbbZN0vt5KY4kcrAIhs5gJGc2
 JFUAnfFC2kK0jtCU60ntehEIE1JsAaS7n3m+NXxoqVNxGYD+EROJI3IO6qi91b/W6Wlg/x
 p2e0tw5UAdfQMD2N7KebwuYnMzQjeYcqN6ypim3hpG3qBosLqhrVMlrEpCDu+Ljz9Iy6/h
 CC/GSxiVTkbtnl4W3A5JzKXhY4imm9H62iQv72XDUl1aqKv2GscyJy2FH1ONnA==
Date: Wed, 28 Jan 2026 16:42:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4] tools: fit_image: Fallback to 8-byte alignment for
 flat_dt images
To: "Padhi, Beleswar" <b-padhi@ti.com>, trini@konsulko.com
Cc: sean.anderson@seco.com, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, anshuld@ti.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
References: <20260128141834.2322865-1-b-padhi@ti.com>
 <71adda09-1f3b-48f7-aaed-845e6a30b6ca@mailbox.org>
 <139a01e9-c395-47f0-a09d-1c591c178bf9@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <139a01e9-c395-47f0-a09d-1c591c178bf9@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a7aa8c16b52c35b8591
X-MBO-RS-META: pmiyshdfb61z9u9a5nrumxcx7ywkhiqr
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

On 1/28/26 4:26 PM, Padhi, Beleswar wrote:
> 
> On 1/28/2026 8:26 PM, Marek Vasut wrote:
>> On 1/28/26 3:18 PM, Beleswar Padhi wrote:
>>> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>> Please drop this , it isnt needed.
>>
>>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>>> packed inside the multidtb.fit FIT image. While the individual DTBs
>>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>>>
>>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>>> setup_multi_dtb_fit() when locating the next available DTB within the
>>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
>>> version v1.7.2-35-g52f07dcca47c")
>>>
>>> To fix this, check the image type when extracting
>>
>> "extracting" ? This code changes mkimage, so not "extracting" but 
>> "packing" (into fitImage), right ?
> 
> 
> Well the function name is fit_extract_data(). It is documented as 
> extracting
> all the data properties of a node to the end of the fit. So just keeping 
> the
> same terminology. Its obviously not in the same context as extracting data
> out of a FIT image to consume information...

... check the image type when moving image data at the end of the tree 
... or something like that ?

>>> FIT image data and
>>> set the alignment size to 8 bytes (if not already) only for flat_dt
>>> images. This ensures correct alignment for device tree blobs as per the
>>> DT spec, while also allowing different alignment sizes for other image
>>> types within the FIT.
>>
>> [...]
>>
>>> diff --git a/tools/fit_image.c b/tools/fit_image.c
>>> index e865f65a400..f842c845771 100644
>>> --- a/tools/fit_image.c
>>> +++ b/tools/fit_image.c
>>> @@ -682,9 +682,17 @@ static int fit_extract_data(struct 
>>> image_tool_params *params, const char *fname)
>>>       for (node = fdt_first_subnode(fdt, images);
>>>            node >= 0;
>>>            node = fdt_next_subnode(fdt, node)) {
>>> -        const char *data;
>>> +        const char *data, *type;
>>>           int len;
>>>   +        /* Fallback to 8-byte alignment for DTBs if unaligned */
>>> +        type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
>>> +        if (type &&
>>> +            len == sizeof("flat_dt") &&
>>> +            !memcmp(type, "flat_dt", len) &&
>>> +            align_size & 0x7)
>>
>> What will be the resulting alignment if align_size = 0x1f ? 8 right ? 
>> I think it should be 0x20 .
> 
> 
> I thought we agreed on resetting align_size to 8 if its not already aligned
> (regardless if < or > 8) in v3 version of this patch[0]. Do we really 
> have to
> align the align_size var itself? It seems like a overkill to me...
Maybe simply call round_up(8) on the align_size , to align to the next 
8-byte aligned offset , but somewhat respect user wishes ?

But looking at this code one more time , look at the calloc() in this 
function, I think you might also have to allocate a bit more memory to 
really hold all the newly aligned DTs, right ?

Also, don't you need to align the buf_ptr as well ? Consider a scenario 
where the fitImage contains two images, one ends at 4-byte aligned 
address, followed by a DT. The users passes -B 4 to mkimage, and I think 
buf_ptr would then be 4-byte aligned, so will the DT, no ?
