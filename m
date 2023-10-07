Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB70E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1CB186E22;
	Sat,  7 Oct 2023 23:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MkQqspHG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dIYIP5Nn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 782598691E; Sat,  7 Oct 2023 23:41:32 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0A5E86DFE
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S2zJP1mZ5z9sl8;
 Sat,  7 Oct 2023 23:41:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L44l0tiUK9ZzxraBS42OKTTs9V3qe4udIw864Ha4B0k=;
 b=MkQqspHGFfxHoRUMSsW3g6Ic9mUDf6RqA0b81WgBHYGdYgmSE+wrr2C+sMkTDrrzP178c1
 hU5gOePiol4Khy3/j+1sZ/sB54NrITDqyL4Zay1e8GL4Yv06uXJNCmZbR5AH2pwU+1w1TP
 BIDYQLpnaX8BxrewFlN5/mSQZWSp5jE8Yyx7GGQozzWwN+wfbdtWx9WBZrs97w8EM1Rd72
 KWFqBwqcx4AWN3ZhG7xyeM4hvbUueJ1o73PWGdjhUewA2SFXObHEbDYszYE44eZCWDnOHN
 SI6NpHow+0LhHf5Mc2qcWssUPHyunamhq95HzdGw2Ojq9TAiVUdpxYOaB62L6Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L44l0tiUK9ZzxraBS42OKTTs9V3qe4udIw864Ha4B0k=;
 b=dIYIP5NnQHO6y4s7Xn/s3qGNvmZnW8mbOnnqwXuF6Z0Xtu7M/PV+a+fPXPpSU+cYVhGjPp
 l4L+Qo7+ccEODla09zy78fXiS2qC0esqdj2xiQuLrvNkVG+pGZMHY2afLZ1ZAtKHA3utHH
 we6H4IZUyXgO8INxOsHiEvhIXglyBT3TKC1sify/HRwbgvnrqyh+e3cb3HUbke1DXbWtkp
 XurfmJ2/lyslN+j4ZYzXV8Nkowtf5ArWATKgrF5heA7Hgu5VGHOPnsxgTSZKRoZj3+qDac
 GsQRCEy8lsqr32aM1oxUhspaIkDYT7xL5xfiGkUeUogSoSDrN/y8ZSWWBZJ/4Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v2 9/9] test: bdinfo: Test bdinfo -e
Date: Sat,  7 Oct 2023 23:41:06 +0200
Message-Id: <20231007214106.15744-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
References: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5zhpscxnobmd45dk4qib7xndp9zoh4dg
X-MBO-RS-ID: 94281aafd6c1de6af7a
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
 test/cmd/bdinfo.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index c9be182e370..9744bd16df9 100644
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

