Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE06FC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 19:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C1C78648C;
	Mon, 28 Aug 2023 21:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jLaqjS/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9918E86456; Mon, 28 Aug 2023 21:12:52 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E378648B
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 21:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4EB7D3F6DD; 
 Mon, 28 Aug 2023 19:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693249969;
 bh=lSsO0i90wKyzdSA5vv+5iguiFtP++FUw5V1JBcQvMrY=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=jLaqjS/bOLPuOzyDOzYoeR+4E6RQiOxPmypMbICODriJC4hHr443MnhyKG1DWOssJ
 JlxyExuHSNmzxzju6gSYcMFT193yA5Zx9WUELSqdg2hENaT3AWGuxaMdnEUXQuA3c7
 amaq4lEq/7TcpHn/sNIDrg2u14BGoxz6o2pXb84CME+snE517lzhAsaQ8MsIUCtz8Y
 lRlk3jXG6sF0tYVfOgpVoNWwfknnbJN1/kr+ppNLPg7sr2L1TzS3Zstn/Fnz85VARM
 1kDdOj4xYqd86XNVHWetokOwfzftKck9H1mmgXl3E6sbSg2/1Mv30q1E9nZB/Z06iR
 aW973/EC+blXg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] doc: add events.h to documentation
Date: Mon, 28 Aug 2023 21:13:33 +0200
Message-Id: <20230828191333.77249-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230828191333.77249-1-heinrich.schuchardt@canonical.com>
References: <20230828191333.77249-1-heinrich.schuchardt@canonical.com>
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

Add the events.h include to the API documentation.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	no change
---
 doc/api/event.rst | 9 +++++++++
 doc/api/index.rst | 1 +
 2 files changed, 10 insertions(+)
 create mode 100644 doc/api/event.rst

diff --git a/doc/api/event.rst b/doc/api/event.rst
new file mode 100644
index 0000000000..8a57d43832
--- /dev/null
+++ b/doc/api/event.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Events
+======
+
+The concept of events is decribed :doc:`here <../develop/event>`.
+
+.. kernel-doc:: include/event.h
+   :internal:
diff --git a/doc/api/index.rst b/doc/api/index.rst
index 3a80ae0635..2f0218c47a 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -10,6 +10,7 @@ U-Boot API documentation
    dfu
    dm
    efi
+   event
    getopt
    linker_lists
    lmb
-- 
2.40.1

