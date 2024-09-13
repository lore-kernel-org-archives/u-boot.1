Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC13FA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F157688C70;
	Fri, 13 Sep 2024 11:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rCtjsyOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A531C88D90; Fri, 13 Sep 2024 11:57:26 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77E2988C4C
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d3cde1103so257391866b.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221438; x=1726826238;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUQmvYAOCNrD+j4utYa3bxEavO03hv/rn6c6e2GiH8Y=;
 b=rCtjsyOMU1K/sHoZoBfbnYOL6OAZga0B5Y9Gu9nGgRN0NhXURIvl7UFq2QFiNugLDq
 /TqmDgqbHqg8mwpDT1IMBFOue4wCsMo2QKhSos0ZeUGuXzLi8DTfoWfbXoJY+A3T4SKO
 6NkSCTheXXdIVpG8I6uJZ457YqC+yvfjWkJGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221438; x=1726826238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUQmvYAOCNrD+j4utYa3bxEavO03hv/rn6c6e2GiH8Y=;
 b=kDNMbCwqykCXy5Z2agiopbtril47FqAd44wGdpWL/FNUqLhEzSU2qyOi3lKBNeseVp
 6KVBXu6vGeK4s1z+OQf6gr4HQb7jGdPDBuegK6avhyHM3ynaH61VU2Wwv895t/xzHeCH
 fqICxxS7jQ6vvPoK2GYy0K0YMhvf6ExGm38Ulc6DD28GQfJP8IhkYiAhJcZUZx8hwQ1H
 m7XVSL4S9GSsGbopN+ILyBhUEyvWxJbPSCROToOh3hjnh7AapbvSXlbPbmfwAepczJot
 xBGz+2i9hFCn3Ab2QUKt+nfSLsh4N4ODlF0T1/Y0Fre31Qnl26YHohnro4JGg+6YTYgU
 ABJQ==
X-Gm-Message-State: AOJu0Ywjgnr5NxzVXkS19SFC5MyZva4MpwLzby1/BKZ/t5AwDO4l76+n
 3OOtwknCxGFTxIWHkSYfVoKpBpM5oWDLmpIqPyd+CZO819RCqc1CVP23QvHzBKqhWU1k6QIrc+f
 WDAA=
X-Google-Smtp-Source: AGHT+IElzwcDH6874Ae/dOu2b3L2NPNfm2/5BA7YdymC59P0O7k3E5LVacb9Fk3F9iiRN/EJTDnvjg==
X-Received: by 2002:a17:907:c7c4:b0:a86:7021:1368 with SMTP id
 a640c23a62f3a-a9029434ca4mr601307066b.21.1726221437507; 
 Fri, 13 Sep 2024 02:57:17 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:17 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Liu Ying <victor.liu@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/26] phy: dphy: Correct lpx parameter and its
 derivatives(ta_{get, go, sure})
Date: Fri, 13 Sep 2024 11:55:57 +0200
Message-ID: <20240913095622.72377-16-dario.binacchi@amarulasolutions.com>
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

