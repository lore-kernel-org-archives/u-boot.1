Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D65CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0536984A91;
	Thu,  7 May 2026 11:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wrv4vdxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB9484A8F; Thu,  7 May 2026 11:29:45 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEFC084A8A
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5a40b2bc96dso511037e87.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146173; x=1778750973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3TJaTBkJA7ih52gQxcUdGZgTOjXXepnLNurjtqr4cw=;
 b=wrv4vdxXgBSK3XzLe3GxBavdhhXMkVuvbE0ihLYqVhHvQ8WMIImM+xh6fheu/kb3Yf
 zL5zhIOL8x85pXrd1sSpcd0yQw0FQCKK2B6hXPxWfnNIyJCK1T9O1C6ieu88vkX7eahu
 UuJsbuyFyAPqO8KksDHYeEo/jasHdGztM0WVEy6KxAQq/a0AsRTU3+yNYcCHUKt9pnto
 wu1Irip1nV2NGMBnTiP/zNHbR4LQ9PLN2uiBjDIwcPyvwACLOJM1ouy0vvPRUvVYCEwr
 qoe14PuyzH4ruUKgLV+EjxoJVdP/hwaFzUZcFJiV46CjbhA9qfTVEWc3Pvf0WGNWqJJ1
 iE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146173; x=1778750973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s3TJaTBkJA7ih52gQxcUdGZgTOjXXepnLNurjtqr4cw=;
 b=eMUv5lJ2EprL1KuQqwUhGcCGaeekc3Z8/Qt1p/uK30nwLPLEUaSJJ7bV9JVXlqnKUK
 hFyOQQF+ugMYx+BPUkyhtTwQQuR3+kZurfsEbFKvKjl9bTznLhZbNQG0PjFu9+HrJDi7
 ZAqX5Q/E6kcnhQSTh+IsuT6/ou64oe5lG3yfyVA6iq9FaNOIyWpCAQF1yWy7bKbaFJuv
 jwDwgDyYiq1MpCSWRtzGnMyO9kALHur6dZcXBmAavJEf+d8FVGtc+csiMJXqyUy4tmc2
 NgY9y4HQJiHrCRSS5Z6h/GAd18OWZhIJbF7sc/6N5TMSRcnHZZ6VtxCz5rXoWxtz/Bl+
 lmTg==
X-Gm-Message-State: AOJu0YyWB74kdbXw547fMAKnuDy4Ral9vtPtjtol86OTSMBWCgsTEzeD
 mrB0Q9zR07Fnzo7gDiv5by+uOLPxkYiASRBSf0hNF3IP8oUaysBPNaOpFWXKqh8Cf7TlV5hCar/
 3N6t//N9K/A==
X-Gm-Gg: AeBDievXXd4AIB3PCwZIrhQzMGd8eUspLUvNlb8OYuu7+UfYuHtw9OKyDR0S+RqQiAf
 e+0vs0/N/+ptvsnLj0tk1I7tT4q5fRJBPI+ZByi35n7nkd2Rs2HNzJcrqzA42QQ7ZDHwC6TKgDq
 s0NsHT7Z/7AiqwFIjVI6Ovw6Mh6+hMh92NdPLOuN1PchGv8NC9mb/C0qQV7nwRVEbee1ipznc6F
 n8RfQlSErUSYs6YaLDb1fzZsApdO5z5iMhgGLcRoey19DFO4NUmVMi2LPk/OhvSfiU2P5xZcySg
 YFTjFzrOSBWq28ffW8k2QzBKy+wPElG9psP0gexkvHyuc3rDH53uuxOeSQr4bdfqEIoiNH91z2M
 SPVp3XxLqPCtmVC5aP7L28kCVq2S20Th6V/guUsA6T2jtvDIou39Ld/Ex5++ZyL9akXTujAgRUy
 pGcnsgAA8mG9kZ0e/WxfjL/yyQh5mepVtkP/I0keeNM8e1PZr9NTKng+v+DwiNU1svsoHfv0+Vu
 cS+8JukqJ75n71GTpX9FGa/FQTpJLLQY//LqX08AnGN62SFyeWt
X-Received: by 2002:a05:6512:1149:b0:5a8:918d:5926 with SMTP id
 2adb3069b0e04-5a8918d5f41mr1740942e87.18.1778146172783; 
 Thu, 07 May 2026 02:29:32 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:31 -0700 (PDT)
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
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [RFC PATCH v2 15/64] usb: dwc3: import from kernel v4.12
Date: Thu,  7 May 2026 11:27:22 +0200
Message-ID: <20260507092843.358908-16-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.11 to v4.12.

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

List of commits: git log --oneline v4.11..v4.12
Commits imported:
018047a1dba7 usb: dwc3: keystone: check return value
d325a1de49d6 usb: dwc3: gadget: Prevent losing events in event cache
f1d6826cae30 usb: dwc3: gadget: Fix ISO transfer performance
682179592e48 usb: dwc3: pci: add Intel Cannonlake PCI IDs
8f28472a739e Merge tag 'usb-4.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
2bd804017435 Merge tag 'gpio-v4.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio
ba7756d08212 Merge tag 'usb-for-v4.12' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
9840354ff429 usb: dwc3: Add dual-role support
41ce1456e1db usb: dwc3: core: make dwc3_set_mode() work properly
b202c42cbf81 usb: dwc3: debugfs: remove unnecessary | operator
6b3261a27428 usb: dwc3: core: add current_dr_role member
d6e5a549cc4d usb: dwc3: simplify ZLP handling
4199c5f8bccd usb: dwc3: ep0: improve handling of unaligned OUT requests
d686a5ff6a2d usb: dwc3: ep0: pass dep as argument to internal functions
7d5e650a5fdb usb: dwc3: ep0: use immediate SETUP on TRB
b5c7ed5cca82 usb: dwc3: expose dwc3_trb_type_string()
90abb425d949 usb: dwc3: debugfs: return strings that match tracepoints
26c9f3e391d1 usb: dwc3: debugfs: make use of dwc3_gadget_link_string()
2df301cd3d71 usb: dwc3: debugfs: downcase OTG on 'mode' file
ff3f0789b3dc usb: dwc3: use BIT() macro where possible
aad7c2596495 usb: dwc3: trace: change format for string to cmd trace
af771d731b8e usb: dwc3: gadget: Fix starting microframe for ISOC
3a932b0f50f4 usb: dwc3: exynos: change goto labels to meaningful names
f3bcfc7e68f0 usb: dwc3: remove dwc3_gadget_init_hw_endpoints
47d3946ea220 usb: dwc3: refactor gadget endpoint count calculation
8261bd4e91e2 usb: dwc3: make macros safe to expression arguments
05428ba983e6 usb: dwc3: remove dwc3_log_msg trace class
1966b8657d05 usb: dwc3: make sure UX_EXIT_PX is cleared
e47ff590cc57 Merge 4.11-rc4 into usb-next
4a56e413b50c usb: dwc3: pci: Switch to devm_acpi_dev_add_driver_gpios()
2c93e790e825 usb: add CONFIG_USB_PCI for system have both PCI HW and non-PCI based USB HW

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c   | 109 +++++++++++-----
 drivers/usb/dwc3/core.h   | 261 ++++++++++++++++++++------------------
 drivers/usb/dwc3/debug.h  |  28 ++++
 drivers/usb/dwc3/ep0.c    | 151 ++++++++++------------
 drivers/usb/dwc3/gadget.c | 218 +++++++++++--------------------
 drivers/usb/dwc3/gadget.h |  20 +--
 6 files changed, 392 insertions(+), 395 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 369bab16a824..455d89a1cd6d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -100,7 +100,10 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 	return 0;
 }
 
-void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
+static void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
+static int dwc3_event_buffers_setup(struct dwc3 *dwc);
+
+static void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
 
@@ -110,6 +113,69 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 }
 
