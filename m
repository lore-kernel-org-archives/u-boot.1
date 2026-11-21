Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D320606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RWRIBo4N;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=RwRv/8a2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE56960717;
	Sat, 21 Nov 2026 12:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xksjO2NXKpJ3; Sat, 21 Nov 2026 12:35:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E2D47605B7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264535;
	b=aWK6DKMoPkAh6J+NA88s5O+bGfS4YPePilEUUa0fkyp5dx19gM2oq3AOrNnXoa/7Q9+u
	 5C9+x1LxRVZRhcg+yXiE9BUE4vSCidU0xSukI5VEp2eYqx8wF/XnisYOT8AFMKKPMGd65
	 /zxBopqbULz6v/Ik3AF/VNIjK6YCrIswhyhzyOP4Vgvcu4b7WUswlQstBsMjKdzMeFScB
	 MF8y1a4TjRURqfK3HFimB4BvGH8OAFoSHMObhtWzl6Pl0/ugNX26RMZswTMOMRMgdm+sA
	 eGsJpMQzDmi3yLXAe36h0J5llOeRiV66NzKAY3Vjw9IwTW7K/oivyqdCRYiTyjWzcAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264535;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7lMzTtI6wXUPMkTg/SAat0ADhfH5iXYRKzVc+QavQbc=;
	b=nzmXJMx2AqnspCzV0R3P9c3NIChA0Fy9AWSZlMnsJ3zf/dLDOzu78eViIFY1hqSUtZfo
	 004cWkBvJKWWwg5jqwslXH1wo0KmM/VpSXB/ZRRqE+AIginj8c/wtEPufAsAhFene+lEx
	 W9oyOcm+zcIeK2UmWknz+Fv3y0kNFvga1ydfrV32INuXZjk3jh1lTu0mgryy+XY/ENd0X
	 DBm+jz1i+9hsqnz0LBhFULKd+rKJZjk8gPh9RLnRdSUnPHVu7dYEsg2BpWpVFxZhBq6TJ
	 Vs4jSa5eKOclhJ6c8jQzIwq1IDPT9pbeDzy2dw8XeyPsdDD+Fm2zuDefOT3O6QAF9NQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b="RwRv/8a2";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264535;
	bh=7lMzTtI6wXUPMkTg/SAat0ADhfH5iXYRKzVc+QavQbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RWRIBo4Nc70EP18Q98gLuaR08pxRWFFvXv3NIB0WQmes5nlP/tPd3p0XXt8KL/ePL
	 bLedAJQmoZBHUVqXFX/g46uHozsnhqJjtRbaT4Bsnop0AW5pGug/zPIv29RmR6kVxN
	 /Ez4K4YY5YImsQAqK6GNloHSSSMvsm/7eqB0NkDoe3rog11HOZ+RGk3IQekQnCx/Ad
	 rumsHvZL6xaxZthzUJ06AmY/hS2xqB94apy1NnXKqyma7HsucxLlfe4+ju7q+oLbGO
	 VARQ9CZMik5KmEzzzPoHNPmu157hfx+THiYk/fNl/AEhzqz4C+6bsob1KwNvZZniPK
	 WHzP8Nax+wULg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2D47605B7;
	Sat, 21 Nov 2026 12:35:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F1FB465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 359266065A
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dNo9sBmJOJOh for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA763606D5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=RwRv/8a2
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA763606D5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:26 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1002592f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264525; x=1795869325;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7lMzTtI6wXUPMkTg/SAat0ADhfH5iXYRKzVc+QavQbc=;
 b=RwRv/8a2eR402k3UoithCbtjNtN1d70zpCvCbq70fyvV+ge7/QQ7OH5THZNqJNQxxR
 qZRAbFKBJAJWoV4gv1+Qc414a7aNJx5dSd61TgUfNXrdKJNnOnW5dfvEFO1/c/O2s1Ii
 VAUMm92ostnAgcAB2fBPHAN9ihLmTEhZ91+QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264525; x=1795869325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7lMzTtI6wXUPMkTg/SAat0ADhfH5iXYRKzVc+QavQbc=;
 b=IYUhUoa+Ajy7iWgEq75zYA6qxIp/sfIrmlQAvb/TEpKCCi15JVt3knKjweNhNK/aJb
 x5W5ORwijoB/H1IqeqgevUty3QkN6L8yrXvVixmD7fgE4RvrEpCm2fSuNeXiqjF1QGrC
 qRK6cxXp5poaZkw0uydyADs2jruTCDiYuCcPmZeKWFg9274iIsmyNSX1KCZZi+GNs5US
 4/pnpdCSN02O6tALGwOIragmt3HhVm0dPQbYkT4WCdaXfEcVl8w3KHOsIQoSmEZsbRTx
 0gP/HQsXphpa5zXajZ2cLHx4J4G6DIHsPc4n5cKuRlLS/nny+mx9LmJVITTZcCx+CQGT
 I8bw==
