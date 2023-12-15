Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C442EC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A515187BC9;
	Fri, 15 Dec 2023 14:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="lOKGv8Ec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 133A287B9E; Fri, 15 Dec 2023 13:10:49 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFF7687B69
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 13:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 417B7A05EF;
 Fri, 15 Dec 2023 13:10:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=mail; bh=xHeXEFmwzIf9HmOD/y4s
 PWVzRpxYpvNClRfUmkLcq+8=; b=lOKGv8EcTL4JJyMTjVUFKgaqyza+ybuA3Wlq
 7M2jl+1Q3WIi82mTbWuKQa6nauz3zeu/pIcIUZsr0Gx3sipSEUBzKwHW+1Q0f7Lh
 eF5zdqEGZRJS/IbY+yUE8MzbpJyz+Qhbs0EHjqWfI9iCghibLitg8UUGCEiHCEHq
 R3SQ+sSYSc6y/oAO+Vl9n2YnFNU1qY6fhiqzV+XJ+Iw2QRZawBO8Q/xq4SCZt3r/
 uvT9melgDVyM85gn97O3zDg8BTJ32JsYM6SUujeorG0mL/5ISl3potwthMUpaZWl
 t01LQ/lGf1p4OSMN8pRKSlF8QP8X+87/8iaR6lGwmuNyKsy+LJMkpIJ7VYCXj77D
 iLEh2+r/AvXUqYVHf5tAGq6zv0Qh4lDBHXmWc5I8iHEIUGuN/JVP96KqQjCUTuo9
 GBTjerAYyYRtyDmhDu0rT5t4WfrKixucX44bN9BYcHzp0xXCTLbGhoTH0yAQ2gGu
 UO6nQBbH1pB3BjoLKvoiq5jOFAwF9GFtUb0Jud5NWx4RQqj3Dnb9GIjGLe3uZMGL
 gPRZ8QdXrD+d7APGMkZul/uZtf3SP+/2lYfJ+ZXBhEAgCT6GzHcxMsNImusOxNCh
 c89sRqwkvfgcD9WbOqj7a47D4qEqHrcm1xZx/JpSYJE1PL/AJmzSOINOFvckGgHI
 3hoeEQU=
Message-ID: <723ec7d9-218d-4ad2-ae02-ead55a10dafd@prolan.hu>
Date: Fri, 15 Dec 2023 13:10:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: spl: Use separate fault handlers instead of a single
 common one
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20231214162931.34236-1-csokas.bence@prolan.hu>
 <20231214175348.GM2513409@bill-the-cat>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20231214175348.GM2513409@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.254.7.28]
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 sinope.intranet.prolan.hu (10.254.0.237)
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D385C6D7066
X-Mailman-Approved-At: Fri, 15 Dec 2023 14:15:15 +0100
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



2023. 12. 14. 18:53 keltezéssel, Tom Rini írta:
> On Thu, Dec 14, 2023 at 05:29:31PM +0100, Csókás Bence wrote:
> 
>> It may be necessary to set breakpoints etc. on a specific fault handler in SPL.
>> Add a Kconfig option to separate the different handlers into their own individual infinite loops.
>>
>> Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
>> ---
>>   arch/arm/Kconfig       | 10 ++++++++++
>>   arch/arm/lib/vectors.S | 18 ++++++++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 328e2ddc33..47494cb72b 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -79,6 +79,16 @@ config SPL_SYS_NO_VECTOR_TABLE
>>   	depends on SPL
>>   	bool
>>   
>> +config SPL_USE_SEPARATE_FAULT_HANDLERS
>> +	bool "Use separate fault handlers instead of a single common one"
>> +	depends on !SPL_SYS_NO_VECTOR_TABLE
> 
> Will this dep catch that this is only valid for !ARM64 && !CPU_V7M ?

Is it? How so?
So should I put `depends on !SPL_SYS_NO_VECTOR_TABLE && !ARM64 && 
!CPU_V7M` instead?

> 
>> +	default n
> 
> "n" is the default, so don't add this.

Understood.

> 
> Otherwise looks good.
> 

