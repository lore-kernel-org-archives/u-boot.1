Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF945CDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 07:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501FE84704;
	Thu, 25 Jun 2026 09:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HeOyBFFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB32584894; Thu, 25 Jun 2026 09:20:33 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105AE8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6a11c68ae41so914905eaf.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 00:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782372028; cv=none;
 d=google.com; s=arc-20260327;
 b=Wwy9zJra+qqyU63YisdXrRydqAeXV+EKpbBzkLqsyjiS/UoHLoYSdgLW8dz7Msizds
 3v3EBfvPPS35nMNDQhdyXDm6A2xT5ZC3rUHJgtsV3tn6/G274J4yPh+mTHubqNcx81+B
 ltDJQlRtJK8JXE35NJauQlVCnw+dx8PduZ2cSEsCo4iAQb1ijE8zxz/q7U+iwj3LxJF/
 DDde7R2bn1x05I2SBi2UWoktqDMESYpwsBI5vHkLaD/gMyRaB+DfGRgrW3vR+1pgBIft
 NHvIZvypRVoooMpY7qkF2m2bj52YM9Xtqx1C1wrkvp2tcZe1p/L3r7Soy0QrVWHIGpI7
 y/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YIXNMsdz+CJvxz18JxA7pnLuXZaQwjJ0nWjcnJyDXcs=;
 fh=yal6Spl0r4uzSozseSfXAl/vWsqQEmYWT7VCu8mi2lk=;
 b=e28SipFhIGJQYb+T/O2x2xp8ROWX9KyAz1CiGYV3Az5Ok4s3KD5LCZO58ZzHinxqkV
 PQyflyFqvHPhD5eF5nXEk+9RAaUkB94Bv3Ogs4KuOs+MEJw3CfW+7TXZU3Kl50dDwEml
 7IQgOXqWt6crKhg9F04hTzxRLRdrt0YJsTyZsLpWnzDQ6JxaFMPvav0uYOqNziPFK60p
 Go7+bkZoXpS68CrQU9TpOD02iKLDIJorA8g4ADg6WRBSfy/L3lqRGefRIQWHH7l4mqrP
 vx3yommRg0K54ooRR5BAn/4WbG+oMJuQuMG5VM2ZHkPycbx9BjbENMhkaDR7l7MBKqHa
 OXlw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782372028; x=1782976828; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIXNMsdz+CJvxz18JxA7pnLuXZaQwjJ0nWjcnJyDXcs=;
 b=HeOyBFFH+g+s9N8/UN43m7Yf+ehFiBWe3GwKarAqaLunCXvfv8eRiXh/uqR+fNTNDI
 57A1DRSN5s66q+OpVXethp9LSEqJZdC/tUNGRV+2D5gmugpWE2Is7BCj2MZ+FTd1NgBu
 0ufwJiwVOFwyRPl1sqHMNusL7CGdqbPBiSSlU/UR84cd0HckhoWpyAH92N8maejgN+as
 fl+ggm5Kmq6Q5Kt848WJAb53vlsMZ8D0nUReRIMOUOpUcn425exKmGxstFo2Q30dnq3X
 0pmfKwuTKmEhCQYPT05IYs0uF5qMIVcWtCtWbyhhfweS0grBbQCi2NnViK99t/kvpWvX
 ScYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782372028; x=1782976828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YIXNMsdz+CJvxz18JxA7pnLuXZaQwjJ0nWjcnJyDXcs=;
 b=iwddI/BiIwb40OYWdCgNq3rC6t72Dc4E4ltf2DrJeWcXDgi/L+fAO2AVi6YYI6h++G
 2XesE2cCWuCq/zI2ZBcj2HcfrogrBSOmCqmZWe5UWI21+T3NHRevqaTi8ZbDmw3ECisB
 DYbak6I78ZWNLdfdzCRbPCjkUQoF0eAldU7qdLhr85mKx1EJPfQ0ThqNdNEWEhf4MLYc
 TPEsTLZf2jGbLLbi2Xr3o26fqBMVtJwUJT/6TUu+aivqZo29CrtP9pQjkoMDynNqxAKk
 /pNeMqIIn3RKmQrdjo7x3W2RqWsz0+p+x2lEJFUdoC1iprAs9e222ejZ1tCJ76w80GdW
 2Nbg==
