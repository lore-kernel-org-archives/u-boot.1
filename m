Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE57DCEE34F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 21:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC77E88DDD;
	Wed,  9 Oct 2024 23:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SXksfnTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3026D88DED; Wed,  9 Oct 2024 23:14:25 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 042A688E0C
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 23:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-45d8f76eca7so3311291cf.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728508460; x=1729113260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qT41TaQ7J+P3Ca7Oi7GQ0elL5LoU6sraQmouredBgc4=;
 b=SXksfnTDuU9Xklr1jFHg5WG+6jOyrNdnj53DggHUdRefvGZDSHgM+MhlGBwYdzHlvi
 i3JlI7tJF46R7QeRXRJ8wf1jv+1pJGFsvspGDECVwFtVdp97QAFNXHNsQPUPXog1tE3L
 0pVcNzZLPZo/L1qbN9edpTm1vAnMpLKrlcJ68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728508460; x=1729113260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qT41TaQ7J+P3Ca7Oi7GQ0elL5LoU6sraQmouredBgc4=;
 b=Cv3NwcqF2S9qfxRU5P1m+muQ6pPO4bd4Yo+GHRJttODR6w1cSFWG/rSBeaI3/Ug7sA
 qrZujNv7xWV3DbSZwy5cf42KmGg9RjXDFnVNt2LevGaV9fby6vVtxIDkzki1IEulU8qt
 WxECXaNoipLOx0r744dLLUUSvuypccTYDVFRI9j76S1IaSUjYUw33+/m6HpvMmVf+2vM
 KdKGd9nbMO7DPt6huVQTsveegu1LbBjZ7U0X+6rgxU06EV1ydfH+iVlSn9i4j1rznCsx
 IObB5Wy3EkdGF17m8rAycjclO7kPnyTrPjydf+P2OO/Qeymdj0sTsohGqa5JP9DTpTh/
 A4OQ==
X-Gm-Message-State: AOJu0YyIPJKbnsrAWv3uD2PfzEXNJEmdfHJh9eeZk7NBiqT8qRRkHkPS
 uhjeGkH+MpWE1cLDVl4QvMDSy4Gk1X8Z/GXYLOrt6gQ3FmSWnJEXTulALqwknvIBXy9hNlpa3eP
 +mNrtBWaVN97TYIlmfg+TXxZJOW/q2m93fPHh
X-Google-Smtp-Source: AGHT+IFeVhUFvGQA7Dh+V/L0aZYtQp+gFoUflGah/el3y9U1l6uSMKCcGthbI93PbLUWT8K7gsiU6dC5A/0eSfSI+Ek=
X-Received: by 2002:a05:622a:581b:b0:45f:788:b1ad with SMTP id
 d75a77b69052e-45fa5f20d81mr62289161cf.27.1728508460127; Wed, 09 Oct 2024
 14:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com>
 <CAFLszTiBHjqc-xeqsC51hFUed8bigv8+WsC9hUnv_tEC2RahcQ@mail.gmail.com>
 <d2a8f534-a983-4092-8fc2-ce45b54de476@amd.com>
In-Reply-To: <d2a8f534-a983-4092-8fc2-ce45b54de476@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Oct 2024 15:14:09 -0600
Message-ID: <CAFLszTjYOoNcMc7MTA-RdR_mKwM+8t=yKRpuYZSfqOvVBA1_PA@mail.gmail.com>
Subject: Re: [PATCH] binman: Add option for pointing to external description
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <sean.anderson@seco.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Michal,

On Wed, 9 Oct 2024 at 07:21, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi,
>
> On 10/9/24 03:55, Simon Glass wrote:
> > Hi Michal,
> >
> > On Mon, 7 Oct 2024 at 07:05, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >> Adding binman node with target images description can be unwanted feature
> >> but as of today there is no way to disable it.
> >> Also on size constrained systems it is not useful to add binman description
> >> to DTB.
> >> Introduce BINMAN_EXTERNAL_DTB Kconfig symbol which allows separate DTB for
> >> target from DTB for binman itself.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >> ---
> >>
> >>   Makefile    |  2 +-
> >>   lib/Kconfig | 10 ++++++++++
> >>   2 files changed, 11 insertions(+), 1 deletion(-)
> >>
> >
> > Doesn't this defeat one of the purposes of Binman, i.e. to document
> > images? We do want the .dts to include the image description. What
> > sort of problem is this causing?
>
> We have two boot flows.
> The first one (default one) is using Xilinx FSBL for SOM initialization with fit
> image (DTBS) + u-boot.elf + tfa.
>
> The second one is using U-Boot SPL instead of FSBL. This flow is used by
> buildroot for example.
>
> In perfect world I should describe both of these flows. I sent description for
> the second as RFC here.
> https://lore.kernel.org/r/de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com

OK I'll take a look.

>
> but it is also reasonable to describe the first flow but I really don't want
> both descriptions ends up in the target image.

Why not? Knowing what is in the firmware is one of the goals of Binman.

>
> The second part is if you look at RFC and how fit-dtb.blob is composed. It is
> one DTB + DTBS which are composed from overlays.
>
> xilinx_zynqmp_kria_defconfig has
> CONFIG_DEFAULT_DEVICE_TREE="zynqmp-smk-k26-revA"
>
> That's why binman node should go to this DTB but because other images are
> composed with overlays binman node is spread to all DTBs inside FIT image.
>
> It means one binman description is in fit-dtb.blob 14 times which is far from
> ideal.

Yes, but I think what you are saying is that U-Boot doesn't need the
description, so you don't need it to appear in the dtbs in the FIT. Is
that right?

If so, then I think we should add a way to remove it, in Binman,
perhaps with a property in the top-level binman image.

>
> Third part is that I can't see binman node in DT schema or bindings that's why I
> expect this will be reported and I can't see any code which removes it before
> handing off to OS which is required for System Ready IR.
> And IIRC removing is also problematic for measured boot.

I did start this e.g. [1] but have not got back to it. Help would be
appreciated if it is important to you. I am not sure about System
Ready IR, but we shouldn't need to remove this.

Also, please add an fdtmap somewhere so the image can be listed.

Regards,
Simon

[1] Documentation/devicetree/bindings/mtd/partitions/binman.yaml
