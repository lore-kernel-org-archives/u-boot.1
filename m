Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881A6C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3ACE040CE5;
	Fri, 21 Aug 2026 13:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mFcf9EtHmduo; Fri, 21 Aug 2026 13:14:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318041;
	bh=rvlahFlK8i4ALBJoN3w4bBAJCwlXwkUI5qSF1ddzQuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VBvP+RRDl5sRz6IjyZR8XqDxayLt0MjYQhq+FhQvH1DRpE9ooR0oO3hT0WjM1HXw6
	 32ipNpO6qaC1Ns4IsvMgdcXnfcH+otFlXRQ1IKQ/Ugg8Y/7GBRJqIcFAao7PBcVSZx
	 nPt89a34kkN77woDJVlXgLl20QLNGiA1kLICJXGJULnmaAxvqqPZhiKUqCcgkarbD1
	 wk3o7A6TkZ6ZviIpxekSiN9jUdJZXNfh2aTBfRZhVdciiGaUmQ/hNmD2fEnidyw/16
	 XxF2PKj5EjsE+UPpn0DQJTPUsR1nlgHScSXtj1lXEBkwJgaSR3GpQV0Lwvh7tiiYW1
	 mOl6vuikJ273w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3192D40CCF;
	Fri, 21 Aug 2026 13:14:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 45DD2476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37309407E5
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iWwQA3P-Trsa for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=AO/1OLDl
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1273E40931
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:05 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c160875e029so8109266b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302324; x=1787907124;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rvlahFlK8i4ALBJoN3w4bBAJCwlXwkUI5qSF1ddzQuI=;
 b=AO/1OLDl+H9n7FhZmumsDKR/08IwHHrQWMZuNbENnQqSB4mJzB6vJOL30GVW31qX3k
 wA6LqBVb6C9/u3bAkLXUWeeda0hry7vJViJJ6biLeXEdeMHzb58Ffk3YMtM01vjSwXFK
 RvIdfJW9K5edEMTqKTokSOtJCybMQG7GK4Un2Ep8k3bI4xCKxSe/EGyrWkr59cld6RWy
 +k69i7i2jwFN9hnM6j5tLPzGMnhDT4L9ytucTBQpK4Rn7FXu5U0p2sC0ZLCIZw3IhDOX
 UCbMAoFnNsZ3B1JCxog9vWME2Mv5gwfywJZsMiU79tdUDekN1m3PV4Lq//t6nQRBgMwd
 nx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302324; x=1787907124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rvlahFlK8i4ALBJoN3w4bBAJCwlXwkUI5qSF1ddzQuI=;
 b=scNhalHCpmcDHE+gifdMKgqv9eD6ooQrxZyGPxjsEL832Sqmo4HtKf+ZkZ1+iwm/Z6
 Bpv0vh6wGGky7n5spGI+ncZZq8bJOlj50Fnfio52eGfh+z0hlqGqmtHhQ8mR4ig/luut
 O8Nvl0NI2OEUdIALqd7xAE28gZxz/QkoX0POw2+jHyW6VA0GafxZIN+8K795Mm6g/iQC
 jXbhT5Y5PlDZj55UsgXrdmG39Kq3dzMQKZUgtQuWIX+SvEZzZzMuk7x2DWbLNvhxBpaU
 Jz5i9m6kPsJRAxfPoTxO1AvRsxEcau1+5OEhjoEmyyV1uOOML1xjT0Z759TDWFyQO2Jd
 vREw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLYlcNegvydgcmsk7/xf+zK4mYzueqCU/LczJjp0gws/LUEbHas67OW4AjHjf3Cq5gyQBFiPE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lqUG28nteznEgjTkPT4iVt77IfeXITabiivK5jV3Q4tKqXWEjb
 VQlYzwjR5D94I761gZ+jz3FRXRZ+f0bG1mIu3f9dUWJ6M7tP5mY13aBzOmzwpYoqUXI=
X-Gm-Gg: AR+sD11CRNAEoF81tUZAYAm7OPXJ7NDPp2qnP21UuX3RRaJIq/Qibms71gMlHtyiSRs
 jK0Qsa7uhKwyEP2DCrAqOUAAGf5486oB0iSSlOu//qznRw3Q0SJwKODBWe7+zy/c/CFYSEtIDqn
 +XkDixoFVK6Gci/FKeKOuT9IizP148EuEptcAyrb8JollCJqBXO3em2EEZkigPCAJwWZqDz8vZ3
 nvUO/t3ai0OSTB3UoQ/ItQEff4cyP0zXrUTpFB+u2JY3+PwYXDqmHmU7DpPEs7TH4k6iLTotZGd
 QxoG7ZGit5TZFDBQrqNDdzUUCliUb1lyn2jkAT6dmOepdpRs9D4a64cnv7Mhu+DXGLASlZvpZZK
 ihYcHkRM2WvolxSSwLcLVycKB2U8L/4Myh45SOARzj2CLeEGfgAinB4mjK8Ij6QLlfcvbMH0cmV
 m1s4DerHvUS5AOJMEvZ+orOBGphbDa7wBSB4TN1OC/lp5Nl6Af4qZia9a3e34nn7zML/FwBiU5v
 N2Y0nds3jhyvSe3c459RyKv
