Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7F7C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE118651D;
	Thu, 24 Aug 2023 05:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="F5qt/wkS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F1F86537; Thu, 24 Aug 2023 05:01:59 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C831F8647E
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fe1b00fce2so9659957e87.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692846116; x=1693450916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KuGnw7SLcHFZ10nL9oYuEQxgwCl24sDV9CvOSreDWRQ=;
 b=F5qt/wkSMz3A+7AGBzYsnmLG4+yMdOT2vbkFiR7KGH5VoyXuRWtHCdc3MJTQgsIKNI
 qS+Rq9fketXrErWdiV9Jb+hV603mrnJvMCNmCqjJvHv3MqmqdRxUJhBgznwfGurn8nyY
 D0ALRz2z82WiVqdaaB7P0jGXYZtpFQm9NBRzp3JOiLWPwup84qPQMFXCt54Db/+Gfd0c
 nI3qWY1Res7Zb909zG52l6HF7EJQyoeUkeaHWfKy5DB74pyfejBTEDO4vba/bh78f8/K
 0VA7iu3ecm/REVH8/x+i1kZCJWsQQVEu0nE2F9q9F9hXUA/JkEHzWHcdtVEek1/e27Gt
 1iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692846116; x=1693450916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KuGnw7SLcHFZ10nL9oYuEQxgwCl24sDV9CvOSreDWRQ=;
 b=OCow6BslY6T2rLrYSih1yrCFCEER3eqTX0IjAv5fWzN2oODcjTnk7jKzI2s7bspAbN
 9Ri/t0MDJEWJaLlz7THZVbS0XsOU7LfEmwNG7VxWw9Yleh+NcVbrVQ0yWopTdIWbroYa
 uh3K1xPjVY0BfggFtBpIDe/2yzY90V31cknbW79ES+cOvEZtNQQ8haVJIIQRdRaKkm3Q
 Dd0EzT83sJnSZU6mKUHlLYZRvxytvcJdC9aQnzdm6gEO9i1biNPonNYMjv8TNZ+LZDGc
 cExlEbXEHAv9TCAyYu1zIHkDzMZpIUcGw0NGrnbur+8AlMwUv1sLnk4uutKyCTlZC9gW
 7Ijg==
X-Gm-Message-State: AOJu0YyfIq4Nj9S2Tv2gfWMGOlouseSgYXJKyDM+gz0II7lCrGIY28gC
 U3jfJsPiu1VuAMq5qbM6afYZpqlmGSOv+UE2e4Xw6g==
X-Google-Smtp-Source: AGHT+IHe3KNXYZSIMAWvF1oKPfzsmpCoUAlsV+bE9L+fC98oA7zLvYeR97ivJNFsrPhUnx33EILSlpBG5uWlONNPAUM=
X-Received: by 2002:a05:6512:2fc:b0:4fe:193c:de74 with SMTP id
 m28-20020a05651202fc00b004fe193cde74mr9642580lfq.18.1692846115704; Wed, 23
 Aug 2023 20:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
 <20230823171502.GQ3953269@bill-the-cat>
 <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
 <20230824001848.vgzl7rcphic3gu2n@carnival>
In-Reply-To: <20230824001848.vgzl7rcphic3gu2n@carnival>
From: Simon Glass <sjg@google.com>
Date: Wed, 23 Aug 2023 21:01:44 -0600
Message-ID: <CAPnjgZ2qxm0KGFp5dM2Jzzcuib5npXodhYQ6u+dbO3oSBHA55A@mail.gmail.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
To: Nishanth Menon <nm@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Neha Francis <n-francis@ti.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Hi Nishanth,

On Wed, 23 Aug 2023 at 18:18, Nishanth Menon <nm@ti.com> wrote:
>
> On 17:57-20230823, Simon Glass wrote:
> [...]
> > > This is how we have a common bit of rST for how to build N boards,
> > > without having to do a literal copy and paste N times.
> >
> > How about using this?
> >
> > https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#substitution-definitions
>
> I was not able to succeed with complex includes such as:
> https://github.com/u-boot/u-boot/blob/master/doc/board/ti/am62x_sk.rst?plain=1#L89
>
> am62x complete build procedure defined once and reused in other am62x
> platforms.. But the am62x build procedure itself is reused from common
> k3 build steps.

I followed through these instructions. I find the env vars quite
confusing, since I don't really know what it is doing. It feels like a
script:

do $a $b $c
do $f $e

it is pretty hard to follow. I think it would be better to write
everything out in full for each board, like rockchip does.

Some other minor feedback:

- The 'make' lines should really have -j $(nproc) added
- The $ signs at the start of each command in the docs are a pain
since it stops me copying the commands into the terminal - can you
remove them?
- It doesn't build for me:

  BINMAN  .binman_stamp
Image 'ti-dm' is missing external blobs and is non-functional: blob-ext

/binman/ti-dm/blob-ext (ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f):
   Missing blob

Some images are invalid
make[1]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files/Makefile:1115:
.binman_stamp] Error 103
make[1]: Leaving directory '/tmp/b/play'
make: *** [Makefile:177: sub-make] Error 2

Regards,
Simon
