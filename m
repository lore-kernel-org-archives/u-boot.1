Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7310C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 22:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9241F84B42;
	Wed,  1 Jul 2026 00:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="EPH5CLag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA1584B33; Wed,  1 Jul 2026 00:25:57 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 110C984A1D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 00:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DD54A11872C; Wed,  1 Jul 2026 00:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782858355;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=RCUCFCKItsD1Fj8Ha41Rrx+zL+ONgzsOhU+FK/py6EI=;
 b=EPH5CLaglOCgEQ4FKYn4o2dxhI09UFJ4nMtGo59+uw+1f5Q77wjk3hpdjXX7WKYYdAj8Vt
 TcG4nHV0oiAW0oFRVH+G97YNoim96K9QX0+KG0S2asNgeDghWJE5xDUYSDDlg2iTTpJFrX
 9GFJZGqFrr+cl47BMUwGubfjr0fHlcshllrYYwgEX1OdWr4hI/8qUZprdWpe06jNwo062z
 IoNo/f2B1DGVaYvcRam9yz1dDeHgXvcel3sJZjqkEfIvESwVgFbft6AyVSoRr0sxkv1U4A
 0SESiWERWA5IeK/uVQA4oNzc0BceePb7u3HK6PMgPNJf2i/IkQTkLt5jOt/MCQ==
Message-ID: <9b3be725-b82f-485f-a133-7d837c0ceeaf@nabladev.com>
Date: Tue, 30 Jun 2026 12:06:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 44/64] usb: dwc3: import from kernel v6.0
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
 <20260629084507.3254232-45-jens.wiklander@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260629084507.3254232-45-jens.wiklander@linaro.org>
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

On 6/29/26 10:44 AM, Jens Wiklander wrote:
> Sync Linux kernel dwc3 changes from v5.19 to v6.0.
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
> List of commits: git log --oneline v5.19..v6.0
> Commits imported:
> f5c5936d6b4d usb: dwc3: st: Fix node's child name
> 91062e663b26 usb: dwc3: core: leave default DMA if the controller does not support 64-bit DMA
> 6000b8d900cd usb: dwc3: disable USB core PHY management
> e41a88f38d87 usb: dwc3: qcom: suppress unused-variable warning
> 040f2dbd2010 usb: dwc3: gadget: Avoid duplicate requests to enable Run/Stop
> bad0d1d726ac usb: dwc3: pci: Add support for Intel Raptor Lake
> ac6928f83f8d usb: dwc3: qcom: clean up suspend callbacks
> e3fafbd8e365 usb: dwc3: qcom: fix wakeup implementation
> c5f14abeb52b usb: dwc3: qcom: fix peripheral and OTG suspend
> 6498a96c8c9c usb: dwc3: qcom: fix runtime PM wakeup
> a872ab303d5d usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup
> c06795f114a6 usb: dwc3: qcom: fix gadget-only builds
> 762e744922b5 Revert "usb: dwc3: qcom: Keep power domain on to retain controller status"
> d2ac7bef95c9 usb: dwc3: fix PHY disable sequence
> dc14036fb324 Merge 5.19-rc7 into usb-next
> 69bb3520db7c usb: dwc3: qcom: fix missing optional irq warnings
> 07903626d988 usb: dwc3: core: Do not perform GCTL_CORE_SOFTRESET during bootup
> 5e76ee96be8f usb: dwc3: ep0: Properly handle setup_packet_pending scenario in data stage
> 8affe37c525d usb: dwc3: gadget: fix high speed multiplier setting
> 23385cec5f35 usb: dwc3: gadget: refactor dwc3_repare_one_trb
> babfcd947eba usb: dwc3: gadget: fix a kernel-doc warning
> ad44cf402486 usb: dwc3: document async_callbacks field
> d9be8d5c5b03 usb: dwc3: qcom: Keep power domain on to retain controller status
> 6895ea55c385 usb: dwc3: qcom: Configure wakeup interrupts during suspend
Are these qcom commits really part of this patch ?

6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
  drivers/usb/dwc3/dwc3-qcom.c | 72 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
  1 file changed, 62 insertions(+), 10 deletions(-)

