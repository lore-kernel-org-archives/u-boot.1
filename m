Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66335D2D0FF
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 13:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E033C83015;
	Tue, 13 Jan 2026 14:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="G9B9D4A1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFCE9830CA; Tue, 13 Jan 2026 14:27:46 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA58C82C7F
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 14:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dr9664yNfz9scl;
 Tue, 13 Jan 2026 14:27:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768310862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPSg1yaQ/rgqMHcVVCva+pGP6ZpN7BD/SOH1MBQpJyM=;
 b=G9B9D4A1mkjoZ1e/el4MrxqALVRvg6EgVLVH2H1xRXYkElzvN8t1ESqu5P2i62d6oElHwZ
 6znncR/ngmH7aq31SQM0AS/FLiXL/7B4Vh2LColZS5HcZPVQh02hTlyAWzfBL1TqfwTs+n
 Dwm1Ud7t6Ugpz1P2g1LZ/8YfIqrnKxTXLVVaJPGS7pE0qoKVm0Y4O8TOY7/Il0V9E49dhs
 Qq4QrFegdnx8XUfMAhRUBRZK7B/K8Ps9Tf7A+AU2ClKnhn+qac3fqXz/QH6PmH9BhH0cKa
 qWERYIQKy+mq8GHtJwCfYkY3SCqHWQgumLCq6F03vD/lYS33bR08A94BTxbezg==
Message-ID: <95292c17-f480-49f8-a0af-bdb2f71de2d1@mailbox.org>
Date: Tue, 13 Jan 2026 14:27:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte
 within multidtb.fit
To: Beleswar Prasad Padhi <b-padhi@ti.com>, Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 james.hilliard1@gmail.com, anshuld@ti.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-2-b-padhi@ti.com>
 <9257e248-512f-4c42-999b-0f8c4f0f92b7@mailbox.org>
 <2854b18c-324f-4052-a6e5-538df6a0bcab@ti.com>
 <a799f9d0-e369-4ccf-8c64-60623143ca86@mailbox.org>
 <20260112220323.GT3416603@bill-the-cat>
 <e7d8161c-789c-4d44-af2b-19bf69f4eb12@mailbox.org>
 <98d6a5d5-a09c-4dd0-a3c3-af5f9b58dc3b@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <98d6a5d5-a09c-4dd0-a3c3-af5f9b58dc3b@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: fd9efbb19a43e1f3390
X-MBO-RS-META: k4rzztkkfjtq79hc7mo8yns7s5s35fz1
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

On 1/13/26 11:25 AM, Beleswar Prasad Padhi wrote:

>>>>>> - Should mkimage -E align blobs to 8 bytes by default ? I think yes,
>>>>>> and frankly, I thought it does so already, but apparently not.
>>>>>
>>>>>
>>>>> This can be done, but should it be? Not all FITs demand an 8-byte
>>>>> alignment right? It is only the FDT which requires this.
>>>> Maybe if image type is flat_dt, it should be implicitly 8-byte aligned then
>>>> ?
>>>
>>> Well, the device tree spec says 8-byte alignment.
>>
>> 8 byte alignment of what, start of DT, right ?
> 
> 
> Yeah from start... In this case, the FDT for OS is aligned, but the sub DT
> from the FIT is not aligned by 8-bytes.

For mkimage -E (fit with trailing external data) , enforcing that 
alignment should be easily doable.

>>> It's not "FDT for OS"
>>> that's 8-byte, it's any device tree should start out 8 byte aligned, and
>>> everything else should then be naturally aligned. If we're looking in a
>>> device tree for another device tree to use in place and not relocate
>>> then that second tree must be aligned.
>>>
>>> Or am I missing something?
>> The discussion is about mkimage -E which generates DTs for U-Boot SPL use. The DTs in those external data should likely be aligned to 8 bytes by default, i.e. implicitly set -B 8 (they don't seem to be right now).
> 
> Instead of -E, we can use '-b' which always takes DT and make sure that is 8-byte aligned by default:
> 
> Usage: mkimage [-D dtc_options] [-f fit-image.its|-f auto|-f auto-conf|-F] [-b <dtb> [-b <dtb>]] [-E] [-B size] [-i <ramdisk.cpio.gz>] fit-image
> -b => append the device tree binary to the FIT

The type flat_dt should likely always be implicitly aligned at minimum 
to 8 bytes , without -b or -B or -whatever flags.

-- 
Best regards,
Marek Vasut
