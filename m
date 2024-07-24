Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEFEC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 06:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 308068888E;
	Wed, 24 Jul 2024 08:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 716DD88005; Wed, 24 Jul 2024 08:03:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2139C8881B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C23F106F;
 Tue, 23 Jul 2024 23:03:29 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECE803F766;
 Tue, 23 Jul 2024 23:02:58 -0700 (PDT)
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
Subject: [PATCH 04/40] lib: Convert str_to_list() to use alist
Date: Wed, 24 Jul 2024 11:31:48 +0530
Message-Id: <20240724060224.3071065-5-sughosh.ganu@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

Use this new data structure in the utility function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/strto.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/lib/strto.c b/lib/strto.c
index f83ac67c66..277e83b20f 100644
--- a/lib/strto.c
+++ b/lib/strto.c
@@ -9,6 +9,7 @@
  * Wirzenius wrote this portably, Torvalds fucked it up :-)
  */
 
+#include <alist.h>
 #include <errno.h>
 #include <malloc.h>
 #include <vsprintf.h>
@@ -226,37 +227,39 @@ void str_to_upper(const char *in, char *out, size_t len)
 
 const char **str_to_list(const char *instr)
 {
-	const char **ptr;
-	char *str, *p;
-	int count, i;
+	struct alist alist;
+	char *str, *p, *start;
 
 	/* don't allocate if the string is empty */
 	str = *instr ? strdup(instr) : (char *)instr;
 	if (!str)
 		return NULL;
 
-	/* count the number of space-separated strings */
-	for (count = 0, p = str; *p; p++) {
+	alist_init_struct(&alist, char *);
+
+	if (*str)
+		alist_add(&alist, str, char *);
+	for (start = str, p = str; *p; p++) {
 		if (*p == ' ') {
-			count++;
 			*p = '\0';
+			start = p + 1;
+			if (*start)
+				alist_add(&alist, start, char *);
 		}
 	}
-	if (p != str && p[-1])
-		count++;
 
-	/* allocate the pointer array, allowing for a NULL terminator */
-	ptr = calloc(count + 1, sizeof(char *));
-	if (!ptr) {
-		if (*str)
+	/* terminate list */
+	p = NULL;
+	alist_add(&alist, p, char *);
+	if (alist_err(&alist)) {
+		alist_uninit(&alist);
+
+		if (*instr)
 			free(str);
 		return NULL;
 	}
 
-	for (i = 0, p = str; i < count; p += strlen(p) + 1, i++)
-		ptr[i] = p;
-
-	return ptr;
+	return alist_uninit_move(&alist, NULL, const char *);
 }
 
 void str_free_list(const char **ptr)
-- 
2.34.1

