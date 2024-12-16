Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640FAE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 17:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91521800D7;
	Mon, 16 Dec 2024 18:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FINPLCD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D590780104; Mon, 16 Dec 2024 18:37:44 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15CDA800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 18:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa69077b93fso650004566b.0
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 09:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734370661; x=1734975461; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PXlaFwDpL07akySP7dy+aLqdNs67EwV/8K2d7CH8eX4=;
 b=FINPLCD7T5OL+vE7fES19VQR4AO2PBqDI4fTco6XFXuCGmWG0oVkrLUibWSBUmMAAD
 5rY0Pg/dx3e/jwQjRQLSv3Jkq5O32xpKEfkcWFe7eic0aIkfIxIXDQ6+ere/cIQoP6HB
 7MQwkizH0FN1Z6LcQ+4WAgWvlbggbimoLWql4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734370661; x=1734975461;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PXlaFwDpL07akySP7dy+aLqdNs67EwV/8K2d7CH8eX4=;
 b=owr9prVj0aNR60zbW1xu4MSzS51+M4qQfy7X0IqnLxC+Idi9bSxteEa4d/IGJZ5WX5
 cvONiillpMhVgxPrn4dHpUBhBu0IMzbQtdS4KNNDugpDGY2O73k6KuBXoTIsx/8lLxjn
 l+yaTkmuE4j8yQLEI3zaFSwHstl80yZUlvu2HTrlTIIBrUmxyqwA8T7TC5adRdwJaflr
 gcBXv6Zf3vA8KNewWdeKLtJPLruNNpBgskm0CIsUuMXMNl/tHy0a/ewBUclixEjXLQeO
 FrRazTRHkwT7Wu9UtPZiZrh7GQplKLeisxQH0aD3JSwVhgV0/jsTMeXP4F/x2tUmkrJe
 3JIw==
X-Gm-Message-State: AOJu0Yw5aaS22Ty6594bYd/xp1w0vJ6NDq6ExojZ1RH4flmNON4AI6WF
 9aJ5TG42IZdekTD7cKb8hxNMSvMbi1Esx8Pk9oiDnC9SxBjvbQFRCHqB+oWThTfYihuUuBh6snq
 XbLHPm20YBFkbxhlfp1bC3oSpnlexZBVSiTZq
X-Gm-Gg: ASbGncsd+okGvsiICQPRSaUkOE2uiUYwBC7KnlOoGd4XUJrlK8errHgx2wv7ryduuRa
 7Ww0O6pTmxAAuPAyLgWtOTj5CIEmMZqF09qpPo4A=
X-Google-Smtp-Source: AGHT+IHnhXtgkXrmzO972EHpKydFZ0wlM0/oqY1vTdF6mzPfLI4O0j/21yDMAzugsw+CvjgZ9E0n91uB8Y0u9kz7hn0=
X-Received: by 2002:a17:907:3f9b:b0:aa6:9461:a17e with SMTP id
 a640c23a62f3a-aab77e9f6a9mr1490124966b.40.1734370661418; Mon, 16 Dec 2024
 09:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20241213225543.392282-1-raymond.mao@linaro.org>
 <20241213225543.392282-2-raymond.mao@linaro.org>
 <CAFLszTiVmZGxETFkngDbsv0PCLN_bVv7ox6MFiAoGGN2v7tbKQ@mail.gmail.com>
 <CAEfUkUL1EyJ6si_N6k6Ku1ZM9dWF6uHYXrQ14dueUeTEYzSRNQ@mail.gmail.com>
 <CAFLszThWQ2pOQux_Hsa2M=ArBR7f+R2GHeB2d4CB6k4MxShR4w@mail.gmail.com>
 <CAEfUkUKA9raUu0dANWf25aw6kBzu-DKshctQxVre57bEiN94kA@mail.gmail.com>
 <CAFLszTh4hjCHAoqkr+zdeBeq5rCoaO3aSjBVvFyCYVLoccPSUw@mail.gmail.com>
 <CAEfUkUJ8MrFoS3k9svxNoiYsZq51SS_=+TpKKeH=x2jPXRjPtQ@mail.gmail.com>
In-Reply-To: <CAEfUkUJ8MrFoS3k9svxNoiYsZq51SS_=+TpKKeH=x2jPXRjPtQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Dec 2024 10:37:30 -0700
Message-ID: <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>
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

Hi Raymond,