+static void __dwc3_set_mode(struct work_struct *work)
+{
+	struct dwc3 *dwc = work_to_dwc(work);
+	unsigned long flags;
+	int ret;
+
+	if (!dwc->desired_dr_role)
+		return;
+
+	if (dwc->desired_dr_role == dwc->current_dr_role)
+		return;
+
+	if (dwc->dr_mode != USB_DR_MODE_OTG)
+		return;
+
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_HOST:
+		dwc3_host_exit(dwc);
+		break;
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		dwc3_gadget_exit(dwc);
+		dwc3_event_buffers_cleanup(dwc);
+		break;
+	default:
+		break;
+	}
+
+	spin_lock_irqsave(&dwc->lock, flags);
+
+	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
+
+	dwc->current_dr_role = dwc->desired_dr_role;
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	switch (dwc->desired_dr_role) {
+	case DWC3_GCTL_PRTCAP_HOST:
+		ret = dwc3_host_init(dwc);
+		if (ret)
+			dev_err(dwc->dev, "failed to initialize host\n");
+		break;
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		dwc3_event_buffers_setup(dwc);
+		ret = dwc3_gadget_init(dwc);
+		if (ret)
+			dev_err(dwc->dev, "failed to initialize peripheral\n");
+		break;
+	default:
+		break;
+	}
+}
+
+void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->desired_dr_role = mode;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	queue_work(system_power_efficient_wq, &dwc->drd_work);
+}
+
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
 {
 	struct dwc3		*dwc = dep->dwc;
@@ -397,8 +463,7 @@ static void dwc3_core_num_eps(struct dwc3 *dwc)
 {
 	struct dwc3_hwparams	*parms = &dwc->hwparams;
 
-	dwc->num_in_eps = DWC3_NUM_IN_EPS(parms);
-	dwc->num_out_eps = DWC3_NUM_EPS(parms) - dwc->num_in_eps;
+	dwc->num_eps = DWC3_NUM_EPS(parms);
 }
 
 static void dwc3_cache_hwparams(struct dwc3 *dwc)
@@ -431,6 +496,12 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
+	/*
+	 * Make sure UX_EXIT_PX is cleared as that causes issues with some
+	 * PHYs. Also, this bit is not supposed to be used in normal operation.
+	 */
+	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
+
 	/*
 	 * Above 1.94a, it is recommended to set DWC3_GUSB3PIPECTL_SUSPHY
 	 * to '0' during coreConsultant configuration. So default value
@@ -714,21 +785,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		goto err4;
 	}
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
-		break;
-	case USB_DR_MODE_HOST:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
-		break;
-	case USB_DR_MODE_OTG:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
-		break;
-	default:
-		dev_warn(dwc->dev, "Unsupported mode %d\n", dwc->dr_mode);
-		break;
-	}
-
 	/*
 	 * ENDXFER polling is available on version 3.10a and later of
 	 * the DWC_usb3 controller. It is NOT available in the
@@ -846,6 +902,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
@@ -854,6 +911,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_HOST:
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
@@ -862,17 +920,11 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_OTG:
-		ret = dwc3_host_init(dwc);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize host\n");
-			return ret;
-		}
-
-		ret = dwc3_gadget_init(dwc);
+		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
+		ret = dwc3_drd_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize gadget\n");
+				dev_err(dev, "failed to initialize dual-role\n");
 			return ret;
 		}
 		break;
@@ -894,8 +946,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 		dwc3_host_exit(dwc);
 		break;
 	case USB_DR_MODE_OTG:
-		dwc3_host_exit(dwc);
-		dwc3_gadget_exit(dwc);
+		dwc3_drd_exit(dwc);
 		break;
 	default:
 		/* do nothing */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 2b9e4ca3c932..981c77f5628e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -23,10 +23,12 @@
 #include <linux/spinlock.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
+#include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/debugfs.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -39,9 +41,8 @@
 
 /* Global constants */
 #define DWC3_PULL_UP_TIMEOUT	500	/* ms */
-#define DWC3_ZLP_BUF_SIZE	1024	/* size of a superspeed bulk */
 #define DWC3_BOUNCE_SIZE	1024	/* size of a superspeed bulk */
-#define DWC3_EP0_BOUNCE_SIZE	512
+#define DWC3_EP0_SETUP_SIZE	512
 #define DWC3_ENDPOINTS_NUM	32
 #define DWC3_XHCI_RESOURCES_NUM	2
 
@@ -66,7 +67,7 @@
 #define DWC3_DEVICE_EVENT_OVERFLOW		11
 
 #define DWC3_GEVNTCOUNT_MASK	0xfffc
-#define DWC3_GEVNTCOUNT_EHB	(1 << 31)
+#define DWC3_GEVNTCOUNT_EHB	BIT(31)
 #define DWC3_GSNPSID_MASK	0xffff0000
 #define DWC3_GSNPSREV_MASK	0xffff
 
@@ -116,20 +117,20 @@
 #define DWC3_VER_NUMBER		0xc1a0
 #define DWC3_VER_TYPE		0xc1a4
 
-#define DWC3_GUSB2PHYCFG(n)	(0xc200 + (n * 0x04))
-#define DWC3_GUSB2I2CCTL(n)	(0xc240 + (n * 0x04))
+#define DWC3_GUSB2PHYCFG(n)	(0xc200 + ((n) * 0x04))
+#define DWC3_GUSB2I2CCTL(n)	(0xc240 + ((n) * 0x04))
 
-#define DWC3_GUSB2PHYACC(n)	(0xc280 + (n * 0x04))
+#define DWC3_GUSB2PHYACC(n)	(0xc280 + ((n) * 0x04))
 
-#define DWC3_GUSB3PIPECTL(n)	(0xc2c0 + (n * 0x04))
+#define DWC3_GUSB3PIPECTL(n)	(0xc2c0 + ((n) * 0x04))
 
-#define DWC3_GTXFIFOSIZ(n)	(0xc300 + (n * 0x04))
-#define DWC3_GRXFIFOSIZ(n)	(0xc380 + (n * 0x04))
+#define DWC3_GTXFIFOSIZ(n)	(0xc300 + ((n) * 0x04))
+#define DWC3_GRXFIFOSIZ(n)	(0xc380 + ((n) * 0x04))
 
-#define DWC3_GEVNTADRLO(n)	(0xc400 + (n * 0x10))
-#define DWC3_GEVNTADRHI(n)	(0xc404 + (n * 0x10))
-#define DWC3_GEVNTSIZ(n)	(0xc408 + (n * 0x10))
-#define DWC3_GEVNTCOUNT(n)	(0xc40c + (n * 0x10))
+#define DWC3_GEVNTADRLO(n)	(0xc400 + ((n) * 0x10))
+#define DWC3_GEVNTADRHI(n)	(0xc404 + ((n) * 0x10))
+#define DWC3_GEVNTSIZ(n)	(0xc408 + ((n) * 0x10))
+#define DWC3_GEVNTCOUNT(n)	(0xc40c + ((n) * 0x10))
 
 #define DWC3_GHWPARAMS8		0xc600
 #define DWC3_GFLADJ		0xc630
@@ -143,13 +144,13 @@
 #define DWC3_DGCMD		0xc714
 #define DWC3_DALEPENA		0xc720
 
-#define DWC3_DEP_BASE(n)	(0xc800 + (n * 0x10))
+#define DWC3_DEP_BASE(n)	(0xc800 + ((n) * 0x10))
 #define DWC3_DEPCMDPAR2		0x00
 #define DWC3_DEPCMDPAR1		0x04
 #define DWC3_DEPCMDPAR0		0x08
 #define DWC3_DEPCMD		0x0c
 
-#define DWC3_DEV_IMOD(n)	(0xca00 + (n * 0x4))
+#define DWC3_DEV_IMOD(n)	(0xca00 + ((n) * 0x4))
 
 /* OTG Registers */
 #define DWC3_OCFG		0xcc00
@@ -176,11 +177,11 @@
 /* Global RX Threshold Configuration Register */
 #define DWC3_GRXTHRCFG_MAXRXBURSTSIZE(n) (((n) & 0x1f) << 19)
 #define DWC3_GRXTHRCFG_RXPKTCNT(n) (((n) & 0xf) << 24)
-#define DWC3_GRXTHRCFG_PKTCNTSEL (1 << 29)
+#define DWC3_GRXTHRCFG_PKTCNTSEL BIT(29)
 
 /* Global Configuration Register */
 #define DWC3_GCTL_PWRDNSCALE(n)	((n) << 19)
-#define DWC3_GCTL_U2RSTECN	(1 << 16)
+#define DWC3_GCTL_U2RSTECN	BIT(16)
 #define DWC3_GCTL_RAMCLKSEL(x)	(((x) & DWC3_GCTL_CLK_MASK) << 6)
 #define DWC3_GCTL_CLK_BUS	(0)
 #define DWC3_GCTL_CLK_PIPE	(1)
@@ -193,24 +194,24 @@
 #define DWC3_GCTL_PRTCAP_DEVICE	2
 #define DWC3_GCTL_PRTCAP_OTG	3
 
-#define DWC3_GCTL_CORESOFTRESET		(1 << 11)
-#define DWC3_GCTL_SOFITPSYNC		(1 << 10)
+#define DWC3_GCTL_CORESOFTRESET		BIT(11)
+#define DWC3_GCTL_SOFITPSYNC		BIT(10)
 #define DWC3_GCTL_SCALEDOWN(n)		((n) << 4)
 #define DWC3_GCTL_SCALEDOWN_MASK	DWC3_GCTL_SCALEDOWN(3)
-#define DWC3_GCTL_DISSCRAMBLE		(1 << 3)
-#define DWC3_GCTL_U2EXIT_LFPS		(1 << 2)
-#define DWC3_GCTL_GBLHIBERNATIONEN	(1 << 1)
-#define DWC3_GCTL_DSBLCLKGTNG		(1 << 0)
+#define DWC3_GCTL_DISSCRAMBLE		BIT(3)
+#define DWC3_GCTL_U2EXIT_LFPS		BIT(2)
+#define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
+#define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
 /* Global User Control 1 Register */
-#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	(1 << 24)
+#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
 
 /* Global USB2 PHY Configuration Register */
-#define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
-#define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	(1 << 30)
-#define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
-#define DWC3_GUSB2PHYCFG_ULPI_UTMI	(1 << 4)
-#define DWC3_GUSB2PHYCFG_ENBLSLPM	(1 << 8)
+#define DWC3_GUSB2PHYCFG_PHYSOFTRST	BIT(31)
+#define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	BIT(30)
+#define DWC3_GUSB2PHYCFG_SUSPHY		BIT(6)
+#define DWC3_GUSB2PHYCFG_ULPI_UTMI	BIT(4)
+#define DWC3_GUSB2PHYCFG_ENBLSLPM	BIT(8)
 #define DWC3_GUSB2PHYCFG_PHYIF(n)	(n << 3)
 #define DWC3_GUSB2PHYCFG_PHYIF_MASK	DWC3_GUSB2PHYCFG_PHYIF(1)
 #define DWC3_GUSB2PHYCFG_USBTRDTIM(n)	(n << 10)
@@ -221,25 +222,26 @@
 #define UTMI_PHYIF_8_BIT		0
 
 /* Global USB2 PHY Vendor Control Register */
-#define DWC3_GUSB2PHYACC_NEWREGREQ	(1 << 25)
-#define DWC3_GUSB2PHYACC_BUSY		(1 << 23)
-#define DWC3_GUSB2PHYACC_WRITE		(1 << 22)
+#define DWC3_GUSB2PHYACC_NEWREGREQ	BIT(25)
+#define DWC3_GUSB2PHYACC_BUSY		BIT(23)
+#define DWC3_GUSB2PHYACC_WRITE		BIT(22)
 #define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
 #define DWC3_GUSB2PHYACC_EXTEND_ADDR(n)	(n << 8)
 #define DWC3_GUSB2PHYACC_DATA(n)	(n & 0xff)
 
 /* Global USB3 PIPE Control Register */
-#define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
-#define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
-#define DWC3_GUSB3PIPECTL_DISRXDETINP3	(1 << 28)
-#define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
+#define DWC3_GUSB3PIPECTL_PHYSOFTRST	BIT(31)
+#define DWC3_GUSB3PIPECTL_U2SSINP3OK	BIT(29)
+#define DWC3_GUSB3PIPECTL_DISRXDETINP3	BIT(28)
+#define DWC3_GUSB3PIPECTL_UX_EXIT_PX	BIT(27)
+#define DWC3_GUSB3PIPECTL_REQP1P2P3	BIT(24)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_EN	DWC3_GUSB3PIPECTL_DEP1P2P3(1)
-#define DWC3_GUSB3PIPECTL_DEPOCHANGE	(1 << 18)
-#define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
-#define DWC3_GUSB3PIPECTL_LFPSFILT	(1 << 9)
-#define DWC3_GUSB3PIPECTL_RX_DETOPOLL	(1 << 8)
+#define DWC3_GUSB3PIPECTL_DEPOCHANGE	BIT(18)
+#define DWC3_GUSB3PIPECTL_SUSPHY	BIT(17)
+#define DWC3_GUSB3PIPECTL_LFPSFILT	BIT(9)
+#define DWC3_GUSB3PIPECTL_RX_DETOPOLL	BIT(8)
 #define DWC3_GUSB3PIPECTL_TX_DEEPH_MASK	DWC3_GUSB3PIPECTL_TX_DEEPH(3)
 #define DWC3_GUSB3PIPECTL_TX_DEEPH(n)	((n) << 1)
 
@@ -248,7 +250,7 @@
 #define DWC3_GTXFIFOSIZ_TXFSTADDR(n)	((n) & 0xffff0000)
 
 /* Global Event Size Registers */
-#define DWC3_GEVNTSIZ_INTMASK		(1 << 31)
+#define DWC3_GEVNTSIZ_INTMASK		BIT(31)
 #define DWC3_GEVNTSIZ_SIZE(n)		((n) & 0xffff)
 
 /* Global HWPARAMS0 Register */
@@ -289,18 +291,18 @@
 #define DWC3_MAX_HIBER_SCRATCHBUFS		15
 
 /* Global HWPARAMS6 Register */
-#define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
+#define DWC3_GHWPARAMS6_EN_FPGA			BIT(7)
 
 /* Global HWPARAMS7 Register */
 #define DWC3_GHWPARAMS7_RAM1_DEPTH(n)	((n) & 0xffff)
 #define DWC3_GHWPARAMS7_RAM2_DEPTH(n)	(((n) >> 16) & 0xffff)
 
 /* Global Frame Length Adjustment Register */
-#define DWC3_GFLADJ_30MHZ_SDBND_SEL		(1 << 7)
+#define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 
 /* Global User Control Register 2 */
-#define DWC3_GUCTL2_RST_ACTBITLATER		(1 << 14)
+#define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
 
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
@@ -310,23 +312,23 @@
 #define DWC3_DCFG_SUPERSPEED_PLUS (5 << 0)  /* DWC_usb31 only */
 #define DWC3_DCFG_SUPERSPEED	(4 << 0)
 #define DWC3_DCFG_HIGHSPEED	(0 << 0)
-#define DWC3_DCFG_FULLSPEED	(1 << 0)
+#define DWC3_DCFG_FULLSPEED	BIT(0)
 #define DWC3_DCFG_LOWSPEED	(2 << 0)
 
 #define DWC3_DCFG_NUMP_SHIFT	17
 #define DWC3_DCFG_NUMP(n)	(((n) >> DWC3_DCFG_NUMP_SHIFT) & 0x1f)
 #define DWC3_DCFG_NUMP_MASK	(0x1f << DWC3_DCFG_NUMP_SHIFT)
-#define DWC3_DCFG_LPM_CAP	(1 << 22)
+#define DWC3_DCFG_LPM_CAP	BIT(22)
 
 /* Device Control Register */
-#define DWC3_DCTL_RUN_STOP	(1 << 31)
-#define DWC3_DCTL_CSFTRST	(1 << 30)
-#define DWC3_DCTL_LSFTRST	(1 << 29)
+#define DWC3_DCTL_RUN_STOP	BIT(31)
+#define DWC3_DCTL_CSFTRST	BIT(30)
+#define DWC3_DCTL_LSFTRST	BIT(29)
 
 #define DWC3_DCTL_HIRD_THRES_MASK	(0x1f << 24)
 #define DWC3_DCTL_HIRD_THRES(n)	((n) << 24)
 
-#define DWC3_DCTL_APPL1RES	(1 << 23)
+#define DWC3_DCTL_APPL1RES	BIT(23)
 
 /* These apply for core versions 1.87a and earlier */
 #define DWC3_DCTL_TRGTULST_MASK		(0x0f << 17)
@@ -341,15 +343,15 @@
 #define DWC3_DCTL_LPM_ERRATA_MASK	DWC3_DCTL_LPM_ERRATA(0xf)
 #define DWC3_DCTL_LPM_ERRATA(n)		((n) << 20)
 
-#define DWC3_DCTL_KEEP_CONNECT		(1 << 19)
-#define DWC3_DCTL_L1_HIBER_EN		(1 << 18)
-#define DWC3_DCTL_CRS			(1 << 17)
-#define DWC3_DCTL_CSS			(1 << 16)
+#define DWC3_DCTL_KEEP_CONNECT		BIT(19)
+#define DWC3_DCTL_L1_HIBER_EN		BIT(18)
+#define DWC3_DCTL_CRS			BIT(17)
+#define DWC3_DCTL_CSS			BIT(16)
 
-#define DWC3_DCTL_INITU2ENA		(1 << 12)
-#define DWC3_DCTL_ACCEPTU2ENA		(1 << 11)
-#define DWC3_DCTL_INITU1ENA		(1 << 10)
-#define DWC3_DCTL_ACCEPTU1ENA		(1 << 9)
+#define DWC3_DCTL_INITU2ENA		BIT(12)
+#define DWC3_DCTL_ACCEPTU2ENA		BIT(11)
+#define DWC3_DCTL_INITU1ENA		BIT(10)
+#define DWC3_DCTL_ACCEPTU1ENA		BIT(9)
 #define DWC3_DCTL_TSTCTRL_MASK		(0xf << 1)
 
 #define DWC3_DCTL_ULSTCHNGREQ_MASK	(0x0f << 5)
@@ -364,36 +366,36 @@
 #define DWC3_DCTL_ULSTCHNG_LOOPBACK	(DWC3_DCTL_ULSTCHNGREQ(11))
 
 /* Device Event Enable Register */
-#define DWC3_DEVTEN_VNDRDEVTSTRCVEDEN	(1 << 12)
-#define DWC3_DEVTEN_EVNTOVERFLOWEN	(1 << 11)
-#define DWC3_DEVTEN_CMDCMPLTEN		(1 << 10)
-#define DWC3_DEVTEN_ERRTICERREN		(1 << 9)
-#define DWC3_DEVTEN_SOFEN		(1 << 7)
-#define DWC3_DEVTEN_EOPFEN		(1 << 6)
-#define DWC3_DEVTEN_HIBERNATIONREQEVTEN	(1 << 5)
-#define DWC3_DEVTEN_WKUPEVTEN		(1 << 4)
-#define DWC3_DEVTEN_ULSTCNGEN		(1 << 3)
-#define DWC3_DEVTEN_CONNECTDONEEN	(1 << 2)
-#define DWC3_DEVTEN_USBRSTEN		(1 << 1)
-#define DWC3_DEVTEN_DISCONNEVTEN	(1 << 0)
+#define DWC3_DEVTEN_VNDRDEVTSTRCVEDEN	BIT(12)
+#define DWC3_DEVTEN_EVNTOVERFLOWEN	BIT(11)
+#define DWC3_DEVTEN_CMDCMPLTEN		BIT(10)
+#define DWC3_DEVTEN_ERRTICERREN		BIT(9)
+#define DWC3_DEVTEN_SOFEN		BIT(7)
+#define DWC3_DEVTEN_EOPFEN		BIT(6)
+#define DWC3_DEVTEN_HIBERNATIONREQEVTEN	BIT(5)
+#define DWC3_DEVTEN_WKUPEVTEN		BIT(4)
+#define DWC3_DEVTEN_ULSTCNGEN		BIT(3)
+#define DWC3_DEVTEN_CONNECTDONEEN	BIT(2)
+#define DWC3_DEVTEN_USBRSTEN		BIT(1)
+#define DWC3_DEVTEN_DISCONNEVTEN	BIT(0)
 
 /* Device Status Register */
-#define DWC3_DSTS_DCNRD			(1 << 29)
+#define DWC3_DSTS_DCNRD			BIT(29)
 
 /* This applies for core versions 1.87a and earlier */
-#define DWC3_DSTS_PWRUPREQ		(1 << 24)
+#define DWC3_DSTS_PWRUPREQ		BIT(24)
 
 /* These apply for core versions 1.94a and later */
-#define DWC3_DSTS_RSS			(1 << 25)
-#define DWC3_DSTS_SSS			(1 << 24)
+#define DWC3_DSTS_RSS			BIT(25)
+#define DWC3_DSTS_SSS			BIT(24)
 
-#define DWC3_DSTS_COREIDLE		(1 << 23)
-#define DWC3_DSTS_DEVCTRLHLT		(1 << 22)
+#define DWC3_DSTS_COREIDLE		BIT(23)
+#define DWC3_DSTS_DEVCTRLHLT		BIT(22)
 
 #define DWC3_DSTS_USBLNKST_MASK		(0x0f << 18)
 #define DWC3_DSTS_USBLNKST(n)		(((n) & DWC3_DSTS_USBLNKST_MASK) >> 18)
 
-#define DWC3_DSTS_RXFIFOEMPTY		(1 << 17)
+#define DWC3_DSTS_RXFIFOEMPTY		BIT(17)
 
 #define DWC3_DSTS_SOFFN_MASK		(0x3fff << 3)
 #define DWC3_DSTS_SOFFN(n)		(((n) & DWC3_DSTS_SOFFN_MASK) >> 3)
@@ -403,7 +405,7 @@
 #define DWC3_DSTS_SUPERSPEED_PLUS	(5 << 0) /* DWC_usb31 only */
 #define DWC3_DSTS_SUPERSPEED		(4 << 0)
 #define DWC3_DSTS_HIGHSPEED		(0 << 0)
-#define DWC3_DSTS_FULLSPEED		(1 << 0)
+#define DWC3_DSTS_FULLSPEED		BIT(0)
 #define DWC3_DSTS_LOWSPEED		(2 << 0)
 
 /* Device Generic Command Register */
@@ -421,26 +423,26 @@
 #define DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK	0x10
 
 #define DWC3_DGCMD_STATUS(n)		(((n) >> 12) & 0x0F)
-#define DWC3_DGCMD_CMDACT		(1 << 10)
-#define DWC3_DGCMD_CMDIOC		(1 << 8)
+#define DWC3_DGCMD_CMDACT		BIT(10)
+#define DWC3_DGCMD_CMDIOC		BIT(8)
 
 /* Device Generic Command Parameter Register */
-#define DWC3_DGCMDPAR_FORCE_LINKPM_ACCEPT	(1 << 0)
+#define DWC3_DGCMDPAR_FORCE_LINKPM_ACCEPT	BIT(0)
 #define DWC3_DGCMDPAR_FIFO_NUM(n)		((n) << 0)
 #define DWC3_DGCMDPAR_RX_FIFO			(0 << 5)
-#define DWC3_DGCMDPAR_TX_FIFO			(1 << 5)
+#define DWC3_DGCMDPAR_TX_FIFO			BIT(5)
 #define DWC3_DGCMDPAR_LOOPBACK_DIS		(0 << 0)
-#define DWC3_DGCMDPAR_LOOPBACK_ENA		(1 << 0)
+#define DWC3_DGCMDPAR_LOOPBACK_ENA		BIT(0)
 
 /* Device Endpoint Command Register */
 #define DWC3_DEPCMD_PARAM_SHIFT		16
 #define DWC3_DEPCMD_PARAM(x)		((x) << DWC3_DEPCMD_PARAM_SHIFT)
 #define DWC3_DEPCMD_GET_RSC_IDX(x)	(((x) >> DWC3_DEPCMD_PARAM_SHIFT) & 0x7f)
 #define DWC3_DEPCMD_STATUS(x)		(((x) >> 12) & 0x0F)
-#define DWC3_DEPCMD_HIPRI_FORCERM	(1 << 11)
-#define DWC3_DEPCMD_CLEARPENDIN		(1 << 11)
-#define DWC3_DEPCMD_CMDACT		(1 << 10)
-#define DWC3_DEPCMD_CMDIOC		(1 << 8)
+#define DWC3_DEPCMD_HIPRI_FORCERM	BIT(11)
+#define DWC3_DEPCMD_CLEARPENDIN		BIT(11)
+#define DWC3_DEPCMD_CMDACT		BIT(10)
+#define DWC3_DEPCMD_CMDIOC		BIT(8)
 
 #define DWC3_DEPCMD_DEPSTARTCFG		(0x09 << 0)
 #define DWC3_DEPCMD_ENDTRANSFER		(0x08 << 0)
@@ -458,7 +460,7 @@
 #define DWC3_DEPCMD_CMD(x)		((x) & 0xf)
 
 /* The EP number goes 0..31 so ep0 is always out and ep1 is always in */
-#define DWC3_DALEPENA_EP(n)		(1 << n)
+#define DWC3_DALEPENA_EP(n)		BIT(n)
 
 #define DWC3_DEPCMD_TYPE_CONTROL	0
 #define DWC3_DEPCMD_TYPE_ISOC		1
@@ -500,8 +502,8 @@ struct dwc3_event_buffer {
 	struct dwc3		*dwc;
 };
 
-#define DWC3_EP_FLAG_STALLED	(1 << 0)
-#define DWC3_EP_FLAG_WEDGED	(1 << 1)
+#define DWC3_EP_FLAG_STALLED	BIT(0)
+#define DWC3_EP_FLAG_WEDGED	BIT(1)
 
 #define DWC3_EP_DIRECTION_TX	true
 #define DWC3_EP_DIRECTION_RX	false
@@ -550,17 +552,17 @@ struct dwc3_ep {
 
 	u32			saved_state;
 	unsigned		flags;
-#define DWC3_EP_ENABLED		(1 << 0)
-#define DWC3_EP_STALL		(1 << 1)
-#define DWC3_EP_WEDGE		(1 << 2)
-#define DWC3_EP_BUSY		(1 << 4)
-#define DWC3_EP_PENDING_REQUEST	(1 << 5)
-#define DWC3_EP_MISSED_ISOC	(1 << 6)
-#define DWC3_EP_END_TRANSFER_PENDING	(1 << 7)
-#define DWC3_EP_TRANSFER_STARTED (1 << 8)
+#define DWC3_EP_ENABLED		BIT(0)
+#define DWC3_EP_STALL		BIT(1)
+#define DWC3_EP_WEDGE		BIT(2)
+#define DWC3_EP_BUSY		BIT(4)
+#define DWC3_EP_PENDING_REQUEST	BIT(5)
+#define DWC3_EP_MISSED_ISOC	BIT(6)
+#define DWC3_EP_END_TRANSFER_PENDING	BIT(7)
+#define DWC3_EP_TRANSFER_STARTED BIT(8)
 
 	/* This last one is specific to EP0 */
-#define DWC3_EP0_DIR_IN		(1 << 31)
+#define DWC3_EP0_DIR_IN		BIT(31)
 
 	/*
 	 * IMPORTANT: we *know* we have 256 TRBs in our @trb_pool, so we will
@@ -638,13 +640,13 @@ enum dwc3_link_state {
 #define DWC3_TRB_STS_XFER_IN_PROG	4
 
 /* TRB Control */
-#define DWC3_TRB_CTRL_HWO		(1 << 0)
-#define DWC3_TRB_CTRL_LST		(1 << 1)
-#define DWC3_TRB_CTRL_CHN		(1 << 2)
-#define DWC3_TRB_CTRL_CSP		(1 << 3)
+#define DWC3_TRB_CTRL_HWO		BIT(0)
+#define DWC3_TRB_CTRL_LST		BIT(1)
+#define DWC3_TRB_CTRL_CHN		BIT(2)
+#define DWC3_TRB_CTRL_CSP		BIT(3)
 #define DWC3_TRB_CTRL_TRBCTL(n)		(((n) & 0x3f) << 4)
-#define DWC3_TRB_CTRL_ISP_IMI		(1 << 10)
-#define DWC3_TRB_CTRL_IOC		(1 << 11)
+#define DWC3_TRB_CTRL_ISP_IMI		BIT(10)
+#define DWC3_TRB_CTRL_IOC		BIT(11)
 #define DWC3_TRB_CTRL_SID_SOFN(n)	(((n) & 0xffff) << 14)
 
 #define DWC3_TRBCTL_TYPE(n)		((n) & (0x3f << 4))
@@ -746,6 +748,7 @@ struct dwc3_request {
 	unsigned		direction:1;
 	unsigned		mapped:1;
 	unsigned		started:1;
+	unsigned		zero:1;
 };
 
 /*
@@ -758,15 +761,11 @@ struct dwc3_scratchpad_array {
 
 /**
  * struct dwc3 - representation of our controller
- * @ctrl_req: usb control request which is used for ep0
+ * @drd_work - workqueue used for role swapping
  * @ep0_trb: trb which is used for the ctrl_req
- * @ep0_bounce: bounce buffer for ep0
- * @zlp_buf: used when request->zero is set
  * @setup_buf: used while precessing STD USB requests
- * @ctrl_req_addr: dma address of ctrl_req
  * @ep0_trb: dma address of ep0_trb
  * @ep0_usb_req: dummy req used while handling STD USB requests
- * @ep0_bounce_addr: dma address of ep0_bounce
  * @scratch_addr: dma address of scratchbuf
  * @ep0_in_setup: one control transfer is completed and enter setup phase
  * @lock: for synchronizing
@@ -784,6 +783,10 @@ struct dwc3_scratchpad_array {
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
  * @revision: revision register contents
  * @dr_mode: requested mode of operation
+ * @current_dr_role: current role of operation when in dual-role mode
+ * @desired_dr_role: desired role of operation when in dual-role mode
+ * @edev: extcon handle
+ * @edev_nb: extcon notifier
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
@@ -799,8 +802,7 @@ struct dwc3_scratchpad_array {
  * @u2pel: parameter from Set SEL request.
  * @u1sel: parameter from Set SEL request.
  * @u1pel: parameter from Set SEL request.
- * @num_out_eps: number of out endpoints
- * @num_in_eps: number of in endpoints
+ * @num_eps: number of endpoints
  * @ep0_next_event: hold the next expected event
  * @ep0state: state of endpoint zero
  * @link_state: link state
@@ -858,17 +860,13 @@ struct dwc3_scratchpad_array {
  *                 increments or 0 to disable.
  */
 struct dwc3 {
-	struct usb_ctrlrequest	*ctrl_req;
+	struct work_struct	drd_work;
 	struct dwc3_trb		*ep0_trb;
 	void			*bounce;
-	void			*ep0_bounce;
-	void			*zlp_buf;
 	void			*scratchbuf;
 	u8			*setup_buf;
-	dma_addr_t		ctrl_req_addr;
 	dma_addr_t		ep0_trb_addr;
 	dma_addr_t		bounce_addr;
-	dma_addr_t		ep0_bounce_addr;
 	dma_addr_t		scratch_addr;
 	struct dwc3_request	ep0_usb_req;
 	struct completion	ep0_in_setup;
@@ -900,6 +898,10 @@ struct dwc3 {
 	size_t			regs_size;
 
 	enum usb_dr_mode	dr_mode;
+	u32			current_dr_role;
+	u32			desired_dr_role;
+	struct extcon_dev	*edev;
+	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
 
 	u32			fladj;
@@ -960,8 +962,7 @@ struct dwc3 {
 
 	u8			speed;
 
-	u8			num_out_eps;
-	u8			num_in_eps;
+	u8			num_eps;
 
 	struct dwc3_hwparams	hwparams;
 	struct dentry		*root;
@@ -1010,7 +1011,7 @@ struct dwc3 {
 	u16			imod_interval;
 };
 
-/* -------------------------------------------------------------------------- */
+#define work_to_dwc(w)		(container_of((w), struct dwc3, drd_work))
 
 /* -------------------------------------------------------------------------- */
 
@@ -1054,13 +1055,13 @@ struct dwc3_event_depevt {
 	u32	status:4;
 
 /* Within XferNotReady */
-#define DEPEVT_STATUS_TRANSFER_ACTIVE	(1 << 3)
+#define DEPEVT_STATUS_TRANSFER_ACTIVE	BIT(3)
 
 /* Within XferComplete */
-#define DEPEVT_STATUS_BUSERR	(1 << 0)
-#define DEPEVT_STATUS_SHORT	(1 << 1)
-#define DEPEVT_STATUS_IOC	(1 << 2)
-#define DEPEVT_STATUS_LST	(1 << 3)
+#define DEPEVT_STATUS_BUSERR	BIT(0)
+#define DEPEVT_STATUS_SHORT	BIT(1)
+#define DEPEVT_STATUS_IOC	BIT(2)
+#define DEPEVT_STATUS_LST	BIT(3)
 
 /* Stream event only */
 #define DEPEVT_STREAMEVT_FOUND		1
@@ -1221,6 +1222,16 @@ static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 { return 0; }
 #endif
 
+#if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
+int dwc3_drd_init(struct dwc3 *dwc);
+void dwc3_drd_exit(struct dwc3 *dwc);
+#else
+static inline int dwc3_drd_init(struct dwc3 *dwc)
+{ return 0; }
+static inline void dwc3_drd_exit(struct dwc3 *dwc)
+{ }
+#endif
+
 /* power management interface */
 #if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
 int dwc3_gadget_suspend(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index eeed4ffd8131..cb2d8d3f7f3d 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -124,6 +124,34 @@ dwc3_gadget_link_string(enum dwc3_link_state link_state)
 	}
 }
 
+/**
+ * dwc3_trb_type_string - returns TRB type as a string
+ * @type: the type of the TRB
+ */
+static inline const char *dwc3_trb_type_string(unsigned int type)
+{
+	switch (type) {
+	case DWC3_TRBCTL_NORMAL:
+		return "normal";
+	case DWC3_TRBCTL_CONTROL_SETUP:
+		return "setup";
+	case DWC3_TRBCTL_CONTROL_STATUS2:
+		return "status2";
+	case DWC3_TRBCTL_CONTROL_STATUS3:
+		return "status3";
+	case DWC3_TRBCTL_CONTROL_DATA:
+		return "data";
+	case DWC3_TRBCTL_ISOCHRONOUS_FIRST:
+		return "isoc-first";
+	case DWC3_TRBCTL_ISOCHRONOUS:
+		return "isoc";
+	case DWC3_TRBCTL_LINK_TRB:
+		return "link";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 static inline const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
 {
 	switch (state) {
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index e689cede9b0e..a78c78e7a8c3 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -39,14 +39,13 @@ static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep);
 static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		struct dwc3_ep *dep, struct dwc3_request *req);
 
-static void dwc3_ep0_prepare_one_trb(struct dwc3 *dwc, u8 epnum,
+static void dwc3_ep0_prepare_one_trb(struct dwc3_ep *dep,
 		dma_addr_t buf_dma, u32 len, u32 type, bool chain)
 {
 	struct dwc3_trb			*trb;
-	struct dwc3_ep			*dep;
-
-	dep = dwc->eps[epnum];
+	struct dwc3			*dwc;
 
+	dwc = dep->dwc;
 	trb = &dwc->ep0_trb[dep->trb_enqueue];
 
 	if (chain)
@@ -69,16 +68,17 @@ static void dwc3_ep0_prepare_one_trb(struct dwc3 *dwc, u8 epnum,
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum)
+static int dwc3_ep0_start_trans(struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
-	struct dwc3_ep			*dep;
+	struct dwc3			*dwc;
 	int				ret;
 
-	dep = dwc->eps[epnum];
 	if (dep->flags & DWC3_EP_BUSY)
 		return 0;
 
+	dwc = dep->dwc;
+
 	memset(&params, 0, sizeof(params));
 	params.param0 = upper_32_bits(dwc->ep0_trb_addr);
 	params.param1 = lower_32_bits(dwc->ep0_trb_addr);
@@ -279,13 +279,15 @@ int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 
 void dwc3_ep0_out_start(struct dwc3 *dwc)
 {
+	struct dwc3_ep			*dep;
 	int				ret;
 
 	complete(&dwc->ep0_in_setup);
 
-	dwc3_ep0_prepare_one_trb(dwc, 0, dwc->ctrl_req_addr, 8,
+	dep = dwc->eps[0];
+	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
 			DWC3_TRBCTL_CONTROL_SETUP, false);
-	ret = dwc3_ep0_start_trans(dwc, 0);
+	ret = dwc3_ep0_start_trans(dep);
 	WARN_ON(ret < 0);
 }
 
@@ -794,7 +796,7 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
-	struct usb_ctrlrequest *ctrl = dwc->ctrl_req;
+	struct usb_ctrlrequest *ctrl = (void *) dwc->ep0_trb;
 	int ret = -EINVAL;
 	u32 len;
 
@@ -834,7 +836,6 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
-	unsigned		transfer_size = 0;
 	unsigned		maxp;
 	unsigned		remaining_ur_length;
 	void			*buf;
@@ -847,9 +848,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	ep0 = dwc->eps[0];
 
 	dwc->ep0_next_event = DWC3_EP0_NRDY_STATUS;
-
 	trb = dwc->ep0_trb;
-
 	trace_dwc3_complete_trb(ep0, trb);
 
 	r = next_request(&ep0->pending_list);
@@ -870,58 +869,23 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	remaining_ur_length = ur->length;
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
-
 	maxp = ep0->endpoint.maxpacket;
-
-	if (dwc->ep0_bounced) {
-		/*
-		 * Handle the first TRB before handling the bounce buffer if
-		 * the request length is greater than the bounce buffer size
-		 */
-		if (ur->length > DWC3_EP0_BOUNCE_SIZE) {
-			transfer_size = ALIGN(ur->length - maxp, maxp);
-			transferred = transfer_size - length;
-			buf = (u8 *)buf + transferred;
-			ur->actual += transferred;
-			remaining_ur_length -= transferred;
-
-			trb++;
-			length = trb->size & DWC3_TRB_SIZE_MASK;
-
-			ep0->trb_enqueue = 0;
-		}
-
-		transfer_size = roundup((ur->length - transfer_size),
-					maxp);
-
-		transferred = min_t(u32, remaining_ur_length,
-				    transfer_size - length);
-		memcpy(buf, dwc->ep0_bounce, transferred);
-	} else {
-		transferred = ur->length - length;
-	}
-
+	transferred = ur->length - length;
 	ur->actual += transferred;
 
-	if ((epnum & 1) && ur->actual < ur->length) {
-		/* for some reason we did not get everything out */
+	if ((IS_ALIGNED(ur->length, ep0->endpoint.maxpacket) &&
+	     ur->length && ur->zero) || dwc->ep0_bounced) {
+		trb++;
+		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+		trace_dwc3_complete_trb(ep0, trb);
+		ep0->trb_enqueue = 0;
+		dwc->ep0_bounced = false;
+	}
 
+	if ((epnum & 1) && ur->actual < ur->length)
 		dwc3_ep0_stall_and_restart(dwc);
-	} else {
+	else
 		dwc3_gadget_giveback(ep0, r, 0);
-
-		if (IS_ALIGNED(ur->length, ep0->endpoint.maxpacket) &&
-				ur->length && ur->zero) {
-			int ret;
-
-			dwc->ep0_next_event = DWC3_EP0_COMPLETE;
-
-			dwc3_ep0_prepare_one_trb(dwc, epnum, dwc->ctrl_req_addr,
-					0, DWC3_TRBCTL_CONTROL_DATA, false);
-			ret = dwc3_ep0_start_trans(dwc, epnum);
-			WARN_ON(ret < 0);
-		}
-	}
 }
 
 static void dwc3_ep0_complete_status(struct dwc3 *dwc,
@@ -997,14 +961,13 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 	req->direction = !!dep->number;
 
 	if (req->request.length == 0) {
-		dwc3_ep0_prepare_one_trb(dwc, dep->number,
-				dwc->ctrl_req_addr, 0,
+		dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 0,
 				DWC3_TRBCTL_CONTROL_DATA, false);
-		ret = dwc3_ep0_start_trans(dwc, dep->number);
+		ret = dwc3_ep0_start_trans(dep);
 	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
 			&& (dep->number == 0)) {
-		u32	transfer_size = 0;
 		u32	maxpacket;
+		u32	rem;
 
 		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
 				&req->request, dep->number);
@@ -1012,36 +975,55 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 			return;
 
 		maxpacket = dep->endpoint.maxpacket;
+		rem = req->request.length % maxpacket;
+		dwc->ep0_bounced = true;
 
-		if (req->request.length > DWC3_EP0_BOUNCE_SIZE) {
-			transfer_size = ALIGN(req->request.length - maxpacket,
-					      maxpacket);
-			dwc3_ep0_prepare_one_trb(dwc, dep->number,
-						   req->request.dma,
-						   transfer_size,
-						   DWC3_TRBCTL_CONTROL_DATA,
-						   true);
-		}
-
-		transfer_size = roundup((req->request.length - transfer_size),
-					maxpacket);
+		/* prepare normal TRB */
+		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
+					 req->request.length,
+					 DWC3_TRBCTL_CONTROL_DATA,
+					 true);
+
+		/* Now prepare one extra TRB to align transfer size */
+		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
+					 maxpacket - rem,
+					 DWC3_TRBCTL_CONTROL_DATA,
+					 false);
+		ret = dwc3_ep0_start_trans(dep);
+	} else if (IS_ALIGNED(req->request.length, dep->endpoint.maxpacket) &&
+		   req->request.length && req->request.zero) {
+		u32	maxpacket;
+		u32	rem;
 
-		dwc->ep0_bounced = true;
+		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
+				&req->request, dep->number);
+		if (ret)
+			return;
 
-		dwc3_ep0_prepare_one_trb(dwc, dep->number,
-				dwc->ep0_bounce_addr, transfer_size,
-				DWC3_TRBCTL_CONTROL_DATA, false);
-		ret = dwc3_ep0_start_trans(dwc, dep->number);
+		maxpacket = dep->endpoint.maxpacket;
+		rem = req->request.length % maxpacket;
+
+		/* prepare normal TRB */
+		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
+					 req->request.length,
+					 DWC3_TRBCTL_CONTROL_DATA,
+					 true);
+
+		/* Now prepare one extra TRB to align transfer size */
+		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
+					 0, DWC3_TRBCTL_CONTROL_DATA,
+					 false);
+		ret = dwc3_ep0_start_trans(dep);
 	} else {
 		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
 				&req->request, dep->number);
 		if (ret)
 			return;
 
-		dwc3_ep0_prepare_one_trb(dwc, dep->number, req->request.dma,
+		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
 				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
 				false);
-		ret = dwc3_ep0_start_trans(dwc, dep->number);
+		ret = dwc3_ep0_start_trans(dep);
 	}
 
 	WARN_ON(ret < 0);
@@ -1055,9 +1037,8 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 	type = dwc->three_stage_setup ? DWC3_TRBCTL_CONTROL_STATUS3
 		: DWC3_TRBCTL_CONTROL_STATUS2;
 
-	dwc3_ep0_prepare_one_trb(dwc, dep->number,
-			dwc->ctrl_req_addr, 0, type, false);
-	return dwc3_ep0_start_trans(dwc, dep->number);
+	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 0, type, false);
+	return dwc3_ep0_start_trans(dep);
 }
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 79e7a3480d51..aea9a5b948b4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -171,7 +171,6 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status)
 {
 	struct dwc3			*dwc = dep->dwc;
-	unsigned int			unmap_after_complete = false;
 
 	req->started = false;
 	list_del(&req->list);
@@ -181,19 +180,8 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
 
-	/*
-	 * NOTICE we don't want to unmap before calling ->complete() if we're
-	 * dealing with a bounced ep0 request. If we unmap it here, we would end
-	 * up overwritting the contents of req->buf and this could confuse the
-	 * gadget driver.
-	 */
-	if (dwc->ep0_bounced && dep->number <= 1) {
-		dwc->ep0_bounced = false;
-		unmap_after_complete = true;
-	} else {
-		usb_gadget_unmap_request_by_dev(dwc->sysdev,
-				&req->request, req->direction);
-	}
+	usb_gadget_unmap_request_by_dev(dwc->sysdev,
+					&req->request, req->direction);
 
 	trace_dwc3_gadget_giveback(req);
 
@@ -201,10 +189,6 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
 	spin_lock(&dwc->lock);
 
-	if (unmap_after_complete)
-		usb_gadget_unmap_request_by_dev(dwc->sysdev,
-				&req->request, req->direction);
-
 	if (dep->number > 1)
 		pm_runtime_put(dwc->dev);
 }
