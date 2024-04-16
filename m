Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6455CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 08:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B0538832D;
	Tue, 16 Apr 2024 10:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=xff.cz header.i=@xff.cz header.b="vJeXBHj+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 170AA88337; Tue, 16 Apr 2024 10:45:07 +0200 (CEST)
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB8C68832D
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 10:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=megi@xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
 t=1713257103; bh=WSlxNXmkj24jbDlKpe7pTM13fua7888mzS97UKKQQFw=;
 h=From:To:Cc:Subject:Date:From;
 b=vJeXBHj+dlLPvKakQ1NYYJlMli5Q2CenQQ58vWO7AVxxHJhKr/0U2WNQKQuF7b2G1
 oUSPivEdoBJY/bgySRvL3SAu8g0/N6fdH9VRdhHmYRxLhBfec4KlFVgrT35nDrODhP
 Qw7Fz4xwoi1VbUeQxAktCUXREO5b+e7QBZfcC8sQ=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: u-boot@lists.denx.de
Cc: Ondrej Jirman <megi@xff.cz>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>, Igor Prusov <ivprusov@sberdevices.ru>
Subject: [PATCH] clk: zynq: Fix EMIO clock use detection for gem0
Date: Tue, 16 Apr 2024 10:44:54 +0200
Message-ID: <20240416084456.2821567-1-megi@xff.cz>
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

From: Ondrej Jirman <megi@xff.cz>

According to TRM, the bit that differentiates between MIO and EMIO
clocks is bit 6. This resolves failure to set clock when using EMIO
clock for ethernet.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/clk/clk_zynq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
index e3cefe2e0c72..78e6886a000c 100644
--- a/drivers/clk/clk_zynq.c
+++ b/drivers/clk/clk_zynq.c
@@ -42,6 +42,8 @@
 #define CLK_CTRL_DIV3X_SHIFT	20
 #define CLK_CTRL_DIV3X_MASK	(ZYNQ_CLK_MAXDIV << CLK_CTRL_DIV3X_SHIFT)
 
+#define CLK_CTRL_GEM_EMIO	(1u << 6)
+
 DECLARE_GLOBAL_DATA_PTR;
 
 #ifndef CONFIG_SPL_BUILD
@@ -161,7 +163,7 @@ static enum zynq_clk_rclk zynq_clk_get_gem_rclk(enum zynq_clk id)
 	else
 		clk_ctrl = readl(&slcr_base->gem1_rclk_ctrl);
 
-	srcsel = (clk_ctrl & CLK_CTRL_SRCSEL_MASK) >> CLK_CTRL_SRCSEL_SHIFT;
+	srcsel = (clk_ctrl & CLK_CTRL_GEM_EMIO);
 	if (srcsel)
 		return emio_clk;
 	else
-- 
2.44.0

