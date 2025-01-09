Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E742E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 186C780602;
	Thu,  9 Jan 2025 16:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jAoHv5g/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D89AD8066C; Thu,  9 Jan 2025 16:12:18 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79F6F805E2
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so1432422a91.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736435535; x=1737040335; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cw1NRIWqGCu3mZjQmjezK2NlJ4hcJkAPbRYFhDGtL2U=;
 b=jAoHv5g/FHcmIHAoTg32ikEmaXcwB4v+ri0mdOD1E6g6QtqYl6FIM5Ad8z6f7HkAZ0
 UXY5xbcd022gVAC3UAI/4HrPB15Z0eZS5kH7YIv3m0L0ZcUghr0aD7UagRsCr+UXbVJ2
 stotYPGpZU43DcL8CFtSggkQeXuxVGehJD8P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736435535; x=1737040335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cw1NRIWqGCu3mZjQmjezK2NlJ4hcJkAPbRYFhDGtL2U=;
 b=jWyAy6zhPZt+gvV54BFQK4EeaNChr2JyOOQ43H8D+jGYJJghQQuJIq6PojK5eVGPw3
 GBZhNP80Mh4xTYbhAViWHcEt0jWWsfuXtmkHh/wTRL0/FVgsG7rHLU+1npGv8eWAWAhP
 4q+5j3zcKRMeFrmojQKgEzEMZCbSU/6lKJvHTWbOSUkp8RTLgE2fc2zKEZ5vpJXDij4k
 ziXf4KLhWmRjDH18YD2cxIOescdjwsNIeOhz8SBxBY4c0PcmAZfYkuBwXvQlDi+xxdsy
 loP6UxiKl+7Ok0+/uFBYoDB4Oy6/QMj9CRVVhqDAoJKa8qGUN4t7FTDcqOBEcCXwbLAQ
 isfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/E24CC+rld1/LPwniA6UB+FFEX2ujeUTjfJrC7NQraYUaXwIOj/16P5vxvfl2y3PiQGKi3CI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy051kmS5TtH/45BB2YehgyMP+7qT3P2I29tbgsrZAV9CpV1Xkm
 hon0jwKFfEWrQJPQhRerUgS4d6N+5RmB02yMlCXnieZTTz0e7E2mNhQe4cKIkuOxDUOKAq/1QPo
 WP7lxbhY647ky1v7oudKCMEzLZrFs0lytCXf3NOjXFs03NCM=
X-Gm-Gg: ASbGnctM3YIZOekzBNjzwECEbEEwf+7Bk6JpLjqHmeQw5MKRWlw1h8Gh80Dn5G/AwzY
 wJYJ8r9CJwmdLZzk4jtaZFM/rhC8gwoXX7YK58A4=
X-Google-Smtp-Source: AGHT+IG7e+3rQvBSsfVzpiS2cCYGvRLdN3u/5+KnuxYuKPE55yZQ8LsX/49OREPwPNwEKAZ/Ypx+DJfKdS3vOADCr4A=
X-Received: by 2002:a17:90b:2748:b0:2f1:30c8:6e75 with SMTP id
 98e67ed59e1d1-2f5490e89e0mr9024850a91.32.1736435535005; Thu, 09 Jan 2025
 07:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-5-sjg@chromium.org>
 <517d087e-4ac5-4fd5-a37f-d4d3aaa534bd@gmx.de>
 <CAFLszTjbDHvMvv3U+SaW0_7b4oajW8RRf6KYbF_jex34en6ByA@mail.gmail.com>
 <20250109150454.GT3476@bill-the-cat>
In-Reply-To: <20250109150454.GT3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 08:11:58 -0700
X-Gm-Features: AbW1kvbP2KdfuBg6REtX0zWT7ChngKYfEmXSe9a2WDsqNc1a0z7KDOYRf-TpvzM
Message-ID: <CAFLszTgtP5vXT+HsvHP8i50KihetHf2-h3KPp2-f6M4XJ3+i8g@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] RFC: Revert "bootstd: Make efi_mgr bootmeth work
 for non-sandbox setups"
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
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

