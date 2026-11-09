Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2AD606A326
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pN+FLEG+;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f3ei7DGl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1C8C80DCB;
	Mon,  9 Nov 2026 21:02:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PtmjFSHxIGik; Mon,  9 Nov 2026 21:02:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A598380D4A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794258150;
	b=EVU13ClIb1qRVEahhbdYEBJbKvuijnYZzRwjWwQab9IAZUTaIcYOhiZf+Ij/pFL6/9UM
	 bZCY5Hijqwtmecyv+ge051Yp5RNwD/QCdayWxDVC6MW2UCul4x/ECrzVsjxJeyD03a278
	 BRGuQTYGbOlP67173XbtUZrfNlqrDdrTXSvhMHYBl2n9tnXyEEyXxJmtwoF0IoHABX/DU
	 BsndK8WISahnfuQ6YIddQjPxy3FasiPnOSWCD+Phg74gsPHXzi8IKDbcruphzDxNrAMup
	 L6yfziqgJ3rC6hC3LKYGcDbF8wra9K3NRY51RZ7Oz4zhImIkkAKHF/Koy1CPEtlrCtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794258150;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sJvhBq3TCSNpGsw4BzgjMvZ0lenk515jIabFhqx/OEo=;
	b=JaNSYA1wVcFqCX5hj7Y6Sq7n4IrQHETL8bcIpEL/zC3PtRsoAY2PY/xYEyesYPPUcfN7
	 CgX5uFqP/pgojL52vA7kTYdBCLVUaDgwpsdBVtAjw6ux9eO3vKsWOtkag4KzdUnOy18pe
	 ucONiAzYXOYWtXsCw+TAeAt3LxGJUjcV3xroqWu0m1n1WK9ToSZKDxfYBrjjVDjOz+BEK
	 hhAY+jkUueERugKoj1Neu/pplFWsT/D2T9f4UiANEQG2lJMRyMEERJy/DHdapKtzxtQYX
	 d8YJImMMyV+KPjdmCvuYgWu52VQehie4ubKp0bz29nwjS3E7VxeIm940F1TnvzpVedQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794258150;
	bh=sJvhBq3TCSNpGsw4BzgjMvZ0lenk515jIabFhqx/OEo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pN+FLEG+ExYeuxblVA/uQCVQaJxG0RZLoDiw9ynBSjvdNJ83Pnl9ZazFu+GfYYgh3
	 f3s+/CUMHzv+4ALxnNKxqL9PTDiqqfunP35fHX8aNK76Ory6HhzXZlrTbGC5niNBRC
	 GnI1fEXDvgz7wC2H2Lxf6cWAjwnT+VlmpQw0QwtrMW7dt6aXYU2WFX2k4C4ZLn6IzG
	 sARaEGgyeZoZTyTwzs/UuatsQxhFJwvlwQ1HFonUVPd9BbNzvsLDR8DWGKDFk5Ewde
	 w32x3Rwv5TVhyw4cYDwXLXG6of5yLnCAx8KIAYoq7/X+q10CZ/gbutcKCHswNcx7KY
	 v4WuMQAYwqISg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A598380D4A;
	Mon,  9 Nov 2026 21:02:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7977235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9AD7406FC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:02:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lsAycmJgzHG3 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:02:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A2904406A5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=arturkow2000@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=f3ei7DGl
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2904406A5
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:02:26 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso14013075e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794258145; x=1794862945;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sJvhBq3TCSNpGsw4BzgjMvZ0lenk515jIabFhqx/OEo=;
 b=f3ei7DGlk59BVDyHovZfurczzSwLURDIZR916plEqAlE2BtT7vmQvJAwWwFzjRgv4e
 aoNWVTT68CaxxRWrKbVbXuXYE7JmomyFNnyl1g8GOP2EyjEEv1wCdJBAVA5xQMn7WKel
 cV5DkEumhbToUwzKjih8SCSzucSxavERHmnDPv04sEEdbWFTpaUcnU+3aDDmw/mDKi05
 D7fE/wvHnuiKFyuW8rq5kuudQkG/DoeKcMOtwqwgjVsHBE3qTkjZPcDrik/tSJGkbU96
 fk9TXju/99mnW1H+7F5zNojhYCRDltFUuOJAWyO6bmCBOA6dmbntlrS8+oGv4m543IkI
 hOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794258145; x=1794862945;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sJvhBq3TCSNpGsw4BzgjMvZ0lenk515jIabFhqx/OEo=;
 b=QfhqrCgytsHiW4E1/TegI+PYMFjE0CrZv3aHMoaOvcaCEYdvv++QxgVkgwLHlKbnIM
 J0ZgxgD97peuWRlhaK7eudbDjTmo4UGaU1I1G0CFfKUgFSPsEbs1CNQk9U6Cj1ruzUNP
 LXeuDcuMXjCZnya73dW5RBPwNYC162KRaHEgv3vc2jckVNr5EAObFXqDgnbL0/Onn7AU
 vLl9tj13i7N9Y+Iv/c2Poo9Mf2TDRzjREQUmhRzTR8lVMm9HGaw8FBBRPW9S6Cg+7Wr8
 +0N6R6SH1dudPtjzbPoEXdyYnbfH/XT/l4AZu/UVpjO9VRAPenVlYUA7mlV0uZJ8XV1Y
 el7Q==
