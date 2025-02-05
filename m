Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA4AC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 14:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F825805E7;
	Wed,  5 Feb 2025 15:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738766104;
	bh=4aXyMkU5/z5CFF7oU9qYc7kcCmd28gHIhG3QNzi5By8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xOI5VOSwl5sSGvps4uWhtvh7k0V5sy2/gIlwb1CDAGCBeRoxl/KSeFyWd8veLCIU/
	 coXtA2jj+hM6zpN64kCu3Bad1FnU2p/OzLpqYKmi5I0CyvqdmsALL65dMd+R4++b4K
	 97mUuYcasPV+Dzpr8ZhKLgsXPREWcqgdYgn6b1/SYscSZLs5hO55O2CHRey5Y2I+Mm
	 YZdSvCvbO7ewaP4EBSnu0yEGJVl+fH4EmrXO+oEBKOe2mMLgTu10ieWGSffSmAiCB/
	 gvRuAum7fL/PR/oYmpx/hn8s5+7hp0rK20r4/pJAPet6CaYzAZgQ9qGVB713GCvftK
	 CuCHNDUWltrHQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99424806C9; Wed,  5 Feb 2025 15:35:02 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B13880562
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 15:35:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="G1zJjCty"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CD59A102D4FF8; Wed,  5 Feb 2025 15:34:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738766099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4aXyMkU5/z5CFF7oU9qYc7kcCmd28gHIhG3QNzi5By8=;
 b=G1zJjCtyX4DB8/fGSNGqW73mGHHYp4NsVANSaQJn9UHAMbAJaQY4OYr9soFXdbVut5qyFF
 Q+F6xS0WlIGWjIfEX7N6ZdoA2qXpUsYqGiZ/+vLjXiQup19YE5kWg1ZTRuAE9oWEFiyi1s
 GievGZ7gCBPZSojKMhnUavf3jkvb/8eLiVl1EhJmqAjXXQreiLJ6bM3SB2pQVYwl1Xl/ub
 Ay4gf1D04d2d/HxBBJPwQfHpfjQYer8qE6GN2J4aRB1xz2hhairzdtY/GfYZ6Q9Gzdy00y
 v2yWM8Xkb+J8LQWVbMBm71JaT5BHr5twsswVe0v+9EQmRJVvW8DXxSNPfBBbpg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] tools: mkenvimage: List -V parameter in help text
Date: Wed,  5 Feb 2025 15:34:28 +0100
Message-ID: <20250205143444.65146-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
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

The -V version parameter is missing in the optional list of parameters
in help text. Add it.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Tom Rini <trini@konsulko.com>
---
 tools/mkenvimage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mkenvimage.c b/tools/mkenvimage.c
index a8eebab6c33..885cdb1390e 100644
--- a/tools/mkenvimage.c
+++ b/tools/mkenvimage.c
@@ -28,7 +28,7 @@
 
 static void usage(const char *exec_name)
 {
-	fprintf(stderr, "%s [-h] [-r] [-b] [-p <byte>] -s <environment partition size> -o <output> <input file>\n"
+	fprintf(stderr, "%s [-h] [-V] [-r] [-b] [-p <byte>] -s <environment partition size> -o <output> <input file>\n"
 	       "\n"
 	       "This tool takes a key=value input file (same as would a `printenv' show) and generates the corresponding environment image, ready to be flashed.\n"
 	       "\n"
-- 
2.47.2

