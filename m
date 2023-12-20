Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDF6C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 14:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 569A2877C4;
	Wed, 20 Dec 2023 15:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U0n6Oggm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35D198773C; Wed, 20 Dec 2023 15:53:46 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E62DA8773C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 15:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d532e4f6d6so2200218b3a.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 06:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703084020; x=1703688820; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GtDGptG+YlbDaOvMtNgOc46Sf0Z+HhlpzxBmLKvKtNA=;
 b=U0n6OggmphGcwdmn7y8PVkB4UbuweEaZXO+56YT4bKDbLJ+Y8WCZwYeC/C/C7R1d39
 WiMbScHed9SzJj4KDpK8aEwcUuZa11lvwvhqJUdlnze5rNGMucWLMs1KRp6AuXVYfy24
 oyYHW+aCswIdRuT4L8OgGDL8vTPG25U5CeNBVC0lG/GTnEWw07RzPZwAMlGqYWfUxR07
 lra5FCISZ3JVVYhij5r0TYEwuAwkgiUWx7cQvEYBb9LHQGYFXAmR0BpiPB4cds4kFYaM
 vRUGiy4X2L2Ubid/WDrcqqCFdB9bigmLv6c1T0XR02aSI99tD/Kyx74XIiqSn4hgtqW5
 Gmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703084020; x=1703688820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GtDGptG+YlbDaOvMtNgOc46Sf0Z+HhlpzxBmLKvKtNA=;
 b=d+NFzF6mqrxHmWcVhmGynuDei6LRswRZwxO3SsZSUv0/zvsefKD92PhgNNyZVMfnFi
 InzaRuJLD/517Vvtcoh+R2Y2PihlxigSvH1zS1KJYh7UTdoLrsV7dz1RMFh95kX1JWsE
 JkVFifdwTFffYEXf3XP+DnhnJcM6YBHhpJWZbcrJDyG/O+F4F6hWbIDfu0oCpVbtaf1r
 C05FbRDa+2ewet+6rQPaDu0zZRmhteou2+W8KvyZ/xeVmrSHU1hrgrzl6xQm+n4eIwL9
 da5QYoXHR1HvK5s9PAe4EoAk6BPXKnvJkzL6YjMybg0V5HQLk1xgYF0nAumWdeLitSU3
 PcBg==
X-Gm-Message-State: AOJu0YzvIen8c/3uhdR/cYFQm7ep2PWgF25cf/ZZ37FurbKtGSIaKtt9
 FuXOdxDz/ZE7/RGhYGNblzVA+TLdo3cRwVCJLQYMyA==
X-Google-Smtp-Source: AGHT+IEa0AgD2amJwQC3hLGTrDpf8YWb/RNCtvkRQN6K4xajLkws7cF8uh7fTafydEwgXYoW7prnNS4NnXyfi5KAcVc=
X-Received: by 2002:a05:6a20:3ca2:b0:190:c670:8e43 with SMTP id
 b34-20020a056a203ca200b00190c6708e43mr10375928pzj.92.1703084020163; Wed, 20
 Dec 2023 06:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20231219211114.393193-1-raymond.mao@linaro.org>
 <20231219211114.393193-4-raymond.mao@linaro.org>
 <f2221d44-cbb7-4355-b9a1-ecea47af62c5@amd.com>
In-Reply-To: <f2221d44-cbb7-4355-b9a1-ecea47af62c5@amd.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 20 Dec 2023 09:53:29 -0500
Message-ID: <CAEfUkULk+gFBEg=6YPtzracvHJ6pU7AM=+fw0eB3=NuxjctNcA@mail.gmail.com>
Subject: Re: [PATCH 3/5] bloblist: Load the bloblist from the previous loader
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Michal,

Other vendors should add their own custom function under the
"./board/<board-name>" directory.
The inline function here is just to avoid the building errors on other
platforms which do not yet implement the custom function.
Otherwise we have to create a function "board_bloblist_from_boot_arg()"
under all boards with this patch.

Thanks and regards,
Raymond


On Wed, 20 Dec 2023 at 05:57, Michal Simek <michal.simek@amd.com> wrote:

