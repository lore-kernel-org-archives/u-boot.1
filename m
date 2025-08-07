Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FD6C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 579F18445C;
	Thu,  7 Aug 2025 10:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IdEJzun1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D511483AD5; Thu,  7 Aug 2025 09:45:23 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD07C83A43
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-31ecd1f0e71so894718a91.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754552718; x=1755157518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14BIlsJ2/JKNk9jxM68GYZYyjBOzXEUywhb4O36Cbmo=;
 b=IdEJzun1Y7IX0E/980gCDWgOiIz1jCxs/kpxDPfS/xIUOZa3V337ohwoSvlC5N9t07
 7Pl9LwI7sbtGg2Lb1VEeG+UPbpYl3CZXPXRDyiIdCshp6sLEzPA4XhRyLKzXcA7VI3hm
 jZ/5oId4k9WfBmwF3GPUJpdBLZTaco5bVruDLfCxaxfvvxBhQKVn9on0VULIab8Y6UVv
 qSOhJQKSYKBRz6TGXGiU5peJ9ucmvQfUu9pLYzTBhS4256m6Fm49m3/c874+vkhwYa2A
 fGfyV1oPtNuFylWdPasJpBxS9g4Rqr2at947UBJKoY8jpt2dmKyv713KSPKIWImf6TUQ
 YsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754552718; x=1755157518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14BIlsJ2/JKNk9jxM68GYZYyjBOzXEUywhb4O36Cbmo=;
 b=msHJuJpYwyBHVZlKqqQmgKgOtpFsh+4awUoTB8zVpzU1uDiScR+Uq5KD1SXi3w3ATD
 lo4ZY3o/Gu/5SxM3eIM2yX2TNW6z7eB5W6BS/YulWo+a4qgzLj99JUDStv5LjG1GVekx
 rhuvymhTFCXsyYLuUfELunWEpQw3fYm9tqd4C6Jazw5XXfwqRJ/QtqpIlgSvtowVw+L5
 3rrAKctJVcFeAB2/aBJsjcmKxqhdQkigo+GEOT58UXndPZZSa+C6aCH8sIuq9FFHzGvk
 B26/QxzEsRS1XPkdNEH+BcVz2g0oKQMdARLbKtvg1N1V/zzMJ6pf+SNkYjKOI6RbZfG8
 ddmQ==
X-Gm-Message-State: AOJu0Yz/3ses55k8y13ubr5bhw/IbkDIJklCsMUCb4bLOdRXUcpMzRK+
 Fw/KRPLUZZ4eokkD39zYtdB44DkbkJPczmVY/kuTD5dqLG6Qf/7RiLDApBEGdSp8
X-Gm-Gg: ASbGncu3EAFlnnsMlNvdDr2KDTQB9g5yh7cjw1SImKwubRbft1u4kx16ALAy5c+csLi
 sRuKTWRFE+hVzLAAd4xreLQUFdo1DEc7d1UMg5t9ejyFg3mB/CueAkHy9YBoZiSOMN8t5IsDu9Z
 EWaEKewQqwn/LTrAfjOdXp50EU7CXe8uAzzZ9pesFtZ63lCLkTq086d9yCN0STGEvr1gebIgdBw
 Es/xc7MOJf+UtUprP9bGv/dE67LBw46D2p5m+mnk9tmYSixk6FqvlOI2kepHmrChKrKpSSJRTsC
 s+zGhiMUIfgUXWv4w6ZJuj6jESsji2OF6qBegGf7ByRt8MAJ4tmienPSLgdnIt52GwANkJW4esw
 ZvSezvGETzae7etFV0h2mUBXJPVajwmO3N5S+
X-Google-Smtp-Source: AGHT+IGO0Ty/rjvSBB59hr+o/CFQaFcxou6DSLixcFrWlpG9tZDj8wjSyzAVaOD4HgLlDOHDq0xYvA==
X-Received: by 2002:a17:90b:3e86:b0:31e:c8fc:e62a with SMTP id
 98e67ed59e1d1-32167593e1emr8006363a91.35.1754552718064; 
 Thu, 07 Aug 2025 00:45:18 -0700 (PDT)
Received: from localhost.localdomain ([218.90.41.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-320f4909b8bsm16809202a91.16.2025.08.07.00.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 00:45:17 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, quentin.schulz@cherry.de,
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com,
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, WeiHao Li <cn.liweihao@gmail.com>,
 WeiHao Li <ieiao@outlook.com>
Subject: [PATCH 01/10] clk: rockchip: rk3368: fix gmac clock error
Date: Thu,  7 Aug 2025 15:44:09 +0800
Message-Id: <20250807074419.336752-2-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807074419.336752-1-cn.liweihao@gmail.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Aug 2025 10:26:22 +0200
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

Signed-off-by: WeiHao Li <ieiao@outlook.com>
---
 drivers/clk/rockchip/clk_rk3368.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 630253fbb1..6691801384 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -329,11 +329,9 @@ static ulong rk3368_gmac_set_clk(struct rk3368_cru *cru, ulong set_rate)
 		ulong pll_rate;
 		u8 div;
 
-		if (((con >> GMAC_PLL_SHIFT) & GMAC_PLL_MASK) ==
-		    GMAC_PLL_SELECT_GENERAL)
+		if ((con & GMAC_PLL_MASK) == GMAC_PLL_SELECT_GENERAL)
 			pll_rate = GPLL_HZ;
-		else if (((con >> GMAC_PLL_SHIFT) & GMAC_PLL_MASK) ==
-			 GMAC_PLL_SELECT_CODEC)
+		else if ((con & GMAC_PLL_MASK) == GMAC_PLL_SELECT_CODEC)
 			pll_rate = CPLL_HZ;
 		else
 			/* CPLL is not set */
-- 
2.39.5

