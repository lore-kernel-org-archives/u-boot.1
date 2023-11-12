Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0014CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 21:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E3287103;
	Sun, 12 Nov 2023 22:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e+N6sRmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 374E0870F2; Sun, 12 Nov 2023 22:21:07 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2981987103
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 22:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9bf86b77a2aso572526766b.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699824062; x=1700428862; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BacqIDdrXliVd+j/J7huHIekmQY6pzygzoTmtVm/2ok=;
 b=e+N6sRmWFYtcLidCfoVE20My3AbI19cey9lFPAWrT60PjRFCybKrIow4TfSgHMhTDc
 jF244pJRoSKMdW2YTpx2MinpUDsoHYf8MSTA2Y6eJEZeCWbGGAMIxl81jQWP4Bqz66Im
 TktoSCV5doGuzxMyE3o5NTRqZ3dqVhsheoZXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699824062; x=1700428862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BacqIDdrXliVd+j/J7huHIekmQY6pzygzoTmtVm/2ok=;
 b=nJmv+1t9GJZbahXtGkC9CoFW91KqFlFVNn1Nn44ogyZwKIVcZtYkRR+dW5FW1iHvUQ
 qDuSKG6vdJQF26D9jH6KEfv+3IZEDpj8+4NszegV2CFalpSHTjYYag+F8jmB0gXzHXvY
 7cr8S6QAJS/7h8rxoyoDVj/Id0irZpXJ435SiAYYn6yBehQ/qYjF1Q9oWcCRo2bVgAUq
 TczPu3K06xrjbjj3U1qwzYFApUdZqd1Kk2zKBXNF+MXVDi5VfzHcBdVhqRwtkgqwlLXs
 dd4Lr8IfuGIaPY0JTQ6qwSEL+mPBDYoF8KXeGupiB42VRWhwAxk7PS3kZVAalCuT1O9H
 o11Q==
X-Gm-Message-State: AOJu0YyApy4+rcZOaTu/kOrVbnkiWVEI6BZJtyZkhMrxv0bEAtxbP6mf
 3DHoagL5i7Xxe5lz8zTvGyU8dMQIgRGLvLOjo/hLtQ==
X-Google-Smtp-Source: AGHT+IEXg5IWs94NH1e8OJsBMtL2aESXMLegCa0TGU8W1PRfy5vg7mxPGxLFUR8w9O4CVlaywhNciS3BWSt8jFssrYU=
X-Received: by 2002:a17:906:2515:b0:9c7:5667:5649 with SMTP id
 i21-20020a170906251500b009c756675649mr3380397ejb.73.1699824062439; Sun, 12
 Nov 2023 13:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
 <3F7DFCBC-D5A1-43C4-AF00-11C27BFF7508@gmx.de>
In-Reply-To: <3F7DFCBC-D5A1-43C4-AF00-11C27BFF7508@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 14:20:50 -0700
Message-ID: <CAPnjgZ3wEzHNqzpsF1zU6U4WBAm=oMYEzRRR-UuqDEwXB24rLw@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] usb: Avoid unbinding devices in use by bootflows
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
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

Hi Heinrich,

On Sun, 12 Nov 2023 at 13:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 12. November 2023 21:02:42 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >When a USB device is unbound, it causes any bootflows attached to it to
> >be removed, via a call to bootdev_clear_bootflows() from
> >bootdev_pre_unbind(). This obviously makes it impossible to boot the
> >bootflow.
> >
> >However, when booting a bootflow that relies on USB, usb_stop() is
> >called, which unbinds the device. For EFI, this happens in
> >efi_exit_boot_services() which means that the bootflow disappears
> >before it is finished with.
>
> After ExitBootServices() no driver of U-Boot can be used as the operating system is in charge.
>
> Any bootflow inside U-Boot is terminated by definition when reaching ExitBootServices.
>
> >
> >There is no need to unbind all the USB devices just to quiesce them.
> >Add a new usb_pause() call which removes them but leaves them bound.
>
> As U-Boot must not access any device after ExitBootServices() it is unclear to me what you want to achieve.

I can't remember exactly what is needed from the bootflow, but
something is. Perhaps the kernel, or the cmdline, or fdt? It would
have been better if I had mentioned this explicitly,  But then this
patch has been sitting around for ages...

In any case, the intent of exit-boot-services is not to free all the
memory used, since some of it may have been used to hold data that the
app continues to use.

Also there is U-Boot code between when the devices are unbound and
when U-Boot actually exits back to the app.

