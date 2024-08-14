Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EE6C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B2688AC2;
	Wed, 14 Aug 2024 13:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75A4A88A27; Wed, 14 Aug 2024 13:03:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4F264889D0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8BA3DA7;
 Wed, 14 Aug 2024 04:03:39 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3548D3F58B;
 Wed, 14 Aug 2024 04:03:08 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 32/32] lmb: add logic to print lmb flag strings
Date: Wed, 14 Aug 2024 16:30:09 +0530
Message-Id: <20240814110009.45310-33-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814110009.45310-1-sughosh.ganu@linaro.org>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
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
---
Changes since V1: New patch

 lib/lmb.c         | 18 ++++++++++++++++--
 test/cmd/bdinfo.c |  4 ++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 37d2a72951..5c5b3e9bb5 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -26,6 +26,19 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static struct lmb lmb;
 
+static void print_region_flags(enum lmb_flags flags)
+{
+	uint64_t bitpos;
+	const char *flag_str[] = { "LMB_NONE", "LMB_NOMAP", "LMB_NOOVERWRITE" };
+
+	do {
+		bitpos = fls(flags) - 1;
+		printf("%s", flag_str[bitpos]);
+		flags &= ~(1ull << bitpos);
+		flags ? puts(", ") : puts("\n");
+	} while (flags);
+}
+
 static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 {
 	struct lmb_region *rgn = lmb_rgn_lst->data;
@@ -41,8 +54,9 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 		end = base + size - 1;
 		flags = rgn[i].flags;
 
-		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x\n",
-		       name, i, base, end, size, flags);
+		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
+		       name, i, base, end, size);
+		print_region_flags(flags);
 	}
 }
 
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 7dd3f7ca5b..887defc28a 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -120,8 +120,8 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
 			ut_assert_nextlinen(" %s[%d]\t[", name, i);
 			continue;
 		}
-		ut_assert_nextline(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x",
-				   name, i, base, end, size, flags);
+		ut_assert_nextlinen(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
+				   name, i, base, end, size);
 	}
 
 	return 0;
-- 
2.34.1

