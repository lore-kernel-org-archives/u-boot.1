Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BD8C88E45
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 07:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DBBB40B4B;
	Fri, 11 Sep 2026 07:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7yaOqOF20lft; Fri, 11 Sep 2026 07:14:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 98CBD40B25
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789110862;
	b=bqoUCYZBAW9sm5oTQ4XgUYpYh4d3Y/AUQgmg6+pVMQWF+Xgi8opIcF1jr1XU2K01JJiA
	 KPNiO/p00oxqv7L3nbe70eh8bKx/JVTTqtACAmgAbIWwf+yAH5YREeTsNnmF0lNeRYA3i
	 DVtYz+2gBTZIehVSMsXgnxBVf0zH5LRGTUv9Apo6gFMeZVfzUAUSHn33ATxSBc7E9tXYF
	 sack4gBaxfs7aUCDkx7t1Hhz9UIgYesryJM1tuSfqsjJ8VlfsKsYkRXhI2jJ9Tfk2VHmJ
	 ufu9wnBfmu1yMcOTfQ6BBJdOddXrlEQgHb2jpiWrxXkkobTu8UbwlWm4A76m0sEGu2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789110862;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6hET7IWr0u04rG8+7e2OsYyUukMtEj3p3pEHVcB+OR4=;
	b=ZltDd7Ioh+Y8QGRoZUmNW7WVPRM+jJSYEbiE5WRKYu+161ENYzLyZd/ZklhD1ejPRQJC
	 UR+0NGhNaXgoZ6LBH42L7LlJULvxX5wTIhAICvTfvOMwgVbdJpjBDmOzwLH/nw+CGRnV/
	 qQeFML7odz9of3xv4cRCvX4G3D5fRbrktRF7v0c40LG6j/qnxXG0wIHAlNMuJb/pKCXKO
	 RnUDldOSa2XOZ7rX5Ic2p6w28343JK3TX3BB/eo1+o8jrvl7EOz9TH3TCDBJJrQFOvm3n
	 jkAt2E23IWLNYeMBTon3huAvx95GRq+w8ZC95NOHgeu8DltszZlImh62bTvHUu71oYw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789110862;
	bh=6hET7IWr0u04rG8+7e2OsYyUukMtEj3p3pEHVcB+OR4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wZX9cVZY/lVMX57ztPyKtup0KVaNAgwo41KfTQsosphzleUlcaIxTpVh8p6uWTdZQ
	 EhnAJRPy4iBaFbR3VeZXZFv8VuaT4ZgevGC75zUnMiIWtmywEiQOiighprOrD/ScLW
	 0FYKPlH7Cf08+62s2VE8JznAVHK/oWoGWJrNTGLhXU4ujQ3Kye8dnJYRXklcbWGM5J
	 rpnDNherrPo6qKeBXMcsbwNJotAND4/PyEFBea+A+s5x900Atl9wNfYOMzyEbQO2R/
	 oV6NNWHgSP6BypgvC5u+sjqOA5OBffv43f+XSgmVJ0rnGvddfeR9HjJvLx/CmQ/r6g
	 EBovhJ/OhBNAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98CBD40B25;
	Fri, 11 Sep 2026 07:14:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4729D14D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 07:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CD20402C5
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 07:14:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5AmWzNYKAp1 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 07:14:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 338CA4026E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.150
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789110858;
 b=MhoAxTG0/8DqnNXouVZaVlroQF8mC3teN0hIypBmKuZ7CZBIUAUpZISdrvo0SxCNLyKw
 6lybQumWxuDis3o+BC1eBHAaIwQ7Nqkc4BvA5F3eD2uPexAldEdEWjc2QiF/rw3O62bn2
 r6N/WYk7HVfV37kzO9PYpJoHbe1Is0ANXZNFefTSJ+8Whg0Co+zhGCoIBUJhkepM8WxxI
 3mDVnBemlJAIqtAJIBVdkEjzBlTgsEpnbPXH+ThSiJ0hK+ckVzYOvyoO/rVv1maCUyn4r
 i/FjAgzbsFLz6IUBoFdAF37yOU3yV4iQ46+rkyv73IlKAIjRsw5b3G/3waAs7DtRB3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789110858;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=6hET7IWr0u04rG8+7e2OsYyUukMtEj3p3pEHVcB+OR4=;
 b=VtV4qMP/f55+mT/tK0n8lP2/bz8Toid/B5hV0Y06BZ4zOmM7sjK7qbVOG+nX9iOn52e0
 WZhsGMD8MQ9ifvZ86UiaTe9FePsJQ3XLsWyfZBvHA7EMFvsXUzzqgUi7BnQrFL4+jh1Jq
 zm0+Ng5/3gcjp/V1FAZc9l3tZHwIExYlVSoeyQ6eZX5T+yH7bkHuAr4WyD+Xb6GEMfcXT
 uahKTEVaF/HY5sJdtlAFXR5q3Z5YKBzgr8tpKHZzFafgMZ8ImcLnSV+WMU+nsAj1mdRbi
 qBsZzQwqXqMErJAHL+XbXRVYKPEISdmKhR27tMk/ilcfY/vbgiUnQLFN3xb1wRVpqzA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=taXItanZ; 
 arc=none smtp.remote-ip=178.154.239.150
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.150;
 helo=forward103b.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=taXItanZ
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net
 [178.154.239.150])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 338CA4026E
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 07:14:14 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:4021:0:640:30fc:0])
 by forward103b.mail.yandex.net (postfix) with ESMTPS id 50CB7C00AF;
 Fri, 11 Sep 2026 10:14:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id 6EKFZlKoaKo0-zJAz3vQN; 
 Fri, 11 Sep 2026 10:14:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789110849; bh=6hET7IWr0u04rG8+7e2OsYyUukMtEj3p3pEHVcB+OR4=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=taXItanZqOwvgLuX2e6vceqdoI5ObkO8Bta4DwFYR0nGAjmSyVzsbElezQi3HFoMg
 Hj9a01aMPgAI8lbJ3rZF+R/TuMP+kImgper6rMEkWghBriOW8gfM3ELIGKsvqeQEpZ
 AUPrJl7EJ3sBqelwdx73XFUca5hgO4cZpIPY5hxU=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 11 Sep 2026 10:14:06 +0300
