Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DC4C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F6CD87FBC;
	Tue, 20 Feb 2024 12:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="orMo+Ebs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AEF087D4D; Tue, 20 Feb 2024 11:36:16 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD9887F93
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rcNTi-00016a-8i; Tue, 20 Feb 2024 05:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=uck3KIVUrnsQLF5ErMqY2tkND5CaoDlZ02Lpb4iuBFg=; b=orMo+EbsPMgnrfxjGLww
 bVdKo2i4pfaNEyHysGRcZNeE8o+E02ktF5ZZmoPXBMMnaJOFpUz1KJklrZOJs0YSZi8naQLhid/Sl
 GK5TMP9cwpJH/9D/LRuOUkOHY34YLhsWVkwCP1ZuoLFvcH9myDR0tIXGAC+leLD3Q38PUxmnuXR+L
 WOJv+Ckos7F/4xzRQtxmCsNi6zKs1o0pVet0M+If782d8QuKBNaermPMg+P8DTd0HTuo7c1972Bfs
 6g1tXYHuBm+HSj1BMx4IwVbCaZLpD7JcpHIBa9plTup1aut5qQ46mSHCaSR1a6vSnZdaQhkTfp9b5
 ORxWkKp8gHCPNA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 5/5] configs: imx93_var_som: Add EFI support.
Date: Tue, 20 Feb 2024 11:35:06 +0100
Message-ID: <20240220103506.17218-6-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220103506.17218-1-othacehe@gnu.org>
References: <20240220103506.17218-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Feb 2024 12:03:24 +0100
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

Enable the `gpt` command and EFI partitions support.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 configs/imx93_var_som_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/imx93_var_som_defconfig b/configs/imx93_var_som_defconfig
index 60751a77037..a3f98abc161 100644
--- a/configs/imx93_var_som_defconfig
+++ b/configs/imx93_var_som_defconfig
@@ -78,6 +78,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
 CONFIG_CMD_TIME=y
+CONFIG_CMD_GPT=y
 CONFIG_CMD_GETTIME=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_REGULATOR=y
@@ -151,4 +152,5 @@ CONFIG_ULP_WATCHDOG=y
 CONFIG_WDT=y
 CONFIG_LZO=y
 CONFIG_BZIP2=y
-CONFIG_RSA=y
\ No newline at end of file
+CONFIG_RSA=y
+CONFIG_EFI_PARTITION=y
\ No newline at end of file
-- 
2.41.0

