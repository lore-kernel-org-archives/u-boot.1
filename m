Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A6AC44501
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 18:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FDAF8497A;
	Wed,  8 Jul 2026 20:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="xwPSzGBE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAFC6849D2; Wed,  8 Jul 2026 20:41:11 +0200 (CEST)
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D738496E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 20:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783536064; x=1783795264;
 bh=bizBQfgVj0qXKhvkESD2XMSU3WXVq+10kXsgBCSUUGY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=xwPSzGBEfnn1PZND2AwDpov0+OmE73x0uGPINp2JqW2HwRfpyXJHSNnVp3gVboAxr
 k0oNP+yEXp20MZrwezRZCgSgTwyR6Bqg0FF7GPeLfsYxiPIKhkV3vvhyC7cHM9byOu
 GqFKfl9RKMNFo4ysL0MRp2TDJ7WX4mInBNs5FysE7E+YxYImHQITHSEDAJ0uk6ysQf
 f8FRja8W/oziWF9qg3GN3+KYpOxzfyi2bPwdnkK2iHWmViAaT4x0R7LTen/IkXhTgU
 HJeRcLD9gN27MIwkWm6QzvV3i2I636hTGlU8a6C6d2qnWvyF8d0T6/NJ9XkEcLLwNY
 Q0RJQoFKgx/jw==
X-Pm-Submission-Id: 4gwRkP2vbRz2Sd51
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Simon Glass" <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>,  "Tom Rini" <trini@konsulko.com>,  "Casey
 Connolly" <casey.connolly@linaro.org>
Subject: Re: [PATCH 6/8] string: add strcasestr()
In-Reply-To: <CAFLszTi58-YBJU=Z-Ab00xSTaaFGkibyogd4dP_whYv70MqOpQ@mail.gmail.com>
 (Simon Glass's message of "Thu, 02 Jul 2026 09:30:15 +0100")
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
 <20260701171535.906272-7-rv@rasmusvillemoes.dk>
 <-L2J8wyvBfsoNZ_oj3Z9kf9VHJFXGSNTsIaWTbFhAyLP_MEWPFZBwC5BJtJLV-ucgg_88lw_CVudQN9BYQaJVQ==@protonmail.internalid>
 <CAFLszTi58-YBJU=Z-Ab00xSTaaFGkibyogd4dP_whYv70MqOpQ@mail.gmail.com>
Date: Wed, 08 Jul 2026 20:40:59 +0200
Message-ID: <878q7luxxg.fsf@rasmusvillemoes.dk>
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
>> string: add strcasestr()
>>
>> While this is not likely needed by any 'real' driver code, a later
>> convenience addition to the 'config' command will need this. As usual,
>> the linker will throw it away if nothing actually uses it, so it
>> should have no size impact when not used.
>>
>> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>>
>> include/linux/string.h |  1 +
>>  lib/string.c           | 27 +++++++++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>
>> diff --git a/include/linux/string.h b/include/linux/string.h
>> @@ -77,6 +77,7 @@ extern __kernel_size_t strlen(const char *);
>>  #ifndef __HAVE_ARCH_STRNLEN
>>  extern __kernel_size_t strnlen(const char *,__kernel_size_t);
>>  #endif
>> +char *strcasestr(const char *, const char *);
>
> I've been trying to add proper function docs to newly added ones, so
> we can clearly see the behaviour. Despite these being well-known
> function, they sometimes differ in how they handle edge-conditions.
>
> Also you could group this with the strstr()/strnstr() declarations a
> few lines above, so it sits alongside its siblings.

Sure, I can move the declaration up. As for function docs, they exist,
but in string.c, which is also where the docs for str[n]str is (an
earlier patch had fixups for those). I see some kernel docs in
string.h, and I dunno which is preferred, but most, including the
sibling str[n]str ones, are in the .c file. So I'll leave it there.

Rasmus
