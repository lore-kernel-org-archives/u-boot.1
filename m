Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90475C282D0
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 19:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B16811AC;
	Fri, 28 Feb 2025 19:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Krion8T/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D88681115; Fri, 28 Feb 2025 19:59:55 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39457810F5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 19:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so2166351276.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 10:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740769191; x=1741373991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAjS3+NRr4BDUQM7eeLUOczBIjzFSW8htKbSCCoMPwM=;
 b=Krion8T/WYhMskmx3b/BH4lAZ3qqoXsXiS/We8AmPKeAsZEHStjQletbSIcBEsG6JC
 oTZgLMCWwn8f3+gxyfdoSUb76EVEfJvdhecA5+ZAtcKRlRGBVNgvnh3wKIP5Svlx91VS
 qHDpb7ydjBKVvyqB7eGAkT3tflKSauOwu99lni2WZ40JM8XNYCx8BjM6+RrhrCRAYIHs
 yDGG67S8cjW64uSfUPY9kmLT2RslGX3GyUdBsuwkZh7I5vg/GPLxyLEvT97sDlfmncU3
 UjPgTAlEeWA7MyqgBd2qt7QF8Hu+9wN9Pa9gC7xwNRx4amd10+1gfVsEv88WBwaar58U
 MnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740769191; x=1741373991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SAjS3+NRr4BDUQM7eeLUOczBIjzFSW8htKbSCCoMPwM=;
 b=eFQxynaAPSkGwJqVvjPAfV+GIZdI7ePIjrsdlZC+LYYVZMDUD2xWm/AbyQ+mlQ52AY
 XPoUgjGgGSUFWRFSdK6aEyk1ow/L2aV/aNVIQUesYywNQyA5XUhyyAF/1zOUEuE8lx1J
 209CPbSmdGpO1zTzWktyH1z6dzssRd25od0YfKz0ajYmiOhdcVkea8QnfyQLmCKS8BBZ
 FjjTXBQrD0WTol7low15Jv0NTpJGMaoiz+T1q5KlvxYBBTDsUTnrikhZvtYkvWRD5jq9
 HzseuaJ0+NM+xjMC8wyr9mTnclwL9MEc5qrVHJJElTc8+3ZDrR/3ghJzhYK9dCTsxsa5
 WJ8w==
X-Gm-Message-State: AOJu0Ywf4iJFF3s+jX0e91R9AN+mMn3esXRDfEsbUePMR4+ZEeooU7qq
 2vJTmRRX82L7CbaUaGSxugFTi7plFz2mc564+0vOMtKmGR35IP9wsv1h
X-Gm-Gg: ASbGnctd2KUBMiqFvNvZStHzN4Q1IAMPPTXF/VcdPT/4IQRTpNvkB9OiM/0SBo9HgcY
 +cV1rN/DY6qmKlRNQOzfhIH24UnonqVIxzyiVLxWeFYi7WKJDaz/XhYWIWR7zpX4A2osQcCwzXh
 heoA+VOMbtIL2+d2hsK+qzAMyMW1o20qzM7BMsWCK1oXYICedQ39jWqGnjgl0ELGvBpB3OwpShT
 gT27PZmHnxlPsB0YQfyFLyzxpxHqj76XqeMSuD9Knf3/K9EsshG43a9IfEyi4kyUnk3Odfyk0eG
 qQ4d4PzNC83kfrGMlRXjyagdzwTUfDondpQilCTWWQ==
X-Google-Smtp-Source: AGHT+IEDPuMzlZ41jcoUfClZep8zDhYAtuwXsnIoNEEtkF30HzKWN5qQ/96vLT36t5D3XgQQsHiKbg==
X-Received: by 2002:a05:6902:1085:b0:e5b:2472:f4dc with SMTP id
 3f1490d57ef6-e60b2ed1c1amr5692528276.29.1740769191254; 
 Fri, 28 Feb 2025 10:59:51 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3a41ab9sm1257976276.27.2025.02.28.10.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 10:59:50 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, adsp-linux@analog.com
Subject: [PATCH 2/2] arm: mach-sc5xx: Remove inappropriate board-specific
 functions
Date: Fri, 28 Feb 2025 13:58:34 -0500
Message-ID: <20250228185837.25741-2-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250228185837.25741-1-malysagreg@gmail.com>
References: <20250228185837.25741-1-malysagreg@gmail.com>
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

The sc5xx machine code includes implementations of board_init and
board_early_init_f which should not be included in the base soc support
code, as they should be implemented by a board where necessary.

This removes the default empty implementations of both from mach-sc5xx.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

 arch/arm/mach-sc5xx/soc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-sc5xx/soc.c b/arch/arm/mach-sc5xx/soc.c
index 9bf7c314e01..8f13127a660 100644
--- a/arch/arm/mach-sc5xx/soc.c
+++ b/arch/arm/mach-sc5xx/soc.c
@@ -172,16 +172,6 @@ void fixup_dp83867_phy(struct phy_device *phydev)
 		phy_write(phydev, MDIO_DEVAD_NONE, 0, 0x3100);
 }
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
-int board_init(void)
-{
-	return 0;
-}
-
 int dram_init(void)
 {
 	gd->ram_size = CFG_SYS_SDRAM_SIZE;
-- 
2.45.2

