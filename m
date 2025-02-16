Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC2FC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 19:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796468056A;
	Sun, 16 Feb 2025 20:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HFyEK3UX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 075FD807E1; Sun, 16 Feb 2025 20:39:24 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F6980104
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 20:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-abb79af88afso204591366b.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 11:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739734760; x=1740339560; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+j4hP4wsO/VL+xLKw6IK+Ay0wyhVUi5WUO6n92U3nJA=;
 b=HFyEK3UXoaDQVY9FCig0OIC0MzbCDCFg/PMo7Pinkx0KvZmeED2zPsCm0dDx1pEK9u
 tT4QTYvGUbBfHA+MSDENBvGjDqU6UYIGbyZ2OCpvnuHvjVaFS4EnwNShWiPo5zMTARwT
 FTBXbqZALx9BxXkyXWxYbH/5aEXWhzdmtwWcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739734760; x=1740339560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+j4hP4wsO/VL+xLKw6IK+Ay0wyhVUi5WUO6n92U3nJA=;
 b=MrELz2ECAzRWwqGApSbRQA3blb7IQ6K73MyjJe4eqGuKX0LRU1o0870XOw2I9SuC4S
 zIxFnXo4zIVzo8erOVl5Kg78d0UcgBfFpn6w9cdHqiPfXFQmOwgLc1Qh/JhjBiGa3whp
 EVJdnqxBO7NIK7yaG4mDcQn3yfQHk47UobldqKEqtF5AkiyhZRm5LuSZ8z/iPfBTrtt8
 cy/3E2KXOBE2/HBNq3SKckkgEMhR0SLtx10cTxe9ifbKd/OHuUm8wZU09nl642NFpByz
 JdXVMSPkEj46ykbeUhUII/ywBf20l8aFfZTsnpIQGrrB/Uydmd16bwQilaGURfTwCPCp
 Mmcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN0C9M64RvO3Oqer7Yshq3SR8psU5KqDnkgHlG8knr+L+99GzIFUjOo+osOxILhJo9vbMflOc=@lists.denx.de
X-Gm-Message-State: AOJu0YwQgWSpDFnwfthyPa1h45kvlyeBq0J1W5nHAlAmH+Ew6jyyom2y
 4D2jdvg6fvMC7r0bu4IKbBTrkJBpptjHHEzt+VEsGlBzodrcg3kGhYLyR88MgfKbT6whoB83X7t
 CBqHpab90oZOVdQSP9KA8fqqF4hWtNVNLbJPe
X-Gm-Gg: ASbGncubyQSqC761sb29hnK7ffseEGZiGevwJ5JwoZ64pW3x52u6/oveewrRcR/MJYY
 B29O8rulnJWhcSMZt98zT3m6+mEvOLKwbZ8pVF7mQMx13NhQLpoQi7illwMe94nHPJhUb9ycNGQ
 ==
X-Google-Smtp-Source: AGHT+IFWt94YM07rt38l95Jhx5nLoWuimswC34fO+3ZWmiY5DHtKXirfvhp3k99Fq++58MNDU2R4IXGeCja4CGCSKXo=
X-Received: by 2002:a17:907:1c9c:b0:abb:6259:477e with SMTP id
 a640c23a62f3a-abb70e62d74mr769369966b.55.1739734760482; Sun, 16 Feb 2025
 11:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20241112131830.576864-1-sjg@chromium.org>
 <CADg8p96cKqSEmZWLaOV1-onUwT4uwBp11=t4K7tmmPwZ-6UvXw@mail.gmail.com>
 <CAFLszTjw8ihHESoDk0RE6+00idN4Y-7=72NbUp+yOqpyCYqexQ@mail.gmail.com>
 <CADg8p97KQskghmGR+mv-AUVSAyCJ02DRzCbfHsZjGfEYbb+skQ@mail.gmail.com>
 <CAFLszTj+sxM+RrCvqq5i9_pOqjajm1V2U=egEfGS9nAfo76BSA@mail.gmail.com>
 <20250216150358.GY1233568@bill-the-cat>
In-Reply-To: <20250216150358.GY1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 12:39:08 -0700
X-Gm-Features: AWEUYZn7IoPOaXv3bykgSThSm4biuptRGZ7y6fGHtEDawkeutVSTFEnbLTALIDI
Message-ID: <CAFLszTigCGFTkJWNPdZjRo6AEyAYKdHUjA-tzXKjU4x3zFBq2A@mail.gmail.com>
Subject: Re: [PATCH] Revert "efi_memory: do not add U-Boot memory to the
 memory map"
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Hi Tom,

On Sun, 16 Feb 2025 at 08:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 16, 2025 at 07:50:48AM -0700, Simon Glass wrote:
> > Hi Sughosh,
> >
> > On Wed, 27 Nov 2024 at 04:48, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Tue, 26 Nov 2024 at 21:09, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Thu, 21 Nov 2024 at 00:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > On Tue, 12 Nov 2024 at 18:48, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted in this
> > > > > > patch. I am not sure how to investigate it.
> > > > > >
> > > > > > The boot hangs at some point during booting of the install image, before
> > > > > > the Ubuntu logo appears.
> > > > > >
> > > > > > I will sent a series with a script showing how it is run.
> > > > > >
> > > > > > This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > >
> > > > > I did some digging into this issue, and it turns out that the revert
> > > > > is only masking the real issue. What this revert does is mark the
> > > > > memory region occupied by U-Boot as EFI_BOOT_SERVICES_CODE. The x86
> > > > > kernel seems to mark memory regions other than
> > > > > EFI_{BOOT,RUNTIME}_SERVICES_CODE as not executable -- and this is
> > > > > precisely why this crash shows up only on x86. The actual cause of
> > > > > this issue is in the efi runtime functionality of U-Boot. The kernel
> > > > > is calling the SetVirtualAddressMap() runtime service function, and
> > > > > that seems to be calling some of the boot service code of U-Boot,
> > > > > which it shouldn't. We do not get the crash after disabling the
> > > > > ConvertPointer() and SetVirtualAddressMap() runtime functions.
> > > >
> > > > OK, so what is the solution here? Did you send a patch?
> > >
> > > I am trying to check if the installation can be done by disabling the
> > > ConvertPointer() and SetVirtualAddressMap() runtime service calls. If
> > > so, then I will send a patch which disables them temporarily till the
> > > actual issue is triaged and fixed. If the installation does not work
> > > without these runtime calls, I would say putting this change in with
> > > an explanation of what is happening (similar to the above
> > > explanation). Please give me some more days, and I will let you know.
> > > Thanks.
> >
> > I forgot what happened with this. Could you update this thread, please?
>
> After much further investigation to understand why the revert worked,
> the revert was applied with a different commit message.

OK, thanks.

I have found another problem in that it breaks sandbox (bootflow_efi
test) when it calls exit-boot-services. But you have not applied that
series[1] so we can wait to see if you hit that problem in general
usage. Hopefully not!

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=439021
