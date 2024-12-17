Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF48E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C83BC80303;
	Tue, 17 Dec 2024 20:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DEErsvBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3180680351; Tue, 17 Dec 2024 20:47:59 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C0280323
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee989553c1so4760889a91.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464875; x=1735069675; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z5odFw5A/exDVrTdvvkdVJbc9/VrAJ9z8WPafbd/Wc0=;
 b=DEErsvBJcAx/VZZ4J4eGuQNqvn6IFC91WeIDpuNa+cGgTizXZyCc6QZBrmcVzyz3VL
 honTlYiiBarq14PejUcLJhAIpvJ1xqQpjvxm1WPtq7yP8yQngwVRhMyu5b0quhuqmCHM
 JvMGXvDvQupxNE3i9vti7U+PV/V54jrYzBKIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464875; x=1735069675;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z5odFw5A/exDVrTdvvkdVJbc9/VrAJ9z8WPafbd/Wc0=;
 b=nn9GKYwZZHpY4vsy7g95YLQWE3jIluxEtLwBRPQsKqnY4qZ/GbRTPa0YDeKGYpsGDN
 kjMAPAmFbVcE9Jhh63Fw6Hgb7LeQtSkHlyiPwleRf04pe8p2VpCHTZCLodRuhOxUJgRx
 j1uE9v3SpY4ulegj99ZWaRNzEvzm1SMfUhEDpwIEtFeyV+WGDm2d9mp8q2L2IaR245LE
 hS4Oe8hcYkAn7CsW9prQDJh4iRs2wRscggwo01NGuhD/ZY6hEeHdnKyyk6uEj9hekhMQ
 fk0Lr7d3/nup2CUlkmdt5WX3i539U1uHP9YSseuaMDyLhtT5KA+nLBtq30crt2ksX6zr
 QNMw==
X-Gm-Message-State: AOJu0YyHbgfqnc9APn1A8IJLcgeQWJP5NzA22JSXBM1OmOWV/NRDb15x
 RBOpqOFLFpJd9d4+wPFcJWcUnSAWq0JiVDr1ynHCluLMAGimh1EaNN5z9e9dCXccf+eZFDXG7iL
 I2SQx6reycawby/P4axDT0ts7s8MMS/18TZBb
X-Gm-Gg: ASbGnct/L+AOCFoGEtAv+2OnbFq/LVGEqxQ8XunEMXtulEO+ut0jKiHGcELS8QcYbU7
 2qpGtywt7yaoWPa1fhRQeSYG9oE8h2JY2XFKsbxQ=
X-Google-Smtp-Source: AGHT+IGamtpGL8rbq6hb5qFV+Ti1neIKgmpxTSomHqNdfuQdesfW5BstZSXFQ3ojeaLAYTQTz1rY36mMeTZicqYDonc=
X-Received: by 2002:a17:90b:2b8e:b0:2ee:d63f:d71 with SMTP id
 98e67ed59e1d1-2f2e91d6163mr221943a91.14.1734464875411; Tue, 17 Dec 2024
 11:47:55 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:47 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTiHDiGSYD=LxBNj8mA-nYeXc_2B4NU=7c-hKp7iKCPQSA@mail.gmail.com>
References: <CAFLszTiHDiGSYD=LxBNj8mA-nYeXc_2B4NU=7c-hKp7iKCPQSA@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-9-sjg@chromium.org>
 <CAC_iWjKnvOsKP7sa447yaQB7_G6nvbY=FxDWuFxkW5pt=cXXeQ@mail.gmail.com>
Date: Tue, 17 Dec 2024 11:47:47 -0800
X-Google-Sender-Auth: L7acajlhtZ-4ucPVCaExqh34oU8
Message-ID: <CAFLszTg_HcFJPah-4mwmQDMCND7D6E+xjFP1NQJoyLVuPsXBGw@mail.gmail.com>
Subject: Re: [PATCH v5 08/23] efi_loader: Use a separate struct for memory
 nodes
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Wed, 11 Dec 2024 at 08:08, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > At present efi_memory uses struct efi_mem_desc for each node of its
> > memory list. This is convenient but is not ideal, since:
> >
> > - it means that the fields are under a 'desc' sub-structure
> > - it includes an unused 'reserved' field
>
> That's interesting. The EFI spec does not define that and I looked as
> back as 2.5.
> Heinrich, this predates my involvement with EFI, do you remember why
> it was added?
>
> Because it's defined in
> > - it includes virtual_start which is confusing as it is always the same
> >   as physical_start
> > - we must use u64 to store pointers, since that is how they are returned
> >   by calls to efi_get_memory_map()
>
> I don't understand the 'pointers' again here. It's a physical address.
>

Let's have a call so I can explain this...

> >
> > As a first step to tidying this up, create a new, private struct to hold
> > these fields.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Add new patch to use a separate stuct for memory nodes
> >
> >  lib/efi_loader/efi_memory.c | 49 +++++++++++++++++++++++++++++++------
> >  1 file changed, 42 insertions(+), 7 deletions(-)
> >
Applied to sjg/master, thanks!
