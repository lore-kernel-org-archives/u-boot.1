Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468E1C2BA15
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65A18844B;
	Wed, 19 Jun 2024 14:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="frkib5Zw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0291888415; Wed, 19 Jun 2024 12:57:57 +0200 (CEST)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC9488363
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 12:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=emil.kronborg@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1718794673; x=1719053873;
 bh=Wj9nbteiZfzOgsjuUOqOf3oxE6S6MGJeC/DJaEkLiq4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=frkib5Zw1fKKm0+KmTU04tNR2XdVHnDkRTxWJ7U26fbULlLOYJbRKEg1Y8psgqa3V
 Nhf1Lhq4nWLebSQgSLi85A6Jwu8jYZI43+edp29X9Wldi3yF4wg46o++pfLULD5ilj
 CKpYApP18UWB9tn4HxwfVDEdGbg9IB2mS6LUGMpsQ0SP5X0pFfgS9yqATxkiSa1Oif
 jydtU/YQocsaMdwUnnofOSLDawwQlFD8aN/eLG+RUt79nSSXs5E5lDo/WLctWt2UhK
 2OP9EMimW1fkN8HiTVrk6fs4zcG3QXRPB/56jP7n3qhi9XFGHqQ1fINOwpEbr1PjvV
 78vfTUDcPbXnQ==
Date: Wed, 19 Jun 2024 10:57:49 +0000
To: u-boot@lists.denx.de
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: trini@konsulko.com, sr@denx.de, rasmus.villemoes@prevas.dk
Subject: [PATCH] arm: davinci: remove unused watchdog functions
Message-ID: <20240619105735.42745-1-emil.kronborg@protonmail.com>
Feedback-ID: 20949900:user:proton
X-Pm-Message-ID: d3ba1be0cd5a846204d42afb043ff65a53491c53
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Jun 2024 14:21:41 +0200
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

The davinci_hw_watchdog_ functions are defined but never called from
anywhere. Commit 881ae794b93b ("calimain: remove board") eliminated the
last call to these functions.

Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
---
 .../mach-davinci/include/mach/timer_defs.h    |  4 ---
 arch/arm/mach-davinci/timer.c                 | 31 -------------------
 2 files changed, 35 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/timer_defs.h b/arch/arm/mac=
h-davinci/include/mach/timer_defs.h
index 110e67e454ce..7b21f2599930 100644
--- a/arch/arm/mach-davinci/include/mach/timer_defs.h
+++ b/arch/arm/mach-davinci/include/mach/timer_defs.h
@@ -36,8 +36,4 @@ struct davinci_timer {
 #define DV_WDT_ENABLE_SYS_RESET=09=090x00020000
 #define DV_WDT_TRIGGER_SYS_RESET=090x00020002
=20
-#ifdef CONFIG_HW_WATCHDOG
-void davinci_hw_watchdog_enable(void);
-void davinci_hw_watchdog_reset(void);
-#endif
 #endif /* _TIMER_DEFS_H_ */
diff --git a/arch/arm/mach-davinci/timer.c b/arch/arm/mach-davinci/timer.c
index f2990f718773..474dc6b1abd9 100644
--- a/arch/arm/mach-davinci/timer.c
+++ b/arch/arm/mach-davinci/timer.c
@@ -98,34 +98,3 @@ ulong get_tbclk(void)
 {
 =09return gd->arch.timer_rate_hz;
 }
-
-#ifdef CONFIG_HW_WATCHDOG
-static struct davinci_timer * const wdttimer =3D
-=09(struct davinci_timer *)CONFIG_SYS_WDTTIMERBASE;
-
-/*
- * See prufw2.pdf for using Timer as a WDT
- */
-void davinci_hw_watchdog_enable(void)
-{
-=09writel(0x0, &wdttimer->tcr);
-=09writel(0x0, &wdttimer->tgcr);
-=09/* TIMMODE =3D 2h */
-=09writel(0x08 | 0x03 | ((TIM_CLK_DIV - 1) << 8), &wdttimer->tgcr);
-=09writel(CONFIG_SYS_WDT_PERIOD_LOW, &wdttimer->prd12);
-=09writel(CONFIG_SYS_WDT_PERIOD_HIGH, &wdttimer->prd34);
-=09writel(2 << 22, &wdttimer->tcr);
-=09writel(0x0, &wdttimer->tim12);
-=09writel(0x0, &wdttimer->tim34);
-=09/* set WDEN bit, WDKEY 0xa5c6 */
-=09writel(0xa5c64000, &wdttimer->wdtcr);
-=09/* clear counter register */
-=09writel(0xda7e4000, &wdttimer->wdtcr);
-}
-
-void davinci_hw_watchdog_reset(void)
-{
-=09writel(0xa5c64000, &wdttimer->wdtcr);
-=09writel(0xda7e4000, &wdttimer->wdtcr);
-}
-#endif

base-commit: 01a5d7547ed3a51a8ac5837c31a150f85bc475f8
--=20
2.45.2


