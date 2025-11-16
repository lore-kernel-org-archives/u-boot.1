Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2ADCD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 11:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02DC083A3D;
	Sun, 16 Nov 2025 12:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bzBVsYlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88ED183A8A; Sun, 16 Nov 2025 12:42:02 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51DCF839B7
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 12:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A11DD40994; 
 Sun, 16 Nov 2025 11:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763293318;
 bh=vP0VWijIja846QtKK8U6EBysshTh4xPTgZcTYKjr1O0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=bzBVsYlf6L2Z8IWosfS2gO4ru4fJWWKmJ9AI3NP4cjTS45NJqtWzIOnKRcv1louXU
 6/hTqpBcWJAWeHma8m4fQBp5jNGVVuI6UYvd4+rWDvvyUVi+1qE97KKxAXez/994JZ
 MBM7bkQUpOoOph9HCnf7109gJ2g0HI1EGpbu2yhpZdg8p0YSPfK8AlIrfnSNl38owA
 Rh52aSKP+tEP7Ym/dr0d+knjUe2t+Bs61/2zsuWDF1akw6IXIQdgaDUPr/8px4OYu/
 ZjKRhyeTBYnw2pRS0/uCgBwkWiM0d8CYOFESAXcbvafVEsCJ6+DX8uUwq7yNRK9vrM
 Zd1ZFm9cBY6I1GegbH7BDTGyZlU793Z4seQZQP1FIFABQWLOr2J2Kv5lB5du8vY3Et
 EFJ1JhFw9OjKdAjgVjK/+I+6xlAQ0LZrqXwmCyvTzbwZaXbfDLsq7GGmMuS8jxv+Zk
 6LmSnEhW6Tu4lp8PzA6pUdd8AeITFv0MgcN701Jqufh//EfGW8OA+bDmlWC0EvQc5m
 46DsfeUAtnIOxI5uxbgZjZkODmYBSqUNYwuYpqGNxDuMriOlK6HrmYbaPplhEbR4ly
 Vi14P8CPWOdRra9SizNuVQt8Wd+ZIzseNv9AOfpnDGajxP/+NjNO6ab7JaxjQVUWVe
 S42DwcPrpmXNYMXg+0M34XEo=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd/extension: avoid NULL pointer dereference
Date: Sun, 16 Nov 2025 12:41:53 +0100
Message-ID: <20251116114153.118217-1-heinrich.schuchardt@canonical.com>
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

extension_get_list() will return NULL if there is no extension device.
Check for this situation.

Addresses-Coverity-ID: 638557 - Null pointer dereferences (NULL_RETURNS)
Fixes: 2d12958ee71b ("boot: Remove legacy extension board support")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/extension_board.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cmd/extension_board.c b/cmd/extension_board.c
index 86e4795ba8a..75358abf666 100644
--- a/cmd/extension_board.c
+++ b/cmd/extension_board.c
@@ -99,6 +99,10 @@ static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
 	int i = 0;
 
 	extension_list = extension_get_list();
+	if (!extension_list) {
+		printf("No extension device\n");
+		return CMD_RET_FAILURE;
+	}
 	if (!alist_get_ptr(extension_list, 0)) {
 		printf("No extension registered - Please run \"extension scan\"\n");
 		return CMD_RET_SUCCESS;
-- 
2.51.0

