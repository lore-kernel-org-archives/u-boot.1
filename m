Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A03CE8D46
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 125948908D;
	Thu, 19 Sep 2024 05:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XLjyfSnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A06889AE; Thu, 19 Sep 2024 05:56:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8966789095
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718178; x=1758254178;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7lz4BnAqWyWp+ehh3/fwqzwBFdUI1GofuBDRTZhbo3U=;
 b=XLjyfSnt3P3+0mk+GZf6wJGspJTiTM5Z0x+K3JQuayxw4XNGKxpiasst
 Gx7WphLVEtPzKZfpO47XSDw4Pu1ZoeimiqJledl6zqsh4aWobaJlhqWxw
 WAd/AVbgzSPu8vakpznL6rQnzNPYabQeGLFG+GWOdUk5ZjLPF5V7gmJNl
 aTG69h2Eh8u2nMvxcKmtoJRgekB3FyuLtqQcCZ9Ku8gPiszefwMwzdRt2
 UApUNS2g+YYvXDYdXd1HOIz+OK8kn6CP+s57WmPkPpAnybbsnvvoEFcrN
 P6fJvapTjhK4W/l/NHeeNfSPnxjai27PRMRFBu/XfdDKRPeGzpAzWZPY6 w==;
X-CSE-ConnectionGUID: zLZptKwbSCaIep4BgJorSQ==
X-CSE-MsgGUID: G6MgCb8oSligEClscBA/LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178045"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178045"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:56:17 -0700
X-CSE-ConnectionGUID: d1xRwenvSkWiDVDVBPq8+Q==
X-CSE-MsgGUID: e80tmM20TES2bjsuZ6gfTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253802"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:56:12 -0700
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 10/19] drivers: mtd: nand: cadence: Flush dma descriptor
Date: Thu, 19 Sep 2024 11:55:03 +0800
Message-Id: <20240919035512.13854-11-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240919035512.13854-1-dinesh.maniyam@intel.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
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

The patch is to ensure ddr memory is updated with the data from dcache,
This would help to ensure cdma always reading the latest dma descriptor
in ddr memory.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/cadence_nand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 108e1fa965..429a5e8017 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -429,6 +429,10 @@ cadence_nand_cdma_desc_prepare(struct cadence_nand_info *cadence,
 
 	cdma_desc->command_type = ctype;
 	cdma_desc->ctrl_data_ptr = ctrl_data_ptr;
+
+	flush_cache((dma_addr_t)cadence->cdma_desc,
+		    ROUND(sizeof(struct cadence_nand_cdma_desc),
+			  ARCH_DMA_MINALIGN));
 }
 
 static u8 cadence_nand_check_desc_error(struct cadence_nand_info *cadence,
-- 
2.26.2

