Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AEBC021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 02:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3394180F7B;
	Tue, 18 Feb 2025 03:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UBmSDGhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5369B80F6C; Tue, 18 Feb 2025 03:58:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34EA580017
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:58:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739847497; x=1771383497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vU09s3BJkbi6OoOA4p85SO8e8FwR5kaWAUQ+PPf9Yvo=;
 b=UBmSDGhQfsWjB0ZwdzRxXh6+itj4iodN1UBhnBy7n7nXGj5CAAphwJoD
 oAV5gmN/9Ne/jlfwOh0H0p6994ifpPufqwWk19LJlQNgxp1P7qqscfbZI
 baCCEuGPKJSLuh29zclVBbRmgUa+Myph4gdjtXdb960o+vKWmlTnqSMYW
 sLoPkgIoz4Z2EDrdqEqdVRV33WQf6JAmDi+xBxjp0RHydk5/PNgUVVQDZ
 JidwPb02nsBkeyQIImw+wEAMS3vTvgqP3v1bn7kdrqqef65bR4eNMZrRH
 k5uQGJXXnIethX9sefLsMNPEqWNUbe+HHWHX0SHShUWMhZ43gwk7XDWaW g==;
X-CSE-ConnectionGUID: dG6TExc/Sc2/2CKur+N/xg==
X-CSE-MsgGUID: Z3FMw2pHR5e3oE4Vtoj16Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51174440"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="51174440"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 18:58:09 -0800
X-CSE-ConnectionGUID: G48/9Ol1Smq3qtpsNx8cAA==
X-CSE-MsgGUID: hA1Y4d93Te+4Y6rutXJ7qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="119259300"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2025 18:58:04 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wang Jie <dave.wang@rock-chips.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 08/10] i3c: master: dw-i3c-master: Fix OD_TIMING for spike
 filter
Date: Tue, 18 Feb 2025 10:57:03 +0800
Message-Id: <20250218025705.50051-9-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250218025705.50051-1-dinesh.maniyam@intel.com>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

Fix the I3C device with spike filter unable to detect issue by setting
tHIGH_INIT to 200ns for first broadcast address.
This is according to MIPI SPEC 1.1.1 for first broadcast address
which is already part of linux upstreamed patch.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/i3c/master/dw-i3c-master.c | 23 +++++++++++++++++++++++
 include/dw-i3c.h                   |  1 +
 include/linux/i3c/master.h         |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index b3c5bf210c..af6e472f23 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -330,6 +330,14 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
 		hcnt = SCL_I3C_TIMING_CNT_MIN;
 
+	/* set back to THIGH_MAX_NS, after disable spike filter */
+	if (!master->first_broadcast) {
+		lcnt = SCL_I3C_TIMING_LCNT(readl(master->regs + SCL_I3C_OD_TIMING));
+		scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | lcnt;
+		writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
+		return 0;
+	}
+
 	lcnt = DIV_ROUND_UP(core_rate, master->base.bus.scl_rate.i3c) - hcnt;
 	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
 		lcnt = SCL_I3C_TIMING_CNT_MIN;
@@ -347,6 +355,9 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	lcnt = max_t(u8,
 		     DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period), lcnt);
 
+	/* first broadcast thigh to 200ns, to disable spike filter */
+	hcnt = DIV_ROUND_UP(I3C_BUS_THIGH_INIT_OD_MIN_NS, core_period);
+
 	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
 
@@ -402,6 +413,9 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	u32 thld_ctrl;
 	int ret;
 
+	/* first broadcast to disable spike filter */
+	master->first_broadcast = true;
+
 	switch (bus->mode) {
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
@@ -481,6 +495,15 @@ static void dw_i3c_master_irq_handler(struct dw_i3c_master *master)
 	if (status & INTR_TRANSFER_ERR_STAT)
 		writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
 
+	/* set back to THIGH_MAX_NS, after disable spike filter */
+	if (master->first_broadcast) {
+		master->first_broadcast = false;
+		int ret = dw_i3c_clk_cfg(master);
+
+		if (ret)
+			pr_err("Failed to set clk cfg\n");
+	}
+
 	spin_unlock(&master->xferqueue.lock);
 }
 
diff --git a/include/dw-i3c.h b/include/dw-i3c.h
index 920f18bccb..42c37d6dfa 100644
--- a/include/dw-i3c.h
+++ b/include/dw-i3c.h
@@ -240,6 +240,7 @@ struct dw_i3c_master {
 	char version[5];
 	char type[5];
 	u8 addrs[MAX_DEVS];
+	bool first_broadcast;
 };
 
 struct dw_i3c_i2c_dev_data {
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 759e689e2c..aefe593fc2 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -280,6 +280,7 @@ struct i3c_device {
 #define I3C_BUS_I2C_FM_PLUS_SCL_RATE	1000000
 #define I3C_BUS_I2C_FM_SCL_RATE		400000
 #define I3C_BUS_TLOW_OD_MIN_NS		200
+#define I3C_BUS_THIGH_INIT_OD_MIN_NS	200
 
 /**
  * enum i3c_bus_mode - I3C bus mode
-- 
2.26.2

