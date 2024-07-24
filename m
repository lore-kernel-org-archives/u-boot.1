Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4FCC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 06:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F9488955;
	Wed, 24 Jul 2024 08:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B1F88906; Wed, 24 Jul 2024 08:05:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id ECC198890F
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF608152B;
 Tue, 23 Jul 2024 23:05:22 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB9DD3F766;
 Tue, 23 Jul 2024 23:04:52 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 26/40] spl: call spl_board_init() at the end of the spl init
 sequence
Date: Wed, 24 Jul 2024 11:32:10 +0530
Message-Id: <20240724060224.3071065-27-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
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

The spl_board_init() function on sandbox invokes the unit
tests. Invoking the tests should be done once the rest of the system
has been initialised. Call the spl_board_init() function at the very
end, once the rest of the initilisation functions have been called,
including the setting up of the LMB memory map.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since rfc: New patch

 common/spl/spl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 38ac0608bb..891edde156 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -713,9 +713,6 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	if (CONFIG_IS_ENABLED(SOC_INIT))
 		spl_soc_init();
 
-	if (CONFIG_IS_ENABLED(BOARD_INIT))
-		spl_board_init();
-
 	if (IS_ENABLED(CONFIG_SPL_WATCHDOG) && CONFIG_IS_ENABLED(WDT))
 		initr_watchdog();
 
@@ -733,6 +730,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		/* Don't fail. We still can try other boot methods. */
 	}
 
+	if (CONFIG_IS_ENABLED(BOARD_INIT))
+		spl_board_init();
+
 	bootcount_inc();
 
 	/* Dump driver model states to aid analysis */
-- 
2.34.1

