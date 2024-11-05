Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A953D2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C42A0891E9;
	Tue,  5 Nov 2024 17:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ao30cew5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16335891FE; Tue,  5 Nov 2024 17:07:42 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E8C8891F4
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a2209bd7fso987727666b.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730822859; x=1731427659; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zbk2LkQVBD5e4ZCBLgShBPud4OwTYAjRvO5LnR84y/4=;
 b=ao30cew5FYYA3EcE8yjJnPvCyYJ+cTSO4805XpO3p/IKcQseu2CouKB/va62/xn8O7
 +Bk5l8ZVFfB/Gaoz19m9qp4FSbhAiWyHUGfcBC0eKeRHC3p+WG64t7C8SCVQkA4UyMvg
 O+qnfSBUhSvwQYEgkvwBsW92CIeukCC5epX+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822859; x=1731427659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zbk2LkQVBD5e4ZCBLgShBPud4OwTYAjRvO5LnR84y/4=;
 b=V6tl0vw4qG3C0V+t0cKKspfPULrQqvYOgsCtHgkXdMmlUzch5HGDrbvy6Ze24YNQEW
 xlE/u7xsJWIDEX1GTVyFQeH15CtZqKMwxOEGxdVdZB0aDtio4xBtxvcsALuCvV/S/3ev
 gkghB2IKpXLBrDKfs2EcviOmrZrgllxXjTBEcjY0RuOAVnRDb+enjZwdkZ3vvgfOEN8k
 6pXU7AFIPr5diiXhNCMC1X1XeNOC7lUTZU92tgnvgwRsQidMZJP1wSHZOnUpl+0PiilL
 +qIAsmf/ysx+xP3MHAwKkaqkfK5Q0WPTooanpabSqSwExZLPQ6vReKnX0oKy86hXVI2r
 WWzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs3BLcjANeSDhNKfxtH3pG/sH1+XgYh2ugbe1+3V6MYKQOd26ahgvU02tF4d0WgsLHOKBSJuQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl01bqv5EUcX6zeGUonBQMopGOsdf7hLiOthQrq8dWlNU7/Ve7
 f3+2ANk9vJAk+eu88scIC1ntxTZu9F5nt/vso3I8OIxpwrjiHOkwIVWwMKUVo1Aimxt7sxWcn/6
 Pvbzng/D0gUvcir7qrImlbrhD9GkaG+fMMcHo
X-Google-Smtp-Source: AGHT+IG3Bs+8K5xOtvOnpzG/WZKGBoMkgSuffe7nWOH1O+3GUjAcEM+hxSnYPknUEhNnmMie4BBlnWNFk+54dKw9iqc=
X-Received: by 2002:a17:907:7da0:b0:a99:f972:7544 with SMTP id
 a640c23a62f3a-a9de5f40788mr3283173266b.38.1730822858949; Tue, 05 Nov 2024
 08:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20241104175110.1048449-1-sjg@chromium.org>
 <20241104175110.1048449-2-sjg@chromium.org>
 <d2822624-f9a0-4bc6-a911-861c7b2ac88e@gmx.de>
 <CAFLszTg6=FOJa0-=ywoNEkhSSSSoCE2mtHCQyTiWYqvZmQFRCg@mail.gmail.com>
 <20241105153939.GG3600562@bill-the-cat>
In-Reply-To: <20241105153939.GG3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 09:07:27 -0700
Message-ID: <CAFLszTjLHO0Ge+NJn7_5JSm8CjFsFXEMyf-Pcb3ZQ3xamPH6nw@mail.gmail.com>
Subject: Re: [PATCH v3 01/19] bootstd: Move bootflow-adding to bootstd
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
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

Hi Tom,

