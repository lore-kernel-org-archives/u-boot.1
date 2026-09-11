Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C5DC88E58
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C744E606B3;
	Fri, 11 Sep 2026 13:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4D120vd2A4hR; Fri, 11 Sep 2026 13:35:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 91338606A8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133743;
	b=MllVh73oLvrRMplZwmNVng4SmN3yVfIytbDoWF5ydNj6dKpVeBd5xDwdhLEwTmqIJWjI
	 m81muRALkYr5iYPaZEXwozR4stoi+Sk2tt/oCXsE0V2f3GAQ5k5vKyg26mo+bnX4NdZkn
	 s3b6qjUDPmIUMy4BpLtDjSYT1VQJP12ltv52/FzLPkxCZX7AiFhizg6kWdcsFTl47E+YX
	 XRJG1Wo2aB+L96MSd6mERPNp9NYx1UWGzZ99hlrQNg8bNgyr6LLzS8GuntNiHXK1UAz2B
	 5+qUccGb4J+5nYZfqKVNz4aUElSXrhdyTgCEF5R4O/E3He7ZKRPr1+HPPGIARXc//Sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zRbQfAv4cAgoY/KjfJX0FmN5wK93nurlfcTZaknkkdE=;
	b=L+FyXkBJwhullAFoWtsK9KP0hiBB/+xmUQlItTvyi0Yz+qIjO7UFCJRAcl+4zQx/MgDQ
	 f49wjURu0evkvu2jgQZzPZjGocB99iw4uSuDnn7aIG1ih/DCxZ/4zmhr6OiS/SMAgtCu/
	 WIoDrTEvL+r9gWi2A5Hq7jysegnzKyfEM/XXVgK/YSCN3v/lmnVUGel2nuKTgSreTdDbz
	 BDGdAoOEK8GEXn9EPdxmze7O464muR5nz2c+eZNJGpdgkbuLwwHAmdndpIyQ3GxlOZuBW
	 aNkHxYgrGVNsN7//kZjoBj1zXYHNgz5K46J56Fblq2eVBuvfjkszcF6v+jiQPbEChBg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789133743;
	bh=zRbQfAv4cAgoY/KjfJX0FmN5wK93nurlfcTZaknkkdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yOxkRlAeDoj2VM/yNcGbAybComcZLxObCjvrmL4WswoC8BJx3lQx54/F8cUuvgR4+
	 du48r8BubSFTnJvK9/MJtRh2xI5ZqDDQLFf6iS6/45K49HPMCc6yCtJAGoM7tVVQ7X
	 5Y0SV2f2j5vddHyoqGHXeIygS/IPvXQSHTBCFkANxEzHwCOi5gFWf2yn3/bswT5Kwc
	 7V45J0Ca+3cv+Lj9SGXUyjMwqb6BsfK4YnSpYEW+GZlwzYK5VZ9rl3z/ZgOIIkVLM5
	 DxWSX3BSnaZW2AgQ1Go6fMO3ZI1/eJz3+5xQw8/FqKCtYur3VJyxF5Qpw7JVoq1cDP
	 l4H9uWatXMYsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91338606A8;
	Fri, 11 Sep 2026 13:35:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7047914D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D2A980F7A
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DwEslKtAJDnv for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:35:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 26BD080F54
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.150
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133739;
 b=gScmTyFvKEJt1QcDkDnoG4hXnBQ5IZ+iVXnrwfsXWzLe/HXvfQdVSPGGuAnsdJugEC5s
 TrItLPppHABRDkIcPB+r0MY0+qKCeDqOrUf7Ox2Mkbo4754PFOyv66sWXpNKEHD5dG9r7
 pV2dy1KVEwVKjKscbd3rgKsGOjUg1qucodp+46UbVugvp/EgcBhFo4+36TfWQyiWSkKRD
 RC4pGI6UhqufISCl0WzjVa9BNrBPX+AVAt3IdiceAqlDymqPmssRbh6eNofxnJsQyDRhZ
 /WxgbQdftmI3QCGNcJDiGRhpSpd3ljZX+1VeJABi+Ui0K18qKopBFdDwFSG/gm1MsnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133739;
 h=Received-SPF:Received:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=zRbQfAv4cAgoY/KjfJX0FmN5wK93nurlfcTZaknkkdE=;
 b=PfLIzFIHoj4vxvC/hR3K2Kk0O0jDsvC7l7cyb1fZPVU36U0fHiyDVOuUnPErTAyF3WbN
 oLGJVMzRi27as/goPXhwk9kXRvCAsP+mKaFnyix/fc8FcRGgNgcZ5PcbPWvQtoKxdq3SB
 ERRWICmvmQmeokNerBy7HAiDOPVy2OGBzUe17RxHjFtiEv5pyUehCz4SyoihvlsYWs/sI
 DLa3NUmlXayh0vZmbgdv3VstKYjk+AeeO5qciU66PApBgdRBA6yUuDjVprEuhzIWi6RHY
 pLXpknrJMQQZPTjbRvZy2wUwezVhzU1Dqq/v70jZqcewmoX+VEO7QqR2UcYDwsJDqVg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=Tc3IFUrm; 
 arc=none smtp.remote-ip=178.154.239.150
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.150;
 helo=forward103b.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=Tc3IFUrm
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net
 [178.154.239.150])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26BD080F54
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:35:36 +0000 (UTC)
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
 by forward103b.mail.yandex.net (postfix) with ESMTPS id 8076DC005C;
 Fri, 11 Sep 2026 16:35:30 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward101d.mail.yandex.net (postfix) with ESMTPS id 69125C0046;
 Fri, 11 Sep 2026 16:35:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id RZQKjqwlda60-zxR9tWnx; 
 Fri, 11 Sep 2026 16:35:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789133730; bh=zRbQfAv4cAgoY/KjfJX0FmN5wK93nurlfcTZaknkkdE=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=Tc3IFUrmE/cPzAzhrmnZw2tGlamRqYYR7XDTsBGwk7JsWH9UXt/D0KHPvPazxi/1F
 qirjrrMfDIuMOmuaKJfZ/3NYhwC9dV34OJX7zfTwusD5j1j973wGvWWxVGidBL5Mtt
 7T6i8ppQeVJ5q3+EtydPD0HAh5CAqLXoDHunUZeM=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 11 Sep 2026 16:35:24 +0300
Subject: =?utf-8?q?=5BPATCH_v5_2/2=5D_riscv=3A_timer=3A_Enable_early_time?=
 =?utf-8?q?r_for_M=E2=80=91mode?=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-riscv_fix_early_timer_mmode-v5-2-98e7aaf91396@maquefel.me>
References: <20260911-riscv_fix_early_timer_mmode-v5-0-98e7aaf91396@maquefel.me>
In-Reply-To: <20260911-riscv_fix_early_timer_mmode-v5-0-98e7aaf91396@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789133729; l=3335;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=e+LlYiqAK0JJTy5mZrcR2g0R6Vn7dHNtX+3wy8kgsHA=;
 b=tPDwehkgDxuPoLG3a+o6yAhEUwyc8JcKmnhLW7xusBK1zd/r/XrUH/H5ZCBCSCuU7NM8gxS9Q
 H9AGlqrJN5nBzERaxzBpKxlgshDTaTSUCuKVK5Llj8PF0afWCkbATXq
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

This is also necessary because functions like net_random_ethaddr()
rely on get_ticks() which uses timer_early_get_count(), so we
should provide one if CONFIG_TIMER_EARLY is enabled.

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

