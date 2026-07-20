Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EE0C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C994406F4;
	Mon, 20 Jul 2026 18:10:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GwvGDR5xoXkI; Mon, 20 Jul 2026 18:10:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1275040702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571039;
	bh=3ZMP5mony9BNcF83cuLiACntos9AEkOO1poFvGtoC28=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LuWegX+kQgrgE0W6M2SIFfdUwco7DYgQKWV2yBwb7cqqmkL05+CdzJMYxYLLUKMzk
	 UZL+ftv1K1awDsx+UxOe8vLKzeEF79YaBDVIbmskldx/rEHnay0VCLRVSZiQva1nZE
	 NI3NwkDJvphF3Jk2t9nINX2Z35j+w3akLLhueZdLls8PCVjxVhM4U6mcnl87+WvrOO
	 xwNO4qnwgTr4xif3ScySL+oRj49CACFaHum3zflbrqa7giLdYn0Zed1Omy9m4gFCWG
	 vsYs+x8MIYaKB2VMiEk63qgyJU3dOoZvhG4lKomYQCD0pYKDec8xkm2UiInA0PsB37
	 EqTxqUP2QLBKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1275040702;
	Mon, 20 Jul 2026 18:10:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B18EA1DC1
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A374880BFF
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lg0oY2Na6vSA for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7431D80BFA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7431D80BFA
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7431D80BFA
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C8F284A30; Mon, 20 Jul 2026 18:41:44 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 466A28484A
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:42 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so19282825e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565702; x=1785170502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ZMP5mony9BNcF83cuLiACntos9AEkOO1poFvGtoC28=;
 b=fXSsgmttM5bOxoN1PK0LEzlESnAdNNcA0+nwC9N2ZrQGmIc8WkEK48ZOcB58HCC475
 flzX5jLnimLcH3Mvz93HCDd01AXBS3ENE+sslvCPEsV46yl7DdciYqiU+B07ciS5rxXh
 SD4UcmNvWbIlKOFmgFzMpw2YZo7Z2hVPMcwvxOhZiMjcx5ESH6X55Dfhc4pSgGiwkgcR
 dJXW8dLT5Y6vzpcsCCU55Impok/E9Zj7p4V5DC4tgueHW3XuWHGRUn76LQ7aWy4B4w7o
 9jsxJ7Vbg3Sox1QNJ1tIg4ibr01Onq56BVWOcOlR3a/k70NZLvpRR8xPmzAxn760SFwU
 3FAA==
X-Gm-Message-State: AOJu0YzyFbQcBdVxyzrnsxnTzlg55KW/WjcIhAVjRftylX8zO8uKoLkq
 8naHvi0sFUemgstHU5Agb1afUUwhlN5X5wNfilANjyWfnngCkAW3Ognu1JGp7BTQ57U=
X-Gm-Gg: AfdE7cmfLD3c0Oby24S6Ws2sekfHWdHruYMyoXOt32cTX6Y6+KcJBUCGBishwRmmgcf
 LDSTN6QH/CllHxhPEKoE5pRdK4GZVjgDclGSXcrJSEjVh5z2rAWwKsgAeNoLIOeyI4LE4bchdcI
 8WL3GjeT85zuM42y5A4Cev6BuipjtV1bNg+mSBZchdEjFpPQ864lzCZo7pHzh4i1xyoSepFZQ5D
 gCfcdaAa0tzbTLTxoCHDLxnNub1XplFE94Atxh9mxTuhMrUMTH9Db93nRmJuzNTCBOqsvpO//fy
 nD6MMOlgowzkK0HhyRITvdWLTteBR0N+rAv8UgZv31Hu+Ymw89cYP3uBkSHWyA0DjpSuV6VkPB5
 nkSUMQ5HHLDL48l7nqdeVuT+RRUjcbyB4Mzaxwf55cy22vNsc9caXLBVVup75qBt0nkoMUur2eA
 5FZuDxPE2ItDg/e9GtD6bDA6N/JMYrPA==
X-Received: by 2002:a05:600c:19cc:b0:493:b877:fbc with SMTP id
 5b1f17b1804b1-4954a402fcdmr193365345e9.21.1784565701626; 
 Mon, 20 Jul 2026 09:41:41 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:40 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:48 +0100
