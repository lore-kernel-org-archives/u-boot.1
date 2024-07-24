Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53012C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 06:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 980F18881C;
	Wed, 24 Jul 2024 08:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26BC688845; Wed, 24 Jul 2024 08:03:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3790488005
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D62E1476;
 Tue, 23 Jul 2024 23:03:34 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A3FF3F766;
 Tue, 23 Jul 2024 23:03:03 -0700 (PDT)
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
Subject: [PATCH 05/40] spl: alloc: call full alloc functions if malloc pool is
 available
Date: Wed, 24 Jul 2024 11:31:49 +0530
Message-Id: <20240724060224.3071065-6-sughosh.ganu@linaro.org>
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

If the malloc simple functionality is enabled in SPL, it is not
possible to call the full-implementation alloc functions even after
the heap is set-up in ram memory. Check for this condition and
call the functions when enabled.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since rfc: New patch

 common/malloc_simple.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/malloc_simple.c b/common/malloc_simple.c
index 4e6d7952b3..982287defe 100644
--- a/common/malloc_simple.c
+++ b/common/malloc_simple.c
@@ -40,6 +40,10 @@ void *malloc_simple(size_t bytes)
 {
 	void *ptr;
 
+#if IS_ENABLED(CONFIG_SPL_SYS_MALLOC) && IS_ENABLED(CONFIG_SPL_LMB)
+	if (gd->flags & GD_FLG_FULL_MALLOC_INIT)
+		return mALLOc(bytes);
+#endif
 	ptr = alloc_simple(bytes, 1);
 	if (!ptr)
 		return ptr;
@@ -50,6 +54,15 @@ void *malloc_simple(size_t bytes)
 	return ptr;
 }
 
+void *realloc_simple(void *oldmem, size_t bytes)
+{
+#if IS_ENABLED(CONFIG_SPL_SYS_MALLOC) && IS_ENABLED(CONFIG_SPL_LMB)
+	if (gd->flags & GD_FLG_FULL_MALLOC_INIT)
+		return rEALLOc(oldmem, bytes);
+#endif
+	return NULL;
+}
+
 void *memalign_simple(size_t align, size_t bytes)
 {
 	void *ptr;
-- 
2.34.1

