Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FA5C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3FC980756;
	Fri, 17 Jan 2025 15:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Luoj5x4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11BC7806D8; Fri, 17 Jan 2025 07:33:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E34780312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 07:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737095628; x=1768631628;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wjRVyHc/nYaY5Rx7WJ+RryAR0tn5AYG8ZcrTu2FO1RY=;
 b=Luoj5x4YUnGfeOQcjBdd+UeQbNGPejxXJveo6dh38OdJN46ThEfLSoi4
 vsGU6V+0c2AyQt/MEIr/7SWUsC7g/BxQtSC7XM3OF7ad5w2oX3j4gCiAw
 0Awp1U9ivgyNWTGXK2LWIOL8ABr/LpFJQZsNFw8bZEW7KWLuuTkrGgdMU
 LLKJfaPJ2YTUW9olBBkDEi2MT7e8hUuHXofndVauyeZ1ZnPLg+Xq/ocbL
 YCQyiWI8yOPc9BAUWpJ73XTLk+znA6kUPjFZKfQV+B48gRugkygPZhEXF
 qFmkNqeGLiJ6iOJR/kvGlSnDkL4nHihvlMEaCJNYyCpifngIKgtRK4YL7 g==;
X-CSE-ConnectionGUID: LAa/k1G6SQy774+esKbIMg==
X-CSE-MsgGUID: NkvoaX4PT+Sk71SGVkJWUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="54928869"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="54928869"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 22:33:46 -0800
X-CSE-ConnectionGUID: WdMVKsL8T0em5TSko/SDSQ==
X-CSE-MsgGUID: hzaDzwOUT/+HnXJ5lWFW6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="136567685"
Received: from apgcp0d551112.png.altera.com ([10.244.77.50])
 by orviesa002.jf.intel.com with ESMTP; 16 Jan 2025 22:33:42 -0800
From: Boon Khai Ng <boon.khai.ng@intel.com>
To: Uboot Open List <u-boot@lists.denx.de>
Cc: Tien Fong Chee <tien.fong.chee@intel.com>,
 Kok Kiang Hea <kok.kiang.hea@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>, Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [mailbox error message v1 0/1] Ehancement proposal for improved FPGA
 Configuration Error Reporting
Date: Fri, 17 Jan 2025 14:33:30 +0800
Message-Id: <20250117063331.13890-1-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:26 +0100
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

Enhancing the FPGA configuration workflow to increase 
the visibility into the FPGA configuration process and help streamline
troubleshooting efforts for the users.

Currently, when an FPGA core image is loaded in U-Boot using the 
fpga load command, success messages are issued, but
unsuccessful configurations do not return any helpful messages.
This lack of feedback leaves users in the dark regarding the
nature of the failure, making it challenging to quickly identify
and resolve issues.

To address this gap, I propose this patch that allows querying
the SDM configuration status and reporting any errors detected
by the SDM during FPGA configuration. This enhancement will
provide valuable insights into the configuration process.

Boon Khai Ng (1):
  fpga: intel_sdm_mb: add support for query SDM config error and status

 .../mach-socfpga/include/mach/mailbox_s10.h   | 218 ++++++
 drivers/fpga/intel_sdm_mb.c                   | 641 +++++++++++++++++-
 2 files changed, 852 insertions(+), 7 deletions(-)

-- 
2.26.2

