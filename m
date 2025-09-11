Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BE1CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 13:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE881835B9;
	Thu, 11 Sep 2025 15:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ay0O+fVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 093F1833F1; Thu, 11 Sep 2025 15:14:52 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A458835B0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BDEmQL808444;
 Thu, 11 Sep 2025 08:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757596488;
 bh=ePvgd3z7emD4CHDJCb7FJLItbyH3Fn32xHXtqEDgiGE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ay0O+fVw7qtGrO8zBmhk3f9y8NsYuzQK9GE61BiBzONZXa8tno/JxAVbyE1Ibrmmu
 N1zDm8T/eL3cb0rsshIfeC93mXnGfdYqseJIcY+HoWUwHSZMv5J15hX0Wpiy3KiaaI
 SOHkiH1H/NUNUifqsiBWDNd/3mkPahWeO+hvY48c=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BDEmOM1962386
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 08:14:48 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 08:14:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 08:14:47 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BDEkV51873253;
 Thu, 11 Sep 2025 08:14:47 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH RFT v1 15/17] env: Kconfig: disable external env in secure os
 boot
Date: Thu, 11 Sep 2025 18:44:11 +0530
Message-ID: <20250911131414.3296697-16-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911131414.3296697-1-anshuld@ti.com>
References: <20250911131414.3296697-1-anshuld@ti.com>
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

Falcon mode uses falcon_image_file from the env during mmc fs boot, but
external env can be compromised. Therefore disable access to external
env by setting SPL_ENV_IS_NOWHERE when SPL_OS_BOOT_SECURE is set.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 env/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/env/Kconfig b/env/Kconfig
index 03c189b7266..d68cb90f3a4 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -827,6 +827,7 @@ if SPL_ENV_SUPPORT
 config SPL_ENV_IS_NOWHERE
 	bool "SPL Environment is not stored"
 	default y if ENV_IS_NOWHERE
+	default y if SPL_OS_BOOT_SECURE
 	help
 	  Similar to ENV_IS_NOWHERE, used for SPL environment.
 
-- 
2.51.0

