Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753C3C4725D
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 00:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91CE687B7F;
	Sat, 20 Jan 2024 01:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705710984;
	bh=uJem8QUhCPVdfrtEXLU+41pcsn5GCpnAXZhzqZuTOxE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qoUbv+EvYazPCJm5PCNGeEWZT+1ATtQZ7fByYdAU7pGAAc5MMVgCAg0iyxTJaVnwN
	 URwlIUAXftpu5NDFumS2A+jlcLnqR+HUf87nbi9oPzjkL3QhxLMAtYpeLVD0vOcNfw
	 kWiNqYF+WgfF3Cp6emBCagTxWFtV5Ms2lyzE0Q66bLMAONw4bonkawxGuv84DGGejy
	 oreK5DFSz/AwmAMTtSpa6O79ZY5KSuA53ZPqs4WsTHAf0bMA+wbl4qCYuvty5PWaZ7
	 bslvCa3tSQ+1+E7hahfM2Fob26mfsUtDWjhnQpyE4ONGyD7rJMUgS0dWixshXuXjc7
	 qNXA47E3tMVjg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1FA9F8793C;
 Sat, 20 Jan 2024 01:36:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705710983;
 bh=uJem8QUhCPVdfrtEXLU+41pcsn5GCpnAXZhzqZuTOxE=;
 h=From:To:Cc:Subject:Date:From;
 b=WfZ5g1n4mwGr0Er0NhTe5jTLA7xACukevo0u15zdFgxLTCHtalm9TeCfR1IOY4Xh/
 e0YXaAyhrak3UbJAa8p/KcaiHFImxz4pFd2Avs/bG02+rfioNhrEBCi2jsdp1EcXsY
 0EL4TBwM5sNDbZ8t+N3Fo/D7zFyDPqYNlvlvDbCE2Mxh+Ao+gGFXOpipVPwl8p4ySY
 AJtj1Xwl0C18ohZxilUdJUCx7ef+Ae1M7wXTHotX9OdWbPjAMreSpTfb2vl/aI+uiX
 Tmg15DNngSvaCUNc72ZBrEIBuJLADZ96v+tmbjDCQcT/QjtALXzBYTiKVrOh0Rksqi
 iLTNtWaB9N8Nw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
Subject: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
Date: Sat, 20 Jan 2024 01:35:58 +0100
Message-ID: <20240120003610.124981-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Linux 6.6.y with KASLR enabled would print the following message on boot:
"
KASLR disabled due to lack of seed
"
Enable the 'kaslrseed' command so a random number seed can be pulled
from CAAM and inserted into the /chosen node 'kaslr-seed' property of
Linux kernel DT before boot, thus letting KASLR work properly.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@denx.de>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
 configs/imx8mp_dhcom_pdk2_defconfig | 2 ++
 configs/imx8mp_dhcom_pdk3_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index 4f907ce00d0..23fb6272ad5 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -117,6 +117,7 @@ CONFIG_CMD_BOOTCOUNT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_GETTIME=y
+CONFIG_CMD_KASLRSEED=y
 CONFIG_CMD_SYSBOOT=y
 CONFIG_CMD_UUID=y
 CONFIG_CMD_PMIC=y
@@ -223,6 +224,7 @@ CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_SPL_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_M41T62=y
 CONFIG_CONS_INDEX=2
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index 9972e2d96b6..0d47c12b1f9 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -119,6 +119,7 @@ CONFIG_CMD_BOOTCOUNT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_GETTIME=y
+CONFIG_CMD_KASLRSEED=y
 CONFIG_CMD_SYSBOOT=y
 CONFIG_CMD_UUID=y
 CONFIG_CMD_PMIC=y
@@ -228,6 +229,7 @@ CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_SPL_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_M41T62=y
 CONFIG_CONS_INDEX=2
-- 
2.43.0

