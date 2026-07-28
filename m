Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80B1C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 794F2607D7;
	Wed, 29 Jul 2026 04:55:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YnrzWnsNV6Sk; Wed, 29 Jul 2026 04:55:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC56460AB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300947;
	bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0o5U0u0b6udW7plHmD81sFCPTYMJq19PEUymCngPS9/SbdFea9dwxdwFcQktqNZ5z
	 u7fFZlNKVpW/y3sN4ryoJnnlZlBPpZqNNGPSDZx5AJIijT4iAIljlWcY3DutKvwXDD
	 uUGDofwFPJWxfzOJuwOc3o6M5q2Tqzty1YgmVreGFWYb8Uky/T62iZLjr/6xz7KAkw
	 1jsGc/D541D8H6ys9+NFezKLVnzQbL++RpyECaZw+il3T4rs06dTpk8wb3nzhnR9ZB
	 yX6Yt2YGZzAZbU9bjFRdreQM9buBZRsv4a7UfwTcjR3Dk7YqVl18bkWq35iuqVt9TL
	 Kfw8bSPQgC1kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC56460AB3;
	Wed, 29 Jul 2026 04:55:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1540C26C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F03B4608C3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ComXCyqxg5KE for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:44:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E7AFD608A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7AFD608A8
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7AFD608A8
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:12 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb64085c45so123894a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785260652; x=1785865452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
 b=l8KosuBF9KQEWEa0RCBB2YaNEt6GoMaHRPaaswmaeEqtSpQGnkAwUNWMVaPKTeWQ6K
 o7yPaRllUlhXUrT5L1ZOskTTHfQWFQjWBt78ZMlN6EDQqCf1NOcHwbxp5bVnfUhqtcn6
 aiLZt4zcgtNvkJoIgDJbj11gsQplxC22IdE++BcFrYD6QpwD149TAIcKSEDH3YnFw82M
 3gF5kk9TjdvMEuQf8ycIuMq4+AWn8uWohTSA66cMaDdrh5GGSzSVJd5oKXwXe6TMMe07
 qyee1BW+tXva4nz4i8c9PgGMMdOcH0HmazeSKliUUjJedhqU936LpV/gmyaMZuq4+5os
 /LNA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpppw+oEn+cnl64o+/1vyM9IZX91p3w/VyCiz73wyjNkOucpAfB0mFiJ3i+PeRJP/C6pbpEfYU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzITW83hQJfIJ81I0D8vuWlrt7CCKkbVwY9jIg3IZ6A+i8VeHVU
 W9BQj1BTpx8UYPL6u7vHiBDG+kWJ/qkjDUECcCNkatj3Vl1DkpD4FjgA
X-Gm-Gg: AR+sD10/0aOq44LeHuVyMNpVJUTgMvme0v+Imfk9y/11vcP71FbAMVNnjeJyN1w5Ejc
 3LKxBk5jSM7R7wgVr70vKeGyZasSV+u3G1EtxXKfLvvF/pZBxH+7msGIq3V5Uy/wnBUmvfwzVmK
 VSKdtddw8CPrnot8IF509wHfi1hbkgyDmGLOryTA6ruFcSlS0qBl1n+TBVsmt0QW1y8ZCDSs20m
 vZXTvjoztYzbYDbCbqYKgAXvlEkji4dKoyb/OWOeF3DXeau3KjfDHdoUif47yDI5YJbnIHREU4i
 aVjpG8emYOnPqvnCyOaXqgmZWLUMABXW2f5UiSgPqoWCYD3lE4HQ4FY0NH8ax/Zc64mH0nIuQvN
 Sfi7c2ySGX4liRT3kZx7mHwS9yxGOicpGzXTUsiIH0RNn7cTqEO5H7/DQXWEcSgwdc9PnCCQ8iW
 1dRYeql2688CL1UrruJq+dJ2+Pv16liJDb8Bck4Z9EX6ih/qGxyjzT08OOtFZ4Gz9SqYbQ44bHN
 zsz5xuB7hjqBZJ9mEJpEXLVj2CvAJMDu3l/X93xJHsk/6g0NIOX8pYI
X-Received: by 2002:a05:6830:8389:b0:7e6:cfd0:42de with SMTP id
 46e09a7af769-7efff247f64mr1817308a34.15.1785260651812; 
 Tue, 28 Jul 2026 10:44:11 -0700 (PDT)
