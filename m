Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC4606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cW+ivPmr;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=h1kvJYWJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B27046088F;
	Tue, 17 Nov 2026 11:37:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IV5DVZw9MPoU; Tue, 17 Nov 2026 11:37:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D8FBF60887
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794915464;
	b=jgscqbzf9Jccd6mnWzHKBpxsB5BnDV7PpW7eC4G2sB9bqpi2qBtfyhegFf+bGojkBvZq
	 P85F9doETBHK84W/DUmIPfQ9YNdPMQsIh6/JXLlJK9EZ+PLEU0m0p3rqOWqwca49zKZFO
	 2AIjKv5mV64pbaAiwkh6Quw8rkB2QQJ0r+AsvDTMjI34smk68eLUvBr3BxL1yLWbhngLB
	 B1QWIt11XhMsWWSNIb69SONO1gd8CIjJxqcOhmo2tq//buuJVrLlDRyPtFsLU02Yz2Cim
	 ezx9Z7RH3DJic5jzAukhjIBta9l5jtpCpHQYvURfHK+Qr4UfSZBMbhYa+fp0h2MZckA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794915464;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZCru7Zxm6epqUCNwFINnIky2gXSejYW/XSPC3+l9jJI=;
	b=DRL86HMng/2waIsqXENkZvWGnhWlqGVNPuOtRfJjhqkhB4SxbSf3rwTSDAljXmrLEz6B
	 YxujsNetZfQoBIl9hag9c9lTHIGuizWsp5H/1FMjmlAZ26wGpzhGyY4V3Tqi1lLEakDhB
	 5BGSwR2NEp5r8s9ZpFbQQKbFGKrguwvNoWJjmIKWvcnQ+Pd7SUd5JGGg/SOTO6KIVbZyu
	 QtzSR8Ej7F33mD/1vMzC/SefKyLvAQDLqg9ZU8/AdaKO0VqS2Tt2eZ1gVreCQG6EOy6Xn
	 IZHBqY7Fn/fdSK8Qd4pl+jz0Tk0YK9sWzPQWdUws5fP+YaE+vxxeQJ+vXg/fXkThSGQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794915464;
	bh=ZCru7Zxm6epqUCNwFINnIky2gXSejYW/XSPC3+l9jJI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cW+ivPmr7QY7T6JMKfAwaksq3ateNdbvxCbUzG7ImOz7JboMz1S2/0kxIf8BbJtfZ
	 mNf5AY1mnh1yW6oELWg2qcTlKmPaYz5O0AXj0nEOV1Naad8tOcZhckdmQtST9CAW5G
	 GnLaM+KNUIyz6tKZZqqQjNHmt2C0VT8VTlueKXE0SYDgtWNQ64gLlkFq1+YqYGOqb7
	 o3iiib8E7Ic+Q4HAELapQRQV7bMW9y1SOuipn1YItt6Sn3BQH/fTUG8msbHMX1x72G
	 414Y+5fGETPL6AXYBuu48HktDfhuIy/AlwJ4A7UBlcF/3afudc65mpj/oszNSi2RtK
	 VL7R2ukGTbH1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8FBF60887;
	Tue, 17 Nov 2026 11:37:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DF4C13C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13FFC8109F
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id toGzTQohjTCx for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 11:37:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 38C8A81027
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.125.25.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.12;
 helo=smtp-190c.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=h1kvJYWJ
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [185.125.25.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38C8A81027
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:34 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTN4r5NBWz18Z;
 Tue, 17 Nov 2026 12:37:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794915452;
 bh=ZCru7Zxm6epqUCNwFINnIky2gXSejYW/XSPC3+l9jJI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=h1kvJYWJOhFFXIj9wiDU2ezHEL5y73UDk5unnTNzhWLiGBBbof3xkhhV+HROyGYwl
 x/OC1qa7NKaXbx0DyKFXtNUefag2c3Qd1uorp50+A/b4AVr0TBDu9LkjtsM83+SO6V
 W6ruiZ6IqeyrDSptTLHzfxBN/8Seh1hKZ2yi8HyJoBWgHILWnDaVVasqCQtlTfYBZP
 DVsl0TiqLT2tHELzYDe6X1kKizNO4Z/AWr5vnDmSg+CrCVbNYeQXt3J+vrbCY68yeg
 zuUzzKsIGzhckquIdI9zI1AMiR5ZxPwC9tzhOubFhgCQKE50kqbJIABx5O0tARV/m2
 K23XaeqyBcAPQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTN4q5nVZz98f; Tue, 17 Nov 2026 12:37:31 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 12:37:17 +0100
Subject: [PATCH next 8/8] clk: rockchip: rv1126: improve PLL_CON() user
 friendliness
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-clk-better-con-names-v1-8-25521d4e37c3@cherry.de>
References: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
In-Reply-To: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

There's no PMU_MODE, PLL_CON8/16/24 or PMU_PLL_CON0 in the TRM so one
needs to do an additional lookup the header file to know what exactly
this refers to.

Use new macros that reflect the names used in the TRM.

No intended change in behavior.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/include/asm/arch-rockchip/cru_rv1126.h |  9 ++++++---
 drivers/clk/rockchip/clk_rv1126.c               | 12 ++++++------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
index 20e580a8eb3d..9390c71fce15 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
@@ -149,9 +149,12 @@ struct cpu_rate_table {
 	unsigned int pclk_div;
 };
 
-#define RV1126_PMU_MODE			0x0
-#define RV1126_PMU_PLL_CON(x)		((x) * 0x4 + 0x10)
-#define RV1126_PLL_CON(x)		((x) * 0x4)
+#define RV1126_PMU_MODE_CON		0x0
+#define RV1126_PMU_GPLL_CON(x)		((x) * 0x4 + 0x10)
+#define RV1126_APLL_CON(x)		((x) * 0x4 + 0x00)
+#define RV1126_DPLL_CON(x)		((x) * 0x4 + 0x20)
+#define RV1126_CPLL_CON(x)		((x) * 0x4 + 0x40)
+#define RV1126_HPLL_CON(x)		((x) * 0x4 + 0x60)
 #define RV1126_MODE_CON			0x90
 
 enum {
diff --git a/drivers/clk/rockchip/clk_rv1126.c b/drivers/clk/rockchip/clk_rv1126.c
index 018232dcb027..ac5791aaf050 100644
--- a/drivers/clk/rockchip/clk_rv1126.c
+++ b/drivers/clk/rockchip/clk_rv1126.c
@@ -55,16 +55,16 @@ static struct rockchip_pll_rate_table rv1126_pll_rates[] = {
 };
 
 static struct rockchip_pll_clock rv1126_pll_clks[] = {
-	[APLL] = PLL(pll_rk3328, PLL_APLL, RV1126_PLL_CON(0),
+	[APLL] = PLL(pll_rk3328, PLL_APLL, RV1126_APLL_CON(0),
 		     RV1126_MODE_CON, 0, 10, 0, rv1126_pll_rates),
-	[DPLL] = PLL(pll_rk3328, PLL_DPLL, RV1126_PLL_CON(8),
+	[DPLL] = PLL(pll_rk3328, PLL_DPLL, RV1126_DPLL_CON(0),
 		     RV1126_MODE_CON, 2, 10, 0, NULL),
-	[CPLL] = PLL(pll_rk3328, PLL_CPLL, RV1126_PLL_CON(16),
+	[CPLL] = PLL(pll_rk3328, PLL_CPLL, RV1126_CPLL_CON(0),
 		     RV1126_MODE_CON, 4, 10, 0, rv1126_pll_rates),
-	[HPLL] = PLL(pll_rk3328, PLL_HPLL, RV1126_PLL_CON(24),
+	[HPLL] = PLL(pll_rk3328, PLL_HPLL, RV1126_HPLL_CON(0),
 		     RV1126_MODE_CON, 6, 10, 0, rv1126_pll_rates),
-	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RV1126_PMU_PLL_CON(0),
-		     RV1126_PMU_MODE, 0, 10, 0, rv1126_pll_rates),
+	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RV1126_PMU_GPLL_CON(0),
+		     RV1126_PMU_MODE_CON, 0, 10, 0, rv1126_pll_rates),
 };
 
 static ulong rv1126_gpll_set_rate(struct rv1126_clk_priv *priv,

-- 
2.56.1

