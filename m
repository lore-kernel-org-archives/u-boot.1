Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97223C4450A
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 05:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D28A84AA4;
	Wed, 15 Jul 2026 07:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ksKTvhtA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 518A684AC3; Wed, 15 Jul 2026 05:34:09 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A731184AA4
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 05:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+guohaoprc.163.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DFA24416C6;
 Wed, 15 Jul 2026 03:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB99DC2BCB7;
 Wed, 15 Jul 2026 03:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1784086444;
 bh=YlmLp3kBDp4P51rOPNLr2P3pTvJFRzyysfH3Dew4AgU=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=ksKTvhtAjN31lisd8ueWH9d6tbRG7QbjdpOOuppHJGHNZv1dI3zVUCAB7SDektYar
 G46ARhi/CaYjHaCgzO2L3p34mR3w1licRP0UbFDVJMgPodkH/QLpr4oB3lxzTueMYI
 2s6kh93Qzqee3LBrIN9fIWfm7uXCziCiYpgQWD2cPxryArR18O/3MeMLLrLCgCgqO9
 tAqJJx8itMoeJZO0pfGtr0W6gIlfLsAFTYUUmwVsSqGpL1xE7joHcWJ0+wzkCZ6hGF
 bOUE2GPgYqI9GH/aByWn9H/k6CBf8oWULeCaHrLno3a+T+2N4V/GB+ocxOQZxjiIg0
 b6Oei6FE9rJbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 81EBDC43458;
 Wed, 15 Jul 2026 03:34:04 +0000 (UTC)
From: Guo Hao via B4 Relay <devnull+guohaoprc.163.com@kernel.org>
Date: Wed, 15 Jul 2026 11:32:26 +0800
Subject: [PATCH] board: ti: am62x: Fix build without TI_I2C_BOARD_DETECT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-am62x-no-board-detect-v1-1-2969faec1001@163.com>
X-B4-Tracking: v=1; b=H4sIAEn/VmoC/yXMQQqDMBCF4avIrDuQhJqAVyldJM5op2BSEi2Ce
 HejLj9479+gcBYu0DUbZP5LkRQr9KOB/uPjyChUDUYZq5xu0U/WrBgThuQzIfHM/Yw2GA7PwRE
 pC/X7yzzIenVf79tlCd86PWOw7wdLA5TIeQAAAA==
X-Change-ID: 20260715-am62x-no-board-detect-6b2eb4f7dd06
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Guo Hao <guohaoprc@163.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784086442; l=1266;
 i=guohaoprc@163.com; s=20260715; h=from:subject:message-id;
 bh=G3Mhs8J9V0d8ZQoA8QQUSCj8yZ5UWak1KQPX0gCC1AU=;
 b=nrcf05D4qL4qyJzyCjsuwoWV4+aSgvTjGIeBeabyBWiLkVOc136XhKDX+I1CpLVew2J4o8BG3
 daZsRZYN/FNDhr4Vc5GRGVlKUf+KLvoEV3jNsDklQscul8VVCqGfQPe
X-Developer-Key: i=guohaoprc@163.com; a=ed25519;
 pk=LuAU/SLdnwHV0emUu69VagQyjh4bAVGO89ZPeHKJCrA=
X-Endpoint-Received: by B4 Relay for guohaoprc@163.com/20260715 with
 auth_id=873
X-Original-From: Guo Hao <guohaoprc@163.com>
X-Mailman-Approved-At: Wed, 15 Jul 2026 07:22:45 +0200
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
Reply-To: guohaoprc@163.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Guo Hao <guohaoprc@163.com>

setup_board_eeprom_env() and setup_serial_am6() are only available when
TI_I2C_BOARD_DETECT is enabled.

IS_ENABLED() does not remove the guarded statements during preprocessing,
so disabling TI_I2C_BOARD_DETECT results in an implicit function
declaration error. Use a preprocessor condition to match the condition
used for the function definition.

Fixes: ff1b83c095c2 ("board: am62x: Add support for reading eeprom data")
Signed-off-by: Guo Hao <guohaoprc@163.com>
---
 board/ti/am62x/evm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 49e58ad6d6c..f54abb56384 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -125,10 +125,10 @@ invalid_eeprom:
 #if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
 int board_late_init(void)
 {
-	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
-		setup_board_eeprom_env();
-		setup_serial_am6();
-	}
+#if CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
+	setup_board_eeprom_env();
+	setup_serial_am6();
+#endif
 
 	ti_set_fdt_env(NULL, NULL);
 	return 0;

---
base-commit: 501d76ca801343cce6dafb17740a8b679ed17072
change-id: 20260715-am62x-no-board-detect-6b2eb4f7dd06

Best regards,
--  
Guo Hao <guohaoprc@163.com>


