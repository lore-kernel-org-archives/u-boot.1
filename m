Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB700C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FA3060748;
	Sun, 23 Aug 2026 19:48:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NVsnVBtXJEj4; Sun, 23 Aug 2026 19:48:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787514525;
	bh=g4A9ubsGVDuC+LIaJL15PDQvIcoFY23VceOzTTl+xrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AWKXeEbfL8r60WMUh3J/EjqaEiweH0cSOxLxWs+JGGm1WIeb4B2DC+1A7WqeAG7LQ
	 noB/LKJFn/tLOvHcpM/Vzc8Dpii1KevQXcgY8jkKqqdmOpgeYSpDE/MU23I3OwxM8J
	 GGlLWixR9SUqALiBAsqWONGlsGrWuVS5GtuCn8Fs6hOAAvy2jgR1T8ub2qg6lUjNKR
	 T37BFtd58a6mokjWRSkv+kutDD3ikZw828FliMhq+BXNP6OwKr0kahFDKjjXcRfupK
	 MO5rixm6RqiXHkch+0TOJ9NFcBo4FN+aNToHOcFE/V3rSBAHT+rZGnRX6bQuzPYkcR
	 MMw9w+h6RjnSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB132606C5;
	Sun, 23 Aug 2026 19:48:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A675336
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8197E40528
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBZmtuv--eDY for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:48:37 +0000 (UTC)
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 23 Aug 2026 19:48:35 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=OzqJHxwe
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.225;
 helo=mta-64-225.siemens.flowmailer.net;
 envelope-from=fm-294854-202608231947292a2e4294dc000207c3-lnahow@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 88D4040538
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:34 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202608231947292a2e4294dc000207c3
 for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 21:47:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=g4A9ubsGVDuC+LIaJL15PDQvIcoFY23VceOzTTl+xrM=;
 b=OzqJHxweq+iw/UwLtqrqL2PYn1n45Mgg9CAlvs5xL8pIgXyowKcn88oqI8WClkWMpA93Mr
 uEZxgRTufowwsbwcVcR/Yqks16dbCrluIBLl5qS6VhT1VwK/Cr7Yur/Ra6BxcHOkkgWe3CCR
 XwohIGJOq7id7bWEbPiIFsLFwoslQYVgoEV5Va2CWqu7XM2P6y5Wxy9ilP2yPBmg8WXM44zV
 kWcSVu+t9D5ndB4G42rqkonZSfMGFVjpJeKggyu5mgYzWGmRbTRLJ0eV/i0K02Xy6XUb3ceD
 Rb0pndGh6EL5pdO/z/3mzfXaQO1nJxzgmxTxWAPeOquic66nGQqh5xXQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 5/5] mmc: Make "MMC Device not found" a debug output
Date: Sun, 23 Aug 2026 21:47:26 +0200
Message-ID: <57a99d87a25d42f68f26697b81fafefcae29abad.1787514446.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787514446.git.jan.kiszka@siemens.com>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Callers of find_mmc_device are generally processing and informing about
errors already, e.g.

=> mmc dev 2
MMC Device 2 not found
no mmc device at slot 2

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
CC: Peng Fan <peng.fan@nxp.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/mmc-uclass.c | 2 +-
 drivers/mmc/mmc_legacy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 698530088fe..ec16899f92e 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -319,7 +319,7 @@ struct mmc *find_mmc_device(int dev_num)
 
 	if (ret) {
 #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-		printf("MMC Device %d not found\n", dev_num);
+		dev_dbg(dev, "MMC Device %d not found\n", dev_num);
 #endif
 		return NULL;
 	}
diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
index 8f8ba34be71..573521842f6 100644
--- a/drivers/mmc/mmc_legacy.c
+++ b/drivers/mmc/mmc_legacy.c
@@ -45,7 +45,7 @@ struct mmc *find_mmc_device(int dev_num)
 	}
 
 #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-	printf("MMC Device %d not found\n", dev_num);
+	dev_dbg(dev, "MMC Device %d not found\n", dev_num);
 #endif
 
 	return NULL;
-- 
2.47.3

