Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B7DC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 00:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22348886C8;
	Sat, 20 Apr 2024 02:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="Qc9XWR0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E5C088208; Sat, 20 Apr 2024 02:04:29 +0200 (CEST)
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FDE6881F6
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 02:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1713571466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9btPr7nTz+E9V369ulyHjBkjkOj/pyjB80GKXiSBb3E=;
 b=Qc9XWR0rupmWeygz9nUayqGe18hyeLCNYVZv1ZEDd+4pT1xgL0ENldumdj6ftuG9/j46Fy
 mzVnURLSWI9bAvd0xiRgYuaSLTN1KeWdKs1anGBfdQ/Ck1h3cpqd6eJqmSse5I45ypStBN
 sDup7RpaJHc2BSyJlzxN0g2rzHT4dE0PYaUTuT+QK+FO43bqnDxwsLHxLNrJLzG8y+lGCo
 iAw2qbpjUByGPV8msZnHFFfagj2yOekReKrykmhRiFgt4xjw3ajS/3+nFaO+H3uIheS2ZP
 MkT2vLvVk+JewzlQIW26/MbGvSvYh9TycXHv7LRhDH5DatDZRTwHRQwdNNQjcQ==
From: John Watts <contact@jookia.org>
Date: Sat, 20 Apr 2024 10:02:39 +1000
Subject: [PATCH RFC 6/9] sunxi: video: silence unused use_mipi_pll warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-d1_de2-v1-6-297efca674ba@jookia.org>
References: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
In-Reply-To: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1713571385; l=716;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=Ok8mqtDbaaH/r9VTt7O13r+9FeXV+IoN3/tMHI3c+EU=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAxbBRBM9DnTX+McitCjANTHZ
 vSw03stlXvb5zvma4/Nppq97Z444xCFQKn5vzDnBj0dP7T3KPREavOZpMGvTDAQUAAOpL
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

This variable is only used sometimes, so gate it behind an #ifdef.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/video/sunxi/lcdc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/sunxi/lcdc.c b/drivers/video/sunxi/lcdc.c
index ea21d602be..1474f6cb2e 100644
--- a/drivers/video/sunxi/lcdc.c
+++ b/drivers/video/sunxi/lcdc.c
@@ -216,7 +216,10 @@ void lcdc_pll_set(struct sunxi_ccm_reg *ccm, int tcon, int dotclock,
 	int value, n, m, min_m, max_m, diff, step;
 	int best_n = 0, best_m = 0, best_diff = 0x0FFFFFFF;
 	int best_double = 0;
+
+#ifdef CONFIG_MACH_SUN6I
 	bool use_mipi_pll = false;
+#endif
 
 #ifdef CONFIG_SUNXI_DE2
 	step = 6000;

-- 
2.44.0

