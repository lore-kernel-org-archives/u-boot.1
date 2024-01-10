Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3CAC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC3D68790F;
	Wed, 10 Jan 2024 10:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ACfzN39Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22138792C; Wed, 10 Jan 2024 10:35:04 +0100 (CET)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA0BF8786F
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:34:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91B55C000A;
 Wed, 10 Jan 2024 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1704879298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DE9uuBGOE8iE11z7iCEv1LCNKh/TJEOuMQ8Ga9cizAc=;
 b=ACfzN39QerkyhuQYcMyL+iaES1diREhwNL6gFq/fmAVWthp+mxBC9/33D+CygX1oWNPZSe
 XXXSK+iIi+lDWbHzUb5BTg4K6OYAG8v0fHDP3RQNxAwLDeEb8dJ9A+IvCpjwxdIyS5Fxoa
 Jpme8dAIe989ELe7HoowOqMwEAYxTBcZ8s8qr7mkgo5QtjJybmmxc/lNzWyol8btLSRQrh
 0xplHZF4ntKFpWeAzeulNgdS0KVQ64xXbdp6PL+CliZd5OL71idhcfxjK5U3XcRZ5wDLJL
 KJk9pxsj8PNmlTtBI0+O+SBewC7Ym3Qz78IC12xl9q0Ix9MnwSRrkoue9u/8xA==
Message-ID: <6b76423c-6c38-4aba-a7f7-c7aafb3be80b@bootlin.com>
Date: Wed, 10 Jan 2024 10:34:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Suspend to RAM support for K3 J7200
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de
Cc: thomas.petazzoni@bootlin.com, nm@ti.com, u-kumar1@ti.com,
 gregory.clement@bootlin.com, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Gowtham Tammana <g-tammana@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240108165628.3935756-1-thomas.richard@bootlin.com>
 <8a2970aa-7c4b-41f4-9eeb-c43e2c5da285@ti.com>
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <8a2970aa-7c4b-41f4-9eeb-c43e2c5da285@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
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

On 1/9/24 18:32, Andrew Davis wrote:
> On 1/8/24 10:56 AM, Thomas Richard wrote:
>> This series is the U-Boot part of the work to add the suspend to RAM
>> support for the K3 J7200 EVM board.
>>
>> During the boot R5 SPL makes a copy of DM-Firmware and TF-A in memory.
>> Resume detection is done by reading a magic value in a pmic register
>> (set by DM-Firmware).
>>
>> If a resume is detected, R5 SPL run the exit retention sequence of the
>> DDR. Then it load TF-A and DM-Firmware using the copies done during
>> the boot
>> (fit image processing is skipped).
>> Before to start TF-A, R5 SPL writes a magic value in scratchpad ram. This
>> will be used by TF-A to detect that the board is resuming.
>>
>> The copy of TF-A/DM-Firmware, the SPL stack and malloc are located in a
>> reserved memory region (for the kernel point of view) to avoid any
>> memory corruption.
>>
>> This version is mostly to test the firewall protection with the suspend
>> to ram.
> 
> Seems to show the opposite, if you are able to access and load TF-A
> back to its spot after resume from un-trusted SPL then the firewall
> did not survive suspend to RAM. That is a huge security gap if TIFS
> is forgetting to put back the firewalls on resume.. What is the
> point of firewalls on these systems if I can just knock them all
> out by doing a simple suspend/resume cycle?

Hello Andrew,

Why are you talking about un-trusted SPL, how R5 SPL can be un-trusted ?
Our resume sequence starts like a power-on: ROM code is started, it
loads TIFS and R5 SPL.
As defined in the chain of trust [1], ROM authenticates TIFS and R5 SPL.
So I don't understand how R5 SPL can be un-trusted.

Then R5 SPL detects that the board is resuming (and does some specific
operations on the DDR).
But even if the board is resuming, TF-A is authenticated (using
ti_secure_image_post_process) like during the boot.

So once TF-A is loaded, firewall is active.
TF-A restores its context, then jump to its warm entrypoint.

I guess a weak point could be TF-A context (stored in DDR).

[1] https://docs.u-boot.org/en/latest/board/ti/k3.html#chain-of-trust

> 
>> Some comments (for the v2) were not fixed in this version.
> 
> Why not?
> 
>> This series has been tested with the series [1] to enable the firewall.
>> At the end of the resume sequence, TF-A is well protected by the
>> firewall, but OP-TEE remains unprotected.
>>
> 
> Then why post this? If it is just to get some eyes on it, then label
> it as an "RFC" so our silence isn't considered acceptance, otherwise we
> have to manually NAK these each time.

Yes sorry, I totally forgot to label it as RFC.

Regards,

Thomas
