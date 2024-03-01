Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C9CC48BF6
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 00:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D93888024;
	Fri,  1 Mar 2024 01:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687558809C; Fri,  1 Mar 2024 01:37:17 +0100 (CET)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id F2E0087CFC
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 01:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kojima.masahisa@socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 01 Mar 2024 09:37:11 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
 by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 5F77520584CE;
 Fri,  1 Mar 2024 09:37:11 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Fri, 1 Mar 2024 09:37:11 +0900
Received: from ubuntu-FMVS04001.e01.socionext.com (unknown [10.213.110.223])
 by kinkan2.css.socionext.com (Postfix) with ESMTP id 0FCA5B62AC;
 Fri,  1 Mar 2024 09:37:11 +0900 (JST)
From: Masahisa Kojima <kojima.masahisa@socionext.com>
To: u-boot@lists.denx.de
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: synquacer: developerbox: add myself as co-maintainer
Date: Fri,  1 Mar 2024 09:37:30 +0900
Message-Id: <20240301003731.2308083-1-kojima.masahisa@socionext.com>
X-Mailer: git-send-email 2.34.1
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

Add myself as co-maintainer for SynQuacer Developerbox,
as I'm currently working on it.

Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
---
 board/socionext/developerbox/MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/socionext/developerbox/MAINTAINERS b/board/socionext/developerbox/MAINTAINERS
index c6d4f2749d..d772bc3b4c 100644
--- a/board/socionext/developerbox/MAINTAINERS
+++ b/board/socionext/developerbox/MAINTAINERS
@@ -1,5 +1,6 @@
 DEVELOPER BOX
 M:	Jassi Brar <jaswinder.singh@linaro.org>
+M:	Masahisa Kojima <kojima.masahisa@socionext.com>
 S:	Maintained
 F:	arch/arm/dts/synquacer-*
 F:	board/socionext/developerbox/*
-- 
2.34.1

