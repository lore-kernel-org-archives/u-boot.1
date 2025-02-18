Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCB4C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 02:58:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECAD80ADF;
	Tue, 18 Feb 2025 03:58:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="K/skujV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1CF480ADF; Tue, 18 Feb 2025 03:58:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3205480017
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739847502; x=1771383502;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QcV/X44f+a5qSHya8CTCaJyhMoMqc+AMLIbqTmCrYlc=;
 b=K/skujV9CkKj5nvbhmibFEFn1J8HpEsS3dmrPUd0ss18YYsYvZ2TrkGp
 TkXshffXBLE5Y9BntWKoEbRgA8ZDP0NruHO+KXBT+d8uiCb37upfcns2a
 59EjvpX4Z1Lt/J8xRUFS6q96nP5FMcXh62kV/wxyAodWCq+Ra3bw9pmca
 3RMr6q6h7mTMxIXloenizqeDQ1LHHTyogJooqhHtJNb8bLbCJf0Ek4i2X
 9xAsRn2krRb1XIGdfRMHjqCPqz0316Vszjr50Yh6S/yMcCmDKEzFxV3Uh
 VMx4S/L17+7bxxl2toIDcTbR9hPOoqLP1wHsV9e7VrbGNWKw6L53dyUFP w==;
X-CSE-ConnectionGUID: bdIoE86JQWO9XIItf8igeA==
X-CSE-MsgGUID: 0o2bl0vwT2qM69eGqa+51g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51174496"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="51174496"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 18:58:21 -0800
X-CSE-ConnectionGUID: oRHaTyTkR1aKpJ7uCHVRQA==
X-CSE-MsgGUID: AFRtT3PmT5+4D47I/c2XKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="119259315"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2025 18:58:16 -0800
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
Subject: [PATCH 10/10] cmd: Enabled Kconfig and Makefile for DWI3C cmd support
Date: Tue, 18 Feb 2025 10:57:05 +0800
Message-Id: <20250218025705.50051-11-dinesh.maniyam@intel.com>
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

Enable the Kconfig and Makefile for the
DWI3C driver cmd support.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 cmd/Kconfig  | 6 ++++++
 cmd/Makefile | 1 +
 2 files changed, 7 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a04fcaa0e0..5236e7ea76 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1327,6 +1327,12 @@ config CMD_I2C
 	help
 	  I2C support.
 
+config CMD_I3C
+	bool "i3c"
+	help
+	  Enable command to list i3c devices connected to the i3c controller
+	  and perform read and write on the connected i3c devices.
+
 config CMD_W1
 	depends on W1
 	default y if W1
diff --git a/cmd/Makefile b/cmd/Makefile
index 8410be576b..082470fa10 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_CMD_GPIO) += gpio.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_HVC) += smccc.o
 obj-$(CONFIG_CMD_I2C) += i2c.o
+obj-$(CONFIG_CMD_I3C) += i3c.o
 obj-$(CONFIG_CMD_IOTRACE) += iotrace.o
 obj-$(CONFIG_CMD_HASH) += hash.o
 obj-$(CONFIG_CMD_IDE) += ide.o disk.o
-- 
2.26.2

