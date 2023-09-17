Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C253ACD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAA07869E1;
	Sun, 17 Sep 2023 16:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XyJIbQxx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZTSC6SAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA7FC867EA; Sun, 17 Sep 2023 16:09:19 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62A58690B
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpVCx4Qvtz9sPm
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ft1aOIMQ99hvhb+Po3sP7czooW/Zq+YQ7ck9W7YO4tY=;
 b=XyJIbQxxevLItKHzivssBKT/4vqcxIX87CmQYAqLVwPBdPq6TqWROD3DydjIO30yKsT0y3
 Ci9lsVk0wAE8vfjIkA5d2if6cTxJFmYYq0KBptP7o7OVTjWiZHJw2XWef2lJK7K+fMEA8/
 0V7nBYvdsWcS9mMIjJZ5Q/JlGLKrbPenI4ycPG9QQKxq2SlljwfaphjDBNepMXJLPeVQb+
 F78nc+I76G55UBkd1VtX0KNfo7xOJ8adpqtgH3GeKkIu+0dAa25HyqT5ijs6OazbR11dLe
 MSpvblcUFDpbcAx5W39hhRUA9u7uMXOh/IJgPTeFNg3Ai894NjWixkztqFyR5Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ft1aOIMQ99hvhb+Po3sP7czooW/Zq+YQ7ck9W7YO4tY=;
 b=ZTSC6SABYp6pfTV3VikuqbYr5R83UOQFzBfMAJAaPlMInOcLL37yN7w8S4PX/m62japgLs
 kCs1kdp3iPagYqg3BL9k3v/qEXRpOWwlt+pqiNneGpgTL2JbDtU+olJB2zNoDD2D1wxM0n
 Ll4f/WUlbdZtBl//fk/Z40Ef5PDMSCvFSquK1yXU3FXKx2MLMXX4fhoJlwbG2JjxRuc7rr
 IERieefssXUdG7VZCg9b6pxZj8YVCtx4g+Po1J72U4zOTf0PROj+ewvTVTQIOl9CFsBPnA
 mWcfKOtqTbl5WqPScFWDpf4j6fq5xou9Q61l/RywGnh757slYRV3LckVlgnY3A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 16/18] pinctrl: renesas: Synchronize R8A779A0 V3U PFC tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:47 +0200
Message-Id: <20230917140849.379711-16-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b09a5a1de2b23cede74
X-MBO-RS-META: 9jh7f866s1i64ro8i584yt7raqttcakk
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

Synchronize R-Car R8A779A0 V3U PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a779a0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779a0.c b/drivers/pinctrl/renesas/pfc-r8a779a0.c
index 0f570e4ea5e..3c4b03b1b4c 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779a0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779a0.c
@@ -3633,7 +3633,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL2_3_2
 		/* RESERVED 1-0 */ ))
 	},
-	{ },
+	{ /* sentinel */ }
 };
 
 static const struct pinmux_drive_reg pinmux_drive_regs[] = {
@@ -3938,7 +3938,7 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(9, 17),  4, 3 },	/* AVB5_LINK */
 		{ RCAR_GP_PIN(9, 16),  0, 3 },	/* AVB5_PHY_INT */
 	} },
-	{ },
+	{ /* sentinel */ }
 };
 
 enum ioctrl_regs {
@@ -3965,7 +3965,7 @@ static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POC8] = { 0xe60690a0, },
 	[POC9] = { 0xe60698a0, },
 	[TD1SEL0] = { 0xe6058124, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int r8a779a0_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
@@ -4352,7 +4352,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[30] = SH_PFC_PIN_NONE,
 		[31] = SH_PFC_PIN_NONE,
 	} },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static const struct sh_pfc_soc_operations r8a779a0_pfc_ops = {
-- 
2.40.1

