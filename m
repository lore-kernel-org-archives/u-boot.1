Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739FFC25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 03:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2EE4885E4;
	Sat, 18 May 2024 05:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="dPHffoCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E53D8858C; Sat, 18 May 2024 05:55:19 +0200 (CEST)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com
 [95.215.58.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4C7885A0
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 05:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Envelope-To: contact@jookia.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1716004517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aT9xmtMVgAoWnzoaRYOrRVILa1wd+OE7PzOHEMlobek=;
 b=dPHffoCSVQPgxzGdQfnzDY2j7CIfh4j3ki9/AWJPkmULCqf5OdzR/I+0pijW0A8r6U42x8
 icfU03jG2KXZYmDaFmqGGfNSMmKlrZejx5H2HrvobSbhCbR0zSO4f1cHMQSY97FycwNR86
 1Jn+tz0DiPl3bm+79fAZJHtatbdaITdmxe6MG1nBUj1DrVcVaQTFVEYXBDt/sNI0rg8nk7
 GhDH2OJyLYbXjWN2LSEd/lTP/xNMXgHX6hmQrCChl1VADa4VpCTaXajyPSwD8D+55tIxO6
 AeTPT6gMkLlMD/XrkFLuwtYbtzbdTqr/ng5scRGbIuvXYj7VOSX0V/K5V4qIhw==
X-Envelope-To: lukma@denx.de
X-Envelope-To: rick@andestech.com
X-Envelope-To: seanga2@gmail.com
X-Envelope-To: ycliang@andestech.com
X-Envelope-To: sumit.garg@linaro.org
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: trini@konsulko.com
X-Envelope-To: andre.przywara@arm.com
X-Envelope-To: jagan@amarulasolutions.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Date: Sat, 18 May 2024 13:54:43 +1000
Subject: [PATCH RFC 1/4] clk: sunxi: Add PWM bus clock and reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240518-pwm_d1-v1-1-311fc5fe2248@jookia.org>
References: <20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org>
In-Reply-To: <20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1716004486; l=912;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=Kmsnwpa7uOGEZkgz5Qdpb19tUIvmBu659timOMwdCoQ=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAmLfjqVpJ/iUXB5DkKnR8War
 Hmt1z+n/ABox9k1a7zESFEiyVhMoM1niUmvDy6NRTF+gm6UZLzbjH8BsqmdXKCAUAAPQ/
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

This is needed for the D1 PWM driver.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/clk/sunxi/clk_d1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/sunxi/clk_d1.c b/drivers/clk/sunxi/clk_d1.c
index 9dae761de8..6577d86e0b 100644
--- a/drivers/clk/sunxi/clk_d1.c
+++ b/drivers/clk/sunxi/clk_d1.c
@@ -15,6 +15,8 @@
 static struct ccu_clk_gate d1_gates[] = {
 	[CLK_APB0]		= GATE_DUMMY,
 
+	[CLK_BUS_PWM]		= GATE(0x7ac, BIT(0)),
+
 	[CLK_BUS_MMC0]		= GATE(0x84c, BIT(0)),
 	[CLK_BUS_MMC1]		= GATE(0x84c, BIT(1)),
 	[CLK_BUS_MMC2]		= GATE(0x84c, BIT(2)),
@@ -48,6 +50,8 @@ static struct ccu_clk_gate d1_gates[] = {
 };
 
 static struct ccu_reset d1_resets[] = {
+	[RST_BUS_PWM]		= RESET(0x7ac, BIT(16)),
+
 	[RST_BUS_MMC0]		= RESET(0x84c, BIT(16)),
 	[RST_BUS_MMC1]		= RESET(0x84c, BIT(17)),
 	[RST_BUS_MMC2]		= RESET(0x84c, BIT(18)),

-- 
2.45.1

