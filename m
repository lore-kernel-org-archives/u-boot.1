Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794E4C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4310881E14;
	Wed, 19 Mar 2025 04:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354366;
	bh=B+lZR0i7x+YDmC41a24Cnixvtb1k81kzH2qu5D33f6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ON9Ets1G+GC79zbxFTv1U5mHx2D8BNQNX+9Ge64R/q87HdkMI/Ou/T3nKDMe7Z+kT
	 RgLNYT7SN9uW4LnYfirWyyD3CTFeCfGngCw5gONY6c63LUnoVrt0gsysKnkCOC6yU4
	 E2pjj85mg25HShJqMMvK/Qd7i2T2NSE/VS52rakJpjk0S82Ez8OVkJ9FAPzv8Y3wt3
	 jKxFnhVjhExdg08jt9yRdUtLxB7ZkoRMUohGWCfwkwYn5BCWBp1q24TlYwZ+oFZ+pc
	 n4kua/2gddQ5Mbv7DoSnD3li3Lbv6egGZlRBsrgu/ALWEEWM95aH/Gvzh+dmofZwkM
	 BT6Xu716iTgxA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0C2081E02; Wed, 19 Mar 2025 04:19:24 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BB6781DFA
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VrczJgNJ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DCE11101E91CB; Wed, 19 Mar 2025 04:19:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354361; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=B+lZR0i7x+YDmC41a24Cnixvtb1k81kzH2qu5D33f6A=;
 b=VrczJgNJRtTGSijrB1wNCZ1PAAvqyd2kmfq/nG7ip7NAgacKP+fr34eCNj8WD60pAIQXLL
 Ry0dg6wPhLMEOOg/HFArcMJHU8yrT1ZOVqyfc1+e3NOhS0epkByAj+Q83jQbafmfmTDdDM
 FRYdB7JbVBw5TU+MwvzsBBweSqjqPpfdXlcxF6oYDhW1umbkNtR4YD0ost8tZ7Qhsk3jOB
 KrSRW2kLvYia8v+oI7+kZifVettVE+9WTmz0t/NzKMFn2wLxW86MrRkfO6QCtCe5KmfG09
 snvLZ17g7ZXbtVJwv73VmHp+PxxxDtzAz8FEmTk0ooI2Gca6JWdhpQhMKbmh0w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 07/24] clk: clk-gate: Use struct udevice instead of struct
 device
Date: Wed, 19 Mar 2025 04:17:17 +0100
Message-ID: <20250319031852.233537-8-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319031852.233537-1-marex@denx.de>
References: <20250319031852.233537-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Use U-Boot specific struct udevice instead of Linux compatibility
struct device in clk-gate registration.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
 drivers/clk/clk-gate.c       | 2 +-
 include/linux/clk-provider.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index bf1c6a93b46..cef98720b69 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -117,7 +117,7 @@ const struct clk_ops clk_gate_ops = {
 	.get_rate = clk_generic_get_rate,
 };
 
-struct clk *clk_register_gate(struct device *dev, const char *name,
+struct clk *clk_register_gate(struct udevice *dev, const char *name,
 			      const char *parent_name, unsigned long flags,
 			      void __iomem *reg, u8 bit_idx,
 			      u8 clk_gate_flags, spinlock_t *lock)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index f27878ae6fa..e282be12897 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -105,7 +105,7 @@ struct clk_gate {
 #define CLK_GATE_HIWORD_MASK		BIT(1)
 
 extern const struct clk_ops clk_gate_ops;
-struct clk *clk_register_gate(struct device *dev, const char *name,
+struct clk *clk_register_gate(struct udevice *dev, const char *name,
 			      const char *parent_name, unsigned long flags,
 			      void __iomem *reg, u8 bit_idx,
 			      u8 clk_gate_flags, spinlock_t *lock);
-- 
2.47.2

