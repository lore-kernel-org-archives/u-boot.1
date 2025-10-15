Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5B7CCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 10:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432B58362A;
	Wed, 15 Oct 2025 12:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t2PINAbe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86048323A; Wed, 15 Oct 2025 12:47:18 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8A828362A
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FAlFOU1383642;
 Wed, 15 Oct 2025 05:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760525235;
 bh=hWCFxH/+wZmzqUUFljPyl4YsbX/4wZ1DErYoOTG9RE8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=t2PINAbejGq/A3gEPPhVQTxe0RfQV0doq8PoYcZjX7+EdbR0C+DfvN9K9HOMREZ44
 XGSfrmAciRuaPeENAE/dwPqimAFmfFKQNHWA6eSHpGhOHaZ6YljugcVxHTQIKMb2Fd
 ili13yjRV78Xr20mCwKwatLXaKngEbmxXMVf6OmI=
Received: from DFLE210.ent.ti.com (dfle210.ent.ti.com [10.64.6.68])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FAlFS51166554
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 Oct 2025 05:47:15 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 05:47:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 05:47:14 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FAlD6L1780987;
 Wed, 15 Oct 2025 05:47:14 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v2 5/5] doc: develop: falcon: document unsetting CMD_BOOTx
Date: Wed, 15 Oct 2025 16:16:47 +0530
Message-ID: <20251015104702.3726411-6-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015104702.3726411-1-anshuld@ti.com>
References: <20251015104702.3726411-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Currently secure falcon mode still allows for booting from raw kernel
images if the support is enabled by (CMD_BOOTI or CMD_BOOTZ).

So, this patch documents the need to explicitly disable those config
options to ensure only a verifiable FIT is a valid payload.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 doc/develop/falcon.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
index 528a9c389bf..e40595f49d4 100644
--- a/doc/develop/falcon.rst
+++ b/doc/develop/falcon.rst
@@ -357,6 +357,10 @@ following configuration fragment to enable Falcon Mode:
         CONFIG_SPL_FIT_SIGNATURE=y
         CONFIG_SPL_RSA=y
 
+        # Disable support for booting raw kernel image
+        CONFIG_CMD_BOOTI=n
+        CONFIG_CMD_BOOTZ=n
+
         # Only support MMC falcon mode
         CONFIG_SPL_SPI_FLASH_SUPPORT=n
         CONFIG_SPL_NOR_SUPPORT=n
-- 
2.51.0

