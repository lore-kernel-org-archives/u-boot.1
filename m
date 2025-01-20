Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7482C02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 08:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E7F800B6;
	Mon, 20 Jan 2025 09:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Z+J3o9YG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C69801CF; Mon, 20 Jan 2025 09:29:41 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 156E580077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 09:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A3B803FEA0; 
 Mon, 20 Jan 2025 08:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737361777;
 bh=tPYGucbQPsou6Dwy4y2HdAswJsewJfD7femo65UbECY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Z+J3o9YGCWgHkF6Tr5DqOm0Bq9ncKXNfebmGkay1StHFXCsziVDMG2XMlogtJirCd
 sg+XUR1KmARd+NpSSQ3MQYMG7mZdJZDzhqKKNYPd8rqS3j3oA/NjPUPyNop/y1TMuh
 SVcgAAKDmbB06LwQFrWM6Rsw3+n0Mgiy0MUnOgfpPN+HkQdqEJG6mRh5vL3QQPhfMx
 Xsg0QnZhYah6nmDtNw7sVSAqciVkLEZQan4Vvh4uGM3glHFAoSz83NUdem5S6P4WoR
 IA0eeLqPpjEAD4DQr1gMc2o+rjsx7Ho4Mau3E+vrxNW5B48rOiBGCjZZnWnvZyoj7r
 EzOHn4r2Fm/ew==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] test: str_ut.c depends on CONFIG_STRTO
Date: Mon, 20 Jan 2025 09:29:32 +0100
Message-ID: <20250120082932.20620-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

The string conversion functions are implemented in lib/strto.c which is
only compiled if CONFIG_STRTO=y.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	rebased on origin/master
---
 test/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/lib/Makefile b/test/lib/Makefile
index 24ce6ed8f00..f15a76cec2e 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -17,7 +17,7 @@ obj-y += lmb.o
 obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
 obj-$(CONFIG_CONSOLE_RECORD) += test_print.o
 obj-$(CONFIG_SSCANF) += sscanf.o
-obj-$(CONFIG_$(XPL_)CMDLINE) += str.o
+obj-$(CONFIG_$(PHASE_)STRTO) += str.o
 obj-y += string.o
 obj-y += strlcat.o
 obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
-- 
2.47.1

