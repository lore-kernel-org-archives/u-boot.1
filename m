Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98291CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94CE84D1F;
	Fri,  8 May 2026 17:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N7CWaL4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CEF384D23; Fri,  8 May 2026 17:28:13 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 689A584CF2
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ba922426c5cso369649566b.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254091; cv=none;
 d=google.com; s=arc-20240605;
 b=UzJ3k7J30y1L6ztTsoc/YIxLPr8m7fGXKi4clzWI0Q8OUI4YB7hM0wmuNId42YW9m5
 g31aZv3yXb7+gFlPpvI+QpCpboUQDN8z0/OPZKeuSu6+9eiw0gsFeu3xJVh8SPs7RENH
 5/R6SljQMfENNrU1Y3J7BKsuxYum+ZeNK1Pshr6Q2o4E2Wu1oSF/y+ymQqCqUywRsa2n
 7YaxhLBGrNj19CTibvRlUTDCTNd9xJt+aS6NJ+Z242+fqe4bPHV2Pmw6G+zIaVJIZas3
 BET6JNJFRJ1fxtMD9Fxwce0Q/1fBqAXxq+hc6ib6XRPfszN76eg33jehv1exLhEZF0Jy
 IF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qrk0ES76V9wE0fgFD4SSim3Axp8T/rJqhzqYQNA3U7Y=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=L2NGR8Mt9IfrEars7bPq5I03Qz/z0F4kjpbBRwHBkx9ViLDRku0YzOpbwUGxplO1m/
 rHLqXO129+k9VFOP8YMnLFg92pGlB0O4XCuP72Z+k70nRG3FGCkLa4KNfgyXFsALw1Bt
 sulwKx9Tnts1Aj05+6Ml7TZEHtSleNbzVmifq+gli02eQr5teZQp/zJOuv7l+pl7lS7n
 pLzUp52rm8FLhMiPiqnmC9Ybww/Zsx3X6D34rYvbi3uX4b740RyjOVyWDcfheReF8uoz
 HeruziQ1R22Uzhj43Gs0tC/R5qKJAwLswl8MLG5PFuQ/dKPZ/lcul8gYqOQFc3sMdHq+
 JoRg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254091; x=1778858891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qrk0ES76V9wE0fgFD4SSim3Axp8T/rJqhzqYQNA3U7Y=;
 b=N7CWaL4/OS720mgiANQUk3Ij2Gki5vNlRNUSHC4ZmN2HmXy1FaSrKZcNHqP3R3EyvL
 iLC8Rx/jBQGVANE5Sr/LHVlCJP6upu7/w5jKkrSPxWXoo6F0y75SvZrbBSm9gQgGMH01
 1pgjz4UsYk+SQxOkH7NeKxG+hAbDpDATN9mZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254091; x=1778858891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrk0ES76V9wE0fgFD4SSim3Axp8T/rJqhzqYQNA3U7Y=;
 b=V1YbK8wd2Ny9+0gt5PrFF88ATZd7wCmrueDgulh/ar9s6fNOFbQcfOSt9VRI2JeqxW
 9qQiE3+7Xa62MLUmQecxRTal6gosTqi140Y5QF0Sl7YykdEgtr2z7P3HBt4xWflwmzUB
 vHzhXOhWrH9nH0R1jkseHbMFUDvy9t+RRJNf7ePGJkY/fxRKt8SvE6+JCuN+sv40F5V8
 nT0TNAAtFsFT6lBmzk3MF/68snJOZG+AbOFez5dg/YaJzuBF4KcvV5UE5KvrFtF7ng43
 6CUIz3HwlkHh2XbnTWSu29da9v8mojHG4Ja8CVCkmQFgsaScnC1cJ8CZ7rgD1QvIgcss
 CJEg==
