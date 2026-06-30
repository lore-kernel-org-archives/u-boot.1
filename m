Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A0DC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 22:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3FE84B37;
	Wed,  1 Jul 2026 00:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="VWBxuZTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B3884B24; Wed,  1 Jul 2026 00:25:56 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED0A284671
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 00:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AA1B71186C8; Wed,  1 Jul 2026 00:25:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782858353;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=j/j6dhyuRgawGhwCgXZNyaNdmPx8Wvqo7TlYEoGIKxU=;
 b=VWBxuZTWnaHvQRBrPFoo0nKCSv49zz3p9F5grZM/4ibggK94uycUa4tcDERM6wlARjw3B2
 OPVuLGlBIVdmhbxfRvyVD+qICFi3d+y4oPMvf4EZnJYCo3P4xOYLPzjpbS0sd0LwdFBsV2
 2EWTK3t9bCxiTnQBdqEOp5RrSaaN3qa7VLX+aP1Ey6MV7ZVn94SSgiTGKaMLHLsLJFfz0i
 vh6lB5CLYsW9Lmw2u5gppunuKuDlE+NtkeZhZ1Pa+OS1EsQGlqLzJAAJXzlZrfYDD/0UKS
 XwObtpCq6r0NUcBnCQpVktAgVwqBtrSYgrnVC7cmqO5ne06rbLRldxPJn6YRgg==
Message-ID: <e0217633-1293-477c-97e1-1a9508c8e835@nabladev.com>
Date: Tue, 30 Jun 2026 12:04:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH v4 40/64] usb: dwc3: import from kernel v5.16
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
 <20260629084507.3254232-41-jens.wiklander@linaro.org>
Content-Language: en-US
In-Reply-To: <20260629084507.3254232-41-jens.wiklander@linaro.org>
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
> Sync Linux kernel dwc3 changes from v5.15 to v5.16.
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
> List of commits: git log --oneline v5.15..v5.16
> Commits imported:
> 6a97cee39d8f Revert "usb: dwc3: dwc3-qcom: Enable tx-fifo-resize property by default"
> 47ce45906ca9 usb: dwc3: leave default DMA for PCI devices
> 26288448120b usb: dwc3: gadget: Fix null pointer exception
> 63c4c320ccf7 usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer
> d74dc3e9f58c usb: dwc3: gadget: Ignore NoStream after End Transfer
> 250fdabec6ff usb: dwc3: core: Revise GHWPARAMS9 offset
> d1a4683747fe usb: dwc3: Align DWC3_EP_* flag macros
> 876a75cb520f usb: dwc3: gadget: Skip resizing EP's TX FIFO if already resized
> b851f7c7b8fd usb: dwc3: gadget: Change to dev_dbg() when queuing to inactive gadget/ep
> 620b74d01b9d Merge 5.15-rc5 into usb-next
> 2abc865706c9 usb: exynos: describe driver in KConfig
> ae9a6149884e Merge 5.15-rc3 into usb-next
> 8217f07a5023 usb: dwc3: gadget: Avoid starting DWC3 gadget during UDC unbind
> 7bee31883889 usb: dwc3: reference clock period configuration
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Tested-by: Alexey Charkov <alchark@flipper.net>
> ---
>   drivers/usb/dwc3/core.c   | 37 ++++++++++++++++++++++++---
>   drivers/usb/dwc3/core.h   | 27 +++++++++++++-------
>   drivers/usb/dwc3/gadget.c | 53 ++++++++++++++++++++++++++++-----------
>   3 files changed, 90 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 0104a80b185e..f4c09951b517 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -26,6 +26,7 @@
>   #include <linux/acpi.h>
>   #include <linux/pinctrl/consumer.h>
>   #include <linux/reset.h>
> +#include <linux/bitfield.h>
>   
>   #include <linux/usb/ch9.h>
>   #include <linux/usb/gadget.h>
> @@ -335,6 +336,29 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
>   	}
>   }
>   
> +/**
> + * dwc3_ref_clk_period - Reference clock period configuration
> + *		Default reference clock period depends on hardware
> + *		configuration. For systems with reference clock that differs
> + *		from the default, this will set clock period in DWC3_GUCTL
> + *		register.
> + * @dwc: Pointer to our controller context structure
> + * @ref_clk_per: reference clock period in ns
> + */
> +static void dwc3_ref_clk_period(struct dwc3 *dwc)
> +{
> +	u32 reg;
> +
> +	if (dwc->ref_clk_per == 0)
> +		return;
> +
> +	reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
> +	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
> +	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, dwc->ref_clk_per);
> +	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
> +}
> +
> +

One newline too many here.

[...]
