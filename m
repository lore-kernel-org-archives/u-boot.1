Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31512C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF63F838B9;
	Wed,  9 Apr 2025 17:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="NC5Z+18A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF466838BF; Wed,  9 Apr 2025 17:38:39 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE90F838A7
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3b7d=W4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744213115;
 bh=b7nI/hEyFw98gzdtwmHi+YCT3TpKVc/Urx3Hy0ElVdA=;
 b=NC5Z+18AC6Tt8f7fkSgDPea1wwcsRLvkIvkDJJN1XjwV84CkK+RReWy+Ecvx0eyfA9M+Ap77c
 fbMDQ/XuFLrVzTjW8p5ezAuWONISOW3ym7cvAx8+RltK9xUYz1mIa4XQSNUEd6FdMZjnJkeTDyR
 IFovannKV8zoHvHnWxJChEkOWPXavdvcnsJvIApOxtywWdKL46LzvKXWg0hl7CgLhl9a7clWdvl
 DU5ndByGdTri0p/jjiFBHfjsewASwObSh8Zxbl0ZZvTjCHsAqAVX9PFC1bF+U23gQgX1TZMnINW
 ZNZGZv3NbvJtfx7PuqoP4EQM5FVSUEE/2dGbAbOEibBw==
X-Forward-Email-ID: 67f694721aecaf4e4108e5a9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ac68b883-021c-43ac-b834-bafa54e7182b@kwiboo.se>
Date: Wed, 9 Apr 2025 17:38:23 +0200
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
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <5d3c9e7f-336b-4b67-a7f4-a25a61b0908e@cherry.de>
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

On 2025-04-09 13:06, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>> Use of SHA256 checksum validation on ARMv7 SoCs can be very time
>> consuming compared to ARMv8 SoCs with Crypto Extensions.
>>
>> Add support for use of the crc32 hash algo when SHA256 is not supported.
>> Also use a HAS_HASH to simplify the ifdefs when no known hash algo is
>> compiled.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> I don't know enough about general security but this very much looks like 
> a bad idea to me.
> 
> https://web.archive.org/web/20170210173741/http://www.derkeiler.com/Newsgroups/sci.crypt/2003-07/1451.html
> 
> """
> While properly designed CRC's are good at detecting random errors in
> the data (due to e.g. line noise), the CRC is useless as a secure
> indicator of intentional manipulation of the data. And this is
> because it's not hard at all to modify the data to produce any CRC
> you desire (e.g. the same CRC as the original data, to try to
> disguise your data manipulation).
> """
> 
> (yes I took the "first" link my web search engine returned me, thanks 
> confirmation bias!).

I am fully aware, and the fallback to use crc32, and current primarily
use of sha256, should not be considered a security feature. It is
intended purely for a checksum validation of the binary blob after it
has been loaded into memory and before U-Boot otherwise unconditionally
jumps to and execute the loaded blob of binary code.

> 
> I don't want to give people a false sense of security. If it really 
> comes down to it, I'd rather have an explicit Kconfig symbol to set this 
> value (maybe have a `choice` even) and be very clear about security 
> implications.

Prior to the addition of the hash { algo=sha256 }, there was no checksum
test and U-Boot SPL would unconditionally jump to the loaded data, even
if it had been corrupted, was only halfway written or otherwise
overwritten.

The addition of crc32 instead of sha256 is just to allow older board
variants with weaker SoCs to at least have some sort of checksum
validation in use without affecting the boot time too much.

On my rk3228 board, validation using sha256 could take a few seconds,
and with crc32 it could be measured in ms.

To me, having at least some default checksum validation is preferred
over none at all.

Regards,
Jonas

> 
> Cheers,
> Quentin

