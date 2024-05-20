Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C64C04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 06:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 429D58817C;
	Mon, 20 May 2024 08:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="g9srCmmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B8F788621; Mon, 20 May 2024 08:11:02 +0200 (CEST)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [91.218.175.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0DF8817C
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 08:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Envelope-To: jagan@amarulasolutions.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1716185457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7EE+n7dXbvm7hDwXm9PI7enxm7iElAKKNeZSI0hkKY=;
 b=g9srCmmcUkPqND6zgTJSJdtrTc+/TR7HGydod+Y1BHsOpF68GvTyqkYVdr16zRViTq2AMV
 OHVCoskiwMZP4LRbZhuIBfxUzsn/CJnI3PaimbLfgNENR/4WqMjvPM185WwGjLTVIG+xcl
 5KR/tczJ3EzWw4lqJIr3m2eM5wC5l2o1ZheIove0mUovMEiygCD1w5Rv6PCtweUQToAweK
 2PXE+C3V0yEyCBYiMcBk90wzZp3cI266rmArG5eEJEX/7uMox0Xsdp5FpkexltHd9DZYOE
 QyAYG4BTfTmo34JYx/LSv6quGI38ZX9/mZk5irvvbqanCQflkCnvtl6rDtP0Yg==
X-Envelope-To: andre.przywara@arm.com
X-Envelope-To: lukma@denx.de
X-Envelope-To: seanga2@gmail.com
X-Envelope-To: trini@konsulko.com
X-Envelope-To: rick@andestech.com
X-Envelope-To: ycliang@andestech.com
X-Envelope-To: sumit.garg@linaro.org
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: "Cc:u-boot"@lists.denx.de, John Watts <contact@jookia.org>
Subject: Re: [PATCH RFC 3/4] pwm: sunxi: Add support Allwinner D1 PWM
Date: Mon, 20 May 2024 16:10:37 +1000
Message-ID: <20240520061037.2675720-1-contact@jookia.org>
In-Reply-To: <20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org>
References: <20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

After a long time reading the datasheet I found out my approach was
actually wrong and led to an off by on error.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/pwm/sunxi_pwm_d1.c | 57 +++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/sunxi_pwm_d1.c b/drivers/pwm/sunxi_pwm_d1.c
index 6c57bc6e85..f396afff3e 100644
--- a/drivers/pwm/sunxi_pwm_d1.c
+++ b/drivers/pwm/sunxi_pwm_d1.c
@@ -1,34 +1,41 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright 2022 Jookia <contact@jookia.org>
 /*
- * The Allwinner D1's PWM channels are 16-bit counters with up to
- * 65537 cycles (yes, you read that correctly).
+ * The Allwinner D1's PWM channels are paired 16-bit counters.
  *
  * Each channel must be programmed using three variables:
  * - The entire cycle count (used for the period)
- * - The active cycle count (the count of inactive cycles)
- * - The polarity (specifies if the signal is active high or low)
- * The cycle counts are at minimum 1 and at maximum 65536.
+ * - The active cycle count (used for the duty cycle)
+ * - The active state polarity (specifies if the signal goes high or low)
  *
- * The controller will output the number of entire cycles plus one
- * extra, with any cycles after the active cycle output as active.
+ * All counts are zero based, but the datasheet spends a lot of time
+ * adding 1 to the entire cycle count. There's no hidden extra cycle,
+ * it's just trying to make it human understandable. After all, you can
+ * have 0 active counts for a 100% duty cycle, but 0 entire cycles
+ * doesn't really mean sense or work in time calculations.
  *
- * Consider a PWM period of 128 nanoseconds and a cycle period of 32.
- * Setting the entire cycle count to 3 and active cycle count to 4
- * gives an output like so:
+ * The counter works like this (quoting the datasheet):
+ * - PCNTR = (PCNTR == PWM_ENTIRE_CYCLE) ? 0 : PCNTR + 1
+ * - PCNTR > (PWM_ENTIRE_CYCLE - PWM_ACT_CYCLE) = Output active state
+ * - PCNTR <= (PWM_ENTIRE_CYCLE - PWM_ACT_CYCLE) = Output inactive state
  *
- * - Cycle 1 runs 0 to 32 nanoseconds, inactive
- * - Cycle 2 runs 32 to 64 nanoseconds, inactive
- * - Cycle 3 runs 64 to 96 nanoseconds, inactive
- * - Cycle 4 runs 96 to 128 nanoseconds, inactive
- * - Cycle 5 is skipped but would run 128 to 160 nanoseconds, active
+ * Here's a 2-bit table of cycle counts versus active cycle counts:
+ *   Active:  |       0 |        1  |        2  |        3 |
+ *   Count 0  | Active  | Inactive  | Inactive  | Inactive |
+ *   Count 1  | Active  | Active    | Inactive  | Inactive |
+ *   Count 2  | Active  | Active    | Active    | Inactive |
+ *   Count 3  | Active  | Active    | Active    | Active   |
  *
- * If we set the entire count to 4, cycle 5 would run and we wouldn't be
- * able to specify it as inactive as the active count only goes up to 4.
+ * An entire count of 2 and active count of 3 would always be inactive.
  *
- * In practice this means we want to set the entire cycle to be one less
- * then the actual number of cycles we want, so we can set the number of
- * active cycles to be up to maximum for a fully inactive signal.
+ * The main takeaways here for us are:
+ * - The counter wraps around when it hits the entire cycle count
+ * - The output is active after the counter equals the active cycle count
+ * - An active count of 0 means the period is a 100% active cycle
+ * - An active count larger than the entire cycle count is a 0% active cycle
+ *
+ * This driver deals with the last problem by limiting the entire cycles
+ * to 65534 so we can always specify 65535 for a 0% active cycle.
  *
  * The PWM channels are paired and clocked together, resulting in a
  * cycle time found using the following formula:
@@ -123,7 +130,7 @@ int find_channel_dividers(uint period_ns,
 			  uint parent_hz,
 			  struct pwm_timings *out)
 {
-	uint ideal_cycle_ns = div_ns(period_ns, 65536);
+	uint ideal_cycle_ns = div_ns(period_ns, 65535);
 	int common_div = out->common_div;
 	int prescaler = 1;
 	uint cycle_ns = 0;
@@ -160,10 +167,10 @@ int find_channel_timings(const struct pwm_channel *in,
 	if (find_channel_dividers(in->period_ns, parent_hz, &new))
 		return -1;
 
-	new.entire_cycles = (in->period_ns / new.cycle_ns) - 1;
+	new.entire_cycles = (in->period_ns / new.cycle_ns);
 	new.active_cycles = (in->duty_ns / new.cycle_ns);
-	new.period_ns = (new.entire_cycles + 1) * new.cycle_ns;
-	new.duty_ns = new.active_cycles * new.cycle_ns;
+	new.period_ns = (new.entire_cycles * new.cycle_ns);
+	new.duty_ns = (new.active_cycles * new.cycle_ns);
 	new.polarity = in->polarity;
 
 	if (error_too_large(new.period_ns, in->period_ns))
@@ -311,7 +318,7 @@ void enable_channel(void *base, int channel, struct pwm_timings *timings)
 {
 	u32 pwm_active = (timings->polarity) ? 0 : PCR_PWM_ACTIVE;
 	u32 prescale = (timings->prescale_k - 1);
-	u32 entire_cycles = timings->entire_cycles;
+	u32 entire_cycles = (timings->entire_cycles - 1);
 	u32 active_cycles = timings->active_cycles;
 
 	u32 PCR_clear = (PCR_PRESCAL_K_MASK | PCR_PWM_ACTIVE);
-- 
2.45.1

