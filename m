Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E14C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 19:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C8787751;
	Fri, 12 Jan 2024 20:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q8qYwDPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6570876C6; Fri, 12 Jan 2024 20:52:48 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B0B8876C6
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 20:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CJqeYw115525;
 Fri, 12 Jan 2024 13:52:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705089160;
 bh=NAAJelHfRwOvr2GWFs/+5YlZfFfnbTRcFQfPov6Ue8U=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=q8qYwDPiSvnf0WfNHvA41exghaYPGIhnudRi2YLNeIWwoLuvZbsF3V+QF5HFl1Dro
 wG9XCXfVSSpqEnT2nA2FKv0lxWxqFRFWok2TWPGfipNrcPN9ZhUy/xyNX2/zDoP2vP
 VWpfk81ZyYar0vtGvg5KADbm91gGtLsmM6AhPkaU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CJqeW4011224
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 13:52:40 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 13:52:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 13:52:40 -0600
Received: from [10.249.40.136] ([10.249.40.136])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CJqdNf065004;
 Fri, 12 Jan 2024 13:52:39 -0600
Message-ID: <5f246553-e410-4643-a6b4-4c071b4a1239@ti.com>
Date: Fri, 12 Jan 2024 13:52:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Suspend to RAM support for K3 J7200
Content-Language: en-US
To: Thomas Richard <thomas.richard@bootlin.com>, <u-boot@lists.denx.de>
CC: <thomas.petazzoni@bootlin.com>, <nm@ti.com>, <u-kumar1@ti.com>,
 <gregory.clement@bootlin.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Gowtham Tammana <g-tammana@ti.com>, "Manorit Chawdhry" <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240108165628.3935756-1-thomas.richard@bootlin.com>
 <8a2970aa-7c4b-41f4-9eeb-c43e2c5da285@ti.com>
 <6b76423c-6c38-4aba-a7f7-c7aafb3be80b@bootlin.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <6b76423c-6c38-4aba-a7f7-c7aafb3be80b@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 1/10/24 3:34 AM, Thomas Richard wrote:
> On 1/9/24 18:32, Andrew Davis wrote:
>> On 1/8/24 10:56 AM, Thomas Richard wrote:
>>> This series is the U-Boot part of the work to add the suspend to RAM
>>> support for the K3 J7200 EVM board.
>>>
>>> During the boot R5 SPL makes a copy of DM-Firmware and TF-A in memory.
>>> Resume detection is done by reading a magic value in a pmic register
>>> (set by DM-Firmware).
>>>
>>> If a resume is detected, R5 SPL run the exit retention sequence of the
>>> DDR. Then it load TF-A and DM-Firmware using the copies done during
>>> the boot
>>> (fit image processing is skipped).
>>> Before to start TF-A, R5 SPL writes a magic value in scratchpad ram. This
>>> will be used by TF-A to detect that the board is resuming.
>>>
>>> The copy of TF-A/DM-Firmware, the SPL stack and malloc are located in a
>>> reserved memory region (for the kernel point of view) to avoid any
>>> memory corruption.
>>>
>>> This version is mostly to test the firewall protection with the suspend
>>> to ram.
>>
>> Seems to show the opposite, if you are able to access and load TF-A
>> back to its spot after resume from un-trusted SPL then the firewall
>> did not survive suspend to RAM. That is a huge security gap if TIFS
>> is forgetting to put back the firewalls on resume.. What is the
>> point of firewalls on these systems if I can just knock them all
>> out by doing a simple suspend/resume cycle?
> 
> Hello Andrew,
> 
> Why are you talking about un-trusted SPL, how R5 SPL can be un-trusted ?

Very easily, when was the last time it had a proper security audit,
was it written from the ground up with security in mind, what secure
software development standards does it follow, etc.. No offense to
SPL, it is very good at what it was designed for, but it was not
designed for security like OP-TEE or TF-A.

> Our resume sequence starts like a power-on: ROM code is started, it
> loads TIFS and R5 SPL.
> As defined in the chain of trust [1], ROM authenticates TIFS and R5 SPL.
> So I don't understand how R5 SPL can be un-trusted.
> 

You are making a common mistake here, just because some code was
authenticated before it started, doesn't mean it is invulnerable to
attack and cannot be compromised. Authentication only protects
against modification on the boot media.

> Then R5 SPL detects that the board is resuming (and does some specific
> operations on the DDR).
> But even if the board is resuming, TF-A is authenticated (using
> ti_secure_image_post_process) like during the boot.

Right, and this is the only thing that saves us here. TF-A being
authenticated by a higher trust entity like TIFS. My comment
was more about the context in DDR as you point out below. I'm
assuming TF-A will gain some way to authenticate that while
loading it in. Right now R5 SPL could read it out or modify
it (and as above, we don't trust R5 SPL), so having that in
plantext and un-firewalled at that point is a problem that
needs fixed for this solution to be complete.

To be fair that is a TF-A problem, but both need to be in place.

Andrew

> 
> So once TF-A is loaded, firewall is active.
> TF-A restores its context, then jump to its warm entrypoint.
> 
> I guess a weak point could be TF-A context (stored in DDR).
> 
> [1] https://docs.u-boot.org/en/latest/board/ti/k3.html#chain-of-trust
> 
>>
>>> Some comments (for the v2) were not fixed in this version.
>>
>> Why not?
>>
>>> This series has been tested with the series [1] to enable the firewall.
>>> At the end of the resume sequence, TF-A is well protected by the
>>> firewall, but OP-TEE remains unprotected.
>>>
>>
>> Then why post this? If it is just to get some eyes on it, then label
>> it as an "RFC" so our silence isn't considered acceptance, otherwise we
>> have to manually NAK these each time.
> 
> Yes sorry, I totally forgot to label it as RFC.
> 
> Regards,
> 
> Thomas
