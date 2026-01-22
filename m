Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FDCC44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 09:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFF2839DF;
	Thu, 22 Jan 2026 10:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="S6C6vk8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 549DF83A6A; Thu, 22 Jan 2026 10:11:54 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B945980086
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 10:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4730C101EFF; Thu, 22 Jan 2026 10:11:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769073109;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=nnCF0EYSM7z/EUJTVS7mCyhgj8qcQFvWJm4ivzdeudQ=;
 b=S6C6vk8IIMWXgJferLdcet8N3wltg5k0tvTpypUH2nCd8EFoWf0MrCh/xSRWHrWUFGH6sj
 P4Yx1A43e7hWG4B7kMXGblTqQ7yZgLSpF4qBSOWD6wsQb+DcGRpllPM4M21h3qCUB7bEE2
 ayDohNCQJCszRxu2uyWUYwb+aHjG6mdtutcNlN9hILUnT2T9bpDFY5kJ2Cag3raCjuP7cl
 4iYgv7E022bD97pHDFX0taDx5taQbPZ75ZFgZd87GrBRhiSD0cY8/i0JW4eUTOmAqDXAkd
 BMGRO3UAwENQjBzJlp8mnuPTrZmn8O8geqq98iPkV9/ISOn10Gl0Uw9Lhpif1A==
Message-ID: <3c02e1a5-aceb-1528-078f-80b695f741dd@nabladev.com>
Date: Thu, 22 Jan 2026 10:12:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/2] doc_ cmd: add documentation for sm3sum
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260106141405.82637-1-hs@nabladev.com>
 <20260106141405.82637-3-hs@nabladev.com>
 <a0cb3bb1-c9de-470b-9169-386b05eceb6f@cherry.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <a0cb3bb1-c9de-470b-9169-386b05eceb6f@cherry.de>
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

Hello Quentin,

sorry for long delay...

On 14.01.26 15:22, Quentin Schulz wrote:
> Hi Heiko,
> 
> Typo in title, should be doc: and not doc_.
> 
> On 1/6/26 3:14 PM, Heiko Schocher wrote:
>> add documentation for sm3sum command.
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>> ---
>>
>>   doc/usage/cmd/sm3sum.rst | 117 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 117 insertions(+)
>>   create mode 100644 doc/usage/cmd/sm3sum.rst
>>
>> diff --git a/doc/usage/cmd/sm3sum.rst b/doc/usage/cmd/sm3sum.rst
>> new file mode 100644
>> index 00000000000..3b157779a0e
>> --- /dev/null
>> +++ b/doc/usage/cmd/sm3sum.rst
>> @@ -0,0 +1,117 @@
>> +.. SPDX-License-Identifier: GPL-2.0+:
> 
> Use the canonical version:
> 
> GPL-2.0-or-later
> 
> c.f. https://spdx.org/licenses/GPL-2.0-or-later.html
> 
> (Do not end it with a colon either).

okay, but I just copied from other files... for example
doc/usage/cmd/dm.rst:
   1 .. SPDX-License-Identifier: GPL-2.0+:
   2

So of course I change it... but does that mean, we should fix all other
files too?

> 
>> +   Copyright 2025 Nabladev
> 
> Seems like we typically use a new comment for this line
> 
> .. Copyright 2025 Nabladev

Fixed.

