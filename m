Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F61DC47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 14:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB5B87864;
	Mon, 22 Jan 2024 15:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705935377;
	bh=Wo2u6MUV0dCQV/Vj7OPn/YfK/ZQt69cp8/hVt9m2th4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hnd4X0AFL55/VhRKilbfYTb+loH+A20UG6UxLWHg/TKjsvDPGwTIeFq9cllARYC5d
	 Ewx1HrVvfdiwpzA2AVu9jkjgZFiQhFTlkA/NIzS/6ep8lQlY3wlx8Q4ScnVySo5jqz
	 n//gjj3cVsz406Sv3a+xY6l/zoIbS4YVQwhU3fCDD69GBJajmkckdruM92chKvibD9
	 zc8AI26rZjPfGqxsfP0m2B9FjLoQ0+020Q05O6oKI1pvV4dnzSKamALjYeCb4Dxh+u
	 y+Mn/B2mrfubGsVhkvxzIrMELYmTUDGlJHceRV2kYNaMyot+WyC6qQAk2N/gDBFSPS
	 njAFOundnsZKQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C9DF387872;
 Mon, 22 Jan 2024 15:56:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705935376;
 bh=Wo2u6MUV0dCQV/Vj7OPn/YfK/ZQt69cp8/hVt9m2th4=;
 h=From:To:Cc:Subject:Date:From;
 b=SfcJQUV5JcXKqtfEdjk9XuVcxnFwOzR1pNaN2TbT/V1dXJ5hV1lS2g8BeqjTYQvml
 GLr+wQh6OPHgAjcyJHyuDsBAgUW1aCnozAbGqRSUrMOpmj1ecSOAtEq3ut/Aq8ck8B
 haVNDvlsS9mIO58OmgEHtrzcUUL37w5quFXWK8BlcxnTa2Wgxux0GnT5B2xDCfhYvB
 HK78AWWBYpirpIEKlrUsb6dNYpUE4zL5XPjn/3oUMai7tUwhlrVY5T8A6WaeH8DXrD
 ordeYtjTBK+ziMKCIWBXZn5+dMwHVIGcynp25eXKy7b3UO8zsnwn+N7otGbbQkeZTt
 nmSjqEi948Unw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: imx: Enable kaslrseed command on Data Modul i.MX8M
 Mini/Plus eDM SBC
Date: Mon, 22 Jan 2024 15:55:48 +0100
Message-ID: <20240122145604.171415-1-marex@denx.de>
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
---
 configs/imx8mm_data_modul_edm_sbc_defconfig | 2 ++
 configs/imx8mp_data_modul_edm_sbc_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index f945aea82d7..bbd6ac053ba 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -115,6 +115,7 @@ CONFIG_CMD_BOOTCOUNT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_GETTIME=y
+CONFIG_CMD_KASLRSEED=y
 CONFIG_CMD_SYSBOOT=y
 CONFIG_CMD_UUID=y
 CONFIG_CMD_PMIC=y
@@ -210,6 +211,7 @@ CONFIG_DM_REGULATOR_BD71837=y
 CONFIG_SPL_DM_REGULATOR_BD71837=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_M41T62=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index d29bc986267..a3e25ea22ab 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -122,6 +122,7 @@ CONFIG_CMD_BOOTCOUNT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_GETTIME=y
+CONFIG_CMD_KASLRSEED=y
 CONFIG_CMD_SYSBOOT=y
 CONFIG_CMD_UUID=y
 CONFIG_CMD_PMIC=y
@@ -229,6 +230,7 @@ CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_SPL_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_M41T62=y
 CONFIG_DM_SERIAL=y
-- 
2.43.0