X-Gm-Message-State: APuU4Z+ANaMbNJHfTG2xVtfp+VwTscmuDMEX3lh0Iq7hXPRpMMv00wDT
 iAtqDZegSw3lZA1Zizwkhjc2GteAvT3tWWiRMVsZWx67MF9lKYByfkpt
X-Gm-Gg: AYBFou34zLwryyVoMO/Q2NjblHXaXvsio/7R09doT0D5mJCCEU/Kj+S5KNl510ir+38
 n78dnZkgpP8hoGDcP3xQZhkwgtkkF5utx8LkYRiXAjAZ+oTuTWQ5FAzP9EsFK79kUdaF20z3A9K
 HUpDYlY1ulFUXQm4LHETcmtQXsIEQfmkqreRZIj0JXbHke5N6sOk9j3KlFFVPG760bAvvK6u1iy
 HecL5dQfV5MurD7v6FvyOp4VD0NeVQUdp6FapbWjVAa8RdpHGwUYhL5fEemVmhgEZHCpBy482T2
 voUD8Dz2Li+3oN9SP20wD2Wpl5kvnMNCxsA95rGBb1QggnsuJHK7Z8ArOOayWnjvtKBY+iRPwji
 PNrPARiplxL5Pe1XtOs+ngT7DMIdbbSdgW8APwUkldGqL4/q3gNccbPOx8k3IeaX8YvTizxzQ/j
 hjS0xDLyJJdP4j1lJBAmhkU1O57WZE1cUX9IW0QbTGqAk2DjFp5KMw4pPaAarHPwlx1+Zu4VDfl
 2ZTZX9yU+HoOQRjeBL6uAMTG82sS25kLSa8qC7qiGgCQiM2tUFxO4b1LKnuVjdPUwclLxoI63dl
 EkbvUZd99d1cuQwyezKjMVQoxRsosjebE4qWNw/p
X-Received: by 2002:a05:600c:81c5:b0:4b6:540d:6317 with SMTP id
 5b1f17b1804b1-4ba02343ae5mr6652965e9.12.1794258144885; 
 Mon, 09 Nov 2026 13:02:24 -0800 (PST)
