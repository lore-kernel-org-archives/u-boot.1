Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E93AC30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 09:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E42A3887F0;
	Wed,  3 Jul 2024 11:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ekcxGqil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B5B2887E4; Wed,  3 Jul 2024 11:05:20 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2CF9887F0
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 11:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7241b2fe79so563842266b.1
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 02:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1719997517; x=1720602317;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTKyPOiZSdTeRWSurS/BWFcqhEtBNgG2EpnrpWfnasU=;
 b=ekcxGqil85uHsUrX2AhM0U9zYWw6iOOzN6lYE78cu7N00TJjAAXp2TOCSVCHf7RGS9
 1dgau5iWn7LptPwEoHF+Qfkgx/FtTwObBX1KNhvMkSO84WzN4msFxa7qdcgAHTIocBjO
 ZDdpvIImODR/k3wiA3sym7LOdeM0f9PbtqfR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719997517; x=1720602317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nTKyPOiZSdTeRWSurS/BWFcqhEtBNgG2EpnrpWfnasU=;
 b=tJEpHhXh726EKmnLBXGD1LiShWOQw+q41FvXLlP2jPtNtfiUe8uT/z8b991+WlMFL0
 va9m51bqeNxHqdxsSUn//3aeJRK/l6ZjGg55k4UodzhK7a6Kbwwkfy0yyEB0oAOEw6OM
 8DCUmIAa4gKMiVd+GXK3EEUeCMAwT4hu2SZ/6CXdJcMKEW5oujlYk5TaWhmC/noiJku0
 71wiX4P0WyEFigaKFSDVVd/rrXdLP3LbDj9ZG/Rcn2fXu4lwdlpcqdBGNrU6XckQ6FK9
 HWU8xZwZuT1oGrVM9NarQXDkkBTdJsUQCgoLW08LhaOOJGApFwoigTlUs+oZCfjMVQG8
 9U8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc3TS371zD4OGKamyc0oaJ4SN3vVOdE8TuuOS4tXUJ2B5vbmX5wKnoGXZbP1dSWL7BOtpIixs9YfeY+1n0CZmNO5IMRQ==
X-Gm-Message-State: AOJu0YwTf6rhQFhRmUgbCs/6mLGphWLFjnvfTa7Z9UmlIw1m6Z6l/KCc
 x8GWsWQY7+EecNbWzEIe48m9OiuzaL7dV41Is9tN3f66275bEW1arcK2yL/+6kFbUdbBEdWs1Ri
 lmdg=
X-Google-Smtp-Source: AGHT+IHp05O72jT6LwMNxasmHItqih6SJm3QxI3vmQM2mb1JvOZEzEzxjUotJsfxs6akhuNnLRHgww==
X-Received: by 2002:a17:907:2d22:b0:a6f:4b5b:4ba7 with SMTP id
 a640c23a62f3a-a75144dea19mr816420266b.67.1719997517158; 
 Wed, 03 Jul 2024 02:05:17 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 ([2001:b07:6474:ebbf:d622:a7f3:7832:9423])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf1bb6bsm491186866b.30.2024.07.03.02.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 02:05:16 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 2/2] clk: imx: add mux ops for i.MX8M composite clk
Date: Wed,  3 Jul 2024 11:05:11 +0200
Message-ID: <20240703090512.92636-3-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703090512.92636-1-michael@amarulasolutions.com>
References: <20240703090512.92636-1-michael@amarulasolutions.com>
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

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
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

