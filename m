Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5252DC79FB7
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 05:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0869F80F16;
	Thu, 10 Sep 2026 05:36:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T8g8QYi_L0Bx; Thu, 10 Sep 2026 05:36:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D475480F00
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789018615;
	b=LsvR7pY6wRqa68gzIMgL8xZw5GpogPTfyd37tEgA67K/K6EOJrIdgHiWrxjtjcBWa0iJ
	 YAzWyAn+oqk1CVGO0yENvBfzcep25zVbsDRpjuvOs8MDywChCPL8bZC4pWReLqOE6EmyB
	 EspVewrQ4/ROFVR591/00865GQQf7OZTseLBBZOneR7UByzzZ4+XYpcy1jJNasjs95fgZ
	 yyKRfRf1KAcTvfd754SGakEyWp6GlyTOyuCVBObbB7dHscG0ECzaWwhYkZI6iM0o2zmp8
	 dK/rsvhK9W+QkA6SGV2h3uvFacLEvrdlUbxiV8aVnh/q9l4Zv9hJaVYWTixwgNSThCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789018615;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=K6NMCdeoC6EEh712ZzKt/zb93Jwr6+YPcacufzBybnE=;
	b=HPbnpUiOhJQn64Stn9HAMg1ihkutcCYD1rHOe7NDJ7yR+C1ZJDZ5LfZdIhRUOxOOtWuq
	 MBDoc1YHpEYmMd5+uF5m7Dy+8jJ7VC/tgSAP6rrAFn3715GxPTqCiBde6a4fCHvq8hPCb
	 Y4ECZcMnWmR2a4hPxUvOuAJ82dyNXoVcZDkLQ1fj1bY389g05GND9KUqrgTfxeZU+gs9K
	 mN0hQ3EPVvAsQc1uYpEIe6oQIPf6bQnLvubZkFn93xSN1jNZFHIybKVUA2nU5RlHsz8TX
	 zeVbv0scvrBvhSnRZlbxTBE7lJOfWVz0v3tjdX+9R+rQKxvgbWxwdg75PB4VBUWIdSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789018615;
	bh=K6NMCdeoC6EEh712ZzKt/zb93Jwr6+YPcacufzBybnE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RyjuNE0ggsgcM6vGUlZD6/UdbvGteepU/JT9xVsbwxBC2vc5lGGBSvE0zFVs3W9VV
	 cllg7kvMloCvnqRPK/YDp5KKW1iBRcme0UdvDviI5W59NXIjtNEIzsr/I1n9yrkWlS
	 HjkKb+eQcLtiNIFFBEOTMLYduf32OmPfFOr9ERaGKHi9vEM1o08SUyFpLqH7zN++XC
	 qgsXiDn5czZQOZvx591pXYV1okwwKHl+orWk2IbCAWgYWmj2BvdTJE/05NCpv3I3WA
	 An6NQIjoICQE3mbqeWL6yyk52ffOBtWVZxenRllrrz8EZ8vAR0K5FxUBsQ1Gdq9ioU
	 gpbfq+miWthSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D475480F00;
	Thu, 10 Sep 2026 05:36:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EE504E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D480F4086E
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YWqaYeH22SJ2 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 05:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8D7ED40850
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c41:1300:1:45:d181:d101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789018613;
 b=J3uHb87MZlWLc/gqMAQnbSjY/6huMPKAKS8rsNHMBVkHEerGxyCeN1hmm0Q3NEgURyI7
 TWlHWZSe9g5BY9UtJ0pavxIve7HJ/RRegdC6kBmvc5GdHmU1xVWrsb4AWfT8XtugHTlzj
 X8HFy7jGMFY+oJdPVQ5FkUg86lhL/Zf9GzE01XtSSdBGIUxI28SZ+b+dcdf6MvGAghCaF
 dvl60zVdcdLFJJcUUUcsTLuadUBF2bNLNiIMBxFNkabNvn7rOKVKAgeZmiqGAYamQBn8c
 u4nBi6lWrAIyPH6W7eMcXv1ci2win9U9TGddBXhFHcILrpQMi8eQDQNFBhXBVplJWLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789018613;
 h=X-Greylist:Received-SPF:Received:Received:X-Yandex-Fwd:
 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=K6NMCdeoC6EEh712ZzKt/zb93Jwr6+YPcacufzBybnE=;
 b=ozQtAB35MYHaMH9yDQ7S4d37O9DJg5E9DPTiJapTHKdMv0Ky1UMLmWQufs2qJkNvXYq5
 UOnVpa2AUa5MkhluU3BwA1OoToy+T9/Irc2iDc5zVjvuE38E4+WOiul1I8npA5MCVTHGw
 PUeOkWRWQ1QL9eLdBwPciKk+qWbRdLU8WH21xSPhh2kOTaaC+6RSrSmq2kaMxWIFlHlHN
 4dnksvCM9xGpwVTM1MlzPPgYQAUdGv5HCxvh/kEJen8PUtqnjR9Yc37VctOuzuFysmLsC
 mZq1OufGxnJT8jh1w17EWUCxjbqxtvjFY/i1NMZP7jJ3VnnGaFWXNyFuyGKharM9Cqg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=Cq0XN6BP; 
 arc=none smtp.remote-ip="2a02:6b8:c41:1300:1:45:d181:d101"
