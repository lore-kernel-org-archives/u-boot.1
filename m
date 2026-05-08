Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FEBCD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3277B84CFD;
	Fri,  8 May 2026 17:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UrWy4UEs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F5E84CFD; Fri,  8 May 2026 17:32:24 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1FAB84CF2
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c796163fac5so1460031a12.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254340; cv=none;
 d=google.com; s=arc-20240605;
 b=lT7Nfk9v8QDsbVYUu9crX3RpdDPINAXEDpgRrGVGQxZdEbwiKtoeY/bf16mZ9H3GwU
 52nMav+HQfKA4Q8GxRjqr0BR0jvPITgUsXxquHDPD3ogCnk9sMdQGleyEYIQZnJnPl5R
 Q/jIIPsoCPB9cN2ypKQwvo7fdhVQxUPQYBvOHrcGaCGafxvR5NXXQc1AeMBHxeHosAiq
 cLgK/Jk95GVOjiHSfqdOieR2QvS/kjc8Gw2nYVI+cxM2WwdjE/YiOLP0Yj06SbVzLO2v
 aOp3ufGj9kGrUTte8sgkSXh9YE9ItPoPyQd6ZEtgbTbGBEMQBlz8Qh13g9uyd1sEcXhO
 LT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qw0uqJX670CBEEQhdksM1xACMZgi+iKgM6J0sDE4NEo=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=LZEmwpghx77r0ag8mbKFV2J5RLiKDZEd9ZXhU6PYOO+2N+KiCvRcEzRPUocx2AgDNP
 PTNI+1f/p8685C2M4Y8gEdcvNf+TT8g4bo1DJ8qWMSSn1ontCMNQ5gzTSuqenptkWEct
 FgIilVLeQNGkrEotdn24muPBIAdEuXDaj8ZtpMtrwEMtvLBQMYO9pj3zVz6Lw8eUuzxx
 FWKShSJqJ4dkFWQ5d0/U0+pbB/aS/NnyuC6SQkL2wUMoKXS/mUaXcKlkaDfI/qBNYo8H
 q40bCcj0t+a6uOQvT54u+iohRPZhaqfAAxnkZK8wzlT6llojeYnBk8Qeb/f0C+jSkV09
 Ngmg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254340; x=1778859140; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qw0uqJX670CBEEQhdksM1xACMZgi+iKgM6J0sDE4NEo=;
 b=UrWy4UEshR5jnRodLowSzvImv4uCit/wuSvC/nSxS2gjNZeeEdspvpeXtjmn27GAfL
 sjLLZBBaaTqeF4jdyXkMeOqFs2CVGGZbuG6dkDxXOqtXaIKst/d/T2sxSR2sZG4QkF1X
 Latux0AKGjdzxEiZM4taZgm6YnDeImuOtAJro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254340; x=1778859140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qw0uqJX670CBEEQhdksM1xACMZgi+iKgM6J0sDE4NEo=;
 b=LN0/Gx5dPCVVxdTAR5aGFQZNsoNpens6Hb3WTkTtaqHNvGxdmY7k0d/dSRwKpahS8g
 oW6FK22h266UAMsXgGrDPx/XoPoJZAzgehYAx0oE5EpXXPxNlYhSRM+JugcciDal0Vxx
 SL/U1HQAjZitKmk0t+3fkMApQmUfsO8MudunVY4FNvlf+EeaBg6FefvTTt8C6mZPDjTl
 gRYVze4+xc4ktVbAx9r9VKxA36PtHAwT0Sac26YEt4J+gMxyZ1Mj9m9yWe1SLIM/fNdG
 Mx0q+RyiJO4O/sqbx2xHSGNNkx724IZB6iX7UwARlqLqFZxrswS/4GN5858wEslCzAZ5
 +54w==
X-Gm-Message-State: AOJu0YzD8D9+JNR2hLieh6/7g89FRLRKgkU6F6bRr4N43DV2J2WnI3ZP
 uYjK3PMQNheTF4ylZ9q0Qah0Z7VDWlVxLI4oxqFYRLF5tRaluRoLs3roXL3ubT/yq2QO0t1NHok
 2prvvh/h/F7pzAKZr2mlTiP1396y8FoAuz0Zwa1jM
