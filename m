Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A33C10F997D
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 20:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9777A83CF5;
	Wed,  8 Apr 2026 22:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="kgikEG/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D433F8412A; Wed,  8 Apr 2026 22:30:28 +0200 (CEST)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B73A83936
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 22:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1775680222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3o/pmBhdixVCYMjWeWNQLKdT65F5jUltcwhUPb0xY1s=;
 b=kgikEG/bIQKz3kSG6cGQsjQFjMqS1wiRhqc2GrXhXoq4eLmndy/mcAm/lIwatBWy8ag9P4
 YL22CJwLcAvwmlgfllIYkjBqF2Iq577s/JkGBKyvJW886ZWafPdX5eQc3V0B//Fl7JHoum
 K0UNrsJI8F+CMBDl1EmOLAwRNSz7Jskm1qAYJfuBO9OcdMuwyfRwmsqioYvcxJCFtR6ziY
 UOIIKr0r1NM15f3Vmjj1UKPF6Pan/X1NqHRWQ5elZBKB3xeHpLvMEIx9caqxooNUtSem7G
 UBmKcZ0iYcbAQGVP9fNsWDf4ZrP7GqQ5VLehARWFGLoEQmOOBrxyHRXS3GsXJg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Apr 2026 20:30:12 +0000
Subject: [PATCH 1/4] arm: mach-meson: move reset_cpu to spl only
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-b4-amlogic-sysreset-capsules-v1-1-6f3386eb5124@postmarketos.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=SyLmiOFA/rtoLHgU5y2gqAyhDPi3vYUVWYWi4tktsFA=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp1rrbrkGYeWqQxUfJYbYfrRNX1p0htNuwW8qoS
 /DIJI2Q+1aJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCada62wAKCRCEr8vQ14ma
 A1mID/9SqV89kODo3qvOCZCKe8h/CIFdP857tUyXBrKpzhsxxQqWmqMiSfuyAZAfX+M2qinGB79
 CWAH6pUjWPfk8t/MzpZKO35YD0RtIYUN2ZUZp2GwAKic9GSJihCoEWgKhA1eO/i4BxbLEx1YCXk
 8TmCv3VUCCAkeRDfVoshJNSAB8qROUxOXRcN2c1LAdp+NGn79097okkj53j7KdCF7ADKqxQdsTm
 32mTursQRvjJy5TQg+nmXQTgJhX/hUJcAEtCu6guYZhKMD0o5BX6qqquCwPkbc85UJOCTu3UxYn
 bwskhrzpMytDUimUbwb0DOVAccKCuYQCrLncn0cZtGXxj14KruqVEPHdmTVG1Jg1w9wmDBbQ6ym
 XX8eu6qcicolTKrCb/vMjfRhYjOHCbVXQwBgamLG68OksidMyM93V5vTinXbQyabA+5SOCLhrZh
 MR7uVPnbQhy2M2jwwwvuSbgLAltLok7WpDXtcYQemXVueO1gGFx4tmEfJLu4po09eXrvdkoB9d5
 41X9tV9VezM2bNhfwTbg56HoRzr9Y5B/38duQDQgauK4V6ElHuzU6VnzSnBPHUtE8WyBeNCV0kY
 0NcAABEOqhsdaNdjNxHSuo89vjZSOtYH+Fvb17uMog3vlLF0lQ2fUThyEqJyzJdoMev70a5PFG4
 FP2bkrnpvu+FRHw==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
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

This is in preparation of enabling SYSRESET across all Amlogic boards by
default. SYSRESET brings its own reset_cpu implementation which will
conflict with the one defined in board-common.c. SPL however will not
have SYSRESET enabled (due to overhead in the final image, as we have
very little space to work with), and thus will still need that reset_cpu
to be defined, so move it to spl.c so it is only built for SPL.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/mach-meson/board-common.c | 14 --------------
 arch/arm/mach-meson/spl.c          | 10 ++++++++++
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index a5afc2d75c0..24dcafd30ac 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -154,17 +154,3 @@ int board_late_init(void)
 
 	return meson_board_late_init();
 }
-
-void reset_cpu(void)
-{
-#if CONFIG_SPL_BUILD
-	/*
-	 * We do not have BL31 running yet, so no PSCI.
-	 * Instead, let the watchdog reset the board.
-	 */
-	for (;;)
-		;
-#else
-	psci_system_reset();
-#endif
-}
diff --git a/arch/arm/mach-meson/spl.c b/arch/arm/mach-meson/spl.c
index 28a63f39d36..ec566849667 100644
--- a/arch/arm/mach-meson/spl.c
+++ b/arch/arm/mach-meson/spl.c
@@ -121,3 +121,13 @@ void board_init_f(ulong dummy)
 	clrbits_32(GX_WDT_CTRL_REG, (1 << 18) | (1 << 25));
 #endif
 }
+
+void reset_cpu(void)
+{
+	/*
+	 * We do not have BL31 running yet, so no PSCI.
+	 * Instead, let the watchdog reset the board.
+	 */
+	for (;;)
+		;
+}

-- 
2.53.0

