Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BA4CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 10:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06108833BF;
	Wed, 13 Aug 2025 12:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ieKJ+od7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE96D833BF; Wed, 13 Aug 2025 12:10:19 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E059083322
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 12:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AEB8422FFD;
 Wed, 13 Aug 2025 12:10:17 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Zzvr6ENy4JZ; Wed, 13 Aug 2025 12:10:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1755079817; bh=n+P+J9Hm2TYHbwsSGQPmXGBRq0h364YYEq6GZU48Bac=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ieKJ+od7n4aKA0UILcIN2jXhEJVQx/T78vZ8IA3VSKFe2F14j6tIXE8LnczJ1de8Z
 Bc5Pk7jYw+xNvQOtgihvQKJBAGu04HGDi/4j2BMQtTBzApLyyjeCsm+DEfTLxH3eMx
 7/yHvGhwTzKu50LJLm8J2azp+0wk6jJ3MHuu9g3qLXOkVdXzzMGjPEQQIhvVlyNolt
 +LOBST2qeZT30Rm7L8NCqaSo090+aik61ILBNpswo29hlarnJSbkzJ2LMiYsAimbZ7
 TaBuLtdwVPgqxo8KaPmZ17jNuk/81f8ULUXB7FB4W/kDxxslFJXRJWxvG1Rjyt+f+C
 N9nVsJOXpyOww==
From: Yao Zi <ziyao@disroot.org>
To: Yao Zi <ziyao@disroot.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 2/4] clk: thead: th1520-ap: Mark drivers as DM_FLAG_PRE_RELOC
Date: Wed, 13 Aug 2025 10:09:25 +0000
Message-ID: <20250813100926.51725-4-ziyao@disroot.org>
In-Reply-To: <20250813100926.51725-2-ziyao@disroot.org>
References: <20250813100926.51725-2-ziyao@disroot.org>
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

It's common that UARTs are bound and probed before U-Boot relocation,
in which case the clocks of UART and UART's pincontroller must be
registered first. Let's apply DM_FLAG_PRE_RELOC to the driver, allowing
it to bind before relocation.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/thead/clk-th1520-ap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 822cf0809d5..6899e1b595a 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -235,6 +235,7 @@ U_BOOT_DRIVER(th1520_clk_div) = {
 	.name	= "th1520_clk_div",
 	.id	= UCLASS_CLK,
 	.ops	= &ccu_div_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
 };
 
 static unsigned long th1520_pll_vco_recalc_rate(struct clk *clk,
@@ -302,6 +303,7 @@ U_BOOT_DRIVER(th1520_clk_pll) = {
 	.name	= "th1520_clk_pll",
 	.id	= UCLASS_CLK,
 	.ops	= &clk_pll_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
 };
 
 static struct ccu_pll cpu_pll0_clk = {
@@ -1030,4 +1032,5 @@ U_BOOT_DRIVER(th1520_clk) = {
 	.of_match	= th1520_clk_match,
 	.probe		= th1520_clk_probe,
 	.ops		= &th1520_clk_ops,
+	.flags		= DM_FLAG_PRE_RELOC,
 };
-- 
2.50.1

