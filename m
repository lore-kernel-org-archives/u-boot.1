Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01320CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 15:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A749839A1;
	Thu, 14 Aug 2025 17:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="XZfIuVqJ";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dtW4HG1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 140A8838E3; Thu, 14 Aug 2025 14:04:54 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD94838C5
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 14:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1755173076; x=1786709076;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kLdmga9T7vSnIMUpjCEAK959hmEFQrJPtMObNWLajRw=;
 b=XZfIuVqJIjeE2zqJG2VEWykWgEvxyxIokDBZaZj8co5EIxnz9vpBOCHi
 A4CxY+xHea/IpeyJIxO/ROC63BEWCvMdG5Y8aDwrLUeEPwY621Ct9Z3p9
 zALeqCDDQFJ43Zu91NqauKZB0yH04n1SoxZZR9Mx6wJl0k/TFZRsHdVN+
 ZH6B3zVZsmZ81HEcmZkMR0QDq3w2q0YOlkhOJ0uG2JMZ+HTrKgTKef0WH
 Hku9CYgeC2GKSDI3wsLn1RAdKzxac1v9S8l71Yg237Ob/ke5J5f5vntbC
 nNG5Iapsg7rS4+13oaS5xIzjVimgwWedPHM/IMP3wMW2ZeLisHTs9viwz g==;
X-CSE-ConnectionGUID: EWjTqyG5QIe9QdFdi5eODA==
X-CSE-MsgGUID: cYEJHbv/Q4igF8gke1qbow==
X-IronPort-AV: E=Sophos;i="6.17,287,1747692000"; d="scan'208";a="45742143"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 14 Aug 2025 14:04:36 +0200
X-CheckPoint: {689DD0D4-12-410E8DD8-CEA8F0F8}
X-MAIL-CPID: 1C35477696DAC2A8CBDBED1DE0611544_3
X-Control-Analysis: str=0001.0A002102.689DD0D4.0065, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C9538161362; Thu, 14 Aug 2025 14:04:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1755173072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kLdmga9T7vSnIMUpjCEAK959hmEFQrJPtMObNWLajRw=;
 b=dtW4HG1WfJ80QJ/ZdGnOKfaNP1+LXWKarSN3LxVR3zoMz+GHtGyt7wx8EldjXxUsxolRi4
 clHZT2/MGB9wAgXaT2HukO3Z+AO8he8qRY3uylOm1bGNWpFpKoQ6EMPyO2/mDFqU0O0n+q
 8yDGAGe78jl+T2X1eCS6rVq9jeYpZD/zqBQTopk6FW/lR0K5boLnjiCf/jOqEZii0UJHFc
 QgaE28rp+7fevyV6r/8tTHa4ufM7bvG08iJkuw5aptUcXAOsTCyCOeBK9ioaZcjcUKCL4G
 9WCywWULInAvCDaElWoRSb1nQTC7yHjjHYwF61e2onp3J8cz29uIaqk6AJutWg==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH] tools/libfdt/fdt_rw: sync SPDX-License-Identifier with libfdt
Date: Thu, 14 Aug 2025 14:03:30 +0200
Message-ID: <20250814120334.235081-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 14 Aug 2025 17:15:25 +0200
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

Currently, the terms of both licenses (GPL 2.0 and BSD-3 clause) must be met.
However, libfdt uses OR to allow the choice of license used for the project.

[https://git.kernel.org/pub/scm/utils/dtc/dtc.git/tree/libfdt/fdt_rw.c?h=main&id=739403f222420a2fade2f939d001f51da473b6af]

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 tools/libfdt/fdt_rw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/libfdt/fdt_rw.c b/tools/libfdt/fdt_rw.c
index 7189f014295..8df1e97566d 100644
--- a/tools/libfdt/fdt_rw.c
+++ b/tools/libfdt/fdt_rw.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier:	GPL-2.0+ BSD-2-Clause */
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
 #include "fdt_host.h"
 #include "../../scripts/dtc/libfdt/fdt_rw.c"
 
-- 
2.43.0

