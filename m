Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FC3C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210F3800C2;
	Wed, 15 Jan 2025 14:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YHFXO+tQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D55280214; Wed, 15 Jan 2025 14:22:56 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE2F80040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3f65844deso10932358a12.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947374; x=1737552174; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XjckX0jnYMieB2wXp400b5WzGKpGylvUqZVHqzd3ano=;
 b=YHFXO+tQZlNYynzHCfuyIOGidLJV3Ex6E8WF3JTBFAsibtAcVSKytqRbM7BnTDcMW2
 s0P7vvWCaqF7iwkZjqw4OSOKYTQDvXzw+5lGcij8CFt0ywOzHLNbQG0X7I5r6b29yAjP
 cwZqYngDS3bMLGUUBFaLKwP0loeLcwFJwv9dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947374; x=1737552174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XjckX0jnYMieB2wXp400b5WzGKpGylvUqZVHqzd3ano=;
 b=fpRMOLxZsppx95UE5icIy0K/5t/5RAzDTx07DixvQjAVoMkkURNZ8RNV46XLM6+lzv
 DzQ0PudxJeXq6EnmT6goA1AUQjakbLg1MR39K1VZVFa5I+4I4zHByQDwqrOFE7McxALP
 F9Yuo27vEOcZXmw2/vxK1CzQ/xvMMxULmaZ49wWcG1kvZ1U9EsVjuyZGmrrrKoMBI6lz
 DL8lbhe443M8m3gfHgWuZsz50oyCVL6tHNsTq1jxzt9yI7J3YJWVnO33Dzh/rcGIuipd
 MiR8v2719uqZjuEpRXfdnAqty3iDoew8PL/8UEHZk00YFSzHlxM6hkzYVMF8Rrun+PZy
 Jk4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaML70dHqnJilKn+ipMY9FVNQxuzghjE8nOmBuikTBSskHq8dtriWrBiA0KaXnj7PN5RMhtt8=@lists.denx.de
X-Gm-Message-State: AOJu0YwlbdTHA39NO2Ck++B101GIqk5aNjJX+/M0sgJD4MlOLFg12dCM
 zszivdMi3fOoD/aQnqnYnOvaGEOliNU0eMsqnMzIO1nZC7V3ECYCgZ3bWsBy4JJlAtgUbj1XJsp
 14zyNZv1BJqGkWKTWQa0CpjPk3bR63+hmAQqx
X-Gm-Gg: ASbGncu9t3pMRbMlOe5z2ZsoPXbXEg/Z4vFs8LSBUTqBpF+YWtoVoRcal/vrp7djY0U
 F8r1W5uG34yC9kbB9uIBUPWfYJpMzQc7tYKnv2EQ=
X-Google-Smtp-Source: AGHT+IGfUuyXxYOgtWbLjvz+uybZ+02KHGxVIeYNMLScP7fqd4QxdiNY5I+dVWSrZlQhrQHC3iZh2PutQ2HBI4lsjE0=
X-Received: by 2002:a17:907:97c1:b0:ab2:db7b:5db3 with SMTP id
 a640c23a62f3a-ab2db7b5ee7mr1783090766b.54.1736947373735; Wed, 15 Jan 2025
 05:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-5-sjg@chromium.org>
 <517d087e-4ac5-4fd5-a37f-d4d3aaa534bd@gmx.de>
 <CAFLszTjbDHvMvv3U+SaW0_7b4oajW8RRf6KYbF_jex34en6ByA@mail.gmail.com>
 <20250109150454.GT3476@bill-the-cat>
 <CAFLszTgtP5vXT+HsvHP8i50KihetHf2-h3KPp2-f6M4XJ3+i8g@mail.gmail.com>
 <20250109152234.GW3476@bill-the-cat>
 <CAFLszThy9OkfMMbbyzUvWF19rvTRk64q62J+Lhk=U0VABwZNbQ@mail.gmail.com>
 <20250110170531.GK3476@bill-the-cat>
