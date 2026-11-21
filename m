Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC7606A333
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=roaTT/cQ;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=TWNVqynC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB44F40E84;
	Sat, 21 Nov 2026 12:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sUWuWAG3Y3Gz; Sat, 21 Nov 2026 12:35:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1079040E22
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264539;
	b=C7rpPecXtf76dAruGMCHJIctbbIq4w1AwNmu3lrqIvBYfPRnuEFMvGgaf10vO6ar7/QO
	 gNghT6lE7yJz8at7UIrJx/sx8gavR/h9BRwfXN/ANllKNVt/2j8GHYnXvpj1hazCbCpAw
	 +OfEU3dz8c+Qr23JqiiQkOnM8m27x/pHCGJpqKGgBqjTJcFEEMZwnwMEHIN4VavVWKmkh
	 J3WZ3yhL0R3thU91gKA9wFq426r/GK4QtaYY9y9oZ7fE5YJ5kUiDUJBQMyZd2Fe5lRGQs
	 n4gOJUH3xhRF5AyhQVU0d06TTh3Dq8ivaPpJ6MdXmcXM87Tx2ykkZnyz4JH26UPjJ0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264539;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=u0n+YNFcmMyOeqNS629GEoFYUxyDiF7wnnMtBbUZqLM=;
	b=RyYGpHQTNfXqVu625T6fjGY8tfLbuANa5rHnH4UhE+oe6OODqwh3muRBPYBrABswExOz
	 fLAj5u9BUSKTnyZCGWh+zSCR6xQ6J/vi9xpRlwHKNV8SxHRTwgWmDRVhazWdJfqxFLSyV
	 fsEXiIEdf80/ynctZmMoTcRNOJPoQOFFuQVK0Mm6vUWxrkBB0tUfDjekSjutTmyRSKa7G
	 jQS3ij8wslHuOl5VxLd7wDPz9htHXRWANAd8tK0xQCvDJyZMQAz0qEtE9BfqErEZ2p46t
	 6ao29/1NHTSF8+R18ZA27Ef5STmFRTHlcrjlFuO9fYYh3XVWyw7haBVOHt9BgU4tbWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264539;
	bh=u0n+YNFcmMyOeqNS629GEoFYUxyDiF7wnnMtBbUZqLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=roaTT/cQXSNi9a9ZAVoqnMLfm44wDq2PWk40NgoEBd0rFPRH4L7iITIukOg2muiEu
	 Y2QQ/UZrGnW+dwsJ6C6KiIwRsYYp8XsLuQCV5uYljlT183OSgAmIHGR0NJoisoB/Ep
	 xnNxSo6Byn2Kz5mdaF2n3vCeC0f8qOjKiHDR5s0cX1fESpETGUmer9rwJAy4YJghri
	 w/quFye1zIyqMmd+zjGx3PgrdHwvx+eOC1Ze8j2tcuGN2QS2IWi2WAdN3fpRWZVU0K
	 70VNZuzTRfECO+7kAc2qXevrIh+wHc5TiH0s6eNF8Kc0HVnbbU4YQYDCHI2/YQWaWH
	 7nwhChQodjqCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1079040E22;
	Sat, 21 Nov 2026 12:35:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 653C03A8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4BA1760697
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fx4wrkF1f4SO for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 173CB6071E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=TWNVqynC
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 173CB6071E
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:28 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1002602f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264527; x=1795869327;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u0n+YNFcmMyOeqNS629GEoFYUxyDiF7wnnMtBbUZqLM=;
 b=TWNVqynC9H0aUAEsWnr/DsADfCajbB06hjtrSrsHm8fG3N8r0WURSTB9kNn5g1nHHU
 0nGtpLE3IT+ifJ39nckUy1DQMqq0v4xNtKKPqXhpOzwIryRfpziOiCdX7GDKAPIP2JKV
 BeA23O8HKKdlnUZr8uocLQRcIzbZtbUXlSH80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264527; x=1795869327;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u0n+YNFcmMyOeqNS629GEoFYUxyDiF7wnnMtBbUZqLM=;
 b=UZ4x1KoS7giWA/Boz3rmyK8IlVtIIapPyRs7Tk5j4OjCzcRbW03AcUGyK7ggW4eZL2
 dZYy5HFQfmy50UsWXHdL1iLegHD31g9/rWiekVvr5BJna9C/GyTX69JfSA7iFB08iloE
 4YnFT3Od4RXh7WGfoPr6G9YStjoFC4I2x7919EdriS1/rL+Czh4qWrn8Q2egBSNL9LYZ
 PffRY4OPoio9tzMeHbo7ORv43BELtevTikJdL27Od3uyvBk6V7x8TiRE+Jyviy3rGukv
 yJJ1mYaEATNy8kTrRW4y7lkUAcbEDqZJUdR/ICueZe50fvZ9CcD239OGYmcbuSiG3aZS
 cEbw==
X-Gm-Message-State: APuU4Z8iZacchl2x3C1cAUzJVGYndj7TlsU/4rK4qdKM7uiDuwYL2fqO
 zFyHioKcJWNwFD7hvjcORiouH2HAaP8Kdz7EWuDAFE867BVv/3WKOYSZGMlE97i2ZgKFl2ayKK4
 Mv9sT
