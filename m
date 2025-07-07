Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC365C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 12:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3020830E4;
	Mon,  7 Jul 2025 14:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EWI+Bwgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BCA483106; Mon,  7 Jul 2025 14:14:14 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B330C830CA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 14:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 901576143D;
 Mon,  7 Jul 2025 12:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F127BC4CEE3;
 Mon,  7 Jul 2025 12:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751890450;
 bh=1eECpHe2GoikdFvbn/gECEh2MtHwJvLOD97gEgMp0lM=;
 h=From:To:Cc:Subject:Date:From;
 b=EWI+BwgjK/Ix/NDbuGYyk5dBrVgWoWVpTpDBPjCdMzTGUXC9LjrYFYEe2qkXH0ZHp
 r2PuxZyUpKlPwCRK0TuK7gEBjfNXmQ303Ndsu7Y24qrR111uTkzOSYKI1CpyOjAzAB
 7Ou7L3SmV+DAmkT5keRy187tgxviNx5h1S6kaILlqSs6tA0M+bF5u8vQ7+EeJvDUGj
 MzTzsVQ61FzaNF7LDvGadWu0UFlmqSmSc4r6iSp0Dv8LchPsawC5M/7kslbvLvRz1i
 cjXkXR7T2ZIOJ2tPXF3IlnLh9u9STKBPFLsAmJzDoT8673P19WdUssWh22JLJ4hlrO
 ADGQanhzo1lrA==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: [PATCH v1] board: mpfs_icicle: fix board_fit_config_name_match()
Date: Mon,  7 Jul 2025 13:13:33 +0100
Message-ID: <20250707121333.601067-2-conor@kernel.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

The loop in the icicle implementation of board_fit_config_name_match()
runs strtok() to split off the vendor portion of the compatible string
using , as the delimiter. strtok() modifies a string in place, so where
the first config and compatible do not match, the compatible has been
modified by the time the loop hits the second iteration.
Since stringlists in dt land are null separated strings, the nulls
strtok() inserts to replace the delimiter increase the number of strings
in the compatible list. When the second iteration of the loop calls
fdt_stringlist_get(), it gets the vendorless portion of the first
compatible string, rather than the second compatible string. Copy each
compatible before calling strtok() to avoid this problem.

The temporary string the compatible is copied to is statically
allocated, as attempts to dynamically allocate it at this stage of boot
were met with "alloc space exhausted" errors.

Fixes: 7c16ebba1ed ("board: mpfs_icicle: implement board_fdt_blob_setup()/board_fit_config_name_match()")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Cyril Jean <cyril.jean@microchip.com>
CC: Tom Rini <trini@konsulko.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>
CC: u-boot@lists.denx.de
---
 board/microchip/mpfs_icicle/mpfs_icicle.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_icicle/mpfs_icicle.c
index 6b6984eae3f..ba622e38ee5 100644
--- a/board/microchip/mpfs_icicle/mpfs_icicle.c
+++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
@@ -73,13 +73,22 @@ int board_fit_config_name_match(const char *name)
 	for (int i = 0; i < list_len; i++) {
 		int len, match;
 		const char *compat;
+		char copy[64];
 		char *devendored;
 
 		compat = fdt_stringlist_get(fdt, 0, "compatible", i, &len);
 		if (!compat)
 			return -EINVAL;
 
-		strtok((char *)compat, ",");
+		/*
+		 * The naming scheme for compatibles doesn't produce anything
+		 * close to this long.
+		 */
+		if (len >= 64)
+			return -EINVAL;
+
+		strncpy(copy, compat, 64);
+		strtok(copy, ",");
 
 		devendored = strtok(NULL, ",");
 		if (!devendored)
-- 
2.45.2