In-Reply-To: <20250110170531.GK3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 06:22:40 -0700
X-Gm-Features: AbW1kvYnx1SHRGdLPLgbVEnDF1RNtAaobBa1E48T59rKmUEOVdlhlFdBKm0nugU
Message-ID: <CAFLszTgHe5ZOvD_6w=hGhA2E97kPXxLS7tPPZWMm0_w4gGn58A@mail.gmail.com>
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

On Fri, 10 Jan 2025 at 10:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jan 10, 2025 at 06:41:00AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 9 Jan 2025 at 08:22, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jan 09, 2025 at 08:11:58AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 9 Jan 2025 at 08:05, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Jan 09, 2025 at 08:01:13AM -0700, Simon Glass wrote:
> > > > > > Hi Heinrich,
> > > > > >
> > > > > > On Sat, 4 Jan 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > >
> > > > > > > On 11/13/24 16:09, Simon Glass wrote:
> > > > > > > > This is another option to fix sunxi booting with bootstd, which may be
> > > > > > > > better since it will work for all boards. We can then figure out how to
> > > > > > > > automatically and deterministicaly decide when bootmgr should be used.
> > > > > > > >
> > > > > > > > This reverts commit f2bfa0cb17948aa4a0fa20fdf9014296b9c4d9c7.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > > If this patch is applied, we don't need to drop bootmgr for sunxi
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > >   boot/bootmeth_efi_mgr.c | 18 +-----------------
> > > > > > > >   1 file changed, 1 insertion(+), 17 deletions(-)avilable
> > > > > > > >
> > > > > > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > > > > > > index 23ae1e610ac..095fa74fc60 100644
> > > > > > > > --- a/boot/bootmeth_efi_mgr.c
> > > > > > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > > > > > @@ -14,8 +14,6 @@
> > > > > > > >   #include <command.h>
> > > > > > > >   #include <dm.h>
> > > > > > > >   #include <efi_loader.h>
> > > > > > > > -#include <efi_variable.h>
> > > > > > > > -#include <malloc.h>
> > > > > > > >
> > > > > > > >   /**
> > > > > > > >    * struct efi_mgr_priv - private info for the efi-mgr driver
> > > > > > > > @@ -48,27 +46,13 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
> > > > > > > >   static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> > > > > > > >   {
> > > > > > > >       struct efi_mgr_priv *priv = dev_get_priv(dev);
> > > > > > > > -     efi_status_t ret;
> > > > > > > > -     efi_uintn_t size;
> > > > > > > > -     u16 *bootorder;
> > > > > > > >
> > > > > > > >       if (priv->fake_dev) {
> > > > > > > >               bflow->state = BOOTFLOWST_READY;
> > > > > > > >               return 0;
> > > > > > > >       }
> > > > > > > >
> > > > > > > > -     ret = efi_init_obj_list();
> > > > > > > > -     if (ret)
> > > > > > > > -             return log_msg_ret("init", ret);
> > > > > > > > -
> > > > > > > > -     /* Enable this method if the "BootOrder" UEFI exists. */
> > > > > > > > -     bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
> > > > > > > > -                             &size);
> > > > > > > > -     if (bootorder) {
> > > > > > > > -             free(bootorder);
> > > > > > > > -             bflow->state = BOOTFLOWST_READY;
> > > > > > > > -             return 0;
> > > > > > > > -     }
> > > > > > > > +     /* To be implemented */
> > > > > > >
> > > > > > > The EFI boot manager can boot based on:
> > > > > > >
> > > > > > > * variable BootOrder
> > > > > > > * variable BootNext
> > > > > > > * an existing file EFI/BOOT/BOOT<arch>.EFI
> > > > > > >
> > > > > > > It obsoletes bootsmeth_efi.
> > > > > > >
> > > > > > > >
> > > > > > > >       return -EINVAL;
> > > > > > >
> > > > > > > We must always run the EFI boot manager if it is enabled. So -EINVAL is
> > > > > > > wrong here.
> > > > > >
> > > > > > Well, I don't believe you have a solution, then.
> > > > > >
> > > > > > You did suggest putting bootmgr later, as we discussed on irc.
> > > > > >
> > > > > > For now, I think we should apply this patch (and series), while we
> > > > > > sort out how to make bootmgr more incremental. It should not be
> > > > > > scanning every available device before it starts, since that can be
> > > > > > very slow.
> > > > >
> > > > > Heinrich and I talked the other day, and we think the right path is the
> > > > > "later" path, where we don't try and use efi bootmanager until
> > > > > everything has been probed, and also drop the single "efi" option. This
> > > > > should mean that by the time we would be trying efi bootmanager most if
> > > > > not everything that needs to be probed has been probed. It doesn't make
> > > > > any sense to have "efi bootmanger" be more incremental as conceptually
> > > > > it's point is to show the user all the options.
> > > >
> > > > What is the single 'efi' option? I hope you don't mean the EFI bootmeth.
> > >
> > > Yes, the single EFI bootmeth. Because part of the issue with that is to
> > > be compliant a bunch of things need to be probed. And rather than have
> > > an option to be only semi-compliant, the preference is to be compliant
> > > and just tried later in the boot sequence.
> >
> > Well then you need a way to disable the single EFI bootmeth?
>
> We have BOOTMETH_EFILOADER already.
>
> > > > Putting bootmanager at the very end is OK with me, if we really cannot
> > > > figure out a way to know whether the system is using it or now. It is
> > > > 'putting it in the middle' that I don't like.
> > >
> > > In the case of no specified boot order, after block (and after very
> > > special things like FEL) and before network is what makes the most
> > > sense. We don't need to try and DHCP/etc for it, just need to know if
> > > the interface exists (and so the user can say / have configured, to try
> > > and boot it).
> >
> > Apart from FEL, we also have ChromeOS, Android, QFW.
>
> OK? Yes, bootstd needs to handle "we're in a special update things
> state". I'm not sure if QFW counts as a faux-block device or not. And
> ChromeOS I would have thought is "try and boot like $this from $device".
> I don't know if by "Android" you mean booting the OS, or the AVB state
> machine. The former would be like ChromeOS and the latter the special
> state machine case.

