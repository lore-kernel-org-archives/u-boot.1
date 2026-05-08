Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16C1CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B68A684D23;
	Fri,  8 May 2026 17:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BEan3QMv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E60A84D3C; Fri,  8 May 2026 17:29:17 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4348C84D23
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-356337f058aso1455227a91.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254154; cv=none;
 d=google.com; s=arc-20240605;
 b=eRuLEUOhrk4VtisyrLD7hiWsKQg6v8+8Bls4WJpv0c1Sz/ehu2z2tgXt3JV1Fcqhe2
 NTUQgTqINrvxJcNo9eE95hH4J+RT7Xx1RUG8TVQrqniidMuabTaCRkMAnaUxxd9qmCwo
 jVPVVHwdAM46ueojIYKvVFP2Dx4rChqWXWZlvsSi73k8BbPyCxDK/3s2vVzetnL6caaK
 PSevZnNxMbmtVUdA/VDVA3LQqZpLI+XI75u1ifmpVRelIBLt8uOYv+osGwDNLxMoSK/5
 VCngg553sjWHqBhoQw9bdT+kE+Vywh+jUUENvItvOSZ4+YLwEnybk+iWJyWkucJmgaGQ
 3PLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yYN98aN8VGNx6MLoPHCa5eKujg0vdhfXCQxmOqw79Z8=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=HaoGt7mZCy+FDf9isKJJeBpF6mKtc4lT0DIAd8NDB86fgPv3v9bxnWCdUcO8IY/UJ0
 KflNAiugDuPxDcA9m9TXi0l37theDNiLS8iOnfjniTrZLBYjpGbnLq0glbVuZBsoQ4UD
 I85PKyyWSmcDsUQHwkmA33Nad3iXg4BXUI2I7DNMKt4JkJAd+W+mGnpPm6EpHkp96QNI
 Cz51b98/xu3bWgjIqPkn700C2sDoHa7eeX6dF0/YOePcvDwN3u/l7mBUGyRqVfxvZR5d
 Bc7bqqt/SpdM/aJHnPDzkK8wdbrG8DDDi4pYeEX53YYpESeLib2pissEZpJw8y3flcbH
 DV8g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254154; x=1778858954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yYN98aN8VGNx6MLoPHCa5eKujg0vdhfXCQxmOqw79Z8=;
 b=BEan3QMvvGdlVbA9DyJoGW9RI51WU1Csz/4LBfRumT/b4ZhPcpAs6GmwX2DBrcCwrK
 +YRyi8URzD4CisBhDyP4uSI0zd2tcAL/0sB9jUxhpMkuygmUGlo8VWcLlAqtlWXHmDxY
 Prw2ex1JoKuFQL0Jm1oY5qQt2u0UG/radSaH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254154; x=1778858954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYN98aN8VGNx6MLoPHCa5eKujg0vdhfXCQxmOqw79Z8=;
 b=GkkFf69uagkU+USoKcqbvh5Lk3RjLxsbseD3WdRnWLtW1ptbwAC1xNYJGhrMoEfyIf
 WmpXoqgZk+T6W/Mhhor069NxSUYwldsTfWsiDlHVsd9cOD17rzYuVhNRgouIAb4Rjwof
 6bgc/HjVBdU/8lHMA1oWc+JTXnR6k3FzR7qxXRBmx5AFbieXktj5jJBvB9ApqjAvwyeB
 OFQNbhzj/lKSih6aZL68tUogQC7eiX61M+c3iBQCwGugiDrKt1qRWhKhOypp+lneY0ep
 m2UkEMkLxaU+mEFUBL27sI9jMkPCEfF0IRZvgQKP60pP8cWgYIvpURHwCYLpI6n1UVpB
 NWLg==
X-Gm-Message-State: AOJu0YxIdOJBghTX2Eck/YyZ8DGTCxlBEWiTJkyfzSRKVKZg5xJIZEUP
 6Xgyv2skO7CNHFg3Oqp8fI1dUyTQsQPbdTRY7iywh2nk027ibVvVy+yEaBnM01uH4CVBTNf9Ume
 TE9seOEGg9E8/WKPt7eRYuKdLpvdTDJ/mfXJGp/f5
