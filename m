Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE66D26D94
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 19:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EB54843AD;
	Fri,  9 Jan 2026 20:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wduuu4P/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDF58843C5; Fri,  9 Jan 2026 20:28:48 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D033A8437C
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 20:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dnsJX5s1Vz9sjn;
 Fri,  9 Jan 2026 20:28:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767986924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5iac4p0wwZ/5wvm7xzwZGIuUz8/5tK8y9WhAgk9Q48=;
 b=wduuu4P/iPMqu0KJdgDRxept6Pdf6PdYO2N4VI51mkVsygkGkNoftx8ghiVHS8qRdkEeIA
 PsWaln6Y00eZ30NbBrMe50Ce6zYuakaTB2GoVlijtZ9e+d41gvEmmlj8oMGWxA+YqAkLSp
 GSy0vNIjvxQZQ9lESfEYhqqLQZMqHeLmaHnrVICKI/QLZUlmnYP1j6z68XpxCYlcjUO6xx
 kE7LURtEo8bhu6ogFL5yREKRUlxjZS1tOW0vW0/xg97W+WvXXoouzm7XsMK/3NvHluWnrU
 836t5oP31Y6mSaEct4d/paCez3BbJixzwgi0kPE1VMDqHhvIW9F5KnKS994lzw==
Message-ID: <39815895-5db1-4740-a060-c4050c330da4@mailbox.org>
Date: Fri, 9 Jan 2026 20:28:40 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
To: "Padhi, Beleswar" <b-padhi@ti.com>, Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 james.hilliard1@gmail.com, anshuld@ti.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
References: <20260109190026.58464-1-b-padhi@ti.com>
 <20260109190026.58464-3-b-padhi@ti.com>
 <20260109191054.GJ3416603@bill-the-cat>
 <48022594-212f-4f43-ba9b-0802711e88e5@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <48022594-212f-4f43-ba9b-0802711e88e5@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 70a48a689d5f792d33b
X-MBO-RS-META: m6kkwshy1km4aih9kqohnzx7hy1ihkya
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

On 1/9/26 8:21 PM, Padhi, Beleswar wrote:
> Hi Tom,
> 
> On 1/10/2026 12:40 AM, Tom Rini wrote:
>> On Sat, Jan 10, 2026 at 12:30:26AM +0530, Beleswar Padhi wrote:
>>
>>> The OMAP2 SPL linker script (also used for K3 platforms) currently uses
>>> 4-byte alignment after the __u_boot_list section. Change this to 8-byte
>>> alignment to meet the device tree specification requirement for DTB
>>> alignment.
>>>
>>> However, this alignment directive only advances the location counter
>>> without padding the actual binary output. When objcopy extracts
>>> u-boot-spl-nodtb.bin, it includes only actual data, stopping at the last
>>> byte of __u_boot_list (e.g., 0x41c359fc), not the aligned address (e.g.,
>>> 0x41c35a00). When the FIT image containing device trees is concatenated
>>> to the above SPL binary, it gets appended at the unaligned file size,
>>> causing libfdt validation failure.
>>>
>>> To fix this, add an alignment directive inside the __u_boot_list section
>>> itself. This forces the linker to include padding as part of the section
>>> data, ensuring objcopy includes the padding bytes in the binary and the
>>> appended FIT image starts at an 8-byte aligned boundary.
>>>
>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/u-boot-spl.lds | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach- 
>>> omap2/u-boot-spl.lds
>>> index 3bb759d8a1c..081323e6599 100644
>>> --- a/arch/arm/mach-omap2/u-boot-spl.lds
>>> +++ b/arch/arm/mach-omap2/u-boot-spl.lds
>>> @@ -35,9 +35,10 @@ SECTIONS
>>>       . = ALIGN(4);
>>>       __u_boot_list : {
>>>           KEEP(*(SORT(__u_boot_list*)));
>>> +        . = ALIGN(8);
>>>       } >.sram
>>> -    . = ALIGN(4);
>>> +    . = ALIGN(8);
>>>       __image_copy_end = .;
>>>       _end = .;
>>>       _image_binary_end = .;
>> Do we need both of these? Shouldn't we just need the one inside the sram
>> section with a comment that this ensures the end of the SRAM portion is
>> 8-byte aligned?
> 
> 
> Yes, we need only the first directive.

Would that work if the __u_boot_list section is empty ? I think it won't 
and you would end up with possible 4-byte alignment again.
