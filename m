Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB38CD6E64
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 13:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB69786E10;
	Wed, 11 Oct 2023 15:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4352986C33; Wed, 11 Oct 2023 15:06:42 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C71986DDA
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 15:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp78t1697029554t98dvxiq
Received: from ubuntu.. ( [111.196.129.4]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 21:05:53 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: LE7C6P2vL8TZV8QblF16D/+QiufXaBsf1Y+qoqck48pGDIfurkT4NVw02G4p+
 0WN3d4CRgUQjcYEjSTrs22sZp+O5jJx4mSibsOq86TxHw7RW0MO+wkyCjZKvWG4C5nXgU9w
 zB32iT8Qju6e96RIAP3AHcACYhLA9sZNfS2DQRoZdU/SOKqTCRNzBE/5NjStOXwyEdkjtHG
 TCnB8PE+pwyhKJX4ZiWldMDOa+k8Ln77UAs4H7gs2yuFJOnwdu8+BCH11NmlBko4kIb+hTM
 QSK4WDJ5JqmBNXus6PrjnJfk2DyCGb7SZZbINQVqepY9AQK0KmkGVWMbvb8kysjK/16N0Nq
 SNdmNDf8ywJK6zcUwNEBEdQM5KZ5enTh15Hb2Ws
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14860838997727015007
From: Bin Meng <bmeng@tinylab.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Subject: [PATCH 6/9] ufs: Allow mmio registers on the PCI bus
Date: Wed, 11 Oct 2023 21:05:32 +0800
Message-Id: <20231011130535.3964-7-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011130535.3964-1-bmeng@tinylab.org>
References: <20231011130535.3964-1-bmeng@tinylab.org>
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

Check if the UFS controller is on the PCI bus, and get its register
base address accordingly.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 drivers/ufs/ufs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 96801866d3..fb2a607ef1 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1914,6 +1914,7 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	struct ufs_hba *hba = dev_get_uclass_priv(ufs_dev);
 	struct scsi_plat *scsi_plat;
 	struct udevice *scsi_dev;
+	void __iomem *mmio_base;
 	int err;
 
 	device_find_first_child(ufs_dev, &scsi_dev);
@@ -1927,7 +1928,14 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 
 	hba->dev = ufs_dev;
 	hba->ops = hba_ops;
-	hba->mmio_base = dev_read_addr_ptr(ufs_dev);
+
+	if (device_is_on_pci_bus(ufs_dev)) {
+		mmio_base = dm_pci_map_bar(ufs_dev, PCI_BASE_ADDRESS_0, 0, 0,
+					   PCI_REGION_TYPE, PCI_REGION_MEM);
+	} else {
+		mmio_base = dev_read_addr_ptr(ufs_dev);
+	}
+	hba->mmio_base = mmio_base;
 
 	/* Set descriptor lengths to specification defaults */
 	ufshcd_def_desc_sizes(hba);
-- 
2.34.1