X-Gm-Message-State: AOJu0YwUpm829IhS8QlayN0+9wAX+B3TX9LLA/xHqgoxCJ8bEtvQ8ZeJ
 3MnNHIWbpnCAkHcLBdyFJrT45XRPag42n/uf/23RAQzhXh/gK8XkIG6DtIaIP+lyleOixWuqgJg
 fGjspiDhU5KDZ1Gd7LGZ8NeEB6p0i4exafSiwetgPEA==
X-Gm-Gg: AfdE7cnCM/5rG7+UelcOi6l3FaAFrtae0wR7owouD95UPMe2yKhWR/E3UKlcunGv3TQ
 lO9cBkk7SJpq6WFMZEbHieW7UQ6HKsn3ZXe0nJIGNyDlRdbe2+gbxwNu2/Mx3alLN8EPCrj/GIB
 ifp1bCiLzCDifPknNaNwJ3fYZGYRonjF5fxRW1P0j6MVAoUORqbrsXCWcUnGvX9d/THuPp3K5ps
 gRipCI9582+fk990usI/GfbvUG4Jcjxe3qDn+XkYGthjb521TK7B8+3wP/Id3GJJyzpxOWm3eMz
 wkuk51gi5PF2E193N2zB1JxuJ5g=
X-Received: by 2002:a05:6820:174c:b0:6a1:1ac3:638 with SMTP id
 006d021491bc7-6a13523fa0cmr1040739eaf.53.1782372027653; Thu, 25 Jun 2026
 00:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-65-jens.wiklander@linaro.org>
 <DIFPCP4IT3G1.3RRSF2ZPW4PZZ@ti.com>
In-Reply-To: <DIFPCP4IT3G1.3RRSF2ZPW4PZZ@ti.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 25 Jun 2026 09:20:16 +0200
X-Gm-Features: AVVi8CcQzRGz2y-1v2m_bWhnnzI66kokcHmeTAb6vB8Nl_NLLdmJrMbtDNFddE8
Message-ID: <CAHUa44FYTR56HjK4mYqy=7HFZwXQJiL8SUnpR5RmZF7-NUQ=nQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 64/64] usb: fix build after resync of DWC3 with
 kernel v6.16-rc7
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Eddie Cai <eddie.cai.linux@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
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

