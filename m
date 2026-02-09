Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC68E94606
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 20:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38E1805D7;
	Mon,  9 Feb 2026 21:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YYE31iIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 518908388D; Mon,  9 Feb 2026 21:46:28 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7198480325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 21:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f8xYr3w8Fz9tlt;
 Mon,  9 Feb 2026 21:46:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770669984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pzEHz3+92wDARcMNAZOe9OB6B20/IZADPkr5RLVBMck=;
 b=YYE31iIMH74+JjyRMY7mt4DRP+3LOK+FJ4aeZZ8/HNTfHxG+QiC8Wu7iHCOs25X6BV5n4/
 BeEGUGQBqGVJkFY0O9HIuRe/1VfsKrly40PHtDROn+tVq6lCz8ZRB4v6nQuXAdt8uvtDqh
 cuefVnrAPkS2UwG3Qf15csdjEqAy5MTFeM9V3bVjVvZzZTOPieIPjBASQ+a6LfT1/h7lYc
 crTxGfuUlDgC1vVA+c7+gm5H8qSa7bc+soMqFGGNK1X0GsAemTkhK/C2rFxzBf5kWrTHUg
 WKgHWNpoFx78EapyDbLnLhTRSZRuWqbrGTxSRLCHK1jTNvFecq8TNZc3t0dWBg==
Message-ID: <85b4ced7-1419-4dd8-a650-a2167c3204eb@mailbox.org>
Date: Mon, 9 Feb 2026 21:46:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] image: fit: Apply overlays on a writable FDT copy
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jamie Gibbons <Jamie.Gibbons@microchip.com>
References: <20260208223715.3721340-1-james.hilliard1@gmail.com>
 <d462a246-86ce-42d2-befa-d1b93b74e99a@mailbox.org>
 <CADvTj4qZoDVV-7PQorFk9vmMaLzxYTsyoqnjcO3JYRaPLLM6=A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CADvTj4qZoDVV-7PQorFk9vmMaLzxYTsyoqnjcO3JYRaPLLM6=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dfb9701e69a7878282c
X-MBO-RS-META: ksrrzftgpw4d8m4sd369i3pips9yjkaz
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

On 2/9/26 8:57 AM, James Hilliard wrote:
> On Sun, Feb 8, 2026 at 4:19 PM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 2/8/26 11:37 PM, James Hilliard wrote:
>>> boot_get_fdt_fit() relocates the base FDT with boot_relocate_fdt()
>>> before applying overlays. That uses the bootm memory map and can
>>> overlap with the FIT buffer when the FIT is loaded into RAM, corrupting
>>> data needed to load the kernel and ramdisk.
>>>
>>> Allocate a writable copy of the base FDT with memalign() and
>>> fdt_open_into(), grow it as needed for each overlay, and apply the
>>> overlays to this buffer. Also check fdt_pack() errors and free the
>>> temporary overlay copy after each application.
>>>
>>> Fixes: 881f0b77dc8c ("image: apply FDTOs on FDT node")
>>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> This code is starting to be super-convoluted. Can you please have a look
>> at [1] and see if that can be somehow extended to cover this ? I think
>> it should trim the complexity, but it likely needs a bit more work.
> 
> Hmm, that kinda looks like it's solving a different issue? At least I'm
> not really seeing an obvious way an alignment refactor like that
> would help with this issue with a bad relocation corrupting the FIT
> buffer.
> 
> I agree the code here is a bit convoluted, so maybe I'm missing the
> relation between the fdt alignment and the relocation location issues.

Well, if the FDT embedded in a fitImage is at 4-Byte aligned address, it 
has to be copied into a temporary buffer before the DTO is applied. In 
your case, if the FDT is embedded in the fitImage period, it has to be 
copied into a temporary buffer. It seems to be almost the same thing, is 
it not ? Note that the temporary buffer would be mallocated, and 
therefore out of harms way ?
