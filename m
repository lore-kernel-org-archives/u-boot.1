Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4C7CF45DB
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 02:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F6383700;
	Tue, 13 Jan 2026 03:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qQ87IVsi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89DDD836C8; Tue, 13 Jan 2026 03:04:33 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03D4983045
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 03:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dqsxm6yWgz9t29;
 Tue, 13 Jan 2026 03:04:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768269869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMHV1e4RdRFLyXqT3OITaNnI+WwkK05SxXZXCIjBnSE=;
 b=qQ87IVsi8Qdea5T+mj7I6hlcaxUjrdWL1c8+/nifJHgP75QX+hSMOx4k5PPN5qXzR5iWqg
 0yARCcn6njUTB/9YQqz3odeLGL7TjQk8tAoF6vNY4gaMXuLQsoIQplLmirGIb56U2vIF41
 48FBQ7qk+pUAVyD0QXkHaBx55l3lfRWpAsP1ZrH2X2HqLEBCEh/peENmKJgOpoz0a7/6S7
 MJt0c1PweNJ7SmzyQ2WtJ1xcR+IN7D4U2Z81Se1yXGlsQtb+I+aO4HpKSCcrPkY6LqXfSV
 /uTG2nl6n0fWACRUw4rcTVziINsXNyXhvKla/hqAYpjnkvhV1/b9IMfvaxCVXA==
Message-ID: <e7d8161c-789c-4d44-af2b-19bf69f4eb12@mailbox.org>
Date: Tue, 13 Jan 2026 00:53:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte
 within multidtb.fit
To: Tom Rini <trini@konsulko.com>
Cc: "Padhi, Beleswar" <b-padhi@ti.com>, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org, philip.molloy@analog.com,
 james.hilliard1@gmail.com, anshuld@ti.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-2-b-padhi@ti.com>
 <9257e248-512f-4c42-999b-0f8c4f0f92b7@mailbox.org>
 <2854b18c-324f-4052-a6e5-538df6a0bcab@ti.com>
 <a799f9d0-e369-4ccf-8c64-60623143ca86@mailbox.org>
 <20260112220323.GT3416603@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260112220323.GT3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d736c66aa03b06fb830
X-MBO-RS-META: me7i74jkj1be6h987c49h8qhaoyab1rc
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

On 1/12/26 11:03 PM, Tom Rini wrote:

>>> This we can fix in the Makefile via the dd command as suggested by Tom.
>>
>> My concern is about LEGACY fitImages (means already generated ones), not
>> newly generated ones.
> 
> Why is that a concern? If it's a legacy fitImage for the OS, we relocate
> the device tree already normally to be aligned. If it's a legacy
> fitImage of U-Boot, it's an old U-Boot?

Not necessarily, it could be new U-Boot using old fitImage, for whatever 
reason (falcon boot maybe ?). We should not break that.

>>>> - Should mkimage -E align blobs to 8 bytes by default ? I think yes,
>>>> and frankly, I thought it does so already, but apparently not.
>>>
>>>
>>> This can be done, but should it be? Not all FITs demand an 8-byte
>>> alignment right? It is only the FDT which requires this.
>> Maybe if image type is flat_dt, it should be implicitly 8-byte aligned then
>> ?
> 
> Well, the device tree spec says 8-byte alignment.

8 byte alignment of what, start of DT, right ?

> It's not "FDT for OS"
> that's 8-byte, it's any device tree should start out 8 byte aligned, and
> everything else should then be naturally aligned. If we're looking in a
> device tree for another device tree to use in place and not relocate
> then that second tree must be aligned.
> 
> Or am I missing something?
The discussion is about mkimage -E which generates DTs for U-Boot SPL 
use. The DTs in those external data should likely be aligned to 8 bytes 
by default, i.e. implicitly set -B 8 (they don't seem to be right now).
