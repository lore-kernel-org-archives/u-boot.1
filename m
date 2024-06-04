Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F89DC25B7E
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 05:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7998B8840C;
	Tue,  4 Jun 2024 07:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BcE2/HUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D1A88431; Tue,  4 Jun 2024 07:44:38 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C558840C
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 07:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (ip-109-43-115-118.web.vodafone.de [109.43.115.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C40603F07A; 
 Tue,  4 Jun 2024 05:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1717479872;
 bh=IS+ce+otDlX9Vo9X2bE9Y4s6r3v8+51t7dD88mNgtig=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=BcE2/HUyjoSL0OFHzXqu4W+8qK3Psf/N9sDaZzUQL8UnjTff0qT3N7VbCb+d6k2pF
 dYx2Bh418bLv+b6VtHy+3Q2yr+7nBu2prOZ6vd+ji4Vo2IlmpAiYqr06QjW437x1Xk
 BbOehyI7TrjDEyOz+siCRwgvYXwJ0lN2s9wpoQd+poO2d9sXwNlsF+ruvniH/cXPE/
 Uuy+0WqW0GlViAzn8djSp2YV4zV/yYt0oBqiVOKmmMtb1RXfO2LuFQGgvFGuASiyq3
 UgUghk5b9KpXUslfzZU4vCcIxxbyINrSykHqJcpYHgwVQzm2GARPjKc/bAGTVL6tro
 7Vt2ofmnCJRoQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] dfu: add missing dependency for SPI flash DFU driver
Date: Tue,  4 Jun 2024 07:44:25 +0200
Message-ID: <20240604054425.105902-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Building the SPI flash DFU driver fails if SPI flash support is missing.

    drivers/dfu/dfu_sf.c:123:29: error:
    ‘CONFIG_SF_DEFAULT_MODE’ undeclared (first use in this function);

Add the missing dependency.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/dfu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index 0360d9da142..971204758aa 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -68,6 +68,7 @@ config DFU_RAM
 
 config DFU_SF
 	bool "SPI flash back end for DFU"
+	depends on SPI_FLASH || DM_SPI_FLASH
 	help
 	  This option enables using DFU to read and write to SPI flash based
 	  storage.
-- 
2.43.0

