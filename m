Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8094FC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 01:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2355865A8;
	Sat,  2 Dec 2023 02:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701482200;
	bh=lAv1m6LrK47ehob03nSAyvlE9+imnpdAKbWLwxY+EPo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VW5c038dwONH97aIxSLiTGmj+PuYFAEqT9d6q3LVCPvBEPUx7PXICKTFKS3qIFQli
	 FLYNUuE4DLNjQCMqCX9HUQkR7jlCXlWUsq9wj+cqCiPn1107zzEi8Aft570vNa4Yap
	 urY5RY0Bpd5Me9cmU9Qv1sGpN6MHhVrHDUBOt52rVVdZap8tbaHq+k2zYn4F9RnQd8
	 858y2kBlqyMJRjIMYEEUNUTgTeFxkkhhArMjMaiD34TfatPqP6+XHUiTyFHN86vaBR
	 EgOveC+aumGU8DZX1u+HuSdo/xx4m7l9+SxtD11JRPbExiyY/jPteHd/FGDkvQcPpj
	 ItfmVKAJt8X1A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2F4FF85E44;
 Sat,  2 Dec 2023 02:56:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701482199;
 bh=lAv1m6LrK47ehob03nSAyvlE9+imnpdAKbWLwxY+EPo=;
 h=From:To:Cc:Subject:Date:From;
 b=JBSIdnT+nwvk1vNqTMN0w0HMo74rZTXLQvA51Fhf3/Hg6Lbgaa4qu4PczYOrrEQqO
 9YfS0YdB13aGmTSVY75BV8bKud9n6k5tNPaH2T9S1eVXwkAkArigrulyCeOEiBXT6O
 Yt590uUT5aCQzETvifjHgyrFzxCYu4jbZSaUS+igR5Gqzl4dNeEJXq6SRiqWANngMh
 g4Bdawe1jeLAqr9CMhnYWxAboqnN937QtfjiT/uc6ijM9g1216b2WEWzxdCYEh2Hn5
 vs9GdalcSwFzvx3lIczBuwvDjaUZZ0T3La5goYoYfiMfOPA3MZSc6mQCXFHkGmvem+
 yPAdFbEnMtc7g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: imx: Enable CAAM on Data Modul i.MX8M Mini/Plus eDM SBC
Date: Sat,  2 Dec 2023 02:55:06 +0100
Message-ID: <20231202015620.213638-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

Enable CAAM in U-Boot to make crypto available early in the boot process.

This has a side-effect that in case an older kernel version contains a
broken CAAM initialization timeout code, initialization in bootloader
will help that old kernel version function correctly.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
---
 configs/imx8mm_data_modul_edm_sbc_defconfig | 1 +
 configs/imx8mp_data_modul_edm_sbc_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index e724607c6ee..06e10869bc1 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -157,6 +157,7 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_FSL_CAAM=y
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index ae1a48c6812..30f8636f4d5 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -164,6 +164,7 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
+CONFIG_FSL_CAAM=y
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
-- 
2.42.0

