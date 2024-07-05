Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0DBC3271F
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 07:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 304F888934;
	Fri,  5 Jul 2024 09:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MtZhg+id";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA218896F; Fri,  5 Jul 2024 09:20:05 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8962B88579
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 09:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a724958f118so154665166b.0
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720164002; x=1720768802;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N85XRfDcPcplvNL7bzPUkL1l2YYn2nyqS5OiAu7J43s=;
 b=MtZhg+iddb7j04fL/LjSa3yIjoRB/+fpNU7ewL2sBCZq9PDFl1djwcKUkQrZIvx3KV
 G8FhyWmQt4PHCFkWtreY5i+Oas07+ML72z1v7oJMH3RVMm9Tcj3YXjqgnC8qKDRTeaXK
 C/hHpxnMsK9gt0j9JnBDmQVV3NXISP75hRcIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720164002; x=1720768802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N85XRfDcPcplvNL7bzPUkL1l2YYn2nyqS5OiAu7J43s=;
 b=isLl87U7QJSZx9ddB1TRD25RVrEAcbD5TjUoNTyrnzL2K2bjYg1HoaMwgOx26ZMIaW
 dAFl3wtdC4RNL7lJq+KAfVNwTSFEyIkYsn2sGRyXp6RueNV3q5Iq4TL9hmTrOB6QeX9a
 XpFBB+qbQISnDtKZvHBGTx0RGNRM3HN8w3I0It+OR2GZpEtS2mvHsCTp4wqo51Evl8FV
 D3auALkqg7fuchhN13OtmNtE3OGTQJafQyzk39KVqlTPtqMPcgUSdBaGX3NISrMP8PxX
 bHEnKIJj8TuqJDg4l7Qj5M4rto5X9xPjJcQtGt+mH29b7pjbE7s5z8joBtn6RGwgQ99M
 5XEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXtIfzmr+RpLrnbAI7Y89Gmr9AoiGDqG0CQj2ma8Dy5aOmLJMMxw9rKhWdKkLOfKYH5kPrmVH3W54xO2GWbU1XSZutAw==
X-Gm-Message-State: AOJu0YwplTGWc3q+Rwk6EGvz2lZBKoKt/0R2BIguWOhajLj/WPPm+00w
 fycXoFhbMZjMnpDwrjUV+qA1bJd+XGxg1BiBprpSCK1pb6nn//qg9j87/AIYauI=
X-Google-Smtp-Source: AGHT+IGMyZN/zGE9Om2i8GUgTPd9lQ6DSTsvOdf/heA6QQw61Fy8ddYhzrA11x78arJdPaC6NgHKIQ==
X-Received: by 2002:a17:907:7e89:b0:a72:40e7:c6e1 with SMTP id
 a640c23a62f3a-a77ba48d504mr283970866b.44.1720164001702; 
 Fri, 05 Jul 2024 00:20:01 -0700 (PDT)
Received: from panicking.. ([2001:b07:6474:ebbf:a3e:4288:e106:2eef])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b84d5sm655158066b.223.2024.07.05.00.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 00:20:01 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH V2] clk: imx: add mux ops for i.MX8M composite clk
Date: Fri,  5 Jul 2024 09:19:52 +0200
Message-ID: <20240705071952.12245-3-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705071952.12245-1-michael@amarulasolutions.com>
References: <20240705071952.12245-1-michael@amarulasolutions.com>
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

Upstream Linux commit f90b68d6c8b0.

The CORE/BUS root slice has following design, simplied graph:
The difference is core not have pre_div block.
A composite core/bus clk has 8 inputs for mux to select, saying clk[0-7].

It support target(smart) interface and normal interface. Target interface
is exported for programmer easy to configure ccm root. Normal interface
is also exported, but we not use it in our driver, because it will
introduce more complexity compared with target interface.

The normal interface simplified as below:
            SEL_A  GA
            +--+  +-+
            |  +->+ +------+
CLK[0-7]--->+  |  +-+      |
       |    |  |      +----v---+    +----+
       |    +--+      |pre_diva+---->    |  +---------+
       |              +--------+    |mux +--+post_div |
       |    +--+      |pre_divb+--->+    |  +---------+
       |    |  |      +----^---+    +----+
       +--->+  |  +-+      |
            |  +->+ +------+
            +--+  +-+
            SEL_B  GB

The mux in the upper pic is not the target interface MUX, target
interface MUX is hiding SEL_A and SEL_B. When you choose clk[0-7],
you are actually writing SEL_A or SEL_B depends on the internal
counter which will also control the internal "mux".

The target interface simplified as below which is used by Linux Kernel:
CLK[0-7]--->MUX-->Gate-->pre_div-->post_div

A requirement of the Target Interface's software is that the
target clock source is active, it means when setting SEL_A, the
current input clk to SEL_A must be active, same to SEL_B.

We touch target interface, but hardware logic actually also need
configure normal interface.

There will be system hang, when doing the following steps:
The initial state:
SEL_A/SEL_B are both sourcing from clk0, the internal counter
choose SEL_A.
1. switch mux from clk0 to clk1
   The hardware logic will choose SEL_B and configure SEL_B to clk1.
   SEL_A no changed.
2. gate off clk0
   Disable clk0, then the input to SEL_A is off.
3. switch from clk1 to clk2
   The hardware logic will choose SEL_A and configure SEL_A to clk2,
   however the current SEL_A input clk0 is off, the system hang.

The solution to fix the issue is in step 1, write twice to
target interface MUX, it will make SEL_A/SEL_B both sources
from clk1, then no need to care about the state of clk0. And
finally system performs well.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
V1->V2:
	add original submitter in linux kernel, suggested by Fabio
	Estevam
---
 drivers/clk/imx/clk-composite-8m.c | 37 +++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 560d74aac80..2cb7d135000 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -117,6 +117,41 @@ static const struct clk_ops imx8m_clk_composite_divider_ops = {
 	.set_rate = imx8m_clk_composite_divider_set_rate,
 };
 
+static int imx8m_clk_mux_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_mux *mux = to_clk_mux(clk);
+	int index;
+	u32 val;
+	u32 reg;
+
+	index = clk_mux_fetch_parent_index(clk, parent);
+	if (index < 0) {
+		log_err("Could not fetch index\n");
+		return index;
+	}
+
+	val = clk_mux_index_to_val(mux->table, mux->flags, index);
+
+	reg = readl(mux->reg);
+	reg &= ~(mux->mask << mux->shift);
+	val = val << mux->shift;
+	reg |= val;
+
+	/*
+	 * write twice to make sure non-target interface
+	 * SEL_A/B point the same clk input.
+	 */
+	writel(reg, mux->reg);
+	writel(reg, mux->reg);
+
+	return 0;
+}
+
+const struct clk_ops imx8m_clk_mux_ops = {
+	.get_rate = clk_generic_get_rate,
+	.set_parent = imx8m_clk_mux_set_parent,
+};
+
 struct clk *imx8m_clk_composite_flags(const char *name,
 				      const char * const *parent_names,
 				      int num_parents, void __iomem *reg,
@@ -155,7 +190,7 @@ struct clk *imx8m_clk_composite_flags(const char *name,
 
 	clk = clk_register_composite(NULL, name,
 				     parent_names, num_parents,
-				     &mux->clk, &clk_mux_ops, &div->clk,
+				     &mux->clk, &imx8m_clk_mux_ops, &div->clk,
 				     &imx8m_clk_composite_divider_ops,
 				     &gate->clk, &clk_gate_ops, flags);
 	if (IS_ERR(clk))
-- 
2.43.0

