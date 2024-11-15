Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ADDD6DDF8
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D4189235;
	Fri, 15 Nov 2024 14:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dN3YGV/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA74589667; Fri, 15 Nov 2024 10:43:19 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 693CC88F83
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 10:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=theo.lebrun@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA21540003;
 Fri, 15 Nov 2024 09:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1731663797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mpV1z0xgey2wpPM1UC2g3pFB4VyRnOWpE+Ndf/yaWmI=;
 b=dN3YGV/n4D+bxkbuYbQUefXG6C+rfh/GujbSoYFihM3eJ08JSKE4JUjFYJ/MJ/NOIE8+Pn
 nMqxiYGTeVnYN2txJDuinJpO/N5iuttSsBsWwDUhGGsnRp+QuoXyDCJuYtXdxws8JobQxK
 0hkYvkgmXm2D7fFsBiMqMc+z2MDMpZQNrlUqaabzUVPXiXzogyyYPt07L9vTVyrX5Tgrm8
 z4kPs0+5/TUxuPSQO5thl4xsENYn2TtFyyJIbwdFmU1dQjP8ovif22qpoNzsreWfouanfm
 MT6GBzOQK6/0FaGnqgkXCI3i/oPX/6hsGC1vGux/sQTrswH7fFm3nK9vVazOUg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 15 Nov 2024 10:43:15 +0100
Subject: [PATCH] ram: k3-ddrss: drop debug() in timing-sensitive sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241115-k3-debug-v1-1-5c1c130b4e2e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIALIXN2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0NT3Wxj3ZTUpNJ0XWMDUwPTNCOTVCNDEyWg8oKi1LTMCrBR0bG1tQC
 TasFiWgAAAA==
X-Change-ID: 20241115-k3-debug-30505f24e214
To: Tom Rini <trini@konsulko.com>
Cc: =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: theo.lebrun@bootlin.com
X-Mailman-Approved-At: Fri, 15 Nov 2024 14:04:27 +0100
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

Those debug() calls might be useful, but beware. They can cause the DDR
controller to hang if we do not run the sequence quickly enough.

They usually are not an issue with upstream U-Boot and the default DDR
config, but they have become troublesome with custom DDR configs.

Drop those debug() statements that shouldn't be present in
time-sensitive code, to avoid anyone else falling into the trap.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 525b6d5b79fce18819946e1714e98290057ccccf..6e9202b957962ec95fbad2469a0ef8c8557c5d95 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -216,9 +216,6 @@ static void k3_lpddr4_freq_update(struct k3_ddrss_desc *ddrss)
 		req_type = readl(ddrss->ddrss_ctrl_mmr +
 				 CTRLMMR_DDR4_FSP_CLKCHNG_REQ_OFFS + ddrss->instance * 0x10) & 0x03;
 
-		debug("%s: received freq change req: req type = %d, req no. = %d, instance = %d\n",
-		      __func__, req_type, counter, ddrss->instance);
-
 		if (req_type == 1)
 			clk_set_rate(&ddrss->ddr_clk, ddrss->ddr_freq1);
 		else if (req_type == 2)
@@ -245,8 +242,6 @@ static void k3_lpddr4_ack_freq_upd_req(const lpddr4_privatedata *pd)
 {
 	struct k3_ddrss_desc *ddrss = (struct k3_ddrss_desc *)pd->ddr_instance;
 
-	debug("--->>> LPDDR4 Initialization is in progress ... <<<---\n");
-
 	switch (ddrss->dram_class) {
 	case DENALI_CTL_0_DRAM_CLASS_DDR4:
 		break;

---
base-commit: 2bf2615b8004e4a296fb25498ad0c183fd5c7b94
change-id: 20241115-k3-debug-30505f24e214

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>

