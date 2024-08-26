Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B225C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 12:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385A588C4B;
	Mon, 26 Aug 2024 14:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6918D866EB; Mon, 26 Aug 2024 14:02:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6BEF788C1C
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 14:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19D53DA7;
 Mon, 26 Aug 2024 05:02:27 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DFC53F762;
 Mon, 26 Aug 2024 05:01:56 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 27/27] lmb: add logic to print lmb flag strings
Date: Mon, 26 Aug 2024 17:29:40 +0530
Message-Id: <20240826115940.3233167-28-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
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

Instead of printing the LMB flags as numerical values, print them as
strings. This makes it easier to understand what flags are associated
with the lmb region. Also make corresponding changes to the bdinfo
command's test code.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V3:
* Put the tertiary expression in the puts() function call as suggested
  by Simon Glass.
* s/uin64_t/u64 in lmb_print_region_flags() as suggested by checkpatch.

 lib/lmb.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 9f1bb5ec7d..3ed570fb29 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -27,6 +27,19 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static struct lmb lmb;
 
+static void lmb_print_region_flags(enum lmb_flags flags)
+{
+	u64 bitpos;
+	const char *flag_str[] = { "none", "no-map", "no-overwrite" };
+
+	do {
+		bitpos = flags ? fls(flags) - 1 : 0;
+		printf("%s", flag_str[bitpos]);
+		flags &= ~(1ull << bitpos);
+		puts(flags ? ", " : "\n");
+	} while (flags);
+}
+
 static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 {
 	struct lmb_region *rgn = lmb_rgn_lst->data;
@@ -42,8 +55,9 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 		end = base + size - 1;
 		flags = rgn[i].flags;
 
-		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x\n",
-		       name, i, base, end, size, flags);
+		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
+		       name, i, base, end, size);
+		lmb_print_region_flags(flags);
 	}
 }
 
-- 
2.34.1

