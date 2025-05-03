Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876FFC369D9
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 10:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F052F8212F;
	Sat,  3 May 2025 12:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BYWrG6ra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 986D58214A; Sat,  3 May 2025 12:14:29 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A798281F7B
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 12:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-064.46.114.pool.telefonica.de
 [46.114.111.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 96EE33FA63; 
 Sat,  3 May 2025 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746267266;
 bh=Q8JvAry9RBrIHK9+HO1mzQ9EHLqj1W74ZXBkc2tt2lg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=BYWrG6raNe3OL/DgWDuPumvLC+GwjDf8qyTadWD+fsOefa+m3Z6DT8phDVQtQIAxS
 MXVNEYy/IsTp/1K+cZSSbQhE6ITUfnI0RHHZokxFRMlKJOUztRozOE48MtLTMfXzQ5
 1aEL/SLHKom0uUMF6RmipFinrbJGO1E/NO12un7JqwRNgQhOeiySy8MoPg3MklcW5P
 ZPGVS7rwhK/jgqBShqp6j1ksmNoNxInZ7pomRpdYeewz9NlvkrZ4qoCOiuPItU6vzY
 3ohgpvltBrb0/VSBihKy/efWmuXBJWrS7Q3qIg3aBq21h4DI9v6aYuw26uKfBv6ZZJ
 GDEmgt7UOuXyw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: describe u-boot-test-release
Date: Sat,  3 May 2025 12:14:24 +0200
Message-ID: <20250503101424.48236-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

The scripts u-boot-test-release is called at the end of testing.
Describe it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/develop/py_testing.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
index 217ae447035..824e3c0d9a7 100644
--- a/doc/develop/py_testing.rst
+++ b/doc/develop/py_testing.rst
@@ -388,6 +388,13 @@ to download the U-Boot binary directly into RAM and execute it. This would
 avoid the need for `u-boot-test-flash` to actually write U-Boot to flash, thus
 saving wear on the flash chip(s).
 
+u-boot-test-release
+'''''''''''''''''''
+
+When all tests for the board have been executed, this script is called.
+
+The board can be switched off now.
+
 Examples
 ''''''''
 
-- 
2.48.1

