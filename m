Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8322E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 17:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58FA3800D7;
	Mon, 16 Dec 2024 18:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yjarO72h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6768780104; Mon, 16 Dec 2024 18:53:05 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53716800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 18:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee989553c1so3682565a91.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 09:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734371581; x=1734976381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/f+zyXov8clq+X6cjM9JVMKhheUTcMWrXv7xDuJV1X4=;
 b=yjarO72h2E1HWqfrG1ygndFsRWEsfMDom7cU1PHISFV8f28tkNkl2KHbQhM6jkk9cq
 sXj4BPmRNo3DPjQoztPj5PmNCtt9kp3dxIUPXpA93+xWbfGUsbITcTBNOuSHdZZbNH+W
 xoNbvG0Nw7XvRLiuNMVYXyzbI5xemx2KYhsq1ZlYyOwEphSDzK3zFa4qI0WieLZOzQan
 FFKYxK7vjEhkH8VxT+D0NjR6utBVmqbLJG/Gx0LaXBKASG7iIWHOihom4D4zMN950JL8
 3kQ50e7rxGq70ugJosTr5AAj/XiFnX93Tn7ECoDXCFp+8lQ5VtRBjC4ld98iMuhW9IZH
 bG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734371581; x=1734976381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/f+zyXov8clq+X6cjM9JVMKhheUTcMWrXv7xDuJV1X4=;
 b=IMEVjJ8iz/ilJSJh5zEY4ayqd3sY8XRHvRxCV4+kOlDBqzyQ315V+oixPip8j4ecq9
 mXDTw22ZdRmdAb79UosFj8Q6B8F76HO7addwO3c09O/HBLRbvwf+u+v7VctWwlshnXOF
 fvdHX54rduyclHg1rxdIJ/TWwRPJOu+pKjLzjDfd5Y7QbeEBVSSKr8HCNQcT+428qzy/
 DvbVfqoFpXkSG7w0rEqBzfQvBINX3c7qSkN67OKfZxi/3XnkV953wAII1+Kfa1jw+FMv
 U+MzxQPUti3so/7f9cz9caei2pQkTXKW0pP1ls1rmLmajbSevy/pLLQgJDpNIhqcVb66
 IADw==
X-Gm-Message-State: AOJu0Yzp9T4RWjSLE29uOl8aGnMMMIlVaJ8t+Z5hQ7Ung2lc1A23iKns
 BJ0worZwGlOmSdP1NfVosKY1wS9UeHUj46bjt/S6KfK7h3mjlN7mXW3fT4gbajTHC7rS44SLAr4
 ZljAkbFGgtuhk/jGuPUcSOUjJznr+obKwo1LZ0g==
X-Gm-Gg: ASbGncufD56QMJqzElVFco7ikESvolpFn/058eoPdZnTF6/PPbjMoBwOjAxFRXK7IyQ
 Ur6c6SkWpYVRdPsm7phy9QBGFg0sP17dyVL32XnW+gy3ZRJXft+rRCeutTA1JEFzJ+HRQ/bY=
X-Google-Smtp-Source: AGHT+IEVap18sdnPFY3QWH5bEsxtfZSBuwHRQlvLqvQB9LOo4sEgsrBhsBmRmOhKpHZw9HF6fMqEogJcy7mt6B+bzNM=
X-Received: by 2002:a17:90b:3b48:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2f28fb6768emr24735054a91.12.1734371580701; Mon, 16 Dec 2024
 09:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20241213225543.392282-1-raymond.mao@linaro.org>
 <20241213225543.392282-2-raymond.mao@linaro.org>
 <CAFLszTiVmZGxETFkngDbsv0PCLN_bVv7ox6MFiAoGGN2v7tbKQ@mail.gmail.com>
 <CAEfUkUL1EyJ6si_N6k6Ku1ZM9dWF6uHYXrQ14dueUeTEYzSRNQ@mail.gmail.com>
 <CAFLszThWQ2pOQux_Hsa2M=ArBR7f+R2GHeB2d4CB6k4MxShR4w@mail.gmail.com>
 <CAEfUkUKA9raUu0dANWf25aw6kBzu-DKshctQxVre57bEiN94kA@mail.gmail.com>
 <CAFLszTh4hjCHAoqkr+zdeBeq5rCoaO3aSjBVvFyCYVLoccPSUw@mail.gmail.com>
 <CAEfUkUJ8MrFoS3k9svxNoiYsZq51SS_=+TpKKeH=x2jPXRjPtQ@mail.gmail.com>
 <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
In-Reply-To: <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 16 Dec 2024 12:52:49 -0500
Message-ID: <CAEfUkUJ6srnrxewzgd26_1FTU-0Qfv27ZOGtpF-kR+6JvzYOeQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

