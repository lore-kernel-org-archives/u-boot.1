Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6612CCCF9F1
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 23:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE4DC82E34;
	Wed, 29 Oct 2025 00:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="edFF9tYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5C8E832AD; Wed, 29 Oct 2025 00:12:24 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A61CB80422
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 00:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cx5kD5Jqkz9tQr;
 Wed, 29 Oct 2025 00:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761693140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yk54Tb2J4aMlhmGjkU5JWRXcjPtuLuCYYJ86HwrFppE=;
 b=edFF9tYxlXcFRxIiqKbddTevCee3HYrz4DrpnCVOUb5PEc528jHzI54xMy7D/nroubIP8Q
 Cy2VWfmu+j2XM0gL2VLMrmQhf06jt3ldV7PQ0eNyR8eHtaVZMHSCaV8RHvyWAltRQkvHj4
 IudiC923LG0IIGzmoHEieuSpE+bPn05tE2rxORUMWHEojzmbnrV+hmS5CGSvtu8WsGpVeD
 7pZLnI819m9wvi7DveoDN2+22cBW78+5hlF8KAytXn8k99VDoRP0R/8KOz5KIC3P1KFV7P
 sE0Iq1MNxarAXhz1lKa+aMAz9COrQgX1cSFUPhBi63SVF6GzY4PkrOXuNcxGSg==
Message-ID: <5e6552ae-cd1a-4644-8f61-ea29847b427d@mailbox.org>
Date: Wed, 29 Oct 2025 00:12:18 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] ARM: bootm: Add support for starting Linux through
 OpTee-OS on ARMv7a
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20250630000832.952206-1-marek.vasut@mailbox.org>
 <97DFDFA0-80F7-462B-B2A9-BDBAD42A191A@gmx.de>
 <20250630194711.GA523899@bill-the-cat>
 <9c9317eb-7d14-40c8-9955-c69a6a5a3bcb@mailbox.org>
 <20251028153641.GA833321@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251028153641.GA833321@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: zt1tquea1sud3dt6j73bk946ze661uaq
X-MBO-RS-ID: 1f51f0b88818829992d
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

On 10/28/25 4:36 PM, Tom Rini wrote:
> On Tue, Oct 28, 2025 at 04:11:38PM +0100, Marek Vasut wrote:
>> On 6/30/25 9:47 PM, Tom Rini wrote:
>>> On Mon, Jun 30, 2025 at 07:18:33AM +0200, Heinrich Schuchardt wrote:
>>>> Am 30. Juni 2025 02:08:05 MESZ schrieb Marek Vasut <marek.vasut@mailbox.org>:
>>>>> Add support for jumping to Linux kernel through OpTee-OS on ARMv7a.
>>>>> This is only supported if U-Boot runs in PL1 secure. This change adds
>>>>> two components, one is fitImage OpTee-OS loadable handler, which makes
>>>>> a note of OpTee-OS being loaded and stores the load address for later
>>>>> jump to it. The second part is the actual jump to Linux through OpTee-OS.
>>>>> The jump through OpTee-OS requires set up of multiple CPU registers, r1
>>>>> and r2 are passed through, r0 and r3 have to be set to 0, lr is set to
>>>>> Linux kernel entry point. This setup is done by new assembler function
>>>>> boot_jump_linux_via_optee().
>>>>>
>>>>> The boot_jump_linux_via_optee() also includes STM32MP13xx late TZC
>>>>> configuration write, this cannot be moved easily, hence the ifdef.
>>>>
>>>> Hello Marek,
>>>>
>>>> Could you, please, add a documentation change to the series. This would allow reviewers to test your proposal.
>>>>
>>>> Furthermore, please, provide tests on QEMU.
>>>
>>> Documentation is good, also wiring up this use case for testing in CI
>>> via QEMU is a rather large ask. We're still on needing a general boot OS
>>> test or two in CI (and Ilias noted either on a call or IRC, I forget
>>> now, that there's been some progress on making up a small enough generic
>>> OS image to work from).
>> I would really like these two patches to land, it is the remaining piece I
>> need to make STM32MP13xx usable with pure U-Boot. How can we proceed here ?
> 
> There was some minor rewording requested, and adding documentation is
> also good. We can't reasonably add CI testing here at this time, yes?
I added documentation in V3 now.

As for CI testing, I recall the infrastructure is not there yet.
