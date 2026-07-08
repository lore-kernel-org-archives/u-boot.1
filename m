Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5854C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 18:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A6738496E;
	Wed,  8 Jul 2026 20:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UNoLhQ6z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A8AD8497A; Wed,  8 Jul 2026 20:59:54 +0200 (CEST)
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch
 [109.224.244.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 015018407E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 20:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783537191; x=1783796391;
 bh=No0zBflBBRXe4SQq9jhNhrR0bFW+vGLIq206h12+PFE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=UNoLhQ6z0Ft4QICaa6KUAOeHetz6LOsAgfACNO9S/snTcnx0HRLm7uSUTEiyqH8a+
 kJ755zOJzeCpJZa189hXVwDsSSfx5BfU9XDJFZXlMqpcQ6TMY3299RAuXo9ROKkR/x
 Z9nY350IfVHkH+8/3M7+28d87FrQ2mPQ4JJD1d0JX5LkFWBePaqy1YB4Jl7FhzG7oj
 rPbfOgf+sR7Z3IiFFbW3JJMv2EpirXC3BF2hrWc9O9KChUeiPPqwUqT+/Rpa0uq2Uh
 DdRVSAEtn3oD7r0/RKAEMjCRkkERD5gnCweHFAYvTeQRtg03QJAeJw9/lOIvMXHY8+
 HAxsY7Ms8X5Kw==
X-Pm-Submission-Id: 4gwS855BF0z2Scsk
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Simon Glass" <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>,  "Tom Rini" <trini@konsulko.com>,  "Casey
 Connolly" <casey.connolly@linaro.org>
Subject: Re: [PATCH 8/8] cmd: config: allow simple filtering of output
In-Reply-To: <CAFLszTgNgDUY-sKspO9O5JaSg7ERv7g-qO-UV8apunFs4w6ZWA@mail.gmail.com>
 (Simon Glass's message of "Thu, 02 Jul 2026 09:30:24 +0100")
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
 <20260701171535.906272-9-rv@rasmusvillemoes.dk>
 <mDleQcmnzVaEqwpyh0836NLo6HZabQwOFGxUtd7JIm67SxPNzQIE3-UQzl01D2cxbu6hE8WppO_QBg3PLkEzWQ==@protonmail.internalid>
 <CAFLszTgNgDUY-sKspO9O5JaSg7ERv7g-qO-UV8apunFs4w6ZWA@mail.gmail.com>
Date: Wed, 08 Jul 2026 20:59:48 +0200
Message-ID: <8733xtux23.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Jul 02 2026, "Simon Glass" <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On 2026-07-01T17:15:27, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
>> cmd: config: allow simple filtering of output
>>
>> When doing development, it can be quite useful to enable
>> CONFIG_CMD_CONFIG, so that one can always check whether a config knob
>> one has just enabled has actually made it to target.
>>
>> Because sometimes, one doesn't flash the right binary, or maybe one
>> has just done CONFIG_FOO=y in some config fragment, but that had no
>> effect because one would also have to do CONFIG_BAR=y.
>>
>> However, 2400+ lines of text are rather hard to read through. One
>> probably uses a terminal emulator with capturing enabled, but
>> searching back through the capture file is a little tedious, and one
>> easily ends up finding something that doesn't pertain to the most
>> recent 'config' command invocation.
>>
>> So make it possible to limit the output to those lines containing a
>> given string. Like the search functionality in menuconfig, make it
>> case insensitive, because it is much more convenient to type "config
>> pinctrl" than "config PINCTRL".
>> [...]
>>
>> cmd/config.c | 25 ++++++++++++++++++++++---
>>  1 file changed, 22 insertions(+), 3 deletions(-)
>
>> diff --git a/cmd/config.c b/cmd/config.c
>> @@ -29,7 +29,23 @@ static int do_config(struct cmd_tbl *cmdtp, int flag, int argc,
>> +             while (b < e) {
>> +                     n = strchrnul(b, '\n');
>> +                     *n = '\0';
>> +
>> +                     if (strcasestr(b, s)) {
>> +                             puts(b);
>> +                             puts('\n');
>> +                     }
>> +                     b = n + 1;
>> +             }
>
> The two puts() could be a single printf("%s\n", b). 

Well, originally I just had the first puts(), then I found out that our
puts() is not standards-compliant (which would automatically add that
newline). I think I prefer keeping these as-is, to avoid a pathological
case of some .config line exceeding CONFIG_SYS_PBSIZE and then be
truncated (that could happen with some of the config options that are
potentially long lists of strings, OF_LIST, DEVICE_TREE_INCLUDES, the like).

> Also please add an explicit #include <linux/string.h> now that we rely
> on strchrnul() and strcasestr() here.

Ack.

> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> In addition to Tom's comment, how about a simple sandbox test?

Ack.

Rasmus
