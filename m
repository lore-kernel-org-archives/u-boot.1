Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAC3C5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 07:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4760A831BB;
	Wed, 28 May 2025 09:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q1RtXziQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2840831C5; Wed, 28 May 2025 09:35:53 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6349083158
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6049431b409so4812658a12.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 00:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748417751; x=1749022551; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HW+PqhlFklA2Sia7Ze7uBwzS/YOUYj2hRtFCq+pBFU0=;
 b=Q1RtXziQcFs+5Xzoe2sd1cBOqEJA3XjHWSewqbNN/0W4P4lWLrznviW1Z494UXoyiI
 FdoTLfdBas9E0WkxRpd3gWdJ6deXuwjqXiWWHrbSSR1MtZpdG+H3fuBHAgSSH1uApfve
 toS053h7XDFnBHlRov4Bqdde4YHQehRnHjMhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748417751; x=1749022551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HW+PqhlFklA2Sia7Ze7uBwzS/YOUYj2hRtFCq+pBFU0=;
 b=Y/swFRuhpUXbGei8GedP78rqHzFmjA5EXVFB1kdchbEely6cQsTwbb086nbpGruJWE
 4OoM1f9vit6FjZRQ12HLjcysBkEcSi8J6PfSYlxvxHKFqdkFUZbJRsdjNQVGAvRPett7
 2rbedNvt3TLkdbe8TWqcd2cdaDTSzT3xeefALp5h+cnGkNr/k9OPM8dg3IrGh4wj0QS1
 V1k4ozMh8Z/poWIFqtMEEH5o7cIqANppJ89ARYPv89NEe+AEsgNchQ0wtb4JKG+Y6D2e
 ylwQHJLW6RVdcDY7N07nzqBbcRkFpX3pdk5ugJxAlbk7cEAGJZOA7Y3MX1F1eF8vh2Xy
 VnNQ==
X-Gm-Message-State: AOJu0YwStaEKMPgcidDSjFFNyYKCMXYlKTErHJVCQRfnXA9OLxEhr7Oq
 8PrcjDLQjst/tej0OFQukTVUt6sJuvuMCOMYABgaYsEXF+cc7UW6a4Yag2ZLs7Q0Txw9qdm4DJc
 /5ydn3hRZMO+Qb/BcpBeTJs8moB1ncb3j0XD4vcNL
X-Gm-Gg: ASbGncv+JTvhQd/Q04vF0FoSNVzRFhROwRxmpNEoUXazqhyCYmLMPTqw9IxcsOLVEuo
 v/QT8D1G1/Gg9ExgQvMC3+lTYix5mbvDPT+79Q+r4qSe8yAnGkctKwbWlzIgRrXElbYgcsoHZug
 zfe30Z+cslGiVm3FueMaEMgij3KIeBiRs=
X-Google-Smtp-Source: AGHT+IFMdrqA0QU2An76YtDHDLa8egNKfkGLul4NyKuC+DIsOx4KTGRJOikq0n6c+W4gY0lmV3jMSEw7MVV7lqDr7XQ=
X-Received: by 2002:a05:6402:5106:b0:605:2990:a9dc with SMTP id
 4fb4d7f45d1cf-6052990ad3amr449329a12.27.1748417750693; Wed, 28 May 2025
 00:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250524120904.684977-1-sjg@chromium.org>
 <CAC_iWj+XfkWPj+R1JUc0ZPFatRtpMso-Lw+uYzcgcbuKPuV3Dw@mail.gmail.com>
 <CAFLszTho++gscP4rUUY354iyVWFyPkZeMCpa-TpX0GaWOQzQvw@mail.gmail.com>
 <CAC_iWjKjZ-Q_hreO1Z64AFBWXOHB_YB_+Au_9psecVO+ATE_Pw@mail.gmail.com>
In-Reply-To: <CAC_iWjKjZ-Q_hreO1Z64AFBWXOHB_YB_+Au_9psecVO+ATE_Pw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 08:35:37 +0100
X-Gm-Features: AX0GCFvHJghsbb3YhaeTnjULQd06KAsfRqNJfYWb4XsFML3GdKDQGVJS06qyCj0
Message-ID: <CAFLszTi7M335=whLPav5P4+mhunAvs4eue780_eJZNjEG_+YAg@mail.gmail.com>
Subject: Re: [PATCH 0/3] efi_loader: Move the public cerificate back to the
 devicetree
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, 
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>, 
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

