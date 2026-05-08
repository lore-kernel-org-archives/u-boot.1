Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE63CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7EA84CEC;
	Fri,  8 May 2026 17:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UNNBgzzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18DC684CEE; Fri,  8 May 2026 17:26:20 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBFF84BBD
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ba3115fe0d5so583608866b.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778253978; cv=none;
 d=google.com; s=arc-20240605;
 b=V3wBnD0/tOEtdiLT5NaNCpOGpNBvilvKAq11bAnRFXoL/yLU9CvDsivgOjBN2pnsOA
 m/fX5tARohsx/a8EPHcn+Il74VvoqxXzNnQ6wq4wRssCmDatv/3uYdRndJIJsClcWcEq
 2j3bQN+SPmlQT1A7zyxjWiNw1OmUl7UpxF2ywyb2NWstY5NDCu8U+myETOzRM4Y0Sguf
 FLp+N+hX3mf+4gpW/B2ztX4epUpwWrW4cHqNe6MLIyCKQ5Go2lzZRaR8KiIgwRnUhQ2o
 DSnXNhV9sh4NUe4AYc7K2JKZ7XVNPJHUMQTvZ1ZfXSwFL/41W3NNXcPlWbBBEqRF5osx
 wD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1U6hb18Ls8Op0zk7RPlwdfiTdPcyUqmb7tRvuARDKE4=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=a9vfzdg3AJom3llonB/WItdkuBaMyHolXHgVGi5naKpUzab5AkgOvs3nRIfmXHEOBb
 4wKa3bo/eC61qYeD3cUnQgOj34uR4fafb7DpHxiApJ9HHrZkbNhMXCsWucVY1AC1Ypz+
 Eo5d56mv+Prt+VG3WlZGJkbLOS8WlEgr/jNgft+x6Re/ty0ySbilCiSE3GoDybTXWTNy
 DPgOHLEjqV5yfz6wgsVR+c3ACCUxtcknR4ToQ5TSoB2dtpNmkrd5VE64KelpNpa5cUrN
 Y6TBagSj7EreL6nGkCQNgHiH1QR+op0eoonzSkjwBLcj/ljEWbeYROmispgqlXETxeDo
 j0mQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778253978; x=1778858778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1U6hb18Ls8Op0zk7RPlwdfiTdPcyUqmb7tRvuARDKE4=;
 b=UNNBgzzMTESUpsLqDYjFULNJ4YhevAnu5fKOyPA9byFRdpWcbLS3yNcGKXsKcay1Kt
 oPlSjPvaLk2GeCc1zpZYtCtz4vFkb0p2dlmvZ2CLqgX1YUvgKqAg/l8vNn3DPp3bVlq4
 zyUllwT0ibI6pedvvUxNZwLttWhJBQ2ZcmWNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253978; x=1778858778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1U6hb18Ls8Op0zk7RPlwdfiTdPcyUqmb7tRvuARDKE4=;
 b=pr9KxdREXONdcDCPeNJiMAls4xF2rRiaTOjdR3lAD+gFfm6kkzct209EMjsXyjO1sP
 HAOqz6eeCdNsJAwaLWd7OyYRWSNMKTSj4G6sx5ihwE6fAxw5WM5q+Ws6o2C2235pDcF+
 nL1s0k0pxyQaUpzMqoamqPPxaDfUa5ZUTUYSOjq4FApEBuS61TsgzPmPabiXTwTsI64r
 UCFWxOiadPrTMLmh4PuJpUeu6uPz0p8QP9PqanvvICL6r/ah9BhcWR5744bT4mUulAmr
 S0V/nEmPv2+qp9lpb7H3EPVI6sYFj2ekKaTv6yi7Dy/fcIGbP0I7MuW3f2CEM2Spf6RY
 U7cg==
X-Gm-Message-State: AOJu0YwjvO4AoWRjbM1owMD+3C6hLCC+qjc/oOOTdrejbwNhKFeB4Uz1
 kjB7YYt63hd3QHdxGFEIChIF14c7sBrPnnBGsIHG8GEbP+wGYgrulThSVgrPtdAw8i8/iPEFf4K
 9CFuup+DZ0czNk1DgOL0eIJYsT1oKAyqHR/ZuW33E
X-Gm-Gg: AeBDies9qXhcc3EfCZLopM8d8p2UdQsPI/tBMxmBxbizZjTy8xxTCMw4ZKa8t759TFj
 KvT/tITdZqWRfpOkqwlXh/Je6H0beeo89zRgc58pRGNIAaxBW4BZ3e1JyApPs1USnZBP0pZ+cQh
 ravhk/n9EC7B2dv4XTuNVKgKJPuOzBCXT+XjIIqgFf65nwr9nXTAJZVrPR2mFXpdxdF2seX1U6N
 JDdz9tpBQrRn0m3dgLBDaRj/zHSJOC6mvUWlHHfgOfyvatlV1UTU0WP6rhrIlohnCtA/Ys65iGA
 8HjMfBoEA224ejTr
X-Received: by 2002:a17:907:da17:b0:bc6:3122:c241 with SMTP id
 a640c23a62f3a-bc85c890f00mr415718666b.18.1778253977592; Fri, 08 May 2026
 08:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-5-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-5-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:04 -0600
X-Gm-Features: AVHnY4K4WVI3hbZw8DlCmw5uDu33SIQInVB1JU9hJxg7-U4TRZtFbNFo0qGIecI
Message-ID: <CAFLszTgVWEdSq8VM5YWxdms2o2193HW4L1WirgV632DCy4o=sg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/64] usb: dwc3: import from kernel v4.1
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

Hi Jens,

On 2026-05-07T09:27:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> usb: dwc3: import from kernel v4.1
>
> Sync Linux kernel dwc3 changes from v4.0 to v4.1.
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
> List of commits: git log --oneline v4.0..v4.1
> Commits imported:
> 459e210c4fd0 usb: dwc3: gadget: Fix incorrect DEPCMD and DGCMD status macros
> [...]
>
> drivers/usb/dwc3/core.c          | 59 +++++++++++++++++++++++++---------------
>  drivers/usb/dwc3/core.h          |  6 ++--
>  drivers/usb/dwc3/gadget.c        | 37 +++++++++++--------------
>  drivers/usb/dwc3/platform_data.h |  1 +
>  4 files changed, 58 insertions(+), 45 deletions(-)

> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> @@ -811,17 +811,13 @@ static int dwc3_probe(struct platform_device *pdev)
>     Commits imported:
>     459e210c4fd0 usb: dwc3: gadget: Fix incorrect DEPCMD and DGCMD status macros
>     228321904089 usb: dwc3: dwc3-omap: correct the register macros
>     eac68e8f979b usb: dwc3: make LPM configurable in DT
>     adf9c3c85615 usb: move definition of PCI_VENDOR_ID_SYNOPSYS to linux/pci_ids.h
>     8f2c9544aba6 usb: dwc3: gadget: drop unnecessary loop when cleaning up TRBs
>     3d0184d08757 usb: dwc3: omap: call of_platform_depopulate() instead
>     3da1f6ee3563 usb: dwc3: core: only reset res->start in case of error

Reviewed-by: Simon Glass <sjg@chromium.org>
