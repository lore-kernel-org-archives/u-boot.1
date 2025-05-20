Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67409C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 09:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0E6A82A8D;
	Tue, 20 May 2025 11:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MVCdYPQR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D703B82AE1; Tue, 20 May 2025 11:02:47 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97710829F5
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 11:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a37a243388so464219f8f.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747731765; x=1748336565;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ti8KIcuVjpz9FJ6CVRJXyW122eEb+93+vha66oT1hdw=;
 b=MVCdYPQR1BhNQ2zzc4YZY/Oey1DZ3Lh2EtTvVDFqi0SgKoNpvjvncNhXzFa6qmz8TA
 AKEB6nn+VHy6wYf/3GW2yvlrVsA7KWrg5xkQzBXbI6DXWgpWU782J4R5es9mz8ZkDRyU
 wEZ8NbI8KLvjrv65TMl60XNvMGUfeL37N1beg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747731765; x=1748336565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ti8KIcuVjpz9FJ6CVRJXyW122eEb+93+vha66oT1hdw=;
 b=Wb7a+ap/WgpUPyctm38RHeoLDa1Sa49WogJQ8S1HWJwWLykvZvBB/hkXtUCuHh7yw8
 8yTi5Ma5sdG5KeJb5D20Sv6AZrbra7fUVEiCy7ILbvCyzGhvcZQCmsgtAxBl9qjuYdqj
 2cmwqPRd7O2WxobFyvOBFMoqMooOFABkKiKgKxb11ZK+Aw74W1Zm2eDMxq9dFK03AB9L
 86UgdLo+s4SN+odVdVhDpXUP/YVbJnkPLnMy2fNu+Tz2GmlVwa5jWHmAwdmCRl4+dxls
 Z+vN2F0/uYq3E+YVQd8wAb89xAmRoSFv/9G65ZFP6FYMqmKUs82M+gfk2Tp38XVFA7Kf
 AiEQ==
X-Gm-Message-State: AOJu0YzzoIRlkq1tEPuaMMtrsnhh2QOuM36wkhpHVr2pgKxsMDabQe4h
 KRkU9LBL1DpfDq2BuaIYyDMTSf7cKg0oDpqcyP5Ys8gE52xOyS9GW9sX96aO2dsDaPiWkRU3Jl2
 sVnom
X-Gm-Gg: ASbGncufCW1PLQvRHnklV9vOTjcg2OO8m4gB4zSfl6FtT/jvk0Z2cTmM6OYyw8vcCWu
 e1MMZ9agz0Q10Bz8y+Rc+/7O3bInUJky1f0QmwestQYyKFea8L6KQYisw5RDj8+nKzf5ErT8+dA
 MLAOjTRNnNnsMzj8uRzLk1gP3CiMFQ8Ex+dg/0PR5nmGXqZRHwAUgCo5T2JCm/2VUTUaqf0bl1G
 yznjtZEV9sc2wUyZLmRM4SoK2+vbqVgUezO3b0B5Ld8Yip3o4UyxCfTZpRI+jWHXF7zb1L38KSV
 4tlx7nydk8+/qP/oyxNMdE8FBmI2Ffhc1KJKz7iz4fh0VTgvLcAgBgQcPyJpmB0DEHetYEZvdB5
 9Rvs43h2LI+mYfeJQ+5RePE+zMQ==
X-Google-Smtp-Source: AGHT+IH3D3Cu+bttYFZnExBNOg5KIOkMyxvFA1F3eQdEe3LvRhy76B9PjYUv8yrG8sTcjYlXgJtOCA==
X-Received: by 2002:a05:6000:1883:b0:3a0:7d39:c23f with SMTP id
 ffacd0b85a97d-3a35c821990mr12469792f8f.21.1747731764805; 
 Tue, 20 May 2025 02:02:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca62910sm15994707f8f.50.2025.05.20.02.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 02:02:44 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: freescale: imx8mn_evk: let clock system enable UART
 clock
Date: Tue, 20 May 2025 11:02:15 +0200
Message-ID: <20250520090241.926812-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

Now that the UART driver can enable the required clocks, remove
the hard-coded clock enable.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 board/freescale/imx8mn_evk/spl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/freescale/imx8mn_evk/spl.c b/board/freescale/imx8mn_evk/spl.c
index 231b9289eead..f96f5c45789a 100644
--- a/board/freescale/imx8mn_evk/spl.c
+++ b/board/freescale/imx8mn_evk/spl.c
@@ -115,8 +115,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	init_uart_clk(1);
-
 	timer_init();
 
 	/* Clear the BSS. */
-- 
2.43.0

base-commit: eeb5ff1a468b2303efa9deb2483b5edbebb568c6
branch: imx8mn_evk-drop-init_uart_clk
