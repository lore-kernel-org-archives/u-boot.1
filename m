Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC140D11190
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 20:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41126888D5;
	Sun,  3 Nov 2024 21:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="h/O9ebXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8C088E81; Sun,  3 Nov 2024 21:46:49 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6EA38862E
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 21:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DBEF93FDE7; 
 Sun,  3 Nov 2024 20:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730666807;
 bh=9FhZbT+5M0dXqkudv2PL8tumAUEU0IrKpj7mI7U7ZjY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=h/O9ebXr6M/40vSjPWsyeVgcwHvCUGJjjvG8xi1ZX/G4m1/vxaTk/n7b5EPqCraB1
 srBVM0/Pz7SmnHCI7d1LSsKE5DNinObCsNriAEDnv4L2Znw2IIE46BKaKJtaxWSC2f
 5gCv7sV8FUQklcozmuQOHuLului6Hm2dsbLT/Aw31bFRNhb8H7sIo5dcyW1WXCJbzI
 0FIMl0T69aJp98wtmSBnmIGLMJ0et6bSf8XTJu07FLBEAqdQHTd3rAk9hBwu55BVSw
 RGMa/b7y0TVBjGPPMeY5jxMaHFJt52WNUfGSQ40d/zbhwJKhMkoweHCMmOsSgcUIQP
 /hEtEenztUVZA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: print_printf() must check availability of %ls
Date: Sun,  3 Nov 2024 21:46:42 +0100
Message-ID: <20241103204642.175928-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Availability of %ls in printf() depends on having
CONFIG_EFI_LOADER or CONFIG_EFI_APP.

Respect this when testing.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/print_ut.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/test/print_ut.c b/test/print_ut.c
index f5e607b21a3..bffd446f6c0 100644
--- a/test/print_ut.c
+++ b/test/print_ut.c
@@ -118,8 +118,10 @@ static int print_printf(struct unit_test_state *uts)
 	snprintf(str, 0, "testing none");
 	ut_asserteq('x', *str);
 
-	sprintf(big_str, "_%ls_", u"foo");
-	ut_assertok(strcmp("_foo_", big_str));
+	if (CONFIG_IS_ENABLED(EFI_LOADER) || IS_ENABLED(CONFIG_EFI_APP)) {
+		sprintf(big_str, "_%ls_", u"foo");
+		ut_assertok(strcmp("_foo_", big_str));
+	}
 
 	/* Test the banner function */
 	s = display_options_get_banner(true, str, sizeof(str));
-- 
2.45.2

