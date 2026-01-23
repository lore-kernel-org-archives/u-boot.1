Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D740D77898
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 00:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7C2C83AEE;
	Sat, 24 Jan 2026 01:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="voTq46mE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vmnz3biW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C506283B03; Sat, 24 Jan 2026 01:30:38 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97624839DF
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 01:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dybLN1XW5z9tlb;
 Sat, 24 Jan 2026 01:30:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769214636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hK+CKylKc9YluoZaCUMPknix3Z8v7d5c9rJg4NTSZpE=;
 b=voTq46mExH62anGqEUXW8YImYc7wwZwzNJNKcEbyeDmDq1B2C5TPsJ1Ih3/6l88T1m0yEe
 D+0m6QNmVVcZxwKbLKz53oGh6HdF48NTGaMnnStkJai41DyPRsMhuiQZdJDevsJK/ldMhe
 rwaYM0WJHcIQJXjKd9sQOZSizhkMMQQyUSkL4PIn6ObB0YNSnV6KkdYT9/K8tXlNPVHYj7
 yuAP97C9i2osO/dPPlgcBn0oqTCSCEBwma7C1MWSkIPYGHlnfn/ShoSnb8bG+0Zb2+R8aa
 jEOA8rxZg8L90OXh7LKE8xs1rQPgKD0m3nWuTbJPkEo3mRgyRUKtCa0YlEi7nA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Vmnz3biW;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <c60ae82e-da62-42c8-89d1-ed44adeaf351@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769214634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hK+CKylKc9YluoZaCUMPknix3Z8v7d5c9rJg4NTSZpE=;
 b=Vmnz3biWmTNcOmSH55IdEGakqYIxSqUnUjG/lVo54bUvuqHo+ZVgYeJz1Xio9e4ng3H14j
 pU+JFqQsRMk7DY+HfNqDOKxYQBv4MpzAXZfCvlGSX1abYpPGs1vCE9EZIjoP674+u2wPMU
 51Si0q30WtLh/MQqgxdtxuh9EdeB24mj+X5gExHsYAnVKbyvbI6cOqiNguuAE5oDLRJrZS
 WTuuBBh6lZNa7qa2a//QVdUfxNZ5Vy8sheOc51JJWL4UxcUKmI72YzPVT8BXf5jSK7d5fx
 1mIMwMKPZEzrKZtfwKu9zwk6XRVdRXzy+ojf6hKEu03Zd57eWwW4w3+kKaKVOQ==
Date: Fri, 23 Jan 2026 19:53:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Tom Rini <trini@konsulko.com>
Cc: Anshul Dalal <anshuld@ti.com>, Beleswar Prasad Padhi <b-padhi@ti.com>,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, marek.vasut+renesas@mailbox.org,
 james.hilliard1@gmail.com, afd@ti.com, nm@ti.com, vigneshr@ti.com,
 n-francis@ti.com, u-kumar1@ti.com, bb@ti.com, praneeth@ti.com,
 u-boot@lists.denx.de
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
 <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
 <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
 <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
 <20260123152506.GL3416603@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260123152506.GL3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fgizd1d7pp65j5g389qy6dcabrrzzgcz
X-MBO-RS-ID: b6253f63bfc574afe0e
X-Rspamd-Queue-Id: 4dybLN1XW5z9tlb
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

On 1/23/26 4:25 PM, Tom Rini wrote:

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
> Probably fine to keep going as-is. If there's security challenges here
> this isn't the first one I bet.
This is unacceptable.

Adding strncmp() is trivial.