> I **think** the copyright should use the name of the legal entity (so likely "Nabla Software 
> Engineering GmbH"). But IANAL and I personally don't care :)
> 
>> +   Written by Heiko Schocher <hs@nabladev.com>
>> +
>> +.. index::
>> +   single: sm3sum (command)
>> +
>> +sm3sum command
>> +==============
>> +
>> +Synopsis
>> +--------
>> +
>> +::
>> +
>> +    sm3sum - compute SM3 message digest
>> +
>> +    Usage:
>> +    sm3sum address count [[*]sum]
>> +      - compute SM3 message digest [save to sum]
>> +    sm3sum -v address count [*]sum
>> +      - verify sm3sum of memory area
>> +
>> +
>> +Description
>> +-----------
>> +
>> +The sm3sum command calculates the SM3_256 Hash from a
> 
> Are there variants of SM3? From what I understood, it's "equivalent" to sha256 in terms of security 
> and efficiency, but it's SM3, just that?

As I know, there is only sm3_256 hash. If you look for example
into include/tpm-v2.h
  33 #define TPM2_SM3_256_DIGEST_SIZE 32
[...]
277         TPM2_ALG_SM3_256        = 0x12,
[...]
301 #define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010

> 
>> +address with length of count bytes. If the -v option is
> 
> Can suggest:
> 
> """
> calculates the SM3 hash of data of ``count`` bytes at address ``address``.
> """
> 
> which highlights which parts of the command must be specific by the user.
> 
> s/-v/``-v``/

done.

> 
>> +passed to the command, it compares the calculated hash
>> +with the hash found at address sum.
>> +
> 
> s/sum/``sum``/.

done.

> 
>> +The SM3 secure hash, is calculated as specified by OSCCA GM/T
> 
> s/,//

done.

> 
>> +0004-2012 SM3 and described at
>> +
>> +https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
>> +
>> +Parameters
>> +----------
>> +
>> +address
>> +    address from where the sm3 hash is calculated
> 
> How is this value parsed? Is it deducted from the string (e.g. starts with 0x or contains hex digits 
> = hex, starts with 0, octal, otherwise decimal), or is it a forced base? This needs to be specified.

It is at the end from hextoul(), so it is at the end "hex"...

I added the line

Hexadecimal string, 0x prefix optional.


>> +
>> +count
>> +    length in bytes of memory area for which the sm3 hash is calculated

same here hextoul() used...

>> +
>> +sum
>> +    address of hash to which the calculated hash gets stored
> 
> This is only true if you sum starts with "*" no? Otherwise it's the name of the environment variable 
> where to store the checksum?

correct, good catch, see the examples.

> 
>> +
>> +    or if "-v" option is passed:
> 
> s/"-v"/``-v``/

done.

> 
>> +
>> +    address of hash with which the calculated hash gets compared.
>> +
>> +Example
>> +-------
>> +
>> +create some data
>> +
> 
> +at address ``0x0000000100000000``
> 
> (do we need the leading zeroes?)

removed them.

> 
>> +::
>> +
>> +    u-boot=> mw 0x0000000100000000 0x426f6f46 1
>> +    u-boot=> md.b 0x0000000100000000 4
>> +    00000000: 46 6f 6f 42                                      FooB
>> +
>> +and calculate the sm3sum from address and store it in environment
> 
> s/from address/of 4 bytes starting from address ``0x0000000100000000``/

done.

> 
>> +variable hashval
>> +
> 
> s/hashval/``hashval``/

done.

> 
>> +::
>> +
>> +    u-boot=> sm3sum 0x0000000100000000 4 hashval
>> +    sm3_256 for 100000000 ... 100000003 ==> 
>> cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7
>> +    u-boot=> print hashval
>> +    hashval=cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7
>> +    u-boot=>
>> +
>> +or calculate sm3sum from address and store it at address sum
> 
> s/from address/of 4 bytes starting from address ``0x0000000100000000``/
> 
> s/sum/``0x0000000110000000``/

done.

> 
>> +
>> +::
>> +
>> +    u-boot=> sm3sum 0x0000000100000000 4 *0x0000000110000000
>> +    sm3_256 for 100000000 ... 100000003 ==> 
>> cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7
>> +
>> +and now check if this hash is a valid sm3sum with "-v" option
> 
> s/is a valid sm3sum/is the expected sm3sum hash value/

done.

> 
> s/"-v"/``-v``/
>> +
>> +::
>> +
>> +    u-boot=> sm3sum -v 0x0000000100000000 4 *0x0000000110000000
>> +    u-boot=> echo $?
>> +    0
>> +
>> +example with wrong hash
>> +
>> +::
>> +
>> +    u-boot=> sm3sum -v 0x0000000100000000 4 *0x0000000110000004
>> +    sm3_256 for 100000000 ... 100000003 ==> 
>> cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7 != 
>> e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7ffffffff ** ERROR **
>> +    u-boot=>
>> +
>> +
>> +Configuration
>> +-------------
>> +
>> +Enable the sm3sum command via Kconfig option CONFIG_CMD_SM3SUM.
> 
> s/CONFIG_CMD_SM3SUM/``CONFIG_CMD_SM3SUM``/

done.

> 
>> +The "-v" option is separate enabled through Kconfig option
> 
> s/"-v"/``-v``/

done.

> 
>> +CONFIG_SM3SUM_VERIFY.
> 
> s/CONFIG_SM3SUM_VERIFY/``CONFIG_SM3SUM_VERIFY``/

done.

> 
>> +
>> +
>> +Return value
>> +------------
>> +
>> +The return value $? is true (0) if the hash is calculated or if
>> +the created hash is the same as the hash stored in memory at
>> +address sum.
>> +
>> +The return value is false (1) if there is a problem with
>> +calculating the hash, or if the hash is not the same as
>> +the hash stored ar address sum.
> 
> This matches the expectations I got from reading 
> https://docs.u-boot.org/en/latest/usage/cmdline.html#general-rules (point 3). So I would simply 
> remove the return value section in this patch here.

removed.

Many thanks for your input!

Azure build runs, if fine, I send v2...

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
