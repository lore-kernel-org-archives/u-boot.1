Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05633C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 08:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E90384A30;
	Tue, 30 Jun 2026 10:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="LYhC7x9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C0284A27; Tue, 30 Jun 2026 10:41:43 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8DBA84119
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B4C89115234; Tue, 30 Jun 2026 10:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782808901;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=++dg+N+d6+ZWWfjIGhc7zPJbY0BtaWnmi5B8VV1pk1k=;
 b=LYhC7x9tmvHRxQTSx1JkY70q42rJBrLAEBM7+70xU9K9Oqmge/j1ngpJvsyPwyxTl9VVdv
 SSSSTFBPVNpxjqrw+fHi8kbfQJY1PhRK09WdaHVHC5yaLHLLhVdKoQDtYPsUdttXLpM1zv
 oh8seBJV51EPBoObnrYwKLRFiVRM8F57Og/t4hC8wHFzYq/0a+PKvxgMKddSg/QHP7B0/9
 X6C0/p+Oa2Fgk0N0QT4pN84j7iFVJJA7EOyhVCcZoocGI6zqZtQRhgmfbqquVC3Ase0/nj
 Nas1zSIrE49NTucbf0QQC/tzICs3Zz5VTrGhcW2kVwrokMH4MwfS81vvHsDZFg==
Message-ID: <c76343af-0af9-4edc-a19c-26e87c758990@nabladev.com>
Date: Tue, 30 Jun 2026 10:41:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: imx8mimage: Generate FSPI header in binman
 instead of mkimage
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
References: <20260610161748.54824-1-marex@nabladev.com>
 <659d8f70-bbd4-468d-90e4-7109a9166353@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <659d8f70-bbd4-468d-90e4-7109a9166353@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/26/26 1:14 PM, Quentin Schulz wrote:

Hello Quentin,

> On 6/10/26 6:17 PM, Marek Vasut wrote:
>> Stop depending on the current mkimage method of generating the FSPI
>> header, instead generate the FSPI header within binman itself. This
> 
> Soooooo, do we still need the mkimage version or can we remove it?

I believe it is part of ABI, so we cannot remove it.

> I 
> generally would be against it since "users may make use of it" but since 
> you would need to rebuild (according to this commit log) it to be able 
> to compile what you want for your device, essentially making the host 
> tool dependent on the target you're building for, I guess it could be 
> removed? What do you think? I'm eyeing tools/imx8mimage.c and tools/ 
> imximage.c specifically.

Whatever the tool generates right now is a generic SPI NOR boot header, 
for all configurations that are in the tree that use this header. I 
think we should keep this, but only to retain backward compatibility and 
not break users who might depend on it.

> Which makes me ask "is this something we could do for imximage as well?"

What does "this" refer to -- drop something, or, add some header 
support, or something else entirely ?

[...]

>> +++ b/tools/binman/etype/nxp_imx8mimage.py
>> @@ -8,6 +8,7 @@
>>   #
>>   import os
> 
> You remove the only user of this module later in the diff, so this can 
> be removed as well.

Fixed in V2, thanks.

>> +import struct
>>   from collections import OrderedDict
>> @@ -23,10 +24,25 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
>>       Properties / Entry arguments:
>>           - nxp,boot-from - device to boot from (e.g. 'sd')
>> +        - nxp,fspi-columnadresswidth - FSPI column address width
>> +            (3 - HyperFlash, 12/13 - Serial NAND, 0 - Otherwise)
>> +        - nxp,fspi-controllermisc-diffclk - FSPI differential clock 
>> enable
>> +        - nxp,fspi-controllermisc-wordaddr - FSPI word addressable 
>> enable
>> +        - nxp,fspi-controllermisc-safecfg - FSPI safe configuration 
>> frequency
>> +        - nxp,fspi-controllermisc-padovr - FSPI pad setting override
>> +        - nxp,fspi-controllermisc-ddrmode - FSPI DDR mode
>> +        - nxp,fspi-lutcustomseq - FSPI use LUT sequence parameters
>> +        - nxp,fspi-devicetype - FSPI device type
>> +            (1 - SPI NOR, 2 - Serial NAND)
>> +        - nxp,fspi-flashpadtype - FSPI flash pad type
>> +            (1 - Single pad, 2 - Dual pads, 4 - Quad pads, 8 - Octal 
>> pads)
>> +        - nxp,fspi-readsampleclksrc - FSPI clock source
>> +            (0 - Internal loopback, 1 - loopback from DQS pad, 3 - 
>> Flash provided DQS).
>> +        - nxp,fspi-serialclkfreq - FSPI clock frequency
>> +            (1 - 30 MHz, 2 - 50 MHz, 3 - 60 MHz, 4 - 75 MHz, 5 - 80 MHz,
>> +             6 - 100 MHz, 7 - 133 MHz, 8 - 166 MHz).
> 
> OK, so... I have not played with i.MX8M but I would be absolutely 
> clueless on how to configure this. Is there some literature, readme, 
> docs we could point at?

Yes, there is the SoC datasheet if you ever need to change the defaults 
(I haven't done that yet).

> Please also mention that all nxp,fspi-* arguments are only available if 
> nxp,boot-from == "fspi".

Fixed in V2, thanks.

> Please document which is the default if the argument is omitted.

Fixed in V2, thanks.

> Finally, I don't think it makes sense to tell the user "say 1 if you 
> want 30MHz, 2 for 50MHz", why can't the user specify the frequency 
> directly and we do the job for them of translating it to something to 
> put in the binary? (same remark for all arguments).

Does a big switch-case bring up any improvement in this case ?

>> +                # 0x88..0xfff ... Padding (end of FSPI block is 
>> 0x1bf, align to 4k)
>> +                spidata += tools.get_bytes(0, 0x1000 - 0xa8)
> 
> I'll let people with an i.MX8M review the implementation but I do have 
> some feedback to provide on the logic. This essentially removes the 
> ability to use an externally-provided fspi_header.bin. So you should fix 
> in the same commit arch/arm/dts/imx8mm-u-boot.dtsi and arch/arm/dts/ 
> imx8mn-u-boot.dtsi to migrate them to the new mechanism...

Not in the same commit, but the fspi-header.bin references should be 
dropped eventually.

> Which likely 
> means going through all board defconfigs and figuring out which values 
> they use for compiling the mkimage that is used to generate this file 
> and then put it in a board-specific -u-boot.dtsi.

They all use the same values, the default values that are also used in 
this implementation.

> The other issue is 
> downstream which will now be forced to migrate to it. I guess it could 
> be fine but another option could be "specify the binary file to use or 
> all those arguments instead" and keep current logic and simply extend it 
> to support the new arguments.

Let's not make this more complicated than it already is, and let's ditch 
the old fspi-header.bin mechanism entirely. Note that the 
fspi-header.bin handling was broken for some 2 years now, so I don't 
think anyone depends on it.

> Otherwise, maybe checking the argument 
> exists in the DTB and fail hard and tell the user to migrate to the new 
> format with multiple arguments (what happens if we remove support for 
> nxp,fspi-header-filename but it's still present in the DTS and the user 
> hasn't migrated to the new arguments? does it fail the build or silently 
> build something that they cannot boot?).

It generates the header using default values, which seems to be used by 
most users anyway.
