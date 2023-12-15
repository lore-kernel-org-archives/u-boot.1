Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34185C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 09:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8993C87949;
	Fri, 15 Dec 2023 10:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qb/lkO3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E532C87949; Fri, 15 Dec 2023 10:42:39 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFBB887853
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 10:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 18F92413C5; 
 Fri, 15 Dec 2023 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702633357;
 bh=Fj4KEnDow3sW7fJGklCxTXjB80rh0toqhEX2plRdu6E=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=qb/lkO3j/YxbODDWDPa8H886nFcc1XZ7brqFbW1OHowySOEOy8Qb5YW05EI7RnXqp
 amaoUB7Ht6wLbfCOvsRkC78XGhbf+Uov8bgwTcjhyLz50gg/GB0cw2g8NVMSj1MehG
 bHxHYYfjNIAGX3oXkFYvmvVFEAUmrM69OP5T6PkgMADW+KPpaSddns/uGkuJCk0k2i
 QLfYjmv/W1+l75kGJ0PHRd6bBQ2WZEwRW/AKaJrRd83r1O49nFeMqNW32fDnq5cKV/
 ymiUs3/6uM6KdZ2shgRg6KuDxys5PQN60xOkpVz7g8KKiOKF//BEmTEMFpbNqv2XkK
 ZqYFMoj3DR5Nw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] buildman: type cotaining
Date: Fri, 15 Dec 2023 10:42:30 +0100
Message-Id: <20231215094230.130121-1-heinrich.schuchardt@canonical.com>
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

%s/cotaining/containing/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/buildman/boards.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
index 341a5056df..3c2822715f 100644
--- a/tools/buildman/boards.py
+++ b/tools/buildman/boards.py
@@ -119,7 +119,7 @@ class Expr:
         """Set up a new Expr object.
 
         Args:
-            expr (str): String cotaining regular expression to store
+            expr (str): String containing regular expression to store
         """
         self._expr = expr
         self._re = re.compile(expr)
-- 
2.40.1

