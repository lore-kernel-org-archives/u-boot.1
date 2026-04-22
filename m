Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CF0FA1FC5
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 15:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74CDE843C6;
	Wed, 22 Apr 2026 17:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="Kp4WK7c4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23809843D8; Wed, 22 Apr 2026 17:43:41 +0200 (CEST)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF41B843D1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 17:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776872617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7YPzW7ar84iuQsUv9oCtS64vTevJoRF13hjgsyAL9E=;
 b=Kp4WK7c4wPEb0AC6BmEajLrrl+w72SUdlkbERfYFSuD4DbLuAenCKu6qEiT4kcW857VrGa
 sQJSK8jRiBmu+ryRv9TLjjvLcyYRvuI4D4UUpdQ2NIPs65iHpuuKv1ScSBhY9HfL78P1Vr
 oR/Bd5xuZSXEw0T8tC4RjCojJD3ZhpmcmyCrhb5GIbV5oEldcWfoHKEWLfBTa50EOiAo9a
 f/6oSMQeklBTgf/1ddF6fzDPsbAG+dS7xrv5qf3krcWLUO5ktkmnPnm2o3ootXM5bH/X2c
 ArPpY3Kn04gWXu/xEAY+Fzij/aTEy/TI96yTYsCJ+gcIEqtEXSdtGYNdeIjYxg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 22 Apr 2026 15:43:23 +0000
Subject: [PATCH v3 1/4] arm: mach-meson: provide reset_cpu only when
 SYSRESET is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v3-1-07b5ccc8f552@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=IoO1gOKnt0cbf2RWK6vS8f3st5C63IkFCn5XCxBr6JE=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp6OyiD+/FeSVSupsuN9+ByzDbJBfvzZZ1s0FXQ
 SOyjPdkj9uJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaejsogAKCRCEr8vQ14ma
 AwoHD/448ZNhM7XwwsPT9attJ/Wq6HlxLhSfhia/mKMhr1S/PamlQCxx2kmIuIc/PXY7Nj4q432
 B0wHm9L4mDMU4cdDq27xOtKlRVuB0BFiOVlkONByTYSQc2gx/Vav0DcZl+2EKOWGd4cR6sS64u3
 IN6mwNGY8wa/0ywWavvJJpU2bTDDOJDnIbq/EnJR8HOEmfJtDYX2HCylFem2H5D8OCQtb5i93Ty
 eXyNZWssKH5HSnvv+JvUy2bEFWP0tSZkuZVa3DXwP9nWMcnnfx9sr2bkeD50UqiIyx9lo50KYkJ
 qATdShUy4f6/jTLTy7pfBuQzJ4qrYRYqdFPAiZfLpFOIPQsGTIgruyoSPdcArLwr63/JFq8/+f6
 PVuAfdKU+yVsAk4FxSyinzbwFAJuUq7mXwoXwS8hF4KoR2lobg1cL1jMa9FfVD+wCyB+n0euUaX
 cnCpb1PU43R+AUau8+FSG8cjiqLhnZMilR2MOue6s6MgbRuutA8cGM/+QsJxwrBEfdodJtnrPDO
 DKy30s+OI6dwpGsBTpBsDZzj9pENChAgtdXJS/0FfQjIn8KGuGa8BqKnrwz2d/YfqOO9xIUunaO
 miSt0vRFe0mKdJkhE5q2c4FWg14GzQDO+HXQMqo81ZXT25YP4iBhXM70dpQTru1YsNLw5ILriQI
 94nzUrmdXmZBTWA==
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
conflict with the one defined in board-common.c.
SPL however will not have SYSRESET enabled (due to overhead in the final
image, as we have very little space to work with), and thus will still
need that reset_cpu to be defined. Furthermore, some boards do not enable
PSCI support in U-Boot, so they may still need this implementation.
Guard reset_cpu inside #ifdef to only compile it in when SYSRESET is not
enabled.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/mach-meson/board-common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index a5afc2d75c0..c34b81e5e78 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -155,16 +155,14 @@ int board_late_init(void)
 	return meson_board_late_init();
 }
 
+#if defined(CONFIG_XPL) || !CONFIG_IS_ENABLED(SYSRESET)
 void reset_cpu(void)
 {
-#if CONFIG_SPL_BUILD
 	/*
 	 * We do not have BL31 running yet, so no PSCI.
 	 * Instead, let the watchdog reset the board.
 	 */
 	for (;;)
 		;
-#else
-	psci_system_reset();
-#endif
 }
+#endif

-- 
2.53.0

