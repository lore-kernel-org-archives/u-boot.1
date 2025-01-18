Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E65C02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A26A80761;
	Sat, 18 Jan 2025 05:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vin1XFmk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YcSthUvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB2080786; Sat, 18 Jan 2025 05:02:15 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2594480758
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZjbm13FWz9sbl;
 Sat, 18 Jan 2025 05:02:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVQ2KsZCF1RPttG/7wBu8fsA6BUmk+PsLoBm9//ENjU=;
 b=vin1XFmkKTd/sTzi5JCTm1axCF6m7oGXJ3uoq555NY0liEz7KI66P9l6Vv7JFc/NuD7Vl0
 +fvHvKJRAYcrzW1rybnA8HQ0PMuNHac+CefTI+xt/lSZlZnGGF/d7OFNcGRgnsttCOQ2wH
 lVIKPS4Y9OeJ+AIr+SVjDL93//CdYpV1q2FqVkP8Kp58tS33j1O9SVqi/rQ/LqzU2dSuTJ
 9ftk9l8YBMKfS7/mFYNQ1zwVs8cN+aGWqrdayQK168Sbw7hHkIaSbkE3ssf8O22IWiHizv
 2uLMwu6pqKiCi8feENzA+izqGtCj8QPJOrawBY15bXXqqgoLy0/Sh3I94qW9tw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVQ2KsZCF1RPttG/7wBu8fsA6BUmk+PsLoBm9//ENjU=;
 b=YcSthUvg1eRcK4bfFSvdjKi/BvUDA965JSxbDDdS/HTl+9tBJ+WXJr9s2XajIO12fzt0PG
 JbI3TwVkQFeSemY1f62mxFwcnZar7b6hEzDgWn2FE/WPMlqF381fEJqPmAzB1D0FNCcn9x
 EP68pPu+0oa2oFnjLIK04mhhPz7DvbvRum5pQ2ypM78kmFQVYRp2a2heshcjko0AKTcUvw
 f7eRNDkF666bK1LAJjKtJcxEkkRQv91UpZvyCIUFyj69C4VfnRQ9wcroq9PkDgsYaUgxSY
 LitwSzAzB2ofEmOK4PHTrrFWhZUqN1L1+5yJ//gvdXGuMUcpA03tWFeBwwMwbQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aaron Williams <awilliams@marvell.com>, Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/8] cyclic: Test return code from cyclic_register() in test
Date: Sat, 18 Jan 2025 05:00:57 +0100
Message-ID: <20250118040130.74921-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
References: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a39b5097dc9731fa463
X-MBO-RS-META: 5picophz61imx7uowuz3af573d7yfyd1
X-Rspamd-Queue-Id: 4YZjbm13FWz9sbl
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

Update the cyclic test code to verify return code from cyclic_register() works.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aaron Williams <awilliams@marvell.com>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Devarsh Thakkar <devarsht@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 test/common/cyclic.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/test/common/cyclic.c b/test/common/cyclic.c
index 51a07c576b6..714dec60b7f 100644
--- a/test/common/cyclic.c
+++ b/test/common/cyclic.c
@@ -25,8 +25,11 @@ static void test_cb(struct cyclic_info *c)
 
 static int dm_test_cyclic_running(struct unit_test_state *uts)
 {
+	int ret;
+
 	cyclic_test.called = false;
-	cyclic_register(&cyclic_test.cyclic, test_cb, 10 * 1000, "cyclic_test");
+	ret = cyclic_register(&cyclic_test.cyclic, test_cb, 10 * 1000, "cyclic_test");
+	ut_asserteq(ret, 0);
 
 	/* Execute all registered cyclic functions */
 	schedule();
@@ -37,3 +40,19 @@ static int dm_test_cyclic_running(struct unit_test_state *uts)
 	return 0;
 }
 COMMON_TEST(dm_test_cyclic_running, 0);
+
+static int dm_test_cyclic_reregister(struct unit_test_state *uts)
+{
+	int ret;
+
+	cyclic_test.called = false;
+	ret = cyclic_register(&cyclic_test.cyclic, test_cb, 10 * 1000, "cyclic_test1");
+	ut_asserteq(ret, 0);
+	ret = cyclic_register(&cyclic_test.cyclic, test_cb, 10 * 1000, "cyclic_test2");
+	ut_asserteq(ret, -EALREADY);
+
+	cyclic_unregister(&cyclic_test.cyclic);
+
+	return 0;
+}
+COMMON_TEST(dm_test_cyclic_reregister, 0);
-- 
2.45.2

