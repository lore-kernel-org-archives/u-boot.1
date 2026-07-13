Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111C5C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 07:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5758484A49;
	Mon, 13 Jul 2026 09:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DH6DsBnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0063684A4B; Mon, 13 Jul 2026 09:59:35 +0200 (CEST)
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch
 [185.70.43.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F03E84A48
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 09:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783929570; x=1784188770;
 bh=MTS4kXBPO3DLCwbw1b6BMG8WKvC9aW4XFg5T/9RSrkQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=DH6DsBnpfOrawKyPh6LNBPhj08WAOlpezQ1BpsSjWKs6/WC7HO0xVR+tTeemwDsoQ
 JiWCnqB+DDZwxR4GFprfKPH6McEa00vfUvo62Y03RG6uJwFKc9Lk6JEYg1xdf1yWX5
 LH4oTpNfmgu1W+2jEb/ynlHDI1QVgVjx/VIx22IyqcWYjeZIU9EhrFFll2QSORl+jB
 c5YE0zJtyENJdjL8fMAn2sKoc7bZf6r8L9O3l0tjzqAeHbzwc30AmxcU6i0C2hbS/f
 xKrx21ebsMHCSr0h7c9Mzz2tVZwhZ/BGMdQLnnPYebM+WitnRHD1QoxdJgI7koMlPy
 ITPTBgtGxuucw==
X-Pm-Submission-Id: 4gzFFr6tdZz1DDpB
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Simon Glass" <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>,  "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH v2 10/10] test: add test of 'config' command
In-Reply-To: <CAFLszTi=ytF1MTd4Egvo3LZDgrP5KZ5=K4Uz5jUVFcRkOagAgQ@mail.gmail.com>
 (Simon Glass's message of "Sun, 12 Jul 2026 18:18:32 -0600")
References: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
 <20260708203711.849489-11-rv@rasmusvillemoes.dk>
 <FA-v9BFSUTj-TRyvSvaYa8kaUuphTp9fZRIO_BnXaIe0fdFBItff9747oLX6ihRtP0d73XCcmuSDxqsGffREpw==@protonmail.internalid>
 <CAFLszTi=ytF1MTd4Egvo3LZDgrP5KZ5=K4Uz5jUVFcRkOagAgQ@mail.gmail.com>
Date: Mon, 13 Jul 2026 09:59:28 +0200
Message-ID: <8733xntj4v.fsf@rasmusvillemoes.dk>
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

On Sun, Jul 12 2026, "Simon Glass" <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On 2026-07-08T20:37:01, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
>> test: add test of 'config' command
>>
>> Add some test cases for the 'config' command, including the ability to
>> filter the output.
>>
>> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>>
>> test/cmd/Makefile |  1 +
>>  test/cmd/config.c | 28 ++++++++++++++++++++++++++++
>>  2 files changed, 29 insertions(+)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
>> diff --git a/test/cmd/config.c b/test/cmd/config.c
>> @@ -0,0 +1,28 @@
>> +     ut_assertok(run_command('config', 0));
>> +     ut_assert_skip_to_line("# Automatically generated file; DO NOT EDIT.");
>> +     ut_assert_skip_to_linen("# Compiler:");
>> +     ut_assert_skip_to_line('CONFIG_CMD_CONFIG=y');
>> +
>> +     console_record_reset_enable();
>
> Just to check, is there a reason the first block doesn't finish with
> ut_assert_console_end() before the reset? The other invocations round
> out with it, and it would be nice to verify we consumed to a known
> point rather than discarding whatever was left.

Yes. When printing the whole .config, I know that there'll be the
commented out lines I check for at the top, and obviously also the
CMD_CONFIG option itself must be enabled. But I don't know anything else
about what might be in the .config, and in particular, there's no way to
know what the last line will look like (the .config file does not have a
"# end of .config" footer or similar). So I can neither skip to or
assert existence of other lines after the CONFIG_CMD_CONFIG=y check. I
don't think there's anything else to do.

When invoked with a filter, I do know exactly what line(s) to expect, in
in those cases it is also more important to assert that there are no
unexpected lines.

Rasmus
