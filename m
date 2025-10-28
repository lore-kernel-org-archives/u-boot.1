Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9978BCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 15:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECF982A9E;
	Tue, 28 Oct 2025 16:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="faJp08re";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED02282E34; Tue, 28 Oct 2025 16:11:46 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F8A980422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwv3f12tkz9t02;
 Tue, 28 Oct 2025 16:11:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761664302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPT6Lc919D56GVIw41XG2Nm8mTdKzhhkICELs4VxBUI=;
 b=faJp08re2SV5nxYJQru7cMxUeRfozTwrSGeHeNkuvz4wJJ0v+UZRTkp9nEvacvHvkgYTtn
 S3lGyks3WZQ6RjSXEmCSQjcVVFN/jg9JK3A7sgIFLm/+t4/++7gMgfykV0tjTF/Hx59Ixu
 //y36iz8TT10tJrZbGgLhH1CwzoP5Swpb5ubpVpDXdZ6Q0fcYJ+fQm/dkdHEeB02VJqk0i
 Trm5FVf8B1YWgHfZiEPjxG0jQgnrvn8/kUzqDb/rN5tmJsJNyXObTiq/AlSDl6E8dKqIJO
 UmnihcR+c0AydzzMA+3bD41zDFp6S9yUByCRyJKjZP0CEcbJyXeVG+pNOd9DGA==
Message-ID: <9c9317eb-7d14-40c8-9955-c69a6a5a3bcb@mailbox.org>
Date: Tue, 28 Oct 2025 16:11:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] ARM: bootm: Add support for starting Linux through
 OpTee-OS on ARMv7a
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20250630000832.952206-1-marek.vasut@mailbox.org>
 <97DFDFA0-80F7-462B-B2A9-BDBAD42A191A@gmx.de>
 <20250630194711.GA523899@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250630194711.GA523899@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: aoohm6p7jm1ze6d4n7inmh1pxtjbuq9u
X-MBO-RS-ID: a6cd8bdb9e25f4c50e4
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

On 6/30/25 9:47 PM, Tom Rini wrote:
> On Mon, Jun 30, 2025 at 07:18:33AM +0200, Heinrich Schuchardt wrote:
>> Am 30. Juni 2025 02:08:05 MESZ schrieb Marek Vasut <marek.vasut@mailbox.org>:
>>> Add support for jumping to Linux kernel through OpTee-OS on ARMv7a.
>>> This is only supported if U-Boot runs in PL1 secure. This change adds
>>> two components, one is fitImage OpTee-OS loadable handler, which makes
>>> a note of OpTee-OS being loaded and stores the load address for later
>>> jump to it. The second part is the actual jump to Linux through OpTee-OS.
>>> The jump through OpTee-OS requires set up of multiple CPU registers, r1
>>> and r2 are passed through, r0 and r3 have to be set to 0, lr is set to
>>> Linux kernel entry point. This setup is done by new assembler function
>>> boot_jump_linux_via_optee().
>>>
>>> The boot_jump_linux_via_optee() also includes STM32MP13xx late TZC
>>> configuration write, this cannot be moved easily, hence the ifdef.
>>
>> Hello Marek,
>>
>> Could you, please, add a documentation change to the series. This would allow reviewers to test your proposal.
>>
>> Furthermore, please, provide tests on QEMU.
> 
> Documentation is good, also wiring up this use case for testing in CI
> via QEMU is a rather large ask. We're still on needing a general boot OS
> test or two in CI (and Ilias noted either on a call or IRC, I forget
> now, that there's been some progress on making up a small enough generic
> OS image to work from).
I would really like these two patches to land, it is the remaining piece 
I need to make STM32MP13xx usable with pure U-Boot. How can we proceed 
here ?
