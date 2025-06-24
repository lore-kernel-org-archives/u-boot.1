Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D01C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 12:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E4582DA1;
	Tue, 24 Jun 2025 14:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 090BC82C84; Tue, 24 Jun 2025 14:07:53 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9EB8482C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 14:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01A53113E;
 Tue, 24 Jun 2025 05:07:32 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB0063F66E;
 Tue, 24 Jun 2025 05:07:47 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 2/2] test: wget: add a test case for validating URI
Date: Tue, 24 Jun 2025 17:37:30 +0530
Message-Id: <20250624120730.2158194-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624120730.2158194-1-sughosh.ganu@linaro.org>
References: <20250624120730.2158194-1-sughosh.ganu@linaro.org>
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

The wget module has a function wget_validate_uri() which is used for
validating the URI to be used by wget. Add a basic test case for this
function.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: New patch

 test/cmd/wget.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index 445750660c2..1005392b952 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -241,3 +241,23 @@ static int net_test_wget(struct unit_test_state *uts)
 	return 0;
 }
 CMD_TEST(net_test_wget, UTF_CONSOLE);
+
+static int net_test_wget_uri_validate(struct unit_test_state *uts)
+{
+	ut_asserteq(true, wget_validate_uri("http://foo.com/bar.html"));
+	ut_asserteq(true, wget_validate_uri("http://1.1.2.3/bar.html"));
+	ut_asserteq(false, wget_validate_uri("http://foo/ba r.html"));
+	ut_asserteq(false, wget_validate_uri("http://"));
+
+	if (CONFIG_IS_ENABLED(WGET_HTTPS)) {
+		ut_asserteq(true,
+			    wget_validate_uri("https://foo.com/bar.html"));
+		ut_asserteq(true,
+			    wget_validate_uri("https://1.1.2.3/bar.html"));
+		ut_asserteq(false, wget_validate_uri("https://foo/ba r.html"));
+		ut_asserteq(false, wget_validate_uri("https://"));
+	}
+
+	return 0;
+}
+CMD_TEST(net_test_wget_uri_validate, UTF_CONSOLE);
-- 
2.34.1

