Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A72E77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0051E80141;
	Mon, 16 Dec 2024 16:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LbWAaUj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF7B280214; Mon, 16 Dec 2024 16:20:13 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C67800D7
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 16:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa6aee68a57so617810366b.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 07:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734362411; x=1734967211; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BFIxgKuLjtjRePb/tdu8I69tPWbL19AiB45FDGQoCXg=;
 b=LbWAaUj1Urx3byqpcW0VA2tU4Xscr0fqbuk332hFr3lF5x2++YKb1whTPYOnBtBMex
 IRjgYihLgeKm8i0+547gnfFql/zWiUxRs2J2ruMj5xTXBsaY05ZGdTWRpcprVuQJuZ7e
 FVnlJ+Rpw+3P4iZ0aNL0J3C4TfwIR0pAvZH48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734362411; x=1734967211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BFIxgKuLjtjRePb/tdu8I69tPWbL19AiB45FDGQoCXg=;
 b=aw/1CSxbifqIazkggxsSu4+Dh97tySmLaK9mZEs8p8i8F7Ycx8RDmMNvDOC54cpbp0
 fkjoCXsuiq00dU7faR+Ss/bePBpc0pkXOcxvcXZA4ByBttTmplYlKS1be/iepvIkdQLC
 zz/kDl7ivl4CpILg2pMltzFBnMW92MjQvZTEUBdHPuY0Vli+35w9DniJGD9CmOLAto7Y
 nbz4rlHd2APXEg0t+F+TU+sWaVzekyZ+Kw9KVysZB0vr+NcZJykuPqz425TFQWN5ucYX
 yjLR6QDf+lK92ojM6cQ+zjMfr2SupuMs6mWNnR8me6YNreX9RodjdgaXWUkJ1OIZzAOM
 KCsg==
X-Gm-Message-State: AOJu0YwYrX5AiTflWE/tcc9Nhkc6YfJx+v6vTpxl5ulauD3Pj8c3UHSo
 hX/7rPCMqAL09eYtuBNiLDKxwRCXxRRCtmrdEt8mlh8g053J0ziWB4tJZtVrNRlC2dkrWWUGnPz
 DbTz8WHWKDnwcSe/zr7mATHe18nxSzo3xkK70
X-Gm-Gg: ASbGncuIKH4m85IxBxNAO5gKmypwphJDrAS7Q/NS7SPXvtAPD+oEljeTEMA4AmDgHNR
 LnzrVeOuRHNB79vnF+DGBKE8vkEcdch6Mk1h+6Ec=
X-Google-Smtp-Source: AGHT+IFktBlY2tS6hIeARljIfsku6EWTiRzhH9LiTg+P+1LVCW/a5rikWrIGbCev+t41PQeWdWWUmV2OVdZrAMQVeA0=
X-Received: by 2002:a17:906:3142:b0:aab:d7ef:d44 with SMTP id
 a640c23a62f3a-aabd7ef10d8mr69400066b.24.1734362410961; Mon, 16 Dec 2024
 07:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20241213225543.392282-1-raymond.mao@linaro.org>
 <20241213225543.392282-2-raymond.mao@linaro.org>
 <CAFLszTiVmZGxETFkngDbsv0PCLN_bVv7ox6MFiAoGGN2v7tbKQ@mail.gmail.com>
 <CAEfUkUL1EyJ6si_N6k6Ku1ZM9dWF6uHYXrQ14dueUeTEYzSRNQ@mail.gmail.com>
In-Reply-To: <CAEfUkUL1EyJ6si_N6k6Ku1ZM9dWF6uHYXrQ14dueUeTEYzSRNQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Dec 2024 08:19:59 -0700
Message-ID: <CAFLszThWQ2pOQux_Hsa2M=ArBR7f+R2GHeB2d4CB6k4MxShR4w@mail.gmail.com>
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

On Mon, 16 Dec 2024 at 07:52, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Sun, 15 Dec 2024 at 19:25, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Get tpm event log from bloblist instead of FDT when bloblist is
>> > enabled and valid from previous boot stage.
>> >
>> > Note:
>> > This patch depends on:
>> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
>> > https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> >  lib/tpm_tcg2.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
>> > index 7f868cc883..acaf0acb88 100644
>> > --- a/lib/tpm_tcg2.c
>> > +++ b/lib/tpm_tcg2.c
>> > @@ -19,6 +19,7 @@
>> >  #include <linux/unaligned/generic.h>
>> >  #include <linux/unaligned/le_byteshift.h>
>> >  #include "tpm-utils.h"
>> > +#include <bloblist.h>
>> >
>> >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
>> >                       u32 *pcr_banks)
>> > @@ -672,6 +673,12 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
>> >         *addr = NULL;
>> >         *size = 0;
>> >
>> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) && !bloblist_maybe_init()) {
>>
>> Please drop the second term...the bloblist is inited by U-Boot already.
>>
>
> As an independent library, from the tpm library's angle, whether the bloblist init was already called or not is agnostic.
> I think this is the purpose of the "maybe" function.

No. U-Boot does init at the start. We don't want each subsystem
'maybe' initing each other subsystem that it uses. If you want to
check whether bloblist is available, you can use the GD flag.

>
>>
>> Also please drop the first term. If you find it in the bloblist, just use it.
>>
>
> I think here we should have the same logic as the existing one in fdtdec:
> If bloblist is not enabled or errors observed, do a fallback to the original process.
> At least I want to keep the same logic in different places before everything is ready from TF-A to U-boot.

Yes, your second line is right. But PRIOR_STAGE doesn't exist, nor
should it. Nor do you need it, since you can just check the bloblist
for what you want. If you don't find it, fall back.

>
> [snip]

REgards,
Simon
