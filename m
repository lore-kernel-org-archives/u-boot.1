Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBB5CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1588784D31;
	Fri,  8 May 2026 17:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G8q1w0gV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659DE84CF2; Fri,  8 May 2026 17:28:25 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 223C984D37
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-670ab084a39so3691255a12.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254102; cv=none;
 d=google.com; s=arc-20240605;
 b=cvxZrztRte3xPA9qMBmw1RGJ2vgXjmt1Vpa0xFLhpGGrSC1i5NiIn0CDpEGP1TC5wp
 6kER5Fbgh9/YzhxRSY7rrlMjTu4BIZwQ2DtNctV2MwlbBdAGPlPTJwN+hxwo29G4CZN0
 oSgwQ4zY2Ru7vGvUP958PYid6Mpl79RYPPeYQ9Q/ALLWY+ZmRoYew/rppnIOwY88ICtC
 59OYirIImkvWSMBu1FmS5Tk38HQ7x+WTIAa20e+rKdAySk56rSnelHPfUtzkQtTVBqKt
 UEblOqWYs4nkToeN4xcgig3L/LX/xug3PICqZnLykb092BlKWtd0vT/EreWQ0yGtM4gr
 /oBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m2sRLKwPEoyOXpEYSOkZJFHNzdOL0X+e5IVZ+npcBQ4=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=WjFzxPTYSSgLhG9eU+S2moC8cVAnKgo1o2HxGLipm7FEC34j/U+XvDyzuJj/8FHAYj
 3u4vwSuo/UzXrX53rDFI+BT/XgFU54+yHWV8zuIuwKzEbHufWsLUKKgfv6nAO46IUBJ7
 tZX6rZCHu/ciDaJ06QUGUkQjUmYsFEYD9z7YBRQ5dHvafwSHPEAvFNw0XMRJ/GGE6Pwb
 tYrWUtBxbl6M1BxcDd+8YQcndozp0AIkEjgZ1/pYHqljocxBYncIzxgfZSukEm+kCjBM
 hZJV2Btwxnf71958jtbFWqrOPtOVVKuL80WGMs1dvnLJGBtCKsX5jfO6lmdKpfCwvGvi
 N+2w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254102; x=1778858902; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m2sRLKwPEoyOXpEYSOkZJFHNzdOL0X+e5IVZ+npcBQ4=;
 b=G8q1w0gV16qvL0+bE020nKzxgf6b5LSGhst4hnYtkgFycLdrINEobRyIvrM11EPNE2
 b/Qsi5+A2rYYbWHF5IB1SdPxNnVKWyuY5H6bcoU0UpgBgWQNW8+0AtM8igUVTMZOV/5M
 Uw7QbIhGMrlwUlXLB/kamxZSfhXuc/JolGUAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254102; x=1778858902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2sRLKwPEoyOXpEYSOkZJFHNzdOL0X+e5IVZ+npcBQ4=;
 b=hfx7vNBh7Bj67IK58Mr0UQJydhZf1CFjmMxzR8NlvV+zTzh9vwG2hSM7sFWStkHkM9
 WshRtwaBFdpz5u8yTsqPsU+XTVPIGqx7UH6rolwAxTuPF837unuID3xzlgPDMYnyRu/K
 TJgPmoRTkJvC0EjRHFKTuCfoN7bctpGtvIriD/uNGtygGCYJAj0gt/iePpfXsYqLrfFO
 hO/L/L+HL4uQaCVOrzRuCunmHqTaRpxtrdMcKqOG2xecpHsBYXvGxANNwS6+v7WsrZ6U
 1bRg7jYeYm2YdQJg0GObeqsRqO6lM894aD7mZnKvJLL34ujWKoygZtSo85a0cS6l5fgP
 sgQA==
X-Gm-Message-State: AOJu0YyU33a/fH7YojpF10tO53BE5Q4dGG2JQ/pBXHqvIHaKQORYgnhY
 tyxy5ilBjDBTO8dxiQ3gMI/9sj9duCeR7jcW03PUPuzIU4PCTP4iEqUbD+eoy1tVTp/I8NRC+xc
 Ttkj1rettp3+P4dwbbRlFfDN9djaxKTs12hIVwZmS
X-Gm-Gg: Acq92OFL6q/iZhZrowJ1HXOu7igMh4vlE1LpJi4G4/WDiWRQSImJecw89sZRNDpFsfD
 eQNYYMjgpVm85P635+YPg9IK14raxEtXugG4J2yFB7WehW6LeEJi15krSZEz3eKZGD6/C0/KEMw
 IPVP5nr0SVzKapwPqHD5nLc6mmtKvqtc3zlSWcYRt7cA7M7U2fUDqvqqbQZesQkBXHri73DyFn7
 HYsawegAghPA53xyNT/0+TOvW39/YfD3YTk3TxisQVASBC3X/BWURwBDE/qFHI24Bhyf9268oRW
 Zjy2nw==