On Tue, 5 Nov 2024 at 08:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 05, 2024 at 08:13:04AM -0700, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 4 Nov 2024 at 15:15, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 11/4/24 18:50, Simon Glass wrote:
> > > > This relates to more than just the bootdev, since there is a global list
> > > > of bootflows. Move the function to the bootstd file and rename it.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >   boot/bootdev-uclass.c | 25 -------------------------
> > > >   boot/bootstd-uclass.c | 25 +++++++++++++++++++++++++
> > > >   cmd/bootflow.c        |  2 +-
> > > >   include/bootdev.h     | 15 ---------------
> > > >   include/bootstd.h     | 17 +++++++++++++++++
> > > >   5 files changed, 43 insertions(+), 41 deletions(-)
> > > >
> > > > diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
> > > > index 64ec4fde493..eddbf60600c 100644
> > > > --- a/boot/bootdev-uclass.c
> > > > +++ b/boot/bootdev-uclass.c
> > > > @@ -32,31 +32,6 @@ enum {
> > > >       BOOT_TARGETS_MAX_LEN    = 100,
> > > >   };
> > > >
> > > > -int bootdev_add_bootflow(struct bootflow *bflow)
> > > > -{
> > > > -     struct bootstd_priv *std;
> > > > -     struct bootflow *new;
> > > > -     int ret;
> > > > -
> > > > -     ret = bootstd_get_priv(&std);
> > > > -     if (ret)
> > > > -             return ret;
> > > > -
> > > > -     new = malloc(sizeof(*bflow));
> > > > -     if (!new)
> > > > -             return log_msg_ret("bflow", -ENOMEM);
> > > > -     memcpy(new, bflow, sizeof(*bflow));
> > > > -
> > > > -     list_add_tail(&new->glob_node, &std->glob_head);
> > > > -     if (bflow->dev) {
> > > > -             struct bootdev_uc_plat *ucp = dev_get_uclass_plat(bflow->dev);
> > > > -
> > > > -             list_add_tail(&new->bm_node, &ucp->bootflow_head);
> > > > -     }
> > > > -
> > > > -     return 0;
> > > > -}
> > > > -
> > > >   int bootdev_first_bootflow(struct udevice *dev, struct bootflow **bflowp)
> > > >   {
> > > >       struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
> > > > diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
> > > > index fdb8d69e320..bf6e49ad97a 100644
> > > > --- a/boot/bootstd-uclass.c
> > > > +++ b/boot/bootstd-uclass.c
> > > > @@ -61,6 +61,31 @@ void bootstd_clear_glob(void)
> > > >       bootstd_clear_glob_(std);
> > > >   }
> > > >
> > > > +int bootstd_add_bootflow(struct bootflow *bflow)
> > > > +{
> > > > +     struct bootstd_priv *std;
> > > > +     struct bootflow *new;
> > > > +     int ret;
> > > > +
> > > > +     ret = bootstd_get_priv(&std);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     new = malloc(sizeof(*bflow));
> > > > +     if (!new)
> > > > +             return log_msg_ret("bflow", -ENOMEM);
> > > > +     memcpy(new, bflow, sizeof(*bflow));
> > > > +
> > > > +     list_add_tail(&new->glob_node, &std->glob_head);
> > > > +     if (bflow->dev) {
> > > > +             struct bootdev_uc_plat *ucp = dev_get_uclass_plat(bflow->dev);
> > > > +
> > > > +             list_add_tail(&new->bm_node, &ucp->bootflow_head);
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > >   static int bootstd_remove(struct udevice *dev)
> > > >   {
> > > >       struct bootstd_priv *priv = dev_get_priv(dev);
> > > > diff --git a/cmd/bootflow.c b/cmd/bootflow.c
> > > > index f67948d7368..8962464bbf8 100644
> > > > --- a/cmd/bootflow.c
> > > > +++ b/cmd/bootflow.c
> > > > @@ -207,7 +207,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
> > > >               bflow.err = ret;
> > > >               if (!ret)
> > > >                       num_valid++;
> > > > -             ret = bootdev_add_bootflow(&bflow);
> > > > +             ret = bootstd_add_bootflow(&bflow);
> > > >               if (ret) {
> > > >                       printf("Out of memory\n");
> > > >                       return CMD_RET_FAILURE;
> > > > diff --git a/include/bootdev.h b/include/bootdev.h
> > > > index ad4af0d1310..8db198dd56b 100644
> > > > --- a/include/bootdev.h
> > > > +++ b/include/bootdev.h
> > > > @@ -195,21 +195,6 @@ void bootdev_list(bool probe);
> > > >    */
> > > >   void bootdev_clear_bootflows(struct udevice *dev);
> > > >
> > > > -/**
> > > > - * bootdev_add_bootflow() - Add a bootflow to the bootdev's list
> > > > - *
> > > > - * All fields in @bflow must be set up. Note that @bflow->dev is used to add the
> > > > - * bootflow to that device.
> > > > - *
> > > > - * @dev: Bootdev device to add to
> > > > - * @bflow: Bootflow to add. Note that fields within bflow must be allocated
> > > > - *   since this function takes over ownership of these. This functions makes
> > > > - *   a copy of @bflow itself (without allocating its fields again), so the
> > > > - *   caller must dispose of the memory used by the @bflow pointer itself
> > > > - * Return: 0 if OK, -ENOMEM if out of memory
> > > > - */
> > > > -int bootdev_add_bootflow(struct bootflow *bflow);
> > > > -
> > > >   /**
> > > >    * bootdev_first_bootflow() - Get the first bootflow from a bootdev
> > > >    *
> > > > diff --git a/include/bootstd.h b/include/bootstd.h
> > > > index ac756e98d84..3fc93a4ec2e 100644
> > > > --- a/include/bootstd.h
> > > > +++ b/include/bootstd.h
> > > > @@ -105,4 +105,21 @@ void bootstd_clear_glob(void);
> > > >    */
> > > >   int bootstd_prog_boot(void);
> > > >
> > > > +/**
> > > > + * bootstd_add_bootflow() - Add a bootflow to the bootdev's and global list
> > > > + *
> > > > + * All fields in @bflow must be set up. Note that @bflow->dev is used to add the
> > > > + * bootflow to that device.
> > > > + *
> > > > + * The bootflow is also added to the global list of all bootflows
> > > > + *
> > > > + * @dev: Bootdev device to add to
> > >
> > > This parameter does not exist.
> > >
> > > > + * @bflow: Bootflow to add. Note that fields within bflow must be allocated
> > > > + *   since this function takes over ownership of these. This functions makes
> > > > + *   a copy of @bflow itself (without allocating its fields again), so the
> > > > + *   caller must dispose of the memory used by the @bflow pointer itself
> > >
> > > Please, add the headers to the API documentation and fix the numerous
> > > documentation issues like:
> > >
> > > ./include/bootdev.h:57: warning: Enum value 'BOOTDEVP_0_NONE' not
> > > described in enum 'bootdev_prio_t'
> > > ./include/bootdev.h:57: warning: Enum value 'BOOTDEVP_1_PRE_SCAN' not
> > > described in enum 'bootdev_prio_t'
> > > ./include/bootdev.h:57: warning: Enum value 'BOOTDEVP_COUNT' not
> > > described in enum 'bootdev_prio_t'
> > > ./include/bootdev.h:57: warning: Excess enum value 'BOOTDEVP_6_PRE_SCAN'
> > > description in 'bootdev_prio_t'
> > > ./include/bootdev.h:118: warning: Function parameter or member
> > > 'bootflow_head' not described in 'bootdev_uc_plat'
> > > ./include/bootdev.h:118: warning: Function parameter or member 'prio'
> > > not described in 'bootdev_uc_plat'
> > > ./include/bootdev.h:412: warning: Function parameter or member 'blk' not
> > > described in 'bootdev_setup_for_sibling_blk'
> > > ./include/bootdev.h:412: warning: Excess function parameter 'parent'
> > > description in 'bootdev_setup_for_sibling_blk'
> >
> > I don't mind doing that in a follow-up once this series is in, but it
> > is out-of-scope here.
>
> I think that's flipping the priorities. Documenting what all of this is
> supposed to be doing will help explain to the rest of us what you're
> intending to do and why it's a good idea and so forth.

The request was to add the header file into sphinx, which is certainly
out of scope for this series. Do you agree?

This series is documented in doc. and bootstd is extremely well
documented. I'm happy of course to fix up the problem introduced by
this patch, but bringing all the headers (there are at least 4) into
Sphinx should be a separate task.

Regards,
Simon
