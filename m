Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D608F513E1
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 21:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1BA683F75;
	Thu,  5 Mar 2026 22:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="Ak6Weejk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 618D583F8F; Thu,  5 Mar 2026 22:57:02 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C95B7839A8
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 22:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1772747816;
 bh=cWxYPB3nilIYkJX4euuQvQJqwt9F97CV1qZuqIaxOZ8=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=Ak6WeejkSO9MkwJ88miKlW9BVK2SLUYLEXs4kMJGknZ5jJPCUtcudH7Kh6FDGSQYk
 KvcmkoAaHyKgN0Ntk0sX54pc0U9DqDcBEicI/FBSHRNq5KCnWOJ0gxDWzguL+W6e1h
 cL0hPGCFnSsXpjKmLRRofIWeXoCaKqLqEbb4GZElOMgvsb+XjMpHybiZ8KjLIRljLz
 scJUcoYrOcFT6yD6cOpn/7asfXvPzOk8AXdXhtwHVldxfYLz4ox8oXCV5ddu771bBS
 ZeUP5lfpcKECAjOTXoZ/ib0dahnfiBSZSgXou/VDMfFFzUyQja9tlwJlxeC8DWFVsh
 iSYDIBlrByPMg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id E122EB220345;
 Thu,  5 Mar 2026 22:56:55 +0100 (CET)
Message-ID: <4cebe05b-ee50-4188-816e-2f8d525ea8b6@freeshell.de>
Date: Thu, 5 Mar 2026 13:56:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: starfive: jh7110 common give build output dir
 by env not arg
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260305205649.61100-1-e@freeshell.de>
 <24982c23-3ee6-4e33-8608-5af6dd612297@freeshell.de>
Content-Language: en-US
In-Reply-To: <24982c23-3ee6-4e33-8608-5af6dd612297@freeshell.de>
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


On 3/5/26 13:05, E Shattow wrote:
> 
> 
> On 3/5/26 12:56, E Shattow wrote:
>> Describe build with output directory as O=<dir> environment variable
>> and not unrelated -O <output sync> command line argument.
>>
>> Fixes: 8304f3226700 ("doc: board: starfive: update jh7110 common description")
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>  doc/board/starfive/jh7110_common.rst | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
>> index 77102fcc189..b0b60da0dc3 100644
>> --- a/doc/board/starfive/jh7110_common.rst
>> +++ b/doc/board/starfive/jh7110_common.rst
>> @@ -162,8 +162,8 @@ Build U-Boot
>>         git -C opensbi.git checkout v1.7
>>         # always clean build directory when building OpenSBI due to incomplete
>>         # dependency tracking
>> -       make -C opensbi.git -O opensbi clean
>> -       make -C opensbi.git -O opensbi PLATFORM=generic
>> +       make -C opensbi.git O=opensbi clean
>> +       make -C opensbi.git O=opensbi PLATFORM=generic
>>  
>>  4.  Now build the First Stage BootLoader (U-Boot Secondary Program Loader) and
>>      Second Boot Loader (OpenSBI + U-Boot Main):
>> @@ -171,9 +171,9 @@ Build U-Boot
>>      .. code-block:: console
>>  
>>         git clone https://source.denx.de/u-boot/u-boot.git u-boot.git
>> -       make -C u-boot.git -O u-boot starfive_visionfive2_defconfig
>> +       make -C u-boot.git O=u-boot starfive_visionfive2_defconfig
> 
>>         export OPENSBI=opensbi/build/platform/generic/firmware/fw_dynamic.bin
> 
> Oh and what is this OPENSBI directory ? That's not correct, either.
> 

Replying myself, follow-up patch for the OPENSBI path typo is submitted
at: https://lore.kernel.org/u-boot/20260305214922.97337-1-e@freeshell.de

>> -       make -C u-boot.git -O u-boot
>> +       make -C u-boot.git O=u-boot
>>  
>>      This will generate the U-Boot SPL image object post-processed with StarFive
>>      SPL headers (u-boot/spl/u-boot-spl.bin.normal.out) as well as the FIT image
>> @@ -191,7 +191,7 @@ Build U-Boot
>>           --set-val SPL_DEBUG_UART_BASE 0x10000000 \
>>           --set-val DEBUG_UART_SHIFT 2
>>  
>> -        make -C u-boot.git -O u-boot olddefconfig
>> +        make -C u-boot.git O=u-boot olddefconfig
>>  
>>  Boot description
>>  ----------------
>>
>> base-commit: b26cc03b7cecaabdb306c2f68eebde764161a545
> 
> -E

-E
