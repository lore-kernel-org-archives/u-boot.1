Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E0CC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 16:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1014F80737;
	Fri, 17 Jan 2025 17:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A9P52Z0Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318DB80717; Fri, 17 Jan 2025 17:37:55 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B5508036F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 17:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6dd1b895541so51419736d6.0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737131871; x=1737736671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jvmESUlxSHA21/WMXtbVBpVxA8EAKPavsYPjYgxvLvA=;
 b=A9P52Z0YrKuDcbaDmhpbVpFhbmkHtl78NcN3vcvrehdhmsl7h/dwZHSjicR0LVfzJI
 twOMLRQi0k+nO5Htj3zuzYWfthxAqWvHfJRno08WWQRCoJboYSSWAXcB59aK9oaCVcW5
 iL8a25WCBFK+XuflhlFN114ryoCjre2Ct3ntct7bKDKOt5ExdOQ22g2L3dhqxDPOPdwx
 xJ5Ay4OG6SQSYgi/pwFVKXk8KHN6GjtCi70aYhTS1jOkks4OVqJc/jJ0OTZy1puN6kDk
 Ix3wJ/iHjwknBY+46wPPL0TpGPp3Frr50fQt4VQoa6TPjFntea1HCfxkXBJ0VzBY75Tw
 pfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737131871; x=1737736671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jvmESUlxSHA21/WMXtbVBpVxA8EAKPavsYPjYgxvLvA=;
 b=AGNzLFzvB3v69yKrE6qGC44HxHeOITYoXk495/sgWs1lQ8qyCwNcwsG7w8b6fEPhcg
 eFYPVpz/cwXus+ndmMP3R/NBilp0Yjpo8L5Cx6dczfz8B+0j/DZayYEcKsVoYu02nMSg
 nXdGMyj6uLTu1E0XTvpYtMG+CZVDsaqz+wCUtUwQyacqgrkiHur0LDhe+SXJKklvSKMA
 ibD7DIiiY+Gvq9e+832ESVUKiDDvpGzPzQ5Mg3EsLI6v0BdaItuYmgPuxqPxxEsuEVGR
 pPtVfkar6QGO71WxGWdF8qb9W+bEk5CuHRe+LAyKl3ltyy2fAkNrceP8Tmn3H5q3nnjl
 CBlw==
X-Gm-Message-State: AOJu0YzPeC8mvO0cjFZ3Ag45WmKb6C+8xRk3JMGHvzWrYsSeQUahC1VK
 HBQ7hoYQg1ZYP7i++TDsOaZIceDw+9+1aVR3PLFISHZZQOb/7Ar6KggAvA==
X-Gm-Gg: ASbGncsBvVJjq/H86tcSRUD8xc4RFSicElFHoqITKSdBDSECtsEQPL/ukSpqjjbKosm
 nlFD7Sv9lw4EvCi6Sr0U48VNc/mLycPD5LK3/Ar4/jFvRAi55Bscok1lW1c9snS7wf6dFET8aDZ
 B0xOPz4Cnm7hiI3svB9ZSexg+fubGke8/5zgiRM4pd9jb1MRkEw/0HHMDHNYKIYd2I1UcyKnVFa
 p7jEuSzCJpiJR0lpcAXMn7rrHEFJPHKnNJyvdpHxZ+JUHgXscJT7iFqtVNHMh2yfn/x/A7PWz72
 g6xBEtj1G5bpOPd1uuHTLZpxdWLzpE+ARhk7Mw==
X-Google-Smtp-Source: AGHT+IF18MSgXN+UmcqyipBKNHzQeiy0yrqyirCGdJLGfdP9ubOIDJIGbc+fcBisSPbTRQelFN6n0g==
X-Received: by 2002:a05:6214:5b81:b0:6d8:9dad:e14b with SMTP id
 6a1803df08f44-6e1b2178768mr54160586d6.13.1737131871650; 
 Fri, 17 Jan 2025 08:37:51 -0800 (PST)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net.
 [108.26.179.17]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcd388asm12770356d6.92.2025.01.17.08.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 08:37:51 -0800 (PST)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Jesse Taube <Mr.Bossman075@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 1/2] ARM: dts: imxrt1050: Fix clocks for mmc
Date: Fri, 17 Jan 2025 11:37:49 -0500
Message-ID: <20250117163750.3918082-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.45.2
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

One of the usdhc1 controller's clocks should be IMXRT1050_CLK_AHB_PODF not
IMXRT1050_CLK_OSC.

Fixes: 1c4f01be3490 ("ARM: dts: imx: Add i.MXRT1050-EVK support")
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>

[ upstream commit: 5f122030061db3e5d2bddd9cf5c583deaa6c54ff ]

(cherry picked from commit 37ab64667e47adcfaaffc8264218fb5cc8a99a3e)
---
V1 -> V2:
 - New patch
---
 dts/upstream/src/arm/nxp/imx/imxrt1050.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm/nxp/imx/imxrt1050.dtsi b/dts/upstream/src/arm/nxp/imx/imxrt1050.dtsi
index dd714d235d5..b0bad0d1ba3 100644
--- a/dts/upstream/src/arm/nxp/imx/imxrt1050.dtsi
+++ b/dts/upstream/src/arm/nxp/imx/imxrt1050.dtsi
@@ -87,7 +87,7 @@
 			reg = <0x402c0000 0x4000>;
 			interrupts = <110>;
 			clocks = <&clks IMXRT1050_CLK_IPG_PDOF>,
-				<&clks IMXRT1050_CLK_OSC>,
+				<&clks IMXRT1050_CLK_AHB_PODF>,
 				<&clks IMXRT1050_CLK_USDHC1>;
 			clock-names = "ipg", "ahb", "per";
 			bus-width = <4>;
-- 
2.45.2