X-Gm-Gg: Acq92OGai/qxPJed4SLDpvPZSeE0BPTZ5xEFi8e9Oe1qt+qKFjsGRIZ69n4gD7d4Yve
 8tqJkjiZqux1+XB+2APCxLiXU2Bb/L7+lXln5eh4xF4RA/te+PUb+B/mVFXlkn+3k9SkS1UJrBa
 DTZPFP+J/vcnJYC+bL34oyFUP0hGk1zmQxnVug88hqE13tXlJbcZBSyn/LeNmfOO7d5gvGt/fO0
 4JVQMTEBUcQiYhuxPOr/h7Pr+gKfyyXp2KwKDfGR/VrIq3542djXeiKfuKE1y64NkjMgdzhFgdT
 wzpwDQ==
X-Received: by 2002:a17:90a:2cc6:b0:366:132:fda6 with SMTP id
 98e67ed59e1d1-36601331eb6mr5979023a91.11.1778254153690; Fri, 08 May 2026
 08:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-22-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-22-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:28:50 -0600
X-Gm-Features: AVHnY4Id25t3LhaVTc0jJSWsqE_hmPGmcSqISX2VP5G7XqiriiYCrRNX918OpdY
Message-ID: <CAFLszThj1uAAm=308Pc3ASgQ=bjzVen=OfD2R5+05grUbCSCiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 21/64] usb: dwc3: import from kernel v4.18
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
> usb: dwc3: import from kernel v4.18
>
> Sync Linux kernel dwc3 changes from v4.17 to v4.18.
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
> List of commits: git log --oneline v4.17..v4.18
> Commits imported:
> 9566a7c72f4f usb: dwc3: gadget: remove redundant variable maxpacket
> 9925e6ebe5c2 usb: dwc3: qcom: mark PM functions as __maybe_unused
> 93ef2dc0c4f7 usb: dwc3: Fix error return code in dwc3_qcom_probe()
> 615277779f41 usb: dwc3: Only call clk_bulk_get() on devicetree instantiated devices
> 896e518883f1 usb: dwc3: of-simple: fix use-after-free on remove
> 00908693c481 usb: dwc3: pci: add support for Intel IceLake
> 535c8dc5c480 USB: dwc3: no need to check return value of debugfs_create functions
> 3bea1cfcff11 usb: dwc3: Remove DEBUG define from Qualcomm DWC3 glue driver
> 05645366f389 usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue
> 691025107eb7 usb: dwc3: gadget: dwc3_gadget_del_and_unmap_request() can be static
> edbbfe19444e usb: dwc3: dwc3_get_extcon() can be static
> 31a2f5a7e136 usb: dwc3: gadget: init req->{direction,epnum} from alloc_request()
> d7ca7e1896b2 usb: dwc3: gadget: initialize transfer index from send_gadget_ep_cmd()
> 4439661d64f5 usb: dwc3: gadget: assign resource_index inside get_transfer_index()
> f62afb4929a8 usb: dwc3: gadget: always start isochronous aligned to dep->interval
> d513320f1fd0 usb: dwc3: gadget: don't issue End Transfer if we have started reqs
> e1d542f712e1 usb: dwc3: debug: decode uFrame from event too
> 42626919efab usb: dwc3: gadget: move dwc3_calc_trbs_left() in place of prototype
> 20d1d43fa09a usb: dwc3: gadget: move set_xfer_resource() in place of prototype
> b07c2db83f92 usb: dwc3: gadget: remove a few more dwc arguments
> a2d23f08038e usb: dwc3: gadget: combine modify & restore into single argument
> 8f1c99cd24b0 usb: dwc3: gadget: refactor dwc3_gadget_init_endpoints()
> f38e35dd84e2 usb: dwc3: gadget: split dwc3_gadget_ep_cleanup_completed_requests()
> 6d9d22dac114 usb: dwc3: gadget: get rid of the length variable
> fee73e6144d8 usb: dwc3: gadget: reduce scope of ret variable
> 6afbdb57732b usb: dwc3: gadget: one declaration per line
> e0c42ce590fe usb: dwc3: gadget: simplify IOC handling
> d80fe1b6e34d usb: dwc3: gadget: simplify short packet event
> b27972b508d1 usb: dwc3: trace: print out event status too
> 8b3b7b66c0e6 usb: dwc3: gadget: simplify unaligned and zlp handling
> cf35fc336e66 usb: dwc3: gadget: remove unnecessary 'chain' variable
> 021595963a3c usb: dwc3: gadget: remove PENDING handling from cleanup_completed
> d36929538f8b usb: dwc3: gadget: split scatterlist and linear handlers
> d5044a04b529 usb: dwc3: gadget: simplify isoc case on cleanup_completed_requests
> fe990cea8ed5 usb: dwc3: gadget: simplify queueing of isoc transfers
> 4d588a145b3e usb: dwc3: gadget: remove duplicated missed isoc handling
> 6d8a019614f3 usb: dwc3: gadget: check for Missed Isoc from event status
> 58f0218a271d usb: dwc3: gadget: remove unnecessary 'ioc' variable
> 12a3a4ada816 usb: dwc3: gadget: make cleanup_completed_requests() return nothing
> 5f2e7975f0df usb: dwc3: gadget: remove DWC3_EP_BUSY flag
> 1912cbc60f44 usb: dwc3: gadget: start removing BUSY flag
> ee3638b897b9 usb: dwc3: gadget: update dep->frame_number from XferInprogress too
> 5828cada9908 usb: dwc3: gadget: always use frame number from XferNotReady
> 8f608e8ab628 usb: dwc3: gadget: remove unnecessary 'dwc' parameter
> 320338651d33 usb: dwc3: gadget: move handler closer to calling site
> ed27442e5093 usb: dwc3: gadget: rename dwc3_gadget_start_isoc()
> a24a6ab1493a usb: dwc3: gadget: remove some pointless checks
> 0bd0f6d201eb usb: dwc3: gadget: remove allocated/queued request tracking
> 66f5dd5a0379 usb: dwc3: gadget: rename done_trbs and done_reqs
> a861282f5037 usb: dwc3: gadget: don't kick transfer all the time
> fbea935accf4 usb: dwc3: gadget: rename dwc3_endpoint_transfer_complete()
> 742a4fff5f29 usb: dwc3: gadget: XferComplete only for EP0
> 38408464aa76 usb: dwc3: gadget: XferNotReady is Isoc-only
> 52fcc0bead0f usb: dwc3: gadget: pre-issue Start Transfer for Interrupt EPs too
> c96e6725db9d usb: dwc3: gadget: Correct the logic for queuing sgs
> a31e63b608ff usb: dwc3: gadget: Correct handling of scattergather lists
> 5f0b74e54890 USB: dwc3: get extcon device by OF graph bindings
> fe8abf332b8f usb: dwc3: support clocks and resets for DWC3 core
> 44feb8e6ea2d usb: dwc3: use local copy of resource to fix-up register offset
> bcb128777af5 usb: dwc3: core: Suspend PHYs on runtime suspend in host mode
> a4333c3a6ba9 usb: dwc3: Add Qualcomm DWC3 glue driver
> e362098f0e12 usb: dwc3: of-simple: Add compatible for Allwinner H6 platform
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   | 157 ++++++++--
>  drivers/usb/dwc3/core.h   |  25 +-
>  drivers/usb/dwc3/debug.h  |  26 +-
>  drivers/usb/dwc3/ep0.c    |   9 +-
>  drivers/usb/dwc3/gadget.c | 773 ++++++++++++++++++++++------------------------
>  drivers/usb/dwc3/gadget.h |   5 +-
>  6 files changed, 531 insertions(+), 464 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
