Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17A3C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED92283A22;
	Thu, 10 Apr 2025 10:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OEdZs3/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF71283A2D; Thu, 10 Apr 2025 10:00:45 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57D083A1E
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 216A3A499E6;
 Thu, 10 Apr 2025 07:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD315C4CEE3;
 Thu, 10 Apr 2025 08:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744272042;
 bh=TO1KRzc+cXf2doL0Dy1GfkSg07JnAaVHdNKASrzZ00k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OEdZs3/wMTdrOn6dG/bWFOVnPu2uzce07Czj2yz+NrXJAbDO/PbNEn5zDjZQFrJeh
 loByIETFuHn4ZPegDjJLFWpiVsZ6d94pOxaPq6DWYV5Z9de0y2Kd8iyMHq1myaUnai
 3w6YD+wdPiVAg+WUZGhA3wqU6nIE7KVc/pVMffynJiLUnvDICHC0AQmFAcGx4XEI6Y
 VeyXUQvtKXVfoSHd4dHIlsyp1LWDC1T3+ObIopevzdG20DJVEUwmFq9ZRj7bB1Qntq
 Q0bqBGiPqopR2OLtLtaTdX12v3iVqS/dwoOzAurdOzhQyJYBigoPtGWTyUwQ1MKAKq
 oiLyaRYF/VVUw==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 alexeymin@postmarketos.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 1/2] qcom_defconfig: Disable MMC HS200 mode support
Date: Thu, 10 Apr 2025 13:30:26 +0530
Message-ID: <20250410080027.208674-2-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410080027.208674-1-sumit.garg@kernel.org>
References: <20250410080027.208674-1-sumit.garg@kernel.org>
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

This should fix eMMC issues reported on RB1/RB2 although it should fix
issues for all Qcom platforms but it's not seen there as mostly SD cards
available don't support HS200 mode. The SD cards usually works in high
speed mode whose performance remains unaffected by this change. It only
affects RB1/RB2 as eMMC flash on these support HS200 mode but the U-Boot
driver currently is incapable of supporting that.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
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