X-Received: by 2002:a17:907:f497:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c246a61c431mr247060866b.3.1787302323896; 
 Fri, 21 Aug 2026 01:52:03 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591dc662sm359565366b.42.2026.08.21.01.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:03 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 52/87] usb: dwc3: import from kernel v6.7
Date: Fri, 21 Aug 2026 10:47:28 +0200
Message-ID: <20260821084829.2070426-53-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
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

Sync Linux kernel dwc3 changes from v6.6 to v6.7.

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

List of commits: git log --oneline v6.6..v6.7
Commits imported:
8bbae288a85a usb: dwc3: set the dma max_seg_size
97789b93b792 usb: dwc3: add optional PHY interface clocks
e24bc293a6a6 usb: dwc3: document gfladj_refclk_lpm_sel field
e72fc8d6a12a usb: dwc3: core: configure TX/RX threshold for DWC3_IP

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c | 190 ++++++++++++++++++++++++++++++++--------
 drivers/usb/dwc3/core.h |  19 ++++
 2 files changed, 173 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 343d2570189f..b101dbf8c5dc 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -854,8 +854,20 @@ static int dwc3_clk_enable(struct dwc3 *dwc)
 	if (ret)
 		goto disable_ref_clk;
 
+	ret = clk_prepare_enable(dwc->utmi_clk);
+	if (ret)
+		goto disable_susp_clk;
+
+	ret = clk_prepare_enable(dwc->pipe_clk);
+	if (ret)
+		goto disable_utmi_clk;
+
 	return 0;
 
+disable_utmi_clk:
+	clk_disable_unprepare(dwc->utmi_clk);
+disable_susp_clk:
+	clk_disable_unprepare(dwc->susp_clk);
 disable_ref_clk:
 	clk_disable_unprepare(dwc->ref_clk);
 disable_bus_clk:
@@ -865,6 +877,8 @@ disable_bus_clk:
 
 static void dwc3_clk_disable(struct dwc3 *dwc)
 {
+	clk_disable_unprepare(dwc->pipe_clk);
+	clk_disable_unprepare(dwc->utmi_clk);
 	clk_disable_unprepare(dwc->susp_clk);
 	clk_disable_unprepare(dwc->ref_clk);
 	clk_disable_unprepare(dwc->bus_clk);
@@ -1094,6 +1108,111 @@ static void dwc3_set_power_down_clk_scale(struct dwc3 *dwc)
 	}
 }
 