On Mon, May 11, 2026 at 10:25=E2=80=AFAM Anshul Dalal <anshuld@ti.com> wrot=
e:
>
> On Thu May 7, 2026 at 2:58 PM IST, Jens Wiklander wrote:
> > From: Jerome Forissier <jerome.forissier@linaro.org>
> >
> > Fix build errors after the re-sync of the DWC3 driver with the kernel.
> > U-Boot has different needs than the kernel: buses, interrupts, internal
> > APIs (DMA, traces, DT...) so many adaptations are required. This commit
> > re-introduces many of the changes that were done locally after the
> > initial import of the DWC3 code from kernel 3.19-rc1 11 years ago, as
> > well as other fixes. This is compile-tested only.
> >
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/usb/cdns3/ep0.c                |    8 +-
> >  drivers/usb/common/common.c            |   23 +
> >  drivers/usb/dwc3/Makefile              |   57 +-
> >  drivers/usb/dwc3/core.c                | 1761 ++++++------------------
> >  drivers/usb/dwc3/core.h                |   39 +-
> >  drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
> >  drivers/usb/dwc3/dwc3-omap.c           |    2 -
> >  drivers/usb/dwc3/ep0.c                 |  110 +-
> >  drivers/usb/dwc3/gadget.c              |  786 +++--------
> >  drivers/usb/dwc3/gadget.h              |    4 +-
> >  drivers/usb/dwc3/io.h                  |   28 +-
> >  drivers/usb/dwc3/ti_usb_phy.c          |    2 -
> >  drivers/usb/gadget/at91_udc.c          |   46 -
> >  drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
> >  drivers/usb/gadget/ci_udc.c            |  419 ------
> >  drivers/usb/gadget/composite.c         |    2 +-
> >  drivers/usb/gadget/dwc2_udc_otg.c      |  174 +--
> >  drivers/usb/gadget/epautoconf.c        |    2 -
> >  drivers/usb/gadget/ether.c             |   21 +-
> >  drivers/usb/gadget/f_acm.c             |   20 +-
> >  drivers/usb/gadget/f_fastboot.c        |   10 +-
> >  drivers/usb/gadget/f_mass_storage.c    |    5 +-
> >  drivers/usb/gadget/f_rockusb.c         |   11 +-
> >  drivers/usb/gadget/f_sdp.c             |   12 +-
> >  drivers/usb/gadget/f_thor.c            |   19 +-
> >  drivers/usb/gadget/udc/Makefile        |    1 +
> >  drivers/usb/gadget/udc/udc-core.c      | 1021 +++-----------
> >  drivers/usb/host/xhci-dwc3.c           |    4 +-
> >  drivers/usb/host/xhci-exynos5.c        |    2 +-
> >  drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
> >  drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
> >  drivers/usb/musb-new/musb_uboot.c      |   39 -
> >  include/dm/device_compat.h             |   13 +
> >  include/dm/read.h                      |   46 +
> >  include/linux/compat.h                 |   15 +
> >  include/linux/usb/ch9.h                |   25 +-
> >  include/linux/usb/gadget.h             |  520 ++-----
> >  include/linux/usb/otg.h                |   10 +
> >  include/linux/usb/phy.h                |   56 +
> >  39 files changed, 1347 insertions(+), 4532 deletions(-)
> >
>
> [snip]
>
> > diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> > index a619cd374fb4..ae1725756c0e 100644
> > --- a/drivers/usb/dwc3/Makefile
> > +++ b/drivers/usb/dwc3/Makefile
> > @@ -1,18 +1,59 @@
> > -# SPDX-License-Identifier: GPL-2.0+
> > -
> > +# SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_USB_DWC3)                       +=3D dwc3.o
> >
> >  dwc3-y                                       :=3D core.o
> >
> > -obj-$(CONFIG_USB_DWC3_GADGET)                +=3D gadget.o ep0.o
> > +ifneq ($(filter y,$(CONFIG_USB_DWC3_HOST) $(CONFIG_USB_DWC3_DUAL_ROLE)=
),)
> > +     dwc3-y                          +=3D host.o
> > +endif
> > +
> > +ifneq ($(filter y,$(CONFIG_USB_DWC3_GADGET) $(CONFIG_USB_DWC3_DUAL_ROL=
E)),)
> > +     dwc3-y                          +=3D gadget.o ep0.o
> > +endif
> > +
> > +ifneq ($(CONFIG_USB_DWC3_DUAL_ROLE),)
> > +     dwc3-y                          +=3D drd.o
> > +endif
> > +
> > +ifneq ($(CONFIG_USB_DWC3_ULPI),)
> > +     dwc3-y                          +=3D ulpi.o
> > +endif
> > +
> > +ifneq ($(CONFIG_DEBUG_FS),)
> > +     dwc3-y                          +=3D debugfs.o
> > +endif
> > +
> > +##
> > +# Platform-specific glue layers go here
> > +#
> > +# NOTICE: Make sure your glue layer doesn't depend on anything
> > +# which is arch-specific and that it compiles on all situations.
> > +#
> > +# We want to keep this requirement in order to be able to compile
> > +# the entire driver (with all its glue layers) on several architecture=
s
> > +# and make sure it compiles fine. This will also help with allmodconfi=
g
> > +# and allyesconfig builds.
> > +##
> >
> > -obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62) +=3D dwc3-am62.o
> > +obj-$(CONFIG_USB_DWC3_AM62)          +=3D dwc3-am62.o
>
> Why is this change being made here? We need dwc3-am62 driver at SPL
> stage for DFU boot on K3 devices. The Kconfig should have a
> corresponding CONFIG_SPL_USB_DWC3_AM62 symbol as well.

I'm sorry, I missed this comment. I'll address it in the next version.

Thanks,
Jens
