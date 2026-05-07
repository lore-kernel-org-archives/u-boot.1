Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DD5CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B3184B32;
	Thu,  7 May 2026 11:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zz09vCvP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B84A284B28; Thu,  7 May 2026 11:31:07 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73ACB84A81
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5a86c1fe573so540643e87.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146263; x=1778751063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eomlYqtvxwvSz/dmQ4LVlHkTsx+5U1wA8Lc+lsSScsk=;
 b=Zz09vCvP11XwCK7jsDMd9TaolJoFczkTrRqfEiTHipHyIe1J869q5fNj5SzV0sV/zz
 GNHEkujFPibj5pGNEIEYlmDKYBo4Efxa2EF2XUoOEqxIp/XLjvyLKmIm32RQqN0aVjkM
 HbNZ7OJGzgNfbTYyCwwUrYGXG4gQ6vFbaWKDJigByA/EAmGzHmhTBx6UCObCi32c3/R4
 lZt51navV9niP+ACt1uD/k3BEpJ4u3HAoawOcrUWMt9lMP0qWNsx8SzjcqoRuWBwJ6nr
 3jdL0J5/yAtPNIMmOIDlZgb6yAn/0X2sxzUuU9WPSgx1Sn7CQSkxIt6Mx/yfYtX2Oqwl
 YSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146263; x=1778751063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eomlYqtvxwvSz/dmQ4LVlHkTsx+5U1wA8Lc+lsSScsk=;
 b=bdEuaGtLnoG+EVR/ykRftauUJfdowgwe8Yfg0C52kTVFH0Q0XSgPKegnvYJBkgtivN
 3ydRWLLdfNS8OuaaN/wdbeZPRYvNpM5peu3/HjB2DyrVNWnlO+Bf4+MrV3w1H/yq83vz
 CJn9soLsSju6hsklFqpWHtbUMlz5f1JavBxyIroLN3XCCUqIZn2geHLcZukHkUTf72LQ
 tZLYWa+9ifekJRra+FjoBlUulKR8OowM6sdWW0LdQCv+9zR7y1iEtbXD73icgx7i0ZTY
 JelrPFTfSRXXD5hX4qgY/xmUfOMizeEjRAilpUz9BWfrR2XB1LVgrDofjrdrnVkm4Bgy
 BfUQ==
X-Gm-Message-State: AOJu0Yytxerlag9PulzaYjvZxYT4DGBEt3MLOv8wOcZ4ceJESwgnWyxo
 tOKn3L5n2kUOvSP1QenzVk0AJ/RRUhzg4MCGvuNYGqFyM/Bd+xIWi5nZL42PU3rXX8S5dkFw8PQ
 zCPxW5YWhtA==
X-Gm-Gg: AeBDievpsyV2XLlYAJYml4RPvot5YftJRDaRSTyirOWxwHhp0kT/N0455pjp9Bbo4LO
 A8tZVVfhRtK3xYJ2eY8P0xHi0LivTYa4LF8lEzeJQATHceqL+f4adj7SshdAxOqupT02BvBCAB5
 dYVQEoXyKYCVjcD929fP1fffV9Cx5y04qtm+cUjnTc34XdnatUS1UjVg9KVugcxF9QZpB/Jtsgn
 XyfrSd3tf2h7acJrSdIr6SpGbV7XwhCXmIe1wXGRTtnGMDoPH26caJWdBfXRK5j1sfuvKctvImk
 IzgVLRkUUi3tDQCUmbCq32BFy41UNQ1NMwFy9M5FddS12jTpoqwpjzoDACMapDQPCr5jpshZpux
 dxkrhHWWIZEXRNApQuQQluC8nvPQCFSRnawem0Swa8WxYa5GBVdiYGWxUQxKkG10LbqZdufON0h
 /oQvdM3wS9tyX8A8Z6WFBeha4Yaupf65a+dgfDvUPSZjJ853IlI5H65E/2grYc5RmPASTm/hjdF
 Q6WUfLrK+mkX2M2a2gl3l9nWegJsDRtj/i87kuAFNHXGnRf1vq7
X-Received: by 2002:a05:6512:691:b0:5a8:9986:8490 with SMTP id
 2adb3069b0e04-5a899868597mr791176e87.20.1778146262275; 
 Thu, 07 May 2026 02:31:02 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:31:01 -0700 (PDT)
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
Subject: [RFC PATCH v2 47/64] usb: dwc3: import from kernel v6.3
Date: Thu,  7 May 2026 11:27:54 +0200
Message-ID: <20260507092843.358908-48-jens.wiklander@linaro.org>
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

