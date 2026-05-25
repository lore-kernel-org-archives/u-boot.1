Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED83ECD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB7084862;
	Mon, 25 May 2026 17:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ngn8el+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB2A384869; Mon, 25 May 2026 17:02:18 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F3F84841
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-67f94c078e8so14725652a12.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779721336; cv=none;
 d=google.com; s=arc-20240605;
 b=ICdk7862HXWWIvl12eGviPJZnENjnTQrjbCMY8euNWIqcBmXMv85StzaMskELN0tWV
 mzxcVRL2s3OHPqpBP0brO8kN6lVjIfQMAvUwbOk+s09BFPBj3RHmTGDqIBpjR0c8DxKx
 mIKz5A5EyVtDLoD6L6LGE3MK8wtFCfODeT47X0P43U0nhXU7j+1dX1UWh0DSMa6zEvl7
 o4Purrd1K9sh2EGGP3O/o7KBLO+m590HQwuRpz3rESEywnKkXIapIQn/KqxZ18PKCiI5
 wJJq/d3xGFA/a3sWmBUjcLDlICJvUIj4JoqpMGXhEqwx266tEowVFzKKKFWYhK0jNH7n
 G94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QrKlCksBTce8Kj5Eti2vA7sRQQywo4liRkaD2cmh5XM=;
 fh=uEwfVtgWmQ+BpqL3MMm4A4agCJ5OLHBunogpqm9TwOU=;
 b=NugXPuddOe9qfInya0hFOytMkjlogBYH1KFvH8HGHb8qQeT54l+XC16/P9uqqBs7wL
 Rr7DaqIaXk6FneX5zjxW95Zh4I0j+HTe92mT9inT/WowNex8QV8FVxMqQLU06kGDI1Oz
 TXwpQ9zab4dsllTxEprRKH62ju7UzXO8piHw23dAVIDl8cDgTXYTlFqQNBydSSu88Ett
 /VwOHxAV7yIWjDMRXlpggthNIPmwAwVimo+jA4XlbcImEvPLvm7JSlKw+rdr76M0topn
 yY1XtC7IAgZ17mzB5ePHjndlbji3O+G45ymVd3DlLCfx3TZblq/LK9AA0TS59D//s4KE
 Oynw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779721336; x=1780326136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QrKlCksBTce8Kj5Eti2vA7sRQQywo4liRkaD2cmh5XM=;
 b=ngn8el+QMMn1IWqG5XJN5b3bJypJyZa9BfjmbO9F0ueKwl93lDe7wN9nfJl2a6kjQ7
 rHZF/tFViyHNZADQAhs/Evawaslk0Hy1JrVrzR2YHR/x6ohSzM8W/SN+5i9z4i5gcyIE
 f7I9mSbxBDLBuRQZOUTduXXl4qS4nSIGF+UIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721336; x=1780326136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrKlCksBTce8Kj5Eti2vA7sRQQywo4liRkaD2cmh5XM=;
 b=bnDktG8K9eAxWkWut30QyMyy6SFUiB1vkhiTDEmPQwIvFaTeHB0FuxWHRw0AaS3OGN
 qaqk59X5jdwZI3+D4v9gtPRxVlM6GUQ0+7dXhFrO8S9o0o2LI481RgmPBk/6za5YV5J8
 5uychtDHNIfHCTZLifI7svWUoLkyjnMFR09UOm4egSao6nxpmb0qyfQZ9gPRECXLfhD4
 im4NQXix81kKAzeAucCYFkM/rWvI2wHSp9nxvWJZbz7avVnMrPSuiqq8mRbn2jUB9Hy+
 Y7KcRnjXE7lDLtUbRCiXi2RCs6DCIxYiEOEHaK9yQxWlp2vXXeoeZQw8vJ+j+I7PyGho
 mzYg==
X-Gm-Message-State: AOJu0YzhhfTUiOs1S2/6XhZshnzmRqFjIRZnCSLe6yjVyT2x/GVAJkAO
 MKInbMCjio7PCWL0X4dLsEdWSAJiYbcbVDCPfO/O+rcgW1B608tOcq6b6m8sEGixWq9iDckLHHS
 +FSK8VwxIrdjfU3SuiQksqXsQMPadBJaAbWbqoVMQ
X-Gm-Gg: Acq92OHJUayZ9YKgzWen2iIDR9eoHsY0BnuK8UvaFWHVQYkHh02WzP5dYxZ0zYZvf2z
 V5XLG/ibVB2i+glvYhN28idYvaNfGprZ89TO+te8/ogqxsQtIX2UOt0VX2MmfBFb9wJ6OZkVsOf
 cUSUFzLOoWphQB52loVXEd029Mz6ShKesQtkHFxJ31cjmwZAcqD/XRSVg5omZsuFtg8eLa/ojoV
 TTWnERaH43njVwqIWD0ha5RgbRn8MAxFlA03doVrAlKnhIj9PqeAb2ct2N2JwuXEJjVX1TdcWe+
 dHnc8Q==
X-Received: by 2002:a17:907:3a98:b0:bdf:bccd:a7e9 with SMTP id
 a640c23a62f3a-bdfbccddb82mr277800966b.2.1779721335699; Mon, 25 May 2026
 08:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-3-ravi@prevas.dk>
In-Reply-To: <20260522212756.3169222-3-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:02:02 -0600
X-Gm-Features: AVHnY4JUOAikv_I0xmFfiM-h1iWv__CkO44DrMX5J5Apo1S6HPFyxHxuc7tXBk4
Message-ID: <CAFLszTgmEKG7+8RJnXbdfy67pJ3U8u15-NcmT2Y1K2L5uSt+8g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] linker_lists: Do not set "unused" attribute
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> linker_lists: Do not set 'unused' attribute
>
> Whenever we declare something to be in a linker list, we want it to be
> included. This is why all of our linker scripts have a line similar to:
>         KEEP(*(SORT(__u_boot_list*)));
> to ensure that any linker list found in any of the archives we are
> linking together makes it to the final object. Remove the places where
> we set an attribute saying that it is unused, or maybe_unused.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> include/linker_lists.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

> diff --git a/include/linker_lists.h b/include/linker_lists.h
> @@ -69,7 +69,6 @@
>  */
>  #define ll_entry_declare(_type, _name, _list)                                \
>       _type _u_boot_list_2_##_list##_2_##_name __aligned(4)           \
> -                     __attribute__((unused))                         \
>                       __section('__u_boot_list_2_'#_list'_2_'#_name)

The commit message conflates two unrelated things:
__attribute__((unused)) and __maybe_unused are purely warning
suppressions; they do not affect whether the symbol is emitted, kept
by the linker, or seen by LTO. The thing that prevents removal is
__used (and at the linker stage, KEEP()).

The real reason removal is safe is that none of these declarations
would have warned anyway - ll_entry_declare()/ll_entry_declare_list()
produce non-static externals (no -Wunused-variable for those),
ll_entry_start()/ll_entry_end() take the address of start[]/end[]
inside the same statement expression, and the symbols from
ll_start_decl()/ll_end_decl() are referenced by the caller (cmd_ut.c
is currently the only one). Please reword the commit message along
those lines; the KEEP() stuff belongs more naturally with patch 3.

Regards,
Simon
