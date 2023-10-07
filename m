Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0D8E95A6B
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E544986DFA;
	Sat,  7 Oct 2023 23:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GU+gHqwE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jgmTW3sQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 355F186DE6; Sat,  7 Oct 2023 23:41:37 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E350D86DF9
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4S2zJL5b1sz9spv;
 Sat,  7 Oct 2023 23:41:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMkrVFCoQdRvKs9/3V48eXyQyNQ5S2mCSFv9JHdZdto=;
 b=GU+gHqwElABn4WThG9eOG1cApMCBMs0E3eiyeJv2YdnoPRGSoZunu5FKStXAauL1we1spH
 P71hzbaby1Zu+z1ZrD4n1XGTDYgLC4qIQ7ykC/P/7bQnqSTVT4jhjh2PzUSDkAL01rMeDt
 rwp+sfthSIw5wWx7b1T/uxIrgZI/lyEMXmIS/nV1oDP/ZDvI5Ett9N1f1tAIUVs6kNjR1U
 n8IkBAtntxhHontWfpukSfjDEbhGOtDXj4LAniDQm61lJSeZ1DCyCuXdqGmVBzKvdnD31D
 0Yw5eT5og3wACnBPcPS3IJplu6SISzzajcwPpFn8xAypuAlj9iICIuivIgpu/g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMkrVFCoQdRvKs9/3V48eXyQyNQ5S2mCSFv9JHdZdto=;
 b=jgmTW3sQF1Id7OjnouUI5rd6C6z0q3gJcPLvjTb+pDcdytgzG5qpuymbgSd5+7UghRRXRw
 tIG023suT90jSQpD8Tsz0EtT43b9iAtwsyOJHHE+8zu8KmZc+jK7YgKUMlhve69IIOlDf5
 Oi98JZSLaLBuXagFa2y0bjOsAIZSqvgLi7CZaHHu/xlpy2GpI6WX96MLy1yRv9v+/crdpM
 423Z8AByv0rt7n3x56NL49hRrzITc7EjYPSTTVMrQD8Oii1ifkMY2gHaAhUgxNbq1IlEzA
 YXkmh+nMt04a38kCgLn32QkBjuBguQnOXnIXeKWa5+UsbaIZlCmMDuIzCiVdzw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v2 6/9] test: bdinfo: Test both bdinfo and bdinfo -a
Date: Sat,  7 Oct 2023 23:41:03 +0200
Message-Id: <20231007214106.15744-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
References: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9rwjbupzmz43a85tcrbifd1fuiosa99p
X-MBO-RS-ID: 660cd50863bebd98444
X-Rspamd-Queue-Id: 4S2zJL5b1sz9spv
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

Factor out the core of test for all bdinfo output into bdinfo_test_all()
and then reuse it to verify that both 'bdinfo' and 'bdinfo -a' print all
the bdinfo output.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: Add RB from Simon
---
 test/cmd/bdinfo.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index b2896e8eb41..509a8b5c586 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -130,15 +130,11 @@ static int lmb_test_dump_all(struct unit_test_state *uts, struct lmb *lmb)
 	return 0;
 }
 
-static int bdinfo_test_full(struct unit_test_state *uts)
+static int bdinfo_test_all(struct unit_test_state *uts)
 {
 	struct bd_info *bd = gd->bd;
 	int i;
 
-	/* Test moving the working BDINFO to a new location */
-	ut_assertok(console_record_reset_enable());
-	ut_assertok(run_commandf("bdinfo"));
-
 	ut_assertok(test_num_l(uts, "boot_params", 0));
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; ++i) {
@@ -212,6 +208,17 @@ static int bdinfo_test_full(struct unit_test_state *uts)
 		ut_assertok(test_num_l(uts, "malloc base", gd_malloc_start()));
 	}
 
+	return 0;
+}
+
+static int bdinfo_test_full(struct unit_test_state *uts)
+{
+	/* Test BDINFO full print */
+	ut_assertok(console_record_reset_enable());
+	ut_assertok(run_commandf("bdinfo"));
+	ut_assertok(bdinfo_test_all(uts));
+	ut_assertok(run_commandf("bdinfo -a"));
+	ut_assertok(bdinfo_test_all(uts));
 	ut_assertok(ut_check_console_end(uts));
 
 	return 0;
-- 
2.40.1

