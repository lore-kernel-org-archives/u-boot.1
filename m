Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B59C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 21:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9554288427;
	Tue, 18 Jun 2024 23:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFDA8840E; Tue, 18 Jun 2024 23:06:19 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 453E8883DE
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 23:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sJg1v-00FAbj-11;
 Tue, 18 Jun 2024 21:06:15 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, Michal Simek <michal.simek@amd.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v7 4/4] test: cmd: fdt: fix chosen test for DM_RNG
Date: Tue, 18 Jun 2024 14:06:09 -0700
Message-Id: <20240618210609.1744727-5-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618210609.1744727-1-tharvey@gateworks.com>
References: <20240618210609.1744727-1-tharvey@gateworks.com>
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

Now that kaslr-seed is automatically added to the chosen node if DM_RNG
is enabled, adjust the test to expect this.

Take care not to expect kaslr-seed for CONFIG_MEASURED_BOOT and
CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT as we do not add it for those.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Akash Gajjar <gajjar04akash@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Devarsh Thakkar <devarsht@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Chris Morgan <macromorgan@hotmail.com>
---
v7: fix fdt_test_chosen to not expect kaslr-seed for
    CONFIG_MEASURED_BOOT and CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
v6: new patch
---
 test/cmd/fdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 547085521758..5cda1ef382a1 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -1347,6 +1347,10 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	ut_assert_nextlinen("\tu-boot,version = "); /* Ignore the version string */
 	if (env_bootargs)
 		ut_assert_nextline("\tbootargs = \"%s\";", env_bootargs);
+	if (IS_ENABLED(CONFIG_DM_RNG) &&
+	    !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
+	    !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
+		ut_assert_nextlinen("\tkaslr-seed = ");
 	ut_assert_nextline("};");
 	ut_assertok(ut_check_console_end(uts));
 
@@ -1363,6 +1367,10 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	ut_assert_nextlinen("\tu-boot,version = "); /* Ignore the version string */
 	if (env_bootargs)
 		ut_assert_nextline("\tbootargs = \"%s\";", env_bootargs);
+	if (IS_ENABLED(CONFIG_DM_RNG) &&
+	    !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
+	    !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
+		ut_assert_nextlinen("\tkaslr-seed = ");
 	ut_assert_nextline("};");
 	ut_assertok(ut_check_console_end(uts));
 
-- 
2.25.1

