Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70217E6780C
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 20:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2D3890F8;
	Sat,  2 Nov 2024 21:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gVI0EM//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB4CE890F8; Sat,  2 Nov 2024 21:38:17 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 668E3892CE
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 21:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4e10=R6=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730579889; bh=5mSqNHqKvVfDHYrcaMfSdaKEmshdOlfRqtos/ACAZwI=;
 b=gVI0EM//N195P/K9vruoebrB+aY1sFjjUiJF/8uYBp8Gya9N0foYbhkx9JzaX3weekNdJ/85D
 LcC36CRsKGL0iMxRjTB5xHnL0AYDRTsndW/egFjhx4MNycrIO+2eoTad0AH3buWmKPIfL+VtuNF
 Gds3CSrLRAB0LiUz+I2EMjwF3lIl7tRMwP4tNvta9Jktu+SogzWIYB35IPu8hhcxm8i0enXLMUl
 zs7Ru1CPrZkIo1PbkTU73yOIoWQ0Fx8vlJ6UWxW4z+X9Es2us8v0s4f18ZcQD13S9l64V8R7eu7
 fP4o64s5+1aR3WTtHAzF2ghekkvJna6y63Sf+5N1JE9A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/3] rockchip: rk3308: Implement checkboard() to print SoC
 variant
Date: Sat,  2 Nov 2024 20:37:41 +0000
Message-ID: <20241102203746.3631481-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241102203746.3631481-1-jonas@kwiboo.se>
References: <20241102203746.3631481-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67268dae922720f2eae9024b
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

Implement checkboard() to print current SoC variant used by a board,
e.g. one of:

  SoC:   RK3308
  SoC:   RK3308B
  SoC:   RK3308B-S

when U-Boot proper is running.

  U-Boot 2025.01-rc1 (Nov 02 2024 - 20:26:25 +0000)

  Model: Radxa ROCK Pi S
  SoC:   RK3308B
  DRAM:  512 MiB (effective 510 MiB)

Information about the SoC variant is read from GRF.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 arch/arm/mach-rockchip/rk3308/rk3308.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
index c6b1a35f47e6..03d97e1d7460 100644
--- a/arch/arm/mach-rockchip/rk3308/rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
@@ -216,3 +216,19 @@ int arch_cpu_init(void)
 	return 0;
 }
 #endif
+
+#define RK3308_GRF_CHIP_ID	0xFF000800
+
+int checkboard(void)
+{
+	u32 chip_id = readl(RK3308_GRF_CHIP_ID);
+
+	if (chip_id == 0x3308)
+		printf("SoC:   RK3308B\n");
+	else if (chip_id == 0x3308c)
+		printf("SoC:   RK3308B-S\n");
+	else
+		printf("SoC:   RK3308\n");
+
+	return 0;
+}
-- 
2.46.2

