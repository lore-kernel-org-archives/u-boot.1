Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C77CC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 08:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 112E484844;
	Tue, 30 Jun 2026 10:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="gwcy4A+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A415849E5; Tue, 30 Jun 2026 10:59:27 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6714E84105
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AF6C310ED7F; Tue, 30 Jun 2026 10:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782809964;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Ta7ZVwlFewQssPT5SjgfURPLYXaXPlFczlXIhnYB1EU=;
 b=gwcy4A+JZcbiN0uYVxH6tEvp8U4ds8EVrtSND7/X/Ai4/aXs1nq8xhJOTK9Pjr3NAriAnt
 Ffur+kP5B5b728EGYI9Nuo5c7rckXlS7eHkkThCwR//U+mO2lR2YtF4lzX7oYHbfkQrTab
 hWrxtoavgHRrSDPhf/xyURwFLOlRNSTa+TX2Fi7RpCJ45USHXtJ7jKfTb0lLmY9wzfij2e
 KXv72qx+Cufq13MU0H3svkI0+CSOZ1YSFwJugLaiKJUOm84ECC58G68icFvKwzwRTy4Kyp
 NqBuhLqUh5Ni4p2HTi4RDh8vNExA8LsIMdtnO5fyR33O3cxUgu2na+gkdYo34Q==
Message-ID: <58b13bf5-8075-4adf-a576-2fbd08229733@nabladev.com>
Date: Tue, 30 Jun 2026 10:59:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/64] usb: dwc3: import from kernel v4.11
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
 <20260629084507.3254232-15-jens.wiklander@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260629084507.3254232-15-jens.wiklander@linaro.org>
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
> Sync Linux kernel dwc3 changes from v4.10 to v4.11.
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
> List of commits: git log --oneline v4.10..v4.11
> Commits imported:
> de288e36fe33 usb: dwc3: gadget: delay unmap of bounced requests
> 35b2719e72d3 usb: dwc3: gadget: make to increment req->remaining in all cases
> 0913750f9fb6 usb: dwc3-omap: Fix missing break in dwc3_omap_set_mailbox()
> 1551e35ea418 usb: dwc3: gadget: Fix system suspend/resume on TI platforms
> 73561128eb72 usb: dwc3: Fix incorrect type for utmi mode
> cf3113d893d4 usb: dwc3: gadget: properly increment dequeue pointer on ep_dequeue
> 7369090a9fb5 usb: dwc3: gadget: make Set Endpoint Configuration macros safe
> bc46e23c3425 Merge tag 'usb-for-v4.11' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
> e42a5dbb8a3d usb: dwc3: host: pass quirk-broken-port-ped property for known broken revisions
> 28781789051e usb: dwc3: gadget: read IN ep FIFO size from HW
> 692665c621bb Merge 4.10-rc5 into usb-next
> ffb80fc672c3 usb: dwc3: gadget: skip Set/Clear Halt when invalid
> 538967983b88 usb: dwc3: ep0: Fix the possible missed request for handling delay STATUS phase
> c773bb0b9264 usb: dwc3: omap: Replace the extcon API
> c6267a51639b usb: dwc3: gadget: align transfers to wMaxPacketSize
> 905dc04ea796 usb: dwc3: gadget: allocate bounce buffer for unaligned xfers
> e49d3cf4926a usb: dwc3: gadget: extract __dwc3_prepare_one_trb()
> 843053093f47 usb: dwc3: gadget: simplify dwc3_prepare_one_trb()
> 0e4018ff5d12 usb: dwc3: exynos: Remove MODULE_ALIAS()
> 3e27b3f66a56 usb: dwc3: exynos remove suspend clock unspecified debug message
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Tested-by: Alexey Charkov <alchark@flipper.net>

Patch 13/64 seems to be missing ?