@@ -1060,6 +1044,22 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 				false, 0, req->request.stream_id,
 				req->request.short_not_ok,
 				req->request.no_interrupt);
+	} else if (req->request.zero && req->request.length &&
+		   (IS_ALIGNED(req->request.length,dep->endpoint.maxpacket))) {
+		struct dwc3	*dwc = dep->dwc;
+		struct dwc3_trb	*trb;
+
+		req->zero = true;
+
+		/* prepare normal TRB */
+		dwc3_prepare_one_trb(dep, req, true, 0);
+
+		/* Now prepare one extra TRB to handle ZLP */
+		trb = &dep->trb_pool[dep->trb_enqueue];
+		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
+				false, 0, req->request.stream_id,
+				req->request.short_not_ok,
+				req->request.no_interrupt);
 	} else {
 		dwc3_prepare_one_trb(dep, req, false, 0);
 	}
@@ -1184,8 +1184,11 @@ static void __dwc3_gadget_start_isoc(struct dwc3 *dwc,
 		return;
 	}
 
-	/* 4 micro frames in the future */
-	uf = cur_uf + dep->interval * 4;
+	/*
+	 * Schedule the first trb for one interval in the future or at
+	 * least 4 microframes.
+	 */
+	uf = cur_uf + max_t(u32, 4, dep->interval);
 
 	__dwc3_gadget_kick_transfer(dep, uf);
 }