X-Gm-Message-State: APuU4Z+lurS6gen9SJmU367ieuuWMR6UZol5PY4ao7PeM5/EcQHRG5TZ
 8ksejRCgF/b7hhnpZZAwBDujg0JgNQiS8JmumZbz6Nfj1Zc0ZV1YgwWCJ3Kp0UPS2B8BFn2uvgH
 meGSb
X-Gm-Gg: AZFdTZfDlA1btn2FmlZwAdHWlRNjpf/t+TVqaQsTp0Isq14AVS+B5RT9bVl6OxeekLm
 bSjcKm77tM/3Srg+gQfj51GeZw4obyQDidhbfBYmTrkX107n8q3B7uH6KRPk4VFA8fErYcz+drl
 6BPL5vuH3x6mTfKH/R3t9v42YF39GBEhBtWfVA/LSyvSYpxBcZMWtzrRD8yknej8OiRTfTli9vb
 bBJ7z8kIndQw4JaN0RAnYCv2t5LP4NjSl7dwbxaHo7v+xAG+UB4p5COLnNoi+P0Z2SPrmz/UPbb
 umMmb5WyTH+22/f2vqtU5wafE4B0GSRmi5hqmmA6/gPyJhAWtDBXeXGKQfOIXNu+QVy5So5itnI
 Y+qyTrp43FV7VFFTCuL/94YHnu9+6U0yAZwA7lorI6F/hHEY8Z8bGbC7GVs2IiQW3nQNfizJCvb
 nwf44SFIuafjcZ/I3cX8l4V80JEnTsPNnjwCqK/XujwOH1dngZmF5C223XsfU3EviipEGuzePmH
 R+QJgY9yv6VC50nPfGq0OqImsWG2cUhW+nGF9jbKjUosSsDiKrO/g80qHj4DbONfTzAq98v6fYx
 W7TsgBmRCgqrf73qAcOk2u9EnJ4JJ6isIwESBuHmGCQ2L2NDhguVZESVjr8PyNg7+YqMHOyfPP4
 4pOILb80x6206Yeqg6M9RlHdbXmA9t8Rq83+TU9o0BDCgWbV7sLKe9D2bbSK2QZ6jFjqH0C2asn
 +/BIfJ/a+5jITvY7S2mJeLZsE10w==
X-Received: by 2002:a5d:5888:0:b0:492:5ef7:5d98 with SMTP id
 ffacd0b85a97d-4abb6651686mr11642707f8f.38.1795264524660; 
 Sat, 21 Nov 2026 04:35:24 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:24 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Liu Ying <victor.liu@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 15/25] phy: dphy: Correct lpx parameter and its
 derivatives(ta_{get, go, sure})
Date: Sat, 21 Nov 2026 13:34:05 +0100
Message-ID: <20261121123451.2471185-16-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michael Trimarchi <michael@amarulasolutions.com>

Upstream linux commit 3153fa38e38af5.

According to the comment of the function phy_mipi_dphy_get_default_config(),
it uses minimum D-PHY timings based on MIPI D-PHY specification.  They are
derived from the valid ranges specified in Section 6.9, Table 14, Page 41
of the D-PHY specification (v1.2).  The table 14 explicitly mentions that
the minimum T-LPX parameter is 50 nanoseconds and the minimum TA-SURE
parameter is T-LPX nanoseconds.  Likewise, the kernel doc of the 'lpx' and
'ta_sure' members of struct phy_configure_opts_mipi_dphy mentions that
the minimum values are 50000 picoseconds and @lpx picoseconds respectively.
Also, the function phy_mipi_dphy_config_validate() checks if cfg->lpx is
less than 50000 picoseconds and if cfg->ta_sure is less than cfg->lpx,
which hints the same minimum values.

Without this patch, the function phy_mipi_dphy_get_default_config()
wrongly sets cfg->lpx to 60000 picoseconds and cfg->ta_sure to 2 * cfg->lpx.
So, let's correct them to 50000 picoseconds and cfg->lpx respectively.

Note that I've only tested the patch with RM67191 DSI panel on i.MX8mq EVK.
Help is needed to test with other i.MX8mq, Meson and Rockchip platforms,
as I don't have the hardwares.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Link: https://lore.kernel.org/r/20220216071257.1647703-1-victor.liu@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/phy/phy-core-mipi-dphy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
index 727c2b040520..79cab9125002 100644
--- a/drivers/phy/phy-core-mipi-dphy.c
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -64,10 +64,10 @@ static int phy_mipi_dphy_calc_config(unsigned long pixel_clock,
 	cfg->hs_trail = max(4 * 8 * ui, 60000 + 4 * 4 * ui);
 
 	cfg->init = 100;
-	cfg->lpx = 60000;
+	cfg->lpx = 50000;
 	cfg->ta_get = 5 * cfg->lpx;
 	cfg->ta_go = 4 * cfg->lpx;
-	cfg->ta_sure = 2 * cfg->lpx;
+	cfg->ta_sure = cfg->lpx;
 	cfg->wakeup = 1000;
 
 	cfg->hs_clk_rate = hs_clk_rate;
-- 
2.43.0

