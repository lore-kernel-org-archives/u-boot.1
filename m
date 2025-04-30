Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E08C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 17:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC3682C03;
	Wed, 30 Apr 2025 19:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eb9mJHXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 517E682C13; Wed, 30 Apr 2025 19:26:34 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D78E982BF2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 19:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53UHQU6C3444578
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 12:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746033990;
 bh=V4tLZWtE51enZ0GUqvO+OurHz/Txbj+hBloZfMPRGps=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=eb9mJHXoRdVNIoRhNhL37EqErmb7eAQc48pnRMNSGaAftv+i0p6Yr4c4L9C0rLsC8
 X8hciLGauSb/rKTSLHfGiZ32fYZ2SZ1JEHq6UEQCn1jthpHK1EmIAy39FObYjUjkBk
 5XM7JJABOt84fFgtFaLYJniWCel0boI97N7lyx7g=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53UHQU7h026081
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Apr 2025 12:26:30 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Apr 2025 12:26:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Apr 2025 12:26:29 -0500
Received: from [10.249.142.58] ([10.249.142.58])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53UHQRuV121808;
 Wed, 30 Apr 2025 12:26:28 -0500
Message-ID: <fa03eca6-1cdc-4ff6-abb6-fde05682da01@ti.com>
Date: Wed, 30 Apr 2025 22:56:27 +0530
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
To: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
CC: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
References: <20250430135751.2626849-1-anshuld@ti.com>
 <20250430162904.nmjqomr2kmxhllfc@bryanbrattlof.com>
 <20250430163156.GV1261075@bill-the-cat>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250430163156.GV1261075@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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



On 4/30/2025 10:01 PM, Tom Rini wrote:
> On Wed, Apr 30, 2025 at 11:29:04AM -0500, Bryan Brattlof wrote:
>> On April 30, 2025 thus sayeth Anshul Dalal:
>>> As discussed here[1], the go command causes undefined behavior when used
>>> for running custom OSes since the icache might hold outdated data. OSes
>>> usually also expect the MMU to be disabled upon execution.
>>>
>>> Therefore this patch adds a call to cleanup_before_linux before we jump
>>> to the loaded program/os which disables both the caches and the MMU.
>>> This makes the go command's behavior consistent with riscv platforms.
>>>
>>
>> I know quite a few other OSes are beginning to use U-Boot (QNX, 
>> GreenHills or all the other RTOSes) each with their own requirements 
>> from the bootloader. I'm curious if we should make boot* a little more 
>> generic rather than abuse the 'go' command.

VXworks has its own:
https://docs.u-boot.org/en/stable/usage/os/vxworks.html

I suppose QNX and others should ideally have their own cmds as needed.

> 
> Well, that's what bootelf is for :)
> 

And if its not an elf but some .bin file "go" cmd should be used in
conjunction with "cache" cmd here to flush/disable cache, I guess?

If so, we should probably update the docs for this cmd appropriately so
as to avoid end users overloading like what RISC-V did?

Regards
Vignesh