Received: from [192.168.0.15] ([2a02:a312:c59b:a180:251a:f25f:80fa:af1d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba020485bcsm12113705e9.11.2026.11.09.13.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:02:23 -0800 (PST)
From: Artur Kowalski <arturkow2000@gmail.com>
Date: Mon, 09 Nov 2026 22:02:18 +0100
Subject: [PATCH] watchdog: tegra: support Tegra20
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-wdt-tegra20-v1-1-d04bbc5829e4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMMQ7CMAwF0KtYf26kJINV5SqIoalNMUOpkgCVo
 t4dFca3vI6qxbQiUUfRt1V7rkgUBsJ8n9ZFnQkSIfrIIfjRfaS5pkuZonejMCtnzl4EA2ErerP
 9t12uf9dXfujczgLH8QXZ+RfIbwAAAA==
X-Change-ID: 20261108-wdt-tegra20-8d66e6b6b0dd
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Artur Kowalski <arturkow2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7121;
 i=arturkow2000@gmail.com; s=default; h=from:subject:message-id;
 bh=JuR49rPTxsb7XIK1WoSkrcgAgRu26T5U5mLQS60ErrM=;
 b=owGbwMvMwCVmYeTc/TaVxZzxtFoSQ9Ynk3v/en5+TEi9YZvn7dETz2s5J/S61IOwdfyrC6fbR
 t3wrG/oKGVhEONikBVTZDF7KPSFZ57X+w0vt3bCzGFlAhnCwMUpABPxaGZk6O3WFVrwY9l3w/c+
 Gd8P+J7mM3k2b9L8pImlHUcUGhcv/MLI0LhlVpnJjcRrf89O4Izo/RQ9XyPy9Q0dbV+7BWuZo7y
 zGAA=
X-Developer-Key: i=arturkow2000@gmail.com; a=openpgp;
 fpr=F60710C8D69E03A01A2801CD87A47D20C2709637
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The timer driver binds tegra_wdt to Tegra20's timer node as well, but the
driver programs timer 5 and watchdog 0, which only exist on Tegra30 and
later. On Tegra20 they lie past the end of the timer block, so starting the
watchdog writes to unrelated registers.

Tegra20 has no watchdog block. Instead, the clock and reset controller can
reset the system when the interrupt of timer 1 or 2 fires while the previous
one is still pending, enabled through the WDT bits of RST_SOURCE. Use timer
1 for it (U-Boot itself only uses the microsecond counter): run it periodic
with half of the timeout as period. Clearing the interrupt alone doesn't
restart the period, which would leave between half and all of the timeout
after a ping, so a ping also rewrites the timer setting, read back from
the timer, to restart it.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---
Add watchdog support for Tegra20. This makes it possible to recover
from hangs in U-Boot or early during Linux boot.

Linux doesn't handle a running Tegra20 watchdog yet. Its timer driver
takes over TIMER1 for CPU0's clock event device, which can reset the
system early during boot.

There is also a Tegra20 quirk that affects any watchdog reset while
Linux runs: the watchdog resets the system through the clock and reset
controller, which doesn't reset the PMC, so the power partitions keep
their state. Linux powers the VDE partition off when its PMC driver
registers it, and whenever the VDE is idle. If the watchdog fires while
the partition is off, the boot ROM hangs and the device stays dead
until it is powered off. Linux already works around the same hang for
reboots (commit 8f0c714ad9be ("media: staging: tegra-vde: Turn ON power
domain on shutdown") and commit 510f276df2b9 ("mfd: tps6586x: Register
restart handler")). The Linux patches that will follow stop the
watchdog before the VDE partition is powered off.

For these reasons I haven't enabled the watchdog in any defconfig.

checkpatch suggests IS_ENABLED() instead of the #if blocks. They select
whole functions and a struct member, as a U-Boot binary supports a
single SoC generation and the two variants share no register layout.
I'm happy to restructure it with IS_ENABLED() if preferred.

The patch was developed with the help of Claude Code. I have reviewed
it and tested it on an ASUS TF101 (Tegra20). Tegra30 and later are
untested, but their code path is unchanged.
---
 drivers/watchdog/tegra_wdt.c | 102 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index adc30da579a..6dc3a3e0b1d 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -10,13 +10,105 @@
 #include <wdt.h>
 #include <hang.h>
 #include <asm/io.h>
+#include <asm/arch/tegra.h>
+#include <asm/arch-tegra/clk_rst.h>
 #include <watchdog.h>
 
 /* Timer registers */
 #define TIMER_PTV			0x0
 #define TIMER_EN			BIT(31)
 #define TIMER_PERIODIC			BIT(30)
+#define TIMER_PTV_MAX			GENMASK(28, 0)
+#define TIMER_PCR			0x4
+#define TIMER_PCR_INTR_CLR		BIT(30)
 
+struct tegra_wdt_priv {
+#if !defined(CONFIG_TEGRA20)
+	void __iomem *wdt_base;
+#endif
+	void __iomem *tmr_base;
+};
+
+#if defined(CONFIG_TEGRA20)
+/*
+ * Tegra20 has no watchdog block. Instead the clock and reset controller can
+ * reset the system when the interrupt of timer 1 or 2 is asserted while the
+ * previous one is still pending.
+ */
+#define T20_WDT_EN			BIT(5)
+#define T20_WDT_SEL_TMR2		BIT(4)
+#define T20_WDT_SYS_RST_EN		BIT(2)
+#define T20_WDT_MASK			(T20_WDT_EN | T20_WDT_SEL_TMR2 | \
+					 T20_WDT_SYS_RST_EN)
+
+/* Use Timer 1 as WDT counter */
+#define T20_WDT_TIMER_BASE		0x0
+
+static int tegra_wdt_reset(struct udevice *dev)
+{
+	struct tegra_wdt_priv *priv = dev_get_priv(dev);
+
+	/*
+	 * Clearing the interrupt alone doesn't restart the timer, so the
+	 * reset could follow as soon as half the timeout after the ping.
+	 * Rewriting the timer setting restarts its period. The register reads
+	 * back the setting (in periodic mode, the timer never clears TIMER_EN),
+	 * and while stopped it holds 0, so pinging doesn't start the timer.
+	 */
+	writel(readl(priv->tmr_base + TIMER_PTV), priv->tmr_base + TIMER_PTV);
+	/*
+	 * Clear the pending interrupt. Doing it after the restart is safe:
+	 * an interrupt from the new period that fired in between is just
+	 * cleared as part of this ping.
+	 */
+	writel(TIMER_PCR_INTR_CLR, priv->tmr_base + TIMER_PCR);
+
+	return 0;
+}
+
+static int tegra_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
+{
+	struct clk_rst_ctlr *clkrst = (struct clk_rst_ctlr *)NV_PA_CLK_RST_BASE;
+	struct tegra_wdt_priv *priv = dev_get_priv(dev);
+	u64 period;
+
+	/*
+	 * The reset occurs on the second expiry of the timer after a ping,
+	 * so the timer period is half of the timeout. The timer has a fixed
+	 * 1 MHz clock and counts PTV + 1 ticks.
+	 */
+	period = timeout * 1000 / 2;
+	if (period < 1 || period > TIMER_PTV_MAX + 1ull)
+		return -EINVAL;
+
+	writel(TIMER_EN | TIMER_PERIODIC | (u32)(period - 1),
+	       priv->tmr_base + TIMER_PTV);
+	/*
+	 * Clear an interrupt left pending from earlier use of the timer,
+	 * which would otherwise reset the system on the first expiry, after
+	 * half the timeout. If the new timer has already expired, this counts
+	 * as a ping, which is harmless right after starting.
+	 */
+	writel(TIMER_PCR_INTR_CLR, priv->tmr_base + TIMER_PCR);
+
+	clrsetbits_le32(&clkrst->crc_rst_src, T20_WDT_MASK,
+			T20_WDT_EN | T20_WDT_SYS_RST_EN);
+
+	return 0;
+}
+
+static int tegra_wdt_stop(struct udevice *dev)
+{
+	struct clk_rst_ctlr *clkrst = (struct clk_rst_ctlr *)NV_PA_CLK_RST_BASE;
+	struct tegra_wdt_priv *priv = dev_get_priv(dev);
+
+	clrbits_le32(&clkrst->crc_rst_src, T20_WDT_MASK);
+	writel(0, priv->tmr_base + TIMER_PTV);
+	writel(TIMER_PCR_INTR_CLR, priv->tmr_base + TIMER_PCR);
+
+	return 0;
+}
+#else
 /* WDT registers */
 #define WDT_CFG				0x0
 #define WDT_CFG_PERIOD_SHIFT		4
@@ -36,11 +128,6 @@
 #define WDT_TIMER_BASE			0x60
 #define WDT_TIMER_ID			5
 
-struct tegra_wdt_priv {
-	void __iomem *wdt_base;
-	void __iomem *tmr_base;
-};
-
 static int tegra_wdt_reset(struct udevice *dev)
 {
 	struct tegra_wdt_priv *priv = dev_get_priv(dev);
@@ -87,6 +174,7 @@ static int tegra_wdt_stop(struct udevice *dev)
 
 	return 0;
 }
+#endif
 
 static int tegra_wdt_probe(struct udevice *dev)
 {
@@ -97,8 +185,12 @@ static int tegra_wdt_probe(struct udevice *dev)
 	if (!base)
 		return -ENOENT;
 
+#if defined(CONFIG_TEGRA20)
+	priv->tmr_base = base + T20_WDT_TIMER_BASE;
+#else
 	priv->wdt_base = base + WDT_BASE;
 	priv->tmr_base = base + WDT_TIMER_BASE;
+#endif
 
 	return 0;
 }

---
base-commit: 2f797312a4e2c5d104786dbcde9f7db8e355ee6e
change-id: 20261108-wdt-tegra20-8d66e6b6b0dd

Best regards,
--  
Artur Kowalski <arturkow2000@gmail.com>

