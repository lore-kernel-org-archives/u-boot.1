Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B74FA1FE7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 19:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28010843C0;
	Wed, 22 Apr 2026 21:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="a7m2qiOt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SvIVEA6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C1C84227; Wed, 22 Apr 2026 21:09:16 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B9C843C5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 21:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g180T4ZCcz9tjZ;
 Wed, 22 Apr 2026 21:09:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776884953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+KAt6FOYo01O5NApeV9cWhMO62ERQzkCDh0bpI+AxQ=;
 b=a7m2qiOt43L3RXswd7BJTD22oPNhiMyLD0QcTGlS2f778Cm3kfUrQjU1bbSA89NQ0mVGTQ
 fcTKZJSF2Z5WmoELFYZ2Kw6Wfjw4EF/G3c2t9ycrf2n9EW3I9eJDl5RG/F9LKdSqSqrFjK
 bMj7ImEzpXASKoMrayXw9ZcyemZXqdGIAgXQOe3ntgulQZ9q/jtl1/IkfOpFJ7S1pxZWE6
 NSldAfffA+zbKdOsD/pnWfBYdP5AaNXHuhcR2vzqnR9w7NUxSlbNnjx9jbHR6PQ7qhIiQa
 zGpQ6ppwVHb9bgM/e/NGyWNrP7MwiwLJVgGaj65/EyOXTIaVADtVUhG4H1aE1A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=SvIVEA6c;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <29c41700-62ae-47b0-86c8-e5ce1356d04f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776884952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+KAt6FOYo01O5NApeV9cWhMO62ERQzkCDh0bpI+AxQ=;
 b=SvIVEA6coXRhZ5UrfO4fvfg7RssgnZAfwgJvlufHzN7JV1xAb8LNINUfScCS/DC0rM1DmV
 XLPbTABKgwyKlyQHME+5OlFwvOQzyZQf5CpvlPYWrgyorpwpLonURCU59e9CLi+G39e1Ax
 1+H2Z3md6Pe9+n1AHpjYfY4RRnxEsq+vZQi2+ti80DXafbRCudxs6z6IQWfJUeMPRYilYF
 aUllVYsemIa55kZ6EVGED0v13Aqo6HYSD9c/IOes8R7tsayErpHiMDbCnKmdqgeppb3YFf
 mOuiOqxhpCh6Ht7dLr1J5KCN0ZY8snUcdg48rXgRrSIjAk9LdJEI1oozqF5rCA==
Date: Wed, 22 Apr 2026 21:09:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
To: Simon Glass <sjg@chromium.org>
Cc: marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260420012348.400492-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg+nfKGCaHGz6-GHoQ+KntLYYdUTZqfYGpBdsvLSW9FZQ@mail.gmail.com>
 <0c112980-e5db-4acc-97df-c1097c41112b@mailbox.org>
 <CAFLszTgV6L=G2-MpBgYh3h=4QM0r0V-aLueS3zUgTCTx3YmcpA@mail.gmail.com>
 <1f18aeee-ca36-4ec3-af50-d3ebe49c2a4f@mailbox.org>
 <CAFLszTi4w7d1rVSViaShX7yT=QWHx363Y4Ac3MSrqJ6N+6Ai2Q@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTi4w7d1rVSViaShX7yT=QWHx363Y4Ac3MSrqJ6N+6Ai2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b2e69b56757bcb27f89
X-MBO-RS-META: oh5mtrkma3xebu9fhzimpamceef7dbra
X-Rspamd-Queue-Id: 4g180T4ZCcz9tjZ
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

On 4/22/26 4:25 AM, Simon Glass wrote:
> Hi Marek,
> 
> On Wed, 22 Apr 2026 at 13:46, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 4/22/26 3:15 AM, Simon Glass wrote:
>>> Hi Marek,
>>>
>>> On Tue, 21 Apr 2026 at 12:48, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>>
>>>> On 4/20/26 6:14 AM, Simon Glass wrote:
>>>>> On 2026-04-20T01:23:26, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
>>>>>> kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
>>>>>>
>>>>>> The fdtgrep command will reduce the DT to minimum size, thus eliminating
>>>>>> the extra padding configured via CONFIG_SYS_DTC_PAD_BYTES. Reinstate the
>>>>>> extra padding by running the output DTB from fdtgrep through DTC with the
>>>>>> -p CONFIG_SYS_DTC_PAD_BYTES flag again in case CONFIG_SYS_DTC_PAD_BYTES
>>>>>> is not zero.
>>>>>>
>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>>
>>>>>> scripts/Makefile.lib | 7 +++++++
>>>>>>     1 file changed, 7 insertions(+)
>>>>>
>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>
>>>> Is this something which can be added into fdtgrep itself btw ?
>>>
>>> Yes I'm sure that would be possible: perhaps a flag to maintain the
>>> same padding as it finds in the input file.
>> We can not determine the padding from the input DTB file itself, so the
>> option would have to take a padding parameter. But I wonder if it makes
>> sense to grow fdtgrep this way, or whether using dtc to reinstate the
>> padding is better.
> 
> I think fdtgrep is cleaner. I'll send a patch.
OK, thank you.
