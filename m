Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B4BC83F33
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 379F5865DA;
	Thu, 31 Aug 2023 16:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693492911;
	bh=Atu15Uck0IrFwmNaTulrBsYKnSRJD432tazJBpN0rQg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sTmjXKb9ZBJbY10DnrbyOadCWQ9rSvLknW8q64i4v1iJwVXkjNQaz6KspjXtrds/S
	 Li/PpkFxaZzm15+FaxFgf27JR4gVW+ZV2JIWxjer6PNqYzg/xeea1ELh1094wdHELO
	 qXxESrCG948pD8OfzixKncyhhm3NyeAw1uWPCDZxPiL6wobmWJeNesaIH8Yk/mAKYO
	 MOrWoQkfy0Q8bEDfYRDmULpIirfgjZh+cVDoCKOWmdez1IPuTefRbEDt3zJG8oKycj
	 lmpQyNehmGxlBOnYayjxegoQQ1TYJ09bBTIFVqwDfK4IdHu+RWcXJXjMhorTTqZhMo
	 TjwSIoJ9lTrqw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E8454865AB;
 Thu, 31 Aug 2023 16:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693492910;
 bh=Atu15Uck0IrFwmNaTulrBsYKnSRJD432tazJBpN0rQg=;
 h=From:To:Cc:Subject:Date:From;
 b=WPo4dRMHnK30l3zmKKwSwoRquAU6hoNe30sii9ME/2bRG7QW0zK27//6zDSIN4m7y
 69xtl/u8IjL2XmmIjswfnOXqbtR3/xRcirS9u2j1BWS6K4inyg74OQjQ4RY+b64Uga
 FC4gjsZ3cjdsjLKpCftJPyneYJk9/Z8Vh8hTzhVRMZLhtofEAd3/f+vZ5Fdtib6NII
 mCRnSqRG3cmpkxMsC+Q/IgavE6U9B4fZ5pIbf5lTHWc9DezJk2EtUejXDQVAghh+v+
 BTo7wygzZU2X6Ev8OBV9Wu6jyVM0vM+5z+EiQvB/W9oLmmJIkHX+a+LVq5RmP+Ppe4
 L3zrL9dTvqhTQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH 1/2] ARM: imx: Use default SAVED_DRAM_TIMING_BASE on Data
 Modul i.MX8M Mini eDM SBC
Date: Thu, 31 Aug 2023 16:41:45 +0200
Message-Id: <20230831144146.78537-1-marex@denx.de>
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
 configs/imx8mm_data_modul_edm_sbc_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index d457f1e3c36..2de336e564c 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -157,7 +157,6 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
-CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
-- 
2.40.1