Subject: [PATCH 21/36] clk/ccf: add CCF_FULL port of clk_sandbox
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-21-8fece1b0333d@linaro.org>
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Paul Barker <paul@pbarker.dev>, 
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, 
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7715;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=/XlDaFrFyDbEpNZcmkFUz2LM/gDSB8ZsD8soz7Gz0bY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+EYmKP1tXmFKYf0LJAlHVQ3q5VCWMYOtoAP
 RQUKfMuyX6JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PhAAKCRAFgzErGV9k
 th3FD/0Yj/DhZ9BOoF/YbmjaavviATEpuUJiVo6uBTZLZH7pTZqGdGZxvX2bMyJgrIwl2hpBvJe
 UysltnPfSOa+fxxQtplrdb71ldcYKfy6ryeN00ivAy3pAZF8xEn3cUXQbb8jjezCUw65OxFVqgL
 BAMvgr1LgBFrcrp4wBlnTwS7Hqz7+xt0MDH7OvhypYTsIzBb9sOjhJs85UNMOyj4DC2idjl+IW/
 GWc+vKhff25y02mXHl+vp2vq4PZrqL3R3HCfkvtCZFt70IM2bwbysQvi65uh2Zw4c6HxH+A5r46
 gJACp9TKCYOA7XNff4T4CGcbBzrxRgr27vlI1rpy2p58lFMdU91rtjNX6lsWR9f+S1d71vqkcfO
 3N0ZhoUeXZpIrfEPUevVSysZAzr88RGtqybuZwgAZOIE47UzgvWgR1izpkArDRPaAmrF1Asq2WW
 lu4PGYCHeiQGcWJO8Esd1ucyd3g3y1Ff4RMgB6LjnEQGSm/pEP9BXypvquretCfs/f5alGGkzgd
 c1Cz9lP1/k7IsYKj3Re8Kh6qa1tBT7tk9NVc9RI6VCbwsxUvpUmHxVYG76ABhhWYT1SB0ZKScgr
 4WfiX1axh22LYpJecc3km8l+ji/zVgGdYHkcK1IW6qLC+4jNOIJETPK/wHZFS1qxXT8VrJ2YX2I
 zknxUPDLMiwFv8Q==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565702; x=1785170502; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3ZMP5mony9BNcF83cuLiACntos9AEkOO1poFvGtoC28=;
 b=QNXpZHMq9nMz2LtsELc5tq15NJrldTEV6jXsfp42xG0Th01+NpoN83Kz/8FQ/fySXV
 PpmmlhLF0kdZcU/1VeqNTmzqY74RFeXyxLeevjT7BkXZZz1cYbPD0Xx1cz4DOW0A1T8e
 B3hiLAWCZn/J2URC6v3G1Hs/9c1BANBKTrdG3ZpYdQU2ne50U2jWYYobpvBR1ZnqJu7Y
 oDi3mXVCIKmhRGOZQm31VV0MPDkFI8R0uPT4p/8IIAcVaJ3TxbFjZmFVtfMoFmuL5F1B
 TSAYwB6AQ3cwcunvZCY4lD1rTitmzB4Xm83Zv0iWuMPO58imqPEbY7osK85SLMyiPpK5
 HrDQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=QNXpZHMq
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="QNXpZHMq"; 
 dkim-atps=neutral
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
From: Casey Connolly via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Casey Connolly <casey.connolly@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

It isn't possible to reuse UCLASS_CLK drivers with full CCF, so
introduce a full CCF port of clk_sandbox. This behaves the same and is
used by the generic clk tests when CCF_FULL is enabled.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/ccf/Makefile      |   1 +
 drivers/clk/ccf/clk_sandbox.c | 281 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 282 insertions(+)

diff --git a/drivers/clk/ccf/Makefile b/drivers/clk/ccf/Makefile
index 2d319eb24fff..aa97c74066ec 100644
--- a/drivers/clk/ccf/Makefile
+++ b/drivers/clk/ccf/Makefile
@@ -15,4 +15,5 @@ obj-y += clk.o \
 
 obj-$(CONFIG_CLK_COMPOSITE_CCF) += clk-composite.o
 
 obj-$(CONFIG_SANDBOX_CLK_CCF) += clk_sandbox_ccf_full.o
