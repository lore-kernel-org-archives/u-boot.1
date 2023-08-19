Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1C0EE4996
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 03:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E2F9869B6;
	Sat, 19 Aug 2023 05:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="t2dRDAB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D839869C3; Sat, 19 Aug 2023 05:04:47 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F086869B5
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 05:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7AA473F15E; 
 Sat, 19 Aug 2023 03:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692414284;
 bh=znENB+raamJ1KrPbCDLG3g7ycNsiaLjxTb2GcKwpThY=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=t2dRDAB4lYQf9SufQGj3Mmof3JIJelw+ZF2SmGiriGbvkL8S6bdt+YuvqFjSG1Pl5
 QNFklwEr67qYWLap3W7cXxZAPRy0ci1LayqovQqdVWWDy4isg3rmsPG5p4jzHlu1kr
 YbRNd4CshzO4xdm7KAvuCIWe2dc9dbcjzhR5inbC8PWDN++GvYQazO9jxBQBDuKBWZ
 xiBhiaDI+Jka4mi1WzKpJn5IcgXlvcENrowihaTjv+WmUA2TWkQeCnjiSn6dBTD/2I
 DrEkV5VZcHNIxUHa7L5cFWX+gfZdZmeJObv7/FC2JzG+SI8qjAtjuzgsy2qpfiZXE/
 s5h6AxZiZh/8Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: board: ti: am65x: provide image alt text
Date: Sat, 19 Aug 2023 05:05:31 +0200
Message-Id: <20230819030531.31051-1-heinrich.schuchardt@canonical.com>
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

Provide alternative text for image.

Fixes: fd358121bdb8 ("doc: board: ti: am65x: Update with boot flow diagram")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/ti/am65x_evm.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 5f3c46cf9f..fc8c421a28 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -46,6 +46,7 @@ applications. This should happen before running Linux.
 instead use Falcon boot flow to reduce boot time.
 
 .. image:: img/boot_diagram_am65.svg
+  :alt: AM65 Falcon boot flow
 
 - Here DMSC acts as master and provides all the critical services. R5/A53
   requests DMSC to get these services done as shown in the above diagram.
-- 
2.40.1