@@ -1258,45 +1261,30 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 				__dwc3_gadget_start_isoc(dwc, dep, cur_uf);
 				dep->flags &= ~DWC3_EP_PENDING_REQUEST;
 			}
+			return 0;
 		}
-		return 0;
+
+		if ((dep->flags & DWC3_EP_BUSY) &&
+		    !(dep->flags & DWC3_EP_MISSED_ISOC)) {
+			WARN_ON_ONCE(!dep->resource_index);
+			ret = __dwc3_gadget_kick_transfer(dep,
+							  dep->resource_index);
+		}
+
+		goto out;
 	}
 
 	if (!dwc3_calc_trbs_left(dep))
 		return 0;
 
 	ret = __dwc3_gadget_kick_transfer(dep, 0);
+out:
 	if (ret == -EBUSY)
 		ret = 0;
 
 	return ret;
 }
 
-static void __dwc3_gadget_ep_zlp_complete(struct usb_ep *ep,
-		struct usb_request *request)
-{
-	dwc3_gadget_ep_free_request(ep, request);
-}
-
-static int __dwc3_gadget_ep_queue_zlp(struct dwc3 *dwc, struct dwc3_ep *dep)
-{
-	struct dwc3_request		*req;
-	struct usb_request		*request;
-	struct usb_ep			*ep = &dep->endpoint;
-
-	request = dwc3_gadget_ep_alloc_request(ep, GFP_ATOMIC);
-	if (!request)
-		return -ENOMEM;
-
-	request->length = 0;
-	request->buf = dwc->zlp_buf;
-	request->complete = __dwc3_gadget_ep_zlp_complete;
-
-	req = to_dwc3_request(request);
-
-	return __dwc3_gadget_ep_queue(dep, req);
-}
-
 static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 	gfp_t gfp_flags)
 {
@@ -1310,17 +1298,6 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_queue(dep, req);
-
-	/*
-	 * Okay, here's the thing, if gadget driver has requested for a ZLP by
-	 * setting request->zero, instead of doing magic, we will just queue an
-	 * extra usb_request ourselves so that it gets handled the same way as
-	 * any other request.
-	 */
-	if (ret == 0 && request->zero && request->length &&
-	    (request->length % ep->maxpacket == 0))
-		ret = __dwc3_gadget_ep_queue_zlp(dwc, dep);
-
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -1400,7 +1377,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 					dwc3_ep_inc_deq(dep);
 				}
 
