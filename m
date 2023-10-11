Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73678CD6E5E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 11:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C09086D86;
	Wed, 11 Oct 2023 13:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 595BE86BDB; Wed, 11 Oct 2023 13:04:12 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 by phobos.denx.de (Postfix) with SMTP id E722286D86
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 13:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp80t1697022053trerh8cd
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 19:00:52 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: 6TsEncM2xqhCkL+GtQLvADG+bcwNUS9eVnSK0XA8oFa5swRGpIIB2LYdkNW2W
 +MGS+nN5bTX2SqsHhlJnABoQjdety4WnjucZzNPow60EHbbb2+oOjYROFZTdkRq0OBsVRdT
 QAaavKbvu7bKBXx4ZYeYvk0+K5/y3LsOx05b+OKiOxEhsJcfS3Z0CBHdpOBZccr+yuqf/wG
 eCucHeFt4LuPyY2q4iagA1vcYVEXvyofryp4l9ZR6a4Z4zUL+oAfq1lJL0VhA4vD9h1A/BI
 biFop7T/jTOuAB+FZDeWMQzG7wbF567YLVNoQjzEcIQ4cxGnYkUMaKb4LdRywNKTVbuqvK4
 RaSL0i0c8k2y6qpB8E61nBn+ir0O+Pmxv9wMTU2
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15850106743509373208
From: Bin Meng <bmeng@tinylab.org>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] mmc: pci: Drop the superfluous cast
Date: Wed, 11 Oct 2023 19:00:52 +0800
Message-Id: <20231011110052.2958231-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

dm_pci_map_bar() return a value of (void *) already, hence no need
to cast it again before assigning to host->ioaddr.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 drivers/mmc/pci_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/pci_mmc.c b/drivers/mmc/pci_mmc.c
index 9fb7044029..4d163ccba0 100644
--- a/drivers/mmc/pci_mmc.c
+++ b/drivers/mmc/pci_mmc.c
@@ -50,8 +50,8 @@ static int pci_mmc_probe(struct udevice *dev)
 	desc = mmc_get_blk_desc(&plat->mmc);
 	desc->removable = !(plat->cfg.host_caps & MMC_CAP_NONREMOVABLE);
 
-	host->ioaddr = (void *)dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0, PCI_REGION_TYPE,
-					      PCI_REGION_MEM);
+	host->ioaddr = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0,
+				      PCI_REGION_TYPE, PCI_REGION_MEM);
 	host->name = dev->name;
 	host->cd_gpio = priv->cd_gpio;
 	host->mmc = &plat->mmc;
-- 
2.34.1

