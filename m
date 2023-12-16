Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58807C46CCD
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 15:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB29C875F0;
	Sat, 16 Dec 2023 16:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y6eHRubo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5BA4876C8; Sat, 16 Dec 2023 16:46:35 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E6E87536
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 16:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 72E7C3F278; 
 Sat, 16 Dec 2023 15:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702741593;
 bh=kc9i1m1S0YmJDvT5WPTbYFNQOwaW0GPr+JtcQdQYpdY=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Y6eHRuboZL7SV0jAYIGKr0MHknSl66uedUyV9wsNUHmpFoKuuBB64JcI4CNfkDr9s
 LAfQQM6q4PZ2v8nvBbyfUWLz//grhlr9jJqtkIF2Iegfy05MwKyoefsC0EP6R7Uibl
 8t8x/086y8NsxxJuJY7RlT8Uf4/8n78kND9P9KW8rqIuy0M72LCun6wyotjM9TAUJT
 ThR0dlHw7p+1kcJvJlORBnSVLbuepZcree1YCeVafMOxBSWl1+mFacw4fCKMs1/MgM
 YiYlD499lallOj9+pbGcm+Z+Eyy45GrJ0OLl6GOstpilgbhvUPtKHbyy5DPMDlp2W7
 VPo/h3saVzp1w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: CONFIG_UT_BOOTSTD must depend on CONFIG_BOOTSTD
Date: Sat, 16 Dec 2023 16:46:31 +0100
Message-Id: <20231216154631.87789-1-heinrich.schuchardt@canonical.com>
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

Building sandbox_defconfig with

    CONFIG_BOOTSTD=n
    CONFIG_UT_BOOTSTD=y

leads to an error

    /usr/bin/ld: test/cmd_ut.o:(.data.rel.cmd_ut_sub+0xc0):
    undefined reference to `do_ut_bootstd'

Add the missing dependency.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/Kconfig b/test/Kconfig
index e842c01308..e2ec0994a2 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -67,7 +67,7 @@ endif
 
 config UT_BOOTSTD
 	bool "Unit tests for standard boot"
-	depends on UNIT_TEST && SANDBOX
+	depends on UNIT_TEST && BOOTSTD && SANDBOX
 	default y
 
 config UT_COMPRESSION
-- 
2.40.1