X-Received: by 2002:a17:907:2685:b0:bb5:8532:af4b with SMTP id
 a640c23a62f3a-bc56e40f24amr769779866b.26.1778254102424; Fri, 08 May 2026
 08:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-13-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-13-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:31 -0600
X-Gm-Features: AVHnY4JF8Vv9TE4Bv3jNcgrpow39P7R8TH4Sw6DMkTNPYi53CdpZ0-l4JlKi3OU
Message-ID: <CAFLszTj9Y1tpDh_G6XkcN6XFMAaP021--zM80D94NJYCY7BL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/64] usb: dwc3: import from kernel v4.9
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
> usb: dwc3: import from kernel v4.9
>
> Sync Linux kernel dwc3 changes from v4.8 to v4.9.
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
> List of commits: git log --oneline v4.8..v4.9
> Commits imported:
> 4accb8a1ee7d usb: dwc3: st: add missing <linux/pinctrl/consumer.h> include
> 9b9d7cdd0a20 usb: dwc3: Fix error handling for core init
> 51fbc7c06c89 usb: dwc3: Fix size used in dma_free_coherent()
> d889c23ce4e3 usb: dwc3: gadget: never pre-start Isochronous endpoints
> a9c3ca5fae6b usb: dwc3: gadget: properly account queued requests
> 81522637485d Merge tag 'usb-for-v4.9' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
> b281dc630b41 usb: dwc3: of-simple: add compatible for Cavium
> 26c9cac402c4 usb: dwc3: of-simple: allow glues without clocks
> fc9104d5d717 Merge 4.8-rc6 into usb-next
> 8d53e6267594 usb: dwc3: of-simple: Fix warning during unbind
> 5e6c88d28ccb usb: dwc3: fix Clear Stall EP command failure
> d6e10bf2ba47 usb: dwc3: avoid -Wmaybe-uninitialized warning
> 9d6173e125d9 usb: dwc3: Fix dr_mode validation
> 073c47aca7b7 usb: dwc3: ulpi: make dwc3_ulpi_ops constant
> e6f74849784c usb: ulpi: rename operations {read|write}_dev to simply {read|write}
> b7cf1dc3414d usb: dwc3: ulpi: use new api
> 9b0dd49e3565 Merge 4.8-rc5 into usb-testing
> 594e121f2568 usb: dwc3: gadget: stop kicking if we run out of space
> 7ae7df4982af usb: dwc3: gadget: abolish trbs_left
> 06281d460fc5 usb: dwc3: Add ENDXFER command polling
> 512e47572f7d usb: dwc3: Add revision numbers for the USB 3.0 IP
> 00af62330c39 usb: dwc3: core: Move the mode setting to the right place
> f652191be3f6 usb: dwc3: of-simple: add compatible for rockchip rk3399
> 00fe081dc3a3 usb: dwc3: add dis_del_phy_power_chg_quirk
> 32f2ed864dd5 usb: dwc3: make usb2 phy utmi interface configurable
> 16199f338939 usb: dwc3: add dis_u2_freeclk_exists_quirk
> dc55c67e9c95 usb: dwc3: gadget: improve increment request->actual
> f99f53f24d87 usb: dwc3: gadget: remove condition that never happens
> 1f512119a08c usb: dwc3: gadget: add remaining sg entries to ring
> 2c78c0295fd8 usb: dwc3: gadget: interrupt on ring full too
> 0b3e4af3c740 usb: dwc3: gadget: add sg and num_pending_sgs to dwc3_request
> 31162af447d7 usb: dwc3: gadget: avoid while (1) loop on completion
> 08a36b543803 usb: dwc3: gadget: simplify __dwc3_gadget_ep_queue()
> 45438a0cd9c2 usb: dwc3: gadget: simplify dwc3_ep_prev_trb()
> 737f1ae2556a usb: dwc3: gadget: increment dequeue pointer on completion
> 4bc48c974708 usb: dwc3: gadget: retire LST bit completely
> 1aaaa9acaea1 Merge 4.8-rc3 into usb-next
> a26a142275c6 usb: remove redundant dependency on USB_SUPPORT
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   | 127 +++++++++++++++++---
>  drivers/usb/dwc3/core.h   |  35 +++++-
>  drivers/usb/dwc3/gadget.c | 292 ++++++++++++++++++----------------------------
>  3 files changed, 258 insertions(+), 196 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
