Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF01C369A2
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 13:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCADF82D0C;
	Mon,  7 Apr 2025 15:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cwHlcaiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A6982EBE; Mon,  7 Apr 2025 15:28:41 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B3A82D0C
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EE36961130;
 Mon,  7 Apr 2025 13:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257CCC4CEE9;
 Mon,  7 Apr 2025 13:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744032518;
 bh=FdXppwwCxyXnxffb2hnoREyAKJ5p3Aq6k7ci8DFoz5g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cwHlcaiYdMRvhgVQIVo/hrWH9phPhWwBtZla49lUM7Nvnpij89mRWr1E9MjEYDANp
 0KyfOT13Nu+XDoOMmQIRCrZHZe2CI0f/7D88u5cvkG/rh+hylnLy3hFS5QWyHEcG0I
 VIM02oefvkT2u5Zv6qWWLzmAxHe+Vn8pSvHHTHKeNRIVwtR5YlbNpCDGgn/U+AmZuH
 D8jENCKLr+7Lbxy1yMLxWkWHlrWibQqJo+vUZ8ihSGr4xPE2CCm5bXhGDmrbqsoqjo
 qKowBaVBx0wjZyHoZ4OLC9wkCN496OWj22FQfjTX4nwBbZTBdElvnhQTeKKcbDzJXI
 Q4B2g0MLS7OUw==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 2/2] qcom_defconfig: Disable MMC HS200 mode support
Date: Mon,  7 Apr 2025 18:58:10 +0530
Message-ID: <20250407132810.35149-3-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407132810.35149-1-sumit.garg@kernel.org>
References: <20250407132810.35149-1-sumit.garg@kernel.org>
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

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

