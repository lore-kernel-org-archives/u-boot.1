Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8351C369AE
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 08:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BEFC82A87;
	Sun, 13 Apr 2025 10:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744534706;
	bh=xAB8JrKvoTZoZGPacw6+1rdGCxhqWoC3xYxax5THDGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ifwcn0wSQ8s+uGIzJAZMavuASt+mHTPYQSMXZ4UtRtrinMYmZXEj8uD/PiMTt6BGA
	 ARLjUAThxqv67q5q0Lm4FQhXJ0FNQHjCWHI7Df11fvfPdNCb6PgkuQRjNxZz+Zt5es
	 OE5v461F4LAR8msgCblKOQ6ksuO9lzawcGKBZgMOa8UCYPxjk6+0xDMPxEJqmZt7Dx
	 agLzAc/YFdwOVbHKcWrKc9vXZ9zTLMO5EO1hlDvWZr+Ujf+WJw7ndaxOTl7pmS0oy4
	 8vlRs/ZQYsbmuuGEBDhBhZnShxsSSpEp26wPq4UumKdj8e2+HEpOaM7VU1iN9NddGu
	 hYiK+3Qwl/zCQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48C7D82998; Sun, 13 Apr 2025 10:58:22 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD25829F9
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 10:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FZVraUbz"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0C3BB10271405; 
 Sun, 13 Apr 2025 10:58:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744534699; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=xAB8JrKvoTZoZGPacw6+1rdGCxhqWoC3xYxax5THDGI=;
 b=FZVraUbzguOg9g0n3vgVh4O05KJYBIHyTfIe6ogY6pZXdL7Qn+aJbKfBlnUZW7GV3j6sI6
 koLJUc38pWoYH3sl8djqRESPTj5bv2S1FuzpCZ7ioceV3fAxEBOhRESmoWM6W+/3scw+oz
 a6WO/eSbS1BstLnqGKoFl4PvvHZGgvZP8oLcj4jzpfWK0PrBhtPkPkwbK6MFBBcxtFAVLf
 0yAmqQocAZu8nzWWQngowqawyDyy7Tsn+KxJLFAFuywLq5IBpFTqKzzEJCRmMxmRjFluoq
 MvhQvEPL4h9TpPysMqBvswj6Ai9SWtgkkRZWYB88F3rHWZpMnqPKZvm+G8Xwiw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/7] test_fs: Test 'mv' command on exfat and fs_generic
Date: Sun, 13 Apr 2025 10:55:05 +0200
Message-ID: <20250413085740.5953-7-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250413085740.5953-1-marex@denx.de>
References: <20250413085740.5953-1-marex@denx.de>
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

Enable tests for the generic FS interface 'mv' command against
both exfat and fs_generic.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 test/py/tests/test_fs/conftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index c73fb4abbcb..0205048e73a 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -17,7 +17,7 @@ supported_fs_fat = ['fat12', 'fat16']
 supported_fs_mkdir = ['fat12', 'fat16', 'fat32', 'exfat', 'fs_generic']
 supported_fs_unlink = ['fat12', 'fat16', 'fat32', 'exfat', 'fs_generic']
 supported_fs_symlink = ['ext4']
-supported_fs_rename = ['fat12', 'fat16', 'fat32']
+supported_fs_rename = ['fat12', 'fat16', 'fat32', 'exfat', 'fs_generic']
 
 #
 # Filesystem test specific setup
-- 
2.47.2

