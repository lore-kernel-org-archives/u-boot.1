Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1888C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4B8187730;
	Thu, 30 Nov 2023 21:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VpQOoFdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D11E08771B; Thu, 30 Nov 2023 21:30:41 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C683787713
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a185fb3aa18so223082666b.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701376239; x=1701981039; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0ze3g+KbzqGj36cXK4KXcn2SJ1PO+nJAvkG+kKo7vKI=;
 b=VpQOoFdSRPVUx3sqNFijt5JW/fbyl/Zs0mkegEq8OnPohN9sAXus+giE7ElLEZN4/Q
 iG88YutPEkpz3YKj78RpOOJn9ulhacI8paUUFoHuUjzMMwfmZJJyfYcJ71eAqj9Ka10p
 MwbvonEWFzP3zL/5TybGgfVUkE8vlS8/nzvKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701376239; x=1701981039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ze3g+KbzqGj36cXK4KXcn2SJ1PO+nJAvkG+kKo7vKI=;
 b=qskr+4fkUFw5T+N37C0ygYqGTZtWSce0iz2cPhMuLQFwk+8yY/VR4HFgfzg4UIWTgB
 AVq7wREg+5Ubdh3Nsz84MEV7JHGdGyKZIGLovXEyRCXNZPtQIYjkIf2uKEdrjNfjNS7M
 mOHZO8G0ZeWucm8DJjQ/UAk1gsoXNcfV3QmJe7cy7Z2rztr5DvlzVK/RK8KdtBa+mxOw
 VZ3skeL4ZNSiv49uxGK4aoi8MXUo62bYqHoJCELVq1MP1XVBxvwTMS4zl3ppeIHNaxmj
 B5gtKkMAFaBsa4syvR7O5XEJIR+AbtMtdf5h9mhFJHTFJ5Tk2EdjlZGhXK9ez8CQAmG/
 NRyw==
X-Gm-Message-State: AOJu0Yyz+otsKIzwkr+Bz2GSK/Wtk9pFm/3nbOI1f7pD+4isLgl4MjHx
 0JXMuei84PegXvFPS8YF8R3sU+P7YodSvoLZeZHI9Q==
X-Google-Smtp-Source: AGHT+IF7hBJgyxS2nGwZC6cEyBKE+/ypnjV3+LlsjScXh8z5XtFWXqn22t4Iova8UzN/R3amZDfO6UlKdgPktSBI1UI=
X-Received: by 2002:a17:906:20d7:b0:a19:a409:37e3 with SMTP id
 c23-20020a17090620d700b00a19a40937e3mr151524ejc.60.1701376238996; Thu, 30 Nov
 2023 12:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
 <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
 <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de>
 <CAPnjgZ0UCkm5QCx+JXe1ggSshozPnOLB6cN=UoJyMn6S4wfFkg@mail.gmail.com>
 <06281f7c-e0f2-405c-95a9-0f7e9e84a7f6@pengutronix.de>
 <CAPnjgZ2TT+0BvbjwfnGLQ3EPEXnLW6f1epiFdaBHRYaSAn5xsA@mail.gmail.com>
 <8fbc81b1-31ab-46b0-87f4-b8bd8e8e2b47@pengutronix.de>
In-Reply-To: <8fbc81b1-31ab-46b0-87f4-b8bd8e8e2b47@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Nov 2023 13:30:21 -0700
Message-ID: <CAPnjgZ1iyxk0bb56QR10N5aSphRYhLsw7Ly=z2i6rQCxP_AYPw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, 
 Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 lkml <linux-kernel@vger.kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Terrell <terrelln@fb.com>, Nicolas Schier <nicolas@fjasle.eu>,
 Will Deacon <will@kernel.org>, 
 linux-kbuild@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
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

Hi Ahmad,

On Wed, 29 Nov 2023 at 12:54, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Simon,
>
> On 29.11.23 20:44, Simon Glass wrote:
> > Hi Ahmad,
> >
> > On Wed, 29 Nov 2023 at 12:33, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>
> >> On 29.11.23 20:27, Simon Glass wrote:
> >>> On Wed, 29 Nov 2023 at 12:15, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>> On 29.11.23 20:02, Simon Glass wrote:
> >>>>> On Wed, 29 Nov 2023 at 11:59, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>>>> The specification says that this is the root U-Boot compatible,
> >>>>>> which I presume to mean the top-level compatible, which makes sense to me.
> >>>>>>
> >>>>>> The code here though adds all compatible strings from the device tree though,
> >>>>>> is this intended?
> >>>>>
> >>>>> Yes, since it saves needing to read in each DT just to get the
> >>>>> compatible stringlist.
> >>>>
> >>>> The spec reads as if only one string (root) is supposed to be in the list.
> >>>> The script adds all compatibles though. This is not really useful as a bootloader
> >>>> that's compatible with e.g. fsl,imx8mm would just take the first device tree
> >>>> with that SoC, which is most likely to be wrong. It would be better to just
> >>>> specify the top-level compatible, so the bootloader fails instead of taking
> >>>> the first DT it finds.
> >>>
> >>> We do need to have a list, since we have to support different board revs, etc.
> >>
> >> Can you give me an example? The way I see it, a bootloader with
> >> compatible "vendor,board" and a FIT with configuration with compatibles:
> >>
> >>   "vendor,board-rev-a", "vendor,board"
> >>   "vendor,board-rev-b", "vendor,board"
> >>
> >> would just result in the bootloader booting the first configuration, even if
> >> the device is actually rev-b.
> >
> > You need to find the best match, not just any match. This is
> > documented in the function comment for fit_conf_find_compat().
>
> In my above example, both configuration are equally good.
> Can you give me an example where it makes sense to have multiple
> compatibles automatically extracted from the device tree compatible?
>
> The way I see it having more than one compatible here just has
> downsides.

I don't have an example to hand, but this is the required mechanism of
FIT. This feature has been in place for many years and is used by
ChromeOS, at least.

>
> >> The configuration already has a compatible entry. What extra use is the compatible
> >> entry in the FDT node?
> >
> > It allows seeing the compatible stringlist without having to read the
> > FDT itself. I don't believe it is necessary though, so long as we are
> > scanning the configurations and not the FDT nodes.
>
> I think it's better to drop this if it has no use.

OK. I cannot think of a use for it.

Regards,
Simon
