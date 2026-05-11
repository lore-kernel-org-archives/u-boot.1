Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C2DCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A6F83E76;
	Mon, 11 May 2026 15:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j289nZi2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B76283EF9; Mon, 11 May 2026 15:13:55 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B3E1800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bcc9fdc959cso264243166b.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505232; cv=none;
 d=google.com; s=arc-20240605;
 b=I72aX1Ikb9I/cZZZykquBAQZeF4lEyJ8cCllZOWU86qqVI7QJbsGlyJ1gTReAzmB/n
 KiQoO5SQjDB34xszww+fyMsUVEAABWPpPJ/LTth6VM9hv3fMk+YS+YGjgoPtnKJyifGn
 slQhnMdjXg2iHChnD6zAeI4mMkfp6fAgzQK+DGrV9s+E9HV8aORGKXyqgZaVq921BaKY
 q4chCl3EOqeTQuZs8JWmh4uXY5motFz+mMc2C0G083xnPRpwMbP6zwedVyAtxyiA0u/g
 apJy4KiuM1WCLMtr5CL/W/ds60XKwxbc108U5mvuYZ0Bb2cziFa+0g1sLdF4GTDXSH2v
 tqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v/YgY4e6Ql2EuSx7ksHRpIoyik4pmvRrS4iIPfFcA1g=;
 fh=dvzuQjsfshpz3e8P3f3h1fSYcOeDAzPMSu1fzbyaOsk=;
 b=SZN8VdEZHZvLZOdTKu0yy61fnosAQQQ9HnjwhGeH2Hf3MpfZc20SdFub23/ITiISN9
 jCiCncyKrfDDn7HlICO0SL7O+NJALN+82KycoNa+5tvPplezMkZ/sQUKkRr6M154wcra
 eCMtwy6sBIYETxg4kkxPRkdg/jVLvqtTC7d14zUn0HNXELrBuGzFv/mTJxNbduqXS7R+
 5AzQDisG2BI8wkqG0WgpNeDBqm1Axt/0v1hFaiT0ht7e18fSucSAR97MUwlJtFxtmD1q
 xu0oq1YtDqOnlNWk5D7WD7xX1x7x/BgRI2Hu2OJwP8euoUAjM0GR0oHm1WbjotsomBPt
 DGaQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778505232; x=1779110032; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v/YgY4e6Ql2EuSx7ksHRpIoyik4pmvRrS4iIPfFcA1g=;
 b=j289nZi2YEnQYRXTc8b71O+y7TtEQDPb+k6gpbGMoXkk2n+9b1suhVb9D2AaJaYcBP
 jidOluoAWre0HU16APoWatO6hUrVi///EAcWchv8eDgDtO1z0YM7q3IFvw/7aRQlQY9I
 JeJGLoTJgR4Sz4esk5UvffNNlPW+pxYcWruS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778505232; x=1779110032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/YgY4e6Ql2EuSx7ksHRpIoyik4pmvRrS4iIPfFcA1g=;
 b=p4QXHFqslZK7jz/A3PA7WU8NI8MxQtMGN8zhRYbX1dZoOwbVpBUDNKYEe/8invjErU
 dl7X5PKqBQFogQ+qQAx6in7KSNH8HdUrlo5CySPLOIYOb6IYBJj+TCQpt128ibu9qyQ4
 7n+MMqN8OSKssXlYSPgkC3ZtxBNGjJ1W4+zMpyti6hshDfSw1XnDbuuBvj2v7vHAMvaE
 i9s9ZHxuwgAGfHKRXVBNVh02slpuGzAdHDKxqU09BIp0+hSlMz6iyv43oXWJ3hcdsRgF
 J/ACJ1P4e79DIqPnd0FD87rBydICegFUcYb6FexJi13ec2OPUJnm4jE5GKB4fqclEjT1
 zOcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rLoQJiroCpnL63vV7MYkZk0XzqWefjD7DP1ROapoe/l6gFQAKFybznS/5M2/I1uDx8HxL70Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyE3cdzy2h4DynORuJTsrs64Pu9eQ1M6n//RWcRxtibciz/W3+o
 g3ygTqbUVCOWxV4cvfsfy+Vtuy5/u/pssNO9YBizHdc7RA+SzG4a1JX3nXqvz5MaSqayP+DiXQ0
 kEryx4ZaYhXjPwfihczdxV4Wq1A0GJFNMBtDCHgBE
