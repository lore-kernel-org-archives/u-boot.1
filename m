Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDEBC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 08:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB3A8484C;
	Tue, 30 Jun 2026 10:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="J2RtiQtw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2203584409; Tue, 30 Jun 2026 10:48:09 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48FAB84942
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7A66E10DEFB; Tue, 30 Jun 2026 10:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782809285;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=h/b4Px8dIH734clwmTJ6i+2qLuRc7C2Xt19Cr25q4yg=;
 b=J2RtiQtwjorl4itFZ+Vu9VSg2yUuQiTX5XtcXBwMJLEFD+EuQStD1Wv2VaK/d7THxIzZh/
 XdtgyVbRldxPqQsj/RsFHiBBpU5KmqvgQ8LqGp7htTxiLREt05/8bXS/r+QScK5LpEJ/T3
 iZ/Wf/NGuTtX/5xaTiVGdh1sY6P2IM8BUga+kc8jR+tNpPug8zGBuui3dahJi98THQk0pE
 Wn5VVZc3BmuIdcNPHY0wlKlXVTau34ffoX7hX50sFRIimw1riaR8keSNoLdA5nuTnbJQZ9
 mFcPMQTHsK68Xuua0jAgeRMiZdmmrFxQvNDpmOazYu/cUK2hKHHIhWP0AzRKRQ==
Message-ID: <1b7211dc-13bc-4cd0-8286-bc6fac941f74@nabladev.com>
Date: Tue, 30 Jun 2026 10:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/64] usb: dwc3: import from kernel v4.7
To: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Alexey Charkov <alchark@flipper.net>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-11-jens.wiklander@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260629084507.3254232-11-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/29/26 10:43 AM, Jens Wiklander wrote:
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
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Tested-by: Alexey Charkov <alchark@flipper.net>
Was this really tested at this point, or is this TB for the entire series ?
