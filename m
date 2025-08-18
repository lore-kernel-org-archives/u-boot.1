Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5355ECA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 06:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BEC9831BE;
	Mon, 18 Aug 2025 08:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NyiWtTsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2749D8352B; Mon, 18 Aug 2025 08:47:27 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C76B82D88
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 08:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1A2723F29E; 
 Mon, 18 Aug 2025 06:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1755499642;
 bh=SRL+cRUj7OXHamlV3Jq4RHJPIlkKfHEIrWzby5dj0Xw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=NyiWtTsTe6lW/zZ82J0sAeiRWlcMKBqnHBCoVqghj0UvrwQA2mdteGOJjqE9PYmuO
 2qb7SdiwN/mWXDue/c295iXWsJq1w7jZQH35xJ7CxH7q1PViVI4ULwEy79ziGugfk6
 sDDxCmNpbuKE92F59hBDIpYD26QoECx63OmsFocob9xFfMp708gnTCrH9DIAx+/UjP
 HQW86ezePkWaJo8+OZHYNX26lg8lDwAnp2BS2SvQQHHaT13UH8r4m1ZpYhd65DAqA0
 kYht2RJtRzI2vKmUKAqOhjMWoTMOkyWFON3FLsqVg+HM3FcvqAId/533MBuUPVASqD
 1XxYDssAnxtsw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Janne Grunau <j@jannau.net>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] arm: Fix swtiching typo
Date: Mon, 18 Aug 2025 08:47:15 +0200
Message-ID: <20250818064715.20359-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.0
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

From: Simon Glass <sjg@chromium.org>

This should say 'switching', so fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/lib/bootm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 7eb764e1f4e..ca4cec61f22 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -183,7 +183,7 @@ __weak void setup_board_tags(struct tag **in_params) {}
 static void do_nonsec_virt_switch(void)
 {
 	smp_kick_all_cpus();
-	dcache_disable();	/* flush cache before swtiching to EL2 */
+	dcache_disable();	/* flush cache before switching to EL2 */
 }
 #endif
 
-- 
2.50.0

