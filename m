Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CC9D41D74
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 01:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99441835B3;
	Fri, 12 Dec 2025 02:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t+7t6oYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74CC38367F; Fri, 12 Dec 2025 02:19:16 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 247B78334F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 02:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6597b877066so488216eaf.2
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765502349; x=1766107149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5bl/QtjdtYKZyJQh3rNWvZ739kovt62CgxV0Y3tPS9I=;
 b=t+7t6oYRQGaJr4UFVNoYHnZxIfYOPzvAOWn0CzzlEHcknFxAhlMLIm+7nbiY7EnvBs
 +DtiIW6yIERNXQptIBjMYasavFuXL5ie5iEk40qPbk/ubK4RBziTunRvSpnkFBwF4pTF
 yTTsTVSsRPysw3IDfOs4VGMOOTuqi3YlY/cZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765502349; x=1766107149;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bl/QtjdtYKZyJQh3rNWvZ739kovt62CgxV0Y3tPS9I=;
 b=mmHPia1xYqZN/joR1K9+8toXl56Rhx1uqO3IZRelyCcLOrM3kLli5Cv4DmUbmbHc4k
 ymGYCvuNrYM9WoPhho85bp2l4Nk541pfxG/dP/5QCUX7X+UgdRpodoidwo1Lz0o/T4mX
 oOTO5vu2Xl316RMsct6wAfrYzAYubtTgqxfBmX8LcFkARqIyBADzwNluld+D4+w+9bUx
 kluGDKEy6itE53hcRoYx+O1dWb02Qye5SGkyNYSnj3RiJp9Vmppf8nMq3eJi7KELVMqM
 cecDgRLkvMGWrAY+5NNnfOy/SAoRvhs0Ay0ibEHMP7TWNgZ27mc3IaGCW+kF7ZSd+/e+
 I6FA==
X-Gm-Message-State: AOJu0Yybv/hIxKFjzY884CJBg4sgSTJZHzKdej9Wny9hpS7GhqqbfxHx
 cY6O7qTCEn8T5kMnYMC7x5UqQvYeZCwkUeeJmdx3O8hHoTHYVnbiuZJaf2V5rwzUyhO7BByNlpj
 lNt2J0ek=
X-Gm-Gg: AY/fxX5NDATN/NbJn+LVtjO4dpKGkakQCHDrbO8TzeJ6tqOn4zrNnMXC9sXOB4+b8pJ
 s9T5Fr0U2m3rJRPtDHb/QJO7TOlNX4PxY1E35y0BioKhc8wkf4eP7zQlPu8u6GHV6WafVJJNBwJ
 bxGFhjik61d8cFahdgUfYFB4YUMom/zxiDtD4CLWR6bgBFLu7eLZ/KSceSNdA/uKd6uCTqBHhVF
 YJR4S6omYY0KUwh8f9tVAWDjcBmQkjpteyrZY7NxwRQ66KXOzFrP+TEd8cBRBqOnuodPLPAK1Tu
 KndrYNVI6akOvtzamsqzq6NeVgquLvEezLXi+NRkYYnYO1d37l/W2/3yvbeG6LRewbMzScRh3c2
 p2iHT8tsSEIYgaLOywX2WlH3KsG44vfkkVuSAZSE7vcJzElXVGLLfwuRCzpZvEP52QY42DG0ohh
 eNAxt2b1DcOC6pDpM5hXQWLNczlYSjV1walP9DXeD/f6wFzfdF9NqQ
X-Google-Smtp-Source: AGHT+IEx9kLp3Ta8/rAVBjWfPIhlMAFHo26rQDTi6ACerNRDBCgWBnd9ODZd0VY3X9hun/oPXq8lbA==
X-Received: by 2002:a05:6820:1caa:b0:65b:3641:bf7a with SMTP id
 006d021491bc7-65b4579151amr150362eaf.81.1765502348848; 
 Thu, 11 Dec 2025 17:19:08 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5fe288197sm515fac.5.2025.12.11.17.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 17:19:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH] Revert "clk: Return value calculated by ERR_PTR"
Date: Thu, 11 Dec 2025 19:19:06 -0600
Message-ID: <20251212011906.865419-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

While this change was intended to fix a mistake in the code, of calling
the ERR_PTR macro but not making use of the result, it seems that
functionally platforms depend on the loop not existing here. The TI K3
families of platforms for example were broken by this commit.

