Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7D3C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 13:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E78E87CDC;
	Wed,  7 Feb 2024 14:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="A992Ygn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBC9087CE6; Wed,  7 Feb 2024 14:12:10 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42E287C9A
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 14:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=276722ad61=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 417BEKeI002836; Wed, 7 Feb 2024 14:12:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=Aq1J7L9
 DSppoDJjHI2LFS8ZtQgG1yTMyfYz1H4TO8eg=; b=A992Ygn2JFcemmGa9ZPLczs
 68eXDU89rE5bwJA1CnezmzoXc59I+3y2uzXSvENs2fOWUas2otmyjTe5OcmYKxqE
 X4OB94tognUq0x1TH0l8nbr5DlWaCVcgEUVlVS7eke9xSI6t7xka9z+WWdXrrIsK
 VDG3yXFyVlD4H03nuzj1WFbYsrRIbONEcYiXluD8WSKMwzdg7n8k+mrIQIhKiyr4
 b1xd5ApxLvAlJC8Y1hYhFyv/6xrc4Nak3LR7yiKvFJhUuBy1qEHtlhM6uiI1agBb
 ygKyVQtS7LYAGS30BLXNrOPBqULglCXCO6//6Ih0MSPjPtZTqNnH8yMC2gE+Cpw=
 =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w21ap5nxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 14:12:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B9A04100056;
 Wed,  7 Feb 2024 14:12:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AD530247040;
 Wed,  7 Feb 2024 14:12:05 +0100 (CET)
Received: from localhost (10.201.22.165) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 7 Feb
 2024 14:12:05 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] stm32mp: cmd_stm32prog: add dependencies with
 USB_GADGET_DOWNLOAD
Date: Wed, 7 Feb 2024 14:12:01 +0100
Message-ID: <20240207141154.1.If0aa2d32c2ffde32ed1d87ab8a088db67bc2d25c@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
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

This patch avoids compilation issue when CONFIG_USB_GADGET is deactivated
in defconfig, with undefined reference to run_usb_dnl_gadget and to
g_dnl_set_product.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
index 8f91db4b46b9..589276282e44 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
@@ -17,6 +17,7 @@ config CMD_STM32PROG
 config CMD_STM32PROG_USB
 	bool "support stm32prog over USB"
 	depends on CMD_STM32PROG
+	depends on USB_GADGET_DOWNLOAD
 	default y
 	help
 		activate the command "stm32prog usb" for STM32MP soc family
-- 
2.25.1

