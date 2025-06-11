Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF701C61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B7D82B63;
	Wed, 11 Jun 2025 14:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=amazon.com header.i=@amazon.com header.b="Nf2hLJxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA3782B20; Wed, 11 Jun 2025 07:01:45 +0200 (CEST)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0255A80050
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 07:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=amazon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prvs=250aed5e3=ipman@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1749618104; x=1781154104;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xyYql2OhagdNWHZSmtiqnq2ffJyYHQa9V39zW5c1LGo=;
 b=Nf2hLJxxO5grykwhKTwMDM53bcBfOfqPCVRpYiHT4UrpvRDExZmwaOBY
 Ypc9WUQfyUCDfbiA+i95vphTf/BxshQKtLTGaNmLCnEs1SAEUW6VTL/XZ
 C4sbls2rWUvciUBT8EjrAPFI7mBPSbZpVWY+olAIDQhABDFxmjESsAZa2
 +ksBi8zKer3ubaVG3eQEbIrtuAZcdJHG5Pzwew4t4/thExvtaKjDO1NcZ
 EkEyzwqc64paCmxmkCV2R1GkNHCmPcbCi2d4wjyLfvBDsDnpHf3YY36p9
 KNz6mjn8JOR0BeCUFe6TfVKhFQiT1vYzjEndmjBf333QFrW6EduQDknht Q==;
X-IronPort-AV: E=Sophos;i="6.16,227,1744070400"; d="scan'208";a="500295249"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-6001.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:01:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:59281]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.42:2525]
 with esmtp (Farcaster)
 id 628813f0-7d2e-4143-8992-cd90caa73467; Wed, 11 Jun 2025 05:01:40 +0000 (UTC)
X-Farcaster-Flow-ID: 628813f0-7d2e-4143-8992-cd90caa73467
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 05:01:39 +0000
Received: from dev-dsk-ipman-2a-ee5dfd20.us-west-2.amazon.com (10.2.12.57) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 05:01:39 +0000
From: Ivan Pang <ipman@amazon.com>
To: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
CC: Ivan Pang <ipman@amazon.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v1] dfu: fix dev_part_str for file operations
Date: Wed, 11 Jun 2025 05:00:38 +0000
Message-ID: <20250611050127.38011-1-ipman@amazon.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.2.12.57]
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Mailman-Approved-At: Wed, 11 Jun 2025 14:37:25 +0200
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

The third_arg for a dfu alt is read as an integer and is overloaded for
different supported backends. For ext4 and fat, this third_arg
represents the partition and forms the dev part string, which should
have its partition in hex. This commit fixes dfu ext4/fat usage for
devices with ten or more partitions.

Signed-off-by: Ivan Pang <ipman@amazon.com>
---

 drivers/dfu/dfu_mmc.c  | 2 +-
 drivers/dfu/dfu_scsi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
index c19eb919388..a91671755e1 100644
--- a/drivers/dfu/dfu_mmc.c
+++ b/drivers/dfu/dfu_mmc.c
@@ -117,7 +117,7 @@ static int mmc_file_op(enum dfu_op op, struct dfu_entity *dfu,
 		return -1;
 	}
 
-	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d",
+	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%x",
 		 dfu->data.mmc.dev, dfu->data.mmc.part);
 
 	ret = fs_set_blk_dev("mmc", dev_part_str, fstype);
diff --git a/drivers/dfu/dfu_scsi.c b/drivers/dfu/dfu_scsi.c
index 9f95194784c..7ec34a8f7e3 100644
--- a/drivers/dfu/dfu_scsi.c
+++ b/drivers/dfu/dfu_scsi.c
@@ -96,7 +96,7 @@ static int scsi_file_op(enum dfu_op op, struct dfu_entity *dfu, u64 offset, void
 		return -1;
 	}
 
-	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d", dfu->data.scsi.dev,
+	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%x", dfu->data.scsi.dev,
 		 dfu->data.scsi.part);
 
 	ret = fs_set_blk_dev("scsi", dev_part_str, fstype);
-- 
2.47.1

