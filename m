Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E91D3C526
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 18:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FEE788FFB;
	Thu, 17 Oct 2024 20:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hlp81ln7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E20D89051; Thu, 17 Oct 2024 20:05:18 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3979088EE5
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BD0493F93B; 
 Thu, 17 Oct 2024 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729188310;
 bh=KUjg0BphVkOZzE6kLb/ZIWIzbLPBRe2eraD8mYsmqR0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hlp81ln7iWe/spXI+yAcZAqgOH1epENyycVr2a6t+jPta9SHC8iXO0uGObNIllyRE
 94Qc+OhWRw0Ci+sRxFxhLZTEQgfcEiKT0X/zKepzMVMiX4YcUeSg5QnmTs/YVXOBir
 hbXrzQvmzvRG0U0YZks2qin+j0NQm8DRzukuahtZnQN3mcaGNIeMpDsJRhdKPraBGl
 d/iwNu9xlU+WjVpYhtTZIIhmNMtMTBhoeMS38r+D0ODQ2vmRu/yJyCtfxymspz3LXI
 /vrH2yU2TR+0WW1JmtanCY+UhENOuEKaPrGcWnWL2sbY1offCF+7xGHOoAvxdUrLFB
 TEzBxpKTU0rag==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: add missing lf in error message
Date: Thu, 17 Oct 2024 20:05:07 +0200
Message-ID: <20241017180507.6261-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Messages written with log_err() should terminate with a linefeed.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index b63b5cca71e..3d742fa1915 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -652,7 +652,7 @@ void *efi_alloc(size_t size)
 
 	if (efi_allocate_pool(EFI_BOOT_SERVICES_DATA, size, &buf) !=
 	    EFI_SUCCESS) {
-		log_err("out of memory");
+		log_err("out of memory\n");
 		return NULL;
 	}
 	memset(buf, 0, size);
-- 
2.45.2

