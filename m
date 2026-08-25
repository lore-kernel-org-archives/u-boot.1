Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39841C5B572
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 04:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFAEE80D74;
	Tue, 25 Aug 2026 04:25:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pYGpjeukVJYL; Tue, 25 Aug 2026 04:25:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787631917;
	bh=xVDLYm7Vc4eS7g7lUhStZtpiZZEIXN58iH76x5D+dEk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=izUgzyh7NgaYLDjmH+MUvAcx0LaQmlrV0b7AtVIz+BA394fmYv4Xen/T5IUTi00hn
	 W1MiFz4qVRStnLtDac/ja650qY1ASxsdDf7VBSDWajSp7+hmcPXtpGm/zw7/CjHQF4
	 5cBN8EkM+Bm4AYBufFX9d3ZTmeBS9KGtRIQsPrF5uHsmdD2qPTniOGVqT4kaFL5VBB
	 pDSc2My2yoSStcVq+zFdqCq4d3x80MKKOyPb1UP/d0x0jw4U1JED/MZb9jbypGIsaZ
	 pcrrsxPhwnvrowicLZ+JemDlFLAJkX6iBeNLr8+dDr+97Yz4KpdEwTvV+gs1rBvBF7
	 Nv+i2W43qYcNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46DE380D09;
	Tue, 25 Aug 2026 04:25:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F189E1465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E407880C33
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-RlJs4GRfOh for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 04:25:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cG75mCin
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 344C080D10
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B9F543F63;
 Tue, 25 Aug 2026 04:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ADA1F000E9;
 Tue, 25 Aug 2026 04:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787631913;
 bh=xVDLYm7Vc4eS7g7lUhStZtpiZZEIXN58iH76x5D+dEk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cG75mCinIZY6vXK7Li4vs3p5dtpsoGUt/0KT0hfV5idNZA+Hp/qucEEhTpTBqaTep
 iUXi+OuIVCGwHpi4Ld7Yzlt5npjWoag67npxyVXQe+d5eAf/axQ+yG6m59gFDNTH6w
 vQvLZAb1XFTq5Fnsllw2U3vFZvsefv3UeFhDmewygfF8ZFMy9GMmasfxyvZlH321Jo
 Uz3WwHfKz0Ip40lA21j9f5j8CVp76m1Yg01GcbEz2fR0ppZmwV0lN6/GH9g0G8CeJW
 1xgOiSMWMsKrlHMNehKD2shG1Mlo2HPcSv+A3lz5wulbE4RHIWkIzZaNb9m1bg1c8r
 n8tmQAoN+eKNw==
From: Yixun Lan <dlan@kernel.org>
Date: Tue, 25 Aug 2026 04:24:12 +0000
Subject: [PATCH 2/8] clk: spacemit: ccu_mix: add inverted enable gate clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-01-k3-clock-reset-support-v1-2-c430253e759c@kernel.org>
References: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
In-Reply-To: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3297; i=dlan@kernel.org;
 h=from:subject:message-id; bh=NRLwp8NB1IxmSa8mEQExvHg9nJZQbtlW+HLuENSffDg=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqjRkJXq+Tbcjg1zHZOLuCSpE7BJ5jo8nF6qtX/
 Mv/gh7AJkGJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCao0ZCRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+29ig/+IdtL5ZnZh6NbxOmu9wp6qCmxNrhkzOYQDl+xVl93PQ7vygpwg4aNK
 v6SpNlQf9ug9gAwDToGgDW5OFZ5LSO41A8aTGKVbK7n1r/idv4m3O/VDqaF2T0fFiwprDbbuKPT
 1aqoGP6a0f1CWhsG65z6YRV7oKHULhGg8cB/dpEt0yAxXVHR/UgeI8WB7Jms+GYczi6fUF4KL/a
 UBvUeN/71ExlwfZIii7877Hg+uVI3Ln1uItIhEzVvSTptXuy3kWudx8L2orPI+GE7PzeKCU07fT
 5i1Z/DwZWlql+0ZO1kD0RbeTEtQU9kBsIgS8OKJxUz7wGFdQB5O6pKAk9D31EL0tiD+xO/jhg6s
 Vv9HPc5tk7n1XSz5E/1t2jqTdwFUgWpTduPIaIuNnrgVnziSKkchpEyVjzhTGMHPHraBXGKV5eY
 Kfaco3loKJYeA6S6iC4lCNKlfBcTaZX8sla2Pb/QXX2UWKnFoWeyGJ6WbLumwv+/OigVxHreTyQ
 uNgqRxTvXNQ+SeaA0lPkB7oQu37Tn/csxUA5e8oz/1A0UeEnj5A7yxcXQhhmRo2ZBWUkCfJdcOI
 1wthitIql4lpxG3OmkKEQCZMZy8tVbZOmPIOzS4hoZnhBmDW1Z8bXSpttjPa2LDgm/+lOD0lxpG
 e3b1725+NQ5f7dhtt9mLBr0WKaMx7s=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Based on upstream linux:
  ace73b7e2763 ("clk: spacemit: ccu_mix: add inverted enable gate clock")

