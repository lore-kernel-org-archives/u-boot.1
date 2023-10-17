Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCE2CDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 12:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A11F286E37;
	Tue, 17 Oct 2023 14:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=48.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=48.io header.i=@48.io header.b="rUORUOub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E18086BF2; Tue, 17 Oct 2023 14:04:12 +0200 (CEST)
Received: from pruto.48.io (48.io [37.205.10.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A83F86B05
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 14:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=48.io
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=srk@48.io
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by pruto.48.io (Postfix) with ESMTPSA id 77DE419FE9B;
 Tue, 17 Oct 2023 14:04:08 +0200 (CEST)
DMARC-Filter: OpenDMARC Filter v1.3.2 pruto.48.io 77DE419FE9B
Authentication-Results: pruto.48.io;
 dmarc=none (p=none dis=none) header.from=48.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=48.io; s=default;
 t=1697544248; bh=6v759VvLTbJMM185PhA7JAT+0OHC2Rm/dJhJQFRC8rk=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=rUORUOub4xQ24trhbvtgYFVSxcnsdMbcQAgSet6GEv3IHuvkW/HNvzfCg7iuhYsiI
 Nm+ReZm/7QgNxb6FIqr2OI4eo9jRk0SqdK6+09SXOkWo1UyQvwlGOePo2wn+wcyzG1
 DzStmOv59XzmU2NBapD2NoadV4toIDWhRF52Xcvg=
Message-ID: <29d93577-3bb5-4a0b-975e-8daa84a7ae43@48.io>
Date: Tue, 17 Oct 2023 14:04:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] kbuild: use which $(DTC) as a dependency
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20231017104453.2121276-1-srk@48.io>
 <1eae0688-cda0-4537-a1f7-a11f61a27146@prevas.dk>
Content-Language: en-US
From: sorki <srk@48.io>
In-Reply-To: <1eae0688-cda0-4537-a1f7-a11f61a27146@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 17 Oct 2023 14:05:15 +0200
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

On 10/17/23 13:27, Rasmus Villemoes wrote:
> On 17/10/2023 12.44, Richard Marko wrote:
>> If we try to build using external dtc using
>>
>>> make DTC=dtc
>> we get a confusing error like
>>
>>> make[2]: *** No rule to make target 'arch/x86/dts/bayleybay.dtb',
>>> needed by 'dtbs'.  Stop.
>> Workaround is to use
>>
>>> make DTC=$( which dtc )
>> which gives make a full path, so the dependency
>> is satisfied.
>>
>> This was introduced by commit
>> d50af66 kbuild: add dtc as dependency on .dtb files
>>
>> and we extend it so it calls which automatically
>> (similar to scripts/dtc-version.sh)
>
> Let's please not deviate from linux Kbuild unless we absolutely have to.
> In this case, passing an absolute path works just fine, and is AFAICT
> the only documented way to pass DTC. E.g. doc/build/gcc.rst has
>
>      DTC=/usr/bin/dtc make
>
> as example.
>
> [And if we do this, then at the very least this should also be done for
> the .dtbo rule and wherever else $(DTC) is used. But I'm really not a
> fan of calling out to $(shell which ...) in the rule itself. Perhaps if
> it was done just once, near DTC/DTC_IN_TREE, something like (not real
> make syntax I think)
>
> ifneq ($(DTC), $(DTC_IN_TREE))
> DTC := $(shell which $(DTC))
> endif
>
> But I don't think we should be doing this at all.]
>
> Rasmus
>
I'm fine with passing a full path and not adding this.

The DTC=dtc thingie was done in NixOS and it stopped working for recent 
versions. It took me a while to figure out what is going on because the 
failure message seems very unrelated and no dtc is called except for 
dtc-version.sh check which passes just fine. Alternatively we could fail 
earlier if $(DTC) is not an absolute path and get rid of `which` call in 
dtc-version.sh but I'm not sure how to formulate that into make either.

Richard

