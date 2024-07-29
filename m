Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C627C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 18:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB43887EB;
	Mon, 29 Jul 2024 20:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gg77SC48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF9B788155; Mon, 29 Jul 2024 20:49:16 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12AE7887EB
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 20:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc34722so7942978a12.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722278952; x=1722883752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FSh6NOVR+BXym7SCui103S76yutaCQTYI/wEeObTJVU=;
 b=Gg77SC48bNhyNfQG1mY4ju2FmqHIlAsmDA6IPG9Eadwx7bOxHagT8Z8MR6tC1OQ5Fy
 yYn9Am1aN3iJ2Gb3KFlhjYeB+GYf9j6ojEz1A11stv5P3gaFL+ddSkL5SP8w7eUTnp8b
 hyGIR2PlS9JURux/TY38uLb1Mo3HiZQmLhIlpAuB3gASMNa2FGAMnwtwdIC8Us8dRdn5
 OxIzzCKXw0Eo+aJFQ+vEd4WBZXfaYNfCNeyJOWOYs/SefR812yljnTaFOgTz0S711QSg
 +qX7G0+8PrFbDe3R9fRzkIDCra4faCZ8OuNrvR3pW5GThS+4y1Ma25qNUJfyS2k5id2U
 bfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722278952; x=1722883752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FSh6NOVR+BXym7SCui103S76yutaCQTYI/wEeObTJVU=;
 b=uwMZAgY237TH7cr4wEVONVnityQ8w4/0y97M8YhAi7Ug7bf75gImiDlDxIEUpnWJKV
 5GRALDY8aEnyGVxaV1IXvjJz8GFkO0HutbY/RWYd3hYrpQzoWWElC4Rhb4cS7geDYm/Z
 cC9uRIVl8w98Cj3m0ajINiurJOT8kFExl4arYYSfVgtqJMm2qBQgu6EwzbikOOKlI8Gr
 vhtJbTG8Gps3gcQkwZBi2gHcHLfAthcTgH/dRH8hRXJkkrKfMEYWVrfXd2T8kNtMjxcP
 aQtwKAPIt9C2+g4gAnQKmWqMnOMQSTJ80L0LOgqkPd23lQPOjmpFExKRR4XJOd6nY3Z0
 7Y5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4p8qz7vCNKIVl9zQSrgycwQJjHatQcmwYI2ZY3enAwql07c+kk0S2qwk0gr3xzS+Tw7k+h2c0d1x66Vq3qkHCQwoloQ==
X-Gm-Message-State: AOJu0Yyj3xWKgIxmksqhut5GYyLBIukXzJFPYx1mBk0JD9gCZA3mUZU2
 FfEfySlrSftiMmJJWHNvmtSzP7wLduJThH6is/4cD1enuAwblq2U6CM+IdYhf33TLUcg7SM7o59
 /3oQSCfYWKdSq7BU6v0rRtxPScJk4r6NAElhu8g==
X-Google-Smtp-Source: AGHT+IEdgg6xdn4/1jWI9K9RMAsSzhvef89IiQK9oU6hgLdAMQa3Cjd5tc2oyscAZnHCh5mgnGepGsb97ECuu+M9ZeY=
X-Received: by 2002:a05:6402:2793:b0:58c:5ee3:30ca with SMTP id
 4fb4d7f45d1cf-5b01413ee6emr9956886a12.0.1722278952337; Mon, 29 Jul 2024
 11:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
 <CADg8p95cc=d31LWXzThVY8L=iV_Cg4dnOpQVy81obZM-ejJzQA@mail.gmail.com>
 <CAFLszThHu8xoF4AB0xdSWQzy9JC1ePkpGGg05+4zhbB85qtRkQ@mail.gmail.com>
 <20240729181651.GN989285@bill-the-cat>
In-Reply-To: <20240729181651.GN989285@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 30 Jul 2024 00:19:00 +0530
Message-ID: <CADg8p94GzFOOEX3meYiNJQ+2eacbJF5W8qMmO77SM7jGd+VhKw@mail.gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
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

On Mon, 29 Jul 2024 at 23:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jul 29, 2024 at 09:28:57AM -0600, Simon Glass wrote:
> > Hi Sughosh,
> >
> > On Sun, 28 Jul 2024 at 12:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Thu, 25 Jul 2024 at 18:24, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Thu, 25 Jul 2024 at 02:24, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
> > > > >
> > > > > > From: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > Use this new data structure in the utility function.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > >  lib/strto.c | 35 +++++++++++++++++++----------------
> > > > > >  1 file changed, 19 insertions(+), 16 deletions(-)
> > > > >
> > > > > This is rather big growth when we didn't already have realloc:
> > > > > 05: lib: Convert str_to_list() to use alist
> > > > >    aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
> > > > >             xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
> > > > >                u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
> > > > >                  function                                   old     new   delta
> > > > >                  realloc                                      -    1120   +1120
> > > > >                  alist_ensure_ptr                             -     140    +140
> > > > >                  alist_expand_to                              -     136    +136
> > > > >                  alist_init                                   -     108    +108
> > > > >                  alist_uninit_move_ptr                        -      76     +76
> > > > >                  alist_add_ptr                                -      72     +72
> > > > >                  alist_uninit                                 -      48     +48
> > > > >                  str_to_list                                204     232     +28
> > > > >
> > > >
> > > > I am working on an implementation of lmb maps using lists. The list
> > > > nodes are then allocated with calloc, which I believe is included in
> > > > most of the board images. We can then compare the size impact with the
> > > > two implementations (alist vs list). Thanks.
> > >
> > > I have worked on implementing the LMB maps using simple lists, and we
> > > do get a good size benefit with the list based implementation. I have
> > > used the script that was shared by Tom some time back to get the size
> > > impact [1]. The readings are with 1) alists with realloc 2) alist with
> > > malloc and 3) using linked list. These are on a RPI4 build, which has
> > > LMB enabled. I have checked the impact on a xilinx_versal_mini config
> > > as well, which does not have LMB enabled, and the size impact result
> > > is best with lists. The list based changes can be checked on my github
> > > [2].
> >
> > Thanks for doing that. It is quite hard to read with the LTO enabled.
>
> I don't think LTO is enabled there?

I ran the size checks with -L flag [1]. Do not see any difference.

-sughosh

[1] - https://gist.github.com/sughoshg/8a82946727904944601021a7ee732661
