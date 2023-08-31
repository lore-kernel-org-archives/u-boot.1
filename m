Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6208EC83F2F
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0A8986590;
	Thu, 31 Aug 2023 21:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Epq10US9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 045C286590; Thu, 31 Aug 2023 21:23:43 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E2AB8656C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a8036d805eso758922b6e.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693509755; x=1694114555; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UvLfMTBucLdet7oQiR81Xb2Fls8plPgDgKEB2tWL1bY=;
 b=Epq10US9DmffN2QB2aXClhXPuipxTFekIQCv5DAV40LegtyGmTUPD631QgU9UqRLQC
 H7m/T1XBcmhqeGyuPqEljmx0ZjHZoIqUheVm4t1EF5Si11V2bAduBY+2HYTafRekM9FD
 zAjAotHN7EI1hgb7JcP9ZKXLXxoYjto7r4dQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693509755; x=1694114555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UvLfMTBucLdet7oQiR81Xb2Fls8plPgDgKEB2tWL1bY=;
 b=QzhhLna5Az2QjEvZUZXSADZp53BCXBc4T72SAQuIzHAsQXJEUSdhs94uG0lX2uypSb
 s7q5MQROM2DWmc2mVGvxackDL/Y8P4TJr16MwGdYQFEMR0Ay5ybYFsu/I1wMMkjSaNPM
 GXn2YVPaeDpdl8q86M7GtfDjdFW/g/eCxb2Wq6RMKW0Mmmr0H8D78E3T7B6MBbf6ZmIx
 soI1yMMAzV4kuYKqpipisMw+HqmRFWnuTWc9cZ9Bw2HPY6+idgI5gy1/NqxIpX0se4Ji
 GTP1ululRdcYmt0MdLrocZpkbrHrhfV9uT9Y6GteHHBGIwUcfoxZVOsT4UDBMlzvmwgX
 qIsQ==
X-Gm-Message-State: AOJu0YwkNOPLLqqBvwO6rocQzkq0DJ42vAlSp61rA2rZjm+0Vg9a9Qs2
 pE/pE6T3bQSUVBrg5lHC7dme7fJ9vlkX4s1Kps1leA==
X-Google-Smtp-Source: AGHT+IEcHA3uxkVdxS3kX5Q9Os0211/CVMcYLkoSpztA54Zr6d3y+m3G4j8WM0WQa4BNAS4i6qWLLFjG0HlsV7pi+yo=
X-Received: by 2002:aca:1a12:0:b0:3a7:b1de:bb70 with SMTP id
 a18-20020aca1a12000000b003a7b1debb70mr512693oia.6.1693509755084; Thu, 31 Aug
 2023 12:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230824030304.1555547-1-sjg@chromium.org>
 <40d6d839-6eaf-4950-bf37-aaad0f2d5e03@gmail.com>
 <CAPnjgZ3ejchoWij6C80nVMVr5iOag3Zazf7O_g_yYcw1U_f+cQ@mail.gmail.com>
 <d4ce17ae-8b84-4c8a-acaa-287549ec23a3@gmail.com>
 <CAPnjgZ0sTAoZi5TDAaTZUNPVNQ5dqoyVENDWJr=exa5z2R8srw@mail.gmail.com>
 <20230831190709.GO3101304@bill-the-cat>
In-Reply-To: <20230831190709.GO3101304@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 13:22:13 -0600
Message-ID: <CAPnjgZ0JtmKhY9t_gArwjRO2=qbZsUXDhMcra4mBqBiQmcbWBg@mail.gmail.com>
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

On Thu, 31 Aug 2023 at 13:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 31, 2023 at 01:01:59PM -0600, Simon Glass wrote:
> > Hi Alper,
> >
> > On Thu, 31 Aug 2023 at 04:20, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> > >
> > > On 2023-08-28 20:54 +03:00, Simon Glass wrote:
> > > > Hi Alper,
> > > >
> > > > On Sun, 27 Aug 2023 at 13:17, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> > > >>
> > > >> On 2023-08-24 06:02 +03:00, Simon Glass wrote:
> > > >>> In this early stage of using binman to produce output files, we are mostly
> > > >>> seeing people using common extensions such as '.bin' and '.rom'
> > > >>>
> > > >>> But unusual extensions appear in some places.
> > > >>>
> > > >>> We would like 'buildman -k' to keep the build outputs, but this is hard if
> > > >>> there is no consistency as to the extension used.
> > > >>>
> > > >>> This series adjusts binman to enforce just 4 extensions for output images:
> > > >>>
> > > >>>    .bin
> > > >>>    .rom
> > > >>>    .itb
> > > >>>    .img
> > > >>>
> > > >>> Other extensions will produce an error. With this rule observed, buildman
> > > >>> can keep the required files.
> > > >>
> > > >> I dislike this limitation. We know what files we will generate, they are
> > > >> listed in binman dtb, so we can add something like `binman build --ls`
> > > >> to print their names/paths for buildman to preserve them.
> > > >
> > > > Yes, it would be good to have that...
> > > >
> > > > But why do you dislike the limitation? Do you think extensions provide
> > > > useful information? I suppose one problem is that *.bin might pick up
> > > > private blobs that happen to be in the source directory?
> > >
> > > I guess my strongest argument is that people already/will have workflows
> > > that depend on certain filenames or extensions, and shouldn't have to
> > > modify binman code (consider that people may be using the PyPI wheels)
> > > to accommodate those when we are already putting the name in the dtb.
> > >
> > > I do want some standardization to the U-Boot build outputs though, but
> > > more like a global binman.dts with like u-boot.rom, u-boot-sdmmc.img
> > > images with well-defined TPL, SPL, U-Boot sections that arch-dtsi files
> > > can fill in.
> > >
> > > >> Regarding the output directory suggestion, I think the binman outputs
> > > >> (not temporary/intermediate files) should be in the same directory as
> > > >> make outputs
> > > >
> > > > Agreed
> > > >
> > > >> , and the Makefile should default to O=build to achieve the
> > > >> "output dir". I'm not sure if that's going to happen.
> > > >
> > > > I would quite like the 'non-output' file (i.e. things that are not a
> > > > binman image) to appear in a 'binman-work' subdir of the output dir.
> > > > What do you think?
> > >
> > > I'd prefer them to go in a tempfile.TemporaryDirectory() and discarded
> > > at the end of a binman run, and a "--tmpdir <path>" option to use a
> > > given directory instead and preserve things for debugging.
> >
> > Actually, that was the original purpose of the output directory in the
> > u_boot_pylib.tools module. But with all the files binman creates, that
> > has been lost. I think we should restore that purpose (with an output
> > dir as a temp dir) and then I think what you have written here will
> > work.
>
> Just please note the rest of the feedback that's been given to this
> series too.

Yes. It is a bit hard to know what to do. I suppose we need binman to
publish a list of the image files it writes, so buildman can use that
to save them. Or we could just add some more special cases to the rule
in buildman?

Regards,
Simon
