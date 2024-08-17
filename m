Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDC9C5320E
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 19:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6655881BA;
	Sat, 17 Aug 2024 21:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e48U7nLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C7D8888A0; Sat, 17 Aug 2024 21:13:23 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45CBE8811A
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 21:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d3badec49eso337599a91.1
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723922000; x=1724526800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vmDi0t5pJsZYeSzLmEReXFi7/DtHSW9T9Cf3mhRXZhU=;
 b=e48U7nLUIfiHtPPw4zz4UMO16QSLwvlsZ760pQVGeuGXnZRqmLN0QzoDSDmeW4Gasm
 N7TrD3jIVBFXeBlmQw6ysK+4CFst087WfRsRCdaZSgAzWAMlQfHjcMhS3A390X+e4wlk
 CPZROlG0hW6MV0ynYsFA+fFOayY3CpmhKqYMC1DpqZX+dT1SKA4kfSJ2kdlGSOqusYSp
 CaetRzk6B6HzpdGcUKUh1DFyalh4iXcIrF+9nSR/doLgofsDT1+bYer0VPG2LpVenqfb
 +GqhV7INQHJdLJcIUCqc4AFA+83v1YfHAvOzuYkg03VhbDutvS2zSqmCNlhKKQdWkWJd
 3Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723922000; x=1724526800;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vmDi0t5pJsZYeSzLmEReXFi7/DtHSW9T9Cf3mhRXZhU=;
 b=SBennouOa/zjTCy/7HBLfGhxBKIIr6I2khssXqsLWVTj1bK9YI0Hw6Hfd5310Qp3DQ
 GmLzhN+EVh5fdwFNhZ8aVzSa4LCvBi4rFgWAr5nUHc38HdYXmowamhSNsuXUweX28fvO
 sMpkpgQW+UO9AQiiTiCgr1baW2byFvIl281YcLqlMzues0gRs/XF+VN6k+kNyUzhcAoy
 Piart3NQ/FNMmpIbH1x8DiAbRfS/41cRdZ0aKoINqWZySKzM8Ozxpjf9lZMFJAfyvDtY
 6k3ynsJ1eny4Mh7XYny2Nfee/qSo5T7BzhqP24P2Sl1wPUMlcdaTsuxVOGQYw6dZs45T
 n4Pg==
X-Gm-Message-State: AOJu0YxGrMF3bszqjbMXjtYdgFis7B83fP455t1sxoJX3ar/GWAgAKFx
 ETkp+Ftu5MB3uF4xZdIxhoU72Z+GG3kIK52nmq/zBtPbxjU41vzSEfqLdQ==
X-Google-Smtp-Source: AGHT+IEHpL9cwwrkcCRWwyaSEB0NCk9tbjBqApMwOg0k9OrxU10QUfb1b+D1FskjoEoULCdeUh4kUA==
X-Received: by 2002:a05:6a20:12cb:b0:1c6:ae03:65f7 with SMTP id
 adf61e73a8af0-1c905045d52mr5852824637.5.1723921999685; 
 Sat, 17 Aug 2024 12:13:19 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3659:f640:ab44:3603])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6b61a6e93sm5034223a12.3.2024.08.17.12.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Aug 2024 12:13:18 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] mx6: Expand bmode to support ecspi3 boot
Date: Sat, 17 Aug 2024 16:13:13 -0300
Message-Id: <20240817191313.844479-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Currently, the bmode command only supports booting from ecspi1.

Expand it to also support booting from ecspi3.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/mach-imx/mx6/soc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index 3a3e01f3d0a..2c0c77e1a56 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -585,6 +585,10 @@ const struct boot_mode soc_boot_modes[] = {
 	{"ecspi1:1",	MAKE_CFGVAL(0x30, 0x00, 0x00, 0x18)},
 	{"ecspi1:2",	MAKE_CFGVAL(0x30, 0x00, 0x00, 0x28)},
 	{"ecspi1:3",	MAKE_CFGVAL(0x30, 0x00, 0x00, 0x38)},
+	{"ecspi3:0",	MAKE_CFGVAL(0x30, 0x00, 0x00, 0x0a)},
+	{"ecspi3:1",	MAKE_CFGVAL(0x30, 0x00, 0x00, 0x1a)},
+	{"ecspi3:2",	MAKE_CFGVAL(0x30, 0x00, 0x00, 0x2a)},
+	{"ecspi3:3",	MAKE_CFGVAL(0x30, 0x00, 0x00, 0x3a)},
 	/* 4 bit bus width */
 	{"esdhc1",	MAKE_CFGVAL(0x40, 0x20, 0x00, 0x00)},
 	{"esdhc2",	MAKE_CFGVAL(0x40, 0x28, 0x00, 0x00)},
-- 
2.34.1

