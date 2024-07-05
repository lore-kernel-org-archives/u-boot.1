Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B21C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 07:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20B31885F7;
	Fri,  5 Jul 2024 09:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GtC1T83T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11C4888D3; Fri,  5 Jul 2024 09:14:27 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE9C88579
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 09:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52e97e5a84bso1864891e87.2
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720163665; x=1720768465;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mdXSrxeHzpq2ucZicZoEzC7KYWny6VM9o50UFJdp7f8=;
 b=GtC1T83Tev81lXJdJ1ZyhARyuvCjRwB4tsxFdIUVLyOfe+2WQUej2waYL4RnxPN1z7
 4VYZkxk5R+zbWn2RcSFQDwnwNh57UCQChDcX5wLh92wuHjJKKvxLaBn/ozhoMkJAeC0L
 ZphDl1OkXIEMhn3olhoCKe/4fpnvXZVRATTOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720163665; x=1720768465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mdXSrxeHzpq2ucZicZoEzC7KYWny6VM9o50UFJdp7f8=;
 b=Ua5LclN9R6qf9p6ahRGCwAEXp9zaKrQzlVgmtjrcBgc9ULoQDT2R5WkQa3RgJk59ND
 uc3UaORgH5jsxt4Cjwg8Ty3dZDB7DEkEYDIVYNCRRr2KO6/OIqhR1wyrFcxNq3M1U/N5
 2w7GinXNLSra/cE9/vI4rueg9UKNkWkKTgeDUY2+6FlYAp+mw6lcDQFdaxZR3syApSiL
 /yr4W66xiGj2Fr5jDzlJ1+vnUDPaW4OTjjnyHR8NoQp7/c8kolG7voElLbMbDUTSC2vX
 tNNwstd1rbQf75tAvfjXl5qp/EpOL7//w766PI5HXPg3TE8S80UCZwTLEML1gzLKwwXM
 h9wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbGm9uRoKdfLV2PYvYLOrYlQuFVX5aoYhF/0BGbQgpF/NvZ6z1ZStY8dItGmbK6s28waq3/MUbgRaFUK42HpuQxsbKwA==
X-Gm-Message-State: AOJu0YwWkHbXjbPriAMhhyf/aKqh0mYgmrq8nbhNGFsc6GKBBJ+iIx/d
 9taTKqjr5GHt8RHf+E4J81pw8BEmZZXPGhrY+Bqix7TM/qAJy7TasBPiJx6bzbk=
X-Google-Smtp-Source: AGHT+IH1jAwvUB1lw1tQ2jfzkgAsKotYG3kqnMnOLnBGleWy+GHM/5JO6FyZ8YUjTE3j4gtr9AVp4w==
X-Received: by 2002:a05:6512:3456:b0:52c:8b69:e039 with SMTP id
 2adb3069b0e04-52ea060d76emr2933354e87.4.1720163664570; 
 Fri, 05 Jul 2024 00:14:24 -0700 (PDT)
Received: from panicking.. ([2001:b07:6474:ebbf:a3e:4288:e106:2eef])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77d52c498esm15065266b.34.2024.07.05.00.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 00:14:24 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH V2] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present for gate and mux
Date: Fri,  5 Jul 2024 09:14:19 +0200
Message-ID: <20240705071419.11521-1-michael@amarulasolutions.com>
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
 drivers/clk/clk-gate.c       |  1 +
 drivers/clk/clk-mux.c        |  2 +-
 drivers/clk/clk-uclass.c     | 20 ++++++++++++++++++++
 drivers/clk/clk.c            |  9 +++++++++
 include/clk.h                |  9 +++++++++
 include/linux/clk-provider.h |  1 +
 6 files changed, 41 insertions(+), 1 deletion(-)
---
V1->V2:
	Fix missing include
---
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
diff --git a/include/clk.h b/include/clk.h
index af23e4f3475..1900377eddb 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -452,6 +452,15 @@ struct clk *clk_get_parent(struct clk *clk);
  */
 ulong clk_get_parent_rate(struct clk *clk);
 
+/**
+ * clk_set_parent_rate() - Set parent of current clock rate.
+ * @clk:	A clock struct that was previously successfully requested by
+ *		clk_request/get_by_*().
+ *
+ * Return: clock rate in Hz, or -ve error code.
+ */
+ulong clk_set_parent_rate(struct clk *clk, ulong rate);
+
 /**
  * clk_round_rate() - Adjust a rate to the exact rate a clock can provide
  * @clk: A clock struct that was previously successfully requested by
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 59f9c241b84..459fa2d15ce 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -253,6 +253,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 
 const char *clk_hw_get_name(const struct clk *hw);
 ulong clk_generic_get_rate(struct clk *clk);
+ulong clk_generic_set_rate(struct clk *clk, ulong rate);
 
 struct clk *dev_get_clk_ptr(struct udevice *dev);
 
-- 
2.43.0

