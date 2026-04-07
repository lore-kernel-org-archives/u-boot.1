Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592B9FF5126
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 16:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91DDD8404A;
	Tue,  7 Apr 2026 18:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="vDu8ZeC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CB784105; Tue,  7 Apr 2026 18:40:29 +0200 (CEST)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ba])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B5D283F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 18:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1775580026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yZS3B2+fXMJaraUT0MbMdHi1Y0401Bwfo4kIbl7gQFU=;
 b=vDu8ZeC6soQ0Ho5soaumk9eOAH27by3hkln1B4fl6naDA3Q17yYrQC24rcgButA1UB9Ik7
 dXBXcNj/bGExX/YRN0qyHDJ6xVRPdWaQN1OOeNlQiK0wm/BuCFNBcLUbryxuL/yutzfFsv
 aXRGWO2NeIldiRff00lLsZAGmVUpPWo=
From: Sean Anderson <sean.anderson@linux.dev>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] Update my email address
Date: Tue,  7 Apr 2026 12:40:10 -0400
Message-Id: <20260407164011.210590-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Soon I will no longer be working at SECO. Update the mailmap to redirect
to my linux.dev address which I still have access to.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 6ac4b9b9e5e..337dcba5545 100644
--- a/.mailmap
+++ b/.mailmap
@@ -131,6 +131,7 @@ Sam Protsenko <semen.protsenko@linaro.org> <joe.skb7@gmail.com>
 Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com> <sandeep.gundlupet-raju@xilinx.com>
 Sandeep Paulraj <s-paulraj@ti.com>
 Sandeep Reddy Ghanapuram <sandeep.reddy-ghanapuram@amd.com> <sandeep.reddy-ghanapuram@xilinx.com>
+Sean Anderson <sean.anderson@linux.dev> <sean.anderson@seco.com>
 Shaohui Xie <Shaohui.Xie@freescale.com>
 Shravya Kumbham <shravya.kumbham@amd.com> <shravya.kumbham@xilinx.com>
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com> <shubhrajyoti.datta@xilinx.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 6c596971ae4..01293b23d25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -361,7 +361,7 @@ F:	drivers/rng/msm_rng.c
 F:	drivers/pinctrl/qcom/pinctrl-ipq4019.c
 
 ARM LAYERSCAPE SFP
-M:	Sean Anderson <sean.anderson@seco.com>
+M:	Sean Anderson <sean.anderson@linux.dev>
 S:	Maintained
 F:	drivers/misc/ls2_sfp.c
 
@@ -1700,7 +1700,7 @@ F:	doc/usage/cmd/seama.rst
 F:	test/cmd/seama.c
 
 SEMIHOSTING
-R:	Sean Anderson <sean.anderson@seco.com>
+R:	Sean Anderson <sean.anderson@linux.dev>
 S:	Orphaned
 N:	semihosting
 
-- 
2.35.1.1320.gc452695387.dirty

base-commit: 93f84ee022a8401421cdaab84fe7d106d83fdb4a
branch: email
