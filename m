Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C51CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF1786308;
	Fri,  1 Sep 2023 03:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BoJpt4AQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A63986308; Fri,  1 Sep 2023 03:10:43 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A112866AA
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-500913779f5so2739857e87.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530632; x=1694135432; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9bEZ6oach9EUwqNCCdmgV9v3ZdS2I/938BHgbJ4Fn5k=;
 b=BoJpt4AQjK1+PbYpYU5hJiCob4LNXAnaqFsVMYrr3cfCn5p2upzpmJeLdvXH+2mEDa
 Uz3E2I6tmeqkW65xZWF0cjXpwN203U5uckPl4mfkOXn+ui0HaSaVGuXtsLpgAsf+nV2L
 Ujdtdk/dpdWSGhTEAgiG7h4uMacdme0mSgv6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530632; x=1694135432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9bEZ6oach9EUwqNCCdmgV9v3ZdS2I/938BHgbJ4Fn5k=;
 b=GxBc/YI+5DSwxaPwLU2f8Vo1YVVf5N9l7qYHOIvNCrY18AvgJwMrg8ZisYHmIEm8ou
 k/2W49QUJoX6n30G7IKpSgH55mp2+UDkVGEUA2ILx/LQGtQcahkAS/AlPoQe1c8I9su0
 L2pw5qzaLx3fmXzJ/LzL8z754L75SbEgFe62KBAAwoQKN3E5uzwlKvZoIwDasNR1tmrQ
 pg03bPA0rc0WqWz8v0kjcsa/DBfBnq4zTBvwJtcagEc0+rfh2jSLD85L8wF/uvBkwoGu
 ggiFAVunovCaHlR/rhfWbuxSSIfIQYgg+86rU90lH5mMaxGu6bvTmzUxjv6xg9VVlAQ1
 L6iA==
X-Gm-Message-State: AOJu0YwYCBC/HjnFIS//yhAFdg6bQ4HfdxFVLXvQjKHkDfJ4WDHwWAv5
 vCsF1Jx30ezCkAu1iPBdLsLTMKYn6Uu5gGA/LxCRdQ==
X-Google-Smtp-Source: AGHT+IF/tWPMTmBgEq9kIppBhzrh8/M+y8VgNUidFdliCya57r7x8S6TXlSv0zcZgsB0BGAfPiwOvngqYJ9+8Tacfqs=
X-Received: by 2002:a05:6512:2005:b0:500:b8bc:bd9a with SMTP id
 a5-20020a056512200500b00500b8bcbd9amr486868lfb.49.1693530632259; Thu, 31 Aug
 2023 18:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230824030304.1555547-1-sjg@chromium.org>
 <40d6d839-6eaf-4950-bf37-aaad0f2d5e03@gmail.com>
 <CAPnjgZ3ejchoWij6C80nVMVr5iOag3Zazf7O_g_yYcw1U_f+cQ@mail.gmail.com>
 <d4ce17ae-8b84-4c8a-acaa-287549ec23a3@gmail.com>
 <CAPnjgZ0sTAoZi5TDAaTZUNPVNQ5dqoyVENDWJr=exa5z2R8srw@mail.gmail.com>
 <20230831190709.GO3101304@bill-the-cat>
 <CAPnjgZ0JtmKhY9t_gArwjRO2=qbZsUXDhMcra4mBqBiQmcbWBg@mail.gmail.com>
 <20230831192430.GP3101304@bill-the-cat>
In-Reply-To: <20230831192430.GP3101304@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 19:10:20 -0600
Message-ID: <CAPnjgZ1OSu_=Wk_BtRGC+1pxcGVVED1OqCuKh9cAvWVzhyisag@mail.gmail.com>
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
To: Tom Rini <trini@konsulko.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dillon Min <dillon.minfei@gmail.com>, 
 Ivan Mikhaylov <fr0st61te@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kamil Lulko <kamil.lulko@gmail.com>, Marek Vasut <marex@denx.de>,
 Michael Walle <michael@walle.cc>, Neha Malcom Francis <n-francis@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, 31 Aug 2023 at 13:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 31, 2023 at 01:22:13PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 31 Aug 2023 at 13:07, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Aug 31, 2023 at 01:01:59PM -0600, Simon Glass wrote:
