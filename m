Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682C3D64075
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 17:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6D7A88E00;
	Fri,  8 Nov 2024 18:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Oy3pyTc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883AC88E26; Fri,  8 Nov 2024 18:45:41 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E3C88C7E
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 18:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5EA393F0C6; 
 Fri,  8 Nov 2024 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731087938;
 bh=FRaEYF06dVzjtWpMzpAV74pj3FsSfw9m+wCfzWgkCdU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Oy3pyTc0ct31Zcp17fK1WnHkJyvd1piBvhe3wvrMZd0S7lxtgIewBZ7Fl/Bakd08L
 7rFTvgJDNSrwQ9tWU1ktc5HFKm9dQGQCQ8ltCX6yYQ+yNTE3bW9i1xFNlCUCOoUdYM
 92Ch3AaGFrDvgtTcvV+xJpUiTi3hpbzpVUSAopp/o3GVEkCqPiTum9S86yyiDf+bgZ
 3NrHDJbIpzV7yVi9J71RvlJAgDyd0vs0xxNaFTNsvSBXawBTJr/DY+s9JxwbDGqqAG
 bZw51YI8jb4ZSsc6jgzcbp2sCbMfr/40IAtR9A5rBZhoo9GumP+rAw/f7uYV0EgBke
 1ucctTmB+xuQA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] net: lwip/wget: correct SERVER_NAME_SIZE
Date: Fri,  8 Nov 2024 18:45:26 +0100
Message-ID: <20241108174526.16390-1-heinrich.schuchardt@canonical.com>
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

The maximum length of a domain name is 253 as defined in RFC 1035.
So SERVER_NAME_SIZE should be 254 including NUL.

Fixes: 3c656c928bd7 ("net: lwip: add wget command")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 net/lwip/wget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index b495ebd1aa9..a66b14d1161 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -12,7 +12,7 @@
 #include <net.h>
 #include <time.h>
 
-#define SERVER_NAME_SIZE 200
+#define SERVER_NAME_SIZE 254
 #define HTTP_PORT_DEFAULT 80
 #define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
 
-- 
2.45.2