+static void dwc3_config_threshold(struct dwc3 *dwc)
+{
+	u32 reg;
+	u8 rx_thr_num;
+	u8 rx_maxburst;
+	u8 tx_thr_num;
+	u8 tx_maxburst;
+
+	/*
+	 * Must config both number of packets and max burst settings to enable
+	 * RX and/or TX threshold.
+	 */
+	if (!DWC3_IP_IS(DWC3) && dwc->dr_mode == USB_DR_MODE_HOST) {
+		rx_thr_num = dwc->rx_thr_num_pkt_prd;
+		rx_maxburst = dwc->rx_max_burst_prd;
+		tx_thr_num = dwc->tx_thr_num_pkt_prd;
+		tx_maxburst = dwc->tx_max_burst_prd;
+
+		if (rx_thr_num && rx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+			reg |= DWC31_RXTHRNUMPKTSEL_PRD;
+
+			reg &= ~DWC31_RXTHRNUMPKT_PRD(~0);
+			reg |= DWC31_RXTHRNUMPKT_PRD(rx_thr_num);
+
+			reg &= ~DWC31_MAXRXBURSTSIZE_PRD(~0);
+			reg |= DWC31_MAXRXBURSTSIZE_PRD(rx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+		}
+
+		if (tx_thr_num && tx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
+			reg |= DWC31_TXTHRNUMPKTSEL_PRD;
+
+			reg &= ~DWC31_TXTHRNUMPKT_PRD(~0);
+			reg |= DWC31_TXTHRNUMPKT_PRD(tx_thr_num);
+
+			reg &= ~DWC31_MAXTXBURSTSIZE_PRD(~0);
+			reg |= DWC31_MAXTXBURSTSIZE_PRD(tx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
+		}
+	}
+
+	rx_thr_num = dwc->rx_thr_num_pkt;
+	rx_maxburst = dwc->rx_max_burst;
+	tx_thr_num = dwc->tx_thr_num_pkt;
+	tx_maxburst = dwc->tx_max_burst;
+
+	if (DWC3_IP_IS(DWC3)) {
+		if (rx_thr_num && rx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+			reg |= DWC3_GRXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC3_GRXTHRCFG_RXPKTCNT(~0);
+			reg |= DWC3_GRXTHRCFG_RXPKTCNT(rx_thr_num);
+
+			reg &= ~DWC3_GRXTHRCFG_MAXRXBURSTSIZE(~0);
+			reg |= DWC3_GRXTHRCFG_MAXRXBURSTSIZE(rx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+		}
+
+		if (tx_thr_num && tx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
+			reg |= DWC3_GTXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC3_GTXTHRCFG_TXPKTCNT(~0);
+			reg |= DWC3_GTXTHRCFG_TXPKTCNT(tx_thr_num);
+
+			reg &= ~DWC3_GTXTHRCFG_MAXTXBURSTSIZE(~0);
+			reg |= DWC3_GTXTHRCFG_MAXTXBURSTSIZE(tx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
+		}
+	} else {
+		if (rx_thr_num && rx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+			reg |= DWC31_GRXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC31_GRXTHRCFG_RXPKTCNT(~0);
+			reg |= DWC31_GRXTHRCFG_RXPKTCNT(rx_thr_num);
+
+			reg &= ~DWC31_GRXTHRCFG_MAXRXBURSTSIZE(~0);
+			reg |= DWC31_GRXTHRCFG_MAXRXBURSTSIZE(rx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+		}
+
+		if (tx_thr_num && tx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
+			reg |= DWC31_GTXTHRCFG_PKTCNTSEL;
+
+			reg &= ~DWC31_GTXTHRCFG_TXPKTCNT(~0);
+			reg |= DWC31_GTXTHRCFG_TXPKTCNT(tx_thr_num);
+
+			reg &= ~DWC31_GTXTHRCFG_MAXTXBURSTSIZE(~0);
+			reg |= DWC31_GTXTHRCFG_MAXTXBURSTSIZE(tx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
+		}
+	}
+}
+
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -1246,42 +1365,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
-	/*
-	 * Must config both number of packets and max burst settings to enable
-	 * RX and/or TX threshold.
-	 */
-	if (!DWC3_IP_IS(DWC3) && dwc->dr_mode == USB_DR_MODE_HOST) {
-		u8 rx_thr_num = dwc->rx_thr_num_pkt_prd;
-		u8 rx_maxburst = dwc->rx_max_burst_prd;
-		u8 tx_thr_num = dwc->tx_thr_num_pkt_prd;
-		u8 tx_maxburst = dwc->tx_max_burst_prd;
-
-		if (rx_thr_num && rx_maxburst) {
-			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
-			reg |= DWC31_RXTHRNUMPKTSEL_PRD;
-
-			reg &= ~DWC31_RXTHRNUMPKT_PRD(~0);
-			reg |= DWC31_RXTHRNUMPKT_PRD(rx_thr_num);
-
-			reg &= ~DWC31_MAXRXBURSTSIZE_PRD(~0);
-			reg |= DWC31_MAXRXBURSTSIZE_PRD(rx_maxburst);
-
-			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
-		}
-
-		if (tx_thr_num && tx_maxburst) {
-			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
-			reg |= DWC31_TXTHRNUMPKTSEL_PRD;
-
-			reg &= ~DWC31_TXTHRNUMPKT_PRD(~0);
-			reg |= DWC31_TXTHRNUMPKT_PRD(tx_thr_num);
-
-			reg &= ~DWC31_MAXTXBURSTSIZE_PRD(~0);
-			reg |= DWC31_MAXTXBURSTSIZE_PRD(tx_maxburst);
-
-			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
-		}
-	}
+	dwc3_config_threshold(dwc);
 
 	return 0;
 
@@ -1417,6 +1501,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
+	u8			rx_thr_num_pkt = 0;
+	u8			rx_max_burst = 0;
+	u8			tx_thr_num_pkt = 0;
+	u8			tx_max_burst = 0;
 	u8			rx_thr_num_pkt_prd = 0;
 	u8			rx_max_burst_prd = 0;
 	u8			tx_thr_num_pkt_prd = 0;
@@ -1479,6 +1567,14 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,usb2-lpm-disable");
 	dwc->usb2_gadget_lpm_disable = device_property_read_bool(dev,
 				"snps,usb2-gadget-lpm-disable");
+	device_property_read_u8(dev, "snps,rx-thr-num-pkt",
+				&rx_thr_num_pkt);
+	device_property_read_u8(dev, "snps,rx-max-burst",
+				&rx_max_burst);
+	device_property_read_u8(dev, "snps,tx-thr-num-pkt",
+				&tx_thr_num_pkt);
+	device_property_read_u8(dev, "snps,tx-max-burst",
+				&tx_max_burst);
 	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
 				&rx_thr_num_pkt_prd);
 	device_property_read_u8(dev, "snps,rx-max-burst-prd",
@@ -1560,6 +1656,12 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 
 	dwc->hird_threshold = hird_threshold;
 
+	dwc->rx_thr_num_pkt = rx_thr_num_pkt;
+	dwc->rx_max_burst = rx_max_burst;
+
+	dwc->tx_thr_num_pkt = tx_thr_num_pkt;
+	dwc->tx_max_burst = tx_max_burst;
+
 	dwc->rx_thr_num_pkt_prd = rx_thr_num_pkt_prd;
 	dwc->rx_max_burst_prd = rx_max_burst_prd;
 
@@ -1785,6 +1887,20 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
 		}
 	}
 
+	/* specific to Rockchip RK3588 */
+	dwc->utmi_clk = devm_clk_get_optional(dev, "utmi");
+	if (IS_ERR(dwc->utmi_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->utmi_clk),
+				"could not get utmi clock\n");
+	}
+
+	/* specific to Rockchip RK3588 */
+	dwc->pipe_clk = devm_clk_get_optional(dev, "pipe");
+	if (IS_ERR(dwc->pipe_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->pipe_clk),
+				"could not get pipe clock\n");
+	}
+
 	return 0;
 }
 
@@ -1918,6 +2034,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	pm_runtime_put(dev);
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	return 0;
 
 err_exit_debugfs:
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a69ac67d89fe..efe6caf4d0e8 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -211,6 +211,11 @@
 #define DWC3_GRXTHRCFG_RXPKTCNT(n) (((n) & 0xf) << 24)
 #define DWC3_GRXTHRCFG_PKTCNTSEL BIT(29)
 
+/* Global TX Threshold Configuration Register */
+#define DWC3_GTXTHRCFG_MAXTXBURSTSIZE(n) (((n) & 0xff) << 16)
+#define DWC3_GTXTHRCFG_TXPKTCNT(n) (((n) & 0xf) << 24)
+#define DWC3_GTXTHRCFG_PKTCNTSEL BIT(29)
+
 /* Global RX Threshold Configuration Register for DWC_usb31 only */
 #define DWC31_GRXTHRCFG_MAXRXBURSTSIZE(n)	(((n) & 0x1f) << 16)
 #define DWC31_GRXTHRCFG_RXPKTCNT(n)		(((n) & 0x1f) << 21)
@@ -991,6 +996,8 @@ struct dwc3_scratchpad_array {
  * @bus_clk: clock for accessing the registers
  * @ref_clk: reference clock
  * @susp_clk: clock used when the SS phy is in low power (S3) state
+ * @utmi_clk: clock used for USB2 PHY communication
+ * @pipe_clk: clock used for USB3 PHY communication
  * @reset: reset control
  * @regs: base address for our registers
  * @regs_size: address space size
@@ -1045,6 +1052,10 @@ struct dwc3_scratchpad_array {
  * @test_mode_nr: test feature selector
  * @lpm_nyet_threshold: LPM NYET response threshold
  * @hird_threshold: HIRD threshold
+ * @rx_thr_num_pkt: USB receive packet count
+ * @rx_max_burst: max USB receive burst size
+ * @tx_thr_num_pkt: USB transmit packet count
+ * @tx_max_burst: max USB transmit burst size
  * @rx_thr_num_pkt_prd: periodic ESS receive packet count
  * @rx_max_burst_prd: max periodic ESS receive burst size
  * @tx_thr_num_pkt_prd: periodic ESS transmit packet count
@@ -1106,6 +1117,8 @@ struct dwc3_scratchpad_array {
  *			instances in park mode.
  * @parkmode_disable_hs_quirk: set if we need to disable all HishSpeed
  *			instances in park mode.
+ * @gfladj_refclk_lpm_sel: set if we need to enable SOF/ITP counter
+ *                          running based on ref_clk
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  *	0	- -6dB de-emphasis
@@ -1156,6 +1169,8 @@ struct dwc3 {
 	struct clk		*bus_clk;
 	struct clk		*ref_clk;
 	struct clk		*susp_clk;
+	struct clk		*utmi_clk;
+	struct clk		*pipe_clk;
 
 	struct reset_control	*reset;
 
@@ -1273,6 +1288,10 @@ struct dwc3 {
 	u8			test_mode_nr;
 	u8			lpm_nyet_threshold;
 	u8			hird_threshold;
+	u8			rx_thr_num_pkt;
+	u8			rx_max_burst;
+	u8			tx_thr_num_pkt;
+	u8			tx_max_burst;
 	u8			rx_thr_num_pkt_prd;
 	u8			rx_max_burst_prd;
 	u8			tx_thr_num_pkt_prd;
-- 
2.53.0

