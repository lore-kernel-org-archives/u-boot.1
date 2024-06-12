Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3F2C27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 14:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5969887DD;
	Wed, 12 Jun 2024 16:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703D38881B; Wed, 12 Jun 2024 16:59:01 +0200 (CEST)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42aa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD9E887DD
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 16:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vzpb53bvLzp2C;
 Wed, 12 Jun 2024 16:58:57 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vzpb514S4zF2V; Wed, 12 Jun 2024 16:58:57 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Jun 2024 16:58:46 +0200
Subject: [PATCH 1/4] cmd: fix typo in CMD_BOOTMETH help text
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-bootflow-efi-crash-v1-1-27b71b0ff08a@cherry.de>
References: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
In-Reply-To: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

It's bootmeths and not bootmethds.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b026439c773..57929d4462d 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -308,7 +308,7 @@ config CMD_BOOTMETH
 	depends on BOOTSTD
 	default y if BOOTSTD_FULL
 	help
-	  Support listing available bootmethds (methods used to boot an
+	  Support listing available bootmeths (methods used to boot an
 	  Operating System), as well as selecting the order that the bootmeths
 	  are used.
 

-- 
2.45.2

