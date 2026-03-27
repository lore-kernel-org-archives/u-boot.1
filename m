Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23E110F2862
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 17:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ABAC83F14;
	Fri, 27 Mar 2026 18:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=online.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B5EC83FA3; Fri, 27 Mar 2026 18:50:10 +0100 (CET)
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F55683E7A
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 18:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=online.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=legoll@online.fr
Received: from [10.0.0.2] (unknown [82.65.243.93])
 (Authenticated sender: legoll@free.fr)
 by smtp4-g21.free.fr (Postfix) with ESMTPSA id 50D0F19F576;
 Fri, 27 Mar 2026 18:49:59 +0100 (CET)
Message-ID: <12e02b24-236e-40a9-8734-9f01a2d5f488@online.fr>
Date: Fri, 27 Mar 2026 18:49:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: spacemit: add K1 SPL build and test guide
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Guodong Xu <guodong@riscstar.com>
Cc: trini@konsulko.com, rick@andestech.com, ycliang@andestech.com,
 raymond.mao@riscstar.com, u-boot-spacemit@groups.io, u-boot@lists.denx.de
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
 <20260327081418.550546-1-guodong@riscstar.com>
 <52281343-9c46-4050-845d-9963c10266f3@canonical.com>
Content-Language: en-US
From: Vincent Legoll <legoll@online.fr>
In-Reply-To: <52281343-9c46-4050-845d-9963c10266f3@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Heinrich, Guodong Xu,

On 3/27/26 10:32, Heinrich Schuchardt wrote:
> Thanks a lot for providing this documentation. 

Yes, I also add my thanks. This is very useful to 
help passing-by random-joe-testers.

>> +Hardware Setup
>> +~~~~~~~~~~~~~~
>> +
>> +**1. UART Connection**
>> +
>> +Connect a 3.3V USB-to-UART cable to the **J25** header on the BPI-F3.
>
> Isn't this documentation meant to apply to all K1 boards?
>
> How about:
>
> Connect a 3.3V USB-to-UART cable to the board's UART header (J25 on 
> the BPI-F3). 


I'd even go a step further, i.e. keep this doc completely board-agnostic

and keep board-specific parts for their own pages. That would mean moving

the "Deploying via USB Fastboot" section out of this document.


This is only IMHO, don't take my personal preference as the maintainers one.


>> +Deploying via USB Fastboot
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +To enter BootROM fastboot mode:
>> +
>> +1. Disconnect USB Type-C cable from J15 (power off)
>
> J15 is only the designation on the BPI-F3. A more generic term may be 
> needed.
>
> How about:
>
> Power of the board by disconnecting the OTG port (J15 on BPI-F3) and 
> any additional power supply (12 V on BPI-F3). 


Maybe just: "Power off the board by unplugging its power supply."


>> +2. **Press and hold** the FDL button (see board layout above)


The FDL button is also probably BPI-F3 specific information, I see picture

of the OrangePi RV2 having a "Boot Key", which may be the equivalent one.


>> +.. note::
>> +
>> +   After DDR init succeeds, SPL proceeds to load U-Boot proper. Since
>> +   SPI NOR storage driver support is not yet available, SPL cannot
>> +   transition into U-Boot proper. When U-Boot stage support is ready,
>> +   this document will be updated.
>
> Please, move the note to the top of the document so that reader does 
> not discover at the end of the process that their board does not boot 
> anymore.


Yes, I agree. I missed it, probably out of haste, but still.

Thanks again

