Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4526EE677FF
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 14:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CDD888F62;
	Sat,  2 Nov 2024 15:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jhXh7I9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 971888902E; Sat,  2 Nov 2024 15:30:25 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A04AF88F24
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 15:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D73CB408CF; 
 Sat,  2 Nov 2024 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730557823;
 bh=Dn559hswUUuR3tfs+Iv3dSLJ4qH961v76HPb9qdaLDM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=jhXh7I9uGbkKRWkeonUHx/lUnQh1G4ChnWu5B55nWRcCm7yJNJ1GdhSsTbiYm1nSf
 c6z2CTPxI+HngAb8tHfV5hz/FdZD6h9PIw0ISAKxBwzbbveRBXtFuF8r7+zLkkmeN/
 gzVtcwrsjUfwb9U9ZGNaMoZrPFIQRmwh6XvZbjNARCx9IQRtTHwAbw03e97GWg+p+z
 bJ37fmWa/9HFjOQ9qqT3i2mtG0dsWHVQwSOCV8EwyVmxcP2RIs5ajotDZz9QmYDEdV
 BghEERktOk7Lo/XmfDJMUrIdW5dxwWPkLdS+zu0nvClPxILI5yivu18zi8/vzBlbSb
 6kLOcFwuD5BRA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: upl: initialize unit test state
Date: Sat,  2 Nov 2024 15:30:20 +0100
Message-ID: <20241102143020.129450-1-heinrich.schuchardt@canonical.com>
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

do_upl_write() calls upl_get_test_data() which may increment the fail
count in the unit test state. We should initialize it.

Addresses-Coverity-ID: 510465 Uninitialized scalar variable
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/upl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/upl.c b/cmd/upl.c
index 4996f36c787..c9a823bbc06 100644
--- a/cmd/upl.c
+++ b/cmd/upl.c
@@ -50,7 +50,7 @@ static int do_upl_write(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
 	struct upl s_upl, *upl = &s_upl;
-	struct unit_test_state uts;
+	struct unit_test_state uts = { 0 };
 	struct abuf buf;
 	oftree tree;
 	ulong addr;
-- 
2.45.2

