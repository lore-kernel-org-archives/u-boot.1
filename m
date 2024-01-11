Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6540BC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 08:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1DFA878B1;
	Thu, 11 Jan 2024 09:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UcchVjdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669C987ABA; Thu, 11 Jan 2024 09:27:33 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 429C48786C
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 09:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1704961651; x=1707553651;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KmzgJk6zWqDOQ1FmdLKYilCI5grV1dOI73dXUAF++u0=;
 b=UcchVjdA30septWqPehdCB4p0/V6e8j6yAVcGvrRJs+O6g1DmLUZNLgWVPf1LIAT
 /euOXH6PBxHBr427Rpe2onyjbFDEKpucYrdWZeoMphBlXVTz7mHFmp98yuuowegS
 /11BF8GxYOCg8azn6jMhnD4olD10tFTqfGmOMQvnJRQ=;
X-AuditID: ac14000a-fbefe7000000290d-f1-659fa672be2c
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 49.19.10509.276AF956;
 Thu, 11 Jan 2024 09:27:31 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 11 Jan
 2024 09:27:30 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 11 Jan 2024 09:26:24 +0100
Subject: [PATCH] board: phytec: fix link error when disabling
 PHYTEC_SOM_DETECTION
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240111-wip-y-moog-phytec-de-som-detection-fixup-v1-1-7c1a63e7eee8@phytec.de>
X-B4-Tracking: v=1; b=H4sIAC+mn2UC/x2NwQqDMBBEf0X23AEjEaW/UjyEZKt70IREqyL+u
 0tPw2N4MxcVzsKF3tVFmX9SJC4K5lWRn9wyMiQoU1M3tjbGYJeEE3OMI9J0ruwRGCXOGgqr6vj
 KsSW03gXubOds70jnUmYt/lef4b4fmhU173oAAAA=
To: Fabio Estevam <festevam@gmail.com>, Teresa Remmet <t.remmet@phytec.de>,
 <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWyRpKBR7d42fxUg/Zoi4dX/S3e7u1kt+h+
 p+7A7LFz1l12j7N3djB69He3sAYwR3HZpKTmZJalFunbJXBlbNhwlq3gMUfFlCc7mBoYL7J3
 MXJySAiYSOz/8RDI5uIQEljMJPHv1HJWCOcho8Tsy+cYQarYBFQkHr+4xwpiswioSpxs6Qez
 hQVCJHq+bmEBsXkFBCVOznwCZHNwMAtoSqzfpQ8SZhaQl9j+dg4zREm0xPFznawQi48wSqzu
 qgXZJSLQwChx9sUedogGJYnTV9tYIIqEJdoX3WICsYUEZCVenO+FulpeYtq518wQdqjE1i/b
 mSYwCs5CcsYshDNmITljASPzKkah3Mzk7NSizGy9gozKktRkvZTUTYygsBVh4NrB2DfH4xAj
 EwfjIUYJDmYlEV6Fz3NShXhTEiurUovy44tKc1KLDzFKc7AoifOu7ghOFRJITyxJzU5NLUgt
 gskycXBKNTCuqF8aYfMo6Lax1tSF079/VXuyTVTzs6a5S0z5jfabRy/8mvGoa85ZS4uKZW93
 fgkz7WIMuizDEGbfLe+hETCZ3W3/x6/8PT4v6q8FW87+OuXL9LRek11H11x139GzoZy1bR/j
 lP0TWeK/27DoCus90zD5azxP6uHKBdMutYaGdZrVz3sts7dAiaU4I9FQi7moOBEATgShYUkC
 AAA=
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

Commit aa7858fe5e2e ("board: phytec: som_detection: move definitions to
source file") moved function definitions from header to source file.
Makefile however was not updated to unconditionally build the imx8 and
phytec som detection units. Fix this.

Fixes: aa7858fe5e2e ("board: phytec: som_detection: move definitions to source file")
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/common/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index fe28964ce21..5f8e8435413 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -7,5 +7,4 @@ ifdef CONFIG_SPL_BUILD
 obj- := __dummy__.o
 endif
 
-obj-$(CONFIG_PHYTEC_SOM_DETECTION) += phytec_som_detection.o
-obj-$(CONFIG_PHYTEC_IMX8M_SOM_DETECTION) += imx8m_som_detection.o
+obj-y += phytec_som_detection.o imx8m_som_detection.o

---
base-commit: 7a59d520ef0bfd29b339cba5282149271d5ac3b2
change-id: 20240111-wip-y-moog-phytec-de-som-detection-fixup-5cade747a48a

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

