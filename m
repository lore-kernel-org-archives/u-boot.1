Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C587C46CD3
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 22:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCD05877B0;
	Thu, 21 Dec 2023 23:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=loiseau.fr header.i=@loiseau.fr header.b="kxUQc/vN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFC5787718; Thu, 21 Dec 2023 23:45:11 +0100 (CET)
Received: from enceinte.jabatus.fr (enceinte.jabatus.fr [109.234.163.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D6DB877B0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 23:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anthony@loiseau.fr
X-MailPropre-MailScanner-From: anthony@loiseau.fr
X-MailPropre-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
 score=-25.989, required 5, autolearn=disabled, MED_SPX 1.00,
 RCVD_IN_DNSWL_HI 0.01, SPF_HELO_NONE 0.00, SPF_PASS -1.50,
 WHLISHOS -25.50)
X-MailPropre-MailScanner: Not scanned: please contact your Internet E-Mail
 Service Provider for details
X-MailPropre-MailScanner-ID: 91414E0331.A1A86
X-MailPropre-MailScanner-Information: Please contact the ISP for more
 information
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=loiseau.fr; 
 s=default;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oR5Xx4kExxA5hvOx/y9X1SaGegokwJB7QupkBz05cl8=; b=kxUQc/vNEFQ/UoSLHWnAHnHHLA
 DuPkiXgOykqiOORzTFQYI6xej55zE411iLubPCSUokDwDmOomFUtt+o0dJNl/tf5mnA3C2nBt3tmI
 TDmRwGwcqUtgwIqWLONhRvkdgw98TOAxSoxhF/xVphQzbfLbn50mHsKdGtxTt7N01PDsN9ZgORVXN
 qBlHQYupqG1CSwKwu8MF6SZbCNJJ6+emqFJDC7ZcSIMKlwVvBNCr+0L6ixHXUqZDt/0YYnw2WSGg3
 jsiGnQ3E5tA00dQUR1SF6vV4nE309obTCHEmzBKYRp+2lzfcd496hlnPELviSb99JANYtp4d7NmgN
 y+w+ED5w==;
From: Anthony Loiseau <anthony@loiseau.fr>
To: u-boot@lists.denx.de
Cc: Anthony Loiseau <anthony.loiseau@allcircuits.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Stefan Agner <stefan@agner.ch>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 1/1] fw_env: autodetect NAND erase size and env sectors
Date: Thu, 21 Dec 2023 23:44:38 +0100
Message-Id: <20231221224438.21247-2-anthony@loiseau.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231221224438.21247-1-anthony@loiseau.fr>
References: <20231221224438.21247-1-anthony@loiseau.fr>
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
cc: Stefan Agner <stefan@agner.ch>
cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

