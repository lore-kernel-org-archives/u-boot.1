Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5477BD2C11B
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00932891D4;
	Tue,  5 Nov 2024 16:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DtKziq9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C46E6891D1; Tue,  5 Nov 2024 16:13:18 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B987A88F77
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a6acac4c3so900193366b.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730819596; x=1731424396; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hJLf74gaPj/clk8e2DI21k+zd0L8Scd4QVBxrhseXrM=;
 b=DtKziq9j7XimJjqk1BL7/mxY6YvTe7+xeqWYGsBM+UVYn/5LmNUJvtwoDBVoqjZEbR
 p+KWRAz9vPCl3sfZ9HBdY1ZdDjqEcGhS8doj1SYP+w8ifE6PObEGJlkthV5fohDSaUDa
 e2Nxp/N63cmfxKZJCsggXgpVCHfRYIsFN6hLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819596; x=1731424396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hJLf74gaPj/clk8e2DI21k+zd0L8Scd4QVBxrhseXrM=;
 b=ttnnXQ0pD7YGtVJ6UdgY2tNQEfT1cTHl8aBh48O6mzf7i+5Zlrpgo7yATU6i/IqkAH
 iHaNdhsegbjd4Kn1NlR7RTWDVMJ1XQ/Us8tlWmxdd2cr5GwkS4agEeXtwb1QEQZoUAFG
 YmKNsLXWZRQrWTvoRKMZ7NMh4UE0nZCnzHfl1FEYfoDX2HRlHNioAIxEyCT8A2x2qm3G
 WiHB6AkozkgSutWWdrAlMN08lemcSw6ISIlvb55goF++byFqZo0xs03iUPhkO8T2srnP
 2VnfBwOeSHVgWCxF9zddOKwrydrRsT++CTg5jUkRfdmvMHT3ZkMHr01Gqfb7OifBv3mc
 fQmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYcHscsuCW6zOY7XFoXb9lAEPrJyoQ7JGoEe8PAXF2D9r3Sj73U66TMvMo/r1CuwdjORzeSRg=@lists.denx.de
X-Gm-Message-State: AOJu0YzO3mff4WL+tMZaw388VkMEbmAL0avEJzSz0tvk5E/rCW+LnXyM
 1FoQ9xXs8SpfugpiGQl8wZPazxdWlq85MpcD99CX+P3v6FMnYsCFVIc+XEPmkRyPLr4jJGn1LU8
 m8vxgY+HwP5FcUXBGUvHzPUe1OgiIja3laxaU
X-Google-Smtp-Source: AGHT+IH01KcxuO67ql8xOdAC+HfCOHOcS/6ZuEiuXa95ojbJJNlIDpAok3sJzDX7e9txGL3SdeQrim6+Eis5KDQiIvE=
X-Received: by 2002:a17:907:9405:b0:a9a:a3a:6c58 with SMTP id
 a640c23a62f3a-a9de5ed3e2emr3703084266b.22.1730819596191; Tue, 05 Nov 2024
 07:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20241104175110.1048449-1-sjg@chromium.org>
 <20241104175110.1048449-2-sjg@chromium.org>
 <d2822624-f9a0-4bc6-a911-861c7b2ac88e@gmx.de>
