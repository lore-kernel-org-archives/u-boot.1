Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8C0C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 02:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6EA480F32;
	Tue, 18 Feb 2025 03:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PxlZLtNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4291F80ADF; Tue, 18 Feb 2025 03:58:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C007980BAE
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739847494; x=1771383494;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1nY+qWK40X5/derOi1bvpx38NURLoSLywjAraVZk9Jc=;
 b=PxlZLtNYO/UWTsDq9/uhDQdgat84Uvle2NI5JVMPx6sLJV39ZjWeopNZ
 KZoiuACmVUIqmIIYXtc9FaZBt5vhkIzR/pXyQuJI0bF+EHpHsnndCeJOu
 w2SgxVyeE3MrLM8bnf4B5JULRlCuYvQTxCNuxXx1oeX//8RELee2ltxSX
 6dh4r73uQuBn2sOfh90my0+oTciy2TkMcHsk/+8DRBqJazu8EAt+CAmMr
 GcQgttjhqU8X6LmVixDs7OanOLGm3DTKluCVXFhwMcxI1y+Y758V9Vjw5
 +I7m//GYvYtvQfflo/Z+TNB3P78V3hh1w6thGsICcPoIFLWZTYCNC7647 w==;
X-CSE-ConnectionGUID: eVMHFDwBSh+LD9HRqN5PhQ==
X-CSE-MsgGUID: TON7UCvJT0yTx1K9YYDXlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51174411"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="51174411"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 18:58:03 -0800
X-CSE-ConnectionGUID: NtRd/jKmTDSrwl/g1X+8fw==
X-CSE-MsgGUID: Hbhsj8EaQ1eb5u0pNVuskQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="119259291"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2025 18:57:58 -0800
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
Subject: [PATCH 07/10] drivers: i3c: master: Enable probe i3c without slave
 device
Date: Tue, 18 Feb 2025 10:57:02 +0800
Message-Id: <20250218025705.50051-8-dinesh.maniyam@intel.com>
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

Picked linux i3c driver upstraming patch to fix the issue to
probe for i3c controller without slave device attached.
With this fix, the ret check will be on command error and will success
without slave device attached.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 024db9c2a3..cd238777b9 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -455,6 +455,9 @@ static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
 
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
@@ -510,6 +513,9 @@ static int i3c_master_enec_disec_locked(struct i3c_master_controller *master,
 	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
-- 
2.26.2

