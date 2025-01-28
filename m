Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C2AC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 11:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D45981BEE;
	Tue, 28 Jan 2025 12:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="LcEe2fxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6DA81D42; Tue, 28 Jan 2025 12:58:48 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1506E81BC0
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 12:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e3a0acba5feso7594407276.2
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 03:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1738065525; x=1738670325;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V52n0yMxKWzqbZzo1BwlLvTa5OjXOKE9qiMKW+lJfjI=;
 b=LcEe2fxpZAKfzWrQf8RH2iIx1bGRO3zgxmyuU+RL9v+ctoczig027n4WnAsjxw8Gbz
 tSwZNZv+h08G1dJM/Ba7lThMOhkwD3pTlevW59wwcZdWKCn7dJBBptvtNrJQ6f9YgHlQ
 annj6D9mZEvBV2p/IUTciKgVfh9X4UXPMxXWwZDPfSiGk+i9/GcXw4dC+CH207FsdEbq
 ZkeaWSbk2d2aCrjJdsmmUnOBr+K1ixx1HXMqABozIwcmMUZJxdG/e2YWy43Vk4UShLKi
 QeV6c5/DtQUTjJ1LNr2GtZDKUMVTENcZbaDzOpzsv4ckpFF9o/jBr5funjdBTADBIKhJ
 IxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738065525; x=1738670325;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V52n0yMxKWzqbZzo1BwlLvTa5OjXOKE9qiMKW+lJfjI=;
 b=B4GrZm5YyP7X4F0iNOAEjLE7v6wcy6sDUA0gfEdqoSInB1/mJMVq/TYk3UgisXZbpL
 xFw0pfOOiC52hfHnxJcPojJ4dZGjPn/iwCBaiVXfrGdj42TIFGqnHxuq0XNpTuwmSNJY
 4xRxI34kBObNDjz8f+FeiuulKKoxgA835+ydQ/Tl3QmP6lbdy1dRjKL27ACc/Rr7bgVh
 WMBXZT8izzBvtc55Ws0oO0eIoPq76xltv1HAEdkc7BuPn5GIhzu+pWe73kCabDApeGzO
 bCesC1zhkvVUVPoWTte6aMe9TM42Ny14y1CVyYve4KtSSlv3wEeOYZiN3tRrsTm5ZKOx
 fSIw==
X-Gm-Message-State: AOJu0Yze+kQlaN7saZE+SQhDtd180HsgEBlXKdDPjaPxGZ1ek+sSNukE
 z6JeJKuuaFYnvl9OgYRYahpTCGRWKyU2PTgXWJBJBOiphq65i+ND2Lc7QP5VVXkroqd1yOEbY2/
 1Urz9avym33NcnOxVEO8kwkXntc7uslE5JQsn
X-Gm-Gg: ASbGncuLE5Uj2cLf7qHa0KPTikqa5LS0Lo3pDgEsbedSNMQe/0UfYdO27i0QocCZmSr
 7w551b3PsoqMU/HeoaGm8L36jRG4t3qE3XMe8S6gJYHdmxZdb8BOEqj1UXOFrD4zWPMEvLCju3e
 hPk9zYw6eW
X-Google-Smtp-Source: AGHT+IEdQlluoVlQbhuJ/8wSkusc6T7hBuf66pT8gCsANLO9GwrZaGStnJnL4Ub3hb2/gRRQXw3l9a5B8VkXj3dd5nM=
X-Received: by 2002:a05:6902:2b8e:b0:e57:a314:cf2a with SMTP id
 3f1490d57ef6-e57b1047a16mr28542841276.16.1738065524719; Tue, 28 Jan 2025
 03:58:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738059345.git.jerome.forissier@linaro.org>
 <58d6721203ea81b9c20f162ef40f79bc73243a42.1738059345.git.jerome.forissier@linaro.org>
In-Reply-To: <58d6721203ea81b9c20f162ef40f79bc73243a42.1738059345.git.jerome.forissier@linaro.org>
From: Michal Simek <monstr@monstr.eu>
Date: Tue, 28 Jan 2025 12:58:32 +0100
X-Gm-Features: AWEUYZmBuMTgR-XOCBi5OxBR-nu5bNQG-M6dVyFn2DuivABKKgnM4pKOJnVxNyw
Message-ID: <CAHTX3d+-oy8h=Y1u5iQz-O5fSAEqaKezd3_sTwajgoWedWX9UQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] usb: scan multiple buses simultaneously with
 coroutines
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Dragan Simic <dsimic@manjaro.org>, Caleb Connolly <caleb.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

