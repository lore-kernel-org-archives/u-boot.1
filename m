Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D316CD4935
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 22:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5232F86C5A;
	Thu, 21 Sep 2023 00:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d/+Dj1Je";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S8aPi+dO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2EE186C69; Thu, 21 Sep 2023 00:58:43 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36C786C3F
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 00:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RrYqP58R9z9tSh;
 Thu, 21 Sep 2023 00:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIi4IIlJFkpoeG5Mbd8uHMnonfLOArgWJ8M1Qszfp8M=;
 b=d/+Dj1JesS/I/miRGE4GvWfc0AEDRUWFz1Z2c/x3kdxqOPMIBrK2aus+2R/eJRozRXSK5h
 KT8wV8peP+5gn/11uIeVjYbANoUj9ltBc0dgeyhs1SyWw437cK8i53GQuzBXxhFx+JTgaK
 Le7mzf3haefmM755c1oXE4F1NDtDsI3nOla5iNP3eDDsHPqnZuMfnLWiCZKPIlBPgIykdY
 9UOIpdj10nJcTLepvEe4erW8BeEq/bLj60dyFII2t5vu89Sx8wfJfHdMR1FEBzw4FVxWEP
 m/xq3vE3ZaptRVl57S0JJyo2P0yF1IkMbljcy0OjK93nesN8Ej+khzJTjMzS8Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIi4IIlJFkpoeG5Mbd8uHMnonfLOArgWJ8M1Qszfp8M=;
 b=S8aPi+dOMojwsznGK7hDkWjUvV32RQsZeq0A1Sx6XF78RkWP/3rm9CtGBNoZOjEjWNyNQ/
 bsx7pHnc9V6r60qEl31ImECwl+XR6VEGMw9xST/jqo8PD56eWb4QtXY8L3BvVDdiW3Xq05
 eNvXWAAid95GJPA1yFPFQcxLG6OrOLeT9nX0lLT3DhFPWQNTABmtv92Buxad69oux/I6T5
 Q+NEzhVLmfCllG0Q6DbGpoVy4URJWE5m3wnLpJAs1WzeuVf6h9FXMufeqrYS2OivqlaUp5
 kUH+BvYknNP8dwhJuN8kFVCkxlT0Dz/t22EB6L85BwWlpStRju99MXaN4clSWg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 6/9] test: bdinfo: Test both bdinfo and bdinfo -a
Date: Thu, 21 Sep 2023 00:58:08 +0200
Message-Id: <20230920225811.153474-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 003740b83d0efb57ada
X-MBO-RS-META: b3f9anf51pjz9ebkhnwi6fpcw8wo7azz
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

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
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