> > > > Hi Alper,
> > > >
> > > > On Thu, 31 Aug 2023 at 04:20, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> > > > >
> > > > > On 2023-08-28 20:54 +03:00, Simon Glass wrote:
> > > > > > Hi Alper,
> > > > > >
> > > > > > On Sun, 27 Aug 2023 at 13:17, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> > > > > >>
> > > > > >> On 2023-08-24 06:02 +03:00, Simon Glass wrote:
> > > > > >>> In this early stage of using binman to produce output files, we are mostly
> > > > > >>> seeing people using common extensions such as '.bin' and '.rom'
> > > > > >>>
> > > > > >>> But unusual extensions appear in some places.
> > > > > >>>
> > > > > >>> We would like 'buildman -k' to keep the build outputs, but this is hard if
> > > > > >>> there is no consistency as to the extension used.
> > > > > >>>
> > > > > >>> This series adjusts binman to enforce just 4 extensions for output images:
> > > > > >>>
> > > > > >>>    .bin
> > > > > >>>    .rom
> > > > > >>>    .itb
> > > > > >>>    .img
> > > > > >>>
> > > > > >>> Other extensions will produce an error. With this rule observed, buildman
> > > > > >>> can keep the required files.
> > > > > >>
> > > > > >> I dislike this limitation. We know what files we will generate, they are
> > > > > >> listed in binman dtb, so we can add something like `binman build --ls`
> > > > > >> to print their names/paths for buildman to preserve them.
> > > > > >
> > > > > > Yes, it would be good to have that...
> > > > > >
> > > > > > But why do you dislike the limitation? Do you think extensions provide
> > > > > > useful information? I suppose one problem is that *.bin might pick up
> > > > > > private blobs that happen to be in the source directory?
> > > > >
> > > > > I guess my strongest argument is that people already/will have workflows
> > > > > that depend on certain filenames or extensions, and shouldn't have to
> > > > > modify binman code (consider that people may be using the PyPI wheels)
> > > > > to accommodate those when we are already putting the name in the dtb.
> > > > >
> > > > > I do want some standardization to the U-Boot build outputs though, but
> > > > > more like a global binman.dts with like u-boot.rom, u-boot-sdmmc.img
> > > > > images with well-defined TPL, SPL, U-Boot sections that arch-dtsi files
> > > > > can fill in.
> > > > >
> > > > > >> Regarding the output directory suggestion, I think the binman outputs
> > > > > >> (not temporary/intermediate files) should be in the same directory as
> > > > > >> make outputs
> > > > > >
> > > > > > Agreed
> > > > > >
> > > > > >> , and the Makefile should default to O=build to achieve the
> > > > > >> "output dir". I'm not sure if that's going to happen.
> > > > > >
> > > > > > I would quite like the 'non-output' file (i.e. things that are not a
> > > > > > binman image) to appear in a 'binman-work' subdir of the output dir.
> > > > > > What do you think?
> > > > >
> > > > > I'd prefer them to go in a tempfile.TemporaryDirectory() and discarded
> > > > > at the end of a binman run, and a "--tmpdir <path>" option to use a
> > > > > given directory instead and preserve things for debugging.
> > > >
> > > > Actually, that was the original purpose of the output directory in the
> > > > u_boot_pylib.tools module. But with all the files binman creates, that
> > > > has been lost. I think we should restore that purpose (with an output
> > > > dir as a temp dir) and then I think what you have written here will
> > > > work.
> > >
> > > Just please note the rest of the feedback that's been given to this
> > > series too.
> >
> > Yes. It is a bit hard to know what to do. I suppose we need binman to
> > publish a list of the image files it writes, so buildman can use that
> > to save them. Or we could just add some more special cases to the rule
> > in buildman?
>
> Extend the list of files that we do keep today, so that at least more
> cases could work, set aside the "everything else is an error" notion for
> now.

OK got it, thanks.


- Simon
