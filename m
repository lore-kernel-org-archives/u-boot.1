Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3F7C18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 189D681113;
	Wed, 26 Feb 2025 17:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BWuceIT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1AB68004F; Wed, 26 Feb 2025 17:20:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E01810F4
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586830; x=1772122830;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HTmnL3WoMQ7EBTSdXkPNliAK9yWKK2eTouxB6ZTTd9A=;
 b=BWuceIT7xfP7QEp0LZgBNaZxv6dl7glYiB7ew0akuwCasPUTnaaKZF1l
 NPNIuRvJRR7UXpq0uZKXjC/5tVxqKa01iNVkukNBa2vMvWnFhrg0vz6Ax
 IQIVQ7127n6oNnvMJgJ/IAzl5vNryHrEBj+nDgTl0vAZv69JT4nkdkIpq
 jfCDC5EdeDTALy04jIGoLgM55WAVKOrkiq0VwClgO2tqLOgSdLjeQwc65
 s4EtexNF6UAARtmvjxN1nJlsgVGwOyEmFeYLo7jNrhVTX2tRwGpVpMjBf
 DSMWDjQ6yjE/ILjVXA/6i4yIpdGlNEs0GjQDTm1pff0HKlUFag7VHByMY g==;
X-CSE-ConnectionGUID: YnWrGC50QGO5Q7ydnjO4/Q==
X-CSE-MsgGUID: aE5vWaNER8i3kp8D15kUpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640291"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640291"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:20:29 -0800
X-CSE-ConnectionGUID: 46IlYb+XSiW66HMT43MAUQ==
X-CSE-MsgGUID: 2gm21PERTY24I5Tgp7Fd1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602868"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:20:24 -0800
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
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [resend v3 19/19] drivers: mtd: nand: Kconfig: Enabled self-init for
 cdns-nand SPL
Date: Thu, 27 Feb 2025 00:18:33 +0800
Message-Id: <20250226161833.53689-20-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20250226161833.53689-1-dinesh.maniyam@intel.com>
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
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

Enable SPL_SYS_NAND_SELF_INIT for Cadence NAND SPL.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 drivers/mtd/nand/raw/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 2ede732204..76d14a3447 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -211,6 +211,7 @@ config NAND_CADENCE
 	bool "Support Cadence NAND controller as a DT device"
 	depends on OF_CONTROL && DM_MTD
 	select SYS_NAND_SELF_INIT
+	select SPL_SYS_NAND_SELF_INIT
 	imply CMD_NAND
 	help
 	  Enable the driver for NAND flash on platforms using a Cadence NAND
-- 
2.19.0

