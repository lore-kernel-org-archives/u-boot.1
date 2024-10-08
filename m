Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E62CF042A
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 22:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F976887D1;
	Wed,  9 Oct 2024 00:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="C04Zc56x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6409488B13; Wed,  9 Oct 2024 00:32:31 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BCBF88498
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 00:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-109-097.46.114.pool.telefonica.de
 [46.114.109.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 74FBA3F378; 
 Tue,  8 Oct 2024 22:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1728426746;
 bh=SRuxs59PotB1jm3tgAhd9jDcaxSZThJBxB8czKNKhcA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=C04Zc56xY9GBitRhs5cB9uJH+mvt6ZKH1vD1fNW8qjFnAB88/FE6TZlYgtvoqyMps
 98/cX0W8xllBdjDTn2VSXxgfahjdWrl+0huuJJU2zRX6oQgZ1rE06kRSMX7pb12YyC
 p3qcjY/HDGvEB7Yv8Ko1FD0hU51u4AWphzwTOFKWm8pTfckSHCTyjZdc3/B516ylxO
 lxhVVVGuIA5kIT9hgw+RNuNJ3j3MNIMHRLlgmQpkNIIaJQOy9yMuHOp2graK+P5QM5
 EaxF3KneGo76+beRC++2HzAwl6aKrEm4E8OI+bcoMuICUY6jKxb4xbHwcpkphjyMAn
 HN2L6yyBlYckQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sandbox: add bootmethod EFI boot-manager
Date: Wed,  9 Oct 2024 00:32:19 +0200
Message-ID: <20241008223219.105369-1-heinrich.schuchardt@canonical.com>
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

The EFI boot-manager is the default method to boot EFI binaries.
We should be able to use it on the Sandbox.

* Enable EFI boot-manager bootmethod on the sandbox.
* Adjust unit tests to reflect the additional boot method.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/sandbox/dts/test.dts |  4 ++++
 test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 8412506c17a..1248ed66089 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -119,6 +119,10 @@
 			compatible = "u-boot,distro-efi";
 		};
 
+		efimgr {
+			compatible = "u-boot,efi-bootmgr";
+		};
+
 		theme {
 			font-size = <30>;
 			menu-inset = <3>;
diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
index 518d99c4a27..fe175ccb755 100644
--- a/test/boot/bootmeth.c
+++ b/test/boot/bootmeth.c
@@ -21,11 +21,13 @@ static int bootmeth_cmd_list(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("    0    0  extlinux            Extlinux boot from a block device");
 	ut_assert_nextline("    1    1  efi                 EFI boot from an .efi file");
-	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
-		ut_assert_nextline(" glob    2  firmware0           VBE simple");
+	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)) {
+		ut_assert_nextline(" glob    2  efimgr              EFI bootmgr flow");
+		ut_assert_nextline(" glob    3  firmware0           VBE simple");
+	}
 	ut_assert_nextlinen("---");
 	ut_assert_nextline(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
-		 "(3 bootmeths)" : "(2 bootmeths)");
+		 "(4 bootmeths)" : "(2 bootmeths)");
 	ut_assert_console_end();
 
 	return 0;
@@ -56,11 +58,13 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("    0    0  extlinux            Extlinux boot from a block device");
 	ut_assert_nextline("    -    1  efi                 EFI boot from an .efi file");
-	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
-		ut_assert_nextline(" glob    2  firmware0           VBE simple");
+	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)) {
+		ut_assert_nextline(" glob    2  efimgr              EFI bootmgr flow");
+		ut_assert_nextline(" glob    3  firmware0           VBE simple");
+	}
 	ut_assert_nextlinen("---");
 	ut_assert_nextline(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
-		 "(3 bootmeths)" : "(2 bootmeths)");
+		 "(4 bootmeths)" : "(2 bootmeths)");
 	ut_assert_console_end();
 
 	/* Check the -a flag with the reverse order */
@@ -71,11 +75,13 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("    1    0  extlinux            Extlinux boot from a block device");
 	ut_assert_nextline("    0    1  efi                 EFI boot from an .efi file");
-	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
-		ut_assert_nextline(" glob    2  firmware0           VBE simple");
+	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)) {
+		ut_assert_nextline(" glob    2  efimgr              EFI bootmgr flow");
+		ut_assert_nextline(" glob    3  firmware0           VBE simple");
+	}
 	ut_assert_nextlinen("---");
 	ut_assert_nextline(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
-		 "(3 bootmeths)" : "(2 bootmeths)");
+		 "(4 bootmeths)" : "(2 bootmeths)");
 	ut_assert_console_end();
 
 	/* Now reset the order to empty, which should show all of them again */
@@ -84,7 +90,7 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
 	ut_assertnull(env_get("bootmeths"));
 	ut_assertok(run_command("bootmeth list", 0));
 	ut_assert_skip_to_line(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
-		 "(3 bootmeths)" : "(2 bootmeths)");
+		 "(4 bootmeths)" : "(2 bootmeths)");
 
 	/* Try reverse order */
 	ut_assertok(run_command("bootmeth order \"efi extlinux\"", 0));
@@ -116,7 +122,7 @@ static int bootmeth_cmd_order_glob(struct unit_test_state *uts)
 	ut_assert_nextline("Order  Seq  Name                Description");
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("    0    1  efi                 EFI boot from an .efi file");
-	ut_assert_nextline(" glob    2  firmware0           VBE simple");
+	ut_assert_nextline(" glob    3  firmware0           VBE simple");
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("(2 bootmeths)");
 	ut_assertnonnull(env_get("bootmeths"));
-- 
2.45.2

