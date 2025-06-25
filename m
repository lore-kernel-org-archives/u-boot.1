Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26DDC7EE30
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 12:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15AE682D83;
	Wed, 25 Jun 2025 14:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ceb5ccxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8707182CBC; Wed, 25 Jun 2025 14:41:10 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50FC8803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 14:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kaur@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55PCexbU2109236;
 Wed, 25 Jun 2025 07:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750855259;
 bh=65AlRjgBA2Py3raA2OhrsDCpejYhBvt60MQ1ATiDWZs=;
 h=From:To:CC:Subject:Date;
 b=ceb5ccxiIgFC5YFQX4FxcE548sQ7WSVQVq9GU6WUMRitF59GH9zatY+JD9jOalMZc
 +w9U58vw3p6JEae4V9uuJ6Flw6mhZjl0KGJpYGJkHGFZoPYxrSobBJyH9SVFJ2jmY3
 7fUyKYDI4SrKTZKzA1ro5J26zKYBxBYVKgWlYvVk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55PCexwL2564898
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 25 Jun 2025 07:40:59 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 25
 Jun 2025 07:40:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 25 Jun 2025 07:40:59 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com
 (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55PCetqG3652713;
 Wed, 25 Jun 2025 07:40:56 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>, <msp@baylibre.com>
CC: <u-boot@lists.denx.de>, <vishalm@ti.com>, <sebin.francis@ti.com>,
 <dhruva.gole@ti.com>, <k-willis@ti.com>
Subject: [PATCH] log: Fix the compilation error for emergency log
Date: Wed, 25 Jun 2025 18:10:53 +0530
Message-ID: <20250625124053.1953344-1-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 25 Jun 2025 14:54:31 +0200
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

The log level "emergency" cannot be used as that results in compilation
failure. Correct the macro name used to print at this level.

Fixes: 249679658750 ("log: provide missing macros")

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 include/log.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/log.h b/include/log.h
index dd44badc361..59c66eb7909 100644
--- a/include/log.h
+++ b/include/log.h
@@ -176,7 +176,7 @@ int _log_buffer(enum log_category_t cat, enum log_level_t level,
 #define _LOG_MAX_LEVEL LOGL_INFO
 #endif
 
-#define log_emer(_fmt...)	log(LOG_CATEGORY, LOGL_EMERG, ##_fmt)
+#define log_emerg(_fmt...)	log(LOG_CATEGORY, LOGL_EMERG, ##_fmt)
 #define log_alert(_fmt...)	log(LOG_CATEGORY, LOGL_ALERT, ##_fmt)
 #define log_crit(_fmt...)	log(LOG_CATEGORY, LOGL_CRIT, ##_fmt)
 #define log_err(_fmt...)	log(LOG_CATEGORY, LOGL_ERR, ##_fmt)
-- 
2.34.1

