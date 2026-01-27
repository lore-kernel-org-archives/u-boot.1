Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABC0D19512
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 00:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 368D983F2E;
	Tue, 27 Jan 2026 01:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DZC+X0Rs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B9D483F30; Tue, 27 Jan 2026 01:37:08 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D598583BFE
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 01:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f0RLR08vPz9twV;
 Tue, 27 Jan 2026 01:37:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769474223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0na8Vj2+Ye5a0Z/uUPddOcq6gXZILlIRYDT9fl1BR4g=;
 b=DZC+X0Rs/dw3snRlSNmQdu+GHNihduVlQkoosYGpNz+R/CGtlhF+OHG7RuEMJPylT/V5BC
 3ynwNdjGTKjdHe3Uaov0/VC7+jA5l7GM1KVTizx7hJB7/bdCYYd49fR2xe91L4YwrkXaFN
 3lWxMpvCl+MUq/PYPRsJ8uYaOtr/WGdU8RZEIiFU64OKGoaoUk7ImxDAfpsAFGITJePtI6
 itIs3lfXWaCEVGvJwaC85AsZGkE5eoKUUvma95P16KIiG95KCl8EvihW5zmHbteDLcivZM
 DmV4rlzWl8s1uAoxMfYbhb8XUUB7rrLd2vB1F3Dz/D0WcpwxCOkDEZTmtGfxJA==
Message-ID: <f9310861-396d-4a89-b4a1-d67b9d6cae89@mailbox.org>
Date: Tue, 27 Jan 2026 01:36:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@seco.com>
Cc: Anshul Dalal <anshuld@ti.com>, Beleswar Prasad Padhi <b-padhi@ti.com>,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, james.hilliard1@gmail.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, bb@ti.com,
 praneeth@ti.com, u-boot@lists.denx.de
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
 <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
 <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
 <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
 <ab3a8a36-eaa2-4030-ba18-6c75647455b6@seco.com>
 <6896afd5-76fa-4b1a-abbd-0798f19185ba@mailbox.org>
 <785327c7-9d8a-4f5f-b792-4a1590796948@seco.com>
 <20260126225842.GY3416603@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260126225842.GY3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fgi8q4yunsj78mp9qe8i1fzaqwb3umzh
X-MBO-RS-ID: 81d764c078d3d3e20e4
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

On 1/26/26 11:58 PM, Tom Rini wrote:

>>> Some validation of "len" has to be done before it is fed into strcmp() here.
>>
>> Well if you are concerned about lacking a nul-terminator then we will
>> read at most 8 bytes beyond the string.

Which is wrong, and trivial to fix -- check the "len" that is already 
provided to you by fdt_getprop() and make sure it is exactly length of 
FIT_TYPE_PROP before doing the strcmp() . Then you should be safe.

>> The other thing that can go wrong is if we get something like
>> "flat_dt\0extra data" we will match.

This I did not consider. So maybe what needs to be done is compare the 
length and then memcmp() instead of strcmp().

>> Surprisingly the closest we have to this construct is fdt_string_eq_. I
>> suppose this is because most strings in U-Boot are guaranteed to be
>> nul-terminated.

fdt_string_eq_() seems like the best fit, yes , nice.

> And gets back to my original point. Either we're fine here, because
> libfdt is doing enough input validation (type and len come from
> fdt_getprop(...)) and if that passes enough validation to happen but
> also allow malicious input this is not the most interesting place to
> wreck havoc. Or we're fine, actually. Which is what I was saying on IRC.
We are not fine, fdt_getprop() returns pointer to the string in DT and 
its length decoded from the DT, it doesn't validate any of it. But what 
Sean found, fdt_string_eq_(), seems like the right fit/fix here.
