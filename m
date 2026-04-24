Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E579FFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF4084534;
	Sat, 25 Apr 2026 22:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cRW/wfgA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0FC784496; Sat, 25 Apr 2026 21:30:20 +0200 (CEST)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com
 [IPv6:2607:f8b0:4864:20::122c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D12784474
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-12dbd0f8063so3801620c88.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777145417; cv=none;
 d=google.com; s=arc-20240605;
 b=XnQwHCCJ3Z4yBOaS3G9+M3KdIVZnNM0cD8pfqOKr2V889uYC14XzQ9O8dp8Tfp0SeW
 YUh8rY7k0aQvWtaCFyUxf3VFxJvVjYvTw0yph30dHXCVKTJhmS/D2P7/zmOsIBLRhfJ/
 ATM7bRHVBaqilqD0NP64Toy0uDAcUG70CC6V9/ohwuJJlIJU/R9O2ajwSxhaKBOUONKf
 bCPxUJ2DMp+Cg5snZEa2cvhksmBBc6W0zbb7wZVkcyy7tWvDPl3XIW4/Lrzz+q/lFXNx
 YMq7d0J/NV70+Lu8e5AJWHpPkme7gpeQez5G+vZ/jzQodwvjfTdzRt4sZqTlTU0JMNsd
 DXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=boLk94+1uBNOsUP/OAm3IlFY2L0OD0nL/MWwkHQTSvk=;
 fh=byp86q9k6aVMAx+mMqAL5zwz88wFV7x2RVBnut7lUe0=;
 b=Xd4exm4DRbrORo+lJn7qps+1/GHHIhEkgdUqPvMrNvaigtF9BeEk1vS8wwhO/e1Trc
 EJL3dQRqElicZBgjY907TzZJBRxc+CvJeyhIHH9sbgt7g9azl1/CewKVpKZ4iZk5tdbj
 ztIP/aL4YoIkvNopzbZpZq0QaZV0QJqXhw94jiFwCcHOz3J0cGyPf4mOc8+x27znzIND
 ZkZIDAvDNaUH7zk3AwQopZ3lkXCqoWpqlGvQ+n1/dhTKD+l23sQppfN56EQ9/yZJeoVV
 V3Dk9RiLyzm/P6Gwmuw8PtMaVA1Wb9XfS9HsDQrOFdMYueRF46tWubzEIlSotfU8+wPY
 RJMA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777145417; x=1777750217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=boLk94+1uBNOsUP/OAm3IlFY2L0OD0nL/MWwkHQTSvk=;
 b=cRW/wfgApjVUWiwxul+NErT4LmxYKAlHLTEVpl+HKeO/034/tc6fCUqbAjBNTwz1IE
 McE5fTEnrpO4vdZK+DvaoVvtK0harz7DDg9SwGPSLWeHYn6H7cJ/HLS98wOWuvU+GMqo
 /sRtdkFQlqBajzwIZvhJVQDDohT+TFjehAPGENjZ1JUh+24862qDp7/IXFNnjFzBwgpY
 aCvx1Lpx0IsOlOLIBHY2pBfdyU7AWLD1WgGZPGA17pxp9VdbbsCovt3ir3AoC/oh0Kb4
 tIO4/ybcKhA3IEz1D40BR/d9HMi/Xpn+Hf8481/AA7Kh2nC5rItCChl9HGcED0zXxsbD
 Xe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777145417; x=1777750217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boLk94+1uBNOsUP/OAm3IlFY2L0OD0nL/MWwkHQTSvk=;
 b=UtcG39S3TUYkTfLPUUslvLrGxB3xnpNbdgOKwRBwl6QmCOiZmTfh3Wpzerq5j5zmBI
 VfKC/C9BwZQ3EEH07p2WgkRG7hK5F/GGCYrV0DZNsncf5Dst43+9avexovVYUXfUEDpx
 gZqgEWCM9sy3xQE3MD9nD2h9cZX+qICKBKOaAIF6pNr886X8f6IF42/YCHYZtd0ZBg5H
 r7gFpWRGDTdXf9h9Iju4tTERWvTAOSz5OMBldJ4CXXNzWALMZcojOOvsIaS2tGtv/EAo
 dNysEv3/59naaw6jcrDG/x0nUMuQ9ZU8qoC97sDeB5PDIYiFuhwav83pqtsITjStdQT+
 /Bhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ897Xido3DX597WKrgVac9PQ0hWA3NLjznYy1ITEXTpsyoW97XekZyoRDe5uO+xDpffMrUNAs4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyuf4NIWBfR+IkyohV+4gUmPQJUGlDtwFagdjG2bToKIBjrKblu
 PEUWQMXJwT+7ZK0V8n0n+2q9L38M1P0yJqRB4SG0SAr9xYbW2Yd7o98xV39MXV6hq8JBboYMbKO
 UuqW/wvn9pfxX0ahL3PxOJHG1xivZRlZjBw==
X-Gm-Gg: AeBDieu/Pg+w06jTZyiVEqcPUddJkBGIkTVPYWohruCYg0cTDLdL+TU17DKgh95gpyz
 cLplkkqr+Li0u3P5/e+U/rhEVu0pQPpKbVqBJNWRnX+q1uuOafKWMt8X1UT2Jcy3vm0H2LZA72L
 4yyksWJNr1OxMP6F5u8IlVcfd2f9Nnmq6q9qekDceewToM8oQzEKdnBiLzja1l5SnV78Ar/gqzH
 aSZMmduF6Z/wo60a+sWDGLUl+o0votus367xqYOnMf5VBgBOGb5E4QAduGGG6zN8+WoDAYuVTqs
 l6wQ2NMVppxToJgaD/E=
X-Received: by 2002:a05:6820:2d08:b0:694:921b:b1b3 with SMTP id
 006d021491bc7-694921bb3b4mr10688572eaf.26.1777044281467; Fri, 24 Apr 2026
 08:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260423130323.32533-1-micbis.openwrt@gmail.com>
 <20260423130323.32533-3-micbis.openwrt@gmail.com>
 <cc980d9a-d5ca-4987-a576-bc2bf716ce1c@mailbox.org>
In-Reply-To: <cc980d9a-d5ca-4987-a576-bc2bf716ce1c@mailbox.org>
From: Michele Bisogno <micbis.openwrt@gmail.com>
Date: Fri, 24 Apr 2026 17:24:30 +0200
X-Gm-Features: AQROBzC2uXz76-Hf2i2wS-WvHKX_1up-XDlGjrhl0B2bCDzWXKS69e6uh-92sKc
Message-ID: <CAP8xZ6k2WCfrZZfiuGix4pEDCOYrmeRARgmAz4pBamyRkT_BZA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] usb: gadget: rcar: Add support for reset controller
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

