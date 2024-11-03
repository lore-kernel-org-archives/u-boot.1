Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E1BE67806
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 07:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09E36889A2;
	Sun,  3 Nov 2024 08:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cwiYw81C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6C988770; Sun,  3 Nov 2024 08:12:11 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 499038910E
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 08:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7DD83408F3; 
 Sun,  3 Nov 2024 07:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730617927;
 bh=2aBOwBSR5I1MVxVD16zZuL2DRyLQdTsJyifLFbnzWqA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=cwiYw81CNke+d29rUZ8UDAMdZ4aIZhBJwd0JQ5072ULSzD2P+hZDXrYUVhoxODSTg
 3Mv07KJeJk8kVfoRMuiJNtcpoHqqTCX3whKmxPjPxtQQdYFHW30rOWRtihlUVKitZb
 6sI5FOyAMQtJXYEwFh4+TT1TRndM5d3s2CYpCKooiHAHSdv7mRrcbeWF6cJWy1fpXl
 JKg++a12g8LvwuaZWl2rUE/AW9xx499jBr+ykR/3uTJr5uCCJJuwp2FcOBxjpOKn6D
 RJ2N9Nip+3O5fWfbk2p//C4mr0HZ1VCWHFa4WuhEdkFE8tq+A5qPMqaLoKLj+0D6Gn
 2tKoiZCsmaAZQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] lib: uuid: fix uuid_str_to_le_bin() on 32-bit
Date: Sun,  3 Nov 2024 08:11:59 +0100
Message-ID: <20241103071200.82853-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241103071200.82853-1-heinrich.schuchardt@canonical.com>
References: <20241103071200.82853-1-heinrich.schuchardt@canonical.com>
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

hextoul() cannot convert a string to a 64-bit number on a 32-bit system.
Use function hextoull() instead.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/uuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index c6a27b7d044..19f33dd1477 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -35,6 +35,7 @@
 #ifdef USE_HOSTCC
 /* polyfill hextoul to avoid pulling in strto.c */
 #define hextoul(cp, endp) strtoul(cp, endp, 16)
+#define hextoull(cp, endp) strtoull(cp, endp, 16)
 #endif
 
 int uuid_str_valid(const char *uuid)
@@ -339,7 +340,7 @@ int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
 	tmp16 = cpu_to_le16(hextoul(uuid_str + 19, NULL));
 	memcpy(uuid_bin + 8, &tmp16, 2);
 
-	tmp64 = cpu_to_le64(hextoul(uuid_str + 24, NULL));
+	tmp64 = cpu_to_le64(hextoull(uuid_str + 24, NULL));
 	memcpy(uuid_bin + 10, &tmp64, 6);
 
 	return 0;
-- 
2.45.2