+obj-$(CONFIG_SANDBOX) += clk_sandbox.o
diff --git a/drivers/clk/ccf/clk_sandbox.c b/drivers/clk/ccf/clk_sandbox.c
new file mode 100644
index 000000000000..57cc0fc07649
--- /dev/null
+++ b/drivers/clk/ccf/clk_sandbox.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2015 Google, Inc
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/devres.h>
+#include <errno.h>
+#include <malloc.h>
+#include <asm/clk.h>
+#include <linux/clk-provider.h>
+
+struct sandbox_clk_hw {
+	struct clk_hw hw;
+	enum sandbox_clk_id id;
+};
+
+static ulong sandbox_clk_recalc_rate(struct clk_hw *hw, ulong parent_rate)
+{
+	struct sandbox_clk_hw *shw = container_of(hw, struct sandbox_clk_hw, hw);
+	struct sandbox_clk_priv *priv = dev_get_priv(hw->clk->dev);
+	ulong id = shw->id;
+
+	if (!priv->probed)
+		return -ENODEV;
+
+	if (id >= SANDBOX_CLK_ID_COUNT)
+		return -EINVAL;
+
+	return priv->rate[id];
+}
+
+static long sandbox_clk_round_rate(struct clk_hw *hw, ulong rate, ulong *parent_rate)
+{
+	struct sandbox_clk_hw *shw = container_of(hw, struct sandbox_clk_hw, hw);
+	struct sandbox_clk_priv *priv = dev_get_priv(hw->clk->dev);
+	ulong id = shw->id;
+
+	if (!priv->probed)
+		return -ENODEV;
+
+	if (id >= SANDBOX_CLK_ID_COUNT)
+		return -EINVAL;
+
+	if (!rate)
+		return -EINVAL;
+
+	return rate;
+}
+
+static int sandbox_clk_set_rate(struct clk_hw *hw, ulong rate, ulong parent_rate)
+{
+	struct sandbox_clk_hw *shw = container_of(hw, struct sandbox_clk_hw, hw);
+	struct sandbox_clk_priv *priv = dev_get_priv(hw->clk->dev);
+	ulong old_rate;
+	ulong id = shw->id;
+
+	if (!priv->probed)
+		return -ENODEV;
+
+	if (id >= SANDBOX_CLK_ID_COUNT)
+		return -EINVAL;
+
+	if (!rate)
+		return -EINVAL;
+
+	old_rate = priv->rate[id];
+	priv->rate[id] = rate;
+
+	return 0;
+}
+
+static int sandbox_clk_enable(struct clk_hw *hw)
+{
+	struct sandbox_clk_hw *shw = container_of(hw, struct sandbox_clk_hw, hw);
+	struct sandbox_clk_priv *priv = dev_get_priv(hw->clk->dev);
+	ulong id = shw->id;
+
+	if (!priv->probed)
+		return -ENODEV;
+
+	if (id >= SANDBOX_CLK_ID_COUNT)
+		return -EINVAL;
+
+	priv->enabled[id] = true;
+
+	return 0;
+}
+
+static void sandbox_clk_disable(struct clk_hw *hw)
+{
+	struct sandbox_clk_hw *shw = container_of(hw, struct sandbox_clk_hw, hw);
+	struct sandbox_clk_priv *priv = dev_get_priv(hw->clk->dev);
+	ulong id = shw->id;
+
+	if (!priv->probed)
+		return;
+
+	if (id >= SANDBOX_CLK_ID_COUNT)
+		return;
+
+	priv->enabled[id] = false;
+}
+
+static int sandbox_clk_request(struct clk_hw *hw)
+{
+	struct sandbox_clk_hw *shw = container_of(hw, struct sandbox_clk_hw, hw);
+	struct sandbox_clk_priv *priv = dev_get_priv(hw->clk->dev);
+	ulong id = shw->id;
+
+	if (id >= SANDBOX_CLK_ID_COUNT)
+		return -EINVAL;
+
+	priv->requested[id] = true;
+	return 0;
+}
+
+static struct clk_ops sandbox_clk_ops = {
+	.round_rate	= sandbox_clk_round_rate,
+	.recalc_rate	= sandbox_clk_recalc_rate,
+	.set_rate	= sandbox_clk_set_rate,
+	.enable		= sandbox_clk_enable,
+	.disable	= sandbox_clk_disable,
+	.init		= sandbox_clk_request,
+};
+
+static struct sandbox_clk_hw sandbox_clk_hws[SANDBOX_CLK_ID_COUNT] = {
+	{
+		.hw.init = &(struct clk_init_data) {
+			.name = "spi",
+			.ops = &sandbox_clk_ops,
+		},
+		.id = SANDBOX_CLK_ID_SPI,
+	},
+	{
+		.hw.init = &(struct clk_init_data) {
+			.name = "i2c",
+			.ops = &sandbox_clk_ops,
+		},
+		.id = SANDBOX_CLK_ID_I2C,
+	},
+	{
+		.hw.init = &(struct clk_init_data) {
+			.name = "uart1",
+			.ops = &sandbox_clk_ops,
+		},
+		.id = SANDBOX_CLK_ID_UART1,
+	},
+	{
+		.hw.init = &(struct clk_init_data) {
+			.name = "uart2",
+			.ops = &sandbox_clk_ops,
+		},
+		.id = SANDBOX_CLK_ID_UART2,
+	},
+	{
+		.hw.init = &(struct clk_init_data) {
+			.name = "bus",
+			.ops = &sandbox_clk_ops,
+		},
+		.id = SANDBOX_CLK_ID_BUS,
+	},
+};
+
+struct clk_hw *sbox_get_hw(struct ofnode_phandle_args *clkspec, void *data)
+{
+	struct sandbox_clk_hw *shws = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= SANDBOX_CLK_ID_COUNT) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &shws[idx].hw;
+}
+
+static int sandbox_clk_probe(struct udevice *dev)
+{
+	struct sandbox_clk_priv *priv = dev_get_priv(dev);
+	struct sandbox_clk_hw *shws;
+	int ret;
+
+	/* We can't re-use the struct clk_hw since it will be modified. This driver may be probed multiple times. */
+	shws = devm_kcalloc(dev, SANDBOX_CLK_ID_COUNT, sizeof(struct sandbox_clk_hw), GFP_KERNEL);
+	if (!shws)
+		return -ENOMEM;
+
+	priv->probed = true;
+
+	for (int i = 0; i < SANDBOX_CLK_ID_COUNT; i++) {
+		memcpy(&shws[i], &sandbox_clk_hws[i], sizeof(struct sandbox_clk_hw));
+		ret = devm_clk_hw_register(dev, &shws[i].hw);
+		if (ret)
+			return ret;
+	}
+
+	return devm_of_clk_add_hw_provider(dev, sbox_get_hw, shws);
+}
+
+static const struct udevice_id sandbox_clk_ids[] = {
+	{ .compatible = "sandbox,clk" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_clk) = {
+	.name		= "sandbox_clk",
+	.id		= UCLASS_NOP,
+	.of_match	= sandbox_clk_ids,
+	.probe		= sandbox_clk_probe,
+	.priv_auto	= sizeof(struct sandbox_clk_priv),
+};
+
+ulong sandbox_clk_query_rate(struct udevice *dev, int id)
+{
+	struct sandbox_clk_priv *priv = dev_get_priv(dev);
+
+	if (id < 0 || id >= SANDBOX_CLK_ID_COUNT)
+		return -EINVAL;
+
+	return priv->rate[id];
+}
+
+int sandbox_clk_query_enable(struct udevice *dev, int id)
+{
+	struct sandbox_clk_priv *priv = dev_get_priv(dev);
+
+	if (id < 0 || id >= SANDBOX_CLK_ID_COUNT)
+		return -EINVAL;
+
+	return priv->enabled[id];
+}
+
+int sandbox_clk_query_requested(struct udevice *dev, int id)
+{
+	struct sandbox_clk_priv *priv = dev_get_priv(dev);
+
+	if (id < 0 || id >= SANDBOX_CLK_ID_COUNT)
+		return -EINVAL;
+	return priv->requested[id];
+}
+
+static int clk_fixed_rate_probe(struct udevice *dev)
+{
+	ofnode node = dev_ofnode(dev);
+	const char *clk_name;
+	struct clk_hw *hw;
+	u32 rate = 0;
+	int ret;
+
+	ofnode_read_u32(node, "clock-frequency", &rate);
+
+	clk_name = ofnode_read_string(node, "clock-output-names");
+	if (!clk_name)
+		clk_name = ofnode_get_name(node);
+
+	hw = clk_hw_register_fixed_rate(dev, clk_name, NULL, 0, rate);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
+	if (ret) {
+		clk_hw_unregister_fixed_rate(hw);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id sandbox_clk_fixed_rate_match[] = {
+	{ .compatible = "sandbox,fixed-clock" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(sandbox_fixed_clock) = {
+	.name = "sandbox_fixed_clock",
+	.id = UCLASS_NOP,
+	.of_match = sandbox_clk_fixed_rate_match,
+	.probe = clk_fixed_rate_probe,
+};

-- 
2.55.0

