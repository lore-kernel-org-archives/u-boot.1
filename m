Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F72C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CB8484AA2;
	Mon, 29 Jun 2026 10:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T75iQjUf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D31AD84AE8; Mon, 29 Jun 2026 10:47:29 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6D4184105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-39ad400e762so16870271fa.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722847; x=1783327647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sB7wEpLMhMc8i1XUUV0LMV5It9plBsHlt5LCSezqis=;
 b=T75iQjUfK3Ew5Q7Ypl1E+qnXmO/AUQC7xqMsjTxQPzgXiUvH0kOd7+gPu1sw5E1sfF
 3USnRrQkT21YdIC7uClV/vnSF7b+Ibt4/xtXWC0lnJFcxUbCvEuQRsH4IeTvrY5CVeGG
 u75b+l5iWiI1W+59ORsMKXSct7QQEeVykKhwL2ZQpOBetfFOIdNSnck/R7rVQnhzGX14
 q7s4j30aBf8yvFxz1cFRTEfYwQFgnVv9Tc2NEaH5VIPbDd+Bc7LbWlqRi+UJni1KyZif
 XeTpUtpOEtrWSXgL6ZZn8bznvV/g6VOevNVfR4bmtbCtcHqOxUomkD4z1zX860Y8/p36
 Z6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722847; x=1783327647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8sB7wEpLMhMc8i1XUUV0LMV5It9plBsHlt5LCSezqis=;
 b=hQO0q0dpj/gXmxqFKBUV8KKWeJrxyUucCDKJ7yo92q/WAIJhhrhNX3pJwDB2ElPbO+
 AbwDlJbfO49v8nA0oglRWdIcFNdCp+SaVYs6H5uvxCHx8wh781I9/jWRFGFY11IuGspw
 WvS+cjiHOidXn9IpEgkBOTWQmXx6rbrol+oqczjJVoMVx6tfvScTHSoCuQVuyDuTH6/4
 nCp0+P3tdQA8BINFwTk9wNFeytOQBpIXkhpBLYdSpVC3pD6jFjZR9wmxcwFcHAuMR/qo
 cAHm8x4c3+Jir/ombx5HbrlOop1jf5Wmw6/ybOf0hh60dXBAOLQG1CaNbMJqCQaAcH3X
 u/Lg==
X-Gm-Message-State: AOJu0Ywt/b6Y3td7kzmU2yFnGnf0AHSg6jTBHODmN6SJmEWuWYWS4Isy
 WRQGmwEHlEm+c6V7jrZIW14kqAE1tazQeQTU4pnW7TI0ixn3oJ15Dh+kym2QJKa/6LWQTRq4FAC
 MF9GIx70=
X-Gm-Gg: AfdE7clpwYzoiSe9s2VMzNO8HSUJDM0G10zcWeuJ4V3H8scT9TIbAY0ErDAqRn7+t/v
 XMpkSvD4+ws6hQ8p9dVmhE5W6Hmuvog4FXoc9wHj4pbXCYlgoIJEz2ocWr4Tc+KwaBKytT8MvsU
 CH/ia881z2zUJBkA91b3r8IlAm+RUNFJebfIC1MM7m6tAm5KA6pUxT36urfdqe/b/YOwHo7HEZ/
 ubIcMVydSSTAuWyJDwocGzGnFKXa3rHi/sfdUvx1w150MkvCpGZHh67OwloyReJ5CSzRaRRA3bU
 F/cvdX2HOr63Vqp7uJlyrUm+UYG3R+WpSSMwLTr8FJ8Kx84lpG8xBKaVY28jiJQeVcljbi0KjsV
 6NuTTBXIjrVrk+va19J3JFgm7QsKZSLHQZs2fHIBseWzQnA4x0RoYEM17+GG2EjnP5bj6XLc7D0
 CXRTbcUMMpcUV/Fi04EcX/wjwkI97UbdNRgrBTTAYRCgmsQrRtjfMPqJjMx3IeXWeIP74ZCebYJ
 4KrSILxYX+JnE4GLwcto/wz7EY0Op4=
