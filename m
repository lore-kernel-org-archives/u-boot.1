Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8561BC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 19:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78AE487C39;
	Sat, 16 Dec 2023 20:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jm8+Rj+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EBD1875A0; Sat, 16 Dec 2023 20:38:55 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D7187716
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 20:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-425b9acaf80so16042781cf.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 11:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702755531; x=1703360331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hrl+2tHhBc+jAvmDnWLLjluYlEythlDrZ9/1G8jwYp0=;
 b=jm8+Rj+p0B5xwsvTABtB1BxMyv7A22NkvEDzECGdjbknFyypVsa9Q+3bw9RIOAL79l
 9iG65HwdjDX6tTZJDEW5jbKbBHkZzXNxZi6SLtGiBB315/gaAs8FeuI7Q5KPcn4bZvE9
 i4LpCbeofL9A1vLaYKruyO0jL1RpavLZmsVBhM355m7dET827EzHdRp6tjy8jWHKJn3j
 jjP7G4FF1xAi+pU468aO+8XFLzWJcy1VVG4xiQ+xsjbFF+idI82tuiHp66zHM8QgJSs/
 9wPMFf4HoSFOLsXWVjjkRyAzGjw+smBd7Ynws5sf9CX5r5Pa1/bbCpOYpfBU2J2WgH8H
 rnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702755531; x=1703360331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hrl+2tHhBc+jAvmDnWLLjluYlEythlDrZ9/1G8jwYp0=;
 b=oAI7G/i01yicQIr0J28TUKEtXcl5QaXmc6XxzrBCQtqj7A4b9QBCd2OoOyzkupAnGM
 tZRGyunbfFxRe3rA2EIAdCFJCC5BfEqmCYrn1TeXQRICkdYtiXlv4ynCc4P88B6m9MJ9
 5KmloOr7E0jhd30eFUoq6w/P/4TdOqNJSkcd8jZEqxKn3A4GyZ2CVML4pn/n29JDTfHz
 R0JFHG7mzKmoGkLba31sUOB6MTPccAyvx6JW4NbOqLU+6IIQ+nfggvuKnFs6C3oe5UtS
 XYc2h18GI/vtDyj4tTmh3URw8n8GXkwVi9e7ouS97rC2OcFKuBOQuKVSSe/aWssXewq3
 MEpg==
X-Gm-Message-State: AOJu0YypGuYo15pW/dwsFyntsJ3RLFCE8oy5fPi04If9fIX7my8bDKG0
 vscAb1mw/lX5VWwWBdjxv5X+ZcjRz7xhxQ==
X-Google-Smtp-Source: AGHT+IE/RL11BeoY2SxxPSqMqoqToTZpEcQ6p56xJbfimpOs6teL1Y8gOb1HTFgnInCpszmBN8/rJQ==
X-Received: by 2002:a05:620a:27c9:b0:76c:af30:3281 with SMTP id
 i9-20020a05620a27c900b0076caf303281mr15588921qkp.10.1702755526733; 
 Sat, 16 Dec 2023 11:38:46 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 v25-20020a05620a123900b0077fb4ae1a71sm1183758qkj.93.2023.12.16.11.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 11:38:46 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 1/3] clk: Remove rfree
Date: Sat, 16 Dec 2023 14:38:41 -0500
Message-Id: <20231216193843.2463779-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231216193843.2463779-1-seanga2@gmail.com>
References: <20231216193843.2463779-1-seanga2@gmail.com>
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

Nothing uses this function. Remove it. Since clk_free no longer does
anything, just stub it out.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 arch/sandbox/include/asm/clk.h |  8 --------
 drivers/clk/clk-uclass.c       | 14 --------------
 drivers/clk/clk_sandbox.c      | 12 ------------
 drivers/clk/clk_sandbox_test.c | 12 ------------
 include/clk-uclass.h           | 10 ----------
 include/clk.h                  | 18 ++++--------------
 test/dm/clk.c                  |  9 ---------
 7 files changed, 4 insertions(+), 79 deletions(-)

