Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDA2C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 10:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91095878EA;
	Tue, 26 Dec 2023 11:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BiM5Fgdi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C97A878EE; Tue, 26 Dec 2023 11:22:35 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263E687895
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 11:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 53EAC3F45F
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703586152;
 bh=mlZKSKMo8nWL/6dRrSu5YC6odZv/G4B4PjQpv5UyQ0o=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=BiM5FgdiIax2BFS/t3BFM2cZanNastVjml1z34zYtmBuO6ETdQmkUjzmsVt+kGnfN
 OJv3upWL5VD7nAPEggiehULzp9lwX8oDPad2Mti7qAy6k8YnRgI3ZJW+smT8YTAYOl
 NzYXnG+Fg3ODHJReAG5fCaqCY6nwssP1fUD9zYnBBkIuXK7qSoqWavTxp3IHMW35vz
 eQQhMCW/jbX/63jx+AtVlHBf+XxHrfFVOm0Do/fFpRiFKOHQJXVBTIoleRNt9uDDvS
 FeHmvEYh4C7CTJ85mWrW82VfaeJ7kfhrEnjED4o0qpb7ibIAh9LYSiFWKZXZVtI2EV
 18F4xJe+YL2wQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d42061a35so39550725e9.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 02:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703586152; x=1704190952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mlZKSKMo8nWL/6dRrSu5YC6odZv/G4B4PjQpv5UyQ0o=;
 b=BR/Kh/LBQGR0gjaPPcdc95gZwXbs3WlUQJtUkIoPZAzm06iScGq4DJwXh0UOhGjLZl
 VGeojckTy3AryhP5NZ+gyACbQjrEmVJp5iMLDWtMCu7AsHlOQK3eo7oOiqUk4A959zpF
 yPZgm5AcI7iJmCedhbvEdTGvM/ErQmdnU2aaL6kl6+UXDxQxG4lmohhHnCPftjpkRJLq
 sIOtuypeGZlWsem/E0hUKElyYMxwY82HjEKeKyKNfR7K/kSKoo+1+QBVGOKyUDcQhuBw
 y4aVVw9DWtTa/W3cvYG3jJ10p/Ke7P/Jg4Xk2mKB5PWE7ZNpRDhTHBl2EHg5xulmtthp
 YdrQ==
X-Gm-Message-State: AOJu0YyuNGaqQMDkvsfCwPrIMllf/9U/BPPnWc+fmhMj/cJe5NR7mbjc
 hnALe9lPdqVyiwtIxZKzgAs2ahKmpWe7ZP4kdtrv60mULleeLcxkH3sihj2RgnYh4/HtcMUfFGV
 4KMZ2d4sfhoHhPyCkmfM0K9leZsTJJdQoZ/ieJg==
X-Received: by 2002:a05:600c:4d97:b0:40c:2c6d:c833 with SMTP id
 v23-20020a05600c4d9700b0040c2c6dc833mr4183537wmp.137.1703586151655; 
 Tue, 26 Dec 2023 02:22:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW3ntInE/dIcWA0ns/ptal8Rbo6N94X63NpzY8/gYBoN8iznVN/X/wvh/UD0q/0TVsRqMEcg==
X-Received: by 2002:a05:600c:4d97:b0:40c:2c6d:c833 with SMTP id
 v23-20020a05600c4d9700b0040c2c6dc833mr4183533wmp.137.1703586151325; 
 Tue, 26 Dec 2023 02:22:31 -0800 (PST)
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 s21-20020a05600c45d500b0040c3953cda5sm28075698wmo.45.2023.12.26.02.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 02:22:30 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] lib: smbios: verify_checksum() is duplicate
Date: Tue, 26 Dec 2023 11:22:28 +0100
Message-ID: <20231226102228.66338-1-heinrich.schuchardt@canonical.com>
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

The function verify_checksum() duplicates what table_compute_checksum()
does. Replace it. table_compute_checksum() is always compiled.

Fixes: 415eab0655a8 ("smbios: add parsing API")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	mention that table_compute_checksum() is always compiled
---
 lib/smbios-parser.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
index b578c30840..110670343d 100644
--- a/lib/smbios-parser.c
+++ b/lib/smbios-parser.c
@@ -5,23 +5,9 @@
 
 #define LOG_CATEGORY	LOGC_BOOT
 
+#include <tables_csum.h>
 #include <smbios.h>
 
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

