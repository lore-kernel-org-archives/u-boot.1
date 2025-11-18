Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CFFCEE350
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 20:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F37F583959;
	Tue, 18 Nov 2025 21:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lrdfLr2Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEDA983A48; Tue, 18 Nov 2025 21:17:51 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5609835B3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 21:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E12EC40FFC; 
 Tue, 18 Nov 2025 20:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763497069;
 bh=qWNfeiZkFCWfe+8fGS8d0a2XieXkIC4RAwsDq/Zz3BY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=lrdfLr2QvzuFG0NWqOMMraEa9jWj3e9bI+Q2T9H42y7nLe6FMwjg3VsqFht94kzbv
 G6jt0Bi7+Z5j8AW90uUmFkNo1jZbKUQLJiSvRFdmbVjfOOJaM/7lhmACwGSZDcUiLN
 eFwJN5or/bbrwOJ3m37SqEUemTcQugharep4xABJXU3kACNQU443ZAKSZQKqJ+oByL
 AIibkjm9pbIhZ12cd3tg/akdEyM7PqVq1/eVsYUqCyvECptDhkie/lT8XeyXl8nW3V
 uNwE4u45jM21miPTQQUj4hjNGYZ7P1+rn5WcW+bkXA0t9mFTinsGKD/u1gzgz/mdyU
 x91npLu1AvppMT2OWL7W81tzprZk7A/9HWUhrziQCasuoT8w5ugzyagJBb1BSf7N2l
 qt7j3TOrYn1a3MoyS1YAlsm9iNfqcbBM+DcMDiAxrvx0oiFyv/XDwENYkngMmAbCol
 EuBFVxseCLhnix4pivPkX5p8GR7o0XSMaadRmqEDY7sYPwFn0MMISMOYckLu6HsjeJ
 xPhAFFBb/RVOZka6KXWghp3ymRVJHBYfBRl2XmahGK/n+iUYNy+bbVIMNytHvEqkMB
 tTqEKkgSwHiQvvaDVzoAB3WAHOoAQHICTAP5vk82aRTr4ulLip85iZVZhaBLCisCNT
 LogyrkyBPVOncmuScPHCTIv0=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/4] doc: add include/test/ut.h to HTML documentation
Date: Tue, 18 Nov 2025 21:17:32 +0100
Message-ID: <20251118201733.67297-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
References: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
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

The asserts in ut.h are often used. Provide online documentation.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/api/index.rst |  1 +
 doc/api/test.rst  | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 doc/api/test.rst

diff --git a/doc/api/index.rst b/doc/api/index.rst
index d97630e7671..44922a742c3 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -27,6 +27,7 @@ U-Boot API documentation
    serial
    setjmp
    sysreset
+   test
    timer
    unicode
    uthread
diff --git a/doc/api/test.rst b/doc/api/test.rst
new file mode 100644
index 00000000000..359cbd0617d
--- /dev/null
+++ b/doc/api/test.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright (c) 2025 Heinrich Schuchardt
+
+Test Framework
+==============
+
+Assertions and reporting functions
+----------------------------------
+
+.. kernel-doc:: include/test/ut.h
+   :internal:
-- 
2.51.0

