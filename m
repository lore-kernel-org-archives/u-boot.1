Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F371C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 07:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E3C68839C;
	Fri, 21 Jun 2024 09:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="WcDOFH16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 078F588047; Fri, 21 Jun 2024 09:47:33 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C72A8816D
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 09:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5044514835D7; Fri, 21 Jun 2024 09:47:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1718956050; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Nx1HnD2EeaJyfLgIqJXN2AJdJUoVjuSgG1B+MY4gUDM=;
 b=WcDOFH16BMbnOinRPq92m6vblqgv6sCDHcMqwFnwlxoG8c00BEBiaMxMgjjKX2JBQ4o+1R
 CdWEkfhoQA1Vu0jni/aeSPWsDcZAYn1PRU8iNnVZqz41f2Nny7haqrE8nzYerYd66GMYKu
 UmP6UZyaLvUFGjtUz45n7qVNCAr1JQIxQw55a247PUm6kxirqQ/zKSMwyDz3laD9qSFGtX
 9bP+Mcf66S2yaDO3gntisfmwvHI4/6DJNC9zA7qsJNs8mRTh0ym6yevkUYoBl/Egc4MYfk
 o2z/mMY2BQuYwMl8uKeSC/D90mLUAWtU1W5CGfCQ1qgS0y9CP75C4PvysYCoNw==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] doc: develop: testing: Fix broken reference to pytest
 suite help
Date: Fri, 21 Jun 2024 09:47:19 +0200
Message-Id: <20240621074720.203001-2-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240621074720.203001-1-ada@thorsis.com>
References: <20240621074720.203001-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

This should have been adapted directly with or after
v2021.01-693-gca6583d4e08 ("doc: move test/README to HTML
documentation") or v2021.01-694-g0157619d5c8 ("doc: move
test/py/README.md to HTML documentation") already.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 doc/develop/testing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/testing.rst b/doc/develop/testing.rst
index 5afeb42f696..056bdfd2b69 100644
--- a/doc/develop/testing.rst
+++ b/doc/develop/testing.rst
@@ -69,7 +69,7 @@ build::
 
    ./test/py/test.py --bd sandbox_spl --build -k test_spl
 
-See test/py/README.md for more information about the pytest suite.
+See :doc:`py_testing` for more information about the pytest suite.
 
 See :doc:`tests_sandbox` for how to run tests directly (not through pytest).
 
-- 
2.39.2

