Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B89C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 14:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5832B876E4;
	Wed,  6 Mar 2024 15:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cNAtzjBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F4FD876F3; Wed,  6 Mar 2024 15:03:36 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B94387653
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 15:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426E3U13095348;
 Wed, 6 Mar 2024 08:03:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709733810;
 bh=Bji7cKZuKXnWcFyd4Me7yAGrL1vqSf1pIyzwPCxdwAU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=cNAtzjBZnXibiqD1Bb3UP8//dLMKyvPEt0ETSu2ZZpNUOv5uVjTodDbG8QytDYwAh
 7NowI7V+p/MpFuwCEBGe+BRf5HosIouC6jeg//mdOc5rA0gOvBe/yDCTI5zOEvOrox
 CgQul9Wy/Ho5tFa6hUJ3L7ryz+uhZnP1n3D76trE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426E3UHv021050
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Mar 2024 08:03:30 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 08:03:30 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 08:03:30 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426E3TWC048944;
 Wed, 6 Mar 2024 08:03:29 -0600
Message-ID: <0a1910d6-c25b-4b77-abbe-d14443b061f3@ti.com>
Date: Wed, 6 Mar 2024 08:03:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm: mach-k3: am62: Fixup TF-A/OP-TEE reserved-memory
 node in FDT
Content-Language: en-US
To: Bryan Brattlof <bb@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-5-afd@ti.com>
 <20240306133517.djtzqotxzour34ib@bryanbrattlof.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240306133517.djtzqotxzour34ib@bryanbrattlof.com>
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

On 3/6/24 7:35 AM, Bryan Brattlof wrote:
> On February 14, 2024 thus sayeth Andrew Davis:
>> The address we load TF-A and OP-TEE to is configurable by Kconfig
>> CONFIG_K3_{ATF,OPTEE}_LOAD_ADDR, but the DT nodes reserving this memory
>> are often statically defined. As these binaries are dynamically loadable,
>> and in the case of OP-TEE may not even be loaded at all, hard-coding these
>> addresses is not a hardware description, but rather a configuration.
>>
>> If the address that U-Boot loaded TF-A or OP-TEE does not match the
>> address in hard-coded in DT, then fix that node address. This also handles
>> the case when no reserved memory for these is provided by DT, which is
>> more correct as explained above.
>>
>> Add this fixup function, and enable it for AM62.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
> 
> Acked-by: Bryan Brattlof <bb@ti.com>
> 
> Does this mean we need to no-map these regions in the MMU as well? Right
> now it's just statically defined. I was looking into trying to read the
> reserved-memory{} node to see if we could dynamically build the MMU
> config but that would have to happen after this step right?
> 

Good question. So TF-A/OP-TEE are loaded by R5 SPL, which means by
the time A53 SPL starts they are already in place and firewalled,
which means yes we should no-map them in MMU to prevent some
speculative fetch (A53 doesn't do that, but A72 on other K3 device
might) or similar from causing a firewall exception.

The fixup in this patch is done to the Linux DT file right before
it is handed off to Linux, which as you point out happens after
we setup the U-Boot MMU.

This is more a problem in theory, but not really one in practice.
I know, I don't like that answer either, but I can't think of a
better solution outside of doing this fixup in R5 SPL to the
U-Boot DTB also. (Which might work, but seems overkill)..

Andrew

> ~Bryan
