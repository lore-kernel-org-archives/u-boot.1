Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7748CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F67D84D0C;
	Fri,  8 May 2026 17:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MYdFJiP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E91284CF2; Fri,  8 May 2026 17:29:07 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49DB484D38
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ba922426c5cso369837666b.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254145; cv=none;
 d=google.com; s=arc-20240605;
 b=ZXXTT3Ehob3E9HTp625IloQVDX6MBFmY6t/ggG94RMheG13ugc8f923CKSamru1WXi
 v6Z0ZQgEz2zgG9MMOfqLbz8CNXmQviQw9imEfirqjfjX16r5s1qeLkJMQhgVTb9MTdRE
 W3jAKncqfHBOFhjthHNt/PGt24exe/JviOWZ8UVlZeJlXmvsaqyr5WAyJKwdV2D85ocy
 WsCkNce1uidvtxHHdN52faS2HOeLBtWTC8LUWbk7YIjkXfzPE+jFeLRtDRz/4AHTy5Fm
 2BwCE7urzoGIfeLyri/RwsIRUMDvPjP12YzG0SP3Iq5tt7UNJ58wEaC/Wx0gs9Vn2ljH
 Zduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zItbFJ/kH8bcQVjIBkUedC/RsiNj5fPrrmqEwLHCwcI=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=hlH861QT4t5O+NylqCemp5IIH6JcLM6OuB+P52JSRZzI2mqbJ1iLBEf7golPmeONyL
 HeAeJ//dQcKuofDnpX2sn/mUc5a7hV+LYxtIGVgHKxXjKHvBoP8qb/dsvCTZ+dahRxCd
 VQ3tLs0HFJM1dnvJrnCs05CfTiawUpZFqz2E/QY/M6yryvENM5mrD6N+Glg0D3+ARHxh
 IkpEmgSPwkbuDHUoJDuKTtiPiqoRGLHYV9FUOglY68H1smhHzqBJJTjcuw6tnF3/rPUG
 HZ9OFDQFhMqlFQjDSKmwk4xIzNfD8Z2PNf54gt8/PXvWvdQatf9+PVXHSxZ07PNujO6M
 M1fA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254145; x=1778858945; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zItbFJ/kH8bcQVjIBkUedC/RsiNj5fPrrmqEwLHCwcI=;
 b=MYdFJiP/+AUbqH14owoqxCsJ6lA+PoMcqN5B4WBNV0HB9wQH5zLl3sq4eN/7QS3wOX
 +ih22i93JyTJMCdasA7kwC74sy9RaI++a6BAKoamFZVZsRooRQBsdjZd4WpT6woJ641c
 mT9Vg4xiX23xA6vA4Em8XyZcFPw/g4hacDP18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254145; x=1778858945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zItbFJ/kH8bcQVjIBkUedC/RsiNj5fPrrmqEwLHCwcI=;
 b=L9Ng1mOaigd2ZbRPZgN10LmgR8QsiHWh6iuQylSpgPNE8elDYG4vAGMd2helCGprqr
 lA+JXv2TGBBkIocq7TL7H+tBAp7nZ001daTiWOGkXK7ytT2rLzBeTYCz576DuU/ypprX
 A00duWi9EcxQfZglaK8pQiAAfJ33ii823lvdiULeRKlibRoxvhsWCZvXA2qxW6gAhZe6
 3xZkjmp2hpKPIDI9QKBdziIPESVPCWNt5xKk07v4YpT1sDsFIhCwM0B5MSY0IK2MGwt0
 mvSgZQZdD+hVUI3Cv8FzJkVVDiLF//wCvUxI7rl6LnR9AQhG39aPWwoM3ZJPTA9YGUG5
 o0NA==
X-Gm-Message-State: AOJu0YyMXfUaRMb/syU0dICv0fm+6btINZyHTtrg5QQXWqp3BC04jAmT
 21dd77A0NVaVW5hhP4716tr+8XlidjNR6jzhG9AhkNpzY9tZT/GtPes6wbEApHWOp4QSuvS44L7
 Xs64YWMuoD8MbPxHts35k5Sag/H4DWom0ZfZ/M4//