K3 SoC has the clock IP which support to write value 0 for enabling the
clock, while write 1 for disabling it, thus the enable BIT is inverted.
So, introduce a flag to support the inverted gate clock.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/clk/spacemit/clk_mix.c |  7 +++++--
 drivers/clk/spacemit/clk_mix.h | 17 +++++++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/spacemit/clk_mix.c b/drivers/clk/spacemit/clk_mix.c
index 45bf2c72375..b0d1a506851 100644
--- a/drivers/clk/spacemit/clk_mix.c
+++ b/drivers/clk/spacemit/clk_mix.c
@@ -33,8 +33,10 @@
 int ccu_gate_disable(struct clk *clk)
 {
 	struct ccu_mix *mix = clk_to_ccu_mix(clk);
+	struct ccu_gate_config *gate = &mix->gate;
+	u32 val = gate->inverted ? gate->mask : 0;
 
-	ccu_update(&mix->common, ctrl, mix->gate.mask, 0);
+	ccu_update(&mix->common, ctrl, gate->mask, val);
 
 	return 0;
 }
@@ -43,8 +45,9 @@ int ccu_gate_enable(struct clk *clk)
 {
 	struct ccu_mix *mix = clk_to_ccu_mix(clk);
 	struct ccu_gate_config *gate = &mix->gate;
+	u32 val = gate->inverted ? 0 : gate->mask;
 
-	ccu_update(&mix->common, ctrl, gate->mask, gate->mask);
+	ccu_update(&mix->common, ctrl, gate->mask, val);
 
 	return 0;
 }
diff --git a/drivers/clk/spacemit/clk_mix.h b/drivers/clk/spacemit/clk_mix.h
index 26a12cedd0d..4ac61b55546 100644
--- a/drivers/clk/spacemit/clk_mix.h
+++ b/drivers/clk/spacemit/clk_mix.h
@@ -20,9 +20,11 @@
  *
  * @mask:	Mask to enable the gate. Some clocks may have more than one bit
  *		set in this field.
+ * @inverted:	Enable bit is inverted, 1 - disable clock, 0 - enable clock
  */
 struct ccu_gate_config {
 	u32 mask;
+	bool inverted;
 };
 
 struct ccu_factor_config {
@@ -48,15 +50,17 @@ struct ccu_mix {
 	struct ccu_common common;
 };
 
-#define CCU_GATE_INIT(_mask)		{ .mask = _mask }
+#define CCU_GATE_INIT(_mask)		{ .mask = _mask, .inverted = false }
+#define CCU_GATE_FLAGS_INIT(_mask, _inverted)	\
+	{ .mask = _mask, .inverted = _inverted }
 #define CCU_FACTOR_INIT(_div, _mul)	{ .div = _div, .mul = _mul }
 #define CCU_MUX_INIT(_shift, _width)	{ .shift = _shift, .width = _width }
 #define CCU_DIV_INIT(_shift, _width)	{ .shift = _shift, .width = _width }
 
-#define CCU_GATE_DEFINE(_id, _var, _name, _parent, _reg_ctrl,		\
-			_mask_gate, _flags)				\
+#define CCU_GATE_FLAGS_DEFINE(_id, _var, _name, _parent, _reg_ctrl,	\
+			      _mask_gate, _inverted, _flags)		\
 static struct ccu_mix _var = {						\
-	.gate	= CCU_GATE_INIT(_mask_gate),				\
+	.gate	= CCU_GATE_FLAGS_INIT(_mask_gate, _inverted),		\
 	.common	= {							\
 		.reg_ctrl	= _reg_ctrl,				\
 		CCU_COMMON(_id, _name, _parent, spacemit_gate_init,	\
@@ -64,6 +68,11 @@ static struct ccu_mix _var = {						\
 	}								\
 }
 
+#define CCU_GATE_DEFINE(_id, _var, _name, _parent, _reg_ctrl,		\
+			_mask_gate, _flags)				\
+	CCU_GATE_FLAGS_DEFINE(_id, _var, _name, _parent, _reg_ctrl,	\
+			      _mask_gate, false, _flags)
+
 #define CCU_FACTOR_DEFINE(_id, _var, _name, _parent, _div, _mul)	\
 static struct ccu_mix _var = {						\
 	.factor	= CCU_FACTOR_INIT(_div, _mul),				\

-- 
2.55.0