This hang was 100% repeatable on brya (an x86 Chromebook) and it took
quite a while to find.

Regards,
Simon


>
> Best regards
>
> Heinrich
>
> >
> >This resolves a hang on x86 when booting a distro from USB. This was
> >found using a device with 4 bootflows, the last of which was USB.
> >
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> >Changes in v4:
> >- Don't rename the legacy-USB functions
> >- Add a bit more detail to the comment
> >
> >Changes in v2:
> >- Add new patch to avoid unbinding devices in use by bootflows
> >
> > boot/bootm.c                  |  2 +-
> > common/usb.c                  |  5 +++++
> > drivers/usb/host/usb-uclass.c | 14 ++++++++++++--
> > include/usb.h                 | 21 ++++++++++++++++++++-
> > 4 files changed, 38 insertions(+), 4 deletions(-)
> >
> >diff --git a/boot/bootm.c b/boot/bootm.c
> >index cb61485c226c..d9c3fa8dad99 100644
> >--- a/boot/bootm.c
> >+++ b/boot/bootm.c
> >@@ -502,7 +502,7 @@ ulong bootm_disable_interrupts(void)
> >        * updated every 1 ms within the HCCA structure in SDRAM! For more
> >        * details see the OpenHCI specification.
> >        */
> >-      usb_stop();
> >+      usb_pause();
> > #endif
> >       return iflag;
> > }
> >diff --git a/common/usb.c b/common/usb.c
> >index 836506dcd9e9..a486d1c87d4d 100644
> >--- a/common/usb.c
> >+++ b/common/usb.c
> >@@ -144,6 +144,11 @@ int usb_stop(void)
> >       return 0;
> > }
> >
> >+int usb_pause(void)
> >+{
> >+      return usb_stop();
> >+}
> >+
> > /******************************************************************************
> >  * Detect if a USB device has been plugged or unplugged.
> >  */
> >diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
> >index a1cd0ad2d669..c26c65d7986b 100644
> >--- a/drivers/usb/host/usb-uclass.c
> >+++ b/drivers/usb/host/usb-uclass.c
> >@@ -173,7 +173,7 @@ int usb_get_max_xfer_size(struct usb_device *udev, size_t *size)
> >       return ops->get_max_xfer_size(bus, size);
> > }
> >
> >-int usb_stop(void)
> >+static int usb_finish(bool unbind_all)
> > {
> >       struct udevice *bus;
> >       struct udevice *rh;
> >@@ -195,7 +195,7 @@ int usb_stop(void)
> >
> >               /* Locate root hub device */
> >               device_find_first_child(bus, &rh);
> >-              if (rh) {
> >+              if (rh && unbind_all) {
> >                       /*
> >                        * All USB devices are children of root hub.
> >                        * Unbinding root hub will unbind all of its children.
> >@@ -222,6 +222,16 @@ int usb_stop(void)
> >       return err;
> > }
> >
> >+int usb_stop(void)
> >+{
> >+      return usb_finish(true);
> >+}
> >+
> >+int usb_pause(void)
> >+{
> >+      return usb_finish(false);
> >+}
> >+
> > static void usb_scan_bus(struct udevice *bus, bool recurse)
> > {
> >       struct usb_bus_priv *priv;
> >diff --git a/include/usb.h b/include/usb.h
> >index 09e3f0cb309c..b964e2e1f6b2 100644
> >--- a/include/usb.h
> >+++ b/include/usb.h
> >@@ -265,7 +265,26 @@ int usb_kbd_deregister(int force);
> >  */
> > int usb_init(void);
> >
> >-int usb_stop(void); /* stop the USB Controller */
> >+/**
> >+ * usb_stop() - stop the USB Controller and unbind all USB controllers/devices
> >+ *
> >+ * This unbinds all devices on the USB buses.
> >+ *
> >+ * Return: 0 if OK, -ve on error
> >+ */
> >+int usb_stop(void);
> >+
> >+/**
> >+ * usb_pause() - stop the USB Controller DMA, etc.
> >+ *
> >+ * Note that this does not unbind bus devices, so using usb_init() after this
> >+ * call is not permitted. This function is only useful just before booting, to
> >+ * ensure that devices are dormant.
> >+ *
> >+ * Return: 0 if OK, -ve on error
> >+ */
> >+int usb_pause(void);
> >+
> > int usb_detect_change(void); /* detect if a USB device has been (un)plugged */
> >
> >
