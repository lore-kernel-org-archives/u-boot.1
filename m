Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5067ECA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D7882AC4;
	Fri, 22 Aug 2025 20:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="D0/LjMyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489DA8006D; Fri, 22 Aug 2025 20:56:31 +0200 (CEST)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [91.218.175.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D8DB80548
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755888988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4X0sbIBBWXYTyim3kWHNJLTO4Czc/ty2wDbEeqSq1Hk=;
 b=D0/LjMyU9Lx0O1+Cclp8e0Qou9VTpLsWDdAG350K9BY+apmfBlvQTQiWZloAz8LcRmdTd9
 dQ7X9VXu32rWwG5Qmn5NqRxmJFBq2lBUj70nYcebI2/P827vi2/b4l9Zg/HELEeQoz4UN6
 ek7mgA7FKJFc9aNjuIFGEBnqGmkjmWc=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:54:38 +0200
Subject: [PATCH 1/3] ARM: exynos: use correct exynos4210-origen SoC in Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-exynos-origen-and-pinmux-debug-msg-v1-1-e6384177b42b@grimler.se>
References: <20250822-exynos-origen-and-pinmux-debug-msg-v1-0-e6384177b42b@grimler.se>
In-Reply-To: <20250822-exynos-origen-and-pinmux-debug-msg-v1-0-e6384177b42b@grimler.se>
To: Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=henrik@grimler.se;
 h=from:subject:message-id; bh=rFIDJlOnhgIVMQVu16dN1vI8HXTHff1NXD8niPxv/8Q=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqL1QFDJ07OXCBtFkdcnVDacPFEdTJNArnsDoF
 HpRCpTXD46JATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi9UAAKCRCwB25JC3Fh
 a48CB/98gEWf4BlVa4d4p9MiJrtSR4nPSaNdRVrSyZZryx7a2DeFiMVxXrZWMjb/xhkJ/Dj7cXC
 aJLGvNKdURLcRFc4WCDyVROrAY9BpFxutJ4sDfupwn+YudDQw0ewJj2N9XMBV8bHYVRZrlO42Gs
 LFy9kEXB59MFtYkU+o86XiaNreItda5vdaGuRE1PRYCy9Er+AzuT+niu84rH1qb0bqv5+/Qg46m
 wnHbf/PFZhnm7vCXyWhxCiSz/oLoCCmr/wxSKtTlW9KSvHrFiUwmETQCGPUebA+CqC4SqS31Xym
 Om2COtQwPu+3BZqDD1M1OsA+XNvhz0mDq9mD16kcHJzLiCBB
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
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

There exists both a Origen board based on exynos4210, and a board
based on exynos4412. U-boot only supports the one based on exynos
4210, but Kconfig string was accidentally written as Exynos4412 Origen
in previous migration to Kconfig. Fix the string to clear up
confusion, and to not give the impression that both types of Origen
boards are supported.

Fixes: 72df68cc6b73 ("exynos: kconfig: move board select menu and common settings")

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/mach-exynos/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 28193039cb84251a6fec85cbd249ee36386aa3dd..2cd67d023867de29bf85fe6d68b3485dbb67853c 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -88,7 +88,7 @@ config TARGET_S5PC210_UNIVERSAL
 	select MISC_COMMON
 
 config TARGET_ORIGEN
-	bool "Exynos4412 Origen board"
+	bool "Exynos4210 Origen board"
 	select EXYNOS4210
 	select SUPPORT_SPL
 

-- 
2.50.1

