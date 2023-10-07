Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3442EE95A6C
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5671D86DFE;
	Sat,  7 Oct 2023 23:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FfHctfpF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rNRtyMOo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1830E86DCC; Sat,  7 Oct 2023 23:41:37 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E6DD86DCC
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
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S2zJK6Z3Fz9sW5;
 Sat,  7 Oct 2023 23:41:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vtqui5wrZWw4CnMr6iHrDk6eJA0F5yDkdxL/wWLvMZo=;
 b=FfHctfpFtUQCM+etj83XKGgGYOfXAzYL8N+KUkQkFBAk2LJcjfOKXsYBl3TrkXpXx5eohN
 whe8V7r1Esg0dvseGe14DPbzA0vkh4tfsQQl7OINdiHTY8iKFpCDQazwfz32byFoCSgtiE
 nNj5EBJniDLVhy16T72VKisdbbTpurzr4xZfGztKOzu5osjurM/h/GFpuk/YhudX+ZxTkK
 C8u7SwXf3OzAW0MxNq5g34AY5Jo5lHreI1oq6GExTMim7BonBCIotnlMFThTszoFDkbadf
 rEPNVF7xvTrXEwRyTCwPoM9dbRNwHq/BBcaVqS7sgsdCrxDfuu4uXJBLr+AhnQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vtqui5wrZWw4CnMr6iHrDk6eJA0F5yDkdxL/wWLvMZo=;
 b=rNRtyMOo3/G7MORjiS0FST8DpJxWx5ZAW7OJ6EXD/+onY0P0GI+LLRRJRCkbV9xcWRn6pV
 iMrEG5Kv0iLOeqrGw/WVnYqdGVuoULaw7iMaxrmT5Pi2aQcw0b+aXOsPzQlVxuQEg96dCc
 fmvwfRbC5shROWHe6n4/sLzw1d4FH4NJEQIkbaSPFavsBH9v/GwF9hl1GLnCUruQ6mpKo/
 OeBEA2B8Qree3DP2h1tyJPFHSModkMNyuuI7dxkDvicPWS6rimS69pdMyr9OrfJ+DWXTtv
 2+OMTtnQgjQw2Q+6fx8QJ4daGa8RV2JlPGkxjSgCiRZhMGvhe/dE5CrqnIEB/g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v2 5/9] test: bdinfo: Rename bdinfo_test_move() to
 bdinfo_test_full()
Date: Sat,  7 Oct 2023 23:41:02 +0200
Message-Id: <20231007214106.15744-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
References: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kaqx74tfgihekpwcu1ntgkzgpm17j3gs
X-MBO-RS-ID: 87400bf09d6c90a27f7
X-Rspamd-Queue-Id: 4S2zJK6Z3Fz9sW5
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

Rename bdinfo_test_move() to bdinfo_test_full(). The former is a
remnant of deriving this test from another test. No functional
change.

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
 test/cmd/bdinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 8c09281cac0..b2896e8eb41 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -130,7 +130,7 @@ static int lmb_test_dump_all(struct unit_test_state *uts, struct lmb *lmb)
 	return 0;
 }
 
-static int bdinfo_test_move(struct unit_test_state *uts)
+static int bdinfo_test_full(struct unit_test_state *uts)
 {
 	struct bd_info *bd = gd->bd;
 	int i;
@@ -217,7 +217,7 @@ static int bdinfo_test_move(struct unit_test_state *uts)
 	return 0;
 }
 
-BDINFO_TEST(bdinfo_test_move, UT_TESTF_CONSOLE_REC);
+BDINFO_TEST(bdinfo_test_full, UT_TESTF_CONSOLE_REC);
 
 int do_ut_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-- 
2.40.1

