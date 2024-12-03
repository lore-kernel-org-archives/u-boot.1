Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B0FE64AA6
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6D8089651;
	Tue,  3 Dec 2024 14:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NA6fQQct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A077D89588; Tue,  3 Dec 2024 14:46:42 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 884E28967A
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa503cced42so815324166b.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733233599; x=1733838399; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q2WzdJ7C0mylNQHix4c2X0a0jQ6wCeQGTR3qa7bv5Ds=;
 b=NA6fQQctqs1thOqrP05Rg/yUedeUEaameXkfLAHC8MeqFSF8+c89YdRPtoOC9hPzKb
 UQth9tCABh4T8/niaK8yxWwM/sFPpvh8Yo3dCibTRf2PxJqtIxXpLaLVPdoOB3o4BbLE
 5UKOHZd4xeftT3HQzI0jt7ZWuCqMje8MLpzMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733233599; x=1733838399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q2WzdJ7C0mylNQHix4c2X0a0jQ6wCeQGTR3qa7bv5Ds=;
 b=Zf57f+tbeZic3mH4aySi+nIidKjBeZuXTkzrwW1m2urROLF8yUaRGyiQrxTvzVZtW4
 73xArjGwKqh/z19W9h7Z4KiOAcBx/OLI1H0VQdFXAbnAR2EBwkgvGOYlPoy25lYZbDkn
 Uw8Q0myU6MFYj84rDwjECzY1ByKO3Iw+f1WNvbDxUVSuSTmQ6Rk8h+t9IQFHa/BML+go
 Q8sXWBtSLGxa1r1OZyvOdLKfic/TFPutWaNupCNKQAVTRVDmw2wro/whXjIoCz7piEV2
 NsdOq5IRJr/HF1ml40FFC8xeZhWQiEOQft6WwUnlO5GRCBVUKqOuJHAs0Noo44DWzrlI
 PUEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5H0G/x0SFYKSr5V7HJaQcXnk3wLM1m289ZsJRxc3hqqXqjbzhpZ3BzWBtq/bzsxAiNj9W10U=@lists.denx.de
X-Gm-Message-State: AOJu0YyXlPepJRadOO8q0O7h/Me95aUKazEStG5C+UrBs6pVXs3jmJc4
 eTC847A2OfN2eCJyT5ZcpmSs9B4vRVRWn/Kn8sLCp11jXTvE70cCfDE/zCSwqC7UVOwQGvEHKfg
 VnCEgX1valTQQe5+yvz2UqM7iODak6Kl6uKwO
X-Gm-Gg: ASbGnctSWFfSlbDWVPXAorQSJTkarDOPL8xmbO0KepZnDDnVSmSOrklfMgXHazpEjqP
 WA+rJlidh1KshpoOlBnd9bzlof1tAKrdN
X-Google-Smtp-Source: AGHT+IHoyeRkgp7S6aPSD/zdHx+8d2B72PM2pFotKmW/ZQBSAG/VJaFgY2GA5zaK0C3wP4J0Zj0sVQTzPOO+9BBuH8o=
X-Received: by 2002:a17:906:2921:b0:aa5:2c60:a6c8 with SMTP id
 a640c23a62f3a-aa5f7d6677fmr177477866b.22.1733233599066; Tue, 03 Dec 2024
 05:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-5-sjg@chromium.org>
 <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
 <20241202162239.GE2457179@bill-the-cat>
 <CAFLszTjvnyE4vFQ=Z=Ma1bOjH_Z4JEdUWM51Vc_nRmSUkRzF4Q@mail.gmail.com>
 <20241203005541.GP2457179@bill-the-cat>
In-Reply-To: <20241203005541.GP2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 06:46:27 -0700
Message-ID: <CAFLszTi6koMMr0ggVLxKQK5LCBv+hCunewacBxDAZYH+rERGiw@mail.gmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>
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

On Mon, 2 Dec 2024 at 17:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 02, 2024 at 05:22:35PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 2 Dec 2024 at 09:22, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Dec 02, 2024 at 09:26:42AM -0500, Raymond Mao wrote:
> > > > Hi Simon,
> > > >
> > > > On Sun, 1 Dec 2024 at 09:43, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > > This stops coral, bob and kevin from booting.
> > > > >
> > > > > The correct way to do this was always to use a Kconfig option, so let's
> > > > > first revert this broken idea.
> > > > >
> > > > > OF_BOARD and BLOBLIST should be general and hardware agnostic,
> > > > do you have more information on why they don't work for a few boards?
> > > > Maybe the way to handle these logic within certain boards should be
> > > > changed other than to revert this?
> > >
> > > Yes, I'd like to understand the whole problem better since we had a
> > > forever-and-ever thread, compromised to what's in tree now and now you
> > > want to revert the compromise and bring is back to what was argued
> > > against for forever-and-ever, at least from a very quick read.
> >
> > I'm sorry but I believe I have explained the problem in that forever
> > and-ever thread, so I don't really want to re-run it. It may be that I
> > was right all along?
>
> Or maybe your use case is still badly explained, and your changes will
> instead break other platforms.
>
> > Raymond, I cannot pass the DT in the bloblist from TPL to SPL on x86.
> > There is not enough cache-as-RAM, for a start. Plus the DT is in the
> > memory-mapped SPI flash, so it makes no sense...
>
> DT using x86 is a pretty odd case. I don't recall if you mentioned that
> before, and it's likely everyone else assumed you were talking about
> something more standard. Of course, you're listing one x86 platform and
> two ARM platforms as needing this change. Non-chromebook Rockchip isn't
> generally broken (or several other people would be complaining).
>
> So something that may or may not be explained in the longer older
> threads is how the firmware in these platforms are doing anything with
> the device tree?
>
> But, the biggest problem I see with this portion of the series is that
> patch #4 is 'Revert "fdt: Allow the devicetree to come from a bloblist"'
> and patch #5 is "fdt: Allow the devicetree to come from a bloblist".
> What you need to do instead is squash all 3 of these in to one commit
> and then write a new message that explains what exactly you are
> changing, and why, instead of making someone else do that in order to
> review  your changes here.

As I said, I do not wish to go through all of that again. It is still
a bad memory every though it was a year ago. I would like to build on
what I have here, to resolve any future breakages.

Regards,
SImon