X-Gm-Gg: Acq92OE03pc1sCrWuNLGOCbr15ZhFUbdphbkZ2EjleqBkAMxtnnaylMqf9INX4F6cZX
 2QSwhJ+akpcJyIW0KmiqCywxvzNoXFQSrCu1y1hdqS+C3/DjBHknHsov2D8CHSUCPMulMRWyELI
 ozuT1RUJhboPw/Q0JFeaCYBEUeOrFsXA6hF3qNaSmwTaj4vGlm1Kk/cHGp2s5+50B9s+sT9IbzR
 wE9JS7zIvkogxki/O6gM2S2kTJDAiRIC/F2yF3NPX2NER58yze+0tMkmsUnxO7CTFLGu8DCbVPQ
 4/KnSw==
X-Received: by 2002:a17:907:3d0b:b0:bcc:97db:396c with SMTP id
 a640c23a62f3a-bcc97db3eecmr486247166b.43.1778505231883; Mon, 11 May 2026
 06:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <CAFLszTgdhUO4nTd57atF__z_ox2VSROdxFKP93kr+f4FyW=5Jw@mail.gmail.com>
 <20260508160302.GV1614990@bill-the-cat>
In-Reply-To: <20260508160302.GV1614990@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:13:39 -0600
X-Gm-Features: AVHnY4KqpMExvcOKDw-T0fEPKeAUNSaNpJ5Uy3lI86lUTUUCh5sgOrBPZLckWDA
Message-ID: <CAFLszTjeNGnZmaSWw+Xx1h-GSZ7wYVp4GZT8RUMBqDSgwGs+kQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/64] drivers: usb: dwc3: sync code with Linux
 v6.16-rc7
To: Tom Rini <trini@konsulko.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
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
 Ryder Lee <ryder.lee@mediatek.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
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

