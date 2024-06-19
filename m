Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CFAC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CB4E8846F;
	Wed, 19 Jun 2024 14:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="zYF9XfM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD12E8842A; Wed, 19 Jun 2024 13:00:07 +0200 (CEST)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch
 [185.70.40.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A1487D83
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 13:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=emil.kronborg@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1718794805; x=1719054005;
 bh=aNraD+F78eJbbNZTkGUtz+0+w8+sRKKxtpa7eoeR5NU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=zYF9XfM6gLf/omKDUEwGNB5TKzxGfjec8lfKpmQiDO72I5L9koiWDqZmuL8MVTajS
 tKUlUjIIMR3dvQV1GVCE60ciZPjdLJmCcs1AZk+J3tmR9FOd4EwYil7sW9QZTwr3tb
 lUKqavXb6zjuyjMttV7bNWAa3WRcjPxnSsIfW0gOCdo2HEeLKnKGARxKGlxHFeyZO5
 M2O21dtt1/8yf8295FTcYG3YEjU6ZfIji8Q1gdlezrGzHxf+P/GR38g7SsSSwEISft
 EkxnNbZ/4MC5Dlfuhg4zYqNjNHFatpdMn2lzsimZ1NsEeKAwMY+O/IBbQ8Odod0iSY
 wszdWbfirArWw==
Date: Wed, 19 Jun 2024 11:00:01 +0000
To: u-boot@lists.denx.de
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: trini@konsulko.com, sr@denx.de, rasmus.villemoes@prevas.dk
Subject: [PATCH] arm: davinci: remove unused defines
Message-ID: <20240619105958.43083-1-emil.kronborg@protonmail.com>
Feedback-ID: 20949900:user:proton
X-Pm-Message-ID: 23a8e9c699beaaf8c52e437ddfe65b20677c9471
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

The last usage of the DV_TIMER_ and DV_WDT_ definitions were removed in
commits 8d7757637138 ("ARM: davinci: remove support for cam_enc_4xx")
and cef443c1666c ("arm: davinci: remove leftover code for dm* SoCs"),
respectively.

Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
---
 arch/arm/mach-davinci/include/mach/timer_defs.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/timer_defs.h b/arch/arm/mac=
h-davinci/include/mach/timer_defs.h
index 110e67e454ce..38188dc699cf 100644
--- a/arch/arm/mach-davinci/include/mach/timer_defs.h
+++ b/arch/arm/mach-davinci/include/mach/timer_defs.h
@@ -20,22 +20,6 @@ struct davinci_timer {
 =09u_int32_t=09wdtcr;
 };
=20
-#define DV_TIMER_TCR_ENAMODE_MASK=09=093
-
-#define DV_TIMER_TCR_ENAMODE12_SHIFT=09=096
-#define DV_TIMER_TCR_CLKSRC12_SHIFT=09=098
-#define DV_TIMER_TCR_READRSTMODE12_SHIFT=0910
-#define DV_TIMER_TCR_CAPMODE12_SHIFT=09=0911
-#define DV_TIMER_TCR_CAPVTMODE12_SHIFT=09=0912
-#define DV_TIMER_TCR_ENAMODE34_SHIFT=09=0922
-#define DV_TIMER_TCR_CLKSRC34_SHIFT=09=0924
-#define DV_TIMER_TCR_READRSTMODE34_SHIFT=0926
-#define DV_TIMER_TCR_CAPMODE34_SHIFT=09=0927
-#define DV_TIMER_TCR_CAPEVTMODE12_SHIFT=09=0928
-
-#define DV_WDT_ENABLE_SYS_RESET=09=090x00020000
-#define DV_WDT_TRIGGER_SYS_RESET=090x00020002
-
 #ifdef CONFIG_HW_WATCHDOG
 void davinci_hw_watchdog_enable(void);
 void davinci_hw_watchdog_reset(void);

base-commit: 01a5d7547ed3a51a8ac5837c31a150f85bc475f8
--=20
2.45.2


