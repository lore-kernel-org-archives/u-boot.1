Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF690C47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 08:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F1987873;
	Tue,  9 Jan 2024 09:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aPmnLizO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5978F87871; Tue,  9 Jan 2024 09:53:53 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CB428786B
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 09:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.home.xypron
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 496C542116; 
 Tue,  9 Jan 2024 08:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704790429;
 bh=Zw/LmqMqSbCKaW56QOoJtpwpYJdLXfKj8lrtLTM90TM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=aPmnLizOvU8PrFnb9oRj3JaW8G/9Bad16T9ubgGQ7rpUCyclNBxLTWtjniga4YBi2
 D12f9+U63J3+aDYMDEUgGCIdJjWMbbbA0Rhzp+QGkgZ1Wqzk+3fWZmERcyD4fiKrHK
 PWEWTw1I0dd5CX60a92E/0ASCQvrpzhddvdHShTejxuv+mM2+Mu5Y/pjbu1QiGDSYH
 pAwYwfzGBmJlsGc8pPzOpqlrAG5gyonOgkMUPS7CHrMjJnuoJW/iycJXloEV3C9unD
 EXa+mzSpgybM4fit+NFh41k04dTy0i1e8t9w2FABb3zJYyAPdM/w5Z3FUCXiqClfzl
 cFRIjiZcqpcuA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] lib: smbios: verify_checksum() is duplicate
Date: Tue,  9 Jan 2024 09:53:34 +0100
Message-ID: <20240109085334.41481-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109085334.41481-1-heinrich.schuchardt@canonical.com>
References: <20240109085334.41481-1-heinrich.schuchardt@canonical.com>
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

The function verify_checksum() duplicates what table_compute_checksum()
does. Replace it. table_compute_checksum() is always compiled.

Fixes: 415eab0655a8 ("smbios: add parsing API")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	correct sequence of includes
---
 lib/smbios-parser.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
index b578c30840..110670343d 100644
--- a/lib/smbios-parser.c
+++ b/lib/smbios-parser.c
@@ -5,22 +5,8 @@
 #define LOG_CATEGORY	LOGC_BOOT
 
 #include <smbios.h>
+#include <tables_csum.h>
 
-static inline int verify_checksum(const struct smbios_entry *e)
-{
-	/*
-	 * Checksums for SMBIOS tables are calculated to have a value, so that
-	 * the sum over all bytes yields zero (using unsigned 8 bit arithmetic).
-	 */
-	u8 *byte = (u8 *)e;
-	u8 sum = 0;
-
-	for (int i = 0; i < e->length; i++)
-		sum += byte[i];
-
-	return sum;
-}
-
 const struct smbios_entry *smbios_entry(u64 address, u32 size)
 {
 	const struct smbios_entry *entry = (struct smbios_entry *)(uintptr_t)address;
@@ -32,7 +18,7 @@ const struct smbios_entry *smbios_entry(u64 address, u32 size)
 	if (memcmp(entry->anchor, "_SM_", 4))
 		return NULL;
 
-	if (verify_checksum(entry))
+	if (table_compute_checksum(entry, entry->length))
 		return NULL;
 
 	return entry;
-- 
2.43.0

