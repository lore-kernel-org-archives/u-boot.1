Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A166FEC8745
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECB4286487;
	Thu,  7 Sep 2023 18:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lggDYX7d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 682278657B; Thu,  7 Sep 2023 18:45:51 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D99D686410
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 18:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9FDF73F6E7; 
 Thu,  7 Sep 2023 16:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1694105145;
 bh=FHxxc/gJhResXFFA1OFLUV2q7pzG1B+ksxjn5C4xO7s=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=lggDYX7da88NcGe3Gq+56vDO1/2JzBhnZML3rOc/qLSp+0YDut6KFHLTd0tq0KyDb
 UzGFFNi69LdLoUt4bf1i11XW4HqSz0yNC1p5ZuefK/QroZZNJS97QbX0LnuZAHbE1/
 ZZlT4wZ8/0BZCUgGqeW6j6wsw/rnQDfRz7ZZl9BMnvcVewRApFuOyuKGL/Yj6g9+NK
 SJdAN50Q28ZpGDUJodPVi4dgCdtsglPMDSeIVU4O/SlmFRtsJCrAAgiKMJPMD7k6iX
 ud7JxrXyiNutDjfMU2LPDS9WFl+7bEJv297cM48Qa/NbM+RutBpHoMRIkXtYfJVwyE
 MZdK3uhGZTF2g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: build dependency for event unit tests
Date: Thu,  7 Sep 2023 18:43:17 +0200
Message-Id: <20230907164317.378832-1-heinrich.schuchardt@canonical.com>
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

The test_event_base and test_event_probe unit tests use function
event_register() which depends on CONFIG_EVENT_DYNAMIC=y.

Fixes: 7d02645fe4c0 ("event: Add a simple test")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/common/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/common/Makefile b/test/common/Makefile
index a5ab10f6f6..12c65f8c95 100644
--- a/test/common/Makefile
+++ b/test/common/Makefile
@@ -2,5 +2,5 @@
 obj-y += cmd_ut_common.o
 obj-$(CONFIG_AUTOBOOT) += test_autoboot.o
 obj-$(CONFIG_CYCLIC) += cyclic.o
-obj-$(CONFIG_EVENT) += event.o
+obj-$(CONFIG_EVENT_DYNAMIC) += event.o
 obj-y += cread.o
-- 
2.40.1