-				if (r->unaligned) {
+				if (r->unaligned || r->zero) {
 					trb = r->trb + r->num_pending_sgs + 1;
 					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 					dwc3_ep_inc_deq(dep);
@@ -1411,7 +1388,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 				trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 				dwc3_ep_inc_deq(dep);
 
-				if (r->unaligned) {
+				if (r->unaligned || r->zero) {
 					trb = r->trb + 1;
 					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 					dwc3_ep_inc_deq(dep);
@@ -2006,14 +1983,15 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 
 /* -------------------------------------------------------------------------- */
 
-static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
-		u8 num, u32 direction)
+static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 num)
 {
 	struct dwc3_ep			*dep;
-	u8				i;
+	u8				epnum;
+
+	INIT_LIST_HEAD(&dwc->gadget.ep_list);
 
-	for (i = 0; i < num; i++) {
-		u8 epnum = (i << 1) | (direction ? 1 : 0);
+	for (epnum = 0; epnum < num; epnum++) {
+		bool			direction = epnum & 1;
 
 		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
 		if (!dep)
@@ -2021,12 +1999,12 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 
 		dep->dwc = dwc;
 		dep->number = epnum;
-		dep->direction = !!direction;
+		dep->direction = direction;
 		dep->regs = dwc->regs + DWC3_DEP_BASE(epnum);
 		dwc->eps[epnum] = dep;
 
 		snprintf(dep->name, sizeof(dep->name), "ep%d%s", epnum >> 1,
-				(epnum & 1) ? "in" : "out");
+				direction ? "in" : "out");
 
 		dep->endpoint.name = dep->name;
 
@@ -2053,7 +2031,7 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 			/* MDWIDTH is represented in bits, we need it in bytes */
 			mdwidth /= 8;
 
-			size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(i));
+			size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(epnum >> 1));
 			size = DWC3_GTXFIFOSIZ_TXFDEF(size);
 
 			/* FIFO Depth is in MDWDITH bytes. Multiply */
@@ -2103,7 +2081,7 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 			dep->endpoint.caps.type_int = true;
 		}
 
-		dep->endpoint.caps.dir_in = !!direction;
+		dep->endpoint.caps.dir_in = direction;
 		dep->endpoint.caps.dir_out = !direction;
 
 		INIT_LIST_HEAD(&dep->pending_list);
@@ -2113,27 +2091,6 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 	return 0;
 }
 
