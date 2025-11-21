Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084E5CFA471
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 04:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7498880433;
	Fri, 21 Nov 2025 05:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d4GUi1F6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ED24808AF; Fri, 21 Nov 2025 05:39:54 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297B48042F
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 05:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dCMvT6dmXz9spH;
 Fri, 21 Nov 2025 05:39:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763699990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3r6jZqRRHMco7MKygQIrmreXglIoUmlijwdXcF4Tr2c=;
 b=d4GUi1F6Y/SEpIhuSwnoHjxWGVa9jYRzp7ND6HV/mJD3cCl1BqroXL5zOjoknmmxMfy3pB
 yesKifnPhd2gn7iwlPSooktMMaZ/hH/hDeiWrcspvoEvXmLb/E5EiVCa9LUv/PCX6lnK+H
 OqOnSUZF1bfVBxsDztFtP8lOtnYZ+4jS4pUdySPEFtr4fndhAN+P07oAKQ4cDSdukLPnhQ
 3cs8PqTEo90syMQyCsbJnSMGRcWj2LB4c+FdSjkCRUDSD2uMlrxg0WodHsQ2GGWcltWRgB
 +qSe6WlYyED/dveMG2v7yH9T9dXSEQqm1OH2WkUwxNjFd24zq75203Pbz7l0QQ==
Message-ID: <c8752825-92d5-43bd-aa28-e229d4cc3fda@mailbox.org>
Date: Fri, 21 Nov 2025 05:27:46 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] clk: fixed_rate: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20251120041439.817233-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjnGtSPvki-i1fHQEU+bn=6cTqjRFyid3D5zQepNEhzog@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTjnGtSPvki-i1fHQEU+bn=6cTqjRFyid3D5zQepNEhzog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 623f6fc630d6619d784
X-MBO-RS-META: jqky4whfqtjo6etwp431cg9jbt9qidtt
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

On 11/21/25 12:40 AM, Simon Glass wrote:
> Hi Marek,
> 
> On Wed, 19 Nov 2025 at 21:14, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> If CONFIG_OF_PLATDATA=y , then the udevice has no valid OF node associated
>> with it and ofnode_valid(node) evaluates to 0. The dev_read_u32_default()
>> call ultimately reaches ofnode_read_u32_index() which invokes fdt_getprop()
>> and passes result of ofnode_to_offset(node) as an offset parameter into it.
>>
>> The ofnode_to_offset(node) returns -1 for invalid node, which leads to an
>> fdt_getprop(..., -1, ...) invocation, which will crash sandbox with SIGSEGV
>> because libfdt can not handle negative node offsets without full tree check,
>> which U-Boot inhibits to keep size lower.
>>
>> Add dev_has_ofnode(dev) check and do not assign clock rate in case the
>> device has no valid node associated with it, and do not call any of the
>> dev_read_*() functions for devices without valid nodes.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Sean Anderson <seanga2@gmail.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/clk/clk_fixed_rate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_rate.c
>> index 95a77d2e041..5c32ae207fe 100644
>> --- a/drivers/clk/clk_fixed_rate.c
>> +++ b/drivers/clk/clk_fixed_rate.c
>> @@ -35,7 +35,7 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
>>                                      struct clk_fixed_rate *plat)
>>   {
>>          struct clk *clk = &plat->clk;
>> -       if (CONFIG_IS_ENABLED(OF_REAL))
>> +       if (CONFIG_IS_ENABLED(OF_REAL) && dev_has_ofnode(dev))
>>                  plat->fixed_rate = dev_read_u32_default(dev, "clock-frequency",
>>                                                          0);
> 
> What is happening here? It should already be checking this:
> 
> static inline __attribute_const__ bool dev_has_ofnode(const struct udevice *dev)
> {
> #if CONFIG_IS_ENABLED(OF_REAL)
> return ofnode_valid(dev_ofnode(dev));
> #else
> return false;
> #endif
> }
I do not understand the question -- this patch _adds_ the 
dev_has_ofnode() test into clk_fixed_rate_ofdata_to_plat_() , it wasn't 
present before. Can you please rephrase your question / concern ?