In-Reply-To: <d2822624-f9a0-4bc6-a911-861c7b2ac88e@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 08:13:04 -0700
Message-ID: <CAFLszTg6=FOJa0-=ywoNEkhSSSSoCE2mtHCQyTiWYqvZmQFRCg@mail.gmail.com>
Subject: Re: [PATCH v3 01/19] bootstd: Move bootflow-adding to bootstd
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 4 Nov 2024 at 15:15, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/4/24 18:50, Simon Glass wrote:
> > This relates to more than just the bootdev, since there is a global list
> > of bootflows. Move the function to the bootstd file and rename it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   boot/bootdev-uclass.c | 25 -------------------------
> >   boot/bootstd-uclass.c | 25 +++++++++++++++++++++++++
> >   cmd/bootflow.c        |  2 +-
> >   include/bootdev.h     | 15 ---------------
> >   include/bootstd.h     | 17 +++++++++++++++++
> >   5 files changed, 43 insertions(+), 41 deletions(-)
> >
> > diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
> > index 64ec4fde493..eddbf60600c 100644
> > --- a/boot/bootdev-uclass.c
> > +++ b/boot/bootdev-uclass.c
> > @@ -32,31 +32,6 @@ enum {
> >       BOOT_TARGETS_MAX_LEN    = 100,
> >   };
> >
> > -int bootdev_add_bootflow(struct bootflow *bflow)
> > -{
> > -     struct bootstd_priv *std;
> > -     struct bootflow *new;
> > -     int ret;
> > -
> > -     ret = bootstd_get_priv(&std);
> > -     if (ret)
> > -             return ret;
> > -
> > -     new = malloc(sizeof(*bflow));
> > -     if (!new)
> > -             return log_msg_ret("bflow", -ENOMEM);
> > -     memcpy(new, bflow, sizeof(*bflow));
> > -
> > -     list_add_tail(&new->glob_node, &std->glob_head);
> > -     if (bflow->dev) {
> > -             struct bootdev_uc_plat *ucp = dev_get_uclass_plat(bflow->dev);
> > -
> > -             list_add_tail(&new->bm_node, &ucp->bootflow_head);
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> >   int bootdev_first_bootflow(struct udevice *dev, struct bootflow **bflowp)
> >   {
> >       struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
> > diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
> > index fdb8d69e320..bf6e49ad97a 100644
> > --- a/boot/bootstd-uclass.c
> > +++ b/boot/bootstd-uclass.c
> > @@ -61,6 +61,31 @@ void bootstd_clear_glob(void)
> >       bootstd_clear_glob_(std);
> >   }
> >
> > +int bootstd_add_bootflow(struct bootflow *bflow)
> > +{
> > +     struct bootstd_priv *std;
> > +     struct bootflow *new;
> > +     int ret;
> > +
> > +     ret = bootstd_get_priv(&std);
> > +     if (ret)
> > +             return ret;
> > +
> > +     new = malloc(sizeof(*bflow));
> > +     if (!new)
> > +             return log_msg_ret("bflow", -ENOMEM);
> > +     memcpy(new, bflow, sizeof(*bflow));
> > +
> > +     list_add_tail(&new->glob_node, &std->glob_head);
> > +     if (bflow->dev) {
> > +             struct bootdev_uc_plat *ucp = dev_get_uclass_plat(bflow->dev);
> > +
> > +             list_add_tail(&new->bm_node, &ucp->bootflow_head);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static int bootstd_remove(struct udevice *dev)
> >   {
> >       struct bootstd_priv *priv = dev_get_priv(dev);
> > diff --git a/cmd/bootflow.c b/cmd/bootflow.c
> > index f67948d7368..8962464bbf8 100644
> > --- a/cmd/bootflow.c
> > +++ b/cmd/bootflow.c
> > @@ -207,7 +207,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
> >               bflow.err = ret;
> >               if (!ret)
> >                       num_valid++;
> > -             ret = bootdev_add_bootflow(&bflow);
> > +             ret = bootstd_add_bootflow(&bflow);
> >               if (ret) {
> >                       printf("Out of memory\n");
> >                       return CMD_RET_FAILURE;
> > diff --git a/include/bootdev.h b/include/bootdev.h
> > index ad4af0d1310..8db198dd56b 100644
> > --- a/include/bootdev.h
> > +++ b/include/bootdev.h
> > @@ -195,21 +195,6 @@ void bootdev_list(bool probe);
> >    */
> >   void bootdev_clear_bootflows(struct udevice *dev);
> >
> > -/**
> > - * bootdev_add_bootflow() - Add a bootflow to the bootdev's list
> > - *
> > - * All fields in @bflow must be set up. Note that @bflow->dev is used to add the
> > - * bootflow to that device.
> > - *
> > - * @dev: Bootdev device to add to
> > - * @bflow: Bootflow to add. Note that fields within bflow must be allocated
> > - *   since this function takes over ownership of these. This functions makes
> > - *   a copy of @bflow itself (without allocating its fields again), so the
> > - *   caller must dispose of the memory used by the @bflow pointer itself
> > - * Return: 0 if OK, -ENOMEM if out of memory
> > - */
> > -int bootdev_add_bootflow(struct bootflow *bflow);
> > -
> >   /**
> >    * bootdev_first_bootflow() - Get the first bootflow from a bootdev
> >    *
> > diff --git a/include/bootstd.h b/include/bootstd.h
> > index ac756e98d84..3fc93a4ec2e 100644
> > --- a/include/bootstd.h
> > +++ b/include/bootstd.h
> > @@ -105,4 +105,21 @@ void bootstd_clear_glob(void);
> >    */
> >   int bootstd_prog_boot(void);
> >
> > +/**
> > + * bootstd_add_bootflow() - Add a bootflow to the bootdev's and global list
> > + *
> > + * All fields in @bflow must be set up. Note that @bflow->dev is used to add the
> > + * bootflow to that device.
> > + *
> > + * The bootflow is also added to the global list of all bootflows
> > + *
> > + * @dev: Bootdev device to add to
>
> This parameter does not exist.
>
> > + * @bflow: Bootflow to add. Note that fields within bflow must be allocated
> > + *   since this function takes over ownership of these. This functions makes
> > + *   a copy of @bflow itself (without allocating its fields again), so the
> > + *   caller must dispose of the memory used by the @bflow pointer itself
>
> Please, add the headers to the API documentation and fix the numerous
> documentation issues like:
>
> ./include/bootdev.h:57: warning: Enum value 'BOOTDEVP_0_NONE' not
> described in enum 'bootdev_prio_t'
> ./include/bootdev.h:57: warning: Enum value 'BOOTDEVP_1_PRE_SCAN' not
> described in enum 'bootdev_prio_t'
> ./include/bootdev.h:57: warning: Enum value 'BOOTDEVP_COUNT' not
> described in enum 'bootdev_prio_t'
> ./include/bootdev.h:57: warning: Excess enum value 'BOOTDEVP_6_PRE_SCAN'
> description in 'bootdev_prio_t'
> ./include/bootdev.h:118: warning: Function parameter or member
> 'bootflow_head' not described in 'bootdev_uc_plat'
> ./include/bootdev.h:118: warning: Function parameter or member 'prio'
> not described in 'bootdev_uc_plat'
> ./include/bootdev.h:412: warning: Function parameter or member 'blk' not
> described in 'bootdev_setup_for_sibling_blk'
> ./include/bootdev.h:412: warning: Excess function parameter 'parent'
> description in 'bootdev_setup_for_sibling_blk'

I don't mind doing that in a follow-up once this series is in, but it
is out-of-scope here.

Regards,
Simon