X-Gm-Gg: Acq92OECCIVRgKIo51N8SVnSv0WPs8Vpg0jh8W1zf0KlE+wtxS+fKGJT23dlARDYsFJ
 FBTjbsZ5lWW3hnhIuKV13NsB2GiWYW7R5c2jQeaJ+Np81z4xt+HEv8Le8BpuX8gEp39GKWXFRv4
 Re0ps7B1g0lsnPsyulePC0CyO8H5xIoqUj2WP8p6grtlat29a4N+MDx1T0L3rZ7u4hXqXWPRxTK
 spR64B2ShAOvnU/XD0R1JUySv5A9qRxs3N56soDqqBVgpmjNefZ9kyajz9l9pr8UFqtLgPeX7C+
 eRl4uA==
X-Received: by 2002:a17:906:fe42:b0:b9d:2fce:308b with SMTP id
 a640c23a62f3a-bc56d80c34fmr779534766b.30.1778254144404; Fri, 08 May 2026
 08:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-21-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-21-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:28:48 -0600
X-Gm-Features: AVHnY4Kb7HllWkdyQbV6sT1WLCd0QP36VAMveSXAY-qX8pvas0s6orpdaxmZF_0
Message-ID: <CAFLszTiTqB9x_giD_Gvf_5SHN5Z09d_fF+1MUph5uOuRbDsvMw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/64] usb: dwc3: import from kernel v4.17
To: jens.wiklander@linaro.org
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
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

On 2026-05-07T09:27:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> usb: dwc3: import from kernel v4.17
>
> Sync Linux kernel dwc3 changes from v4.16 to v4.17.
>
> The following files are preserved accross the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
>
> Skipping unused files:
> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
>
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
>
> List of commits: git log --oneline v4.16..v4.17
> Commits imported:
> 96bd39df29c2 usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue
> 9cffd15de0c3 usb: dwc3: gadget: dwc3_gadget_del_and_unmap_request() can be static
> c91815b59624 usb: dwc3: gadget: never call ->complete() from ->ep_queue()
> 6d23ee9caa67 Merge tag 'usb-for-v4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-testing
> 7d11c3ac6669 usb: dwc3: core: Fix broken system suspend/resume on AM437x
> 2f3090c6a8f2 usb: dwc3: Check controller type before setting speed
> 80b776340c78 usb: dwc3: Dump LSP and BMU debug info
> 938a5ad1d305 usb: dwc3: Check for ESS TX/RX threshold config
> 6743e817a4de usb: dwc3: Add DWC_usb31 GTXTHRCFG reg fields
> 01b0e2cc7d89 usb: dwc3: gadget: Check IP revision for GRXTHRCFG
> 2fbc5bdc8fd1 usb: dwc3: Add DWC_usb31 GRXTHRCFG bit fields
> d548a61767fa usb: dwc3: Check IP revision for GTXFIFOSIZ
> 0cab8d26d6e5 usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields
> fab383333877 usb: dwc3: Add SoftReset PHY synchonization delay
> cabdf83dadfb usb: dwc3: pci: Properly cleanup resource
> de948a74ad6f usb: dwc3: Makefile: fix link error on randconfig
> a8f25c36f732 Merge branch 4.16-rc6 into usb-next
> 7642d8386ac7 usb: dwc3: ep0: remove redundant assignment
> 498f0478aba4 usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
> f09cc79b4b33 usb: dwc3: add dual role support using OTG block
> daaecc6541d0 usb: dwc3: prevent setting PRTCAP to OTG from debugfs
> 4cff75c7fe3d usb: dwc3: core.h: add some register definitions
> e8284db48f1f usb: dwc3: of-simple: add support for the Amlogic Meson GXL and AXG SoCs
> ff0a632f0875 usb: dwc3: of-simple: add support for shared and pulsed reset lines
> 6d5b53c1fd5c usb: dwc3: debugfs: Re-use DEFINE_SHOW_ATTRIBUTE() macro
> 134d1fd44221 Merge 4.16-rc3 into usb-next
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   | 132 ++++++++++++++++++++++++++++++++++++++---
>  drivers/usb/dwc3/core.h   | 146 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/ep0.c    |   2 +-
>  drivers/usb/dwc3/gadget.c |  84 ++++++++++++++++++--------
>  4 files changed, 331 insertions(+), 33 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
