Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BF5C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D823387006;
	Sun, 12 Nov 2023 21:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oJegl8fG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A6787124; Sun, 12 Nov 2023 21:03:01 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92BBA86BF7
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d865854ef96so3824358276.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819378; x=1700424178; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Wxu1J9n2Jhfd09V849B25OzokPYA1v5hfP+uctr6dk=;
 b=oJegl8fG1XcIpAvXynnZUzDDO+iP5m8hskzo0lnAU7QPxlvGPFw+DHJ6E2glg4aU4A
 8axxhaKjMdwaHPVG+4Okogk4wDV/m9DTlBd5m9Nk+LZNHfbH5ufvQP8u25+b8djnBXpq
 NL1sH0lAeZdpN3IVOPJPw6VSt/FOGrKPAZNfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819378; x=1700424178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Wxu1J9n2Jhfd09V849B25OzokPYA1v5hfP+uctr6dk=;
 b=rdt1pLsKdFAb7O5mt0ZwTk70uykFTGJYa8908/osJrRpUxDanTKVnwRRbTXFZvEbog
 9kd4ZmKMZMKhReKspjitsOBaZNsRJTzGNy+lSOWG65zC9+Y94/nFHR08ekzAy7beobB5
 Ijs7sQCRMVCkfzLfiNq0kXCF/VjXM/lDjHilXBTiP/6JtdlmHxfu7x3cQBccBh5EnsCE
 cXzCEsaoDSaCl7g5ecZgpVKfAcMoXH32dKgv6EUJfXIlUkfQrFvlIvQA8/abJMHXofNs
 kc7SyKLHCda4T/skIOg9AnfrR/oekanlUIF9YABuHEReIsIBbrNCCOcsM+rSRAptYaPn
 rNHQ==
X-Gm-Message-State: AOJu0Yw/qBctyTsdq+gVVApBf+hZqfFd95OXla7hYDOg1p2M+wtJUzp/
 AQGEZ2PaZe5oVDzIL7xroOtSQFg0mjOEUV7N/SlSeZIQWx+P4GY/BKs=
X-Google-Smtp-Source: AGHT+IELLHAQpWdV/HM9cPBUuhf2uOjXFGuWQsEztxS0LZIeIc+jp2KrOL9WietOYtOsi6uq9RM+G3eMqWWqQ5nJUAs=
X-Received: by 2002:a25:ad27:0:b0:d9a:5ff4:cfde with SMTP id
 y39-20020a25ad27000000b00d9a5ff4cfdemr4609305ybi.13.1699819378126; Sun, 12
 Nov 2023 12:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20230922213819.1886094-1-sjg@chromium.org>
 <20230922153814.v2.4.If206027372f73ce32480223e5626f4b944e281b7@changeid>
 <8734z4974a.fsf@baylibre.com>
In-Reply-To: <8734z4974a.fsf@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:12 -0700
Message-ID: <CAPnjgZ1HY8rJvx9TG+BVV3gQdR32N7cUNP76ZwkPYneqmr0XhA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] usb: Avoid unbinding devices in use by bootflows
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
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

Hi Mattijs,

On Sat, 23 Sept 2023 at 10:39, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Simon,
>
> Thank you for your patch.

Thanks for reviewing it!