X-Gm-Message-State: AOJu0Yz5DxhLla6Im9z0HKDduTQD34VVllIvFZ4xSg0sI9zSEyNkZLZx
 sLhR8Rp/n1lR4yf+yxH9/s4UlkzJIj5MHsbpF8huWKca+cfuyPIt5EjFnaytf/fIdpW1vBisSfa
 IDqHVSe0wB+rClG7nf2U6K2RoCVYFgrAFZr5u1HYt
X-Gm-Gg: AeBDieuinEmTD1qiKk5VaeXrSrSSQxu9qBkXEI31C1ALfljSeQVrn+MRFtOh2Qx5XPR
 sZxaRKK+TI2v4Wi9RzyV8PbnV9TaWM5mMeJjImU2k0tcTMrEWKCScA3F4hx0NV0NQ+UZz8hytF6
 RoY+vpqpC+M8B0S+O8O40lyjlf7tnO5OfwLAk1zVZnAWh60w6aj//BKTsNeGSsyryjP4gzWVxT/
 2wd9GYhlWucIg3p1UKWh7havGJLenGIYXd/kLYW4/TIIcGCHpKPLviOTu2IMiCHV7N+F5rqYN8d
 I8EMPw==
X-Received: by 2002:a17:906:9f8a:b0:ba0:fd75:9c58 with SMTP id
 a640c23a62f3a-bc56d717ed5mr804201866b.32.1778254090655; Fri, 08 May 2026
 08:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-10-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-10-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:19 -0600
X-Gm-Features: AVHnY4IeZwaY3p-RJujQkf6gZ1r9jbwml9NXyE_5eFnBjryjKXfTahuJBITSB5k
Message-ID: <CAFLszTjDJ8_7pFKQGq=6NkEBNhY+sU70h_Ym3hLPD6jCkq8=EA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/64] usb: dwc3: import from kernel v4.6
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
> usb: dwc3: import from kernel v4.6
>
> Sync Linux kernel dwc3 changes from v4.5 to v4.6.
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
> List of commits: git log --oneline v4.5..v4.6
> Commits imported:
> 9772b47a4c29 usb: dwc3: gadget: Fix suspend/resume during device mode
> e6bdf8195b4a usb: dwc3: fix memory leak of dwc->regset
> 5c4ad318de3b usb: dwc3: core: fix PHY handling during suspend
> 45d49cb706e5 usb: dwc3: omap: fix up error path on probe()
> adf9a3ab90eb usb: dwc3: keystone: drop dma_mask configuration
> 1ffb4d5cc78a usb: dwc3: pci: add ID for one more Intel Broxton platform
> e901aa159dac usb: dwc3: gadget: fix endpoint renaming
> ad14d4e0308a usb: dwc3: gadget: release spin lock during gadget resume
> f59dcab17629 usb: dwc3: core: improve reset sequence
> 33c1f638a0fe Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> 77966eb85e6d usb: dwc3: Validate the maximum_speed parameter
> 7580862b3e80 usb: dwc3: Enable SuperSpeedPlus
> 2c7f1bd9127a usb: dwc3: Update maximum_speed for SuperSpeedPlus
> ee5cd41c9117 usb: dwc3: Update speed checks for SuperSpeedPlus
> 1f38f88a24c8 usb: dwc3: Update register fields for SuperSpeedPlus
> c4137a9c841e usb: dwc3: DWC_usb31 controller check
> 71e41bbb4379 Merge 4.5-rc6 into usb-next
> 3d755dcc20dd usb: dwc3: Remove impossible check for of_clk_get_parent_count() < 0
> 172ad9af55d2 Merge 4.5-rc4 into usb-next
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   | 54 ++++++++++++++++++++++++++++++++++++++++++-----
>  drivers/usb/dwc3/core.h   | 11 +++++++++-
>  drivers/usb/dwc3/ep0.c    |  9 +++++---
>  drivers/usb/dwc3/gadget.c | 47 +++++++++++++++++++++++++++++++----------
>  4 files changed, 101 insertions(+), 20 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
