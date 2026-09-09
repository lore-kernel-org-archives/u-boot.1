Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B25C79F8C
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 06:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31122406E1;
	Wed,  9 Sep 2026 06:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A8_Ba80ZsuXV; Wed,  9 Sep 2026 06:31:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 56776406D4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788935472;
	b=cvLHQ8HeOat20wnI4XZt6A3hnsxtSMs7IJ79Isji7NjE9rjqFJfnVQEZ0dGTaXpeaQ+m
	 PEe/diiST8Nmbt0ng7a8CrwhjXj0dXEze3nS8hztbVpPNfGo8IJALtIQYnWUt0SMQhXTB
	 zsltoFoOX9fno9mc0FEwWw3f0OpJdzf11UJD4yaLdXLLs6SOylOC1DKxjhMxteMbNZfOm
	 wf6t2+qb5eq1f/a5dGBwej8zgU662NeY0vSMPDUFvEinUYXha97EXzJIUE/AtJx7rUOIj
	 Zvkr0u9nQUKvLNwS7yZ0utf69WkazN63mo0PCIhTyiqaYWu0Hs2OIdQiiH2jcK9eKRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788935472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mzzPDjIV9Wkhpod+sn3eKu3V5daKrZDhYdJx6QF+flY=;
	b=KnBtoo/g+4MMlgQKLumPJtQ/88+EPBUFWphggzH1iXxckihjUZi22NWwvBGtp7Uc5uRh
	 umpxfQHQG0BuzRbTdmRqTOYdBPHulKVmeKRX7d1J8GMssxGy7Kl+SLyzvitqJMISqw89a
	 rlwIeWQj1LVyNDgFugDfXc18n4NfhZgX5RnT+0couJZOmOenNyuHeL4d9Dqr+ZtjMINI6
	 B2lcLX7XwKpcUhdtXgkIV35Z4dXVqmFYXxW+/OrvUQwZEEa9xMGqcikzYi5ok4RT3MoRJ
	 BJgRmL/EGydJHqEG+T5G2rNrOQ/EU5dCBveVPxRIM2AepQ6m7jzKrK3NqlvHSox2NEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=maquefel.me;
	dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=Y870MYyP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788935472;
	bh=mzzPDjIV9Wkhpod+sn3eKu3V5daKrZDhYdJx6QF+flY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J5t2i/yNfUkcfVtPRRtoxE1DGdABcCLrUOQkw9xX1esl61mYrd5dgeD6BpR+VK68h
	 EtJHoHUXp6/gGtBC8rs98iEoEjlK1/1hYSY9v7YGNKNCpihLCdkbMa/xYBoP3Hw1jm
	 Dt22jxLMyB6xs2cSihaiLsbFRIqRaRZknDgyXwfdvcNLAxt7RQ9YCrJK7j8s4B+/sd
	 fQyJKEcdlxzGABDpNmD0twYy9pT23CJwz4U0ErWjHbH7EDsau5SDFYaxeNIx6VRGC3
	 bVkxpyijjxz1hFsJnQhUSmHCGIRyS9YOs9TBjLi5NcY5E/nUyNsLQ2ZxfxMm5WxKcu
	 0xdmSMKjx//mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56776406D4;
	Wed,  9 Sep 2026 06:31:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 556B2724
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 06:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3BA70406DF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 06:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id daErPMFOsvhy for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 06:31:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 72F69406CF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.213
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788935468;
 b=VGgBtp4+TnrQUrr1g/Mm2JgtQ1mn7YIhrLqsYNHxmewanxSHTn7/wx051PNW+kFDupvO
 P2ssXeQiAg/p45SOlbnNfWfo2wAQh3aU7p2UU3/i6IaEwZOYjHYFXWMaopW3EMSOCF1NV
 NQ07kFNeLCoDgZ+hXaBonIplyx3j5Lhp9u+YYwVcyhXQ9l39GLoXty0yBd2gJinXkvLna
 A4OI0MPgXsPt9O5i7R36i7OBpKZ9sDgpJfqh4Tdtiq2EvOvUuUDbJxG7B9anxkVZxnt/5
 thq+oWAAPMGQpk9ycvCSDwNK/kzsfAr5zpRbO54HJFBZpkRgaUXOJGpli7Cgd3RdxYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788935468;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=mzzPDjIV9Wkhpod+sn3eKu3V5daKrZDhYdJx6QF+flY=;
 b=BDBw2uHHw1HDAbf7s/eqhV6iX/eF22bpLlaVI91fclEunoiGzckTi+ks8+v0fW/VasId
 mMmRWOVVqmSgMo/Z1swx12f7nY5Wy2d/xOJ6MQG7idkMatC0JmrHGZpgSz/KfilmAh/U0
 Ps80d8lCYsHUcSFKiGNqVZ76tbYtMW9azFO7Ux9Jf8E4CoIAjnbE/84narzI1eCoL3K/q
 vTuVTxObio8ZZM/vn5th37O5+SdnmYEmeX0iu0RYFa6LYkbOQs1InJVMPmLfqouMwH72l
 uB08IWuKBPzBNlbVEWv4GnJTQnyQQj1kVKSyY7MVUvQ0VTLUzBdOmxaZsXiyddUHJNA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=Y870MYyP; 
 arc=none smtp.remote-ip=178.154.239.213
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.213;
 helo=forward102d.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=Y870MYyP
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net
 [178.154.239.213])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72F69406CF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 06:31:02 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward102d.mail.yandex.net (postfix) with ESMTPS id DFED2C00F6;
 Wed, 09 Sep 2026 09:30:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id vUHHbfWlcSw0-FS50q8e2; 
 Wed, 09 Sep 2026 09:30:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788935458; bh=mzzPDjIV9Wkhpod+sn3eKu3V5daKrZDhYdJx6QF+flY=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=Y870MYyP6MT9GfvlhIest9AsN2GAcRHDokI/zBAXczjfftfxqSQM+yU6bRnOBHMT1
 aVVNQwWr5r37nU9rcCLuk9GnpYKkI/evM32T0jFqhe6fHDzmJZ02TzuOPVVO0aUAaR
 XG6DhztpiXR7eE2PoDgf5x6WjjRU0JdtxLsU+CNI=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Wed, 09 Sep 2026 09:30:59 +0300
