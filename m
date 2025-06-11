Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8760AC677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 13:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC6F182B63;
	Wed, 11 Jun 2025 15:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="Aj8bLolI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0239182B70; Wed, 11 Jun 2025 15:03:00 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27D2682B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 15:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=Cnhbdo4B4wgE88iMUfIEFhydn3oGNBIiHW4mcXJad+U=;
 b=Aj8bLolIIjM8UxZP93eaYxmwLwXpApK5BVr0TyRYI/0jsdcvNjkRmqPSRweng5wfZ4xjLzZdnw3iFgH7JkxwjXicpNHra8/l5tkZZEeG5dZtuwLhYjFhVnX1hkIe7tEMoB9KXvRu/KmAw2wfsjklq5nWBeXgU4puhyI3PI0qJJj2dBZqeNT/PEJkhvka7H5L/YRhcbGPWpsq2vrWAoRhlhgu6a6aBISh04AXTkfxQ0yuR27Eb1NZZbHkLj
 O8RhCA4bIbsIhm2EFFivLPcxy2+6gI7CvjzpcFDmQcQNO/U2RwUMoelSDoanhQWaBnX30ltZsA5ro18NJ3ksZ0hLuJvg==
Received: from TkB (188-24-194-246.rdsnet.ro [188.24.194.246])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Wed, 11 Jun 2025 13:02:53 +0000
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Marius Dinu <m95d+git@psihoexpert.ro>
Subject: [PATCH] cmd: add "config" command dependency on gzip
Date: Wed, 11 Jun 2025 13:02:12 +0000
Message-ID: <20250611130211.24352-2-m95d+git@psihoexpert.ro>
X-Mailer: git-send-email 2.49.0
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

gunzip is used in cmd/config.c

Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f21d27cb27f..057f091bf3b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -153,6 +153,7 @@ config CMD_CONFIG
 	bool "config"
 	default SANDBOX
 	select BUILD_BIN2C
+	select GZIP
 	help
 	  Print ".config" contents.
 
-- 
2.49.0


