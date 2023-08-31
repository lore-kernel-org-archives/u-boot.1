Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306ACC83F2F
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03426867F7;
	Thu, 31 Aug 2023 21:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JWXhtl32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 832F186784; Thu, 31 Aug 2023 21:03:29 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F8DA8684C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57359e85e9bso679744eaf.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693508604; x=1694113404; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5g+bE+gNK+QLeFC3naMVOJBDEZDvsK84DKLP2VgIlpg=;
 b=JWXhtl32IUudG4jZMi9m4QXInyXoXf6hUulpcYja5Av0iQ2HMODgQMnSN/GLEERqK0
 DH/KVkNrJhRjDtI5kb9+sny4n9kGG0uOJKAVl4c9iwTNP+IzUz8/smi7g+vKivYxV9p8
 ceAPZ2olBkT/B3hPiLtHrG/sMk/Xmw+1/OP+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508604; x=1694113404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5g+bE+gNK+QLeFC3naMVOJBDEZDvsK84DKLP2VgIlpg=;
 b=KTGbjNZy4qww3iRNca46Q0t00b5F0N28MGnCDEh/C1dSZO5BwJT/rYDRrIDDPX+EJr
 oYWZj/DXioQs/75FHpFzy3aaZ+YBNxEbKVNvVvcxalGy2atNsFTJtJck2bEwWZOkd49s
 2f0CMGNz/0oFzQljqyx57yu+9p8iLY9vQpbrBf1oQmzsd1kqlo3OwoW/YZSygHFqC5ng
 kmMUDUS6NIxfQYCTSjYpnZlbE0pAVEiA5N3bT5GnOLZn8h4oO5xCV2BTWbYsl4gCqawV
 Oz81/h9pbwhf1HWE8rXECwErVoxrfFZCu4YoPN6r4V+wbYjXADjsGe7kipFGmv3jz6V6
 nKgg==
X-Gm-Message-State: AOJu0YxdFKYhZ9FcOk9MlPlz7fXVKOBq06zmW8UUzEluEIklv/XYPqjW
 tGf1EbrMWH0cJiGYQXDzqSetM7TQAScU3nRNvvu9SA==
X-Google-Smtp-Source: AGHT+IHIJ2qqBwfGZHc1Xe2a5VkaK3XhoMPIUwC2TYuFiOFGQ98AbLc98BNq2C4j6/7TAAP4ohfixayFmVPBrTUZD74=
X-Received: by 2002:a05:6358:88d:b0:133:ac7:c84b with SMTP id
 m13-20020a056358088d00b001330ac7c84bmr200995rwj.12.1693508603494; Thu, 31 Aug
 2023 12:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230824030304.1555547-1-sjg@chromium.org>
 <40d6d839-6eaf-4950-bf37-aaad0f2d5e03@gmail.com>
 <CAPnjgZ3ejchoWij6C80nVMVr5iOag3Zazf7O_g_yYcw1U_f+cQ@mail.gmail.com>
 <d4ce17ae-8b84-4c8a-acaa-287549ec23a3@gmail.com>
In-Reply-To: <d4ce17ae-8b84-4c8a-acaa-287549ec23a3@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 13:01:59 -0600
Message-ID: <CAPnjgZ0sTAoZi5TDAaTZUNPVNQ5dqoyVENDWJr=exa5z2R8srw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Dillon Min <dillon.minfei@gmail.com>, 
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

Hi Alper,

On Thu, 31 Aug 2023 at 04:20, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> On 2023-08-28 20:54 +03:00, Simon Glass wrote:
> > Hi Alper,
> >
> > On Sun, 27 Aug 2023 at 13:17, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> >>
> >> On 2023-08-24 06:02 +03:00, Simon Glass wrote:
> >>> In this early stage of using binman to produce output files, we are mostly
> >>> seeing people using common extensions such as '.bin' and '.rom'
> >>>
> >>> But unusual extensions appear in some places.
> >>>
> >>> We would like 'buildman -k' to keep the build outputs, but this is hard if
> >>> there is no consistency as to the extension used.
> >>>
> >>> This series adjusts binman to enforce just 4 extensions for output images:
> >>>
> >>>    .bin
> >>>    .rom
> >>>    .itb
> >>>    .img
> >>>
> >>> Other extensions will produce an error. With this rule observed, buildman
> >>> can keep the required files.
> >>
> >> I dislike this limitation. We know what files we will generate, they are
> >> listed in binman dtb, so we can add something like `binman build --ls`
> >> to print their names/paths for buildman to preserve them.
> >
> > Yes, it would be good to have that...
> >
> > But why do you dislike the limitation? Do you think extensions provide
> > useful information? I suppose one problem is that *.bin might pick up
> > private blobs that happen to be in the source directory?
>
> I guess my strongest argument is that people already/will have workflows
> that depend on certain filenames or extensions, and shouldn't have to
> modify binman code (consider that people may be using the PyPI wheels)
> to accommodate those when we are already putting the name in the dtb.
>
> I do want some standardization to the U-Boot build outputs though, but
> more like a global binman.dts with like u-boot.rom, u-boot-sdmmc.img
> images with well-defined TPL, SPL, U-Boot sections that arch-dtsi files
> can fill in.
>
> >> Regarding the output directory suggestion, I think the binman outputs
> >> (not temporary/intermediate files) should be in the same directory as
> >> make outputs
> >
> > Agreed
> >
> >> , and the Makefile should default to O=build to achieve the
> >> "output dir". I'm not sure if that's going to happen.
> >
> > I would quite like the 'non-output' file (i.e. things that are not a
> > binman image) to appear in a 'binman-work' subdir of the output dir.
> > What do you think?
>
> I'd prefer them to go in a tempfile.TemporaryDirectory() and discarded
> at the end of a binman run, and a "--tmpdir <path>" option to use a
> given directory instead and preserve things for debugging.

Actually, that was the original purpose of the output directory in the
u_boot_pylib.tools module. But with all the files binman creates, that
has been lost. I think we should restore that purpose (with an output
dir as a temp dir) and then I think what you have written here will
work.

Regards,
Simon