On Mon, 16 Dec 2024 at 10:24, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Mon, 16 Dec 2024 at 10:43, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Mon, 16 Dec 2024 at 08:29, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Hi Simon,
>> >
>> > On Mon, 16 Dec 2024 at 10:20, Simon Glass <sjg@chromium.org> wrote:
>> >>
>> >> Hi Raymond,
>> >>
>> >> On Mon, 16 Dec 2024 at 07:52, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >> >
>> >> > Hi Simon,
>> >> >
>> >> > On Sun, 15 Dec 2024 at 19:25, Simon Glass <sjg@chromium.org> wrote:
>> >> >>
>> >> >> Hi Raymond,
>> >> >>
>> >> >> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >> >> >
>> >> >> > Get tpm event log from bloblist instead of FDT when bloblist is
>> >> >> > enabled and valid from previous boot stage.
>> >> >> >
>> >> >> > Note:
>> >> >> > This patch depends on:
>> >> >> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
>> >> >> > https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/
>> >> >> >
>> >> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> >> >> > ---
>> >> >> >  lib/tpm_tcg2.c | 7 +++++++
>> >> >> >  1 file changed, 7 insertions(+)
>> >> >> >
>> >> >> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
>> >> >> > index 7f868cc883..acaf0acb88 100644
>> >> >> > --- a/lib/tpm_tcg2.c
>> >> >> > +++ b/lib/tpm_tcg2.c
>> >> >> > @@ -19,6 +19,7 @@
>> >> >> >  #include <linux/unaligned/generic.h>
>> >> >> >  #include <linux/unaligned/le_byteshift.h>
>> >> >> >  #include "tpm-utils.h"
>> >> >> > +#include <bloblist.h>
>> >> >> >
>> >> >> >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
>> >> >> >                       u32 *pcr_banks)
>> >> >> > @@ -672,6 +673,12 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
>> >> >> >         *addr = NULL;
>> >> >> >         *size = 0;
>> >> >> >
>> >> >> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) && !bloblist_maybe_init()) {
>> >> >>
>> >> >> Please drop the second term...the bloblist is inited by U-Boot already.
>> >> >>
>> >> >
>> >> > As an independent library, from the tpm library's angle, whether the bloblist init was already called or not is agnostic.
>> >> > I think this is the purpose of the "maybe" function.
>> >>
>> >> No. U-Boot does init at the start. We don't want each subsystem
>> >> 'maybe' initing each other subsystem that it uses. If you want to
>> >> check whether bloblist is available, you can use the GD flag.
>> >>
>> >
>> > OK. I can use the gd instead.
>> >
>> >>
>> >> >
>> >> >>
>> >> >> Also please drop the first term. If you find it in the bloblist, just use it.
>> >> >>
>> >> >
>> >> > I think here we should have the same logic as the existing one in fdtdec:
>> >> > If bloblist is not enabled or errors observed, do a fallback to the original process.
>> >> > At least I want to keep the same logic in different places before everything is ready from TF-A to U-boot.
>> >>
>> >> Yes, your second line is right. But PRIOR_STAGE doesn't exist, nor
>> >> should it. Nor do you need it, since you can just check the bloblist
>> >> for what you want. If you don't find it, fall back.
>> >>
>> >
>> > Since Firmware Handoff is still an experimental feature and not mandatory yet (at least now),
>> > I put everything under PRIOR_STAGE to allow users to disable it by their own decisions.
>> > I saw PRIOR_STAGE in one of Tom's recent patches so I have added a dependency claim in my commit message.
>>
>> Yes, but even if Tom does pick his patch, which I object to, by the
>> time your code is called, there will be a bloblist.
>>
>> So the end result of your test is to allow the user to ignore any TPM
>> log in the bloblist. If that's what you want (which seems fine to me),
>> add a Kconfig for it.
>>
>
> Per my understanding of PRIOR_STAGE, it means we have a bloblist from the previous stage and we want to use it (as a Transfer List).
> If this is the case, it is not for DT only but can be applied for eventlog or anything for Firmware Handoff in the future.
> That is the reason I use PRIOR_STAGE here, I don't think we need to add another kconfig.

Who knows what it is supposed to mean...anyway, it should not be used
like that. The devicetree is special in that we want to get it from
the bloblist very early, if available. Nothing else (so far) in the
bloblist has this constraint, certainly not the TPM log.

Perhaps I should ask, what problem are you trying to solve by making
it conditional on a Kconfig?

> [snip]

Regards,
Simon
