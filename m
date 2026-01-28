Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0DFD25B76
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 13:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C94683CEA;
	Wed, 28 Jan 2026 14:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XV69hw7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5775283DDF; Wed, 28 Jan 2026 14:28:40 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78EE283C65
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 14:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f1NQC3lhkz9tQH;
 Wed, 28 Jan 2026 14:28:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769606915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7O93CS5v8pq8PB8hPzVs8ZicayaTFYO1SCpzFr1UP8=;
 b=XV69hw7M41vaKSNyQS8mrmdN8evIRRAI/zFuRdw1S3+9P6GrMcwX38zuGIbxMQxPsOQwZ/
 BI1BMJTf98KvBRuHg64VrFqXDkdytrbEMHoHUMMKVxYqqx7nLtgGMy5gPSYauI8Joervzc
 NALfrrfHKjoAhIZf3VBcc7noDKYOWnf4aXQhWVM/hXSoryDXISg4BUv3kd+41ko/floC/F
 WFnGX7F2aqgBe49Fk7My67g3XS1KZAdMBCXqfCixwSZPn6m8+jS5di6V6v28N8zwUnCOQw
 EEpm3TXB9BvOfb5jR4ZD3wjTLCffHMKNynLAQt7GD5sr9N/mNcwEYRWKZXgCeQ==
Message-ID: <462cf22d-10d4-4c59-9690-29d9584e7efb@mailbox.org>
Date: Wed, 28 Jan 2026 12:43:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <A2BF7446-8270-486A-9239-8CBB2C52AC17@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <A2BF7446-8270-486A-9239-8CBB2C52AC17@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 57a7031b82eb5b6dd19
X-MBO-RS-META: 8qbdtssc33oarpb3znxsxr7uh3t7knog
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

On 1/28/26 5:41 AM, Heinrich Schuchardt wrote:
> Am 28. Januar 2026 00:48:40 MEZ schrieb Marek Vasut <marek.vasut+renesas@mailbox.org>:
>> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
>> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
>> same bank"). These are based on incorrect premise of the first commit, that
>> "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
>> not and should not use memory above ram_top, user can perfectly well use
>> that memory from the U-Boot shell, for example to load content in there.
>>
>> Currently, attempt to use that memory to load large image using TFTP ends
>> with "TFTP error: trying to overwrite reserved memory...". With this change
>> in place, the memory can be used again.
> 
> IIRC there are drivers that have issues with memory above 4 GiB and boards that artificially set ram_top to 4 GiB to work around these issues.

I thought I had all of those solved, but apparently not, please read on.

> We need to carefully consider why the reverted patch was introduced.

I didn't find much on either commit. I believe the premise on which the 
original patch was introduced is wrong, cf this commit message. We 
should allow U-Boot to access the memory above ram_top, we should not 
allow U-Boot to use it for its data structures because of the possible 
32bit DMA limitations.

> Why does your board use a 4GiB ram_top and not place ram_top at the physical top?
Originally, I thought it was only a remnant from the past which kept 
U-Boot and all its data structures, stack, heap in the first DRAM bank 
in 32bit space, so I tried to remove that. It turns out there are still 
a couple of problems that have to be solved to make it possible to 
relocate U-Boot fully into the 64bit space.

The first one is the standard parsing of DRAM size / ram_top / DRAM 
banks order in common/board_f.c , which probably hides a lot of issues 
on various boards, pretty much what you wrote above. In short, 
dram_init() only sets up gd->ram_base and gd->ram_size , which is often 
the first continuous DRAM bank which is in 32bit space. The follow up 
setup_dest_addr() uses that information to set up U-Boot relocation 
address at the end of that first continuous bank. And then 
dram_init_banksize() parses the rest of the DRAM banks into gd->bd 
(gd->bd is set up after setup_dest_addr() is called, in reserve_board()).

This above is fixable and I already have some clean up patches for that, 
which I implemented while writing this email.

But then I found out, that the ravb ethernet driver also has 32bit 
limited DMA, which breaks if I relocate U-Boot to the 64bit range. It 
worked thus far, because U-Boot was in 32bit space, so were mallocated 
DMA descriptors, so was the net_pkt_buf[] array (which is in .data 
section). I didn't find any other breakage thus far.

Which means, before we can really start switching boards to relocate to 
64bit space, we need to find all these remaining 32bit limitation sites 
and fix them first. And to do that, we would need some way to force 
allocation from 32bit space for drivers which need that ... do we 
already have such a thing ? I couldn't find anything.