On Fri, 24 Apr 2026 at 07:34, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> >   #include <linux/usb/ch9.h>
> >   #include <linux/usb/gadget.h>
> >   #include <usb.h>
> > +#include <reset.h>
>
> Please keep the header list sorted.

Ops, OK!

> >   #include "common.h"
>
> [...]
>
> clk_enable_bulk() needs to jump to err_clock_enable() on failure, this
> is a bug in the existing driver .
>
> > +     ret = reset_get_bulk(dev, &priv->reset_bulk);
> > +     if (ret)
> > +             goto err_clk;
> > +
> > +     ret = reset_deassert_bulk(&priv->reset_bulk);
> > +     if (ret)
> > +             goto err_clk;
>
> This has to jump to fail path which does reset_release_bulk() , i.e.
>
>                 goto err_reset_deassert;

OK!

> >       clrsetbits_le32(priv->base + UGCTRL2, UGCTRL2_USB0SEL_MASK, UGCTRL2_USB0SEL_EHCI);
> >       clrsetbits_le16(priv->base + LPSTS, LPSTS_SUSPM, LPSTS_SUSPM);
> >
> >       ret = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_OTG, 1);
> >       if (ret)
> > -             goto err_clk;
> > +             goto err_reset;
> >
> >       priv->phybase = dev_read_addr_ptr(priv->phy.dev);
> >
> >       priv->usbhs_priv.pdev = &priv->usbhs_dev;
> >       priv->usbhs_priv.base = priv->base;
> >       priv->usbhs_dev.dev.driver_data = &priv->usbhs_priv;
> > -     ret = usbhs_probe(&priv->usbhs_priv);
> > +     ret = usbhs_probe(dev);
> >       if (ret < 0)
> >               goto err_phy;
> >
> > @@ -439,8 +452,10 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
> >
> >   err_phy:
> >       generic_shutdown_phy(&priv->phy);
> > +err_reset:
> > +     reset_assert_bulk(&priv->reset_bulk);
>
> err_reset_deassert:
>         reset_release_bulk(&priv->reset_bulk);

Alright.

> >   err_clk:
> > -     clk_disable_bulk(&clk_bulk);
> > +     clk_disable_bulk(&priv->clk_bulk);
>
>
> err_clk_enable:
>         clk_release_bulk(&priv->clk_bulk);

OK.

> >       return ret;
> >   }
> >
> > @@ -456,6 +471,12 @@ static int usbhs_udc_otg_remove(struct udevice *dev)
> >       usbhs_fifo_remove(&priv->usbhs_priv);
> >       usbhs_pipe_remove(&priv->usbhs_priv);
> >
> > +     reset_assert_bulk(&priv->reset_bulk);
> > +     reset_release_bulk(&priv->reset_bulk);
> > +
> > +     clk_disable_bulk(&priv->clk_bulk);
> > +     clk_release_bulk(&priv->clk_bulk);
> > +
> >       generic_shutdown_phy(&priv->phy);
> >
> >       return dm_scan_fdt_dev(dev);
>
> Thank you for your help!

Thanks for your patience! :)
