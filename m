Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5B3CD54A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 10:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1071186A26;
	Tue, 19 Sep 2023 12:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tkspdRo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E66486ADA; Tue, 19 Sep 2023 12:02:27 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B28786996
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 12:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 95E3D3F20E; 
 Tue, 19 Sep 2023 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1695117744;
 bh=MQnbwlmDae39aDKB5yUZcTK1ko5LprbBLbfXEl7LXjk=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=tkspdRo8g+DRLMh38b1ZycXKDJtO3hcpyP/EhEZkU3w5pu2TC7CjzhHj58S/r/Hhj
 xwEC/LsjBemtHC3OIw5uS4pXNwHxFKEjpWHVndn4kqDAYGgFWd4lsw5Ns9NCpGA/Iz
 0pZhQRziQdIrt2hclFve6UrR6Ju3mAUQ42PkUE0lLfJHRWSIHc2JkRjN9OGtuXt71W
 YYFGbBdv+bq+dkTjmegzXZiKxZ2kj6JkDSqIOKiOUjMAq1Eg+NPEyf9Bs/giVMKxFZ
 fsyfdmlzj1WrzBxkf/4knhgl8hJGpnxVFixI+4F+UpwnXGBdqymjdVXFxl3SMStGcj
 L80dG9vmqViZg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] binman: doc: Remove incomplete sentence
Date: Tue, 19 Sep 2023 12:02:22 +0200
Message-Id: <20230919100222.9319-1-heinrich.schuchardt@canonical.com>
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

This is the difference between version 1 and 2 of Massimo's patch:

binman: doc: fix reference tag placement for Logging section
v2: https://lore.kernel.org/u-boot/20230913161633.999542-1-massimo.pegorer+oss@gmail.com/
v1: https://lore.kernel.org/u-boot/20230909135235.21242-1-massimo.pegorer+oss@gmail.com/

Fixes: 0f40e23fd22 ("binman: add documentation for binman sign option")
Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/binman/binman.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 8945b19446..020988d955 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1480,8 +1480,6 @@ as set in stone, so Binman will ensure it doesn't change. Without this feature,
 repacking an entry might cause it to disobey the original constraints provided
 when it was created.
 
- Repacking an image involves
-
 
 Signing FIT container with private key in an image
 --------------------------------------------------
-- 
2.40.1

