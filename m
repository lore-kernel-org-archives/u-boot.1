Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45B7C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32B3865A5;
	Thu, 31 Aug 2023 16:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693492890;
	bh=Au5xB902VCX9Y4ONesBGo820AKaNHBW5EVBJ+47nZ4Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xT2loaHHhmKfjM57B0w4+enu1BCaGqbpqCeRrBYehQOxlKPVL/y2TSaRBNybY1XH9
	 VV4E/mru2433q6WWa8igogn4SbB/IJBA4X8lxo2QwxxN21MLlr2mug+cLDrspwqpBd
	 ZBcxLg+Y32dkTBmov+2LSj/hSzDM1+U+M9ItqbbaTiUAnqUSevGU1wXUKE8puSWxv7
	 eHmo4gYuINCAOUyRyci0h3Mml36fGZ9AJy07HLaSeSGT/2K0Hv4WnxhyMW0Q+iudWz
	 TB2G6/yPjMeIvlWvW0CqX0rwJRsgT9nLudnIDZljc6YZdqgbD2VjoaCaf9HnJowOha
	 jVR6lpanCmwnw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A6EBA86523;
 Thu, 31 Aug 2023 16:41:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693492889;
 bh=Au5xB902VCX9Y4ONesBGo820AKaNHBW5EVBJ+47nZ4Q=;
 h=From:To:Cc:Subject:Date:From;
 b=LOExdbcON5H/d+QDG5Mi2vM7zHBlZwEnmYguvhEofnXGBBtRrSYiUm3GXY35lMme5
 6IHEIAD1W5NhXKJG5KmGIQtLbsRNxq4fq2SjCpg9xQ0/Ijnth4W/FT3SFzoe2gxzOb
 img+8heGQUb3TN69Mtdw14FoTKMe7fjXGdYqcQEORRbMORG1oRbaqX5ogztPwM650j
 s3QPfR4krJkpyk3twoqt6MCk51U8SlOSGB/IW4IUYTY7z+TMCziTz+h0qRyAXpmppj
 yBRw/4NaLWHoAjHpOe/3htvqEMxTXAwcW+fHjo988zbKgjpH7+lPNgjyENQNdpitMw
 s0KqKRu8vCt7A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: imx: Use default SAVED_DRAM_TIMING_BASE on DH i.MX8M
 Plus DHCOM
Date: Thu, 31 Aug 2023 16:41:15 +0200
Message-Id: <20230831144115.78505-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
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

Use default SAVED_DRAM_TIMING_BASE as that is what upstream TFA expects.
Without this change, the board will fail to suspend/resume e.g. in Linux.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@denx.de>
---
 configs/imx8mp_dhcom_pdk2_defconfig | 1 -
 configs/imx8mp_dhcom_pdk3_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index 14ac499e587..a920ffe09bf 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -160,7 +160,6 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
-CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index 3b26f315bba..9463456798e 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -161,7 +161,6 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
-CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
-- 
2.40.1

