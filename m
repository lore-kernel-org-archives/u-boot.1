Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132A7EF5862
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 06:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D488366F;
	Wed, 25 Feb 2026 07:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KOi/ofqc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE19A83946; Wed, 25 Feb 2026 07:23:05 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23E9E82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7BEF3403BF; 
 Wed, 25 Feb 2026 06:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772000583;
 bh=oajcYhx8gI6LkX+XymQMoiE3JMnOJbFZ45jwlku4f2c=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=KOi/ofqcHo10lMffRVVGuRPOfujy3yQMPEMwRyGac2On7Or/NYjY31DXpOX5Pa0zP
 6m02kqXQbuB+yJ/0pHsugG38sR3wcV/AuoKRfHcskFOEhQCq5Kqa/YL+xfYR6yOF6d
 MuhqQkfsVFJn8qkYVzqNCPXvO7N98zAANBDY0V+Or/RKHwyCJD4EoW4JSYecdX3ovR
 xmzuW/11D47DU4SR5fwqt1qPHFISZLEyIUoze4Fxo2YriquGzYdqIHnbZMKw4LS+th
 DeiVmJR2a5Y4/ZNHpiIm193vr0NKjqX0YwPl4+EEetNrxhnVyWl7dfDkX2ItFyfr0k
 kTOtnJoxXneP9wdl23Z8A9WsWLwYvEmUD4Mzyd4BpsqmnBFi2V3JmWpQWDKF2UEaXW
 AEvLsaevh/ug8OddNqxUpsY2uqd8oRe5u59UDW5tqnhRslunPe7mlxpoATMrIPd4me
 GoTWPmr9kqBe3D/N3hxXc2dNp5lxortYMtNXbwSe5dhbPAgF2VfIT77QVhEzizS9fI
 /CyW0dnQwX/moAiU+gOUwYkTDChDQyVmDMW2Ql5/ufAlf3w3im6ZnEHMUzr+MJf12V
 /7HTDi9LQlLyi2p0Q6JgZAXhOfRUjMTtG3ZYqXDNuUUeNmxgc1CGgyICnNif5K1cOM
 xh9qAF1fauBFuErg9yS6Er98=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] x86/apollolake: don't select non-existent INTEL_PMC
Date: Wed, 25 Feb 2026 07:23:01 +0100
Message-ID: <20260225062301.46540-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Symbol CONFIG_INTEL_PMC does not exist.
Don't select it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/x86/cpu/apollolake/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/cpu/apollolake/Kconfig b/arch/x86/cpu/apollolake/Kconfig
index 5dd866ffcfe..99b532f385f 100644
--- a/arch/x86/cpu/apollolake/Kconfig
+++ b/arch/x86/cpu/apollolake/Kconfig
@@ -9,7 +9,6 @@ config INTEL_APOLLOLAKE
 	select ARCH_MISC_INIT
 	select USE_CAR
 	select INTEL_SOC
-	select INTEL_PMC
 	select TPL_X86_TSC_TIMER_NATIVE
 	select SPL_PCH
 	select TPL_PCH
-- 
2.51.0

