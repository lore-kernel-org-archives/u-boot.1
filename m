Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EEEE95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D36F86EA9;
	Sat,  7 Oct 2023 23:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MFm0xXai";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k3skrT+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EBD086B0C; Sat,  7 Oct 2023 23:41:32 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA94486DFA
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S2zJM5ChBz9snD;
 Sat,  7 Oct 2023 23:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptPf+u2qk9K092+nolOoAq7eFgywBruUA0CzV3TS2J4=;
 b=MFm0xXaii8ckJ0AbNTRPqgGGkRFgNNnvr+5ac6F5FyzTIaQttx5bpBgJjlBXjJkQHhJHbY
 w9HbTAklTEqnuPtRqbCdmSyw+nS1bWZ8jokfREp2bdy93nWCmEbWocQVudJWHMFcfqSycN
 85Ju/cgb23994DYMeEks2IR38/RIsJZA8+E7mGkanZ8RETVoCXVmuPgHZ6Y2TeH+MwEBzy
 kerkYqNx14oXOMw/pcFVkDKyaEgRlAn3qfjPgE9GWTr/WqCtxTDjQwq6lQNfkKyAr3Hkko
 xdFfniy7mTT9k3DYH3mRnLnAE2hknmivPUEgSKz+dJyf2cG8is893/PE7gCThw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptPf+u2qk9K092+nolOoAq7eFgywBruUA0CzV3TS2J4=;
 b=k3skrT+MkaAm4n0VVRmb7FXadLSkTXSFeEBzmQ80i6CHjE6wgyJ57dg48SXKHw0xHK5ExZ
 bS1npu22GWwGVf/NOqe8RowBuwEU4YIgd1QKV3GfuElZZWOHQdi3fDcEtrFLLL2xgGzhGD
 zCBIfpU5lcswTNWdDmjJEhPc7G7JXBxJ+jwwpRLOqgC6qfoiTi1GpfQ0pp3oZPDDH/q7oQ
 Dbgotp6lnTJ00FdbU43f6h5LiSKoKD3zb0MVCiUDXAjfMeoXlWTA8dcRoyRsWDeSOmqRL+
 H0CA0Wd53IBN9P+TGjYtQ3HF3iOYTqCPRjfWdqjI4RV6pAVBVr48PTVmdU/E4A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v2 7/9] test: bdinfo: Test bdinfo -h
Date: Sat,  7 Oct 2023 23:41:04 +0200
Message-Id: <20231007214106.15744-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
References: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rm7jyy4ng6c9iasba1dfzh5s6m3g483n
X-MBO-RS-ID: fc3aea7f0a94185d821
X-Rspamd-Queue-Id: 4S2zJM5ChBz9snD
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

