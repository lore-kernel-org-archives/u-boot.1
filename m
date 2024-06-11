Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F061C27C5E
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE1E886A8;
	Tue, 11 Jun 2024 15:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC10D88681; Tue, 11 Jun 2024 15:04:46 +0200 (CEST)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65296886AB
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vz85l730gzG0L;
 Tue, 11 Jun 2024 15:04:43 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vz85l39Xbz7rM; Tue, 11 Jun 2024 15:04:43 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 11 Jun 2024 15:04:27 +0200
Subject: [PATCH v2 4/4] dm: core: fix typo in SPL_DM_WARN prompt text
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-misc-20240610-v2-4-028e82b0b620@cherry.de>
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
In-Reply-To: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Dario Binacchi <dariobin@libero.it>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

It should read "in SPL" and not "wuth SPL".

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index 1081d61fcf0..e4b1a66ecb1 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -56,7 +56,7 @@ config DM_WARN
 	  out - it will do nothing when called.
 
 config SPL_DM_WARN
-	bool "Enable warnings in driver model wuth SPL"
+	bool "Enable warnings in driver model in SPL"
 	depends on SPL_DM
 	help
 	  Enable this to see warnings related to driver model in SPL

-- 
2.45.2