Received: from [127.0.1.1] (71-218-31-69.hlrn.qwest.net. [71.218.31.69])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d94389dsm271103a34.21.2026.07.28.10.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:44:11 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 28 Jul 2026 11:41:52 -0600
Subject: [PATCH v6 09/13] clk: sunxi: add H6/H616 CE gates and reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-submit-ce-series-v2-v6-9-80c1f7daffa5@gmail.com>
References: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
In-Reply-To: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785260652; x=1785865452;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
 b=Ji8Vmjh2clkC4tudLw2ax3dhPzKthzf171j5yIv5DHD0Lz1+5Qo/IpAVybh6maqaiT
 Qzh5pUs31BOXK4PIV966ydgJ1FaxwxkdJ3XOP4xWgJ1SLZXQLKifuCiztVV/CTz5+Hdv
 kvva6y69WCa/vTPEkpUUCPHhsWchsJ9+QczbF2UUC87ReBb0VryAIko9KCjgq4tjF6ww
 DVo0rLbxkfr4D1mGnguDmEVXxhnPfSh4Erp3W3IOW+fvGr1dxxkbksqrgEDuj3zdlNlz
 EjfnLx3eYxNmv0idLAhtZn4QDkjdNRJzhtuz3cf+JZBfxA+ZwnoQGVSx1ZO0qauYxPsA
 FWPQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Ji8Vmjh2
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The H6 and H616 devicetrees describe the Crypto Engine with module, bus
and MBUS clocks plus a bus reset. Add the corresponding gate and reset
entries so drivers can enable the CE through the normal clock and reset
uclasses in U-Boot proper.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Add Simon's Reviewed-by tag
---
 drivers/clk/sunxi/clk_h6.c   | 5 +++++
 drivers/clk/sunxi/clk_h616.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/sunxi/clk_h6.c b/drivers/clk/sunxi/clk_h6.c
index 81deb5728e5..27ed5705a14 100644
--- a/drivers/clk/sunxi/clk_h6.c
+++ b/drivers/clk/sunxi/clk_h6.c
@@ -20,6 +20,10 @@ static struct ccu_clk_gate h6_gates[] = {
 	[CLK_DE]		= GATE(0x600, BIT(31)),
 	[CLK_BUS_DE]		= GATE(0x60c, BIT(0)),
 
+	[CLK_CE]		= GATE(0x680, BIT(31)),
+	[CLK_BUS_CE]		= GATE(0x68c, BIT(0)),
+
+	[CLK_MBUS_CE]		= GATE(0x804, BIT(2)),
 	[CLK_MBUS_NAND]		= GATE(0x804, BIT(5)),
 
 	[CLK_NAND0]		= GATE(0x810, BIT(31)),
@@ -77,6 +81,7 @@ static struct ccu_clk_gate h6_gates[] = {
 
 static struct ccu_reset h6_resets[] = {
 	[RST_BUS_DE]		= RESET(0x60c, BIT(16)),
+	[RST_BUS_CE]		= RESET(0x68c, BIT(16)),
 	[RST_BUS_NAND]		= RESET(0x82c, BIT(16)),
 
 	[RST_BUS_MMC0]		= RESET(0x84c, BIT(16)),
diff --git a/drivers/clk/sunxi/clk_h616.c b/drivers/clk/sunxi/clk_h616.c
index 3e7eea25bfe..d5b659d0bb2 100644
--- a/drivers/clk/sunxi/clk_h616.c
+++ b/drivers/clk/sunxi/clk_h616.c
@@ -19,6 +19,10 @@ static struct ccu_clk_gate h616_gates[] = {
 	[CLK_DE]		= GATE(0x600, BIT(31)),
 	[CLK_BUS_DE]		= GATE(0x60c, BIT(0)),
 
+	[CLK_CE]		= GATE(0x680, BIT(31)),
+	[CLK_BUS_CE]		= GATE(0x68c, BIT(0)),
+
+	[CLK_MBUS_CE]		= GATE(0x804, BIT(2)),
 	[CLK_MBUS_NAND]		= GATE(0x804, BIT(5)),
 
 	[CLK_NAND0]		= GATE(0x810, BIT(31)),
@@ -86,6 +90,7 @@ static struct ccu_clk_gate h616_gates[] = {
 
 static struct ccu_reset h616_resets[] = {
 	[RST_BUS_DE]		= RESET(0x60c, BIT(16)),
+	[RST_BUS_CE]		= RESET(0x68c, BIT(16)),
 	[RST_BUS_NAND]		= RESET(0x82c, BIT(16)),
 
 	[RST_BUS_MMC0]		= RESET(0x84c, BIT(16)),

-- 
2.53.0

