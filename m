Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C72FCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D79384ADD;
	Thu,  7 May 2026 11:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qYXAEBvI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C40F484AEF; Thu,  7 May 2026 11:30:37 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1C3184AF5
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5a87782588cso860789e87.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146231; x=1778751031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDCCEbpv0cbcDWCiTbMZoN9J1xnwNn24IWivu58ugNA=;
 b=qYXAEBvIgVFIfPlIDt2hUXYcQBxq9BEONOZ5Rk1wXT6mdyzJfj6Jp2H2AFe4dd5CJK
 z3O1TdO5fmcNsrGeldrQ8ska8APaK7VJqboTu6IhobpZqnyyyHXbVJP9f292VTMsBWiI
 OVJdYLupnSaD1BE3vYcLLz+95E0nuMoc+d00HbnirwlYog9UJPQOdk25zfF5CNY8gKvj
 K//Ul58PwKVMOXGdJp0ixYNJzPvduOHsp8XVeutKzIWHnXrYKK39GuYUY/16LQPOM197
 RUyXoN0kyh4UhaNtDEgynm6O+nww47nA7iSfqh9exyYFvnLaWgkUKODzfMJKVvfUGW6N
 vt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146231; x=1778751031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bDCCEbpv0cbcDWCiTbMZoN9J1xnwNn24IWivu58ugNA=;
 b=AOnW6buNnlWYzKeJLuHq6OMBmRpT2ODexrTqvFhqT/OWymR47HsPiOyVMnsYcd3uyH
 VhLgGKyEWnfGSiOy1/q4sD7G9WA4vseV1jwl/UR8St3ofVzAzhxZ481gSNePSoNu654h
 NA0vAAE3wf0Uh1ZNqHydIRClwzTqHypHiJAgjTjiWxWhb/JJASdZkO74t3Emkb+6Wny8
 xpgCtPyLT0xe31nbu14ERnkr0ABq6Wk4KHuIb4i3ovlTIi/PnupXPMGLqZ52svmczxbZ
 dkHz9vPTr/9dORnGag2nAzZXIEBLSe/nxuFOGJ4JY8qIiy5fLId6jwOohkS5U49qzP3o
 nH9Q==
X-Gm-Message-State: AOJu0Yz2PJ++rOEuA/AYSBb4nrz8kv5NM+cFdxCEAgpthqxQ4E8ekhvC
 gJOcV74TBhv+MGzkzYhFbH6ubp8zs0cts1zq3skBNu7lbmufREP6ffsrrzlLDuksdfH2ete/Ggd
 ykPMMyjDzAQ==
X-Gm-Gg: AeBDieupxKJyIayzePeM0QI/gbU1fYgRbpbz87vbX1Wz59P8voINQrLdRbjARFks/a4
 u3rEKxUtnXvBFAoJSBa/yXzlVnMRlcwKbNWbbFlb0z9/MIwPFZzfRBMWGbiDB6ruh/sBfjpuyvB
 W0hvqREn7zfJ/ZObQjdWfEoJsCUWXniapW0n5Fm/S+38vDaul4tBiS8AMlWw9UzMOrvefTtrLdj
 o4vD2HOdcQfwXDAcFxtjJHRsQaU4qFFBwXkYX1pqRxFcdHlXyuDAO2C9Poj1WUp3DMW6pS+3vTf
 wF/FtQHKijVm+GMZWdmkEg+umny3CdzY2FGrBwIhRD2pqYNG/jOGRUCr7ZeL8CQIGbAMUszzXEw
 U2t52TL1tMj11GqtsVHChtnQY6O2Cqr0CqtRuNve/QF881Abx51VMyIZ4ughZofKr5aa9s/MmyG
 N+xWkg0PfnejYfwMBDSVOTMqO0dI0qp+fnNx6Foopz9CB24ivkn9vKoAu0rx+NNF+D0q6KI8h/4
 pmEjb91rbEu8BkKHrSwK2hCQxWZuhP7Vk0jZeB4eg==
X-Received: by 2002:a05:6512:2213:b0:5a8:9bb6:230a with SMTP id
 2adb3069b0e04-5a89bb62434mr754773e87.18.1778146231290; 
 Thu, 07 May 2026 02:30:31 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:30:29 -0700 (PDT)
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
Subject: [RFC PATCH v2 35/64] usb: dwc3: import from kernel v5.11
Date: Thu,  7 May 2026 11:27:42 +0200
Message-ID: <20260507092843.358908-36-jens.wiklander@linaro.org>
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

