Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF3AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 11:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CCDA88BF9;
	Fri,  9 Aug 2024 13:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BWeR/9Pv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41CE288BFB; Fri,  9 Aug 2024 13:22:39 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45C3F88BB6
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 13:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-170-249.46.114.pool.telefonica.de
 [46.114.170.249])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 228433F20D; 
 Fri,  9 Aug 2024 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723202554;
 bh=pkbNNYbGxkzD65UpKpZt7j3ujKB1CTIeNSEfs5hYuiM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=BWeR/9PvGj4irsT9fnTEILOEYjsAhEyaq3P4t/myey4mUdEeqZrcZkP13NDa7tGgH
 sb+bXLgIFkDTbmhZ3Qs6fWnqhF96vL4HCZ8+vIt3423ByxG/CCyAeZ6F9Hd73kmf6s
 DkLTOhc65mvr4hqAbfUK2o2P7554Eu+wmRUU20a2c+iYEIk2CQPI9IMj0zFFgU/x0A
 /OClogovVDn7ukxi03YHaxHu7IbTdv4cz3TI5FbOoAEMZp3ggxYUs0U/Q3ArvmNX8x
 AGVdSmeKpaQ4etcHkzWp1wxdwTU1a/TjRcvmsu/TO6E4adEeqKHmSGRlLKpPffVOwX
 6M9c39gAyTxKw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tools: fix signature of toc0_verify_cert_item()
Date: Fri,  9 Aug 2024 13:22:16 +0200
Message-ID: <20240809112216.36587-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Avoid a build warning with GCC 14.2

    tools/sunxi_toc0.c: In function ‘toc0_verify_cert_item’:
    tools/sunxi_toc0.c:447:12: warning: ‘nonnull’ argument ‘digest’
    compared to NULL [-Wnonnull-compare]
      447 | if (digest && memcmp(&extension->digest, digest, SHA256_DIGEST_LENGTH)) {
          |    ^

Use a pointer instead of an array to signal that the argument might be
NULL.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/sunxi_toc0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sunxi_toc0.c b/tools/sunxi_toc0.c
index 292649fe90f..545c3771853 100644
--- a/tools/sunxi_toc0.c
+++ b/tools/sunxi_toc0.c
@@ -412,7 +412,7 @@ err:
  * This function is only expected to work with images created by mkimage.
  */
 static int toc0_verify_cert_item(const uint8_t *buf, uint32_t len, RSA *fw_key,
-				 uint8_t digest[static SHA256_DIGEST_LENGTH])
+				 uint8_t *digest)
 {
 	const struct toc0_cert_item *cert_item = (const void *)buf;
 	uint8_t cert_digest[SHA256_DIGEST_LENGTH];
-- 
2.45.2

