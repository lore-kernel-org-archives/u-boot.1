Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B251C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 00:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5708D885BD;
	Sat, 20 Apr 2024 02:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="DEmT2jCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C777388682; Sat, 20 Apr 2024 02:03:53 +0200 (CEST)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com
 [95.215.58.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF6AD885BD
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 02:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1713571431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AxRJ2nG9UujNTuxU6MTu7vtW2CXebfxIx8hc0C985lM=;
 b=DEmT2jCSoFYPy9tEEPhPsJtufj3Piu0CG2Da11NNjuxfoUuRpA1UIzfRpTi+BUv+WUBTYv
 LKuxlb1L5+gdVVQnxSB7ua3Jkg6ReENSKRnpqvFcGnb+NnQkstEBNptPmFnu9JpoBKGVGq
 dUfBY0+2jyZTKC9d+eoYmaU/ViwYPzd9+jbUYHl1t/jVELn+IQyLhltmc0aC4764uG5YqT
 b0n9GfnsQLdYfHRgBlCgPk3CSBp/Vln+ziqtuQaL8EnpKIYYA+VLeN43/gPJnmpuqLlAOE
 +N+E2adEQfNuDddEtcwC8NzdQbiQfs2wVFfDGzhIVK9Lo+z/06ofOcu45bXxnA==
From: John Watts <contact@jookia.org>
Date: Sat, 20 Apr 2024 10:02:35 +1000
Subject: [PATCH RFC 2/9] sunxi: ncat2: Specify DE2 and LCD0 base addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-d1_de2-v1-2-297efca674ba@jookia.org>
References: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
In-Reply-To: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1713571368; l=751;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=9YL8q2WjZiB5Cqnq61xa5zuf9DW+sNLlJm02Kmt1ocw=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABA34nAFkDJsYdWfUnmHaXVSkf
 LWO7sn+tFUlh5sxjwk+gOXOoU56V0LG/2zh1iH85Dz6+X3oCsLiisqNiGJWQuAwUAAOoj
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
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

These are used for operating the LCD on the D1/T113.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
index 908a582ae0..4ae93b5095 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
@@ -25,6 +25,9 @@
 #define SUNXI_MMC1_BASE			0x04021000
 #define SUNXI_MMC2_BASE			0x04022000
 
+#define SUNXI_DE2_BASE			0x05000000
+#define SUNXI_LCD0_BASE			0x05461000
+
 #define SUNXI_R_CPUCFG_BASE		0x07000400
 #define SUNXI_PRCM_BASE			0x07010000
 

-- 
2.44.0

