Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAFDD637CE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A7B58904E;
	Fri, 15 Nov 2024 15:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IbLpNsBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E77AD89221; Fri, 15 Nov 2024 15:10:08 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923D58903C
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1ecbso2573977a12.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731679806; x=1732284606; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SwvXvVqqcAvvcRO5Sx2dBGMRpnPgNCMskTPTemFbPl0=;
 b=IbLpNsBqfdvZ/r/dSlqr13DLiTpRiRjzhfGkMyBuwqB3X1wLQ9BSH3Xc/qyAgGAgd3
 g2Jk/bO899G/h4bdzm/zaz195O8Ykczkmu+H3MBKJDGSvWKogBrCkX1sg9O8diEXvEqn
 3pEs2VjfN/DC8AV4bL7EH7y7ayCmzUlOj3G3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731679806; x=1732284606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SwvXvVqqcAvvcRO5Sx2dBGMRpnPgNCMskTPTemFbPl0=;
 b=w6oJv0TWnvvpNmz6PFyQaGKxEnc0IpcgW4uEPkvqrO15GDmz4R8Xip14Auou3d91AN
 SC+ZmNTGutWymtWmUxcvpdWOrgQW2nSpZ7Oq84S07N0X0+ObN3yYFRz0ldfLJnY9HGkv
 797OraAh5CyDFWx6y6Q2AvkRr/pyAhgyx3VCmeCw4DsvRFbFLG6jazKvPIQVaoMKHz03
 T+oquvuw9bWhLxeT9diw75Sd1MpHpp4WcOLqMxSKo7FXt8BxiKxzDmfU6m4vkQl4gCs+
 eNJbzBeXJchuIKci4myf0CU+xwQqGXIljIH5SX3rGcDJ89+ndXBnI11+4svjjgHuDjvJ
 y09Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSa3m4uPpcq+8AKkAFHLqgJ0K6HP8z6aW+mll7lcXX6wHgd6nsN56WE76TX29ZrtZdnzySfsw=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb4icG9M+X0ZLq9idfIPvXrUekoNJlXTK41xS0t5VACbthLxky
 eKLglUoe0LVBgpsxp/KQTHKjGesUHmPBdpNYoW7+/ix7psqnbSmPbBt0k7QBdWDfcj88vOLmbIX
 ItGiQWWMBWD9lUC/hQay9TPXkQkMi22L6u8CUjFFfxmwb1fTy5w==
X-Google-Smtp-Source: AGHT+IEiDXeGoRKrCunc0HRt0A3LPJd2ueLJBgfet8wjzJfx4+0dSAhFPxMhHatmUoTxqbkJMuEz8XsTV8E3u0lVqWI=
X-Received: by 2002:a17:907:96ab:b0:a99:ec3c:15cd with SMTP id
 a640c23a62f3a-aa483552e2amr232046566b.54.1731679805846; Fri, 15 Nov 2024
 06:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20241102193715.432529-1-sjg@chromium.org>
 <20241102193715.432529-2-sjg@chromium.org>
 <2d8aced2-e1e9-46a4-8fb4-8e8cf5bb3a46@gmx.de>
In-Reply-To: <2d8aced2-e1e9-46a4-8fb4-8e8cf5bb3a46@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:09:54 -0700
Message-ID: <CAFLszThztoFo6ryg3EZzhO9a3cAvcfOb3AU_TejLcvohoVNH_Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] bloblist: test: Move test into common
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 14 Nov 2024 at 04:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/2/24 20:36, Simon Glass wrote:
> > This test doesn't belong at the top level. Move it into the common/
> > directory, to match its implementation.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > ---
> >
> > Changes in v2:
> > - Leave the bootm rule alone, as the bootm test only runs on sandbox
> >
> >   test/Makefile                | 1 -
> >   test/common/Makefile         | 3 +++
> >   test/{ => common}/bloblist.c | 0
> >   3 files changed, 3 insertions(+), 1 deletion(-)
> >   rename test/{ => common}/bloblist.c (100%)
> >
> > diff --git a/test/Makefile b/test/Makefile
> > index 145c952d2c3..5d62b5c3357 100644
> > --- a/test/Makefile
> > +++ b/test/Makefile
> > @@ -5,7 +5,6 @@
> >   obj-y += test-main.o
> >
> >   ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
>
> Shouldn't this be CONFIG_$(PHASE_)BLOBLIST, see common/Makefile.

As before, we don't run this test in any xPL build.

If we use PHASE_ that suggests that each xPL build has a different
setting for this value.

If the final part of my xPL series[1] ever lands, all of these $(xxx)
things in Makefiles will go away. For now, using PHASE_ just adds
confusion and might even make that migration more difficult.

>
> > -obj-$(CONFIG_$(XPL_)CMDLINE) += bloblist.o
>
> Why do we need the command line for running this test?

bloblist_test_cmd_info()

>
> The only thing we need the command line for is issuing the 'ut' command?
>
> Can be remove the CMDLINE dependency or move it to 'config UNIT_TEST'.

We could make the above test return -EAGAIN if
!CONFIG_IS_ENABLED(CMDLINE) I suppose.

>
> >   obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
> >   endif
> >   obj-$(CONFIG_$(XPL_)CMDLINE) += cmd/
> > diff --git a/test/common/Makefile b/test/common/Makefile
> > index 12c65f8c951..b6bff9201ec 100644
> > --- a/test/common/Makefile
> > +++ b/test/common/Makefile
> > @@ -1,6 +1,9 @@
> >   # SPDX-License-Identifier: GPL-2.0+
> >   obj-y += cmd_ut_common.o
> >   obj-$(CONFIG_AUTOBOOT) += test_autoboot.o
> > +ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
>
> ditto
>
> Best regards
>
> Heinrich
>
> > +obj-$(CONFIG_$(XPL_)CMDLINE) += bloblist.o
> > +endif
> >   obj-$(CONFIG_CYCLIC) += cyclic.o
> >   obj-$(CONFIG_EVENT_DYNAMIC) += event.o
> >   obj-y += cread.o
> > diff --git a/test/bloblist.c b/test/common/bloblist.c
> > similarity index 100%
> > rename from test/bloblist.c
> > rename to test/common/bloblist.c
>

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=341504&state=*
