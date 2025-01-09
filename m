Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9F9E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A4980107;
	Thu,  9 Jan 2025 16:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KTluX5mx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35EEB805E2; Thu,  9 Jan 2025 16:01:31 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91BFA8001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d437235769so1457107a12.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434887; x=1737039687; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f4Gj910Ocm96gi7HU5VSN5ZeGZjU1ikhXPb2Zte+8xU=;
 b=KTluX5mxJwk/52MHTKXnEFmHADblPhWWPMZJMQXIjZOscfXETljpbhbFIHmb8DQKXa
 26T8NqE6G8g9d82wjecRCEj7FD+1rACmEqAmP9WncDm5ta4jMXxSGcRFFX2qFj4/+d7Y
 fFkziX+A/HOE7i5JlWNQ9MNFxLP2lYAZI0yic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434887; x=1737039687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f4Gj910Ocm96gi7HU5VSN5ZeGZjU1ikhXPb2Zte+8xU=;
 b=SYcDMrpqFPj/kiSTfBHPk4+12c+3xuhjxdo/n9l3Ur44eb8GmPaaZ1oaqzaFl6cPI/
 hzAQvVAIPmAJ0qnMwYPki7pe/kec6Dgt8+ZiIPv/znn+94AW6kQq31tqDsyAIhCd5CR9
 B8KCk0nJXlkU2EvGpyk8SAu4zHoEjZ8K1icBwRd7XFMMn6XQaPij210oOPNdA+NB9UA/
 lRBSnFUoDeal0lov/J+QxT+++NimU70A9qS+eotXCtx/wV2kNGK1OH/kmjJKOqsqZk2T
 tZHSTa8+pS6kQJIuxV4iVAndoEsOgL1z2jRNmkq3/xuLXL5xRpRVPzjOljUzx27tdbxv
 Zejg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxcufszeDhgX0r7+/ENmRMb+GG+sujUdKtdtyilGxC6D5swABYgOH/kfiw8njDcX38LJVfMRY=@lists.denx.de
X-Gm-Message-State: AOJu0Yws88CqW17ToBHpWRPfyJC7NZjNX/tk6J1Esh/NZqoPkEUfcFE+
 08ue+9JAomSOekc4lbUC5bpZwjhcO6vdmR6lATTAYOQfkvpkSNbhn2ENKiZPu1K+F7oZmplZrVm
 s0fIZdMO5CQ1Q9I6H6HSAgFOi3bR7fGJGZAtQ
X-Gm-Gg: ASbGnctadSlc0NC1tRXS0D+qhg5XzXCFpRKPXTZu9z9fEMNaamXAxHpq0del2eNmtS+
 YQubyVIt70hazlTglyg7965+dnEeoFSSsZYXhKEY=
X-Google-Smtp-Source: AGHT+IG3NaG+g6WziBEFB0dB0gZx1za3IQjvGQjkszII3dkMjxGJ0tfvQE06CijQu7FVWDrBe6qcts2fqxSlgSd2WCc=
X-Received: by 2002:a05:6402:4416:b0:5cf:c33c:34cf with SMTP id
 4fb4d7f45d1cf-5d972e1c42amr6451897a12.15.1736434886679; Thu, 09 Jan 2025
 07:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-5-sjg@chromium.org>
 <517d087e-4ac5-4fd5-a37f-d4d3aaa534bd@gmx.de>
In-Reply-To: <517d087e-4ac5-4fd5-a37f-d4d3aaa534bd@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 08:01:13 -0700
X-Gm-Features: AbW1kvbfZ1L_ztTxlN3rBW538WnysTxjyZONu7fNfiOjTH7O18nA9s_wsI84I8g
Message-ID: <CAFLszTjbDHvMvv3U+SaW0_7b4oajW8RRf6KYbF_jex34en6ByA@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] RFC: Revert "bootstd: Make efi_mgr bootmeth work
 for non-sandbox setups"
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>,
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

Hi Heinrich,

On Sat, 4 Jan 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/13/24 16:09, Simon Glass wrote:
> > This is another option to fix sunxi booting with bootstd, which may be
> > better since it will work for all boards. We can then figure out how to
> > automatically and deterministicaly decide when bootmgr should be used.
> >
> > This reverts commit f2bfa0cb17948aa4a0fa20fdf9014296b9c4d9c7.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> > If this patch is applied, we don't need to drop bootmgr for sunxi
> >
> > (no changes since v1)
> >
> >   boot/bootmeth_efi_mgr.c | 18 +-----------------
> >   1 file changed, 1 insertion(+), 17 deletions(-)avilable
> >
> > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > index 23ae1e610ac..095fa74fc60 100644
> > --- a/boot/bootmeth_efi_mgr.c
> > +++ b/boot/bootmeth_efi_mgr.c
> > @@ -14,8 +14,6 @@
> >   #include <command.h>
> >   #include <dm.h>
> >   #include <efi_loader.h>
> > -#include <efi_variable.h>
> > -#include <malloc.h>
> >
> >   /**
> >    * struct efi_mgr_priv - private info for the efi-mgr driver
> > @@ -48,27 +46,13 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
> >   static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> >   {
> >       struct efi_mgr_priv *priv = dev_get_priv(dev);
> > -     efi_status_t ret;
> > -     efi_uintn_t size;
> > -     u16 *bootorder;
> >
> >       if (priv->fake_dev) {
> >               bflow->state = BOOTFLOWST_READY;
> >               return 0;
> >       }
> >
> > -     ret = efi_init_obj_list();
> > -     if (ret)
> > -             return log_msg_ret("init", ret);
> > -
> > -     /* Enable this method if the "BootOrder" UEFI exists. */
> > -     bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
> > -                             &size);
> > -     if (bootorder) {
> > -             free(bootorder);
> > -             bflow->state = BOOTFLOWST_READY;
> > -             return 0;
> > -     }
> > +     /* To be implemented */
>
> The EFI boot manager can boot based on:
>
> * variable BootOrder
> * variable BootNext
> * an existing file EFI/BOOT/BOOT<arch>.EFI
>
> It obsoletes bootsmeth_efi.
>
> >
> >       return -EINVAL;
>
> We must always run the EFI boot manager if it is enabled. So -EINVAL is
> wrong here.

Well, I don't believe you have a solution, then.

You did suggest putting bootmgr later, as we discussed on irc.

For now, I think we should apply this patch (and series), while we
sort out how to make bootmgr more incremental. It should not be
scanning every available device before it starts, since that can be
very slow.

Regards,
Simon