=C3=BAt 28. 1. 2025 v 11:20 odes=C3=ADlatel Jerome Forissier
<jerome.forissier@linaro.org> napsal:
>
> Use the coroutines framework to scan USB buses in parallel for better
> performance. Tested on arm64 QEMU on a somewhat contrived example
> (4 USB buses, each with one audio device, one keyboard, one mouse and
> one tablet).
>
> $ make qemu_arm64_defconfig
> $ make -j$(nproc) CROSS_COMPILE=3D"ccache aarch64-linux-gnu-"
> $ qemu-system-aarch64 -M virt -nographic -cpu max -bios u-boot.bin \
>     $(for i in {1..4}; do echo -device qemu-xhci,id=3Dxhci$i \
>         -device\ usb-{audio,kbd,mouse,tablet},bus=3Dxhci$i.0; \
>     done)
>
> The time spent in usb_init() is reported on the console and shows a
> significant improvement with COROUTINES enabled.
>
> ** Without COROUTINES
>
>  Bus xhci_pci: Register 8001040 NbrPorts 8
>  Starting the controller
>  USB XHCI 1.00
>  Bus xhci_pci: Register 8001040 NbrPorts 8
>  Starting the controller
>  USB XHCI 1.00
>  Bus xhci_pci: Register 8001040 NbrPorts 8
>  Starting the controller
>  USB XHCI 1.00
>  Bus xhci_pci: Register 8001040 NbrPorts 8
>  Starting the controller
>  USB XHCI 1.00
>  scanning bus xhci_pci for devices... 6 USB Device(s) found
>  scanning bus xhci_pci for devices... 6 USB Device(s) found
>  scanning bus xhci_pci for devices... 6 USB Device(s) found
>  scanning bus xhci_pci for devices... 6 USB Device(s) found
>  USB: 4 bus(es) scanned in 5873 ms
>
> ** With COROUTINES
>
>  Bus xhci_pci: Register 8001040 NbrPorts 8
>  Starting the controller
>  USB XHCI 1.00
>  Bus xhci_pci: Register 8001040 NbrPorts 8
>  Starting the controller
>  USB XHCI 1.00
>  Bus xhci_pci: Register 8001040 NbrPorts 8
>  Starting the controller
>  USB XHCI 1.00
>  Bus xhci_pci: Register 8001040 NbrPorts 8
>  Starting the controller
>  USB XHCI 1.00
>  Scanning 4 USB bus(es)... done
>  Bus xhci_pci: 6 USB device(s) found
>  Bus xhci_pci: 6 USB device(s) found
>  Bus xhci_pci: 6 USB device(s) found
>  Bus xhci_pci: 6 USB device(s) found
>  USB: 4 bus(es) scanned in 2213 ms
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/usb/host/usb-uclass.c | 152 +++++++++++++++++++++++++++++++++-
>  1 file changed, 149 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.=
c
> index bfec303e7af..3104efe7f9e 100644
> --- a/drivers/usb/host/usb-uclass.c
> +++ b/drivers/usb/host/usb-uclass.c
> @@ -9,6 +9,7 @@
>  #define LOG_CATEGORY UCLASS_USB
>
>  #include <bootdev.h>
> +#include <coroutines.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <log.h>
> @@ -18,6 +19,8 @@
>  #include <dm/lists.h>
>  #include <dm/uclass-internal.h>
>
> +#include <time.h>
> +
>  static bool asynch_allowed;
>
>  struct usb_uclass_priv {
> @@ -221,6 +224,40 @@ int usb_stop(void)
>         return err;
>  }
>
> +static int nbus;
> +
> +#if CONFIG_IS_ENABLED(COROUTINES)
> +static void usb_scan_bus(struct udevice *bus, bool recurse)
> +{
> +       struct usb_bus_priv *priv;
> +       struct udevice *dev;
> +       int ret;
> +
> +       priv =3D dev_get_uclass_priv(bus);
> +
> +       assert(recurse);        /* TODO: Support non-recusive */
> +
> +       debug("\n");
> +       ret =3D usb_scan_device(bus, 0, USB_SPEED_FULL, &dev);
> +       if (ret)
> +               printf("Scanning bus %s failed, error %d\n", bus->name, r=
et);
> +}
> +
> +static void usb_report_devices(struct uclass *uc)
> +{
> +       struct usb_bus_priv *priv;
> +       struct udevice *bus;
> +
> +       uclass_foreach_dev(bus, uc) {
> +               priv =3D dev_get_uclass_priv(bus);
> +               printf("Bus %s: ", bus->name);
> +               if (priv->next_addr =3D=3D 0)
> +                       printf("No USB device found\n");
> +               else
> +                       printf("%d USB device(s) found\n", priv->next_add=
r);
> +       }
> +}
> +#else
>  static void usb_scan_bus(struct udevice *bus, bool recurse)
>  {
>         struct usb_bus_priv *priv;
> @@ -240,7 +277,81 @@ static void usb_scan_bus(struct udevice *bus, bool r=
ecurse)
>                 printf("No USB Device found\n");
>         else
>                 printf("%d USB Device(s) found\n", priv->next_addr);
> +       nbus++;
>  }
> +#endif
> +
> +#if CONFIG_IS_ENABLED(COROUTINES)
> +extern int udelay_yield;
> +
> +static void usb_scan_bus_co(void)
> +{
> +       usb_scan_bus((struct udevice *)co_get_arg(), true);
> +       co_exit();
> +}
> +
> +static struct co_stack *stk;
> +static struct co *main_co;
> +static struct co **co;
> +static int co_sz =3D 8;
> +
> +static int add_usb_scan_bus_co(struct udevice *bus)
> +{
> +       if (!co) {
> +               co =3D malloc(co_sz * sizeof(*co));
> +               if (!co)
> +                       return -ENOMEM;
> +       }
> +       if (nbus =3D=3D co_sz) {
> +               struct co **nco;
> +
> +               co_sz *=3D 2;
> +               nco =3D realloc(co, co_sz * sizeof(*co));
> +               if (!nco)
> +                       return -ENOMEM;
> +               co =3D nco;
> +       }
> +       if (!main_co) {
> +               main_co =3D co_create(NULL, NULL, 0, NULL, NULL);
> +               if (!main_co)
> +                       return -ENOMEM;
> +       }
> +       if (!stk) {
> +               stk =3D co_stack_new(32768);
> +               if (!stk)
> +                       return -ENOMEM;
> +       }
> +       co[nbus] =3D co_create(main_co, stk, 0, usb_scan_bus_co, bus);
> +       if (!co[nbus])
> +               return -ENOMEM;
> +       nbus++;
> +       return 0;
> +}
> +
> +static void usb_scan_cleanup(void)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nbus; i++) {
> +               co_destroy(co[i]);
> +               co[i] =3D NULL;
> +       }
> +       nbus =3D 0;
> +       co_destroy(main_co);
> +       main_co =3D NULL;
> +       co_stack_destroy(stk);
> +       stk =3D NULL;
> +}
> +#else
> +static int add_usb_scan_bus_co(struct udevice *bus)
> +{
> +       return 0;
> +}
> +
> +static void usb_scan_cleanup(void)
> +{
> +}
> +#endif
>
>  static void remove_inactive_children(struct uclass *uc, struct udevice *=
bus)
>  {
> @@ -289,6 +400,7 @@ static int usb_probe_companion(struct udevice *bus)
>
>  int usb_init(void)
>  {
> +       unsigned long t0 =3D timer_get_us();
>         int controllers_initialized =3D 0;
>         struct usb_uclass_priv *uc_priv;
>         struct usb_bus_priv *priv;
> @@ -355,10 +467,40 @@ int usb_init(void)
>                         continue;
>
>                 priv =3D dev_get_uclass_priv(bus);
> -               if (!priv->companion)
> -                       usb_scan_bus(bus, true);
> +               if (!priv->companion) {
> +                       if (CONFIG_IS_ENABLED(COROUTINES)) {
> +                               ret =3D add_usb_scan_bus_co(bus);
> +                               if (ret)
> +                                       goto out;
> +                       } else {
> +                               usb_scan_bus(bus, true);
> +                       }
> +               }
>         }
>
> +#if CONFIG_IS_ENABLED(COROUTINES)
> +       {
> +               bool done;
> +               int i;
> +
> +               printf("Scanning %d USB bus(es)... ", nbus);
> +               udelay_yield =3D 0xCAFEDECA;
> +               do {
> +                       done =3D true;
> +                       for (i =3D 0; i < nbus; i++) {
> +                               if (!co[i]->done) {
> +                                       done =3D false;
> +                                       co_resume(co[i]);
> +                               }
> +                       }
> +               } while (!done);
> +               udelay_yield =3D 0;
> +               printf("done\n");
> +
> +               usb_report_devices(uc);
> +       }
> +#endif
> +
>         /*
>          * Now that the primary controllers have been scanned and have ha=
nded
>          * over any devices they do not understand to their companions, s=
can
> @@ -388,7 +530,11 @@ int usb_init(void)
>         /* if we were not able to find at least one working bus, bail out=
 */
>         if (controllers_initialized =3D=3D 0)
>                 printf("No USB controllers found\n");
> -
> +out:
> +       if (nbus)
> +               printf("USB: %d bus(es) scanned in %ld ms\n", nbus,
> +                      (timer_get_us() - t0) / 1000);
> +       usb_scan_cleanup();
>         return usb_started ? 0 : -ENOENT;
>  }
>
> --
> 2.43.0
>

I have tested it on kr260 which is using 2 usb interfaces and there is
an issue with usb hub initialization.
That board has two hubs connected over i2c and only one of them is
initialized over i2c.
It means there is some work which needs to happen and likely some
locking should be in place.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
