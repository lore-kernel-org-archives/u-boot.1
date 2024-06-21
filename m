Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30955C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 07:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DBE48846D;
	Fri, 21 Jun 2024 09:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="atqbZOmZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8476888047; Fri, 21 Jun 2024 09:47:34 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559708834D
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 09:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C9FDC14835D8; Fri, 21 Jun 2024 09:47:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1718956050; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=EtXPDWpCNA6kA2jM9ND1Ip9Mu1KVzY34zCabznmtdnI=;
 b=atqbZOmZxOBHX+VAq5EALtqtlRVqMJ3KuUXG7UsUOICgEERJ/MbbtRucB1NxWwIvfHUizy
 4mD9hY8iWBiOhGRzOYzGePaYsYefDpnxj03Od9CawXxxZ2mxC6GVnluUUZQF8alsuvnZOI
 f8+seXUK4y97R6RmXk9NhRSJKVs026kGr8TW2n0wQW8vPWJXz1mx5GhFrXgMRhqzsxjKT1
 d9fbfNtYfdWVMQ6Y2LB+9EcFtmd/43fQBNBrA/R9oM6IKwg3FbRhr/6FgpNGQurdK1+/qE
 jZePoECxFbYXmkDbho1KJ4L3SLaRa5GQFjQWsKoZPQzsbiqPfn4dF8esbzeIbA==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] doc: develop: testing: Fix reference to test writing
 section
Date: Fri, 21 Jun 2024 09:47:20 +0200
Message-Id: <20240621074720.203001-3-ada@thorsis.com>
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

Fixes: fc3283314539 ("doc: Explain briefly how to write new tests")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 doc/develop/testing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/testing.rst b/doc/develop/testing.rst
index 056bdfd2b69..9114d11ad26 100644
--- a/doc/develop/testing.rst
+++ b/doc/develop/testing.rst
@@ -123,7 +123,7 @@ or is covered sparingly. So here are some suggestions:
   is much easier to add onto a test - writing a new large test can seem
   daunting to most contributors.
 
-See doc:`tests_writing` for how to write tests.
+See :doc:`tests_writing` for how to write tests.
 
 
 Future work
-- 
2.39.2

