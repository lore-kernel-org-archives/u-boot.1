Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A79CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C5C84D1A;
	Fri,  8 May 2026 17:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="igno9kFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5DB084D26; Fri,  8 May 2026 17:28:16 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B8984D11
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67389cf78b0so3885287a12.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:28:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254094; cv=none;
 d=google.com; s=arc-20240605;
 b=a8gCTwvZ2fiCaaFtwa9HDrSXZNIadvomXPqZphqVPa6N0U94pO5SKokYuzSOtawhCW
 Wh9c+17MPci1EkgkSTHk/o1qDmyIynFvQmpTM0hVlRDnHH0Ux1XXRiqS4orqcXDRx6w6
 AjfURU5UfgdON+p/abbD8FcPlsp1Dr2Q5WZrZP3wmm6q6xRDccPVZ6mnJJPxPsKC703P
 FwPB4ptcUDiAnP0f3Jz1phB6SOsvAIj1xcaVrGpB/wP8deJ93hsgVbqXk313lBvB2Qfl
 qAaiIW7nCpT1YT7o0a+7wUl9Yl5i7suVQW+ZrhHgGhc8DMHmNGfG9LsbfJq2jSZjwwye
 mjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3CtE4OGC5fDMgjqGCfVW5TmushCMtPp8XUbEn6MxPwA=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=Wykb+t//ycz70iktjwWEdqEfBtaUPcpqLGO6pnk8G3qIEXd3oMtpu/dDzCo+94gMMD
 +Rr4HKHWgrrgVCNhcJtboG4mJRC+BLsmd1OM9IndfjwFYMF7BtZk8z8Z7BTmb0dYhoxQ
 l/WYypy/0DrqbHoz8RGEWqEkIC01M5Nu5AOeJiHt86HPLbcBbH8+DoviSoxLxR8cup8p
 eRAry6zhIzk+b4rPuPrvna5ZpSDRQ012QxryWnR3Yp9HAle5LhVEqpHlqBrwuemOdEYc
 6eKe9VCW01zH3mIlL//jpAcnWodvFOSK/EwL5BIbutGhz7fJjkrCx2+Wl3O3vFm+Q4jG
 myBA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254094; x=1778858894; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3CtE4OGC5fDMgjqGCfVW5TmushCMtPp8XUbEn6MxPwA=;
 b=igno9kFX1n3QMnmtbwC0y49NMssxoDAlnCzdV7gniPjT6be7yQEy7fyTY495V3c/1g
 s84e6aYAYXiDY8Sk3q56RUrN5Yed4QYYwabRey7uuhpYH5vFJNqMJjbD/hQf/647coVB
 g6fnH48ODBBHVVnPFd/6ZC8uq6apvqmXxe2g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254094; x=1778858894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CtE4OGC5fDMgjqGCfVW5TmushCMtPp8XUbEn6MxPwA=;
 b=TpnZ/7plx8c4ehaLSj1Lrpo1fBATEUIUx5ye7ASQ+2x+83XTeN2oH/iCBfWrWXl4Wq
 9JedJiGGbXasbrqd1f2RG8+jGZBt43ciZqVOViWQtMC6bcvUQR+FSmcgWqXAsqjgAkJS
 W4OMyEJoFJH1bB0sXLnvYASp2x7OzFalz8A9OGgvUXvadNFNOa4B8YijONaOuhtWfs0N
 MIZ6jv/dztVi3z6sNC6c1bv8AfWh/gmMTOeaQR1PPARDHpvU6HCp+VaPkwG6EFguVsum
 EPc8wslULp7Qz1XChXTv1RGnCfnlT2Y6HkIDczrs2Q2kJ7i+7NtC4loFa3xjMC25OiMR
 kZHw==
X-Gm-Message-State: AOJu0YxPH1d9fKAql7OkLWRDgGd/2e5rsk7XpM8KrEiq9rO/0YstcEn9
 6j9Q/9aN54W6H3G417uG49LyIQmHN33LTc6Y8PTVTr+SfGkr5E7uU0YGkec5rmbmR7yBGHLfWgW
 JTIV95NtyuemDgDoRSf8x9Nyh8TzYWljYHv98IfFj
X-Gm-Gg: AeBDietXoCws76B5Bj2q7qcMXO5q190LBWAb3vAE3oDLJWp5d7yJZB52MS1JiIXqiKx
 9r+DmsxD/fhSdlqgRiPTRRePzIi4vTEJI7zlt6rJFZZMazN3pF2g95dFOczadUww1bBUOdjlr/a
 97PYctdXk8yDs7B1kgqmAdGRqUZNxBk16xrjvIdJ7t+cD6yzqqJ1bfU+bgmQ8zDaaL5fIa0P3M3
 kbqOTmBeuZt1r7vf5sd4F1zp3pkwAVnX9IENoLwyb6sEoYkhFsQzsdR/JNCWypVuCZBXQjVAgks
 Z1PFjQ==
