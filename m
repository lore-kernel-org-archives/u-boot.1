Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC93EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 08:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE0086473;
	Tue, 22 Aug 2023 10:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="F4AnN4iO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A292286475; Tue, 22 Aug 2023 10:43:19 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF568646E
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 10:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-062-143-244-162.um16.pools.vodafone-ip.de [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3C0DA3F1FE; 
 Tue, 22 Aug 2023 08:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692693796;
 bh=QV1Srsx9Y4ccpozaWtJF/gsSe0gjbnnoZ6pjmXdgmf8=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=F4AnN4iO6H9+kqdGE4nKEBobVn9a3nwayckG3uTm7sr3Z88U+Qd1lD8kqh1Tl70sV
 OgrxyawFv2IyhkZuaQCixUaqo5ZiEmWbBezOxwx2ZaljFk16atTUgp0AKz7nlMBhXU
 KSvri+h3sniujGJtR8yaGxTeKQuZYVRs6xCgMVkITI3WytlGQWC54d2rzxHunrPSgJ
 a5d7IRADiKz+R+clFoE2U7opaER0KrPXiV6CAkJ76U6Q6WXz3k6jobiUV1r+FgWojV
 K7syYlc6dpUGXjsLa/ycR/Labz6D1TIa4XYlpzUFsdzRfuVbBh048QRtQWH1iacfkJ
 tkQSgOwJfEMkw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@ti.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lib: parameter check in hash_calculate
Date: Tue, 22 Aug 2023 10:43:06 +0200
Message-Id: <20230822084306.91806-1-heinrich.schuchardt@canonical.com>
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

