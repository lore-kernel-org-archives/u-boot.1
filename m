Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02122C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F4E810F4;
	Sat, 29 Mar 2025 00:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e/uc6GN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12FA0805C8; Sat, 29 Mar 2025 00:41:35 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F3DD81E3E
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:41:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac73723b2d5so70963366b.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743205292; x=1743810092; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/8otBMsN85jvEtDGv7+zkVMk6HV2u0hJ9ed38umM/m4=;
 b=e/uc6GN72z9laxVMmUJWhFiwKfIvxoOEtflCPYihmRMDpJgEqQg0ofIpiArPwwcFMr
 +VoSC9MeG6I7Epg2INNDPHGVEZI7IiuoZhSUbXFm1WCPsgYgx+39IhLKxP7WNbpox8u4
 SFP5XIRAGtksBMRZUO3esuHQcyIbFQgaFHf94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205292; x=1743810092;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/8otBMsN85jvEtDGv7+zkVMk6HV2u0hJ9ed38umM/m4=;
 b=jfnG+54Z5BZHS8h0F+kpvcNfyr98lgGoOGee3K+F69to88cmCKtB1KNsWyh8ssWP1h
 8M0L7K7q1PcUdwtlF3HKdhp09dDDcqDclWSREcG+95mImRLp6LYqRgcaLtfbJmlpMBG+
 VghMxcm49XnhMdbGA7nr6jXLKENIn9rzExtziRNEiN4WVwMDCm5NWtN3negYFWmfXvbt
 pj3GnWXs+dKJ4lXAmc+6Pln9HkKzqN6h3iYsL9AUW1iio50pQ4pZR51LH8qs2GtiSQuG
 d8q0EbiWBiXudt+/FrJ4GGNMRoxuJshzmxIMsTw/8BxjXopGg0FgYOOtS8n+0eRn70t/
 CdFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRdOA3MCjGPjeG6PW4iCEr5otBnkCyuwUNLTNUKyZi1Zlt7sf2CK4yeXdmlLPEgVXHAL1REzE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywjf+OqNK9nyA00xBA2/Dxcrni7z291i6Ifx6hsLP0lwe3/sn3u
 Sq57Ua/ttgpDDMGnl/BUOQD3m15ZhPpASOCk+AyN5kCkEWymtSRs/X7obpWqFTVH9ENcZzsvvpk
 KGwZXEZ2UPaWzHNHbEVmye3Z0TUOgHTIWwmit
X-Gm-Gg: ASbGncs4lpBcBBCnEYKa0+APCXmEonBQP8Tpk48FTrDfXF4cez+61vdAzYbCvHeFuY8
 0whs/BIXX3xwGsXIEVPKk6BzX+c3TSb3yDr/R0jMLESweTz5yeDqQKOP4eUYSqRzRJ6rk+cgMpn
 CDVOCh6kUfd4oClMjIpIkiZjAH5uG/osM3U99a8g==
X-Google-Smtp-Source: AGHT+IH1WVK/e/iBmARGNX1O1o1DNYTkaDAoj/yLkkXtiBs4hLEH3jXBgCbveqnw5VwUaiQxKRnuCd2YZwt4XtFbwDY=
X-Received: by 2002:a17:907:2d87:b0:ac6:b816:454f with SMTP id
 a640c23a62f3a-ac738c242e3mr77208366b.54.1743205291889; Fri, 28 Mar 2025
 16:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
 <20250318140400.GX2640854@bill-the-cat>
 <CAFLszTgCZSydxeNoeVGrR9SF7-_9pZjU+NBGXVDgXG6WzYyCYA@mail.gmail.com>
 <20250318155256.GA2640854@bill-the-cat>
 <CAFLszTjC47nk3FmEyHw13zaaWwdcEavk3JY5iewKWF65iVqHiA@mail.gmail.com>
 <20250319154047.GM2640854@bill-the-cat>
 <CAFLszThVHKU+nZhmp5ysNxqTnLJ8AMX8E8eO2zvBhDQTZ5LYNw@mail.gmail.com>
 <20250320142240.GR2640854@bill-the-cat>
 <CAFLszTjG1pvSEV-ET+M0S4bV6biJBcS-ZodVOMhuJU7qL7PZ2g@mail.gmail.com>
 <20250328162958.GD93000@bill-the-cat>
