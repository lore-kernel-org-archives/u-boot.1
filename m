Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E74EC07E97
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 19:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 949CC86BF7;
	Wed, 29 Nov 2023 20:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PguQYQNf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E07486E88; Wed, 29 Nov 2023 20:44:44 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E02886BFA
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 20:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a03a900956dso26215966b.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 11:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701287081; x=1701891881; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qnqDzHz4INacq1KvdtyKE0oHpbQHSFD4sKrps3p8dnw=;
 b=PguQYQNfLlJnABxBjv78JFF08UmhIuVenQR5Aj6LA6LBfmhtZ61RnMjr6V/eJw0+Ip
 qXrULLAZPMuNLdAm1ykEZEN8qHuw9yZE1aOZyVy5uTRia99p/o2OQCxiOfCbMUmJf1/f
 lTCw7KpEdSjdtLP0PdOdYVJq7K6KKNXOBYnRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701287081; x=1701891881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qnqDzHz4INacq1KvdtyKE0oHpbQHSFD4sKrps3p8dnw=;
 b=dY1c8nRD8mz6h5wrw4sGmD6zUduX+A3nwXJ78gVBhVfs7b/bLFXM1PJ6sIwlSuX3ez
 usOygvdU5BpRpuPCTyRQj0pybH82S6VZByLa1Yg6UmZUajKcovigIKIeuzlzda8rpf0x
 1Oh5zQGIt+G9etz5DTzfwi86vzWsg5w1w4jGWkpgSAoPuLxP1Tdog0XfellMD1mkGN+s
 015Gmk5Pvbqh5ppzJl2rSLtxIIxay888dTzny0EcgFiUmQ8sfeKG0VTMYqehuMo0BYjD
 MPy+oBqsXzO/dhXewufF8ibxPMHKkzJLn10PiitRJ2N7csdVqevYT+Yz+EnrtEVm/gwA
 ybPQ==
X-Gm-Message-State: AOJu0YwahrbRJ0jT95TmT//GlbsVDV2jkO7eTaPVlgltHpNtWZspUI/3
 0vAlL1RXvegagrX7GXbWlpvidDwW6bhhQMctSdbsHCIk9Ptaz3LD5q4/7g==
X-Google-Smtp-Source: AGHT+IE6/sJe2xAn+cU+B0tf6CKENoUuHsXD0ZZK1FLCMTWZCVk2aryXnmPQVK+Mqb2N+AK5h9Dj5uGpcs1SpVI/Rug=
X-Received: by 2002:a17:906:105c:b0:9ae:659f:4d2f with SMTP id
 j28-20020a170906105c00b009ae659f4d2fmr18732284ejj.26.1701287081372; Wed, 29
 Nov 2023 11:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
 <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
 <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de>
 <CAPnjgZ0UCkm5QCx+JXe1ggSshozPnOLB6cN=UoJyMn6S4wfFkg@mail.gmail.com>
 <06281f7c-e0f2-405c-95a9-0f7e9e84a7f6@pengutronix.de>
In-Reply-To: <06281f7c-e0f2-405c-95a9-0f7e9e84a7f6@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 12:44:25 -0700
Message-ID: <CAPnjgZ2TT+0BvbjwfnGLQ3EPEXnLW6f1epiFdaBHRYaSAn5xsA@mail.gmail.com>
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

On Wed, 29 Nov 2023 at 12:33, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> On 29.11.23 20:27, Simon Glass wrote:
> > On Wed, 29 Nov 2023 at 12:15, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >> On 29.11.23 20:02, Simon Glass wrote:
> >>> On Wed, 29 Nov 2023 at 11:59, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>> The specification says that this is the root U-Boot compatible,
> >>>> which I presume to mean the top-level compatible, which makes sense to me.
> >>>>
> >>>> The code here though adds all compatible strings from the device tree though,
> >>>> is this intended?
> >>>
> >>> Yes, since it saves needing to read in each DT just to get the
> >>> compatible stringlist.
> >>
> >> The spec reads as if only one string (root) is supposed to be in the list.
> >> The script adds all compatibles though. This is not really useful as a bootloader
> >> that's compatible with e.g. fsl,imx8mm would just take the first device tree
> >> with that SoC, which is most likely to be wrong. It would be better to just
> >> specify the top-level compatible, so the bootloader fails instead of taking
> >> the first DT it finds.
> >
> > We do need to have a list, since we have to support different board revs, etc.
>
> Can you give me an example? The way I see it, a bootloader with
> compatible "vendor,board" and a FIT with configuration with compatibles:
>
>   "vendor,board-rev-a", "vendor,board"
>   "vendor,board-rev-b", "vendor,board"
>
> would just result in the bootloader booting the first configuration, even if
> the device is actually rev-b.

You need to find the best match, not just any match. This is
documented in the function comment for fit_conf_find_compat().

>
>
> >>>>> +        fsw.property_string('description', model)
> >>>>> +        fsw.property_string('type', 'flat_dt')
> >>>>> +        fsw.property_string('arch', arch)
> >>>>> +        fsw.property_string('compression', compress)
> >>>>> +        fsw.property('compatible', bytes(compat))
> >>>>
> >>>> I think I've never seen a compatible for a fdt node before.
> >>>> What use does this serve?
> >>>
> >>> It indicates the machine that the DT is for.
> >>
> >> Who makes use of this information?
> >
> > U-Boot uses it, I believe. There is an optimisation to use this
> > instead of reading the DT itself.
>
> The configuration already has a compatible entry. What extra use is the compatible
> entry in the FDT node?

It allows seeing the compatible stringlist without having to read the
FDT itself. I don't believe it is necessary though, so long as we are
scanning the configurations and not the FDT nodes.

Regards,
Simon
