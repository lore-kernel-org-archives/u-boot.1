Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515C6C43602
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D59E84A92;
	Mon, 29 Jun 2026 10:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZfUe/1Fx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E6F184AA2; Mon, 29 Jun 2026 10:47:04 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C5484105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5aea1776279so2465024e87.2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722819; x=1783327619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fy43YvmxzI20Kgs34YD7mltBdnj7/CsjDtBhCJzThKs=;
 b=ZfUe/1Fxe3PuYpzaVgqGObf0QYPwH8F3sr5u7l4cidKDR5w7AHZQCWeEZ0gPqmNAaX
 Dgbly7YkthKpOr7ZBYtFKOc8cwthn9Xf6NaaCvjpk9TA6PPVQutH9tsLPrl6tPlpaEcy
 114JcpQRCGp+I9EqGJfH4IHngLF4jEOWI5tg7Gl5mJYhS66YxVAv+DlK14K4Ez2IR5BB
 D9/Xn/rFLkmcgSB5xTiHKjfq/nY9M54NqALfmb0s0PJMjAXFjT60fIG/MNz9Q2DR5o8W
 pURLPO3o8tN+AklDBqqvlXja4yRyjHtgQiv021TLq/6vLHfbxvH0J17ZcnMnCc87mMRc
 UAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722819; x=1783327619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fy43YvmxzI20Kgs34YD7mltBdnj7/CsjDtBhCJzThKs=;
 b=auOJL0+A+TFCXVZ6PjnfVSLAtHCEoNljDlyoqStf+oUFsuJvADO4+uzoq7FJSKGjyJ
 4qQZy+GxPbD4VYSdmEJ/7ozYw3Dwlv/OhTF2MK3D1TAI8wj0otaQHaXsNdcg7fs8mjgK
 oPaZVeJEm5uRatxEgNllcGpd3AfdbCVF5+YBH/NvBdjSEeURH9RRd2oKV0w/YHcu7Dyx
 MoOU4TnEH7lPOsJwPtfSs9NpO1G9uhf/9XrUHTYPKIFvRBqOO8udd+clPxlBVb1gS5xq
 bX0gIbofbgqvYnwv1x9uVoq6figPzfg1gmR1HATcpkagV6q5nt0CbMk8Gd8n6ucyAg6N
 JfCw==
X-Gm-Message-State: AOJu0YxISdnxoF6++RXji8lbfX4ElXxZHrSasMwZzsIbxP0IHg8fBB6x
 ORxm4VtMhtyKXTmNd4TI93dm32RmHVqd/NpJ3VknJszJMnDVv14YT8U79nDQ3FMgCT6NBZF4ZPY
 EYXDH/As=
X-Gm-Gg: AfdE7cnExfrMj/JrbSrKUpW81v8NWjVqhiSERQiGQ8KbiNr6htc3vol02BuGdVgxeo2
 2/fvuBUxGS4HuP1KvkstSI0+CQiNi4b+PdfmsuVd4oQkMDjsWlEwSxwb94UnbCMTvOcFyFWVyRb
 2y+Ne2bmrsjcK3dd7wzYsVcjs2TEKgyMNFt9HSQsATes509CmX0SXedsbdbJ1FNo71Ku8fQ/nMn
 XXKs/UqmhhRHNd8F27BClYAQextP3Wfp5O4f622LkEkgTBDX4qRY0t+rPPQq815KxMRBY0a6Uu6
 5DsQZjCHmPYyS/aE0DZ8SqlKVpBI3xFYtSydE65QkhPgxc3yUtli7Fbfvdq3/Crs3akL7X5xwvE
 qdqVbwBKRH5FD07I1k5C3vnsATo1AqPrIn9Mjj42P6h5OjWtRuqAuA9AF+xFJ4VrH/OWJnD99zC
 ye6r+9zPuPtNJSvYtZlP9Mi7gIqcbFIU810rZ1TP8Yb+E9TN8A6x3OabmYIxF6S5Fr2zghx+YAH
 VCoWEQ3JRLB1+QleM8F
X-Received: by 2002:a05:6512:8386:b0:5ae:a553:3318 with SMTP id
 2adb3069b0e04-5aea55333b7mr2217166e87.49.1782722819142; 
 Mon, 29 Jun 2026 01:46:59 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:46:56 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v4 35/64] usb: dwc3: import from kernel v5.11
Date: Mon, 29 Jun 2026 10:44:11 +0200
Message-ID: <20260629084507.3254232-36-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629084507.3254232-1-jens.wiklander@linaro.org>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Sync Linux kernel dwc3 changes from v5.10 to v5.11.

The following files are preserved accross the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v5.10..v5.11
Commits imported:
0e5a3c8284a3 usb: dwc3: fix clock issue during resume in OTG mode
a5c7682aaaa1 usb: dwc3: gadget: Clear wait flag on dequeue
a1383b3537a7 usb: dwc3: gadget: Restart DWC3 gadget when enabling pullup
e5f4ca3fce90 usb: dwc3: ulpi: Fix USB2.0 HS/FS/LS PHY suspend regression
fca3f1381057 usb: dwc3: ulpi: Replace CPU-based busyloop with Protocol-based one
ce722da66d3e usb: dwc3: ulpi: Use VStsDone to detect PHY regs access completion
a5ada3dfe6a2 usb: dwc3: meson-g12a: disable clk on error handling path in probe

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/dwc3/core.c   |  2 +-
 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/gadget.c | 16 +++++-----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 841daec70b6e..3101f0dcf6ae 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1758,7 +1758,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (PMSG_IS_AUTO(msg))
 			break;
 
-		ret = dwc3_core_init(dwc);
+		ret = dwc3_core_init_for_resume(dwc);
 		if (ret)
 			return ret;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 2f95f08ca511..1b241f937d8f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -285,6 +285,7 @@
 
 /* Global USB2 PHY Vendor Control Register */
 #define DWC3_GUSB2PHYACC_NEWREGREQ	BIT(25)
+#define DWC3_GUSB2PHYACC_DONE		BIT(24)
 #define DWC3_GUSB2PHYACC_BUSY		BIT(23)
 #define DWC3_GUSB2PHYACC_WRITE		BIT(22)
 #define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 78cb4db8a6e4..ee44321fee38 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1763,6 +1763,8 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			list_for_each_entry_safe(r, t, &dep->started_list, list)
 				dwc3_gadget_move_cancelled_request(r);
 
+			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
+
 			goto out;
 		}
 	}
@@ -2083,6 +2085,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 
 static void dwc3_gadget_disable_irq(struct dwc3 *dwc);
 static void __dwc3_gadget_stop(struct dwc3 *dwc);
+static int __dwc3_gadget_start(struct dwc3 *dwc);
 
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 {
@@ -2145,6 +2148,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
 						dwc->ev_buf->length;
 		}
+	} else {
+		__dwc3_gadget_start(dwc);
 	}
 
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
@@ -2319,10 +2324,6 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	}
 
 	dwc->gadget_driver	= driver;
-
-	if (pm_runtime_active(dwc->dev))
-		__dwc3_gadget_start(dwc);
-
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
@@ -2348,13 +2349,6 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-
-	if (pm_runtime_suspended(dwc->dev))
-		goto out;
-
-	__dwc3_gadget_stop(dwc);
-
-out:
 	dwc->gadget_driver	= NULL;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-- 
2.43.0

