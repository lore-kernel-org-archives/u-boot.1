Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB15C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0136B884B0;
	Fri,  7 Jun 2024 20:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9659F88445; Fri,  7 Jun 2024 20:54:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A7274884B0
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 847CF1480;
 Fri,  7 Jun 2024 11:55:14 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ADDF3F792;
 Fri,  7 Jun 2024 11:54:47 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 24/31] test: lmb: add a test case for checking overlapping
 region add
Date: Sat,  8 Jun 2024 00:22:33 +0530
Message-Id: <20240607185240.1892031-25-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
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

Memory managed by LMB is now persistent and global. With that, it
could be possible for multiple callers to try to add memory that has
already been added. Add a test case to check that the LMB module
handles it as expected.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 test/lib/lmb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 260ebcfcd3..9b0e023b67 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -419,6 +419,22 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 }
 LIB_TEST(lib_test_lmb_at_0, 0);
 
+static int lib_test_lmb_overlapping_add(struct unit_test_state *uts)
+{
+	const phys_addr_t ram = 0x40000000;
+	const phys_size_t ram_size = 0x20000000;
+	long ret;
+
+	ret = lmb_add(ram, ram_size);
+	ut_asserteq(ret, 0);
+
+	ret = lmb_add(ram, ram_size);
+	ut_asserteq(ret, 0);
+
+	return 0;
+}
+LIB_TEST(lib_test_lmb_overlapping_add, 0);
+
 /* Check that calling lmb_reserve with overlapping regions fails. */
 static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 {
-- 
2.34.1

