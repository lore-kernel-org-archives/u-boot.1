Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA28BCEFD01
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 19:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9134083FCF;
	Tue,  6 Jan 2026 20:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="qsgs/bL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C5583B64; Tue,  6 Jan 2026 20:53:32 +0100 (CET)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C052183F01
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 20:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767729210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrOJU99ojXB5J1kHJvQyx7g9OPT08vjzJsTDyNd2tM0=;
 b=qsgs/bL4DpNvObvs9uMWAF9wsDHcZ4uBgUeCo7Wf3WprbTJRp+LEBrjmNsA8Z3oJWgyaTr
 fuC04awzILwtevwWeCCSiXvDTteUXTul3G1Gik3LLTuMZ5TSmnNUFVHACtW3VcgToYjD7A
 YyeiKSN4GvyxIiI5gheKk6PWSIdhoA8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Tom Rini <trini@konsulko.com>, Adam Ford <aford173@gmail.com>,
 u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/2] clk: versaclock: Fix internal crystal clock
Date: Tue,  6 Jan 2026 14:53:22 -0500
Message-Id: <20260106195322.657150-3-sean.anderson@linux.dev>
In-Reply-To: <20260106195322.657150-1-sean.anderson@linux.dev>
References: <20260106195322.657150-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When pin_xin does not exist and the chip supports an internal crystal,
we must create it. Do so, and don't try to enable an error pointer.

Fixes: dcf2cee77f2 ("clk: clk_versaclock: Add support for versaclock driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/clk/clk_versaclock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk_versaclock.c b/drivers/clk/clk_versaclock.c
index 7a1052a1be7..be01f34ceec 100644
--- a/drivers/clk/clk_versaclock.c
+++ b/drivers/clk/clk_versaclock.c
@@ -889,23 +889,22 @@ int versaclock_probe(struct udevice *dev)
 
 	vc5->chip_info = chip;
 	vc5->pin_xin = devm_clk_get(dev, "xin");
-
-	if (IS_ERR(vc5->pin_xin))
-		dev_dbg(dev, "failed to get xin clock\n");
-
-	ret = clk_enable(vc5->pin_xin);
-	if (ret)
-		dev_dbg(dev, "failed to enable XIN clock\n");
-
 	vc5->pin_clkin = devm_clk_get(dev, "clkin");
 
 	/* Register clock input mux */
 	if (!IS_ERR(vc5->pin_xin)) {
+		ret = clk_enable(vc5->pin_xin);
+		if (ret)
+			dev_dbg(dev, "failed to enable XIN clock\n");
 		vc5->clk_mux_ins |= VC5_MUX_IN_XIN;
 	} else if (vc5->chip_info->flags & VC5_HAS_INTERNAL_XTAL) {
+		vc5->pin_xin = clk_register_fixed_rate(NULL, "internal-xtal",
+						       25000000);
 		if (IS_ERR(vc5->pin_xin))
 			return PTR_ERR(vc5->pin_xin);
 		vc5->clk_mux_ins |= VC5_MUX_IN_XIN;
+	} else {
+		return PTR_ERR(vc5->pin_xin);
 	}
 
 	mux_name = versaclock_get_name(dev->name, "mux", -1);
-- 
2.35.1.1320.gc452695387.dirty

