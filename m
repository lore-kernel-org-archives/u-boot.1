Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF83EC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 19:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB0888438;
	Mon, 17 Jun 2024 21:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADCEA883DA; Mon, 17 Jun 2024 21:14:26 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B75B88378
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 21:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sJHo6-00CFal-Bq;
 Mon, 17 Jun 2024 19:14:22 +0000
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
Subject: [PATCH v6 4/4] test: cmd: fdt: fix chosen test for DM_RNG
Date: Mon, 17 Jun 2024 12:14:16 -0700
Message-Id: <20240617191416.1351790-5-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617191416.1351790-1-tharvey@gateworks.com>
References: <20240617191416.1351790-1-tharvey@gateworks.com>
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
v6: new patch
---
 test/cmd/fdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 547085521758..537d8a338bbf 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -1347,6 +1347,8 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	ut_assert_nextlinen("\tu-boot,version = "); /* Ignore the version string */
 	if (env_bootargs)
 		ut_assert_nextline("\tbootargs = \"%s\";", env_bootargs);
+	if (CONFIG_IS_ENABLED(DM_RNG))
+		ut_assert_nextlinen("\tkaslr-seed = ");
 	ut_assert_nextline("};");
 	ut_assertok(ut_check_console_end(uts));
 
@@ -1363,6 +1365,8 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	ut_assert_nextlinen("\tu-boot,version = "); /* Ignore the version string */
 	if (env_bootargs)
 		ut_assert_nextline("\tbootargs = \"%s\";", env_bootargs);
+	if (CONFIG_IS_ENABLED(DM_RNG))
+		ut_assert_nextlinen("\tkaslr-seed = ");
 	ut_assert_nextline("};");
 	ut_assertok(ut_check_console_end(uts));
 
-- 
2.25.1