>
>
> On 12/19/23 22:11, Raymond Mao wrote:
> > During bloblist initialization, when CONFIG_OF_BOARD is defined,
> > invoke the platform custom function to load the bloblist via boot
> > arguments from the previous loader.
> > If the bloblist exists, copy it into the fixed bloblist memory region.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >   common/bloblist.c  | 47 ++++++++++++++++++++++++++++------------------
> >   include/bloblist.h | 16 ++++++++++++++++
> >   2 files changed, 45 insertions(+), 18 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index 232ca4c6ce..c89f7a1554 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -486,31 +486,38 @@ int bloblist_init(void)
> >       bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
> >       int ret = -ENOENT;
> >       ulong addr, size;
> > -     bool expected;
> > -
> > -     /**
> > -      * We don't expect to find an existing bloblist in the first phase
> of
> > -      * U-Boot that runs. Also we have no way to receive the address of
> an
> > -      * allocated bloblist from a previous stage, so it must be at a
> fixed
> > +     /*
> > +      * If U-Boot is not in the first phase, an existing bloblist must
> be
> > +      * at a fixed address.
> > +      */
> > +     bool from_addr = fixed && !u_boot_first_phase();
> > +     /*
> > +      * If U-Boot is in the first phase that a board specific routine
> should
> > +      * install the bloblist passed from previous loader to this fixed
> >        * address.
> >        */
> > -     expected = fixed && !u_boot_first_phase();
> > +     bool from_board = fixed && IS_ENABLED(CONFIG_OF_BOARD) &&
> > +                       u_boot_first_phase();
> > +
> >       if (spl_prev_phase() == PHASE_TPL &&
> !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> > -             expected = false;
> > +             from_addr = false;
> >       if (fixed)
> >               addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> >                                     CONFIG_BLOBLIST_ADDR);
> >       size = CONFIG_BLOBLIST_SIZE;
> > -     if (expected) {
> > +
> > +     if (from_board)
> > +             ret = board_bloblist_from_boot_arg(addr, size);
> > +     else if (from_addr)
> >               ret = bloblist_check(addr, size);
> > -             if (ret) {
> > -                     log_warning("Expected bloblist at %lx not found
> (err=%d)\n",
> > -                                 addr, ret);
> > -             } else {
> > -                     /* Get the real size, if it is not what we
> expected */
> > -                     size = gd->bloblist->total_size;
> > -             }
> > -     }
> > +
> > +     if (ret)
> > +             log_warning("Bloblist at %lx not found (err=%d)\n",
> > +                         addr, ret);
> > +     else
> > +             /* Get the real size */
> > +             size = gd->bloblist->total_size;
> > +
> >       if (ret) {
> >               if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
> >                       void *ptr = memalign(BLOBLIST_ALIGN, size);
> > @@ -519,7 +526,8 @@ int bloblist_init(void)
> >                               return log_msg_ret("alloc", -ENOMEM);
> >                       addr = map_to_sysmem(ptr);
> >               } else if (!fixed) {
> > -                     return log_msg_ret("!fixed", ret);
> > +                     return log_msg_ret("BLOBLIST_FIXED is not enabled",
> > +                                        ret);
> >               }
> >               log_debug("Creating new bloblist size %lx at %lx\n", size,
> >                         addr);
> > @@ -532,6 +540,9 @@ int bloblist_init(void)
> >               return log_msg_ret("ini", ret);
> >       gd->flags |= GD_FLG_BLOBLIST_READY;
> >
> > +     bloblist_show_stats();
> > +     bloblist_show_list();
> > +
> >       return 0;
> >   }
> >
> > diff --git a/include/bloblist.h b/include/bloblist.h
> > index b5d0f147f6..f5c623133d 100644
> > --- a/include/bloblist.h
> > +++ b/include/bloblist.h
> > @@ -445,6 +445,22 @@ void bloblist_reloc(void *to, uint to_size, void
> *from, uint from_size);
> >    */
> >   int bloblist_init(void);
> >
> > +#if (IS_ENABLED(CONFIG_ARCH_QEMU) && IS_ENABLED(CONFIG_ARM))
>
> How do you think that others start to use it?
> Adding that platforms here? I don't think it is scalable.
>
> Thanks,
> Michal
>
