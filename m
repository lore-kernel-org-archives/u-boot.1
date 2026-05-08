Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9670FCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 13:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3963384CE4;
	Fri,  8 May 2026 15:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="Sjm+zKRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C5A584CE3; Fri,  8 May 2026 15:54:58 +0200 (CEST)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F61784CDB
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 15:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from y14 (unknown [IPv6:2a01:e0a:2af:22b0:d1a5:1153:d371:3c9c])
 (Authenticated sender: vjardin@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0F00B2003E8;
 Fri,  8 May 2026 15:54:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1778248496;
 bh=b0woAqm4EE3bqUM4RoG4VlKR6SZgdcfgc2keDksHNzw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sjm+zKRboHkOxE9HN2aqaeNJyo0oPFe7UjkFPyzqC3ALt+QZBN8AbVd/mVJ3+o62h
 blLgfsMMp1vFj6QAvbztn2FJGuxWNl3zqVC848w0Kh6j2WmXE1vFE/AFiVgq8AW15F
 /25dnOP0iFtKiFbtZpC7iEpdxK/QQJnJkufpj0aE7IucIMU98KRtHpArzOqHHyqcCl
 8ihunEAi5EnQiQmHpldrfXRo+cGyuOLYSeRBKJeiL6YJ0QpOyk38uPTq3izt8k19Hk
 HmCbRY3PIZD3rjKfePXM+R54zxhn2s65c+fleMAe896dkDb4TFp0YLBH4THyt9DibQ
 WYG5trNYs5KJg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 5/5] arm: dts: armada-8040-nbx: add U-Boot dtsi for
 conditional OP-TEE
Date: Fri,  8 May 2026 15:54:08 +0200
Message-ID: <92034904751b86de64d8f97bec13b8262949c08e.1778247592.git.vjardin@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778247592.git.vjardin@free.fr>
References: <cover.1776762022.git.vjardin@free.fr>
 <cover.1778247592.git.vjardin@free.fr>
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

Add armada-8040-nbx-u-boot.dtsi with the firmware/optee node guarded
by CONFIG_OPTEE. This allows U-Boot to probe the OP-TEE driver only
when OP-TEE support is enabled in the configuration.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
---
Changes in v3:
- Move per-patch changelog below --- per U-Boot guidelines (Stefan)

Changes in v2:
- Added Reviewed-by Stefan

 arch/arm/dts/armada-8040-nbx-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm/dts/armada-8040-nbx-u-boot.dtsi

diff --git a/arch/arm/dts/armada-8040-nbx-u-boot.dtsi b/arch/arm/dts/armada-8040-nbx-u-boot.dtsi
new file mode 100644
index 00000000000..dec473b7156
--- /dev/null
+++ b/arch/arm/dts/armada-8040-nbx-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Free Mobile, Vincent Jardin
+ */
+
+#ifdef CONFIG_OPTEE
+/ {
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+};
+#endif
-- 
2.53.0

