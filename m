Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8A4CF6D24
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 13:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6689F890AD;
	Wed,  2 Oct 2024 15:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="YMMdCf2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98F1488FEC; Wed,  2 Oct 2024 15:26:47 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A75890A8
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 15:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1727875604;
 bh=KWmsyL/D8qj0AmCLMpLXCLu1GP3j1nu+qvVEqeU8zFk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YMMdCf2ewt5H/tjermz4W6w5B8z6CVvnsGDtCFvaGXu2tIEjglEkER/ZpvzuFn8PF
 rDzn4EXF6gEu/6DupLI6cD4A4Zlf6jQiJ5FBPXKyLXTVRoooGKHxwcjnd116WFCa9M
 ZBOUGaAfGalM7G63u6QREvwJCaO4qi8dBXbuDAXnRA3U7cuhI6dIsAs35pgAxk+Pf0
 1pxH1gp/vcqsaPS+QkHkPX21xFbZxHoj263muK+LCHlTZLNOxEt84az4/ZTJc3gr2L
 z6QKwXOwjDVlqe5wD4VG8/euGkh4hAZdLgupIffNJgvq1NmbWN2RaXkWUE6DHolGmX
 q+DEo4wpaLrHw==
Received: from pan.lan (unknown [IPv6:2a00:23c6:c32f:9100::16d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: martyn)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B8FBE17E35F3;
 Wed,  2 Oct 2024 15:26:43 +0200 (CEST)
From: Martyn Welch <martyn.welch@collabora.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 4/4] test: Add tests for the bootmeth set command
Date: Wed,  2 Oct 2024 14:26:33 +0100
Message-ID: <20241002132633.246942-4-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002132633.246942-1-martyn.welch@collabora.com>
References: <20241002132633.246942-1-martyn.welch@collabora.com>
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

We have added a "set" sub command to bootmeth, add some tests to check
it's operation.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
 test/boot/bootmeth.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
index 113b789ea7..659f386228 100644
--- a/test/boot/bootmeth.c
+++ b/test/boot/bootmeth.c
@@ -130,6 +130,53 @@ static int bootmeth_cmd_order_glob(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootmeth_cmd_order_glob, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
 
+/* Check 'bootmeth set' command */
+static int bootmeth_cmd_set(struct unit_test_state *uts)
+{
+	/* Check we can enable extlinux fallback */
+	console_record_reset_enable();
+	ut_assertok(run_command("bootmeth set extlinux fallback 1", 0));
+	ut_assert_console_end();
+
+	/* Check we can disable extlinux fallback */
+	console_record_reset_enable();
+	ut_assertok(run_command("bootmeth set extlinux fallback 0", 0));
+	ut_assert_console_end();
+
+	/* Check extlinux fallback unexpected value */
+	console_record_reset_enable();
+	ut_asserteq(1, run_command("bootmeth set extlinux fallback fred", 0));
+	ut_assert_nextline("Unexpected value 'fred'");
+	ut_assert_nextline("Failed (err=-22)");
+	ut_assert_console_end();
+
+	/* Check that we need to provide right number of parameters */
+	ut_asserteq(1, run_command("bootmeth set extlinux fallback", 0));
+	ut_assert_nextline("Required parameters not provided");
+	ut_assert_console_end();
+
+	/* Check that we need to provide a valid bootmethod */
+	ut_asserteq(1, run_command("bootmeth set fred fallback 0", 0));
+	ut_assert_nextline("Unknown bootmeth 'fred'");
+	ut_assert_nextline("Failed (err=-19)");
+	ut_assert_console_end();
+
+	/* Check that we need to provide a valid property */
+	ut_asserteq(1, run_command("bootmeth set extlinux fred 0", 0));
+	ut_assert_nextline("Invalid option");
+	ut_assert_nextline("Failed (err=-22)");
+	ut_assert_console_end();
+
+	/* Check that we need to provide a bootmeth that supports properties */
+	ut_asserteq(1, run_command("bootmeth set efi fallback 0", 0));
+	ut_assert_nextline("set_property not found");
+	ut_assert_nextline("Failed (err=-19)");
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootmeth_cmd_set, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+
 /* Check 'bootmeths' env var */
 static int bootmeth_env(struct unit_test_state *uts)
 {
-- 
2.45.2