X-Received: by 2002:a17:907:9345:b0:b9d:1673:9994 with SMTP id
 a640c23a62f3a-bcaacd3d944mr208088266b.39.1778254093870; Fri, 08 May 2026
 08:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-11-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-11-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:24 -0600
X-Gm-Features: AVHnY4L5F530y4gVt2SfV4fSrgVg9U-6z_LgJi8ZsenrphO28O-VBJ2JoNLyUoo
Message-ID: <CAFLszTgrp4whpQd1_BuezzkvDTn8V5PRs_=bHvdBKwN_f=A3iQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/64] usb: dwc3: import from kernel v4.7
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
> usb: dwc3: import from kernel v4.7
>
> Sync Linux kernel dwc3 changes from v4.6 to v4.7.
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
> List of commits: git log --oneline v4.6..v4.7
> Commits imported:
> 0d064a7b9c43 Merge tag 'mfd-fixes-4.7.1' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
> 5baaf3b9efe1 usb: dwc3: st: Use explicit reset_control_get_exclusive() API
> 4aa34ce3c1ee Merge tag 'mfd-fixes-4.7' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
> 002f17bc54ff usb: dwc3: st: Inform the reset framework that our reset line may be shared
> 50c763f8c1ba usb: dwc3: Set the ClearPendIN bit on Clear Stall EP command
> 27a0faafdca5 usb: dwc3: st: Fix USB_DR_MODE_PERIPHERAL configuration.
> 4879efb34f7d usb: dwc3: exynos: Fix deferred probing storm.
> 973986126a41 usb: dwc3: gadget: fix mask and shift order in DWC3_DCFG_NUMP()
> ce15bda10121 Merge tag 'usb-for-v4.7' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
> 2a58f9c12bb3 usb: dwc3: gadget: disable automatic calculation of ACK TP NUMP
> 676e34974481 usb: dwc3: gadget: update DCFG.NumP to max burst size
> 7b9cc7a2b101 usb: dwc3: gadget: give better command return code
> ce046d323d74 usb: dwc3: pci: pass the platform device as a parameter to dwc3_pci_quirks()
> 474799f07376 usb: dwc3: pci: make build-in device properties available
> ae4114137607 usb: dwc3: ep0: sanity check test mode selector
> 69b4269eff5f Merge 4.6-rc5 into usb-next
> 818ec3aba883 usb: dwc3: debugfs: dump out endpoint details
> b058f3e8a399 usb: dwc3: core: add helper to extract trb type
> cf6d867d3b57 usb: dwc3: core: add fifo space helper
> 4e9f311833a9 usb: dwc3: make dwc3_debugfs_init return value be void
> af566a0be6e4 usb: dwc3: omap: get rid of dma_status
> 8e7046b71dae usb: dwc3: gadget: don't interrupt when chained
> 052ba52efa17 usb: dwc3: gadget: remove newline from trace
> 36b68aae8e39 usb: dwc3: gadget: use link TRB for all endpoint types
> 4faf75504a7d usb: dwc3: gadget: move % operation to increment helpers
> ef966b9d3353 usb: dwc3: gadget: add trb enqueue/dequeue helpers
> 70fdb273db37 usb: dwc3: get rid of DWC3_TRB_MASK
> c28f82595dde usb: dwc3: switch trb enqueue/dequeue and first_trb_index to u8
> 5ef68c56e169 usb: dwc3: core: document struct dwc3_request
> 53fd88189e08 usb: dwc3: gadget: rename busy/free_slot to trb_enqueue/dequeue
> 495dd5f78145 usb: dwc3: omap: drop dma_mask configuration
> e58dd357741b usb: dwc3: add disable receiver detection in P3 quirk
> c36d8e947a56 usb: dwc3: gadget: put link to U0 before Start Transfer
> 218ef7b647e3 usb: dwc3: gadget: extract unlocked dwc3_gadget_wakeup()
> 2b0f11df84bb usb: dwc3: gadget: clear SUSPHY bit before ep cmds
> c0ca324d09a0 usb: dwc3: gadget: combine return points into a single one
> dea520a4a283 usb: dwc3: gadget: pass ev_buff as cookie to irq handler
> 696c8b128220 usb: dwc3: drop ev_buffs array
> 660e9bde74d6 usb: dwc3: remove num_event_buffers
> aa3342c8bb61 usb: dwc3: better name for our request management lists
> 8495036e986b usb: dwc3: increase maximum number of TRBs per endpoint
> ca4d44ea2a91 usb: dwc3: gadget: always enable CSP
> bc5081617fae usb: dwc3: drop FIFO resizing logic
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c          | 118 +++++-----
>  drivers/usb/dwc3/core.h          |  85 ++++++--
>  drivers/usb/dwc3/debug.h         |   6 +-
>  drivers/usb/dwc3/ep0.c           |  43 ++--
>  drivers/usb/dwc3/gadget.c        | 457 +++++++++++++++++++--------------------
>  drivers/usb/dwc3/gadget.h        |   6 +-
>  drivers/usb/dwc3/platform_data.h |   2 +-
>  7 files changed, 374 insertions(+), 343 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
