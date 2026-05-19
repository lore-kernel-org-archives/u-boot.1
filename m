Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8D6CD5BA4
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D008E8470B;
	Tue, 19 May 2026 15:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="NPtRWIqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5238A847AF; Tue, 19 May 2026 15:02:16 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E28A4843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1779195729; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hDo1mZv0TWxC/22cfuxGZdJwQF5dGIYwhWvBXdm+EXj9g5uguBg/lyLd2eLq5/jEdZV5H2jrf2EUwZcEDffKaA7O8/DHiTaFmQiBB9eS+vlfetQXG1hiMah3Bq9vAf+6OYh289QvvkBKcerNDvmMn8y1iSltN+ZSYYNnmNMDUSA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779195729;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Kf64BwDenUiehidMzwOVZiXhb9zbvUVhq1WJhfUc4CY=; 
 b=mBYPjg5kpi0UID6g5A+XXYtNV07J57uk5kriq20MZHqXEhkKes/wWMQFcPd7zvM2Zr78PKzbjxpEljYfHzKHoffxG4EJMpw1iItIL4+hEPoY3fE5Se6t//IXxjEl42AbzS+QYs2UFDZOigU+6U4nB/4CRNnNwo/Y7m05o/aiPSw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779195729; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Kf64BwDenUiehidMzwOVZiXhb9zbvUVhq1WJhfUc4CY=;
 b=NPtRWIqTaSrTFpbYb6XBMBUZ9nQI8Ascs3lTgdFO7ym//CcWSR6wIjyjS9t9T8iu
 0ncKP0Af5LjEP09Boesv3/9NYmsxp5gg0E3xoYQ9nBPKRF1yqW/+TwdPLci8k6Fftll
 QmggK1a6YEZWS2y7jL3tGi8PQyBez6S8nBRTLq3Q=
Received: by mx.zohomail.com with SMTPS id 1779195726455240.1620993492146;
 Tue, 19 May 2026 06:02:06 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 19 May 2026 20:58:31 +0800
Subject: [PATCH 4/5] clk: sunxi: a523: add MBUS_EMAC1 clock gate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-a5e-gmac1-v1-4-c3117603b9fb@pigmoral.tech>
References: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
In-Reply-To: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kalashnikov <iuncuim@gmail.com>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Lukas Schmid <lukas.schmid@netcube.li>, Lukasz Majewski <lukma@denx.de>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779195642; l=813;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=xxk2zP/vrmHJRKeRc1uJpXyKwnfRxrSRGG5Ne0ARAwA=;
 b=aVLdNfP3SxhANrIK1UgzzpZW+ZvmZO94705AEFxejmursokMiD+JTgHX1vjAQi/rrSu+Fc9DC
 pdoWryo5ggHD7oNEGot2W19j1CCl4P+YX514/Nc+pTWHDVOxvhHa949
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
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

The Allwinner sun55i (A523/A527/T527) platform requires the MBUS clock
gate enabled for the gmac1 controller to function. Add the clock gate
definition for CLK_MBUS_EMAC1.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi/clk_a523.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk_a523.c b/drivers/clk/sunxi/clk_a523.c
index 1de95fbaf2f..494ee195599 100644
--- a/drivers/clk/sunxi/clk_a523.c
+++ b/drivers/clk/sunxi/clk_a523.c
@@ -16,6 +16,7 @@ static struct ccu_clk_gate a523_gates[] = {
 	[CLK_PLL_PERIPH0_200M]	= GATE_DUMMY,
 	[CLK_APB1]		= GATE_DUMMY,
 
+	[CLK_MBUS_EMAC1]	= GATE(0x804, BIT(12)),
 	[CLK_BUS_MMC0]		= GATE(0x84c, BIT(0)),
 	[CLK_BUS_MMC1]		= GATE(0x84c, BIT(1)),
 	[CLK_BUS_MMC2]		= GATE(0x84c, BIT(2)),

-- 
2.54.0

