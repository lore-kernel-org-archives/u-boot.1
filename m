Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84E1C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 21:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73BE1881C8;
	Fri, 12 Apr 2024 23:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OQWSF/L1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 745588800D; Fri, 12 Apr 2024 21:27:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECBF887DA7
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 21:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=curtis.machida@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712950021; x=1744486021;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZyVPkR0ssDjab4bjCQn/C/jGdAouNSHZuH5h9iXPnPM=;
 b=OQWSF/L1ehWkE+2seJrXf38tE0wcMornBB9bpMWbmVPVC/ViYAGQTxjd
 NLVgpLBrVnN3EC/JZwbsGvWiCm7aEetdR1adkXFXHGPGxNQEEUHgzKswv
 rTBTL5fQ+PDFo2rlI5GoWmglZC8/fK6aEq3q2JrcBybN1VIRfeaF9iPyi
 YG5txobeLy0l5lmU5rhwAnzGo0nq113KBNoDfw5FtumdoOrIiOyJOQdIa
 eGQXYPY7L2ijraZsu9wOCqZNe4BiOTYyoBoQQDWcyuYQBJS+AjB2sDt1G
 w3V3GK/BXUC+2Q/uch/32ZLKkw1bdUa8/DphSPOFPyHT0ZJ0iVtqPvf3c A==;
X-CSE-ConnectionGUID: Dfaf6I+zTFimCAG1/TDtzg==
X-CSE-MsgGUID: xSyHbUKpTwSJlJFw08r1Qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8970838"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="8970838"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2024 12:26:59 -0700
X-CSE-ConnectionGUID: OCQT9gB1SbqSquWKlOyN5g==
X-CSE-MsgGUID: RaVLKe2sRDSHuFxztGP8gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; d="scan'208";a="25864931"
Received: from cmachida-ivml.fm.intel.com (HELO
 cmachida-ivml.amr.corp.intel.com) ([10.4.125.170])
 by fmviesa003.fm.intel.com with ESMTP; 12 Apr 2024 12:26:58 -0700
From: curtis.machida@intel.com
To: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: cmachida <curtis.machida@intel.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Geis <pgwipeout@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mmc: sdhci: programmable clock calculation needs multiplier +1
Date: Fri, 12 Apr 2024 12:26:40 -0700
Message-ID: <20240412192641.2912914-1-curtis.machida@intel.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Apr 2024 23:18:50 +0200
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

From: cmachida <curtis.machida@intel.com>

According to the SD Host Controller Simplified Specification v4.20,
the multiplier value M is one more than the Clock Multiplier field.

Copied code from Linux project.  drivers/mmc/host/sdhci.c line 4405

Signed-off-by: cmachida <curtis.machida@intel.com>
---

 drivers/mmc/sdhci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 0178ed8a11..a8476ec4e9 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -929,6 +929,15 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
 		debug("%s, caps_1: 0x%x\n", __func__, caps_1);
 		host->clk_mul = (caps_1 & SDHCI_CLOCK_MUL_MASK) >>
 				SDHCI_CLOCK_MUL_SHIFT;
+
+		/*
+		 * In case the value in Clock Multiplier is 0, then programmable
+		 * clock mode is not supported, otherwise the actual clock
+		 * multiplier is one more than the value of Clock Multiplier
+		 * in the Capabilities Register.
+		 */
+		if (host->clk_mul)
+			host->clk_mul += 1;
 	}
 
 	if (host->max_clk == 0) {
-- 
2.43.2

