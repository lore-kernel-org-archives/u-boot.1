Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F40C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EDD384B85;
	Mon, 13 Jul 2026 16:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iJaP5LjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F8984B86; Mon, 13 Jul 2026 16:53:50 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 682B084B51
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5a7b=FI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783954427;
 bh=2s9GugmU33NVmyAcWVlmBjHNWd6263hB41hlrWLKkYc=;
 b=iJaP5LjQcl/GKLrHaHOLPsdjpBfJxPBsChG26H0yas4GtyeYPsqg4gDDJbrKdYVQ7GhnqLV5L
 hmfQLuSm5K4WTiq/ri1g9OxYEruAxot1F2jL1Q5jv3IKEKQAUlefvKHmyLJjBH5JMd/p52L+tXP
 9zYOJI7nqt9kd0b3znWAafnTuUe15ui39TiiQE874LZFq6Lg7QE7915NNN4tqIG763m4Q5b7eZi
 lx48WanTgZGCQM77DaVfUSdOwH00tJR/bWIhuea0kgcwPvbL7cCn9VhU6OHaaOzXZJzZfhNS3WL
 6TU1yz6JI3+4s625s2ORadCV0OuW+P4hgv6NE4JmLLUQ==
X-Forward-Email-ID: 6a54fbf971ce19034bfe8c10
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ab6b6671-fff2-429d-82c4-6d1a9f74fc2e@kwiboo.se>
Date: Mon, 13 Jul 2026 16:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] Kconfig: Add missing depends on xPL to xPL_ symbols
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-7-jonas@kwiboo.se>
 <CAFLszTjxty82LThDuqmAyN7XasOPVT+KBSYdZ_KGd8GC0537Tw@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTjxty82LThDuqmAyN7XasOPVT+KBSYdZ_KGd8GC0537Tw@mail.gmail.com>
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

On 7/13/2026 4:24 PM, Simon Glass wrote:
> Hi Jonas,
> 
> On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
>> Kconfig: Add missing depends on xPL to xPL_ symbols
>>
>> xPL_<name> symbols should typically depend on the associated xPL symbol.
>>
>> Add missing depends on xPL to xPL_<name> symbols to avoid the xPL_<name>
>> symbols being available when the associated xPL symbol is disabled.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
>> common/Kconfig | 2 ++
>>  lib/Kconfig    | 7 ++++++-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> @@ -972,23 +973,27 @@ config SPL_LZO
>>  config TPL_GZIP
>> -     bool "Enable gzip decompression support for SPL build"
>> +     bool "Enable gzip decompression support for TPL build"
>> +     depends on TPL
> 
> The prompt fix is separate from adding the dependencies, so please can
> you mention it in the commit message? Otherwise it looks like a stray
> hunk.

Sure, will update commit message in v2.

> 
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> @@ -960,6 +960,7 @@ config TPL_LZMA
>>  config VPL_LZMA
>>       bool "Enable LZMA decompression support for VPL build"
>> +     depends on VPL
> 
> BTW SPL_LZMA_SIZE_OPTIMIZATION (between SPL_LZMA and TPL_LZMA) has no
> dependency at all, so it shows up in menuconfig even without SPL. It
> fits the pattern this patch fixes and could get 'depends on SPL_LZMA'
> while you are here. What do you think?

Thanks, I have already added following for v2 of this patch:

- SPL_SYS_L2_PL310
- SPL_SYS_STDIO_DEREGISTER
- SPL_NVMEM

And a new patch that adds depends on [xPL_]LZMA to
[xPL_]LZMA_SIZE_OPTIMIZATION symbols, I felt it was different enough to
put such change in a dedicated patch.

Will send the v2 once the I2C_LEGACY size change is resolved/accepted.

Regards,
Jonas

> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Regards,
> Simon