X-Greylist: delayed 83148 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 05:36:52 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=Cq0XN6BP
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c41:1300:1:45:d181:d101; helo=forward101d.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D7ED40850
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:36:51 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c43:9cd:0:640:e66:0])
 by forward101d.mail.yandex.net (postfix) with ESMTPS id 7367DC008C;
 Thu, 10 Sep 2026 08:36:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id haHu9dld98c0-pCvQuS1q; 
 Thu, 10 Sep 2026 08:36:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789018606; bh=K6NMCdeoC6EEh712ZzKt/zb93Jwr6+YPcacufzBybnE=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=Cq0XN6BPGmQXOlKAFMCiEa9iiUKCxNHCUX39WRqBzR+NRAqDrVpkYNNoq4YxEwezR
 pkxFgp6WIyoYe6w1dEDQYd1ptCBq378x8+SAq/CklQYYjIbJv4Uv4iSEWTnVqO87lK
 OzmTfnMvu2o4dO8JreyZDyo+fP2/489AYB/Jo1uI=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Thu, 10 Sep 2026 08:36:45 +0300
Subject: =?utf-8?q?=5BPATCH_v3_2/2=5D_riscv=3A_timer=3A_Enable_early_time?=
 =?utf-8?q?r_for_M=E2=80=91mode?=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-riscv_fix_early_timer_mmode-v3-2-52b569fa1d6d@maquefel.me>
References: <20260910-riscv_fix_early_timer_mmode-v3-0-52b569fa1d6d@maquefel.me>
In-Reply-To: <20260910-riscv_fix_early_timer_mmode-v3-0-52b569fa1d6d@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789018604; l=3539;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=VbPuM+Wn/xQ0uxbp8roJVpn++44sH4o3RdOWcoQNaGY=;
 b=3FYj6zGpJVww5Z+TheyI6964vtP7afUAvPU9Q9DsJOjyshU2if7ByXRgf3t7bugogxCz7e6P5
 d1XvmHTUQKqBTl8ZMS1hB1o4edVcG5kD5Q+89oJMddUzJq1REDpUG0U
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The generic RISC-V timer driver currently defines
timer_early_get_count() only when CONFIG_IS_ENABLED(RISCV_SMODE),
even though reading the TIME CSR is not inherently limited
to S‑mode; it works in M‑mode as well when the CSR is implemented
in hardware (e.g., with the Zicntr extension).

Moreover, timer_early_get_rate() is missing entirely for M‑mode,
causing early timer functions to be unavailable on such systems.

Fix this by:
- Moving timer_early_get_count() out of the RISCV_SMODE guard
  so it is always available when CONFIG_TIMER_EARLY is set.
- Adding M‑mode support to timer_early_get_rate(), returning
  RISCV_MMODE_TIMER_FREQ when running in M‑mode
  and RISCV_SMODE_TIMER_FREQ   in S‑mode.

This is also necessary because several functions
(e.g., net_random_ethaddr() via get_ticks()) rely on
timer_early_get_count() even if CONFIG_TIMER_EARLY is not
enabled.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/timer/Kconfig       | 13 +++++++++++--
 drivers/timer/riscv_timer.c | 12 +++++++++---
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 500a25638a9..12c194ff74a 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -227,8 +227,17 @@ config RISCV_TIMER
 	bool "RISC-V timer support"
 	depends on TIMER && RISCV
 	help
-	  Select this to enable support for a generic RISC-V S-Mode timer
-	  driver.
+	  Enable support for the generic RISC-V timer driver using the TIME CSR.
+
+	  This driver works in S-mode and also in M-mode if the TIME CSR is
+	  implemented in hardware (e.g., when the Zicntr extension is present).
+	  In M-mode, the timer frequency must be provided via the macro
+	  RISCV_MMODE_TIMER_FREQ; in S-mode, use RISCV_SMODE_TIMER_FREQ.
+
+	  On platforms that also enable CLINT/ACLINT MTIMER, both drivers
+	  may provide early timer functions and cause linking conflicts. Ensure
+	  that only one of them is selected, or adjust the configuration to avoid
+	  duplicate symbols.
 
 config ROCKCHIP_TIMER
 	bool "Rockchip timer support"
diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
index eb7c78c3bdd..72cfde57e93 100644
--- a/drivers/timer/riscv_timer.c
+++ b/drivers/timer/riscv_timer.c
@@ -7,7 +7,9 @@
  *
  * RISC-V architecturally-defined generic timer driver
  *
- * This driver provides generic timer support for S-mode U-Boot.
+ * This driver provides generic timer support for S-mode
+ * and M-Mode U-Boot if the TIME CSR is implemented in hardware
+ * (e.g., when the Zicntr extension is present).
  */
 
 #include <config.h>
@@ -33,14 +35,19 @@ static u64 notrace riscv_timer_get_count(struct udevice *dev)
 	return ((u64)hi << 32) | lo;
 }
 
-#if CONFIG_IS_ENABLED(RISCV_SMODE) && IS_ENABLED(CONFIG_TIMER_EARLY)
+#if IS_ENABLED(CONFIG_TIMER_EARLY)
 /**
  * timer_early_get_rate() - Get the timer rate before driver model
  */
 unsigned long notrace __weak timer_early_get_rate(void)
 {
+#if CONFIG_IS_ENABLED(RISCV_SMODE)
 	return RISCV_SMODE_TIMER_FREQ;
+#elif CONFIG_IS_ENABLED(RISCV_MMODE)
+	return RISCV_MMODE_TIMER_FREQ;
+#endif
 }
+#endif
 
 /**
  * timer_early_get_count() - Get the timer count before driver model
@@ -50,7 +57,6 @@ u64 notrace __weak timer_early_get_count(void)
 {
 	return riscv_timer_get_count(NULL);
 }
-#endif
 
 #if CONFIG_IS_ENABLED(RISCV_SMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)
 ulong timer_get_boot_us(void)

-- 
2.54.0

