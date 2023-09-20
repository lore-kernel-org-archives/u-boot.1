Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B77BCD4933
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 23:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E82586C78;
	Thu, 21 Sep 2023 00:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ykBfpRaS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YDanPVFr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F25886C58; Thu, 21 Sep 2023 00:58:46 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36D9886C40
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 00:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RrYqS0rB3z9sy9;
 Thu, 21 Sep 2023 00:58:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPE9DObCSPy/mABUifYxDnJzyfL9hQP7Vaz41MjeS7g=;
 b=ykBfpRaS75vbfrpjYGEWYmZPIeiKzGQany7lkf5OMKmLK5pchAU0lG+sYOqRyrKkp567ZP
 7aQYgZAOuq+jQNw0nnDq//KYPuEev3vZQH+GPYKW1ja6DQUaB3oLUL5v0iKffVT28yoNl9
 C/BVGG4wC0JIucKuOo3wZ/4DK6igyMgUzQ43Ff6Cj+4tqn9rrYlY2LMKd3G+yPt0WS63dF
 IpX3navfmdDfvNx25TMVWH7dL35P/qAmmKbMy2itiav6kRvj2n0IkyTjsBGPgz2ygjYqu2
 ui+/wK6SP9vTstPzyj0PZcnH4/yZIUWriDuoGFXOBVOJWzAW+lfRilHnvV1Iqw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPE9DObCSPy/mABUifYxDnJzyfL9hQP7Vaz41MjeS7g=;
 b=YDanPVFrbCh8465y6CIHtDTlG/2sLXu6YB5UkvxNp3uGZJR+T3LwCbtA4oMhSSbMWwgx7v
 A7TCKOwr6Jd/Dl7mTBwyhO0NRZ7ezkvkzUk3YJyg1+uGrs0HQhCIgPZnPj9OwBgMI/BS17
 Q0TXPXBX3tW8mTslgzrr1QzZWL2JTkxd0adqKLcfaPMCWmFyH6anrVhyARR4kIwBchuxFa
 fSAEKQSsbwRMnM58GI1J1/ei2G1NzqcuwnR21GfvGnJRLhvZOGDUS/a66ZCYVmhlXvEEUT
 N4vegjtKCoKcf+fF60NRhdbpgXWSnm3nRoMejLdLOAMNfUOgqtCHUyGi4r7TCg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 9/9] test: bdinfo: Test bdinfo -e
Date: Thu, 21 Sep 2023 00:58:11 +0200
Message-Id: <20230920225811.153474-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 23f1c4b090ca61f66b3
X-MBO-RS-META: spr5ba15sqgcth9dhnjkkmw6k7yrfy9z
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

The bdinfo -e should print only the board ethernet settings.
Test the expected output.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
 test/cmd/bdinfo.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index f090667fb42..6caee4b0b50 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -263,6 +263,20 @@ static int bdinfo_test_memory(struct unit_test_state *uts)
 
 BDINFO_TEST(bdinfo_test_memory, UT_TESTF_CONSOLE_REC);
 
+static int bdinfo_test_eth(struct unit_test_state *uts)
+{
+	/* Test BDINFO ethernet settings only print */
+	ut_assertok(console_record_reset_enable());
+	ut_assertok(run_commandf("bdinfo -e"));
+	if (IS_ENABLED(CONFIG_CMD_NET))
+		ut_assertok(test_eth(uts));
+	ut_assertok(ut_check_console_end(uts));
+
+	return 0;
+}
+
+BDINFO_TEST(bdinfo_test_eth, UT_TESTF_CONSOLE_REC);
+
 int do_ut_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct unit_test *tests = UNIT_TEST_SUITE_START(bdinfo_test);
-- 
2.40.1

