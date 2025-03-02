Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B27C282D1
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C63481276;
	Sun,  2 Mar 2025 17:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bXN/AXZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F386E811A7; Sun,  2 Mar 2025 17:53:58 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BAA581298
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d0465a8d34so36332495ab.0
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 08:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740934405; x=1741539205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oc9Um/RvHPRMAO0dp4f7x0ocMtxF2CW9/LHB5Ar9Sfg=;
 b=bXN/AXZYHU3yNRTWPsC7aC+dx0WXL7biGn+H2r3kvTAqNVAMN1k2PlA6KRlKI4OpBa
 L81tQSRUDJNWlol2eiHBlqDSJQYnelOQOM9uq6jZlbZMzpvP0ceJSqIHstGM109OtWEK
 Pc9sFPl6/X5hxaR7RqDpCfpzJcuBH36epi+ze/YxnlJ75whoRHGiCZB+vQdOHNz6tOqB
 5JfMxldmDmPibd0KEcR4wyrqhF90DYcmA5pc2+83+Teoy8JEu0+nBSuU3sqbck/GXFqi
 mFxUltFbESWbQ8pJQxIHXYCtssxRqSBlxoC0Zys3AWBVMTNen17805c4LHoW5c9DG9Yp
 RQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740934405; x=1741539205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oc9Um/RvHPRMAO0dp4f7x0ocMtxF2CW9/LHB5Ar9Sfg=;
 b=i9avEdIgPDKyqZpzJzvYDIPso0sE5ECpuLZmIu4zaA1Tra1CaJsNhnKq2/SmHgigA2
 8KmPKh+1tFKaboOr71Dat9ubI13ZeaR/+pvQiLg5DF52BH3MXInG3y0jMoE4HN0tKl8W
 Dwi/69qs65KNay0xUBzhqIuGcaWySIGjLDTIoULwcCBPrJojA5Jr/CyChVO9bByxJtmR
 LhV2IejNJZecQk3faW4tpXQUXa5qdyq0WTW9t8z03PWr79bTApXHsdYI6BG75WgnwGj1
 5MMLS+94Zkhph+KTwS6oMggwT3pp3XZh6+eXpb3rSY72CcwkB1XwFK9D/A9PhHCU2Uow
 rNyg==
X-Gm-Message-State: AOJu0Yz4FVfos3g2IhYRyCw8574B/z9j85XxhIdRt18kZ9ESGBJoLS6z
 jyFc1y2pt7BtRDHvP/9lYY7JcE5k6ca4I23Khi7s16GJe2VJuILk4tw5Yg==
X-Gm-Gg: ASbGncvD9xoPr7oL5ZIPH8mNxhR6L8lI+8lb8j6GhXGhIurBnhGG1KOEtnGs6eubr/5
 fIhKFs/DBdYGfN5q5supH+Sm5EPmBJZb/S47rTbmCW2dMTPzIbsZFqhikZONiGKMY5cdl5EcrM2
 XOsFaqM1gpZ/R4+PU6iE09+NpN+J92FbwpvpIFiyvps+Q6DtY5LpISJyvNqAhFD+X5NZ+67wTsK
 /Bhenpn+vOiYTtDurVBTOdp0XQIyXQKTEUYUOXz7ikdDbALy4zMxYU7OwnIrSundss7hvoNeUMf
 V3KEsIhplZEl9t3DUWb+xJLAUmjJzfgSfr41p9FxURvAixPL5RuMVSC3wIqne+PO4ff6dDi9B32
 pFbAfRiD1T8d5OiXVEpU=
X-Google-Smtp-Source: AGHT+IGmGxyVMW7jE/nGHCJD1b2ClPHyQZFNnL+rFCldmJ8Un7pe5I4fCN6WLuCsHtaE19sinI/g8A==
X-Received: by 2002:a05:6e02:b28:b0:3d3:d00c:3602 with SMTP id
 e9e14a558f8ab-3d3e6e73f08mr99626725ab.10.1740934405376; 
 Sun, 02 Mar 2025 08:53:25 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f07e1310bbsm982714173.9.2025.03.02.08.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 08:53:24 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 10/10] board: beacon: imx8mp: Let clock system enable UART
 clock
Date: Sun,  2 Mar 2025 10:52:37 -0600
Message-ID: <20250302165249.267992-11-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250302165249.267992-1-aford173@gmail.com>
References: <20250302165249.267992-1-aford173@gmail.com>
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

Now that the UART driver can enable the required clocks, remove
the hard-coded clock enable.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 board/beacon/imx8mp/spl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/beacon/imx8mp/spl.c b/board/beacon/imx8mp/spl.c
index 30d577f7e0e..6b357d90a3f 100644
--- a/board/beacon/imx8mp/spl.c
+++ b/board/beacon/imx8mp/spl.c
@@ -112,8 +112,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	init_uart_clk(1);
-
 	ret = spl_early_init();
 	if (ret) {
 		debug("spl_init() failed: %d\n", ret);
-- 
2.45.2