This reverts commit fe780310cfa8bf5a093894b5cd7fe85c6b02fd91.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/include/asm/clk.h |  1 -
 drivers/clk/clk-uclass.c       |  4 ++--
 drivers/clk/clk_sandbox.c      | 17 -----------------
 test/dm/clk.c                  |  5 ++---
 4 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/sandbox/include/asm/clk.h b/arch/sandbox/include/asm/clk.h
index 2d3318cdcc4d..37fe49c7fcf6 100644
--- a/arch/sandbox/include/asm/clk.h
+++ b/arch/sandbox/include/asm/clk.h
@@ -50,7 +50,6 @@ enum sandbox_clk_test_id {
 
 struct sandbox_clk_priv {
 	bool probed;
-	struct clk clk;
 	ulong rate[SANDBOX_CLK_ID_COUNT];
 	bool enabled[SANDBOX_CLK_ID_COUNT];
 	bool requested[SANDBOX_CLK_ID_COUNT];
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 4420651f765c..0584429bed65 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -199,7 +199,7 @@ static struct clk *clk_set_default_get_by_id(struct clk *clk)
 		if (ret) {
 			debug("%s(): could not get parent clock pointer, id %lu\n",
 			      __func__, clk->id);
-			return ERR_PTR(ret);
+			ERR_PTR(ret);
 		}
 	}
 
@@ -354,7 +354,7 @@ static int clk_set_default_rates(struct udevice *dev,
 
 		c = clk_set_default_get_by_id(&clk);
 		if (IS_ERR(c))
-			continue;
+			return PTR_ERR(c);
 
 		ret = clk_set_rate(c, rates[index]);
 
diff --git a/drivers/clk/clk_sandbox.c b/drivers/clk/clk_sandbox.c
index cd92a6a29f57..c8c5a88c52d9 100644
--- a/drivers/clk/clk_sandbox.c
+++ b/drivers/clk/clk_sandbox.c
@@ -8,23 +8,8 @@
 #include <errno.h>
 #include <malloc.h>
 #include <asm/clk.h>
-#include <dm/device-internal.h>
 #include <linux/clk-provider.h>
 
-static int sandbox_clk_of_to_plat(struct udevice *dev)
-{
-	struct clk *clk;
-	struct sandbox_clk_priv *priv = dev_get_priv(dev);
-
-	clk = &priv->clk;
-
-	/* FIXME: This is not allowed */
-	dev_set_uclass_priv(dev, clk);
-
-	clk->dev = dev;
-	return 0;
-}
-
 static ulong sandbox_clk_get_rate(struct clk *clk)
 {
 	struct sandbox_clk_priv *priv = dev_get_priv(clk->dev);
@@ -117,7 +102,6 @@ static int sandbox_clk_request(struct clk *clk)
 	if (id >= SANDBOX_CLK_ID_COUNT)
 		return -EINVAL;
 
-	priv->clk.id = id;
 	priv->requested[id] = true;
 	return 0;
 }
@@ -148,7 +132,6 @@ U_BOOT_DRIVER(sandbox_clk) = {
 	.name		= "sandbox_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= sandbox_clk_ids,
-	.of_to_plat	= sandbox_clk_of_to_plat,
 	.ops		= &sandbox_clk_ops,
 	.probe		= sandbox_clk_probe,
 	.priv_auto	= sizeof(struct sandbox_clk_priv),
diff --git a/test/dm/clk.c b/test/dm/clk.c
index c3363796498b..790968e64774 100644
--- a/test/dm/clk.c
+++ b/test/dm/clk.c
@@ -89,9 +89,8 @@ static int dm_test_clk(struct unit_test_state *uts)
 						 SANDBOX_CLK_TEST_ID_SPI));
 	ut_asserteq(0, sandbox_clk_test_get_rate(dev_test,
 						 SANDBOX_CLK_TEST_ID_I2C));
-	if (!CONFIG_IS_ENABLED(CLK_AUTO_ID))
-		ut_asserteq(321, sandbox_clk_test_get_rate(dev_test,
-							   SANDBOX_CLK_TEST_ID_DEVM1));
+	ut_asserteq(321, sandbox_clk_test_get_rate(dev_test,
+						   SANDBOX_CLK_TEST_ID_DEVM1));
 	ut_asserteq(0, sandbox_clk_test_get_rate(dev_test,
 						 SANDBOX_CLK_TEST_ID_DEVM2));
 
-- 
2.43.0

