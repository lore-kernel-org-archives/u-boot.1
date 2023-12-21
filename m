Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE459C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA9CB878A2;
	Thu, 21 Dec 2023 17:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=loiseau.fr header.i=@loiseau.fr header.b="OnfauDY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52EC87860; Thu, 21 Dec 2023 17:00:14 +0100 (CET)
Received: from try.jabatus.fr (try.jabatus.fr [109.234.163.213])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5611887885
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anthony@loiseau.fr
X-MailPropre-MailScanner-From: anthony@loiseau.fr
X-MailPropre-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
 score=-0.489, required 5, autolearn=disabled, MED_SPX 1.00,
 RCVD_IN_DNSWL_HI 0.01, SPF_HELO_NONE 0.00, SPF_PASS -1.50)
X-MailPropre-MailScanner: Not scanned: please contact your Internet E-Mail
 Service Provider for details
X-MailPropre-MailScanner-ID: D9709E0480.A1F19
X-MailPropre-MailScanner-Information: Please contact the ISP for more
 information
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=loiseau.fr; 
 s=default;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CwrLhtRhxEC5NKuvMIoxNPxfiPsNFmCGf/UaOcDa+6g=; b=OnfauDY6qJBrlcZBCL4tEGPURj
 z4RmHLrXzGgLoms1jd2CgKy3eiLJLtNdOV5HtZfu97Coscgn8ABVpsEe+XIAodeeWA5YBg7RhINpi
 /22dloN/xmeoLAqD4CR8zxqC3jT4xPUt3PmLqM2R2cKm+Sw9jvJKxS4mcamXeyuNnkj2Gk8XGPHMH
 Gt9ghVqzNQ80GRGykPIuQrYdYbsJGbwZhUoJzxN2EI+mLiQY/YGy/nySyj9YwxLgP4+y/tUmVlbiz
 QtlMZFdYpbBgjI199xYq0jy6pOm7vBFJV4dNhj8A+LmwECz4UfsYw9uVNxYPl/rFMF/DL7jiomfBb
 RoVkRDqA==;
From: Anthony Loiseau <anthony@loiseau.fr>
To: u-boot@lists.denx.de
Cc: Anthony Loiseau <anthony.loiseau@allcircuits.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Stefan Agner <stefan.agner@toradex.com>
Subject: [PATCH] fw_env: autodetect NAND erase size and env sectors
Date: Thu, 21 Dec 2023 16:59:29 +0100
Message-Id: <20231221155929.1762-2-anthony@loiseau.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231221155929.1762-1-anthony@loiseau.fr>
References: <20231221155929.1762-1-anthony@loiseau.fr>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - sucre.o2switch.net
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - loiseau.fr
X-Get-Message-Sender-Via: sucre.o2switch.net: authenticated_id:
 anthony@loiseau.fr
X-Authenticated-Sender: sucre.o2switch.net: anthony@loiseau.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Thu, 21 Dec 2023 17:18:03 +0100
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

From: Anthony Loiseau <anthony.loiseau@allcircuits.com>

As already done for NOR chips, if device ESIZE and ENVSECTORS static
configurations are both zero, then autodetect them at runtime.

Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Anthony Loiseau <anthony.loiseau@allcircuits.com>
---
 tools/env/README   |  3 +++
 tools/env/fw_env.c | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/env/README b/tools/env/README
index 480a893202..b8c6a7e197 100644
--- a/tools/env/README
+++ b/tools/env/README
@@ -58,6 +58,9 @@ DEVICEx_ENVSECTORS defines the number of sectors that may be used for
 this environment instance. On NAND this is used to limit the range
 within which bad blocks are skipped, on NOR it is not used.
 
+If DEVICEx_ESIZE and DEVICEx_ENVSECTORS are both zero, then a runtime
+detection is attempted for NOR and NAND mtd types.
+
 To prevent losing changes to the environment and to prevent confusing the MTD
 drivers, a lock file at /run/fw_printenv.lock is used to serialize access
 to the environment.
diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index c9a8774ace..9f57f19d80 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -1659,8 +1659,15 @@ static int check_device_config(int dev)
 		}
 		DEVTYPE(dev) = mtdinfo.type;
 		if (DEVESIZE(dev) == 0 && ENVSECTORS(dev) == 0 &&
-		    mtdinfo.type == MTD_NORFLASH)
-			DEVESIZE(dev) = mtdinfo.erasesize;
+		    mtdinfo.erasesize > 0) {
+			if (mtdinfo.type == MTD_NORFLASH)
+				DEVESIZE(dev) = mtdinfo.erasesize;
+			else if (mtdinfo.type == MTD_NANDFLASH) {
+				DEVESIZE(dev) = mtdinfo.erasesize;
+				ENVSECTORS(dev) =
+				    mtdinfo.size / mtdinfo.erasesize;
+			}
+		}
 		if (DEVESIZE(dev) == 0)
 			/* Assume the erase size is the same as the env-size */
 			DEVESIZE(dev) = ENVSIZE(dev);
-- 
2.11.0