-static int dwc3_gadget_init_endpoints(struct dwc3 *dwc)
-{
-	int				ret;
-
-	INIT_LIST_HEAD(&dwc->gadget.ep_list);
-
-	ret = dwc3_gadget_init_hw_endpoints(dwc, dwc->num_out_eps, 0);
-	if (ret < 0) {
-		dev_err(dwc->dev, "failed to initialize OUT endpoints\n");
-		return ret;
-	}
-
-	ret = dwc3_gadget_init_hw_endpoints(dwc, dwc->num_in_eps, 1);
-	if (ret < 0) {
-		dev_err(dwc->dev, "failed to initialize IN endpoints\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 {
 	struct dwc3_ep			*dep;
@@ -2197,7 +2154,7 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	 * with one TRB pending in the ring. We need to manually clear HWO bit
 	 * from that TRB.
 	 */
-	if (req->unaligned && (trb->ctrl & DWC3_TRB_CTRL_HWO)) {
+	if ((req->zero || req->unaligned) && (trb->ctrl & DWC3_TRB_CTRL_HWO)) {
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		return 1;
 	}
@@ -2291,11 +2248,12 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 					event, status, chain);
 		}
 
-		if (req->unaligned) {
+		if (req->unaligned || req->zero) {
 			trb = &dep->trb_pool[dep->trb_dequeue];
 			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
 					event, status, false);
 			req->unaligned = false;
+			req->zero = false;
 		}
 
 		req->request.actual = length - req->remaining;
@@ -3078,6 +3036,15 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 		return IRQ_HANDLED;
 	}
 
+	/*
+	 * With PCIe legacy interrupt, test shows that top-half irq handler can
+	 * be called again after HW interrupt deassertion. Check if bottom-half
+	 * irq event handler completes before caching new event to prevent
+	 * losing events.
+	 */
+	if (evt->flags & DWC3_EVENT_PENDING)
+		return IRQ_HANDLED;
+
 	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
 	count &= DWC3_GEVNTCOUNT_MASK;
 	if (!count)
@@ -3161,49 +3128,26 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 	dwc->irq_gadget = irq;
 
-	dwc->ctrl_req = dma_alloc_coherent(dwc->sysdev, sizeof(*dwc->ctrl_req),
-			&dwc->ctrl_req_addr, GFP_KERNEL);
-	if (!dwc->ctrl_req) {
-		dev_err(dwc->dev, "failed to allocate ctrl request\n");
-		ret = -ENOMEM;
-		goto err0;
-	}
-
 	dwc->ep0_trb = dma_alloc_coherent(dwc->sysdev,
 					  sizeof(*dwc->ep0_trb) * 2,
 					  &dwc->ep0_trb_addr, GFP_KERNEL);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
 		ret = -ENOMEM;
-		goto err1;
+		goto err0;
 	}
 
