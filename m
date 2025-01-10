Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5B0E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 13:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F5A801F5;
	Fri, 10 Jan 2025 14:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ET/3smWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64BCB801F5; Fri, 10 Jan 2025 14:41:32 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04094800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216281bc30fso40165095ad.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736516488; x=1737121288; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KDeWhcCz2P5kp6T9mAA0fRT1X5rb5HcU9Jkn4MZbO0M=;
 b=ET/3smWM1EOi1iQO5VbWCMjuDHVpzfTf8bep5zaaC6bIxxusTmfA18CfgIzBZCXwcu
 ceO1Zmeh8J99AkPSRCuvvlwV7lb5juiHgjLHi7F88DYMAF/S5tA7CMkjLSzu2sBXF2hm
 OE09LSw4dRdbP+jB6oRoCpJTBjQbdVprILH3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736516488; x=1737121288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KDeWhcCz2P5kp6T9mAA0fRT1X5rb5HcU9Jkn4MZbO0M=;
 b=DlROkuiLAR47l3mHzMcoeXILqo40Z0HvL7quzjNAoQdEMHyb0g+ImMrG0FkS3jPEZY
 KL84Nqb715iVBu/5NE7ee676oEDke5808amVdCcUREbyI6zyMuDxDCTNG6Q35ulninYz
 dVN9db1U1L3VXdv8ihmtusnFJwpDxwTUZodlY7ssxBgqDUjX1hWbPz4i1hBJOHIY3F3l
 SnbGpxhRX+k4dRAAxGt/3vlX3CJ4FT1reBz95sr3q0eBRGDrVg2FqIKz02mlqXTy8RF/
 tjHOlf/HM0kM1Zl/APMQoNFHq8S9cxEo5vQB8/hzD4v9iZzYu2e5fB9pbTGRN16bNvud
 b75Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVaO0g4jJiDh8P0aI/hEEBa2r03C3ixIqNX4TLwwcv3aT9HvaqpFGlIk10srcj4rhxGbcFXcw=@lists.denx.de
X-Gm-Message-State: AOJu0YytJblMFZaKTYH6kXMVhE39yM3d3V2NKssgtNOu4VFKcZxHqmfn
 WDPEImAJqMvDB1vX+tOASqzWfCN//JU8WOVqLJWr50A1eSuf4WtYlT2crNpON2K+seNZPVO4bd6
 lGzv4sw2gxlGgbFlvx2s1nFo9YGXTX1++KAiF
X-Gm-Gg: ASbGncsa9ivkWccNWQRqOBDlJaYa8BmH01T0TyE4VJZsoeXuvygcxTsXF0hQKHwM3Ga
 wE3+Ibygg7N4JBZViyim6w2rBDFs8ypKCsnY5ilY=
X-Google-Smtp-Source: AGHT+IEZ7R7AWP9GQfatVAxTUsqpcjVKuJvQCOiQ6GKP7WDQ7SEPld84kbUBtRTDSDWbvTsqULxHAz/uQi0O1VTuOIw=
X-Received: by 2002:a17:90b:5483:b0:2ea:3d2e:a0d7 with SMTP id
 98e67ed59e1d1-2f548f2a897mr17063536a91.15.1736516488577; Fri, 10 Jan 2025
 05:41:28 -0800 (PST)
MIME-Version: 1.0
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-5-sjg@chromium.org>
 <517d087e-4ac5-4fd5-a37f-d4d3aaa534bd@gmx.de>
 <CAFLszTjbDHvMvv3U+SaW0_7b4oajW8RRf6KYbF_jex34en6ByA@mail.gmail.com>
 <20250109150454.GT3476@bill-the-cat>
 <CAFLszTgtP5vXT+HsvHP8i50KihetHf2-h3KPp2-f6M4XJ3+i8g@mail.gmail.com>
 <20250109152234.GW3476@bill-the-cat>
In-Reply-To: <20250109152234.GW3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Jan 2025 06:41:00 -0700
X-Gm-Features: AbW1kvZ8CzKX1oUG-ic2ECSx1GY2Y3iGSXssyQxt-1iWY8UkCZF7sWdxiWy9ZB8
Message-ID: <CAFLszThy9OkfMMbbyzUvWF19rvTRk64q62J+Lhk=U0VABwZNbQ@mail.gmail.com>
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