In-Reply-To: <20250328162958.GD93000@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 23:41:18 +0000
X-Gm-Features: AQ5f1JptY2-DkXAbSQy6NjyVWu0K8E-tFISRHUiCxzR9_mW3oQLtbGk9YD-rIz8
Message-ID: <CAFLszTivtsJUtmrLE7A6auy0GPQwW+BRRF_WADMNjVoTqe5X9A@mail.gmail.com>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Tom,

On Fri, 28 Mar 2025 at 10:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 21, 2025 at 07:38:27PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 20 Mar 2025 at 15:22, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Mar 20, 2025 at 03:43:36AM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 19 Mar 2025 at 16:40, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Mar 19, 2025 at 03:03:49PM +0000, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 18 Mar 2025 at 16:53, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Tue, Mar 18, 2025 at 03:24:02PM +0000, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 18 Mar 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > Any 'bootable' flag in a DOS partition causes boostd to only scan
> > > > > > > > > > bootable partitions for that media. This can mean that extlinux.conf
> > > > > > > > > > files on the root disk are missed.
> > > > > > > > > >
> > > > > > > > > > Put this logic behind a flag and update the documentation.
> > > > > > > > > >
> > > > > > > > > > For now, the flag is enabled, to preserve existing behaviour. Future
> > > > > > > > > > work may provide a command (or some other mechanism) to control this.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > >
> > > > > > > > > Isn't this backwards as the existing behavior (prior to bootstd) was to
> > > > > > > > > scan and use these files, and so that's the behavior we need to preserve
> > > > > > > > > by default.
> > > > > > > >
> > > > > > > > Not so far as I know, but I've already spent too much time trying to
> > > > > > > > decode those scripts.
> > > > > > > >
> > > > > > > > If you look at scan_dev_for_boot_part, that is what I was trying to
> > > > > > > > replicate with bootstd.
> > > > > > >
> > > > > > > The feedback from the community call where this was brought up was that
> > > > > > > it used to work and now didn't, I thought. Heinrich, I think you had one
> > > > > > > of the cases here (something about RISC-V and multiple distros?) or am I
> > > > > > > misremembering?
> > > > > >
> > > > > > OK let's see if Heinrich chimes in.
> > > > > >
> > > > > > Are there notes for the call? It would help me if they could all be in
> > > > > > a shared document, like we used to use[1].
> > > > >
> > > > > Yes, they're in email.
> > > >
> > > > What subject should I search for to find them? I looked for 'community
> > > > call' and a few other things, but cannot find them.
> > >
> > > They're in reply to every announcement email and sent to all three
> > > lists.
> >
> > OK, well I can't find them, sorry. I did see the first one you sent
> > but after that I have no record.
> >
> > It sounds like you don't want them in a doc for easy reference?
>
> I don't want them hidden away in some document, I want them easily
> accessible.
> https://lore.kernel.org/u-boot/20250128171923.GQ1233568@bill-the-cat/
> https://lore.kernel.org/u-boot/20250211204927.GF1233568@bill-the-cat/
> https://lore.kernel.org/u-boot/20250225191031.GS1233568@bill-the-cat/
> https://lore.kernel.org/u-boot/20250311203117.GV2640854@bill-the-cat/
>
> All of which are in reply to the announcement email for the release.

OK thanks, I see it now. I need to search for '[ann]' not 'community meeting'.

I've copied them into the doc as I find it a bit easier to keep track
of. So much email.

Regards,
Simon

>
> --
> Tom
