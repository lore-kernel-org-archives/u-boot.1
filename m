Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FB1CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 05:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4159C833AD;
	Mon,  1 Sep 2025 07:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="GSxwD96y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F55833E9; Mon,  1 Sep 2025 07:11:57 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 046B1831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 07:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A3AA3105B5C; Mon,  1 Sep 2025 07:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1756703514;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=horQr0wbksBK44wa2YB+8qzb8PBXvvrqj7k113McF1M=;
 b=GSxwD96yzAjAColrGQSvSR6CmdOOgsLNR9NPK11lgIgBJO9xDilcQyfxdT7Vu5cuCuysog
 i3VQESGLWNPKewjdoNZK9B2XdRHRKtOqNHyUts7hbi2sCc24GRRHPkXFpztpl6yo4XUtVq
 tGPqUZ4CmLuo7InwIpVp2ehsdBqFXrCCV2I/lJUzw+zKORpqZVfd/rD3i3WYrhRUJWhb4Z
 08K8fAu8d6aBXL8WzMA4pMlnlIFAT8JRvn8IUDPrjkJuRuGB0rEbUj39WNGwzmfT+bWNMx
 bcWtA3ABGUPOBqCd3b6sQj8rAs0BtJYrJBDq3PrIcBXq6AN1HisGjvrcirZfwA==
Message-ID: <4c31c2d1-f8dc-e04c-003b-5e0f78290628@nabladev.com>
Date: Mon, 1 Sep 2025 07:12:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] cmd: Remove default prompt from output
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Daniel Schultz <d.schultz@phytec.de>
Cc: holger.brunck@hitachienergy.com, sjg@chromium.org,
 jh80.chung@samsung.com, u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20250815160635.3575367-1-d.schultz@phytec.de>
 <20250815161237.GT124814@bill-the-cat>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20250815161237.GT124814@bill-the-cat>
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

Hi Daniel,

On 15.08.25 18:12, Tom Rini wrote:
> On Fri, Aug 15, 2025 at 09:06:35AM -0700, Daniel Schultz wrote:
> 
>> Some commands include the U-Boot prompt (=>) in their output,
>> which can interfere with tools like labgrid that rely on prompt
>> detection to determine when a command has completed. This may cause
>> such tools to misinterpret partial output.
>>
>> To avoid this issue, it's better to update the command output itself
>> rather than modifying the actual U-Boot prompt. Changing the prompt
>> is not acceptable in many cases, as some boards have used the default
>> prompt (=>) for years, and altering it - especially just for testing -
>> could lead to inconsistencies or unintended side effects.
>> Instead, replace instances of the prompt that appear within command
>> output (not the real prompt) with an alternative like -> to ensure
>> correct parsing by tools that rely on prompt recognition.
>>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
>>   cmd/i2c.c      |  2 +-
>>   cmd/mtdparts.c | 12 ++++++------
>>   common/hash.c  |  6 +++---
>>   3 files changed, 10 insertions(+), 10 deletions(-)
> 
> This is two cases, and I'm not sure I like the proposal here, sorry. For
> cmd/mtdparts.c, it's debug statements. We can change them, but are they
> also enabled by default in anything? The other cases, we're changing
> output along the lines of:
> 
>> -	printf ("CRC32 for %08lx ... %08lx ==> ", addr, addr + count - 1);
>> +	printf("CRC32 for %08lx ... %08lx --> ", addr, addr + count - 1);
> 
> In each case, and I'm surprised there's not testing that globs on that
> today. I see the wget case that uses "==>" and we do have a test that
> checks it, today. Is your testing framework not able to handle "=>" in
> the middle of a line? Thanks.

That would be exactly also my question ... fix the tool instead?

Changing this output may breaks automated tests with other tools...

for example tbot handles this case:

https://tbot.tools/modules/machine_channel.html#tbot.machine.channel.Channel.read_until_prompt

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
