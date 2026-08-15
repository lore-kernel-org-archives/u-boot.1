Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659CCC5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15CE240A07;
	Sat, 15 Aug 2026 13:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wc0aJA40GDL9; Sat, 15 Aug 2026 13:01:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EC7A409C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786798899;
	bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ulkn2/G7WnXuzla0tfNcJ93aQmqxIhDf2/53XwmH/17DJkScxvXqSnpf3en4wMM1w
	 CJKCsBYoptKLcAL7ln72mgwG23YA23KpC7yszyZ6MsnWOjuriKsgJFpKQPn95XTUwZ
	 VjJkKSiQYY7P75wxD8sEdMQqBO8PbvyIdl4IIoOKApdLgVpUDRQpicsCfPNYr2Bwzy
	 lXTledlDPolpA6MgejFvRuw/Sud8b3CtZpUuZ5NtmhQrJds48/krdzhwS/MVES7CvV
	 L09RRs3YzVAdKjgNxv1xPYlCameMhvnO4x3NlrPKX9A5zr8nu5TZ85s32i1EkEqR96
	 YgmLgk1Y65h0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EC7A409C3;
	Sat, 15 Aug 2026 13:01:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B4E84194
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A755D4007B
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J30jnsPsdiYj for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 05:49:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8F2B64005A
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F2B64005A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=IWQrSbjp
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F2B64005A
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:49:03 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7f18c0e03e3so881136a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786772942; x=1787377742;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
 b=IWQrSbjpU0tWVhZevSwrHYKBDL5m8AW8LbG0di/16NSGtznjGB4aF4erA9AvWdWkam
 yJeQXviKoOo48x5ZY6juuNbcjx3ikvN5B+NuAnzrFQ26TVVrd87SH5BopMo/DiSY9zlo
 aoRGXBmrPqE3UPN/Cmq3xMxt19l1QZFmYCyXcpbL+wVUnsXFlFJNF/iK2G9a6LFNE9pD
 JNkSpweIxJA3+7U+MMR6L3N2/1b6W0ag47uC3hpykC7lYB0qwCOG2DfhmFddI7o+bt13
 cQ/4St7yVxpBFxV2MBybrXiecIL4xRDrJFjpilUzWDK8Ua27JCHcz3PxPjYTX6Ljzwht
 hanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786772942; x=1787377742;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
 b=Pri9ARY90bexWzlgp6VdWbBTLIxHquQl7k2jspIQnf/3xnIJcVJJa92KOkwn6z+EWi
 yMtVusBV3Z4kgRNQH2pKjBTA9B6G9L0weMk3V217o4gz+mub4lHH6JLK/WlE/tt7utId
 WAtPfsHCpLmFOJ3XzAveFyacEQcRlhiOkT8aG/bfd6aRXkXpEB8a8eFOKopAhLCMsVCM
 CJkwV1sRtg4RT8UHFIfu/ySeqJ3lG7beejxEMgInmwKn+S/AC9HRfoRLK3gjrygfcxDh
 i9i4DRybv+9QkxTGeJnxSIwkKz/jkdwAiCJ3R0V7ssESuhaRNCAUNFIOUIvoYPz87+WA
 bkrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZdHlTBmPrqZrRJh9Hs10IT1cjbNaZkDcTS/YMxyQWJm2SIjj5FoaiF65QNSy7J5cpxz/MgzA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzKryF2LUqSdR/4DrN30EDf4UgtUg2qZ9o4/CMLEL2NR4VtqCGu
 rjdurY+C6Ns2NX9uCwkW6BdXu675cQVF6fgCL1YJbaw6mrpf8XFZ99gI
X-Gm-Gg: AR+sD11UNzMyOg7lDeA8ufY9RjGPXaF82Eezl/ygjZdh+ALvJrx3qzTsMC7cFE5z9y9
 +EK2BNH9OKV2c1Ht+VG7t/OdvAv9rfdpphQcmMdzp2Gbyp7mxN6eaEVNyagnDo2kbv022oVnOW5
 H6iL6ir2eFjcIVulvZ6Qxj5x1tuL8KdKD42Gz2qD02axkTt23ePC7iYd+GR7xKqQgWPKUpnylYz
 x339T5f1sK1YzNrcQeJJpyRXQbnjxRqYEA0Rv33FZ2hPQQBH0Ddh8Xc/l7fSEYdUSVSYlBFo/L7
 8cgdPC6eSzwexgEzgSAgvJtvBg9iHuLolv2u3saOpp/zD3FRrdqANB73/NmWwr9ailOuzUwnuAv
 U46ef+hUzALPynGBfYC1W2ggLEgv2qn5PMRQG/GptCYO40gYAa/lHPj02f3YHawRi4tv2DYvVPm
 LJmiNPhC9wfSDv38H21AIfpj18u6euwcyqOo36v0KfGttyAHIifaHJtm4G1+JTm6JQWvWhRaFOC
 ofYFs5vMjOYOsul2nqXUSMCaFrd+kIMnHQh8GeNqR1YqXhw4mKV3WqO4B/4k6PE8TmvUaMk05nP
 WghYYFb4GrIcOa5erQYm71jdacyYiz1idWCviaQs3Ajss3qsc1N/kDgv64nayptv3Q5p5xy/RDD
 yjZKDnGy8kwfHe/u7
X-Received: by 2002:a05:6830:3748:b0:7e9:e0be:583b with SMTP id
 46e09a7af769-7f3de71d894mr9596913a34.9.1786772942413; 
 Fri, 14 Aug 2026 22:49:02 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86282a6sm2780166a34.18.2026.08.14.22.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 22:49:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 14 Aug 2026 23:48:18 -0600
Subject: [PATCH v8 11/15] clk: sunxi: add H6/H616 CE gates and reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-submit-ce-series-v2-v8-11-fe9212431a94@gmail.com>
References: <20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com>
In-Reply-To: <20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com>
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
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
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
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 15 Aug 2026 13:01:17 +0000
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