Standard boot is designed as a generalisation of the boot process and
is able to cope with most use cases. Everything uses the same
algorithm, at a high level.

>
> > > > How to handle the case where bootorder only specifies a subset of
> > > > options? Ideally we would just probe devices related to that subset.
> > > > That is what I was getting at.
> > >
> > > Yes, that should work just fine, especially if we're in the middle?
> > >
> > > The big challenge here is that conceptually, "bootstd" and "efi
> > > bootmanager" are duplicate functionality. They are both "figure out what
> > > on the system we should boot". The compromise is to try "bootstd" on
> > > block devices first (the common case).
> >
> > Are we trying to make boot slower?
>
> We're already in the slow path, because we're making guesses. But no, we
> aren't trying to make anything slower. This should potentially faster in
> the non-EFI case since we won't be trying to EFI boot every block device
> until we have exhausted the non-EFI methods.
>
> > A better way to design this would be to integrate the EFI stuff with
> > bootstd, rather than duplicating things. For example, a way to convert
> > a BOOTxxxx device into a bootdev would permit faster booting, since we
> > can just work through the boot order and request each device in turn.
> >
> > Once we give up on that and ask the user, we need to probe all devices.
>
> No, we're trying to untangle "EFI", "EFI bootmanager" and "bootstd".

By neutering bootstd? It would be better to update EFI to make use of
bootdev, for example. Heinrich did a patch to use the 'hunt' feature
of bootdev.

>
> > The monolithic init of EFI_LOADER is creating quite a few problems. Am
> > I the only one that sees it?
>
> Yes, because your "monolithic init is a problem" is the subsystem
> maintainers "monolithic init makes us spec compliant".
>
> And when we're in some sort of "probe the device and see what can be
> booted" the subsystem maintainers would rather be spec compliant.

We don't need to be noncompliant with spec. But some thoughtful design
would help us a lot.

>
> And for the role I played in this confusion by suggesting how to
> integrate things privately and has now gone off the rails, I am sorry
> for the confusion and wasted efforts. I don't know if I was unclear or
> misspoke.

I'm not sure what that relates to?

Regards,
Simon
