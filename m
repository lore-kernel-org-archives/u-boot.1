Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAB7C8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 08:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942CC8354B;
	Fri, 29 Aug 2025 10:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dz+ePdCB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E4288359F; Fri, 29 Aug 2025 10:30:34 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4CE83542
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 10:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-55f4410f7c9so2207911e87.2
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 01:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756456231; x=1757061031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OhljXPWmoAimwu/ZhLGIMgSyBN8AZtMJAGJ0BGIxG3I=;
 b=dz+ePdCBNv+MpFJJo1deSiL8VVxK/yPSz4ollHLVHgpQtmPnLZxD8wyeQv/hXmIOXB
 BoOFPkLr9JmbielsJoMTAHkUlmrimvoq5w/z0U9/cjRIdjaBEzbQlZEvTyRSC4SzjZxV
 S/BIHnv1GI6DdCrvWhLbcBXpGyFcLHKGm2ba3O/pHQExoF/Aj1QvwYkoBQFTbRm4eXQA
 MHE922cdDjGFvukXBui2KNoB2w0EnShuI+wDAze53aXTad51Bn4WYJb06s3eLtZ7/IOl
 MJUffDRsUwUdu9S/fOf0jjeTOjLAa8YTSw41kbWh+EqxUYV3oDNCOkc1AT0FTTyUs7Yt
 UNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756456231; x=1757061031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OhljXPWmoAimwu/ZhLGIMgSyBN8AZtMJAGJ0BGIxG3I=;
 b=ARGcnVc0tCHqTO3ydlOlx1v0C6GTBGzbQ7f2ixWYRLobXtum1ylDJlk4OzUcqEH88s
 E/B+gia8prwavSwqu3IAgRYizdQt909ZPBXFoSTGulFfEMJDJJ3P6sX+8Vy76OwyZkIr
 TnrqQED4FBJ53HwgNderchLUKXlUXOaNnMos98NRC9GkptncV881amDcofZlMxjJ+XPo
 IATIkuMxwrMLaLDc21bPxEt2T+NXoXhO81uXl+zUo12tKgQ8Bt9tFkP+wOuQvTG6aX7m
 yaDP1lOGDQEZIOVV8sF1ZqA6CettWtd5S8lSWoJtbQIVIExiE5FBirRB4ZL/w+3htaaq
 45ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe1Qac/7ZafF0AtiPepvCar/Q34MK8AXOcQe+3x41kUI4Uhfz59Ys2FlXWQvFP1hWqd+mvwm8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1+yXnZnW7WuK05W/7xpeBqd+E7c5Wu5QtkSuAjPFGTHkhjErD
 ptYmQm3YXj+RmDaTq/WsCU1p6TM2rtxhW1s4sWcoNznCFOL8gdSvDCbE
X-Gm-Gg: ASbGncsNSRlEWKFtwgH5+KfDsbsE1fuurMS9HhSuYfEvCwJ6Ys17Q+IEzmcrMaXlhlz
 gPO+7857mRNHYVDnk8/X218TsgrZ1G9kh4paK/yqTTy05DgUyiAKswFmBCgQWUkeTg59WGSdhyz
 f4NAGtdHzp8R8/a+l1MtXKdaMuNa49kB8dsZ1D7lBgKS738XiBJretoIsOMJz2RcuWM3IqDC4HS
 5pReZ5pE/piH3ttDOmiJw/Rbz1Y99fEJaS8kfBdpBiZloSp735LpHOmVcVNAq0s1dUwBu1+T3w+
 rl1PofdZK5RbXS21197FfS3C1Teao0c3997i18BHVvAG7w0ZerUUXmqSZLU1Lb7cHUU/+6qJ4kW
 be6Gw7doNlPVadHPySPyJQ2rJ48q6yOA8AMmDtL++xVsBQ1Oh9MuIhJoSOg==
X-Google-Smtp-Source: AGHT+IG3YnW/rMypZlaiiMmlbMvuVZ02jyaNyDHAXhq+C8KozjIK8lSfWh/cYoOTgDrM93LP7XHLtQ==
X-Received: by 2002:a05:6512:6509:b0:55f:53bd:b137 with SMTP id
 2adb3069b0e04-55f53bdb50bmr3100720e87.31.1756456230990; 
 Fri, 29 Aug 2025 01:30:30 -0700 (PDT)
Received: from wpc.yadro.com (host-95-152-52-178.dsl.sura.ru. [95.152.52.178])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f678451dasm451262e87.81.2025.08.29.01.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:30:30 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Marek Vasut <marex@denx.de>,
 Maxim Kochetkov <m.kochetkov@yadro.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Subject: [PATCH v1] clk: Only enable the parent clock if the clock was enabled
 before reparenting
Date: Fri, 29 Aug 2025 11:25:00 +0300
Message-ID: <20250829082628.623597-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.48.1
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

From: Maksim Kiselev <bigunclemax@gmail.com>

The current implementation of clk_set_parent() unconditionally enables
the new parent clock, even if the target clock was not previously enabled.

To avoid this implicit behavior, this patch adds a check for whether
the target clock has been enabled before parent enabling..

Fixes: ac30d90f336 ("clk: Ensure the parent clocks are enabled while reparenting")
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/clk/clk-uclass.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 4f35b90382f..0f6bf3e02ed 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -631,10 +631,12 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!ops->set_parent)
 		return -ENOSYS;
 
-	ret = clk_enable(parent);
-	if (ret && ret != -ENOSYS) {
-		printf("Cannot enable parent %s\n", parent->dev->name);
-		return ret;
+	if (clk->enable_count) {
+		ret = clk_enable(parent);
+		if (ret && ret != -ENOSYS) {
+			printf("Cannot enable parent %s\n", parent->dev->name);
+			return ret;
+		}
 	}
 
 	ret = ops->set_parent(clk, parent);
-- 
2.48.1

