Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA165E77187
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A76B80288;
	Tue, 17 Dec 2024 20:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a18F7193";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20C8C80362; Tue, 17 Dec 2024 20:48:18 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C691480315
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2164b1f05caso53019395ad.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464894; x=1735069694; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RkEl+c/T35kCVKFXZulZwDFQ4NtO/cbu1zK9X54RQxQ=;
 b=a18F7193p2561gWgqd632eNkQrAB9+bPB7DqD4iK2wYei0XQnVmdE2MRtfYZXoGzrg
 1jl6GWHlcPHgEkw4fGrrDRgtchCofx+wLaWCZ4g4RWpYJWcSVW4Q5qPY08vS5DkS85AM
 PoS0Y4J5+3B+7CUZmAFS0mJPXf3B33/63+tIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464894; x=1735069694;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RkEl+c/T35kCVKFXZulZwDFQ4NtO/cbu1zK9X54RQxQ=;
 b=uq6/f4OX3r0h1M32iZSEuqLA2r9T0R2nAwQqtbFTMhhdGqEcLu61S+v0Ob2dJkhrhL
 8h615djBG09u+YSAs5rZ+IRZJU5LkCS811JM6zTOcwJw0+dF2sCv82WyNjtrYx9S99P4
 2boX/yDSB0DG4oBaWTAEjHtj6ZGvCpClCW4aGoBrqaMNUoOLEUNLeZ/fytgGgZMB69ew
 2oTkCg05Z/9tMejE2mSbi3TPaibNEhdrRDXQLK1UFew2/PXos/lbn5LRUeZzPjoiwrlm
 xhasthRFs4btmQn/xhZaiRPftDaqRyLQ8U8byhwSzhxglSexcJVDXsJLE/XxOdyS2p2Y
 fZBw==
X-Gm-Message-State: AOJu0YxlRM6FaY77lfAuKOkKfxJTDs627HAnhdV1QDnGfBzr4uT51uy4
 M3qVaY04hRBOuGO2HFufxlg1vX2ZNOI9AnSLh96Bg6QfrJ02l4IKtedidYkr13vKRRAkrV+R/Ov
 D2Ti3AS6Gd+72RWASxWp/MnXJii0ly8ZRnRHT
X-Gm-Gg: ASbGnctE/1vjwcnDepURYLCPrvdJxmKrVLm8YWuUIvbr03V5xYLgPBfjmuiKRoDOzzy
 g7bKj4/zw86z3XKfukCIX3GGDdWILqjDPFQOu9o4=
X-Google-Smtp-Source: AGHT+IEY4Oum1ZQmm7+OyfNp/5fvC/4LbPLEmJlJPZ04V1dGt3zkHL3yqdE3rWLnh9Xg3xOZrI1bNiD8hcPntVRzVx0=
X-Received: by 2002:a17:90b:5246:b0:2ee:b2fe:eeee with SMTP id
 98e67ed59e1d1-2f2e91dd06emr226893a91.15.1734464894309; Tue, 17 Dec 2024
 11:48:14 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:48:06 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTg4Pn_NZkGOtGduz5bm8R5PkTN4W+J7zKCLXJmiX2QYuw@mail.gmail.com>
References: <CAFLszTg4Pn_NZkGOtGduz5bm8R5PkTN4W+J7zKCLXJmiX2QYuw@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-5-sjg@chromium.org>
 <CAC_iWjK8LO=m9ymhCDMep0xwa+hR8OSaBfS1VXgWsPLAGfnuXQ@mail.gmail.com>
 <CAFLszTiTLXpZ4NYX2rEtjYa3+2moXt-aFtJYQvui8_Po4tQt4w@mail.gmail.com>
 <CAC_iWj+3-pwCZ+=vJGMzPwyzywRXXOJXCLQ3GT0h6jEjcpeK-g@mail.gmail.com>
 <CAFLszTg0ByzE0WhHmgvgZhDWu4BxZ3a8bLc6EDUvHNqBLyYprg@mail.gmail.com>
 <CAC_iWjKHYznXnjTxC060v3H8vdvMcmTHBM0ZKKqb8PjPoUCqZQ@mail.gmail.com>
 <CAC_iWjLhFymSyHaZ96K6Ga4jz2EbX2L87WUX98pH2xPiJ4WijA@mail.gmail.com>
Date: Tue, 17 Dec 2024 11:48:06 -0800
X-Google-Sender-Auth: jgxEcvpZMMLoaHbJPIGukUCJFr0
Message-ID: <CAFLszTiibRd0XY-m1L1g78Lydc1tX6PF7Uni1W=bXhYk9z_z=g@mail.gmail.com>
Subject: Re: [PATCH v5 04/23] efi_loader: Show the resulting memory address
 from an alloc
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Janne Grunau <j@jannau.net>, Tom Rini <trini@konsulko.com>, 
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

On Thu, 12 Dec 2024 at 08:48, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 12 Dec 2024 at 17:46, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 12 Dec 2024 at 15:44, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, 11 Dec 2024 at 23:22, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Wed, 11 Dec 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Wed, 11 Dec 2024 at 07:51, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Update efi_allocate_pool_ext() to log the pointer returned from this
> > > > > > > call, which can be helpful when debugging.
> > > > > >
> > > > > > Can you explain how logging the success is helping? I think its pretty
> > > > > > pointless, why not log a failure?
> > > > >
> > > > > It shows the memory address that was allocated.
> > > >
> > > > Sure, but that's not what I asked.
> > >
> > > On failure, the address is undefined, so logging it just adds
> > > confusion. It will likely be a random number.
>
> I mean just report a failure to update. What use can the allocated
> address be of?

Can you please rewrite the patch so I can understand what you are getting at?

>
> Thanks
> /Ilias
> > >
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v3)
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - Show the returned address rather than the pointer
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Use EFI_PRINT() instead of log_debug()
> > > > > > >
> > > > > > >  lib/efi_loader/efi_boottime.c | 4 ++++
> > > > > > >  1 file changed, 4 insertions(+)
> > > > > > >
Applied to sjg/master, thanks!
