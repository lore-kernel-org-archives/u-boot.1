Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F98FE6BF20
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 15:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E429844F4;
	Fri, 30 Jan 2026 16:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MxAELih2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12F0844CF; Fri, 30 Jan 2026 16:39:40 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65C6784067
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 16:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-409697b94bcso1411334fac.1
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 07:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769787577; x=1770392377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxIVLVSNABAKnICMNDqwEAqtIaxh9kLUFcymZ2lOcuA=;
 b=MxAELih2Wt8D7OZtsjIWNecKasxL0aboi3CG2PzAM+zEArDOzmuRaub7oBs1XpmaQp
 SsVB6Ap3Zt/InWWG+jxKegff6PN2AHgcqHqs02lKJiu+dS62sc7py9gmA6wkj5ISemTw
 gL/5eNmaPN5kqBumSjPHcvt0UpT/z9UvlaFPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769787577; x=1770392377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GxIVLVSNABAKnICMNDqwEAqtIaxh9kLUFcymZ2lOcuA=;
 b=mJDOg/e5sz58XTojcB8zcyqkQ2yldnyHLdIokgqaygHCkfcN+vQiIcSwN1HWpccX+X
 pripNaKr6im2DtnfLFmcKhar3T0E3gpp6UqpRP3e19LsgqvzpHb013Mg2dqtjQOkk/92
 446jmMNQYATXm9icnByK06pYYOG46sTvgKNeyU/dmaHye2uL0XvfJillxGiztQoG9WIO
 K1kVVqC/DCqZy/TTNFfHZl9aj7FsuGkoJm06bwSSyVP8fH9DJze6wk5qmyCx1QL/F2Qm
 OZB2CDPj6lzRSl1sqHeSN72sQpvY2CjIhHCti7JPeHG5POwVZoDpyvgJoQeInwDFrWRD
 qBug==
X-Gm-Message-State: AOJu0Yyl8zHIUa8aaU5WBwtzGBCVFdUxErwLHOPr34g8A+6KeQ73q4OQ
 Fv9/z8uSz9YtfJXUuCIdY6yUas5NfBmpFkya4Gzpm5DVGCPemhp/Va82FhyQ6fWWPPjel8HDWmd
 ZjZwg
X-Gm-Gg: AZuq6aIW9ZIU+7K+OlCaOZQOHzB/Y5kPNFeeX0sOE9OsckM/lboUCKy6qmH7SG1K4R7
 gOLZYiwRuensxGN76+sKPX2ydRHQ+QN8yL+MbB5TWaLewpd+y0q/eKB/7K1UxMN6POHlMg1YxnV
 31CH2BgLmv2SzKDUEamWp3F+RKIZyLL3dmqfyrphbqCW7/DxLB5XE1y5p15UZn8ShjqTzwAEJq1
 VvtgAy8hM3cLd/wbdnxZH36nz2QpqmZlwq+/gpSddKNmplkq9c7XbEd4Htev2UayNQaItiPgsng
 Xks1izI4f2ovsxZultNhV38i94T3wm6uI15R3RlCDi7FGaY08J/ROpx6A9Dg7n9jG/TK8fg5WB4
 r6LbgQxAY9+X6up3tHHE7NFrWCcMyLlYa/8sOSHsO6cwq+n8YRC3+yVdwH7wYfsKfGagJKW89gw
 jEgiYpEzg1mxkkJIDtDwOOZTy7rvljeQ8KM4Mh94xL/jL5Wg==
X-Received: by 2002:a05:6870:3649:b0:3e1:142b:f68a with SMTP id
 586e51a60fabf-409a6b0525fmr1828696fac.6.1769787576738; 
 Fri, 30 Jan 2026 07:39:36 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095752ef7bsm5944934fac.16.2026.01.30.07.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 07:39:36 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/6] pci: pcie_cdns_ti: Add support to provide refclk to
 PCIe connector
Date: Fri, 30 Jan 2026 09:38:04 -0600
Message-ID: <20260130153856.2049575-5-george.mccollister@konsulko.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130153856.2049575-1-george.mccollister@konsulko.com>
References: <20260130153856.2049575-1-george.mccollister@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Jan 2026 16:40:08 +0100
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

Add support to provide refclk to PCIe connector.

Based on: https://lore.kernel.org/r/20210308063550.6227-5-kishon@ti.com

Signed-off-by: George McCollister <george.mccollister@konsulko.com>
Tested-by: Bryan Brattlof <bb@ti.com>
---

(no changes since v1)

 drivers/pci/pcie_cdns_ti.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/pcie_cdns_ti.c b/drivers/pci/pcie_cdns_ti.c
index 9d1d123a18cb..ff56ba3930c6 100644
--- a/drivers/pci/pcie_cdns_ti.c
+++ b/drivers/pci/pcie_cdns_ti.c
@@ -742,6 +742,20 @@ static int pcie_cdns_ti_probe(struct udevice *dev)
 	}
 	generic_phy_reset(&serdes);
 	generic_phy_init(&serdes);
+
+	clk = devm_clk_get_optional(dev, "pcie_refclk");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		dev_err(dev, "failed to get pcie_refclk\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(dev, "failed to enable pcie_refclk\n");
+		return ret;
+	}
+
 	generic_phy_power_on(&serdes);
 
 	ret = pcie_cdns_ti_ctrl_init(pcie);
-- 
2.52.0

