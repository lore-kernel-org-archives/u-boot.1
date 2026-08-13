Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BFCC5DF66
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C134814C7;
	Thu, 13 Aug 2026 20:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3qUcYpiap-8M; Thu, 13 Aug 2026 20:18:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4778A814A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786652280;
	bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GEsGHM1FsiZCbeEE85Y9zw5HVIesZgoHcuuocEyosFjpJfB/fOtW8E3tYW+Km6SAo
	 dNRWETTSuZbb1OhFC2UXh5tUAJvLBoOOQguwqy2/31gWegonAVSSCbxbii3JzWCLo0
	 7iyWH75lEsDK1lCOp2U7DFbJhwUGIIAiMImMqeG5mJfdp18nyoSqc0KLRVGV00tQqD
	 tJseQ2UYd5liYftaIdQect9QP//cxKuhAKzTtWVaJASBHLDoEUVF8Y9VFodDXrcQgf
	 T06a/TxZJSB24SME5bm0I6S97ffd3unt2zgwA0c26ZTs++SNXWBG3Cb7QIZUDcFF0s
	 p04YVkw3+kCsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4778A814A0;
	Thu, 13 Aug 2026 20:18:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F39FC3DF
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9CFA80AA2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4srn7J-WR2La for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 19:59:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2F95D80A9F
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F95D80A9F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DvDiM9AK
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F95D80A9F
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:31 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7eb545db3afso280567a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786651171; x=1787255971;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
 b=DvDiM9AKUpjW863aAU8Gf8IqYUGLZQaOuNuLRNTeU6dowYbqENAGdPnVhGNaQANGmw
 t5mCywyP4CNNocC3xqAuFnlEBwYCpAHxZS4NeM1+6IMUaFmp7ymtViShp+IgmgjJjbqR
 rDG24/oNT3ORu0YPpkg3c8XDzxFcpir1sXKPd5GJqrWb74p6rZiLsulezgMVouet3HLt
 9Txa8e+ug2bILkQPyhL20jkCP7+seY0hEwMIpIoLKbWcCvfcbI4GupRsgq+NdviwCeuZ
 tfKKz52KJG1VypXl0nxEQUgAQVe0yK5ngSqyuka5u+tzJ6TTcnLkIZz6wW4QaLiPnAtl
 q8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651171; x=1787255971;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
 b=YslBZYP3jXQdf+SqZNuN+3ksuThdIafz8h5DVhoCP5kE9kE8xf4Momyo9/jxH8zLH8
 NQyms29pspvfKwPY5fhocTrX7HR+WGDFMmZYRpphXc0gqMgBoSTTGStw1kJHZKLNI9Ve
 XDpaCCAC4C/I4qT9tOu2ZXLJGKMKJCxyHg7pGw6hDCJuGcwynuTEJ7bF1STwm3Rl/OOu
 jrFlm6pOPO1KtjstF1C0HKFU5lLGH6GpST92VkkveWcmzXN1oJF5HoCi3+K0eYuuXFGi
 waMlBeZmll6GKxWUNfLWEohR4poqf0iHGsl9l8UIhfiXCgRehld8JkM7pfXC28anlA8s
 NH6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGriJWY1krd7n2vlHzuf6z5hvjlZwPBF11DWtaaE8lYLC6PIygSwX149Mrk7Ux85M/IchsKQQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxBhZOxTjgnb9MX/tJAX/ob3YuUtCCyHn32ckojonFVWsBFM1UW
 tT4emFu65FqvJeCZ/HqAFywvjvkS80YtyJRP1HqABD60tpFvuetVx2+x
X-Gm-Gg: AR+sD12qzdNvodgXWu7ta9wuNsqwfIn7j2txEkS/MBGPsu/0t0eKxMlhElcZHMOg8U9
 lRiN+NBuSxZApZnP7sG+cxxx6VsdsuZcm6j815jA1s77yCPmXEnKjJLtWT86Ve2gcSGyFIETlRQ
 rKiQ96WeM2fW5XxPdf9EMxDr9w9dXyO6rkCydTyCtcXNpOoDJyf2No9v/WLqs1uWxN78xCxFJWV
 DrcdmVc4op7iLqyAyMiJvqtZOTQr34NqtOtoNqOPg3xfuqTWHK74po5oibOEqR/9GdmvrYvFOMc
 o8f01rvfjIINUcp36UkG8EUIwTHiP2xdY02/ay2+NQO76zPUGrkFVpCrZdlkFlrQvZqNg6XvFjc
 0ezm0kySyAAaAYa40jnTnICjsqalt1Rvp3wIY5K0yw03BFa6ccchMKZ2VYizDsNFunEehUwLgxa
 AqGaAbjnk495o1Z3KKgdn9Ny3NTxiPZqn5/CzTDpD/VGEzTKlITV2i5x+IRjxwl+ETelNL0B84f
 Lg7nZDDaJ12ukFE/MdDmPENzH99IJZuRSPcW+z8bwD70rTDEDHrP5u6kvPdCHr3JZse9ubMevio
 LoV/+6IdWBoALszbqOcKx7NcDo+Z6PMWkV/IuUsR08n0spsY13acyH7beisqJLnvs8wlONODyrD
 GaHzELCv2JjHUUMLM
X-Received: by 2002:a05:6820:4ccb:b0:6ac:bafb:bff5 with SMTP id
 006d021491bc7-6b0d613c553mr889049eaf.11.1786651170930; 
 Thu, 13 Aug 2026 12:59:30 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c34sm3345507eaf.6.2026.08.13.12.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:59:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 13 Aug 2026 13:59:04 -0600
Subject: [PATCH v7 11/15] clk: sunxi: add H6/H616 CE gates and reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-submit-ce-series-v2-v7-11-593fcd8479fd@gmail.com>
References: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
In-Reply-To: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
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
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 20:17:42 +0000
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