Hi Tom,

On Thu, 9 Jan 2025 at 08:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 09, 2025 at 08:01:13AM -0700, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sat, 4 Jan 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 11/13/24 16:09, Simon Glass wrote:
> > > > This is another option to fix sunxi booting with bootstd, which may be
> > > > better since it will work for all boards. We can then figure out how to
> > > > automatically and deterministicaly decide when bootmgr should be used.
> > > >
> > > > This reverts commit f2bfa0cb17948aa4a0fa20fdf9014296b9c4d9c7.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > > If this patch is applied, we don't need to drop bootmgr for sunxi
> > > >
> > > > (no changes since v1)
> > > >
> > > >   boot/bootmeth_efi_mgr.c | 18 +-----------------
> > > >   1 file changed, 1 insertion(+), 17 deletions(-)avilable
> > > >
> > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > > index 23ae1e610ac..095fa74fc60 100644
> > > > --- a/boot/bootmeth_efi_mgr.c
> > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > @@ -14,8 +14,6 @@
> > > >   #include <command.h>
> > > >   #include <dm.h>
> > > >   #include <efi_loader.h>
> > > > -#include <efi_variable.h>
> > > > -#include <malloc.h>
> > > >
> > > >   /**
> > > >    * struct efi_mgr_priv - private info for the efi-mgr driver
> > > > @@ -48,27 +46,13 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
> > > >   static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> > > >   {
> > > >       struct efi_mgr_priv *priv = dev_get_priv(dev);
> > > > -     efi_status_t ret;
> > > > -     efi_uintn_t size;
> > > > -     u16 *bootorder;
> > > >
> > > >       if (priv->fake_dev) {
> > > >               bflow->state = BOOTFLOWST_READY;
> > > >               return 0;
> > > >       }
> > > >
> > > > -     ret = efi_init_obj_list();
> > > > -     if (ret)
> > > > -             return log_msg_ret("init", ret);
> > > > -
> > > > -     /* Enable this method if the "BootOrder" UEFI exists. */
> > > > -     bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
> > > > -                             &size);
> > > > -     if (bootorder) {
> > > > -             free(bootorder);
> > > > -             bflow->state = BOOTFLOWST_READY;
> > > > -             return 0;
> > > > -     }
> > > > +     /* To be implemented */
> > >
> > > The EFI boot manager can boot based on:
> > >
> > > * variable BootOrder
> > > * variable BootNext
> > > * an existing file EFI/BOOT/BOOT<arch>.EFI
> > >
> > > It obsoletes bootsmeth_efi.
> > >
> > > >
> > > >       return -EINVAL;
> > >
> > > We must always run the EFI boot manager if it is enabled. So -EINVAL is
> > > wrong here.
> >
> > Well, I don't believe you have a solution, then.
> >
> > You did suggest putting bootmgr later, as we discussed on irc.
> >
> > For now, I think we should apply this patch (and series), while we
> > sort out how to make bootmgr more incremental. It should not be
> > scanning every available device before it starts, since that can be
> > very slow.
>
> Heinrich and I talked the other day, and we think the right path is the
> "later" path, where we don't try and use efi bootmanager until
> everything has been probed, and also drop the single "efi" option. This
> should mean that by the time we would be trying efi bootmanager most if
> not everything that needs to be probed has been probed. It doesn't make
> any sense to have "efi bootmanger" be more incremental as conceptually
> it's point is to show the user all the options.

What is the single 'efi' option? I hope you don't mean the EFI bootmeth.

Putting bootmanager at the very end is OK with me, if we really cannot
figure out a way to know whether the system is using it or now. It is
'putting it in the middle' that I don't like.

How to handle the case where bootorder only specifies a subset of
options? Ideally we would just probe devices related to that subset.
That is what I was getting at.

Regards,
Simon