diff --git a/arch/sandbox/include/asm/clk.h b/arch/sandbox/include/asm/clk.h
index 2b7dbca8f75..b8204227023 100644
--- a/arch/sandbox/include/asm/clk.h
+++ b/arch/sandbox/include/asm/clk.h
@@ -180,14 +180,6 @@ int sandbox_clk_test_disable(struct udevice *dev, int id);
  * @return:	0 if OK, or a negative error code.
  */
 int sandbox_clk_test_disable_bulk(struct udevice *dev);
-/**
- * sandbox_clk_test_free - Ask the sandbox clock test device to free its
- * clocks.
- *
- * @dev:	The sandbox clock test (client) device.
- * @return:	0 if OK, or a negative error code.
- */
-int sandbox_clk_test_free(struct udevice *dev);
 /**
  * sandbox_clk_test_release_bulk - Ask the sandbox clock test device to release
  * all clocks in it's clock bulk struct.
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 3b5e3f9c86b..9260e434988 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -461,20 +461,6 @@ int clk_request(struct udevice *dev, struct clk *clk)
 	return ops->request(clk);
 }
 
-void clk_free(struct clk *clk)
-{
-	const struct clk_ops *ops;
-
-	debug("%s(clk=%p)\n", __func__, clk);
-	if (!clk_valid(clk))
-		return;
-	ops = clk_dev_ops(clk->dev);
-
-	if (ops->rfree)
-		ops->rfree(clk);
-	return;
-}
-
 ulong clk_get_rate(struct clk *clk)
 {
 	const struct clk_ops *ops;
diff --git a/drivers/clk/clk_sandbox.c b/drivers/clk/clk_sandbox.c
index 636914db8ca..73d943f9e09 100644
--- a/drivers/clk/clk_sandbox.c
+++ b/drivers/clk/clk_sandbox.c
@@ -101,17 +101,6 @@ static int sandbox_clk_request(struct clk *clk)
 	return 0;
 }
 
-static void sandbox_clk_free(struct clk *clk)
-{
-	struct sandbox_clk_priv *priv = dev_get_priv(clk->dev);
-
-	if (clk->id >= SANDBOX_CLK_ID_COUNT)
-		return;
-
-	priv->requested[clk->id] = false;
-	return;
-}
-
 static struct clk_ops sandbox_clk_ops = {
 	.round_rate	= sandbox_clk_round_rate,
 	.get_rate	= sandbox_clk_get_rate,
@@ -119,7 +108,6 @@ static struct clk_ops sandbox_clk_ops = {
 	.enable		= sandbox_clk_enable,
 	.disable	= sandbox_clk_disable,
 	.request	= sandbox_clk_request,
-	.rfree		= sandbox_clk_free,
 };
 
 static int sandbox_clk_probe(struct udevice *dev)
diff --git a/drivers/clk/clk_sandbox_test.c b/drivers/clk/clk_sandbox_test.c
index 5807a454f3b..d9ec070110e 100644
--- a/drivers/clk/clk_sandbox_test.c
+++ b/drivers/clk/clk_sandbox_test.c
@@ -134,18 +134,6 @@ int sandbox_clk_test_disable_bulk(struct udevice *dev)
 	return clk_disable_bulk(&sbct->bulk);
 }
 
-int sandbox_clk_test_free(struct udevice *dev)
-{
-	struct sandbox_clk_test *sbct = dev_get_priv(dev);
-	int i;
-
-	devm_clk_put(dev, sbct->clkps[SANDBOX_CLK_TEST_ID_DEVM1]);
-	for (i = 0; i < SANDBOX_CLK_TEST_NON_DEVM_COUNT; i++)
-		clk_free(&sbct->clks[i]);
-
-	return 0;
-}
-
 int sandbox_clk_test_release_bulk(struct udevice *dev)
 {
 	struct sandbox_clk_test *sbct = dev_get_priv(dev);
diff --git a/include/clk-uclass.h b/include/clk-uclass.h
index cd62848bece..4353b664800 100644
--- a/include/clk-uclass.h
+++ b/include/clk-uclass.h
@@ -18,7 +18,6 @@ struct ofnode_phandle_args;
  * struct clk_ops - The functions that a clock driver must implement.
  * @of_xlate: Translate a client's device-tree (OF) clock specifier.
  * @request: Request a translated clock.
- * @rfree: Free a previously requested clock.
  * @round_rate: Adjust a rate to the exact rate a clock can provide.
  * @get_rate: Get current clock rate.
  * @set_rate: Set current clock rate.
@@ -33,7 +32,6 @@ struct clk_ops {
 	int (*of_xlate)(struct clk *clock,
 			struct ofnode_phandle_args *args);
 	int (*request)(struct clk *clock);
-	void (*rfree)(struct clk *clock);
 	ulong (*round_rate)(struct clk *clk, ulong rate);
 	ulong (*get_rate)(struct clk *clk);
 	ulong (*set_rate)(struct clk *clk, ulong rate);
@@ -81,14 +79,6 @@ int of_xlate(struct clk *clock, struct ofnode_phandle_args *args);
  */
 int request(struct clk *clock);
 
