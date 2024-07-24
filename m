Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB27C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 06:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E64988908;
	Wed, 24 Jul 2024 08:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83ABE887CE; Wed, 24 Jul 2024 08:04:37 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3FEFB88847
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34917106F;
 Tue, 23 Jul 2024 23:04:57 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FE9A3F766;
 Tue, 23 Jul 2024 23:04:26 -0700 (PDT)
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
Subject: [PATCH 21/40] lmb: bootm: remove superfluous lmb stub functions
Date: Wed, 24 Jul 2024 11:32:05 +0530
Message-Id: <20240724060224.3071065-22-sughosh.ganu@linaro.org>
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

Remove a couple of superfluous LMB stub functions, and instead put a
check for calling the lmb_reserve() function.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since rfc: New patch

 boot/bootm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index d44fd2ed87..2689f36977 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -239,11 +239,6 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 	return 0;
 }
 
-#if !CONFIG_IS_ENABLED(LMB)
-#define lmb_reserve(base, size)
-static inline void boot_start_lmb(void) { }
-#endif
-
 static int bootm_start(void)
 {
 	memset((void *)&images, 0, sizeof(images));
@@ -700,7 +695,9 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 		images->os.end = relocated_addr + image_size;
 	}
 
-	lmb_reserve(images->os.load, (load_end - images->os.load));
+	if (CONFIG_IS_ENABLED(LMB))
+		lmb_reserve(images->os.load, (load_end - images->os.load));
+
 	return 0;
 }
 
-- 
2.34.1