-	dwc->setup_buf = kzalloc(DWC3_EP0_BOUNCE_SIZE, GFP_KERNEL);
+	dwc->setup_buf = kzalloc(DWC3_EP0_SETUP_SIZE, GFP_KERNEL);
 	if (!dwc->setup_buf) {
 		ret = -ENOMEM;
-		goto err2;
-	}
-
-	dwc->ep0_bounce = dma_alloc_coherent(dwc->sysdev,
-			DWC3_EP0_BOUNCE_SIZE, &dwc->ep0_bounce_addr,
-			GFP_KERNEL);
-	if (!dwc->ep0_bounce) {
-		dev_err(dwc->dev, "failed to allocate ep0 bounce buffer\n");
-		ret = -ENOMEM;
-		goto err3;
-	}
-
-	dwc->zlp_buf = kzalloc(DWC3_ZLP_BUF_SIZE, GFP_KERNEL);
-	if (!dwc->zlp_buf) {
-		ret = -ENOMEM;
-		goto err4;
+		goto err1;
 	}
 
 	dwc->bounce = dma_alloc_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE,
 			&dwc->bounce_addr, GFP_KERNEL);
 	if (!dwc->bounce) {
 		ret = -ENOMEM;
-		goto err5;
+		goto err2;
 	}
 
 	init_completion(&dwc->ep0_in_setup);
