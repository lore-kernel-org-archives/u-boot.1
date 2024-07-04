Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC82AC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 14:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1069088669;
	Thu,  4 Jul 2024 16:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hkou/9Ql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD8288669; Thu,  4 Jul 2024 16:48:45 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A39FA885D7
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 16:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7541fad560so84473466b.0
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720104522; x=1720709322;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XzBbDuYBhBud4fjVz0V/Rm580A84b5lNRGR8iiz0sH8=;
 b=hkou/9Qlk9JhgEvMtyp+e/czDIjkAYc2W4O6H0ByqHMeq4dBcq7dVFGUgiq+iU63p3
 z9Of6/jTnDtrppn3XYkkjxhbsn5JuAOaTFSXm0C3VIXhRUZ1JW7mKC6S7fx88l9UR1sn
 dAZ8UZ1X18GWqazsZl6WO3Vz7XVgnfQuO051Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720104522; x=1720709322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XzBbDuYBhBud4fjVz0V/Rm580A84b5lNRGR8iiz0sH8=;
 b=h0ksnIuO8KF3+B7ig5X4ozN7IPwmY3LNxprIkenK2SLpykx7eR+JOWRMPmPhUXPkwp
 G6kzUQOZ44Gkz3dvKAq2mxw7afM966CWmvJ8A3KxMyldmr8wp9CbsuEnic8L4CPeRjG7
 kTjbtP8V7GC7VlbB5hQ0G2Sf1u1QzCMQyPJbC94y+EJSvDaZHaM2BlyBVqqCTyncvtTb
 y60Joxd4ndPwNRXZr2HYDWMzG9kWVH6Lje6Si31+zbtYYMYCs+AFNYcoleplsW0iV+22
 Xvwcl99sF5rZ/2m4kmMw/17P57eCiklUknBNUN0d6XcKZSbOwoqyAkjqqwQkEZwdjKlP
 3Wig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5iC0bsZzkpPJ3mWaNYsYrUotILLZUY+8EB1GZB3P41RTkVZKv9uUQNA3jL/kRZVYji5Q4/g8L+HmDAz5ie19fJo+iag==
X-Gm-Message-State: AOJu0Yww0cKiri/DBWS9WWjYXYjFd1+mLMvSTm6aXjLEeTZm5X+STuMH
 M3mYh4FBjwhK9ctBuHIB2MycTZjq1PAicfQKQ1jfHUk6AqXggvXJN/TPZjtV4fg=
X-Google-Smtp-Source: AGHT+IFTGPNtOltmCKavEYbohNMWL9JpE6d2LgKbDgtbC9zL3jAz8ZMSjpU1fw4qKJ1whXJxv5bx6g==
X-Received: by 2002:a17:907:b9c4:b0:a72:7e1e:6301 with SMTP id
 a640c23a62f3a-a77ba7e1a06mr139535066b.61.1720104521911; 
 Thu, 04 Jul 2024 07:48:41 -0700 (PDT)
Received: from panicking.. ([2001:b07:6474:ebbf:bff3:19f9:cf51:6157])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab06519dsm605987666b.99.2024.07.04.07.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 07:48:41 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE present
 for gate and mux
Date: Thu,  4 Jul 2024 16:48:38 +0200
Message-ID: <20240704144838.196350-1-michael@amarulasolutions.com>
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

Gate and mux does not have .set_rate operation, but they could have
CLK_SET_PARENT_RATE flag set. In that case it's usually possible to find a
parent up the tree which is capable of setting the rate (div, pll, etc).
Add clk_generic_set_rate to allow them to trasverse the clock tree.

Cc: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/clk/clk-gate.c   |  1 +
 drivers/clk/clk-mux.c    |  2 +-
 drivers/clk/clk-uclass.c | 20 ++++++++++++++++++++
 drivers/clk/clk.c        |  9 +++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index cfd90b717e7..c86083ac5a3 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -116,6 +116,7 @@ const struct clk_ops clk_gate_ops = {
 	.enable = clk_gate_enable,
 	.disable = clk_gate_disable,
 	.get_rate = clk_generic_get_rate,
+	.set_rate = clk_generic_set_rate,
 };
 
 struct clk *clk_register_gate(struct device *dev, const char *name,
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index e3481be95fa..f99a67ebd35 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -151,13 +151,13 @@ static int clk_mux_set_parent(struct clk *clk, struct clk *parent)
 #else
 	writel(reg, mux->reg);
 #endif
-
 	return 0;
 }
 
 const struct clk_ops clk_mux_ops = {
 	.get_rate = clk_generic_get_rate,
 	.set_parent = clk_mux_set_parent,
+	.set_rate = clk_generic_set_rate,
 };
 
 struct clk *clk_hw_register_mux_table(struct device *dev, const char *name,
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index ed6e60bc484..638864e6774 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -517,6 +517,26 @@ ulong clk_get_parent_rate(struct clk *clk)
 	return pclk->rate;
 }
 
+ulong clk_set_parent_rate(struct clk *clk, ulong rate)
+{
+	const struct clk_ops *ops;
+	struct clk *pclk;
+
+	debug("%s(clk=%p)\n", __func__, clk);
+	if (!clk_valid(clk))
+		return 0;
+
+	pclk = clk_get_parent(clk);
+	if (IS_ERR(pclk))
+		return -ENODEV;
+
+	ops = clk_dev_ops(pclk->dev);
+	if (!ops->set_rate)
+		return -ENOSYS;
+
+	return clk_set_rate(pclk, rate);
+}
+
 ulong clk_round_rate(struct clk *clk, ulong rate)
 {
 	const struct clk_ops *ops;
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 6ede1b4d4dc..febd5314df2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -14,6 +14,7 @@
 #include <dm/uclass.h>
 #include <dm/lists.h>
 #include <dm/device-internal.h>
+#include <linux/clk-provider.h>
 
 int clk_register(struct clk *clk, const char *drv_name,
 		 const char *name, const char *parent_name)
@@ -61,6 +62,14 @@ ulong clk_generic_get_rate(struct clk *clk)
 	return clk_get_parent_rate(clk);
 }
 
+ulong clk_generic_set_rate(struct clk *clk, ulong rate)
+{
+	if (clk->flags & CLK_SET_RATE_PARENT)
+		return clk_set_parent_rate(clk, rate);
+
+	return clk_get_parent_rate(clk);
+}
+
 const char *clk_hw_get_name(const struct clk *hw)
 {
 	assert(hw);
-- 
2.43.0