Hi Ilias,

On Tue, 27 May 2025 at 10:20, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Tue, 27 May 2025 at 11:20, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Sat, 24 May 2025 at 19:13, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Sat, 24 May 2025 at 15:09, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > A previously rejected patch to move the EFI public cerificate out of the
> > > > devicetree has recently been applied. This series reverts the change,
> > > > pending further discussion as to why it was accepted.
> > >
> > > I spent a good amount of time, writing the commit message an
> > > explaining why this patch was sent
> >
> > Yes, that is [1] and I did read it carefully before sending my series.
> >
> > From my POV there are two things wrong there:
> > - The signature is not an internal U-Boot ABI.
>
> It is, as it is for every firmware that builds out there. EDKII does
> the same thing.

I mean that in U-Boot's case it is a published and documented
interface, or was until a few weeks ago.

>
> >  It is how U-Boot works,
> > so if a build systems wants to inject a key it should use that
> > mechanism, not add a new mechanism into U-Boot's build system. If it
> > would help to have some documentation somewhere which says this, I
> > would be happy to send a patch to add something
> > - QEMU is blocked from accepting devicetree additions due to another
> > Linaro employee's refusal to accept a patch[2]
>
> It's not blocked. It has been NAK'ed and IMHO for a very good reason.
>
> >
> > > (which btw wasn't 'rejected', you
> > > forcefully reverted it back then with no agreements from anyone)
> >
> > The original series [4] was applied (I believe accidentally) against
> > my objections. Heinrich pulled the revert [5]. I went ahead and did
> > the QEMU patch, to help with your issue*.
>
> Heinrich applied the patches initially, and you send the revert, that
> none of the patch reviewers ack'ed.
> You reasoning back then is that the RO functionality was moot, because
> we didn't have it. It's here now.

That was one aspect of my reasoning, but of course we can copy the
signature into protected memory, make the devicetree readonly, etc. if
desired.

>
> >
> > > and
> > > why we prefer to do it this way. tl;dr early boot loaders that pass as
> > > a DT is a problem now.
> > > If there's a good reason to revert it, please explain it on the commit message
> >
> > The reasoning hasn't changed from the discussion three years ago -
> > please see [4]. There's also lots of discussion on your original
> > series and my revert, e.g the cover letter. A highly relevant part of
> > this is that devicetree is where config should be stored, so the build
> > system has control over what is placed there.
> >
> > But in any case, it isn't right to send the series again, under a
> > different name, e.g. not mentioning device tree.
> >
> > [..]
> >
> > Regards,
> > Simon
> >
> > * The QEMU patch is still outstanding after three years. Could you
> > please talk to Peter Maydell and see if you can get this resolved? I
> > have sent it twice since, most recently in April [7] but there was not
> > even a reply.
>
> Because they NAK'ed it a few years ago, and aren't willing to take it.
> I don't think there's anything to discuss and for the record I agree
> with the QEMU maintainers on this.

Yes, I agree that discussion is unlikely to be fruitful. My point
remains though that your series should not have been applied, given
the previous discussion.

This thread and the links should provide context for the future, if needed.

One other thing I forgot for the record is that [8] and [9] are only
needed due to Linaro's refusal to accept the QEMU patch or propose a
convenient alternative.

For now I've applied this series to my tree.

Regards,
Simon

> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20250401112729.2181793-1-ilias.apalodimas@linaro.org/
> > [2] https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
> > [3] https://lore.kernel.org/u-boot/CAPnjgZ2uM=n8Qo-a=DUkx5VW5Bzp5Xy8=Wgmrw8ESqUBK00YJQ@mail.gmail.com/
> > [4] https://patchwork.ozlabs.org/project/uboot/list/?series=253693&state=*&archive=both
> > [5] https://patchwork.ozlabs.org/project/uboot/cover/20210802144431.2396678-1-sjg@chromium.org/
> > [6] https://patchwork.kernel.org/project/qemu-devel/patch/20250405191352.2597585-1-sjg@chromium.org/
> > [7] https://patchwork.kernel.org/project/qemu-devel/patch/20250405191352.2597585-1-sjg@chromium.org/
[8] https://lore.kernel.org/u-boot/20250510134253.1581164-2-sjg@chromium.org/
[9] https://docs.u-boot.org/en/latest/develop/devicetree/dt_qemu.html
