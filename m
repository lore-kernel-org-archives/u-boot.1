Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D53CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 10:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1E46878E1;
	Mon, 23 Oct 2023 12:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698057892;
	bh=kovhvuGhYoin14ajBY8l5wzhS1r1MA3gwMHEICA0hOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=POdi1SZnWpItT12lWu9Vd6oRLTIhgqmEP1FjUiBQ2v7Utrga1GIyoksWI/cP1QCx6
	 TI0BOWmZDw7TFk9vD5opJ3Gcl/g/IlG9CsTm8SrIaoPVe1EsiSy25Rzmt0101C6RJX
	 BYhloLjA2BOYGFxnmc/AXzL/4O9PSVZ74boXKM1d5OTGhMdDCp9MBB9SwB6O51gpQC
	 7byGZpMnhRfBR2+QwJ3b+MvF9Zk0U+tIHvWh2jpy2Ip/mpWW0fVBAbghNY3cChwKO/
	 Q8lIs3r6um8uEp3PZzTEHuMXexfJqomyuC3TyZrUFjKKYaTD4Vv5xQS/zPz8LeyJsz
	 q7aVY/bEX3/Nw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DAEC787853;
 Mon, 23 Oct 2023 12:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698057891;
 bh=kovhvuGhYoin14ajBY8l5wzhS1r1MA3gwMHEICA0hOY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ojm8pEx8/mn9WT8RaLvVSiYkqjR1Z3BEgdJ70ZhhyVaGv7wrMV8BrHoB53ZplfAiI
 GgnpRX/nSaA4EbSTGFghZwH7l67wnLrO2FhTzsWv3CLXdKep9QBcuNSrvfNT6LZFPc
 D4OJIhCqAxVSJu1crFmkDO5KgeN8Bw907gwIpzfETgG9IcpRidn/KL52hIhh4ITxz5
 JmvgJLAZ4euoIP3/1nFmPx0X08zB5RCuqFdmr5PEwqj5U2s/sIK9Js/r55OqImyXki
 oPsqWLQde6I8/EGsYxe21tekiy58BozRTMOUCS9zjjIDn6+2LYXOd8uoxuBXe0d4o+
 LGHAW9RrA8s+Q==
Message-ID: <d1cc72e1-9fc8-45a5-b8be-040900edd6e9@denx.de>
Date: Mon, 23 Oct 2023 11:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] led-uclass: do not create fallback label for
 top-level node
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-2-rasmus.villemoes@prevas.dk>
 <6d33180d-f611-43f8-9b73-9ec44eafd277@denx.de>
 <ec461be8-afaf-4ecd-842c-faeea8a6935c@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ec461be8-afaf-4ecd-842c-faeea8a6935c@prevas.dk>
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

On 10/23/23 10:28, Rasmus Villemoes wrote:
> On 19/10/2023 15.51, Marek Vasut wrote:
>> On 10/19/23 11:58, Rasmus Villemoes wrote:
>>> Many existing drivers, and led-uclass itself, rely on uc_plat->label
>>> being NULL for the device representing the top node, as opposed to the
>>> child nodes representing individual LEDs. This means that the drivers
>>> whose .probe methods rely on this were broken by 83c63f0d1185 ("led:
>>> Move OF "label" property parsing to core"), and also that the top node
>>> wrongly shows up with 'led list'. Some drivers have since been fixed
>>> up individually, e.g.
>>>
>>> e3aa76644c2a "led: gpio: Check device compatible string to determine
>>> the top level node"
>>> 01074697801b "led: gpio: Use NOP uclass driver for top-level node"
>>> 910b01c27c04 "drivers: led: bcm6753: do not use null label to find the
>>> top"
>>>
>>> Binding the same driver to the top node as to the individual child
>>> nodes is arguably wrong, and the approach of using a UCLASS_NOP driver
>>> for the top node is probably better.
>>
>> Note that
>> 83c63f0d1185 ("led: Move OF "label" property parsing to core")
>> and
>> 01074697801b ("led: gpio: Use NOP uclass driver for top-level node")
>> were applied shortly after each other, so I don't see the point of the
>> aforementioned rant.
> 
> What rant? I'm merely trying to write down what I found out while trying
> to figure out why 83c63f0d1185 broke stuff, while acknowledging that the
> fixes that have been applied to some drivers are probably the approach
> in general.
> 
>> I sort-of understand what you are trying to do in this patch based on
>> $SUBJECT of this email, but not from this wall of text, so can you
>> abbreviate the commit message ?
> 
> Sure, I can try and make it shorter.
> 
>>> -    if (!uc_plat->label)
>>> +    if (!uc_plat->label && !dev_read_string(dev, "compatible"))
>>>            uc_plat->label = ofnode_get_name(dev_ofnode(dev));
>>
>> Is there an existing driver which has a top-level DT node with "label"
>> property ?
> 
> -ENOPARSE? A driver doesn't have a top-level DT node.

I mean, is there a driver which does:

/ {
   led {
     label = "example";
   };
};

?

I think that is what the conditional checks here, right ?

> And regardless, this wouldn't change anything for a top-level DT node
> with a "label" property, as we're still unconditionally first trying to
> read a "label" property, this is merely avoiding adding a fallback value
> for top-level DT nodes (using "having a "compatible" DT property as
> proxy for that "is a top-level DT node"). So I really don't understand
> what you are trying to ask.


