Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB566C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 02:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E7A80C98;
	Tue, 18 Feb 2025 03:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Y9fskW5K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35AB680017; Tue, 18 Feb 2025 03:57:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55E1C80F56
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739847467; x=1771383467;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qV5eA+9gf2/mYo8E1R5st5suTpbqFRoucZ+6WgYv5Wg=;
 b=Y9fskW5K+FBky0lNPPMQ4SB74PPFwcdQfXM7OQsaSUmZhG3cnQZZP5EY
 2Iv8ZT/M9LV1YNAOiy+JgSHKrgw1Bc4ik/Zqmkw4LAKz4lHCHn2ZYalVs
 tqRMomM/HenyDnObFQK0dSNAfdyvZ9CS4YcsLBBW2x8EQrhQmZns+R+WY
 06st3mn6u6MHX2nrxTbvYrNyA2PX5KDN9qy+re2/PTFEhTjr4/+ns8q0Y
 yG/22Ed5FLNcF1Jhw6lVOUHEIlt0VWgkf4VZG8RTKPJB2bs6VlQFCO2BI
 Mr7SRPWBWxTAf4JKyWuKH1lzAzv9cBBujRj0QDkzP70MHFXuIk7J9a3WO A==;
X-CSE-ConnectionGUID: FbjsE8DuSMezYVE5wtdWQg==
X-CSE-MsgGUID: UF39V0FvTZ2HQm1qPVjLAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51174211"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="51174211"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 18:57:46 -0800
X-CSE-ConnectionGUID: Wa2bZE9eT56n7xTnDQKj+Q==
X-CSE-MsgGUID: 1V98NkUNQLu9oZl0QAmt+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="119259272"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2025 18:57:40 -0800
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
Subject: [PATCH 04/10] drivers: Enabled Kconfig and Makefile for I3C support
Date: Tue, 18 Feb 2025 10:56:59 +0800
Message-Id: <20250218025705.50051-5-dinesh.maniyam@intel.com>
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

Enable I3C driver support.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/i3c/Kconfig  | 21 +++++++++++++++++++++
 drivers/i3c/Makefile |  3 +++
 2 files changed, 24 insertions(+)
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
new file mode 100644
index 0000000000..00c8d19f62
--- /dev/null
+++ b/drivers/i3c/Kconfig
@@ -0,0 +1,21 @@
+menuconfig I3C
+	tristate "I3C support"
+	select I2C
+	help
+	  I3C is a serial protocol standardized by the MIPI alliance.
+
+	  It's supposed to be backward compatible with I2C while providing
+	  support for high speed transfers and native interrupt support
+	  without the need for extra pins.
+
+	  The I3C protocol also standardizes the slave device types and is
+	  mainly designed to communicate with sensors.
+
+	  If you want I3C support, you should say Y here and also to the
+	  specific driver for your bus adapter(s) below.
+
+config DW_I3C_MASTER
+	tristate "Synospsys DesignWare I3C master driver"
+	depends on I3C
+	help
+	  Support for Synopsys DesignWare MIPI I3C Controller.
\ No newline at end of file
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
new file mode 100644
index 0000000000..2d42864d79
--- /dev/null
+++ b/drivers/i3c/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_DW_I3C_MASTER) += dw-i3c-master.o
\ No newline at end of file
-- 
2.26.2

