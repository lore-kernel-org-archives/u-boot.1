Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051DDC27C52
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 04:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED2588418;
	Tue,  4 Jun 2024 06:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="l3RXByRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD64E8841E; Tue,  4 Jun 2024 06:40:51 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11F388400
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 06:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (ip-109-43-115-118.web.vodafone.de [109.43.115.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 164473F2CD; 
 Tue,  4 Jun 2024 04:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1717476048;
 bh=ANG6kJNanuDToNM4nNs0viaCSipQbF8o+PY4dj6qkpU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=l3RXByRW0atVQQmLvfvMa8LDcQ9745DK4NMluVG6lzcpBnv+9KeW6ilh8jA20gVIC
 hS/zgUL9hAfllIv5s0nWLUWpgmDIkmPDVjXatInGITqOlCxY/VQlVtUpOTbXOv3UUL
 JxxqfMj/SRAEPOIZB5cCEK5HOl34PzrRfqSN9EXu/Abmu81Iscu3zFvDuW7sgFbCqg
 bkRFbbA1F6HKIlWxYyOFtJloFpTrGlhM7H0l4ba0eqPC8zXOOPC6vhvDKBHhXbKsQn
 ENDHZycpzGvw1XMMFQyo3Jl+BOrrO6kLaJoB1hS+SyYh+wxlH1QClA0BoIEiy9EkfP
 +LeCKGxDzK5Kg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Vignesh R <vigneshr@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Andre Przywara <andre.przywara@arm.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] mtd: simplify CONFIG_DM_SPI_FLASH dependencies
Date: Tue,  4 Jun 2024 06:40:39 +0200
Message-ID: <20240604044039.27795-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

CONFIG_DM_SPI depends on CONFIG_DM. There is no need to list CONFIG_DM
explicitly as dependency for CONFIG_DM_SPI_FLASH

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/mtd/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index bedc4e970e..63b0fd899f 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -2,7 +2,7 @@ menu "SPI Flash Support"
 
 config DM_SPI_FLASH
 	bool "Enable Driver Model for SPI flash"
-	depends on DM && DM_SPI
+	depends on DM_SPI
 	imply SPI_FLASH
 	help
 	  Enable driver model for SPI flash. This SPI flash interface
-- 
2.43.0

