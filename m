Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543E3C28B2F
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 16:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD0EB81898;
	Wed, 12 Mar 2025 17:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C06E8169D; Wed, 12 Mar 2025 17:05:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F10FD8169D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 17:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=muhammad.hazim.izzat.zamri@altera.com
X-CSE-ConnectionGUID: 0mrwK32JSpiDzU86JqRXsQ==
X-CSE-MsgGUID: p0oBCGX6S62EISshKkbAwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="68241663"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="68241663"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 09:05:11 -0700
X-CSE-ConnectionGUID: Wp8LdOaST1KQp6YGgA6UCg==
X-CSE-MsgGUID: XRpcDuplQDK55CNZtBYSiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="120370814"
Received: from apgcp0d540107.png.altera.com ([10.244.77.29])
 by orviesa009.jf.intel.com with ESMTP; 12 Mar 2025 09:05:09 -0700
From: muhammad.hazim.izzat.zamri@altera.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Tingting Meng <tingting.meng@altera.com>
Subject: [PATCH v1 2/2] drivers: fpga: Follow mainline to pass compatible
 flags to fpga_load
Date: Thu, 13 Mar 2025 00:04:58 +0800
Message-Id: <20250312160458.13585-3-muhammad.hazim.izzat.zamri@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250312160458.13585-1-muhammad.hazim.izzat.zamri@altera.com>
References: <20250312160458.13585-1-muhammad.hazim.izzat.zamri@altera.com>
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

From: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>

Introducing additional flag to check whether an FPGA driver is able to
load a particular FPGA bitstream image.

Generally, flag variable is used to enable or disable certain features,
specify additional parameters (such as error handling), or modify how
the function operates.

Hence, in this function flags is an integer that can be used to pass
configuration options to the fpga_load function. Here, it's
initialized to 0, meaning no special options are enabled, but it could
modify the flags to influence the function's behavior.

Signed-off-by: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>
---
 drivers/fpga/altera.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
index 136ccfc2de..64fda3a307 100644
--- a/drivers/fpga/altera.c
+++ b/drivers/fpga/altera.c
@@ -70,8 +70,9 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 		       bitstream_type bstype)
 {
 	int ret_val;
+	int flags = 0;

-	ret_val = fpga_load(devnum, (void *)fpgadata, size, bstype);
+	ret_val = fpga_load(devnum, (void *)fpgadata, size, bstype, flags);

 	/*
 	 * Enable the HPS to FPGA bridges when FPGA load is completed
--
2.25.1

