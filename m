Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259F4C04FF8
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 07:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8074C882AC;
	Tue, 16 Apr 2024 09:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="G0BTBrKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B42C0882C4; Tue, 16 Apr 2024 09:35:32 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8048A88287
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 09:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9FF914060B; 
 Tue, 16 Apr 2024 07:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713252929;
 bh=ZvVS7RTaXkHnMi8UbkfHAVZb1FOXte6vEqYL7ZAOQu8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=G0BTBrKo94Kp8TVjbzXM6zD+SlPDM6OgvMzOdzz+T1SMqFcC7VbtsRHp2TK98Ij06
 BZUEH41S7Xd5u4jN/UG+IxESA/LW2L6B0O7PxQkZhIpX1ZEezXWhT304yASzDcY63H
 rs4hDGDMkHvrYBJNEllLaMbsqjTvDY0Xk7jDTwabs0+bnHx7RBN3AN4LCIaQ8GLM6+
 iedK7DLbtwQBYnQjh6Ue+/AuM3OiA34wmq58cxJg4C3fhXwURklruImx7fv73LZEEA
 gL4G0HgnxlmQJAupi2jmEoFiDkTl9WTLACmfmiQ8gloa06cDZ0BtR1oYUa5w7wteIP
 /vC1vaxUOMSwg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] Makefile: don't add -Wno-maybe-uninitialized twice
Date: Tue, 16 Apr 2024 09:35:24 +0200
Message-ID: <20240416073524.25764-1-heinrich.schuchardt@canonical.com>
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

Avoid adding the same flag to KBUILD_CFLAGS twice.

Fixes: 8602d97ca2cf ("Makefile: avoid false positive -Wmaybe-uninitialized")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7321fe1499e..47f3ec82b87 100644
--- a/Makefile
+++ b/Makefile
@@ -717,7 +717,7 @@ KBUILD_CFLAGS	+= -O2
 endif
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUG
-KBUILD_CFLAGS	+= -Og -Wno-maybe-uninitialized
+KBUILD_CFLAGS	+= -Og
 # Avoid false positives -Wmaybe-uninitialized
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78394
 KBUILD_CFLAGS	+= -Wno-maybe-uninitialized
-- 
2.43.0

