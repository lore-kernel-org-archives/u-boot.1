Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE56C3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA2C887B9;
	Tue, 30 Jul 2024 16:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IgPwIIbt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E62A887B9; Tue, 30 Jul 2024 16:38:09 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E98A688640
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dff17fd97b3so3361800276.2
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722350286; x=1722955086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SJ62mggbI9FTdRgj9zBO04UcVuQM51w+9ZE20ihq0EM=;
 b=IgPwIIbtdziyVH94Q/SzWGRHMsP11Xq0yKRNhIqpuFzmQSPfmR51L1uwE+scybVe97
 BYC8q7StTvlTqSt+DWRMRJxE+/afMpftB3hruDSniH0R+7kUlD92X9nK2A3Bn6eeejvm
 dXYlSWmiaqEzF3JPfXbZoZz4MsE1T7Zb3RNeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722350286; x=1722955086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SJ62mggbI9FTdRgj9zBO04UcVuQM51w+9ZE20ihq0EM=;
 b=Clp1wRYJFSGtsFSTrdYOMXY/c3/o8bvtsEpQ1eMLmfMy5bMOLgSvlWYXqAb8gUlx5Y
 glufLvRND+5j9ANh6+wvAw0lmAtC6zu3yy51/bzXsIC8koonuc4wtw5UrhALfoysdkLj
 Jb28kh0ZQHNXSVEQaSzajqaPGoD6C8RQSL/MWr5yw4qIKOuO6nWyHbdbWP2WeaRmq6Qi
 jNUdWlK4fSSbmm7HNcVxCkwWmoQTUzQjRIZ8qAe3uVi/OhhwVFuK73LQ1I5GjA4wlmeC
 UliA5BgmMiFGt66sMPLrNVIbCalntGdU08iJQFlD+D8Lm+gmo2ylZjpVISjjbQT0tirU
 aunQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU88JGtapI6Vc5Juf4GcfNcNdgea30IfxiVCLT72WghHofzbcaSpSALr0L3PLPM5ooRdM1g6oa9qQd2JAXKfwtWFZnkfA==
X-Gm-Message-State: AOJu0YyyUe8kruvVSfonWM6FIxS9ZUILsuEuPzAvk1lt4ZmUudlsieZ1
 mBxejx9M0ZTD9W2Cq//voomGuYUqINrTKV6RmlBZNCCSrRoKC5veOj9gr7MHSBqbJ1ke6zahdFt
 XAz8ZzRJPQJfRoAzee4QNpCJOEkEWPpfEP7Mj
X-Google-Smtp-Source: AGHT+IEs0sS7GXI2cGeykOHdEUUGJmpVQNDiPqW0zpc2Soj+zK/sqtUrHFnFCnVTFFshfSswnMniHF/e8f42+Z2Jt14=
X-Received: by 2002:a05:6902:2011:b0:e0b:aa9e:bbc2 with SMTP id
 3f1490d57ef6-e0baa9ebd34mr1304599276.29.1722350285796; Tue, 30 Jul 2024
 07:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
 <CADg8p95cc=d31LWXzThVY8L=iV_Cg4dnOpQVy81obZM-ejJzQA@mail.gmail.com>
 <CAFLszThHu8xoF4AB0xdSWQzy9JC1ePkpGGg05+4zhbB85qtRkQ@mail.gmail.com>
 <20240729181651.GN989285@bill-the-cat>
 <CADg8p94GzFOOEX3meYiNJQ+2eacbJF5W8qMmO77SM7jGd+VhKw@mail.gmail.com>
In-Reply-To: <CADg8p94GzFOOEX3meYiNJQ+2eacbJF5W8qMmO77SM7jGd+VhKw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Jul 2024 08:37:54 -0600
Message-ID: <CAFLszTgzhvCwZxh=MojGMr1FoLeCuQ8-SBhkcRP8fzvjWPt3bA@mail.gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Mon, 29 Jul 2024 at 19:49, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Mon, 29 Jul 2024 at 23:46, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jul 29, 2024 at 09:28:57AM -0600, Simon Glass wrote:
> > > Hi Sughosh,
> > >
> > > On Sun, 28 Jul 2024 at 12:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Thu, 25 Jul 2024 at 18:24, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > On Thu, 25 Jul 2024 at 02:24, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
> > > > > >
> > > > > > > From: Simon Glass <sjg@chromium.org>
> > > > > > >
> > > > > > > Use this new data structure in the utility function.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > ---
> > > > > > >  lib/strto.c | 35 +++++++++++++++++++----------------
> > > > > > >  1 file changed, 19 insertions(+), 16 deletions(-)
> > > > > >
> > > > > > This is rather big growth when we didn't already have realloc:
> > > > > > 05: lib: Convert str_to_list() to use alist
> > > > > >    aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
> > > > > >             xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
> > > > > >                u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
> > > > > >                  function                                   old     new   delta
> > > > > >                  realloc                                      -    1120   +1120
> > > > > >                  alist_ensure_ptr                             -     140    +140
> > > > > >                  alist_expand_to                              -     136    +136
> > > > > >                  alist_init                                   -     108    +108
> > > > > >                  alist_uninit_move_ptr                        -      76     +76
> > > > > >                  alist_add_ptr                                -      72     +72
> > > > > >                  alist_uninit                                 -      48     +48
> > > > > >                  str_to_list                                204     232     +28
> > > > > >
> > > > >
> > > > > I am working on an implementation of lmb maps using lists. The list
> > > > > nodes are then allocated with calloc, which I believe is included in
> > > > > most of the board images. We can then compare the size impact with the
> > > > > two implementations (alist vs list). Thanks.
> > > >
> > > > I have worked on implementing the LMB maps using simple lists, and we
> > > > do get a good size benefit with the list based implementation. I have
> > > > used the script that was shared by Tom some time back to get the size
> > > > impact [1]. The readings are with 1) alists with realloc 2) alist with
> > > > malloc and 3) using linked list. These are on a RPI4 build, which has
> > > > LMB enabled. I have checked the impact on a xilinx_versal_mini config
> > > > as well, which does not have LMB enabled, and the size impact result
> > > > is best with lists. The list based changes can be checked on my github
> > > > [2].
> > >
> > > Thanks for doing that. It is quite hard to read with the LTO enabled.
> >
> > I don't think LTO is enabled there?
>
> I ran the size checks with -L flag [1]. Do not see any difference.\

OK, thanks, as Tom says probably not actually enabled. It's just hard
to compare two branches!

I took a look at the lmb thing and decided to write a few patches to
show what I am getting at, particularly with the testing side. I will
send those as an RFC...

Regards,
Simon


>
> -sughosh
>
> [1] - https://gist.github.com/sughoshg/8a82946727904944601021a7ee732661
