Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F140DD42BBA
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 17:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 477DC884B0;
	Tue, 12 Nov 2024 18:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="q9NPaxPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A63DB892D9; Tue, 12 Nov 2024 18:54:38 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 866E4884B0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 18:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 8DB2A1F8F8;
 Tue, 12 Nov 2024 18:54:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1731434075;
 bh=W9rxCKEbRW3SMhqE6mYkLGgtJlu1oO2zAmanhtGcGKY=; h=From:To:Subject;
 b=q9NPaxPfIg81iM02LXzjv6aevxYZRkwiFdiAuxAL6loHFKMvYkfiI4tKOJ8pRr4MA
 PB76DAuJmJS0CwU/0AumqkubS12Jz9n8te/GcWvLXL9af9u/m8rslBTSDMHvQBJBvs
 rDQP7tEAUj/KoBKTQNjvRn8e7YOyb/2oZHt+yOgVDfadS2waXdBWw7eSBNzgBSfkfA
 dDcUi3CBOqgdHTmdUFdy5X5s4grK0SvwQhNLYvSex90WaiKMYgREsW2aaRPlD6rh6x
 i8o79Hwff4jnMRZvQP76Ny8AALgEtiltLLg4267s6VNTfXK39Qo6U5KJSvj6M9nr+Y
 r5y9ZHmmUnM1g==
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] imx: Fix critical thermal threshold
Date: Tue, 12 Nov 2024 18:54:27 +0100
Message-Id: <20241112175427.83979-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Fix the critical thermal threshold for i.MX processors, this was changed
while moving the code from imx8m/imx9 directories into a shared place.

There is no need to keep the critical threshold 5 degrees less than the
SoC maximum temperature threshold, what is actually going to happen in
practice is that we are going to power-off the board when the SoC is
still within its working temperature range.

In addition to that this is a change in the actual behavior, that is
introducing a regression to users, and it was hidden within a software
refactoring.

Fixes: d0fe80890ab1 ("imx: Generalize fixup_thermal_trips")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/mach-imx/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/fdt.c b/arch/arm/mach-imx/fdt.c
index ac782e3ee636..103c1fc5968a 100644
--- a/arch/arm/mach-imx/fdt.c
+++ b/arch/arm/mach-imx/fdt.c
@@ -115,7 +115,7 @@ int fixup_thermal_trips(void *blob, const char *name)
 
 		temp = 0;
 		if (!strcmp(type, "critical"))
-			temp = 1000 * (maxc - 5);
+			temp = 1000 * maxc;
 		else if (!strcmp(type, "passive"))
 			temp = 1000 * (maxc - 10);
 		if (temp) {
-- 
2.39.5

