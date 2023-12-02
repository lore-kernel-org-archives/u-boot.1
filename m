Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB42C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 01:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 251058749E;
	Sat,  2 Dec 2023 02:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701482335;
	bh=IIaEH0pWYNB6sXECd8d5bDP7mnoccEJgp1+JBzhtpi8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Yb8EsaAdf/zTT5201S6X1BTM/fHWYbSApARhsN9uZhIWgEefZWUFTsKGrsYJ1qFqM
	 Vwt8YVxc6y1Z+DLvQtQOjyUO1h4EHisbQJg1EkVgI5p7m5/qKS0SyvAvi04hC9JPQr
	 16hRPEJIRaJGnr0qlVKFT5bq1SNDSzETv02cgw89PMvXhD7oGfMwOBqShNdaouAGg8
	 yNdZYWvoeoFJOZD3UneVZDqE3+Rr1a9HgsZG7np2y0sNdPD5DY6L+pa61lYVdRwlt1
	 BMHjCYEQF5wHNCjUHGmgr4zK3V/4J2gbp4Ix0KqIKlBwvXI6gwKRl7rQJc6GGf08uI
	 MzRmmw0vLTeXQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 52CDA865A8;
 Sat,  2 Dec 2023 02:58:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701482334;
 bh=IIaEH0pWYNB6sXECd8d5bDP7mnoccEJgp1+JBzhtpi8=;
 h=From:To:Cc:Subject:Date:From;
 b=mggOR3nn9x/HPLOHYLtZH6YyVpYR8hPeUJGD3D+c/WXqOigMD9opzaouZSkOw2yU4
 JsdDnfKHVXXLPgiPfVe87sfo+dIuHcKKesS6kSAYZFLe087UnkY/KfI9BVEmKdxUtm
 j3s3KfgMsfsXRyFKhOmDuTydX5ONWCqiOCJiYTt7mtKbS8FzRhcVGBF4DBlP6vo5Iz
 A4CQD5rGFSvHSjstI/kyragmuNGJfzvpYjPnaj58KRjU8Myx/hWPgC2AmYpNV4wvIE
 M/cmzMrSmeyEvRn5w8WawtCyWdYCKvlB0dF1MUEsjdXlgfGC2Sn0cMe2VRS9irGSK1
 H1p37mfdQU61g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH] ARM: imx: Enable CAAM on DH i.MX8M Plus DHCOM
Date: Sat,  2 Dec 2023 02:58:28 +0100
Message-ID: <20231202015839.213942-1-marex@denx.de>
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
Cc: u-boot@dh-electronics.com
---
 configs/imx8mp_dhcom_pdk2_defconfig | 1 +
 configs/imx8mp_dhcom_pdk3_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index 54c02dfd7ab..3f9b0e3733c 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -165,6 +165,7 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
+CONFIG_FSL_CAAM=y
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index 6799f0c8b73..50c21d51b8d 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -167,6 +167,7 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
+CONFIG_FSL_CAAM=y
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
-- 
2.42.0

