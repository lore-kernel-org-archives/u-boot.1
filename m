Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472F5CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 21:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03D483942;
	Tue,  4 Nov 2025 22:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="U6deA9qh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B2D83946; Tue,  4 Nov 2025 22:50:30 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE2FB83936
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 22:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1DB9A3F189; 
 Tue,  4 Nov 2025 21:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762293028;
 bh=aM+JyGKnO361r6FaKmUK+9/40xMsEg3dM6NmBP4hXm0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=U6deA9qhyusCyHMu3Gxy1qMHlb1EmYKFXTu7DzWe5fv5XoZFDE0sSdGJCw/ishxI/
 E1/vqSa99qEo54U1ACjZhj7Ow2EBcnOy/YzNSM6nq6xVgZ+wz0EVxNPfqjiSGSt9Zr
 MpntnWhMwuh2GKa1ShqBZi2I1P9k48sjDXzOC4WjwPiB3Mh/R8Z1/TUmEltdFR2wEa
 Eo6h1HdA0XE7qm37Vv57ya8QXejMKKxsdxiXL6ME9rPKK1MP2BfqJiNNDpT1ERcb/M
 j93XagzUJ5MxIDKnFr6eKQIIrWtKzoRHeADviFrValrTBJUFCGNZ65ItIZ2wzv5eaj
 gt3AOGSr8uuKqVHFLbnBdTmc/vcRG9mNqTaB+Td+dOyNINAgDApnTt7EDtbemF5I7e
 IKZ6RdFY4Rq6SsJNE9wYwEmavYM334AOk0G7HDbrGWd6R3O3zh+F6gX5CM2wTbKS8N
 JgUZFcoqKg3RK2EZdlnoazv1QvhlOLPXiGkxo5U97j1KDgh3qoAfJCA8Zn7IUUrCfd
 8w95z2xJJspbjF5bTH5UcGD2jSsw0W9/ymlD1f3IIe7Zw1g48jCcLLx3rHBuTQ8bp8
 DKnrFgnx96ZvooZvyOWMk0PXRO91Qw5CMXI9L1mScQUlrBfmYRyYCZP04dJuRaYGbo
 bD/0iCsIo570NwiHzY1nZx5o=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: typo 'eventfor' in efi_ipconfig.c
Date: Tue,  4 Nov 2025 22:50:25 +0100
Message-ID: <20251104215025.18287-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

%s/eventfor/event for/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_ipconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_ipconfig.c b/lib/efi_loader/efi_ipconfig.c
index 9f51f77fa9a..b20de8c3e4b 100644
--- a/lib/efi_loader/efi_ipconfig.c
+++ b/lib/efi_loader/efi_ipconfig.c
@@ -168,8 +168,8 @@ static efi_status_t EFIAPI efi_ip4_config2_register_notify(struct efi_ip4_config
 }
 
 /*
- * efi_ip4_config2_unregister_notify() -  Remove a previously registered eventfor
- * the specified configuration data
+ * efi_ip4_config2_unregister_notify() -  Remove a previously registered event
+ * for the specified configuration data
  *
  * This function implements EFI_IP4_CONFIG2_PROTOCOL.UnregisterDataNotify()
  * See the Unified Extensible Firmware Interface
-- 
2.51.0

