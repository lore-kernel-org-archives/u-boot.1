Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E950BC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76345888F0;
	Mon, 29 Jul 2024 17:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ro0hDZYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5066B888B9; Mon, 29 Jul 2024 17:29:11 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D486C88887
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e0b167da277so1965561276.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266948; x=1722871748; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CWQJc9iw+Dzmo+/w6GM9U+0586aihXRKk9i+paA5X34=;
 b=Ro0hDZYivQlcaZyp4Rs8e+V7pvf2MiPSGybR7YvYWtD+kEM8kymgBoCQzxanpzOt38
 4nKELrNLLepA+fL1DGgDPDs2h0WYH/NNGzFnt3rP7Ankl9Bc5CtLjcKmaF143Uw+Duiv
 E/LaMJ7p3Z5Og5C3ezZiEBwHEZVJlGan7Gb8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266948; x=1722871748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CWQJc9iw+Dzmo+/w6GM9U+0586aihXRKk9i+paA5X34=;
 b=aymycKMdNBe3VdV9nWLwNdEDlYXW57hgGOBSh5jaheN90A5vivtWGYmth3QvoMajno
 Dy6FczPdVOHo5hY5e9SBdYTE7fhnD360BXwVo1hhZi0ThqpXBXq7WjXq2h2pupuhbV/i
 sDsWWdoiHgoKLKIfUEYfHo4Fd6Rmtq0yEAyJDCXk0VxL9Af4WNcvLZTww52dCZnkjn1F
 PHelMq2+LG0oKjjgUvmzZmKq5NmGP7qC6/05QMABDb/y/WVO/2T8YXahJbjZ6VShEKsV
 fXQc9fRruWoUT0y+yI+MdV2xhC29jZWEEo+EfCI5h4zRXJ04Nyw2z2EAkr9lQ1S/WC2D
 Cxqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDFmI5FeXbWS5De2PJnn98F5Ru5B8Tr1HdLiJmhccHL/B7EQ+3asHP+u5VeZszp+d7BpBlUou/AVVHMWIw4hNoJ9t8xQ==
X-Gm-Message-State: AOJu0Yw78Pb8AcUM6eVlPrefNvr2rBSvMGgcYQoeW7SqdFpAMWW7SNGw
 uYQLi2ki7bc7niD41iy/jVAUghXFBDUSThKmQRCB8jh3HNsokaN1uRN+XCF1BQSsTLK3BjFzsx+
 1V+8awuQYNXOZuQ7l1uPTz6MisycemZr7eCXAf9nkCfXxEEk=
X-Google-Smtp-Source: AGHT+IGUPGly0Q0YJhcAQVsxsX0HqzR8VQsYx8DbjxcvqpID4lybHkOrOXJnjF3Mk81XnlO1euKlcN5bjxkE+cKdZ1E=
X-Received: by 2002:a05:6902:2b8f:b0:e08:5934:4bbf with SMTP id
 3f1490d57ef6-e0b5451e523mr8431310276.25.1722266947800; Mon, 29 Jul 2024
 08:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
 <CADg8p95cc=d31LWXzThVY8L=iV_Cg4dnOpQVy81obZM-ejJzQA@mail.gmail.com>
In-Reply-To: <CADg8p95cc=d31LWXzThVY8L=iV_Cg4dnOpQVy81obZM-ejJzQA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:57 -0600
Message-ID: <CAFLszThHu8xoF4AB0xdSWQzy9JC1ePkpGGg05+4zhbB85qtRkQ@mail.gmail.com>
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

On Sun, 28 Jul 2024 at 12:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Thu, 25 Jul 2024 at 18:24, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Thu, 25 Jul 2024 at 02:24, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
> > >
> > > > From: Simon Glass <sjg@chromium.org>
> > > >
> > > > Use this new data structure in the utility function.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >  lib/strto.c | 35 +++++++++++++++++++----------------
> > > >  1 file changed, 19 insertions(+), 16 deletions(-)
> > >
> > > This is rather big growth when we didn't already have realloc:
> > > 05: lib: Convert str_to_list() to use alist
> > >    aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
> > >             xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
> > >                u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
> > >                  function                                   old     new   delta
> > >                  realloc                                      -    1120   +1120
> > >                  alist_ensure_ptr                             -     140    +140
> > >                  alist_expand_to                              -     136    +136
> > >                  alist_init                                   -     108    +108
> > >                  alist_uninit_move_ptr                        -      76     +76
> > >                  alist_add_ptr                                -      72     +72
> > >                  alist_uninit                                 -      48     +48
> > >                  str_to_list                                204     232     +28
> > >
> >
> > I am working on an implementation of lmb maps using lists. The list
> > nodes are then allocated with calloc, which I believe is included in
> > most of the board images. We can then compare the size impact with the
> > two implementations (alist vs list). Thanks.
>
> I have worked on implementing the LMB maps using simple lists, and we
> do get a good size benefit with the list based implementation. I have
> used the script that was shared by Tom some time back to get the size
> impact [1]. The readings are with 1) alists with realloc 2) alist with
> malloc and 3) using linked list. These are on a RPI4 build, which has
> LMB enabled. I have checked the impact on a xilinx_versal_mini config
> as well, which does not have LMB enabled, and the size impact result
> is best with lists. The list based changes can be checked on my github
> [2].

Thanks for doing that. It is quite hard to read with the LTO enabled.
You can try with the -L flag and should get a cleaner result. Also see
my comment about how you are using alist directly instead of going
through the API...that might affect things.

Anyway (once you are using the API), my assumption from my previous
refactor attempt was that lmb would be easier to deal with with simple
arrays, which I why I wrote alist. Is that true, or not?

>
> -sughosh
>
> [1] - https://gist.github.com/sughoshg/d4f9bda8d8a33f715dab892738d192ba
> [2] - https://github.com/sughoshg/u-boot/tree/lmb_only_linked_lists_v3

Regards,
Simon