On Fri, 8 May 2026 at 10:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 08, 2026 at 09:42:40AM -0600, Simon Glass wrote:
> > Hi Jens,
> >
> > On Thu, 7 May 2026 at 03:28, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > This is a follow-up to Jerome's patchset [1], addressing previous feedback
> > > regarding the monolithic nature of the driver update.
> > >
> > > The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven years
> > > ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
> > > to u-boot"). Since then, not many kernel changes have been ported back into
> > > U-Boot.
> > >
> > > This series synchronizes the DWC3 core with Linux v6.16-rc7. To provide
> > > a clear audit trail and maintain bisectability, I have structured the
> > > series as follows:
> > >
> > > 1. Restore to Baseline: The first commit reverts U-Boot-specific changes
> > >    to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state.
> > > 2. Milestone Imports: A sequence of 50+ commits follows, each performing
> > >    a "snapshot" import of the drivers/usb/dwc3 directory for every major
> > >    kernel version (v3.19 through v6.16-rc7).
> > > 3. U-Boot Adaptation: The final commits (based on Jerome's original work)
> > >    re-introduce the necessary glue code, XHCI/UDC updates, and build fixes
> > >    required for U-Boot integration.
> > >
> > > The final diff is identical to [1]. I decided to stick with that for now to
> > > focus on the method of how we import or update the code.
> > >
> > > Note that this is compile-tested only. The CI pipeline on source.denx.de
> > > was used as an OK/NOK indicator [2].
> > >
> > > The previous patchset was tested on xilinx_zynqmp_kria_defconfig and since
> > > this diff is identical to the previous, it should still work on that
> > > platform. With the help of a custom build script [3] and with an additional
> > > patch [4], I could boot the Kria KV260 board and make it detect a USB SSD
> > > plugged into one of its USB 3.0 ports. It certainly doesn't mean all
> > > platforms using the DWC3 driver are still OK, but at least there is some
> > > hope. If this breaks your platform I'd like to know, and if you can send a
> > > fix it's even better.
> > >
> > > I tried cherry-picking all the 1000+ patches in v3.19-rc1..v6.16-rc7. There
> > > were a few conflicts, even when backing out the original U-Boot patches on
> > > top of the original v3.19-rc1 import. However, the resulting state still
> > > diverged significantly from [1].
> > >
> > > Instead, I've imported each new kernel in a separate commit. That way it's
> > > very clear which kernel patches are included. Since there aren't too many
> > > patches for each kernel I'm listing the relevant commits in the U-Boot
> > > commit message for easier reference. I did this with a script so it's easy
> > > to make changes, if the approach is OK but we need to tune it. With this
> > > approach it should be easy to tell if a Fixes patch for the kernel might
> > > also be needed here.
> > >
> > > Thanks,
> > > Jens
> > >
> > > [1] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
> > > [2] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30004
> > > [3] https://source.denx.de/u-boot/u-boot-extras/-/raw/master/contrib/jforissier/zynqmp_kv260_build.sh
> > > [4] https://gitlab.com/Linaro/trustedsubstrate/meta-ts/-/raw/master/meta-trustedsubstrate/recipes-bsp/u-boot/u-boot/zynqmp-kria-starter/0001-kv260-fix-usb.patch
> > >
> > > RFC v1 -> RFC v2:
> > > - Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("usb:
> > >   dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: import
> > >   from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")
> > >
> > > Jens Wiklander (60):
> > >   usb: dwc3: restore to original v3.19-rc1 kernel import
> > >   usb: dwc3: import from kernel v3.19
> > >   usb: dwc3: import from kernel v4.0
> > >   usb: dwc3: import from kernel v4.1
> > >   usb: dwc3: import from kernel v4.2
> > >   usb: dwc3: import from kernel v4.3
> > >   usb: dwc3: import from kernel v4.4
> > >   usb: dwc3: import from kernel v4.5
> > >   usb: dwc3: import from kernel v4.6
> > >   usb: dwc3: import from kernel v4.7
> > >   usb: dwc3: import from kernel v4.8
> > >   usb: dwc3: import from kernel v4.9
> > >   usb: dwc3: import from kernel v4.10
> > >   usb: dwc3: import from kernel v4.11
> > >   usb: dwc3: import from kernel v4.12
> > >   usb: dwc3: import from kernel v4.13
> > >   usb: dwc3: import from kernel v4.14
> > >   usb: dwc3: import from kernel v4.15
> > >   usb: dwc3: import from kernel v4.16
> > >   usb: dwc3: import from kernel v4.17
> > >   usb: dwc3: import from kernel v4.18
> > >   usb: dwc3: import from kernel v4.19
> > >   usb: dwc3: import from kernel v4.20
> > >   usb: dwc3: import from kernel v5.0
> > >   usb: dwc3: import from kernel v5.1
> > >   usb: dwc3: import from kernel v5.2
> > >   usb: dwc3: import from kernel v5.3
> > >   usb: dwc3: import from kernel v5.4
> > >   usb: dwc3: import from kernel v5.5
> > >   usb: dwc3: import from kernel v5.6
> > >   usb: dwc3: import from kernel v5.7
> > >   usb: dwc3: import from kernel v5.8
> > >   usb: dwc3: import from kernel v5.9
> > >   usb: dwc3: import from kernel v5.10
> > >   usb: dwc3: import from kernel v5.11
> > >   usb: dwc3: import from kernel v5.12
> > >   usb: dwc3: import from kernel v5.13
> > >   usb: dwc3: import from kernel v5.14
> > >   usb: dwc3: import from kernel v5.15
> > >   usb: dwc3: import from kernel v5.16
> > >   usb: dwc3: import from kernel v5.17
> > >   usb: dwc3: import from kernel v5.18
> > >   usb: dwc3: import from kernel v5.19
> > >   usb: dwc3: import from kernel v6.0
> > >   usb: dwc3: import from kernel v6.1
> > >   usb: dwc3: import from kernel v6.2
> > >   usb: dwc3: import from kernel v6.3
> > >   usb: dwc3: import from kernel v6.4
> > >   usb: dwc3: import from kernel v6.5
> > >   usb: dwc3: import from kernel v6.6
> > >   usb: dwc3: import from kernel v6.7
> > >   usb: dwc3: import from kernel v6.8
> > >   usb: dwc3: import from kernel v6.9
> > >   usb: dwc3: import from kernel v6.10
> > >   usb: dwc3: import from kernel v6.11
> > >   usb: dwc3: import from kernel v6.12
> > >   usb: dwc3: import from kernel v6.13
> > >   usb: dwc3: import from kernel v6.14
> > >   usb: dwc3: import from kernel v6.15
> > >   usb: dwc3: import from kernel v6.16-rc7
> > >
> > > Jerome Forissier (4):
> > >   usb: host: re-import xhci-ext-caps.h from kernel v6.16-rc7
> > >   usb: gadget: re-import epautoconf.c from kernel v6.16-rc7
> > >   usb: udc: re-import udc-core.c from kernel v6.16-rc7
> > >   usb: fix build after resync of DWC3 with kernel v6.16-rc7
> > >
> > >  drivers/usb/cdns3/ep0.c                |    8 +-
> > >  drivers/usb/common/common.c            |   23 +
> > >  drivers/usb/dwc3/Makefile              |   57 +-
> > >  drivers/usb/dwc3/core.c                | 1780 ++++++----
> > >  drivers/usb/dwc3/core.h                | 1120 +++++--
> > >  drivers/usb/dwc3/debug.h               |  432 +++
> > >  drivers/usb/dwc3/dwc3-omap.c           |    2 -
> > >  drivers/usb/dwc3/ep0.c                 |  737 +++--
> > >  drivers/usb/dwc3/gadget.c              | 4152 ++++++++++++++++--------
> > >  drivers/usb/dwc3/gadget.h              |  124 +-
> > >  drivers/usb/dwc3/glue.h                |   36 +
> > >  drivers/usb/dwc3/io.h                  |   29 +-
> > >  drivers/usb/dwc3/linux-compat.h        |   16 -
> > >  drivers/usb/dwc3/samsung_usb_phy.c     |   77 -
> > >  drivers/usb/dwc3/ti_usb_phy.c          |    2 -
> > >  drivers/usb/gadget/at91_udc.c          |   46 -
> > >  drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
> > >  drivers/usb/gadget/ci_udc.c            |  419 ---
> > >  drivers/usb/gadget/composite.c         |    2 +-
> > >  drivers/usb/gadget/dwc2_udc_otg.c      |  174 +-
> > >  drivers/usb/gadget/epautoconf.c        |  289 +-
> > >  drivers/usb/gadget/ether.c             |   21 +-
> > >  drivers/usb/gadget/f_acm.c             |   20 +-
> > >  drivers/usb/gadget/f_fastboot.c        |   10 +-
> > >  drivers/usb/gadget/f_mass_storage.c    |    5 +-
> > >  drivers/usb/gadget/f_rockusb.c         |   11 +-
> > >  drivers/usb/gadget/f_sdp.c             |   12 +-
> > >  drivers/usb/gadget/f_thor.c            |   19 +-
> > >  drivers/usb/gadget/udc/Makefile        |    1 +
> > >  drivers/usb/gadget/udc/udc-core.c      | 1096 ++++++-
> > >  drivers/usb/host/xhci-dwc3.c           |    4 +-
> > >  drivers/usb/host/xhci-ext-caps.h       |  158 +
> > >  drivers/usb/host/xhci-exynos5.c        |    2 +-
> > >  drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
> > >  drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
> > >  drivers/usb/musb-new/musb_uboot.c      |   39 -
> > >  include/dm/device_compat.h             |   13 +
> > >  include/dm/read.h                      |   46 +
> > >  include/linux/compat.h                 |   15 +
> > >  include/linux/usb/ch9.h                |   25 +-
> > >  include/linux/usb/gadget.h             |  520 +--
> > >  include/linux/usb/otg.h                |   10 +
> > >  include/linux/usb/phy.h                |   56 +
> > >  43 files changed, 7659 insertions(+), 4091 deletions(-)
> > >  create mode 100644 drivers/usb/dwc3/debug.h
> > >  create mode 100644 drivers/usb/dwc3/glue.h
> > >  delete mode 100644 drivers/usb/dwc3/linux-compat.h
> > >  delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
> > >  create mode 100644 drivers/usb/host/xhci-ext-caps.h
> > >
> > >
> > > base-commit: 0f865ab5d68484b4dc1724809de1be06edc85df1
> > > --
> > > 2.43.0
> > >
> >
> > This makes me wonder what USB tests we have. Some boards use USB for
> > Ethernet, but are there any storage tests, etc.?
>
> We've had test/py/tests/test_usb.py for two years now, and so yes, we
> have some hardware tests for USB functionality. I haven't tried getting
> them enabled in the sage labe, but it's on the TODO list. Along with our
> DFU tests, again.

OK, good. We could add some tests to the SJG lab too, perhaps.

Regards,
SImon
