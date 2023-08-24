Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6FAC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84418669C;
	Thu, 24 Aug 2023 18:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tachibana-labs.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93ED1867EA; Thu, 24 Aug 2023 17:52:34 +0200 (CEST)
Received: from l1.tachibana-labs.org (l1.tachibana-labs.org [95.179.235.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B4DE8684C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tachibana-labs.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=inbox@tachibana-labs.org
Received: from tachibana-labs.org
 (cpc99306-croy26-2-0-cust13.19-2.cable.virginm.net [80.192.164.14])
 by l1.tachibana-labs.org (OpenSMTPD) with ESMTPSA id 995f371b
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 24 Aug 2023 15:52:27 +0000 (UTC)
From: mia soweli <inbox@tachibana-labs.org>
To: u-boot@lists.denx.de
Cc: pali@kernel.org,
	mia soweli <inbox@tachibana-labs.org>
Subject: [PATCH] Nokia RX-51: Add CONFIG_BOOTM_PLAN9 to default config.
Date: Thu, 24 Aug 2023 16:52:11 +0100
Message-ID: <20230824155211.15173-1-inbox@tachibana-labs.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Aug 2023 18:01:12 +0200
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

Enables booting Plan 9 kernels by default on this board.

Signed-off-by: mia soweli <inbox@tachibana-labs.org>
---
 configs/nokia_rx51_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/nokia_rx51_defconfig b/configs/nokia_rx51_defconfig
index 8e55069950..551806ae5e 100644
--- a/configs/nokia_rx51_defconfig
+++ b/configs/nokia_rx51_defconfig
@@ -22,7 +22,7 @@ CONFIG_SYS_PBSIZE=287
 # CONFIG_CMD_BDI is not set
 CONFIG_CMD_BOOTZ=y
 # CONFIG_BOOTM_NETBSD is not set
-# CONFIG_BOOTM_PLAN9 is not set
+CONFIG_BOOTM_PLAN9=y
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
 CONFIG_CMD_BOOTMENU=y
-- 
2.41.0

