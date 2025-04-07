Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D0AC36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45E9830D0;
	Mon,  7 Apr 2025 20:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D16682E68; Mon,  7 Apr 2025 15:22:21 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D8B82EA4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=u/I6=WZ=oss.qualcomm.com=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 43CB3441F5;
 Mon,  7 Apr 2025 13:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF533C4CEE7;
 Mon,  7 Apr 2025 13:22:15 +0000 (UTC)
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 2/2] qcom_defconfig: Disable MMC HS200 mode support
Date: Mon,  7 Apr 2025 18:51:57 +0530
Message-ID: <20250407132157.34628-3-sumit.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407132157.34628-1-sumit.garg@oss.qualcomm.com>
References: <20250407132157.34628-1-sumit.garg@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Apr 2025 20:15:00 +0200
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

Currently the msm_sdhci doesn't yet support DLL configurations which are
required to enable bus speeds greater that 100MHz. So disable HS200 mode
support as of now as it requires bus speeds of 200MHz.

This should fix eMMC issues reported on RB1.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index a2b54b95f19..537806450dc 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -81,7 +81,6 @@ CONFIG_QCOM_HYP_SMMU=y
 CONFIG_MISC=y
 CONFIG_NVMEM=y
 CONFIG_I2C_EEPROM=y
-CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
-- 
2.43.0

