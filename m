Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E37C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 14:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 685A88069D;
	Tue, 14 Jan 2025 15:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="G2e7okig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B01806C6; Tue, 14 Jan 2025 15:47:05 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CB278069D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 15:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=31090870d4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EB661c026646;
 Tue, 14 Jan 2025 15:46:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 mt+jnpuen9fBLyVWwfUDLzSJDpVyOYgMcFYDPSAj/L8=; b=G2e7okigucfvYgb9
 1Pl0iFttOR3Ens6Uj7xc1XMDBSPaYNXyPPcrPnx6FGWr74i6rDBF4Ls6BOio/Onm
 P3Bwu32BPCj7KAwocp4WYi0iX/CMgQ7olUHNxNkSJ6dX/z4FF5GhuUOBFu+UHmYg
 rPSnIqASu6CKyBY6Tc6GbpN1BDiiS7BVjlS9QpBoKGoobor9THiF69l3P6Q6qZ0b
 irjmVIatY6jZl0irl3YbYlzEgpy4W2Dgn38tl0hcxG1wQeQhUOXoq89oqPtUbnea
 OHrWqzOWG9ocRm5XY7seZ1oclQMvrU7XzoVOBodFh5AYSxXJyEp2OUy+ERj/Qplu
 dESmhA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 445prprutp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 15:46:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9867640044;
 Tue, 14 Jan 2025 15:46:02 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5CC022ABA77;
 Tue, 14 Jan 2025 15:45:36 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 14 Jan
 2025 15:45:36 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Sjoerd Simons
 <sjoerd@collabora.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/10] dw3-generic: Add dependencies whith SYSCON and REGMAP
Date: Tue, 14 Jan 2025 15:45:24 +0100
Message-ID: <20250114144528.1612168-7-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
References: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Since addition of STiH407 support in dwc3-generic, SYSCON and REGMAP
support are needed.

Add dependencies with SPL_REGMAP and SPL_SYSCON for:
qcm6490, imx8mp_evk, phycore-imx8mp, librem5, qcom,
xilinx_versal_net_virt, amd_versal2_virt, xilinx_zynqmp_kria
xilinx_zynqmp_virt.

Add dependencies with SPL_REGMAP and SPL_SYSCON for am57xx_hs_evm_usb.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marex@denx.de>
---

 drivers/usb/dwc3/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 0100723a68b..ef82a3e9626 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -26,6 +26,10 @@ config USB_DWC3_OMAP
 config USB_DWC3_GENERIC
 	bool "Generic implementation of a DWC3 wrapper (aka dwc3 glue)"
 	depends on DM_USB && USB_DWC3 && MISC
+	select SPL_REGMAP if SPL
+	select SPL_SYSCON if SPL
+	select REGMAP
+	select SYSCON
 	help
 	  Select this for Xilinx ZynqMP and similar Platforms.
 	  This wrapper supports Host and Peripheral operation modes.
-- 
2.25.1