@@ -3241,39 +3185,31 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	 * sure we're starting from a well known location.
 	 */
 
-	ret = dwc3_gadget_init_endpoints(dwc);
+	ret = dwc3_gadget_init_endpoints(dwc, dwc->num_eps);
 	if (ret)
-		goto err6;
+		goto err3;
 
 	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register udc\n");
-		goto err6;
+		goto err4;
 	}
 
 	return 0;
-err6:
-	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
-			dwc->bounce_addr);
-
-err5:
-	kfree(dwc->zlp_buf);
 
 err4:
 	dwc3_gadget_free_endpoints(dwc);
-	dma_free_coherent(dwc->sysdev, DWC3_EP0_BOUNCE_SIZE,
-			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
 err3:
-	kfree(dwc->setup_buf);
+	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
+			dwc->bounce_addr);
 
 err2:
-	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
-			dwc->ep0_trb, dwc->ep0_trb_addr);
+	kfree(dwc->setup_buf);
 
 err1:
-	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ctrl_req),
-			dwc->ctrl_req, dwc->ctrl_req_addr);
+	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
+			dwc->ep0_trb, dwc->ep0_trb_addr);
 
 err0:
 	return ret;
@@ -3284,22 +3220,12 @@ err0:
 void dwc3_gadget_exit(struct dwc3 *dwc)
 {
 	usb_del_gadget_udc(&dwc->gadget);
-
 	dwc3_gadget_free_endpoints(dwc);
-
 	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
-			dwc->bounce_addr);
-	dma_free_coherent(dwc->sysdev, DWC3_EP0_BOUNCE_SIZE,
-			dwc->ep0_bounce, dwc->ep0_bounce_addr);
-
+			  dwc->bounce_addr);
 	kfree(dwc->setup_buf);
-	kfree(dwc->zlp_buf);
-
 	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
-			dwc->ep0_trb, dwc->ep0_trb_addr);
-
-	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ctrl_req),
-			dwc->ctrl_req, dwc->ctrl_req_addr);
+			  dwc->ep0_trb, dwc->ep0_trb_addr);
 }
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 265e223ab645..e4602d0e515b 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -29,16 +29,16 @@ struct dwc3;
 
 /* DEPCFG parameter 1 */
 #define DWC3_DEPCFG_INT_NUM(n)		(((n) & 0x1f) << 0)
-#define DWC3_DEPCFG_XFER_COMPLETE_EN	(1 << 8)
-#define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	(1 << 9)
-#define DWC3_DEPCFG_XFER_NOT_READY_EN	(1 << 10)
-#define DWC3_DEPCFG_FIFO_ERROR_EN	(1 << 11)
-#define DWC3_DEPCFG_STREAM_EVENT_EN	(1 << 13)
+#define DWC3_DEPCFG_XFER_COMPLETE_EN	BIT(8)
+#define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	BIT(9)
+#define DWC3_DEPCFG_XFER_NOT_READY_EN	BIT(10)
+#define DWC3_DEPCFG_FIFO_ERROR_EN	BIT(11)
+#define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(12)
 #define DWC3_DEPCFG_BINTERVAL_M1(n)	(((n) & 0xff) << 16)
-#define DWC3_DEPCFG_STREAM_CAPABLE	(1 << 24)
+#define DWC3_DEPCFG_STREAM_CAPABLE	BIT(24)
 #define DWC3_DEPCFG_EP_NUMBER(n)	(((n) & 0x1f) << 25)
-#define DWC3_DEPCFG_BULK_BASED		(1 << 30)
-#define DWC3_DEPCFG_FIFO_BASED		(1 << 31)
+#define DWC3_DEPCFG_BULK_BASED		BIT(30)
+#define DWC3_DEPCFG_FIFO_BASED		BIT(31)
 
 /* DEPCFG parameter 0 */
 #define DWC3_DEPCFG_EP_TYPE(n)		(((n) & 0x3) << 1)
@@ -47,10 +47,10 @@ struct dwc3;
 #define DWC3_DEPCFG_BURST_SIZE(n)	(((n) & 0xf) << 22)
 #define DWC3_DEPCFG_DATA_SEQ_NUM(n)	((n) << 26)
 /* This applies for core versions earlier than 1.94a */
-#define DWC3_DEPCFG_IGN_SEQ_NUM		(1 << 31)
+#define DWC3_DEPCFG_IGN_SEQ_NUM		BIT(31)
 /* These apply for core versions 1.94a and later */
 #define DWC3_DEPCFG_ACTION_INIT		(0 << 30)
-#define DWC3_DEPCFG_ACTION_RESTORE	(1 << 30)
+#define DWC3_DEPCFG_ACTION_RESTORE	BIT(30)
 #define DWC3_DEPCFG_ACTION_MODIFY	(2 << 30)
 
 /* DEPXFERCFG parameter 0 */
-- 
2.43.0