X-Gm-Gg: AeBDievTgCPXmRONbzPNrcWqbOjaMcUn4wgr2MQM7HpIZj+bEq3tkKxSMC0ZQOGDD3k
 KE9YzLmEBW7MQ6BnOqZg6y+RUM3NCCVBsPTB7rjqNRs6sVAXU8XCCBQTatv0R37uGoRYD3Ogg0C
 8990hEMASOiTj0ywukYtz7cJmavqyu9OlSqp/2kauIHVKtpWpklGnjlXrfXdn5TJ6M7tYOQsuGh
 RiilB47PrIkPfKfopJpdK6/6iE5b24nCjX5db2EGufl1jXPtT5g3UIaggsNYq7IsEdckiNSenrv
 gYVpUg==
X-Received: by 2002:a05:6a20:6a2a:b0:398:d6a9:fc9 with SMTP id
 adf61e73a8af0-3aa5a831c19mr15214800637.5.1778254340382; Fri, 08 May 2026
 08:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-29-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-29-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:31:49 -0600
X-Gm-Features: AVHnY4L7kMOXhYW4AhpfMMT0-I2nyLrXbV_-RSHg5WZSgwPtDHpo4bhhnxW1W48
Message-ID: <CAFLszTgyUSwXP-ump=tZ82DWyuv90TorEPL1vT3b62to6Z9XJw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 28/64] usb: dwc3: import from kernel v5.4
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
> usb: dwc3: import from kernel v5.4
>
> Sync Linux kernel dwc3 changes from v5.3 to v5.4.
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
> List of commits: git log --oneline v5.3..v5.4
> Commits imported:
> d8eca64eec71 usb: dwc3: gadget: fix race when disabling ep with cancelled xfers
> a7d9874c6f3f usb: dwc3: remove the call trace of USBx_GFLADJ
> 9bbfceea12a8 usb: dwc3: pci: prevent memory leak in dwc3_pci_probe
> a51bab592fbb usb: dwc3: select CONFIG_REGMAP_MMIO
> d819f6584c20 usb: dwc3: Remove dev_err() on platform_get_irq() failure
> f146b40ba1f0 usb: dwc3: Switch to platform_get_irq_byname_optional()
> a0a465569b45 usb: dwc3: remove generic PHY calibrate() calls
> 96e46dcfb853 Merge tag 'usb-for-v5.4' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
> 17b63704ec7c usb: dwc3: gadget: Workaround Mirosoft's BESL check
> 91f255a26bce usb: common: Separated decoding functions from dwc3 driver.
> 54fb5ba647f8 usb: dwc3: gadget: Set BESL config parameter
> 16fe4f304015 usb: dwc3: Separate field holding multiple properties
> 1cf084d161f4 usb: dwc3: meson-g12a: fix suspend resume regulator unbalanced disables
> bceb418b65b9 usb: dwc3: st: Add of_dev_put() in probe function
> e36721b90144 usb: dwc3: st: Add of_node_put() before return in probe function
> c09b73cfac2a usb: dwc3: don't set gadget->is_otg flag
> 240b65dc1e89 usb: dwc3: Use clk_bulk_prepare_enable()
> 03bf32bbb607 usb: dwc3: Use devres to get clocks
> 3cd703f483d1 usb: dwc3: remove generic PHYs forwarding for XHCI device
> 4749e0e61241 usb: dwc3: Update soft-reset wait polling rate
> b2a3974253d3 usb: dwc3: omap: squash include/linux/platform_data/dwc3-omap.h
> a6e5e6794a53 usb: dwc3: Switch to use device_property_count_u32()
> 5b76f6a0b0f8 usb: dwc3: keystone: use devm_platform_ioremap_resource() to simplify code
> 58dd0bad2554 usb: dwc3: omap: use devm_platform_ioremap_resource() to simplify code
> c6e4999cd930 usb: dwc3: meson-g12a: use devm_platform_ioremap_resource() to simplify code
> d3523b631403 usb: dwc3: meson-g12a: use devm_platform_ioremap_resource() to simplify code
> b33f37064b74 usb: Remove dev_err() usage after platform_get_irq()
> 41b57327b270 usb: dwc3: Switch to use device_property_count_u32()
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   |  49 +++------
>  drivers/usb/dwc3/core.h   |   2 +
>  drivers/usb/dwc3/debug.h  | 252 ----------------------------------------------
>  drivers/usb/dwc3/gadget.c |  37 +++++--
>  4 files changed, 46 insertions(+), 294 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
