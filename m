Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A601FCD4933
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 22:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A889786C8B;
	Thu, 21 Sep 2023 00:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BGjCpZ8A";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hydNF9q2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A179186C6B; Thu, 21 Sep 2023 00:58:44 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8700386C29
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 00:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RrYqQ3V59z9tSX;
 Thu, 21 Sep 2023 00:58:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/9j7+uABEHhKR99CUy1lpE5Smmjs4tWraYmiMNdZ38=;
 b=BGjCpZ8AW47vy/pJ90jR5h0wL/cKsdmKbqDQ/u3SjTK9KM6iTK7W067WmfwURWSPjVpSdK
 MiO0LbfXUDHrzlJfb9GBlxU0HkqrV6p4I2xfPcPvCkL2+Wx1+EG0wqaetMSlcNjgLX+LH9
 yDqSBSri42MP+3xwTINpcUEQnjmqkCGLo1EO+otDVtVxGvb09c1jB8ynn2FyN1xNz+gviv
 ytQz3uXex5YMwukoNdFhn4WJVhRTcvnRVaJfW1s+24YzgeAaD+guvVz1M6tTh7tqWA9R9j
 /spH7jSpW/NAPQPy+saCjLeZyQOp1DKoSSBhmvv6D2ll6fJPTxxTYYG/d1fWxg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/9j7+uABEHhKR99CUy1lpE5Smmjs4tWraYmiMNdZ38=;
 b=hydNF9q2RykVh2l655mIiUPEilmrJ6FhL0CX9brcngjNM1I7Fhg0FKZrmMX/QV93c5P3Bl
 LuSinlOHm1fJyuBPGuiwZh4cO+Mwkm0zGAGXEzTgWLfRvsuPc18t+3QqFIvDX+oAviqV/H
 o1CGAzzj1z4y9PI+1PvGSXoxC3pcQeMuCKl2HGF3EMsc5LzSgvus8CDIvdh/faFqrdidjF
 SnkCFKK+Bcs0IBJhFHFJMgbbCxhWLnR/YJHWwo798au7kbR7IYi7LmbdOHA9JMq51i0obo
 Tyo6VP4dwRR6cAeFOT9oQc8Z9Fl8ER3whBL51HVh2ty63tx4RFpIZOdi7uq/Bw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 7/9] test: bdinfo: Test bdinfo -h
Date: Thu, 21 Sep 2023 00:58:09 +0200
Message-Id: <20230920225811.153474-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f1cbbef883dd5024018
X-MBO-RS-META: 5ggprdwrpebsby7u1ufaa3epxifxrqzr
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

The bdinfo -h should print error message that -h is an unknown
parameter and then command help text. Test the expected output.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
 test/cmd/bdinfo.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 509a8b5c586..2f34d877e5c 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -226,6 +226,23 @@ static int bdinfo_test_full(struct unit_test_state *uts)
 
 BDINFO_TEST(bdinfo_test_full, UT_TESTF_CONSOLE_REC);
 
+static int bdinfo_test_help(struct unit_test_state *uts)
+{
+	/* Test BDINFO unknown option help text print */
+	ut_assertok(console_record_reset_enable());
+	ut_asserteq(1, run_commandf("bdinfo -h"));
+	ut_assert_nextlinen("bdinfo: invalid option -- h");
+	ut_assert_nextlinen("bdinfo - print Board Info structure");
+	ut_assert_nextline_empty();
+	ut_assert_nextlinen("Usage:");
+	ut_assert_nextlinen("bdinfo");
+	ut_assertok(ut_check_console_end(uts));
+
+	return 0;
+}
+
+BDINFO_TEST(bdinfo_test_help, UT_TESTF_CONSOLE_REC);
+
 int do_ut_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct unit_test *tests = UNIT_TEST_SUITE_START(bdinfo_test);
-- 
2.40.1