-/**
- * rfree() - Free a previously requested clock.
- * @clock:	The clock to free.
- *
- * Free any resources allocated in request().
- */
-void rfree(struct clk *clock);
-
 /**
  * round_rate() - Adjust a rate to the exact rate a clock can provide.
  * @clk:	The clock to manipulate.
diff --git a/include/clk.h b/include/clk.h
index 3d6394477be..ea5f6bd6f79 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -424,6 +424,10 @@ static inline int clk_release_bulk(struct clk_bulk *bulk)
 	return clk_release_all(bulk->clks, bulk->count);
 }
 
+static inline void clk_free(struct clk *clk)
+{
+}
+
 #if CONFIG_IS_ENABLED(CLK)
 /**
  * clk_request() - Request a clock by provider-specific ID.
@@ -441,15 +445,6 @@ static inline int clk_release_bulk(struct clk_bulk *bulk)
  */
 int clk_request(struct udevice *dev, struct clk *clk);
 
-/**
- * clk_free() - Free a previously requested clock.
- * @clk:	A clock struct that was previously successfully requested by
- *		clk_request/get_by_*().
- *
- * Free resources allocated by clk_request() (or any clk_get_* function).
- */
-void clk_free(struct clk *clk);
-
 /**
  * clk_get_rate() - Get current clock rate.
  * @clk:	A clock struct that was previously successfully requested by
@@ -594,11 +589,6 @@ static inline int clk_request(struct udevice *dev, struct clk *clk)
 	return -ENOSYS;
 }
 
-static inline void clk_free(struct clk *clk)
-{
-	return;
-}
-
 static inline ulong clk_get_rate(struct clk *clk)
 {
 	return -ENOSYS;
diff --git a/test/dm/clk.c b/test/dm/clk.c
index 01417fbd825..57fabbdce08 100644
--- a/test/dm/clk.c
+++ b/test/dm/clk.c
@@ -182,19 +182,10 @@ static int dm_test_clk(struct unit_test_state *uts)
 						   SANDBOX_CLK_ID_I2C));
 	ut_asserteq(1, sandbox_clk_query_requested(dev_clk,
 						   SANDBOX_CLK_ID_UART2));
-	ut_assertok(sandbox_clk_test_free(dev_test));
-	ut_asserteq(0, sandbox_clk_query_requested(dev_clk,
-						   SANDBOX_CLK_ID_SPI));
-	ut_asserteq(0, sandbox_clk_query_requested(dev_clk,
-						   SANDBOX_CLK_ID_I2C));
-	ut_asserteq(0, sandbox_clk_query_requested(dev_clk,
-						   SANDBOX_CLK_ID_UART2));
 
 	ut_asserteq(1, sandbox_clk_query_requested(dev_clk,
 						   SANDBOX_CLK_ID_UART1));
 	ut_assertok(device_remove(dev_test, DM_REMOVE_NORMAL));
-	ut_asserteq(0, sandbox_clk_query_requested(dev_clk,
-						   SANDBOX_CLK_ID_UART1));
 	return 0;
 }
 DM_TEST(dm_test_clk, UT_TESTF_SCAN_FDT);
-- 
2.37.1

