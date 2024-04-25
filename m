Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C4BC10F15
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 22:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 213D389073;
	Fri, 26 Apr 2024 00:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714085708;
	bh=USde/yJLp2BkriOXtMmdOMKP7C9qrkXGy6oqbKaMvZ0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MRnhmzf1IxE0M62IWO1BZQoTVe87xSAFelAwheKglzRxm7iVCzZiE6VyEzGmFj8Ds
	 gCxcvudNRs1hBurF+ylmJXTAcFL6dMV4jPoh8Tui9Q33WAStnYkTedQ7Eh1s4kAc0a
	 9oClo7ddL5CV9U+IZf4+Nt+H/6HUm5r61RPqXGuunW3jXIs1/EEMnfn3bV9s+XHjj6
	 2qIo1IEUHEz+FZwhouJdjVMJd9THofzfo8l3iV0p4UYLSlCAtnKAY+a2/5RxDGO5/5
	 FXree2W0FLnMuhC7lwqpJVdz8lPYborbH2xfCDANi8p0uBms94hUl7iKcDnvH8/u0n
	 HRQlgNWY+WdMA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0D4CD87F2A;
 Fri, 26 Apr 2024 00:55:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714085706;
 bh=USde/yJLp2BkriOXtMmdOMKP7C9qrkXGy6oqbKaMvZ0=;
 h=From:To:Cc:Subject:Date:From;
 b=hkoIsytLvVpisd/10p4ZSSiSvjWcqQenFXtNJgyHB4XVr2umS8m3RYeFKsfhXE65t
 dR5bPvUUgd0ceJp9Chz8ymWfN0ruTDT/dTS7LBll52mQLmDZHmkuKJitJIRj9Gqm7g
 TauEhrsgMI1Dgsrg+djb9eAeFPADsOidmDH9T3MeZNDjiV2YBsL8FgyakSbhNutpG6
 J/NvhSKEc2Qj1cBUDfKqvWMTOK21wJdOEkcazTb/CU5ODN4zIkNmUpokBxyqaKgBEW
 zhWFNpIfI3IdUGNAzh88fvKcfTZGYiJ0HRdDr9mGEXvGRi1yjXUIroqAKCbqTVelbF
 imv4s4cuJ6NRg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] binman: Fix typo in mkimage etype description
Date: Fri, 26 Apr 2024 00:54:08 +0200
Message-ID: <20240425225452.496150-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Fix a typo, no functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 tools/binman/btool/mkimage.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.py
index d5b407c5547..39a4c8c1432 100644
--- a/tools/binman/btool/mkimage.py
+++ b/tools/binman/btool/mkimage.py
@@ -11,7 +11,7 @@ class Bintoolmkimage(bintool.Bintool):
     """Image generation for U-Boot
 
     This bintool supports running `mkimage` with some basic parameters as
-    neeed by binman.
+    needed by binman.
 
     Normally binman uses the mkimage built by U-Boot. But when run outside the
     U-Boot build system, binman can use the version installed in your system.
-- 
2.43.0

