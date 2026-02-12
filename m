Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70309EDF057
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 08:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E21A483A47;
	Thu, 12 Feb 2026 09:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="VoULDOM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C2283C4B; Thu, 12 Feb 2026 09:33:34 +0100 (CET)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 886028367F
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 09:33:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TIX/EfJDmjcQjo+9HBrv9ibrm9bSzXK4rZ6mIVKerN8=; b=VoULDOM8HIOrBJPZj6gZ0YNdz2
 sBzTsxACFBVnQCrqjYAAkXf3OI+293GSpoPCmrF0LwQsU+LfiP3E1aavp4vs+FxVMr7u7hV59iZbr
 U7gSBeNMtSgtD6MYbAIF2XNoFgF4RHh71S3LNTnm71msPhkdJ2Ry2kVLfYf0x7M4tDx9tXAsoaSJU
 cuauVuPTDEaN4cc/CcfPAwAau2zzYaTGh/b1TuT1Zm5b4sDhfudhX5R9pd02rRbkZrWGodhpnpWIF
 5vI5FuRowGxnjSA57kdSaT/QaN4/XXT9qiHTOx6/EXaDtWa5HKbT8fhJEAMsLE6GZaSCWgKK4LE5b
 cBreaZjw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:55964
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <primoz.fiser@norik.com>)
 id 1vqS8j-00000003tk7-2idS; Thu, 12 Feb 2026 09:33:31 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: B.Hahn@phytec.de,
	upstream@lists.phytec.de,
	u-boot@lists.denx.de
Subject: [PATCH] board: phytec: phycore-imx93: Enter fastboot on USB boot by
 default
Date: Thu, 12 Feb 2026 09:33:30 +0100
Message-Id: <20260212083330.3293928-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
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

In case board is booted from USB, enter fastboot by default to enable
the UUU flashing. In case of abort continue with the regular bootstd
scan. User also has possibility to override the default bootcmd from
the environment. Last but not least, this syncs behavior with other
PHYTEC boards from the i.MX family.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 board/phytec/phycore_imx93/phycore-imx93.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phycore_imx93/phycore-imx93.c
index cfc6d91f20f2..fe001f77d4ba 100644
--- a/board/phytec/phycore_imx93/phycore-imx93.c
+++ b/board/phytec/phycore_imx93/phycore-imx93.c
@@ -44,6 +44,11 @@ int board_late_init(void)
 	case MMC1_BOOT:
 		env_set_ulong("mmcdev", 0);
 		break;
+	case USB_BOOT:
+		printf("Detect USB boot. Will enter fastboot mode!\n");
+		if (!strcmp(env_get("bootcmd"), env_get_default("bootcmd")))
+			env_set("bootcmd", "fastboot 0; bootflow scan -lb;");
+		break;
 	default:
 		break;
 	}
-- 
2.34.1