Subject: =?utf-8?q?=5BPATCH_v2_1/2=5D_riscv=3A_timer=3A_Enable_early_time?=
 =?utf-8?q?r_for_M=E2=80=91mode?=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-riscv_fix_early_timer_mmode-v2-1-563bff2a50c5@maquefel.me>
References: <20260909-riscv_fix_early_timer_mmode-v2-0-563bff2a50c5@maquefel.me>
In-Reply-To: <20260909-riscv_fix_early_timer_mmode-v2-0-563bff2a50c5@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788935459; l=3525;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=zhM3AkzXMPgtwDMSN+G5i9N/a8xFXWgFyAqj+oANoKw=;
 b=hB3SN0aXSheFJKS1AHN+zEboolftZ0NHq89oV21HhZXRUZi4XgVbssIp2RbAvQrfOFuZZoRzy
 xOqfzepC4lNDgN1DWK0mp+SLwQ/4EenXagdoDcXrsweTKuBNz/fTNQq
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
index 1f4980ceb38..c2e617317aa 100644
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
 /**
  * timer_early_get_rate() - Get the timer rate before driver model
  */
+#if IS_ENABLED(CONFIG_TIMER_EARLY)
 unsigned long notrace timer_early_get_rate(void)
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
@@ -50,7 +57,6 @@ u64 notrace timer_early_get_count(void)
 {
 	return riscv_timer_get_count(NULL);
 }
-#endif
 
 #if CONFIG_IS_ENABLED(RISCV_SMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)
 ulong timer_get_boot_us(void)

-- 
2.54.0

