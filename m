Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5782DCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8486884D1B;
	Fri,  8 May 2026 17:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CSg7QiJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9140B84CF2; Fri,  8 May 2026 17:28:10 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA5884D1A
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bc3582acc23so324555566b.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254088; cv=none;
 d=google.com; s=arc-20240605;
 b=EWIPFrijf+fkyMMsaDMvnqyzFx0l9ADN6aE6UIDxc0jIb/xGaLJMubqpTdYH4VHGMd
 DS+uYbRb9eWN3drIO+8kQojF9JzXn1QDkLStW4UPqVjBGQ+F/Ai9UTLhgDeZQJm7mqce
 I88vJbXdt1T5xLu7cufV6j5Rnfn4Oj4Vw8SmZwYq0NlYyk3JfzdlzWOYDeBU4DWTBzBl
 Wc58q51PjV95x5TIyGFvrtrTtt5fbhW89oBMMzGuHGH6K/2RzkwU6YL3aFM8BD41jy4t
 tG3rkOm3OCeG46/W7JZGK5qJpuIJ/qry+zVsT/G911QV3iY3iwq+pO2eLmtZiI2VfN6M
 AXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MgM9E8q0QjRFXnv1uVG2ZHDqx3ZdbrG8Z9dVt5pPxOY=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=lpQeMTb+BwfjbhYmZZGirJ2myyQ20lkBL60OMY1CpgBtp3Q3vqPfVk68fDeqVhTwWN
 1Q5har+Kkn7IVGclgomhvdtSY6nTyP6xdYwj9pZH+H0mfZOKaMgA7ZJr5ND7AGpUN8Vx
 +fj5Q3L6K5gdULCAlYb6J/QLQSv0cFRKfmxWOoGoDaGpajwNDx9k2FNath7T6Dl5FQdi
 UWE1rfcWcFoHPdLkTSKFWvjsii46b+w3bQ2QkcBrYLVuvOiqo5A8B6K82MACORsH+PYi
 FWPfGU5w/XPt33mWTnq9rguIdrBQsleqOi7rcqaYEmv5qscKOnU9bV+Tk125X0/43HuB
 H+pA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254088; x=1778858888; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MgM9E8q0QjRFXnv1uVG2ZHDqx3ZdbrG8Z9dVt5pPxOY=;
 b=CSg7QiJny/ygUoJwUid1t0uO+pxw5Ap62bcda1SWe77TUDiZhj/Hk9PwhKv/Lq+ga7
 JebOmQzUrla+ouaGbMV22p54935YFjRzY8GmzyH53r5rRfoPNlanrAItG6i/KhRtm722
 xLXqHTygGTJd3U9VU25yR3xJQkPjl1n0xDSeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254088; x=1778858888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgM9E8q0QjRFXnv1uVG2ZHDqx3ZdbrG8Z9dVt5pPxOY=;
 b=miDlTAFkF52t8O+R2aiqM/tB8RpWL3dF0peVDWIRJG+i7dGB4i+JA5htN7Fnj+fxo1
 u08IOOFTbTSZ3MgjaHUdAqyYgOEvzUyJ30Zgi+FtqBjkqxFTObER1eLLElVqD/3wvQSl
 Ac3EEBuARQffx2zxh2pBjU5wtDogFXS+4ocRovYfoDqYZ+YinMll98pvpmOCHVGPIgE+
 AksBG6EHwHHyHPX9GdU/ubXDRZk/MJ9cICicQfg7sQh+lu5dy3YZnp+ILulB9u4AvBze
 627xbHPIBWz2+NGXGFLSfUkdRfi0naYukx/7lQLv8iIV61OPtCxeEHWNYaUDGrYYgrz/
 t20A==
X-Gm-Message-State: AOJu0YyAk5fUx73NoV9bNfyTgkN5nwj6JtVDvU1nnCpDHYiUzE8WjnLN
 FW4MdE8Cfu3/saY3xGr9G8610eW3x0Yd7YdO/yn6nvjFmq9y7o1705uMt/5AQECxnVRjovBrkj+
 ROIO5MtJrFahI55NQjIVF2mjNXAFeDzyLbZgUr1OI
X-Gm-Gg: AeBDieuf8LUjvPvufY0or5YFTXs7g4YX1U3RVKOcMaFcp1k8LwtMS+8QVTXlvK5wvds
 dI/fFiofPyq1ssG5jj/Wc7umYwVMJmQ8yTtEGG2M3/uVALrU2SbngQR6H0lQrlB/O7DQ70HmiVT
 fHyX6R0kPaCBqGEiv3llEySVTmOsBI5WOwM7K2duCL/lVGR2EZr1MEEi+MK9BLBMvf0nTg34XuT
 YOYPsT2ATioIe2DleEEBiDecq3maSl+wJKVpfSEXH3Bqj2OoM3RTZvQe5WD2Q/qaiWexgoC4PuF
 2pz5CSkI4Ka7as4V
X-Received: by 2002:a17:907:1b1c:b0:ba1:1181:b773 with SMTP id
 a640c23a62f3a-bc56b028f46mr781520466b.10.1778254087970; Fri, 08 May 2026
 08:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-9-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-9-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:16 -0600
X-Gm-Features: AVHnY4LehedUUDyL0rM428iY2Lbnf6SNJNbM-e9NLu98DKdBArGpzEhXk-sluHM
Message-ID: <CAFLszTjSnfY=x64Lits80mkFVCdFXVSfzdCQQLYC06yiXk4o_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/64] usb: dwc3: import from kernel v4.5
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
> usb: dwc3: import from kernel v4.5
>
> Sync Linux kernel dwc3 changes from v4.4 to v4.5.
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
> List of commits: git log --oneline v4.4..v4.5
> Commits imported:
> c450960187f4 usb: dwc3: Fix assignment of EP transfer resources
> 6a4290cc28be usb: dwc3: gadget: set the OTG flag in dwc3 gadget driver.
> 5072cfc40a80 usb: dwc3: of-simple: fix build warning on !PM
> d9261898a4b2 usb: dwc3: gadget: don't send extra ZLP
> 95ca961c758c usb: dwc3: gadget: pass a condition to dev_WARN_ONCE()
> 46a01427e969 usb: dwc3: trace: show request flags
> 04c03d10e507 usb: dwc3: gadget: handle request->zero
> b084662776be usb: dwc3: remove dwc3-qcom in favor of dwc3-of-simple
> 16adc674d0d6 usb: dwc3: add generic OF glue layer
> b5d335e5ea6a usb: dwc3: ep0: fix setup_packet_pending initialization
> ac7bdcc1b3ad usb: dwc3: gadget: simplify next_request() return check
> acc38c4970ca usb: dwc3: ep0: purge dev_dbg() calls
> 1407bf13e3bf usb: dwc3: core: purge dev_dbg() calls
> ec5e795cdefb usb: dwc3: gadget: purge dev_dbg() calls
> bb423984c28e usb: dwc3: gadget: simplify dwc3_gadget_ep_queue()
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   |   8 +-
>  drivers/usb/dwc3/core.h   |   4 +-
>  drivers/usb/dwc3/ep0.c    |  17 ++--
>  drivers/usb/dwc3/gadget.c | 204 ++++++++++++++++++++++++++++++++--------------
>  4 files changed, 157 insertions(+), 76 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