>
> On ven., sept. 22, 2023 at 15:38, Simon Glass <sjg@chromium.org> wrote:
>
> > When a USB device is unbound, it causes any bootflows attached to it to
> > be removed, via a call to bootdev_clear_bootflows() from
> > bootdev_pre_unbind(). This obviously makes it impossible to boot the
> > bootflow.
> >
> > However, when booting a bootflow that relies on USB, usb_stop() is
> > called, which unbinds the device. For EFI, this happens in
> > efi_exit_boot_services() which means that the bootflow disappears
> > before it is finished with.
> >
> > There is no need to unbind all the USB devices just to quiesce them.
> > Add a new usb_pause() call which removes them but leaves them bound.
> >
> > This resolves a hang on x86 when booting a distro from USB. This was
> > found using a device with 4 bootflows, the last of which was USB.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Add new patch to avoid unbinding devices in use by bootflows
> >
> >  boot/bootm.c                  |  2 +-
> >  common/usb.c                  |  7 ++++++-
> >  drivers/usb/host/usb-uclass.c | 14 ++++++++++++--
> >  include/usb.h                 | 15 ++++++++++++++-
> >  4 files changed, 33 insertions(+), 5 deletions(-)
> >
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > index b1c3afe0a3a..5c9ba083e64 100644
> > --- a/boot/bootm.c
> > +++ b/boot/bootm.c
> > @@ -501,7 +501,7 @@ ulong bootm_disable_interrupts(void)
> >        * updated every 1 ms within the HCCA structure in SDRAM! For more
> >        * details see the OpenHCI specification.
> >        */
> > -     usb_stop();
> > +     usb_pause();
> >  #endif
> >       return iflag;
> >  }
> > diff --git a/common/usb.c b/common/usb.c
> > index 836506dcd9e..4d6ac69111e 100644
> > --- a/common/usb.c
> > +++ b/common/usb.c
> > @@ -126,7 +126,7 @@ int usb_init(void)
> >  /******************************************************************************
> >   * Stop USB this stops the LowLevel Part and deregisters USB devices.
> >   */
> > -int usb_stop(void)
> > +int usb_pause(void)
>
> nit: I know this is the "legacy" (pre-DM) stuff, but isn't renaming the above
> function making the comment wrong?
>
> Can't we keep this function usb_stop() and create another one named
> usb_pause() which calls usb_stop() ?

I missed this comment but will do this for v4.

>
> >  {
> >       int i;
> >
> > @@ -144,6 +144,11 @@ int usb_stop(void)
> >       return 0;
> >  }
> >
> > +int usb_stop(void)
> > +{
> > +     return usb_pause();
> > +}
> > +
> >  /******************************************************************************
> >   * Detect if a USB device has been plugged or unplugged.
> >   */
> > diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
> > index a1cd0ad2d66..c26c65d7986 100644
> > --- a/drivers/usb/host/usb-uclass.c
> > +++ b/drivers/usb/host/usb-uclass.c
> > @@ -173,7 +173,7 @@ int usb_get_max_xfer_size(struct usb_device *udev, size_t *size)
> >       return ops->get_max_xfer_size(bus, size);
> >  }
> >
> > -int usb_stop(void)
> > +static int usb_finish(bool unbind_all)
> >  {
> >       struct udevice *bus;
> >       struct udevice *rh;
> > @@ -195,7 +195,7 @@ int usb_stop(void)
> >
> >               /* Locate root hub device */
> >               device_find_first_child(bus, &rh);
> > -             if (rh) {
> > +             if (rh && unbind_all) {
> >                       /*
> >                        * All USB devices are children of root hub.
> >                        * Unbinding root hub will unbind all of its children.
> > @@ -222,6 +222,16 @@ int usb_stop(void)
> >       return err;
> >  }
> >
> > +int usb_stop(void)
> > +{
> > +     return usb_finish(true);
> > +}
> > +
> > +int usb_pause(void)
> > +{
> > +     return usb_finish(false);
> > +}
>
> What happens if someone calls usb_pause() followed by usb_init() on a
> root hub ?
>
> I think it behaves properly because usb_init() calls
> remove_inactive_children().

I'm not sure about that. The USB enumeration binds new devices, which
is why we unbind them before enumerating.

remove_inactive_children() only removes them (makes them inactive /
unprobed). It does not unbind them.

>
> > +
> >  static void usb_scan_bus(struct udevice *bus, bool recurse)
> >  {
> >       struct usb_bus_priv *priv;
> > diff --git a/include/usb.h b/include/usb.h
> > index 09e3f0cb309..ad39b09a6e4 100644
> > --- a/include/usb.h
> > +++ b/include/usb.h
> > @@ -265,7 +265,20 @@ int usb_kbd_deregister(int force);
> >   */
> >  int usb_init(void);
> >
> > -int usb_stop(void); /* stop the USB Controller */
> > +/**
> > + * usb_stop() - stop the USB Controller and unbind all USB controllers/devices
> > + *
> > + * Return: 0 if OK, -ve on error
> > + */
> > +int usb_stop(void);
> > +
> > +/**
> > + * usb_pause() - stop the USB Controller DMA, etc.
> > + *
> > + * Return: 0 if OK, -ve on error
> > + */
> > +int usb_pause(void);
> > +
> >  int usb_detect_change(void); /* detect if a USB device has been (un)plugged */
> >
> >
> > --
> > 2.42.0.515.g380fc7ccd1-goog

Regards,
Simon