On Mon, 16 Dec 2024 at 12:37, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Mon, 16 Dec 2024 at 10:24, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Mon, 16 Dec 2024 at 10:43, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Raymond,
> >>
> >> On Mon, 16 Dec 2024 at 08:29, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >> >
> >> > Hi Simon,
> >> >
> >> > On Mon, 16 Dec 2024 at 10:20, Simon Glass <sjg@chromium.org> wrote:
> >> >>
> >> >> Hi Raymond,
> >> >>
> >> >> On Mon, 16 Dec 2024 at 07:52, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >> >> >
> >> >> > Hi Simon,
> >> >> >
> >> >> > On Sun, 15 Dec 2024 at 19:25, Simon Glass <sjg@chromium.org>
> wrote:
> >> >> >>
> >> >> >> Hi Raymond,
> >> >> >>
> >> >> >> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >> >> >> >
> >> >> >> > Get tpm event log from bloblist instead of FDT when bloblist is
> >> >> >> > enabled and valid from previous boot stage.
> >> >> >> >
> >> >> >> > Note:
> >> >> >> > This patch depends on:
> >> >> >> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
> >> >> >> >
> https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/
> >> >> >> >
> >> >> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> >> >> > ---
> >> >> >> >  lib/tpm_tcg2.c | 7 +++++++
> >> >> >> >  1 file changed, 7 insertions(+)
> >> >> >> >
> >> >> >> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> >> >> >> > index 7f868cc883..acaf0acb88 100644
> >> >> >> > --- a/lib/tpm_tcg2.c
> >> >> >> > +++ b/lib/tpm_tcg2.c
> >> >> >> > @@ -19,6 +19,7 @@
> >> >> >> >  #include <linux/unaligned/generic.h>
> >> >> >> >  #include <linux/unaligned/le_byteshift.h>
> >> >> >> >  #include "tpm-utils.h"
> >> >> >> > +#include <bloblist.h>
> >> >> >> >
> >> >> >> >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr,
> u32 *active_pcr,
> >> >> >> >                       u32 *pcr_banks)
> >> >> >> > @@ -672,6 +673,12 @@ __weak int tcg2_platform_get_log(struct
> udevice *dev, void **addr, u32 *size)
> >> >> >> >         *addr = NULL;
> >> >> >> >         *size = 0;
> >> >> >> >
> >> >> >> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
> !bloblist_maybe_init()) {
> >> >> >>
> >> >> >> Please drop the second term...the bloblist is inited by U-Boot
> already.
> >> >> >>
> >> >> >
> >> >> > As an independent library, from the tpm library's angle, whether
> the bloblist init was already called or not is agnostic.
> >> >> > I think this is the purpose of the "maybe" function.
> >> >>
> >> >> No. U-Boot does init at the start. We don't want each subsystem
> >> >> 'maybe' initing each other subsystem that it uses. If you want to
> >> >> check whether bloblist is available, you can use the GD flag.
> >> >>
> >> >
> >> > OK. I can use the gd instead.
> >> >
> >> >>
> >> >> >
> >> >> >>
> >> >> >> Also please drop the first term. If you find it in the bloblist,
> just use it.
> >> >> >>
> >> >> >
> >> >> > I think here we should have the same logic as the existing one in
> fdtdec:
> >> >> > If bloblist is not enabled or errors observed, do a fallback to
> the original process.
> >> >> > At least I want to keep the same logic in different places before
> everything is ready from TF-A to U-boot.
> >> >>
> >> >> Yes, your second line is right. But PRIOR_STAGE doesn't exist, nor
> >> >> should it. Nor do you need it, since you can just check the bloblist
> >> >> for what you want. If you don't find it, fall back.
> >> >>
> >> >
> >> > Since Firmware Handoff is still an experimental feature and not
> mandatory yet (at least now),
> >> > I put everything under PRIOR_STAGE to allow users to disable it by
> their own decisions.
> >> > I saw PRIOR_STAGE in one of Tom's recent patches so I have added a
> dependency claim in my commit message.
> >>
> >> Yes, but even if Tom does pick his patch, which I object to, by the
> >> time your code is called, there will be a bloblist.
> >>
> >> So the end result of your test is to allow the user to ignore any TPM
> >> log in the bloblist. If that's what you want (which seems fine to me),
> >> add a Kconfig for it.
> >>
> >
> > Per my understanding of PRIOR_STAGE, it means we have a bloblist from
> the previous stage and we want to use it (as a Transfer List).
> > If this is the case, it is not for DT only but can be applied for
> eventlog or anything for Firmware Handoff in the future.
> > That is the reason I use PRIOR_STAGE here, I don't think we need to add
> another kconfig.
>
> Who knows what it is supposed to mean...anyway, it should not be used
> like that. The devicetree is special in that we want to get it from
> the bloblist very early, if available. Nothing else (so far) in the
> bloblist has this constraint, certainly not the TPM log.
>
> Perhaps I should ask, what problem are you trying to solve by making
> it conditional on a Kconfig?
>
>
My idea is to have one kconfig to enable/disable all the stuff related to
the Firmware Handoff spec implementations.
When this kconfig is enabled, U-Boot will use bloblist (aka. Transfer List,
described in Firmware Handoff spec) to handover everything (e.g. FDT,
eventlog, ...) from the previous boot stage instead of DT.
If this kconfig is disabled, or any errors during parsing the blob,
fallback to the legacy handoff way. Surely, in the future we can remove the
fallback to restrict the rule.
At the moment, I think the 'BLOBLIST_PRIOR_STAGE' kconfig is best aligned
to this idea.

Regards.
Raymond
