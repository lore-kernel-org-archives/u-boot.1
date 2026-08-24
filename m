Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61242C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AD3980E98;
	Mon, 24 Aug 2026 16:46:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rkw4syAJPQcz; Mon, 24 Aug 2026 16:46:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589905;
	bh=BMWPxhJU07SszhgENdrVD2oVr1+bL4jhDtZONMpI6XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=adtybPwFtLbg1VSI15ueRU13ZRpFLh7I2hlC7t69nRBGDsUGzzht+BSkUT9xzuIk4
	 DQusmLA26g+F+4unNEbv1pGxrQh0TDtYH6Q9SB5Gnt0cENVZbejfDJNfjVdmFYjsNF
	 48lwzVBEeTuNwSoAq6kv8L6OgZlYpbw4PGB1g2KNo1dGzVNUVuiNVOTi7kjh6MZ9/s
	 L27D1ebY23NUDo9sh0l412Z2XPY3KB8GloK1r0bC/W10ch0O1M3S+jcC7YbK3m06hT
	 cx+0q3k1P36mvKuEzv+/fP0p5b+P3O6SARb68m41wj41XWMujvZyG2ajVAGCqCdgmO
	 FLSmkFDh69vgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E1CE80E9B;
	Mon, 24 Aug 2026 16:45:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FBF2396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 21F39403F8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFcUQSLVhbaC for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:31:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=w4QZkWQ4
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D3C00403EB
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:22 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c15e62c695cso33018966b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585481; x=1788190281;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BMWPxhJU07SszhgENdrVD2oVr1+bL4jhDtZONMpI6XE=;
 b=w4QZkWQ48IqoyamHNavUlXyvPu/oHKcVCkrny3QDHbpwadIbQp4Tv3Jt5ydASKqlCO
 ywbViYs6FUuDr7Xt+SCYe6YcduWHFmcwwPwelaj3iVN0OgWOKW2h28s30oe1reUSolsU
 i5ktaTYqVdk6bXHRzSaML+H1mVYHbavk9F+6JeimPV2MyDhyhUzZf4c9EFuZO5nP31sC
 sjcczO3qD+qAohj3ez4IodSh8SsKDlZqw4L4fCZVrS2vfSwyfKZNyF5jxJvDz8BIifX1
 7Q1rQi3HswEOscf+ARJ9ltAo9iHO0bcBpCqg7q1WLI87E1/fNQcmR90DvikoZEz/Ymdb
 zjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585481; x=1788190281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BMWPxhJU07SszhgENdrVD2oVr1+bL4jhDtZONMpI6XE=;
 b=YB3Bb2UIwwBo2agWZ+4EXGqueXKB4M8rgd5sopPjyeahUbooT24l6tJxQHIsl+fwtT
 wVA6OC0ZU+nXyI6h7cfCyZLUUlQjn2KvPs5DIcQ/suxfcvPJ5a64p7NylJujOaoHvavJ
 0BDT2Mc2j/+fTszPzdIaVlFxvDSGXymyO8MiV06EMvcaIkVt0sXg/tk3Rn+sJR/oQalC
 6MuFaYASa41T7h2S8RNg2Ku3WhdOSVxki7dizrBb5bI33B/holn466xRZWKKqdfW+Lof
 ChHtRh0FfnHL1TNHdE1umol0nN2BuQB/8rHAslJaOVed3K0dJtWUXAPsFSiZe3hvhJx4
 eGtA==
X-Gm-Message-State: AFuF++mqP+jwd/qLDuiUvKz4Rr9u10DXWtL8fkfAQrtD/tYNM8L4aO2F
 6xFpM7zlvcy57GHXTb+2IWVi3q6RVKVGzMIn51Ggc5GCqnEfSwfkIlTtUvPrOxmhHC9e6n/vbBF
 2LyEq
X-Gm-Gg: AR+sD13hnF9GUcVXeK9s7lhq3ETgmoM6o4qnzBKYv6zeRZUsdVd6Blww7mg4WhwXB7W
 M+RsricxVRtZK9S5f5H1PiG18aBi+1Ti4eTgkR0gDtr75JfhiA7KcFwkYyrxKDEsU79UgGBoWvl
 MMDIQJGh9Buaj1Mcx0KZAGMCwJv7E2wtInbm+Lot9KeY5+ZQKmQtoNBB4DI1qenCy9mY6hO3rvL
 +hNFI4mKO62GoqAFM7Z0a03XUsZwHqNPBetpbAyCn30A90KZRM0k/E2bt6BdyyYfS9yV0RAcSdO
 B5KG4spCyUmYvqFifNkOYBmOEKvfflqAoO+bpwsNDj4OjypXqJd8JkQa5KxH0dqKugoqel06lxA
 bDcyMhHvkaZiDa1mxnmVkmG6oU/CStk6CL8RWyTRsS3j7MjSI5FmPy3PGxmo8ubU3I2ihw43fNd
 yVtJ0UolKOhUPttWJ3C+1ecve49lC7rHSDokeebi+ABHlZVsBSpXOZr4WGUtoUqzR8R8GZI/CSb
 wy9ctD3CeXhd/bK4jq5vO6JhtCHNcCUWg==
X-Received: by 2002:a17:907:a089:b0:c15:de99:8060 with SMTP id
 a640c23a62f3a-c2469f96e84mr1543999366b.0.1787585478842; 
 Mon, 24 Aug 2026 08:31:18 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295632sm1479917366b.18.2026.08.24.08.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:31:18 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 48/63] usb: dwc3: import from kernel v6.3
Date: Mon, 24 Aug 2026 17:27:19 +0200
Message-ID: <20260824152734.159794-49-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824152734.159794-1-anders.roxell@linaro.org>
References: <20260824152734.159794-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v6.2 to v6.3.

The following files are preserved across the import:
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
d8a2bb4eb758 usb: dwc3: gadget: Add 1ms delay after end transfer command without IOC
02c1820345e7 usb: dwc3: Fix a typo in field name
be308d68785b USB: dwc3: fix memory leak with using debugfs_lookup()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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
2.53.0