X-Received: by 2002:a2e:9a09:0:b0:39a:ffc1:3390 with SMTP id
 38308e7fff4ca-39affc1367fmr11425171fa.6.1782722846889; 
 Mon, 29 Jun 2026 01:47:26 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:47:25 -0700 (PDT)
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
Subject: [PATCH v4 47/64] usb: dwc3: import from kernel v6.3
Date: Mon, 29 Jun 2026 10:44:23 +0200
Message-ID: <20260629084507.3254232-48-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.2 to v6.3.

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

List of commits: git log --oneline v6.2..v6.3
Commits imported:
ec799c8a92e0 usb: dwc3: pci: add support for the Intel Meteor Lake-S
d8a2bb4eb758 usb: dwc3: gadget: Add 1ms delay after end transfer command without IOC
02c1820345e7 usb: dwc3: Fix a typo in field name
e3eafcf0fabe usb: dwc3: xilinx: Remove unused of_gpio,h
8e5248c3a877 usb: dwc3: pci: add support for the Intel Meteor Lake-M
be308d68785b USB: dwc3: fix memory leak with using debugfs_lookup()
924fb3ec50f5 Merge 6.2-rc7 into usb-next
e3e9fc7fa7ad Merge 6.2-rc5 into usb-next
c2fb9a214da1 Merge 6.2-rc3 into usb-next

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/dwc3/core.h   |  4 +++-
 drivers/usb/dwc3/debug.h  |  3 +++
 drivers/usb/dwc3/gadget.c | 18 ++++++++++++------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8f9959ba9fd4..4743e918dcaf 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1098,7 +1098,7 @@ struct dwc3_scratchpad_array {
  *			change quirk.
  * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
  *			check during HS transmit.
- * @resume-hs-terminations: Set if we enable quirk for fixing improper crc
+ * @resume_hs_terminations: Set if we enable quirk for fixing improper crc
  *			generation after resume from suspend.
  * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
  *			instances in park mode.
@@ -1117,6 +1117,7 @@ struct dwc3_scratchpad_array {
  *		     address.
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
+ * @debug_root: root debugfs directory for this device to put its files in.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1332,6 +1333,7 @@ struct dwc3 {
 	int			max_cfg_eps;
 	int			last_fifo_depth;
 	int			num_ep_resized;
+	struct dentry		*debug_root;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 48b44b88dc25..8bb2c9e3b9ac 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -414,11 +414,14 @@ static inline const char *dwc3_gadget_generic_cmd_status_string(int status)
 
 #ifdef CONFIG_DEBUG_FS
 extern void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep);
+extern void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep);
 extern void dwc3_debugfs_init(struct dwc3 *d);
 extern void dwc3_debugfs_exit(struct dwc3 *d);
 #else
 static inline void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
 {  }
+static inline void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep)
+{  }
 static inline void dwc3_debugfs_init(struct dwc3 *d)
 {  }
 static inline void dwc3_debugfs_exit(struct dwc3 *d)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89dcfac01235..cf5b4f49c3ed 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1699,6 +1699,7 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
  */
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
+	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
 	int ret;
@@ -1722,10 +1723,13 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
-	if (!interrupt)
+	if (!interrupt) {
+		if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))
+			mdelay(1);
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	else if (!ret)
+	} else if (!ret) {
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+	}
 
 	dep->flags &= ~DWC3_EP_DELAY_STOP;
 	return ret;
@@ -3194,9 +3198,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 			list_del(&dep->endpoint.ep_list);
 		}
 
-		debugfs_remove_recursive(debugfs_lookup(dep->name,
-				debugfs_lookup(dev_name(dep->dwc->dev),
-					       usb_debug_root)));
+		dwc3_debugfs_remove_endpoint_dir(dep);
 		kfree(dep);
 	}
 }
@@ -3776,7 +3778,11 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	 * enabled, the EndTransfer command will have completed upon
 	 * returning from this function.
 	 *
-	 * This mode is NOT available on the DWC_usb31 IP.
+	 * This mode is NOT available on the DWC_usb31 IP.  In this
+	 * case, if the IOC bit is not set, then delay by 1ms
+	 * after issuing the EndTransfer command.  This allows for the
+	 * controller to handle the command completely before DWC3
+	 * remove requests attempts to unmap USB request buffers.
 	 */
 
 	__dwc3_stop_active_transfer(dep, force, interrupt);
-- 
2.43.0

