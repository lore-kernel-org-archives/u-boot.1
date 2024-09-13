Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48583FA3736
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03BE88BCF;
	Fri, 13 Sep 2024 11:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DJmgR0Qq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E199288B6D; Fri, 13 Sep 2024 11:57:05 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A2A2886AF
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a90349aa7e5so193038166b.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221421; x=1726826221;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jE25Jwvxv1lQqd9B0PMvAa/3bguXHPwmlQrK/A2JMtE=;
 b=DJmgR0QqUQr7P/kO8hNP7Zjp+IPS8Pg2UGqVhz1V3g4YiqUnyzLn+EH8XXmo0JONnk
 TDhAvobRb9yTTWRWz//Uu1MHuvL6P+mU9tamc00edsIc+ipj6NQu83Kibcs6mm5+yRDt
 Bpfe31aF32FujmXA8dhY6hOJpBp/Y/PqyH38s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221421; x=1726826221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jE25Jwvxv1lQqd9B0PMvAa/3bguXHPwmlQrK/A2JMtE=;
 b=uoNs9DzUtKxr+fU0rDTo2QxxeIkefhtkB6ij+Tr5b/cBCHYKeo+zcT9DXqkNnnibnx
 Pke07QLUSsrPBxZPU3hN4qeNS9POt+0r6QUE56sjfgUkMVjCUH25vHShQf1x3QqIf2B+
 4HtGZG3gWx+3B3Z2KRTy/8L8V0LOxGWHlU29dECqhb7KB3F9SGgP9A2/3aWe6CtH73Sj
 WbIL9ASbnysAFBxKhu1duJe8TMJqa4dQbA3bdInPw8Vb+kVo41sBumXpTNqxaE6D3ODO
 tSjlUkuSQ3wF+S1Ja6dvo/XYwABpjixD2Qs8jhMHLkcZqjlUALGJAO8pi7LuzJrxVcxf
 B7Zw==
X-Gm-Message-State: AOJu0Yw1czXYi7KshxGLmx1Zq5wTnAQKLYEwtTibsf61Ln4EsrrxJ3ye
 hq7xqss7uey5unK8IjVGjl8P/PCBngGc9RWBv5cPj1PybsHe6/S0B60DRh6twznnbgBSHPgU6Sf
 776s=
X-Google-Smtp-Source: AGHT+IEPpLhVmMIWTxLRQeZXcejBGD3W2M6KqHuRFO9q/SlH4LThwRNMFy3/YeomVhgiHvGTiRmzJw==
X-Received: by 2002:a17:906:bc26:b0:a8d:2ec3:94f4 with SMTP id
 a640c23a62f3a-a902964d007mr497794666b.54.1726221420786; 
 Fri, 13 Sep 2024 02:57:00 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:00 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexander Dahl <ada@thorsis.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@sberdevices.ru>, Jan Kiszka <jan.kiszka@siemens.com>,
 Julien Masson <jmasson@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH 01/26] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present for gate and mux
Date: Fri, 13 Sep 2024 11:55:43 +0200
Message-ID: <20240913095622.72377-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

Gate and mux does not have .set_rate operation, but they could have
CLK_SET_PARENT_RATE flag set. In that case it's usually possible to find a
parent up the tree which is capable of setting the rate (div, pll, etc).
Add clk_generic_set_rate to allow them to trasverse the clock tree.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/clk-gate.c       |  1 +
 drivers/clk/clk-mux.c        |  2 +-
 drivers/clk/clk-uclass.c     | 20 ++++++++++++++++++++
 drivers/clk/clk.c            |  9 +++++++++
 include/clk.h                |  9 +++++++++
 include/linux/clk-provider.h |  1 +
 6 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index bf1c6a93b468..bd0d3d44ac8c 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -115,6 +115,7 @@ const struct clk_ops clk_gate_ops = {
 	.enable = clk_gate_enable,
 	.disable = clk_gate_disable,
 	.get_rate = clk_generic_get_rate,
+	.set_rate = clk_generic_set_rate,
 };
 
 struct clk *clk_register_gate(struct device *dev, const char *name,
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 62477e15d27a..4feb8e8c821d 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -150,13 +150,13 @@ static int clk_mux_set_parent(struct clk *clk, struct clk *parent)
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
index 16169dac2340..e8db9b0ff2fd 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -515,6 +515,26 @@ ulong clk_get_parent_rate(struct clk *clk)
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
index b8c2e8d531b9..67c6b23231ff 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -13,6 +13,7 @@
 #include <dm/uclass.h>
 #include <dm/lists.h>
 #include <dm/device-internal.h>
+#include <linux/clk-provider.h>
 
 int clk_register(struct clk *clk, const char *drv_name,
 		 const char *name, const char *parent_name)
@@ -60,6 +61,14 @@ ulong clk_generic_get_rate(struct clk *clk)
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
index 045e923a529b..f0fd524ee519 100644
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
index 59f9c241b846..459fa2d15ceb 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -253,6 +253,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 
 const char *clk_hw_get_name(const struct clk *hw);
 ulong clk_generic_get_rate(struct clk *clk);
+ulong clk_generic_set_rate(struct clk *clk, ulong rate);
 
 struct clk *dev_get_clk_ptr(struct udevice *dev);
 
-- 
2.43.0

