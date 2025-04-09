Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715D2C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C77C283933;
	Wed,  9 Apr 2025 19:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bKulvzja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC16A838FA; Wed,  9 Apr 2025 19:26:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4EB283946
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3b7d=W4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744219590;
 bh=qUTx83rT6cvuD4VMDE+mFGp5JAYBh2N5zofjh62Rifk=;
 b=bKulvzjaE9Fln/LkD4HkCUmLK1eT9Q6r1jIfrTLRCly41OKBlUyoAIisiWT3B+UeWXG2xFCRG
 TIbZ65Y5zwY0A11+rWx8c3kN/Kal258p5y0MEI+sKvST2vHRIx7od/v9nKXNDooqgNUvMezkbXX
 p0y1GEp3aVJr9JCganaCgnC0cBoLiX0p3rTwfZuF9iFU33rouv7QmHWO256ZVps2HBcr40u66hP
 kF5HxLG9zBZUz3SB/oERQMeExlgRjivfNw4J3LqQUlB3lBjLEGYAu2HcFjsjiBoAMsfTgFEN0QD
 e6dxK3Rr73k4t5CBup9ReUdy+4g91jGHGXQynP4pGqXw==
X-Forward-Email-ID: 67f6adc21aecaf4e4109094b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <4f4942a1-c08b-4c6f-a898-7defba03d8f1@kwiboo.se>
Date: Wed, 9 Apr 2025 19:26:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] rockchip: binman: Support use of crc32 for
 SPL_FIT_SIGNATURE
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-10-jonas@kwiboo.se>
 <5d3c9e7f-336b-4b67-a7f4-a25a61b0908e@cherry.de>
 <ac68b883-021c-43ac-b834-bafa54e7182b@kwiboo.se>
 <887d7a5c-0ba7-4e62-bee2-8e5c159710c8@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <887d7a5c-0ba7-4e62-bee2-8e5c159710c8@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Quentin,

On 2025-04-09 18:11, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 4/9/25 5:38 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2025-04-09 13:06, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>>>> Use of SHA256 checksum validation on ARMv7 SoCs can be very time
>>>> consuming compared to ARMv8 SoCs with Crypto Extensions.
>>>>
>>>> Add support for use of the crc32 hash algo when SHA256 is not supported.
>>>> Also use a HAS_HASH to simplify the ifdefs when no known hash algo is
>>>> compiled.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>
>>> I don't know enough about general security but this very much looks like
>>> a bad idea to me.
>>>
>>> https://web.archive.org/web/20170210173741/http://www.derkeiler.com/Newsgroups/sci.crypt/2003-07/1451.html
>>>
>>> """
>>> While properly designed CRC's are good at detecting random errors in
>>> the data (due to e.g. line noise), the CRC is useless as a secure
>>> indicator of intentional manipulation of the data. And this is
>>> because it's not hard at all to modify the data to produce any CRC
>>> you desire (e.g. the same CRC as the original data, to try to
>>> disguise your data manipulation).
>>> """
>>>
>>> (yes I took the "first" link my web search engine returned me, thanks
>>> confirmation bias!).
>>
>> I am fully aware, and the fallback to use crc32, and current primarily
>> use of sha256, should not be considered a security feature. It is
>> intended purely for a checksum validation of the binary blob after it
>> has been loaded into memory and before U-Boot otherwise unconditionally
>> jumps to and execute the loaded blob of binary code.
>>
>>>
>>> I don't want to give people a false sense of security. If it really
>>> comes down to it, I'd rather have an explicit Kconfig symbol to set this
>>> value (maybe have a `choice` even) and be very clear about security
>>> implications.
>>
>> Prior to the addition of the hash { algo=sha256 }, there was no checksum
>> test and U-Boot SPL would unconditionally jump to the loaded data, even
>> if it had been corrupted, was only halfway written or otherwise
>> overwritten.
>>
>> The addition of crc32 instead of sha256 is just to allow older board
>> variants with weaker SoCs to at least have some sort of checksum
>> validation in use without affecting the boot time too much.
>>
>> On my rk3228 board, validation using sha256 could take a few seconds,
>> and with crc32 it could be measured in ms.
>>
>> To me, having at least some default checksum validation is preferred
>> over none at all.
>>
> 
> Except if this confuses people into thinking they have a secure system 
> except they use CRC32 instead of something more appropriate like SHA256.
> 
> It seems like the "hash" node presence doesn't mean a FIT conf or image 
> node is signed.

Correct, current use of a hash node does not indicate any type of
signature validation, only that a hash value should be calculated and
added in the final FIT output.

The signature node must be added separately and/or injected at a later
stage, and for that the algo prop use a {checksum_algo},{crypto_algo} 
format. Where checksum_algo = [sha1, sha256, sha384, sha512] and
crypto_algo = [rsa2048, rsa3072, rsa4096, ecdsa256, ecdsa384, secp521r1].
See tools/image-sig-host.c for supported algos.

> I also don't see many device trees with a signature 
> node... which is kinda odd. Looking a bit into the signature node in the 
> spec and binman tests, it's not clear to me if the hash node is reused 
> by the signature node if if exists and if their algo should match and 
> what exactly is checked by the signature node (like signing the hash 
> string contained in the hash node(s) listed in sign-images property, or 
> (re-)generating a hash of those and signing it at build time?

I have not looked into how signing and signature validation works, and
if the checksum in signature { algo } must match the one used in
hash { algo }.

My personal interest have only ever been to add bare minimum checksum
validation in order to avoid executing code that is known to be broken
(a basic checksum test fails).

> 
> If
> a) it is not possible to have a hash node's algo differ from a signature 
> node's algo, then I'm fine with this as crc32 won't be allowed
> b) the signature node regenerates a hash regardless of the hash in the 
> hash node, meaning the signature will be "appropriately secure" 
> regardless of the algorithm listed in the hash node, then I'm fine with 
> it too,
> c) it is possible to sign a crc32 hash, don't want it :)

To actually validate a signature in SPL you would need to enable support
for RSA or ECDSA in SPL, without it only checksum validation may happen.

So yes, to get a proper secure solution there is much more to do than
just select a checksum algo. You need to correctly handle a signing key,
sign  FIT, preferably also sign the rk boot image, burn public cert in
OTP and more.

Not sure what you want me to do here, in my mind the use of a hash algo
has never been an indication of security, and the default to use sha256
was only because it was supported by ARMv8 CE on the SoC being tested
when I added the original hash { algo } prop in commit 99e3a2cd4e74
("rockchip: Add sha256 hash to FIT images").

The option to use crc32 as hash algo fallback was only ever to at least
give a better default option than not doing any type of checksum test.

Regards,
Jonas

> 
> @Simon, do you have some hints about this?
> 
> Cheers,
> Quentin