On Thu, 9 Jan 2025 at 08:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 09, 2025 at 08:11:58AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 9 Jan 2025 at 08:05, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jan 09, 2025 at 08:01:13AM -0700, Simon Glass wrote:
> > > > Hi Heinrich,
> > > >
> > > > On Sat, 4 Jan 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >
> > > > > On 11/13/24 16:09, Simon Glass wrote:
> > > > > > This is another option to fix sunxi booting with bootstd, which may be
> > > > > > better since it will work for all boards. We can then figure out how to
> > > > > > automatically and deterministicaly decide when bootmgr should be used.
> > > > > >
> > > > > > This reverts commit f2bfa0cb17948aa4a0fa20fdf9014296b9c4d9c7.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > > If this patch is applied, we don't need to drop bootmgr for sunxi
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >   boot/bootmeth_efi_mgr.c | 18 +-----------------
> > > > > >   1 file changed, 1 insertion(+), 17 deletions(-)avilable
> > > > > >
> > > > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > > > > index 23ae1e610ac..095fa74fc60 100644
> > > > > > --- a/boot/bootmeth_efi_mgr.c
> > > > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > > > @@ -14,8 +14,6 @@
> > > > > >   #include <command.h>
> > > > > >   #include <dm.h>
> > > > > >   #include <efi_loader.h>
> > > > > > -#include <efi_variable.h>
> > > > > > -#include <malloc.h>
> > > > > >
> > > > > >   /**
> > > > > >    * struct efi_mgr_priv - private info for the efi-mgr driver
> > > > > > @@ -48,27 +46,13 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
> > > > > >   static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> > > > > >   {
> > > > > >       struct efi_mgr_priv *priv = dev_get_priv(dev);
> > > > > > -     efi_status_t ret;
> > > > > > -     efi_uintn_t size;
> > > > > > -     u16 *bootorder;
> > > > > >
> > > > > >       if (priv->fake_dev) {
> > > > > >               bflow->state = BOOTFLOWST_READY;
> > > > > >               return 0;
> > > > > >       }
> > > > > >
> > > > > > -     ret = efi_init_obj_list();
> > > > > > -     if (ret)
> > > > > > -             return log_msg_ret("init", ret);
> > > > > > -
> > > > > > -     /* Enable this method if the "BootOrder" UEFI exists. */
> > > > > > -     bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
> > > > > > -                             &size);
> > > > > > -     if (bootorder) {
> > > > > > -             free(bootorder);
> > > > > > -             bflow->state = BOOTFLOWST_READY;
> > > > > > -             return 0;
> > > > > > -     }
> > > > > > +     /* To be implemented */
> > > > >
> > > > > The EFI boot manager can boot based on:
> > > > >
> > > > > * variable BootOrder
> > > > > * variable BootNext
> > > > > * an existing file EFI/BOOT/BOOT<arch>.EFI
> > > > >
> > > > > It obsoletes bootsmeth_efi.
> > > > >
> > > > > >
> > > > > >       return -EINVAL;
> > > > >
> > > > > We must always run the EFI boot manager if it is enabled. So -EINVAL is
> > > > > wrong here.
> > > >
> > > > Well, I don't believe you have a solution, then.
> > > >
> > > > You did suggest putting bootmgr later, as we discussed on irc.
> > > >
> > > > For now, I think we should apply this patch (and series), while we
> > > > sort out how to make bootmgr more incremental. It should not be
> > > > scanning every available device before it starts, since that can be
> > > > very slow.
> > >
> > > Heinrich and I talked the other day, and we think the right path is the
> > > "later" path, where we don't try and use efi bootmanager until
> > > everything has been probed, and also drop the single "efi" option. This
> > > should mean that by the time we would be trying efi bootmanager most if
> > > not everything that needs to be probed has been probed. It doesn't make
> > > any sense to have "efi bootmanger" be more incremental as conceptually
> > > it's point is to show the user all the options.
> >
> > What is the single 'efi' option? I hope you don't mean the EFI bootmeth.
>
> Yes, the single EFI bootmeth. Because part of the issue with that is to
> be compliant a bunch of things need to be probed. And rather than have
> an option to be only semi-compliant, the preference is to be compliant
> and just tried later in the boot sequence.

Well then you need a way to disable the single EFI bootmeth?

>
> > Putting bootmanager at the very end is OK with me, if we really cannot
> > figure out a way to know whether the system is using it or now. It is
> > 'putting it in the middle' that I don't like.
>
> In the case of no specified boot order, after block (and after very
> special things like FEL) and before network is what makes the most
> sense. We don't need to try and DHCP/etc for it, just need to know if
> the interface exists (and so the user can say / have configured, to try
> and boot it).

Apart from FEL, we also have ChromeOS, Android, QFW.

>
> > How to handle the case where bootorder only specifies a subset of
> > options? Ideally we would just probe devices related to that subset.
> > That is what I was getting at.
>
> Yes, that should work just fine, especially if we're in the middle?
>
> The big challenge here is that conceptually, "bootstd" and "efi
> bootmanager" are duplicate functionality. They are both "figure out what
> on the system we should boot". The compromise is to try "bootstd" on
> block devices first (the common case).

Are we trying to make boot slower?

A better way to design this would be to integrate the EFI stuff with
bootstd, rather than duplicating things. For example, a way to convert
a BOOTxxxx device into a bootdev would permit faster booting, since we
can just work through the boot order and request each device in turn.

Once we give up on that and ask the user, we need to probe all devices.

The monolithic init of EFI_LOADER is creating quite a few problems. Am
I the only one that sees it?

Regards,
Simon