X-Gm-Gg: AZFdTZfOwkUL+4LygvnojgFXj/kfqN4BhsKuzJ81rqH9k7v3MOYlTOYS5ZFUdA9JxQt
 YaX7nn8xzJD2dLtitflV36yEYXYF6P22ciT/j5PpB+dLnYY4Xgwtzq7+W/kyPSDFNoqSstB3Sf8
 JCmSfrjyGo7SWGCfnhioJ+RbCy/DLv2pEOEwxhUKlnCEDL0mm8g05o7SkiEOlIriP7/Z3/UzB+G
 4/fSiqtgPdkRfmF4L6mPGvMcxTDm+q6BGwKku/mTpPiY+hIHjiBu0O300GWMAtJM7VkTYDgG6U4
 x08V3r2dygX7Qdulmd2RKGXoT5GQpz8cUoWyxBx9XiAKHi+n5zoBxS7SJMkuN7qo7T9uML/JbQk
 eF5fTXQMJmt4/blIOijJTSJpcOYriMil5gAVBGLOcC31BO2VyBhA3j5k26RrzO9yUFhO4hoUIGg
 wVzyA+U9MpOv6OO4pEdw3lh89BOs+33sKyxHoW1c97qR1Z6wYMLzCsJKmXD60yDFvUmNcH7grLj
 L4rMmLhTTfq6JD0UJg1Ft4YRMsP1yRjLLNPOSC7dzyG8kA9REB7b7uWba1As/kKXm3yPeHHs3Kr
 Crb56JgVpD2DGqfk+fGyrJqDPQBnawwKJkkClxU5jpNyHSCLDWTPgxrfDraNaW37WpWD7iIfdMc
 WQpJDJqUE6g+89dDWXRK08siH5LdjXN4wkXLM4OUSFgNKMIYdzpM5WDXCLs5TpCuAOITMTSGu9+
 8/UB1T2L7AQuQm/+HR44WIug7YOA==
X-Received: by 2002:a05:6000:2385:b0:497:9e2a:b1e with SMTP id
 ffacd0b85a97d-4abb36787a4mr13966065f8f.9.1795264526668; 
 Sat, 21 Nov 2026 04:35:26 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:26 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Vinod Koul <vkoul@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io
Subject: [PATCH v2 16/25] phy: dphy: Correct clk_pre parameter
Date: Sat, 21 Nov 2026 13:34:06 +0100
Message-ID: <20261121123451.2471185-17-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michael Trimarchi <michael@amarulasolutions.com>

Upstream linux commit 9a8406ba1a9a29.

The D-PHY specification (v1.2) explicitly mentions that the T-CLK-PRE
parameter's unit is Unit Interval(UI) and the minimum value is 8.  Also,
kernel doc of the 'clk_pre' member of struct phy_configure_opts_mipi_dphy
mentions that it should be in UI.  However, the dphy core driver wrongly
sets 'clk_pre' to 8000, which seems to hint that it's in picoseconds.

So, let's fix the dphy core driver to correctly reflect the T-CLK-PRE
parameter's minimum value according to the D-PHY specification.

I'm assuming that all impacted custom drivers shall program values in
TxByteClkHS cycles into hardware for the T-CLK-PRE parameter.  The D-PHY
specification mentions that the frequency of TxByteClkHS is exactly 1/8
the High-Speed(HS) bit rate(each HS bit consumes one UI).  So, relevant
custom driver code is changed to program those values as
DIV_ROUND_UP(cfg->clk_pre, BITS_PER_BYTE), then.

Note that I've only tested the patch with RM67191 DSI panel on i.MX8mq EVK.
Help is needed to test with other i.MX8mq, Meson and Rockchip platforms,
as I don't have the hardwares.

Tested-by: Liu Ying <victor.liu@nxp.com> # RM67191 DSI panel on i.MX8mq EVK
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com> # for phy-meson-axg-mipi-dphy.c
Tested-by: Neil Armstrong <narmstrong@baylibre.com> # for phy-meson-axg-mipi-dphy.c
Tested-by: Guido Günther <agx@sigxcpu.org> # Librem 5 (imx8mq) with it's rather picky panel
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Link: https://lore.kernel.org/r/20220124024007.1465018-1-victor.liu@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/phy/meson-axg-mipi-dphy.c | 2 +-
 drivers/phy/phy-core-mipi-dphy.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/meson-axg-mipi-dphy.c b/drivers/phy/meson-axg-mipi-dphy.c
index 3f89de19970b..fb10ccca6ac1 100644
--- a/drivers/phy/meson-axg-mipi-dphy.c
+++ b/drivers/phy/meson-axg-mipi-dphy.c
@@ -237,7 +237,7 @@ static int phy_meson_axg_mipi_dphy_power_on(struct phy *phy)
 		     (DIV_ROUND_UP(priv->config.clk_zero, temp) << 16) |
 		     (DIV_ROUND_UP(priv->config.clk_prepare, temp) << 24));
 	regmap_write(priv->regmap, MIPI_DSI_CLK_TIM1,
-		     DIV_ROUND_UP(priv->config.clk_pre, temp));
+		     DIV_ROUND_UP(priv->config.clk_pre, BITS_PER_BYTE));
 
 	regmap_write(priv->regmap, MIPI_DSI_HS_TIM,
 		     DIV_ROUND_UP(priv->config.hs_exit, temp) |
diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
index 79cab9125002..27cff85709d9 100644
--- a/drivers/phy/phy-core-mipi-dphy.c
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -36,7 +36,7 @@ static int phy_mipi_dphy_calc_config(unsigned long pixel_clock,
 
 	cfg->clk_miss = 0;
 	cfg->clk_post = 60000 + 52 * ui;
-	cfg->clk_pre = 8000;
+	cfg->clk_pre = 8;
 	cfg->clk_prepare = 38000;
 	cfg->clk_settle = 95000;
 	cfg->clk_term_en = 0;
-- 
2.43.0

