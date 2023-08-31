Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04940C83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8169F8660B;
	Thu, 31 Aug 2023 16:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693492913;
	bh=shxruqiQViriTJuh7UsttAJuwf8lwX7KC5lKZYuk8lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BMOsA0BwIeYV1Z47wmZ2U3K/zPKHO0ViPUYW1Woi1WDuR8v0I4B5ElbNYORvVxR9n
	 930QeKK3EdXoqsadxBbRip4NxuPqlgy6fsCabo9QDiFRU/DLMe1QlzLuwNz6sH4Z6T
	 wmCL07HLnkEdquKryrC//fa4Fvza/Heqnst5CF7XZBl0jUcohZ7f4vpUPbQ14h9WNC
	 rAWTkLkhr4OIYyqN8hsHGOiJT4jF9yF5s9vD1QSSGBcWd7C4I4kf6xEftb0Q2FW2M6
	 BY9ilEUm/MGxV7w2bN1rAi3ETln0IYlq3Wo+d7FhlnyFro9j5nNe/QQMOax7zIZ6zL
	 QurOu0ts0PGGw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4C42A865AD;
 Thu, 31 Aug 2023 16:41:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693492910;
 bh=shxruqiQViriTJuh7UsttAJuwf8lwX7KC5lKZYuk8lM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jj/aMurMS91Em6ti3yAvHTJvg0TJL1Ij8iJQJskoPiuSsW8RgtsbszZvOhQSz03/b
 GVql3H4jiFtniwsVsVkJ0Ec0F2g7R9doKwVYC/vc5JTi11WYtn+peL8+fTEgJYOl0k
 HgmiD1BGH/8CaZntjDLVoq3jmpEp3US8HuSpCTx17n1GUFtxFM/TEMufAESp1DCkkU
 OOXv4Fu82aatXvm+skeetRtKqBEy/9X72qQHvCzyHp9H+U6+wgmsIpqwoBhSxLPg4v
 Q7LgdQWVdVNi5Zp+y8wgaMXZGeXioczG+W3uBPgL0mFIJXcrERXge/lJm6zQhpwccn
 Hm49iVSziWYgA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH 2/2] ARM: imx: Use default SAVED_DRAM_TIMING_BASE on Data
 Modul i.MX8M Plus eDM SBC
Date: Thu, 31 Aug 2023 16:41:46 +0200
Message-Id: <20230831144146.78537-2-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230831144146.78537-1-marex@denx.de>
References: <20230831144146.78537-1-marex@denx.de>
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
 configs/imx8mp_data_modul_edm_sbc_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index 2ff577f2d8a..8b9d4b6c089 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -164,7 +164,6 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
-CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
-- 
2.40.1