Subject: =?utf-8?q?=5BPATCH_v4_2/2=5D_riscv=3A_timer=3A_Enable_early_time?=
 =?utf-8?q?r_for_M=E2=80=91mode?=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-riscv_fix_early_timer_mmode-v4-2-87a7b5abf958@maquefel.me>
References: <20260911-riscv_fix_early_timer_mmode-v4-0-87a7b5abf958@maquefel.me>
In-Reply-To: <20260911-riscv_fix_early_timer_mmode-v4-0-87a7b5abf958@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110848; l=3323;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=WYk/skc9KCuKQe/sApjoNz6L7Lg94a1rwHX/8zIc9/g=;
 b=Twdph5zTtRaTxcHyHPjPyvvyX2Y2kR/f+0mYCUe3J1zsiMZiXVitGoSG3lLjHeBFDsXdDFJN1
 BQ+y1W9odSHBJ6BKG/UQQeyhInXjPVL2SKjQgxBgg7gzC6UPbapD9yM
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
  and RISCV_SMODE_TIMER_FREQ in S‑mode.

This is also necessary because several functions
(e.g., net_random_ethaddr() via get_ticks()) rely on
timer_early_get_count() even if CONFIG_TIMER_EARLY is not
enabled.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/timer/Kconfig       |  9 +++++++--
 drivers/timer/riscv_timer.c | 12 +++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 500a25638a9..2b912302053 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -227,8 +227,13 @@ config RISCV_TIMER
 	bool "RISC-V timer support"
 	depends on TIMER && RISCV
 	help
-	  Select this to enable support for a generic RISC-V S-Mode timer
-	  driver.
+	  Enable support for the generic RISC-V timer driver using the TIME CSR.
+
+	  This driver works in S-Mode and M-Mode if the TIME CSR is implemented
+	  in hardware (e.g., when the Zicntr extension is present).
+	  If CONFIG_TIMER_EARLY is also set, then timer frequency must be provided
+	  via the macros RISCV_SMODE_TIMER_FREQ/RISCV_MMODE_TIMER_FREQ for
+	  S-Mode/M-Mode respectively.
 
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

