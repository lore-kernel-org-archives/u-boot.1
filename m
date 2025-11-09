Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB53CCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 10:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D85283EA9;
	Sun,  9 Nov 2025 11:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kol7FcsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB47783EF9; Sun,  9 Nov 2025 11:10:31 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B27A83E8A
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 11:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-110-120.46.114.pool.telefonica.de
 [46.114.110.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 11912409ED; 
 Sun,  9 Nov 2025 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762683027;
 bh=4Es9BX5jcOTa1Xj30UdVW4DGXEVrbkkqIZKM73cCuYk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=kol7FcsROq8wkpCtzTGlEMEWHE2pBD8ymBt56oLldh/GrnUVUFzTZSEcS43dWrsFz
 HI2p33MtCKfa9qhahIbPgOJ5Ffpo38e0tC3/bxAGqpVDiTUQCM4bYjh59PMJ8gzfpq
 1t+2RZWx9yLcZb4uI69yGlc3xySg31Og7mzezUayeyKyscjQlUcd7z8lBlXrrmNVAO
 F1XdZvGOVu3e1Bw2VtucHEEzO0COZMnsf3J0FUqMs+k3b3hTu8O249KtNNnN6wpYFI
 8aONI4qUoNnZaQE6mb1wPn1KvQgs1fRQhOEbTS1nOmcGEh8nsChNLReUKsDlZpfgOy
 IJGo2CGoDkdD66qNvE+oS8gJ8Kfawyux4dDiz4w27YPD5GqW0VYrZ45RkGfhX6u3lA
 D+TFYsgpm4NKhEsH9YUsrkvftTwBlrzsCZ3AttOGrEYDD/q5IVOS2w9kPFiXeyz6D9
 VgCasha4eV5Ht+XLCZ7BPnNql2MVZcEg1+oIA/TE4mjf3Se+nGYrzujhkq4V1KAr37
 S41lA4P5UAVENIR/cXZM/mJILYL16wQm+l3gQcIiUeTdHljRbvGFblI/lgA9UWKgW6
 t1jOngl5goyRgZJB2Z6gS+X8ttD8xwF3Xn7jM1DvpAfH3mz031dhNbiX825kcIQGSW
 U7LIpzk+NqS67SNMJlWdZi2A=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/9] test: cmd/fdt: do not assume RNG device exists
Date: Sun,  9 Nov 2025 11:10:03 +0100
Message-ID: <20251109101010.306268-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
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

In fdt_test_chosen() currently we test if DM_RNG is configured.
CONFIG_DM_RNG=y does not imply that a RNG device actually exists.
For instance QEMU may be called with -device virtio-rng-device or not.
The current test framework evicts the virtio RNG device even if QEMU is
called with -device virtio-rng-device.

In the fdt_test_chosen() check if a RNG device exists.
Ignore 'No RNG device' messages.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/fdt.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index a36f2dcdda8..b950123b6da 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -10,6 +10,7 @@
 #include <fdt_support.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
+#include <dm/uclass.h>
 #include <linux/libfdt.h>
 #include <test/ut.h>
 
@@ -1267,6 +1268,7 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 {
 	const char *env_bootargs = env_get("bootargs");
 	char fdt[8192];
+	struct udevice *dev;
 	ulong addr;
 
 	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
@@ -1280,11 +1282,16 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	/* Test add new chosen node without initrd */
 	ut_assertok(run_commandf("fdt chosen"));
 	ut_assertok(run_commandf("fdt print /chosen"));
-	ut_assert_nextline("chosen {");
+	ut_assert(0 < console_record_readline(uts->actual_str,
+					      sizeof(uts->actual_str)));
+	if (!strcmp("No RNG device", uts->actual_str))
+		ut_assert(0 < console_record_readline(uts->actual_str,
+						      sizeof(uts->actual_str)));
+	ut_asserteq_str("chosen {", uts->actual_str);
 	ut_assert_nextlinen("\tu-boot,version = "); /* Ignore the version string */
 	if (env_bootargs)
 		ut_assert_nextline("\tbootargs = \"%s\";", env_bootargs);
-	if (IS_ENABLED(CONFIG_DM_RNG) &&
+	if (!uclass_get_device(UCLASS_RNG, 0, &dev) &&
 	    !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
 	    !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
 		ut_assert_nextlinen("\tkaslr-seed = ");
@@ -1294,7 +1301,12 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	/* Test add new chosen node with initrd */
 	ut_assertok(run_commandf("fdt chosen 0x1234 0x5678"));
 	ut_assertok(run_commandf("fdt print /chosen"));
-	ut_assert_nextline("chosen {");
+	ut_assert(0 < console_record_readline(uts->actual_str,
+					      sizeof(uts->actual_str)));
+	if (!strcmp("No RNG device", uts->actual_str))
+		ut_assert(0 < console_record_readline(uts->actual_str,
+						      sizeof(uts->actual_str)));
+	ut_asserteq_str("chosen {", uts->actual_str);
 	ut_assert_nextline("\tlinux,initrd-end = <0x%08x 0x%08x>;",
 			   upper_32_bits(0x1234 + 0x5678 - 1),
 			   lower_32_bits(0x1234 + 0x5678 - 1));
@@ -1303,7 +1315,7 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	ut_assert_nextlinen("\tu-boot,version = "); /* Ignore the version string */
 	if (env_bootargs)
 		ut_assert_nextline("\tbootargs = \"%s\";", env_bootargs);
-	if (IS_ENABLED(CONFIG_DM_RNG) &&
+	if (!uclass_get_device(UCLASS_RNG, 0, &dev) &&
 	    !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
 	    !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
 		ut_assert_nextlinen("\tkaslr-seed = ");
-- 
2.51.0

