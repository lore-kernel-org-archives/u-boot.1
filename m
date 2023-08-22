Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7779EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C57BC86431;
	Tue, 22 Aug 2023 11:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LB617MK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C54408643A; Tue, 22 Aug 2023 11:10:33 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A9FC8642E
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-062-143-244-162.um16.pools.vodafone-ip.de [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7E3FC3F1FB; 
 Tue, 22 Aug 2023 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692695430;
 bh=QV1Srsx9Y4ccpozaWtJF/gsSe0gjbnnoZ6pjmXdgmf8=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=LB617MK+iUdjUazidYcocD+qef8RusS3cllBm/8QUfOXFfzPANTO8aLWD4OXArxLZ
 +1xbY1lnIUXLkFg1tSjUjXApTajBdaHTdxk1Mp9W1MAm0Rxw4h8A4U71hJ4IdYPBrX
 ct93smGhYIWyWolRx1VRR0yHXlafOJtkvPWxGMM5YbrxmXfOxEnSck/Rlyra5SuPAy
 w/f2Zd7GWRQP7juMYq59v8zRUT2RBWsSjR0aY3iwJeLVnrz0bUzvCa0nxovcAmkz4n
 CTq08GTQ6YrrNanY4X/GWgHg8Fgy86f8sRqOiPdIVmCnHiRJEvrAl/pCX/gkgpKcbn
 vyf46pHQ9tg9g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Ruchika Gupta <ruchika.gupta@nxp.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lib: parameter check in hash_calculate
Date: Tue, 22 Aug 2023 11:10:20 +0200
Message-Id: <20230822091020.117376-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

If hash_calculate is invoked with region_count = 0, it will try to hash
INT_MAX regions. We should check this parameter.

* Avoid a comparison with different signedness.
* Check that region_count is at least 1.
* Avoid a superfluous assignment.

Fixes: b37b46f042cc ("rsa: Use checksum algorithms from struct hash_algo")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/hash-checksum.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/hash-checksum.c b/lib/hash-checksum.c
index 8f2a42f9a0..68c290d64d 100644
--- a/lib/hash-checksum.c
+++ b/lib/hash-checksum.c
@@ -23,8 +23,10 @@ int hash_calculate(const char *name,
 	struct hash_algo *algo;
 	int ret = 0;
 	void *ctx;
-	uint32_t i;
-	i = 0;
+	int i;
+
+	if (region_count < 1)
+		return -EINVAL;
 
 	ret = hash_progressive_lookup_algo(name, &algo);
 	if (ret)
-- 
2.40.1

