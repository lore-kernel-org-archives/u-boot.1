Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A521C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 07:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 011A08073D;
	Sat, 18 Jan 2025 08:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HWyj11oz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I0bXAzuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B317080755; Sat, 18 Jan 2025 08:08:13 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93A9F8070C
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZnkL4Fffz9shn;
 Sat, 18 Jan 2025 08:08:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737184090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=atim8joYjJbUzlqz9VdYacpet7AgmvW+HymxvCnoPiE=;
 b=HWyj11ozeCTHH/T58y0/tI0asYizdXeORW7dHZYndh9kUnDkzEcjWwel7hxYZ+sO0nkkid
 trxDiMCaiu5DdSmJR3XP+Mz23pIIP+3EI/sgKRG2IePuQ1tg6l9wV1Hm0xDAEQEgEYVBaW
 wvco0hZrLyhoeM0RWSQ1ClyVlT8bDdewmGSEx2MCuE01U5kyjch4zZLXLv2joTN3/6pLMc
 NDlKb+q9b5bJ8RbwLCmKPMh5R9d7pPGsJrR3sjdS2KNheh4W4FsNK1J9r657gDtJdnRSBJ
 h0G66TlOE095I+YbLY8hT6Ni3tN7XS8J8BLci5ucr5Eul63AEtPu4xTguJdACw==
Message-ID: <f498abff-d8e1-4da8-a612-f2c6c5ad5681@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737184088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=atim8joYjJbUzlqz9VdYacpet7AgmvW+HymxvCnoPiE=;
 b=I0bXAzuPngJ5oie62ZXaeoaTkl5ZvzHPdYBNpwDeoK5j6SfJXHOnNak7OU2D3QwlWiqjjS
 jB2Ncqvr45c7jrduO9rrEpyPvGkR/MAGoFsvDOVFa64rFklbPMsld8a/FDz2NCs8aZ8yCb
 Vm0xsmPlvqGFV5K4f32rCdKscTtNYRuBmFvTx8Oa8V6lBp4aqphU/epJ1suYraF8xPWAot
 zAhiTtcS1Kc3btbyoh14cMO6yfrp3r2Flq0JkV3Es7afnyvCgGSg+5xUplN73IA1I6Rmi5
 wSwlRaBo609LqDIo8kPsHwZ4madkF6Kgkv79fJxEm0msMGo1m+zFAYzsSurngQ==
Date: Sat, 18 Jan 2025 08:08:05 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] Makefile: Make sure all linker input objects exist
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223252.179123-1-marek.vasut+renesas@mailbox.org>
 <c2dc2745-5288-4182-a25a-561b96126cce@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c2dc2745-5288-4182-a25a-561b96126cce@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 49c6d1c9f9b846d151d
X-MBO-RS-META: fobt4no78zp9dnwmqb7stxg9n597qqda
X-Rspamd-Queue-Id: 4YZnkL4Fffz9shn
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

On 1/15/25 11:38 AM, Quentin Schulz wrote:
> Hi Marek,

Hi,

> On 1/12/25 11:32 PM, Marek Vasut wrote:
>> In case the build system builds a directory with empty Makefile,
>> one which does not contain any obj-y entries, the build fails to
>> link due to missing built-in.o .
>>
>> This happens because of this part of scripts/Makefile.build
>>   81 ifneq ($(strip $(obj-y) $(obj-m) $(obj-) $(subdir-m) $(lib- 
>> target)),)
>>   82 builtin-target := $(obj)/built-in.o
>>   83 endif
>> which does not assign builtin-target in case obj-y is empty. The
>> built-in target is then not built at all, and built-in.o is not
>> generated by this part of scripts/Makefile.build
>>   325 ifdef builtin-target
>>   326 quiet_cmd_link_o_target = AR      $@
>>   327 # If the list of objects to link is empty, just create an empty 
>> built-in.o
>>   ...
>>   335 targets += $(builtin-target)
>>   336 endif # builtin-target
>> This is the correct behavior.
>>
>> The final link however expects the built-in.o to exist in every directory
>> included in the build, even in those where the aforementioned code 
>> skipped
>> generation of built-in.o . Make sure the built-in.o does exist for every
>> directory used in final link simply by doing touch on every built-in.o 
>> used
>> for the link, which will create empty built-in.o in case any built- 
>> in.o is
>> missing.
>>
>> A possible alternative fix is the always define the builtin-target
>> and always generate built-in.o .
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> I tested this with the following diff:

[..]

> which allows me to use HAVE_VENDOR_COMMON_LIB mechanism with an empty 
> Makefile for TPL/SPL build stage, so:
> 
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Thank you

> Looking forward to being able to use HAVE_VENDOR_COMMON_LIB!
> 
> Though I could actually always include the file and just ifdef 
> CONFIG_XPL_BUILD in common.o, but let's see where this patch goes first :)
If the intent is to use an empty Makefile (with or without ifdeferry) in 
any directory pulled into the build, to mitigate the missing built-in.o 
problem, that also won't work without this patch, because empty Makefile 
itself won't lead to generation of the built-in.o .
