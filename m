Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A387C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 23:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760B78104B;
	Thu, 27 Feb 2025 00:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c8+tFy4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7103A81113; Thu, 27 Feb 2025 00:07:25 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36EEB80FF2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 00:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22101839807so4799825ad.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 15:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740611238; x=1741216038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uhON0aiSezZFtaTzzz7Hy9bqwR9r6cB6caoknMUf98k=;
 b=c8+tFy4MJfifofxKAZq6X1o5aSSwPJNmDwNinE+TYxtQ2w8cnXRoQpWNiKdNdJdnSL
 tjxQsvLDiKzyES/UsoQ0sCHsm1diE4ixIfthgJDcLVdioZp1l8IKIP3tIE6MVN9AglsP
 VDFFI+LAaBLq4i1ApMr0gDYmLPt4o6FkTYOasGtZbVBtp7X8nKy+kmOjTby2p73pLq1H
 2LY0m1jOiyo/IfdrA5Q63qTwWYGGkPeca2JNqdQxzRQFk+MhJ/h5ebINUGDQnw7b1RnL
 VLVBhOtkKMt1aKfHcnj+rp3VZL99JLa5ozoPkVlgiYLEU2r9u3dMNMXrQsmHqNvou4VR
 zKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740611238; x=1741216038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uhON0aiSezZFtaTzzz7Hy9bqwR9r6cB6caoknMUf98k=;
 b=s0fVZ77RXxMAOCzeX49IG7i1yePUiRqoSb2BGs4j27lKX2/trWPwxzzARK4ZJEt2oW
 3v3MwaKmbXgUEhQOt4fvGmI9NU50FZhENuzC+CCPzUgHUnrruoW06+pQyHeg9SM0aJVG
 I/1qGOddhT8CguGRacxFdxEOTgVGGHE54IUwgrmlAZRjRLyPTLXVcYY/1sGNOSMmijfC
 GLrIOi5rJvFr4eE+jMX+zYW6jUXEKNJPSqWVh3eQAB+ad8u7FP+Lj4Roo/upvSrGhvWi
 jT1hBF8op4J4l7qRWzjteI6T7b4n7jV7WRtWHj7GLstRgb0Cda4PKtRBbVk4LleXf5J1
 JsuQ==
X-Gm-Message-State: AOJu0YwWtPv4PG4KnzVoKmadhI4cBF5zEGL5Q6QNYzT6ORAoNZlzMLek
 5brtDa0UZkO9HUUlauTtCy7C4hDKEHePd0k+1yArK5FqVc37RmSK5MMN4H/b
X-Gm-Gg: ASbGncuzNMQJL33Jjo56RRnZXH7l2QmjeiYKckCxU7eSwY1gV98UljQ1GE04zZ0v93X
 ZtsRFG3GZW6qH/z8styIFIONU6JKVUuGKAPx8/S0UXGldZkUWg/QmxRpnAW692iKvh2Z0VkD+wq
 ZHX6BHLIE5kHe+AOEucNCsHm3ECnG5lfJZvBnH375hvMOkew4Pi0JO1uwEs/lfYha8hSfxuMwnl
 qMCH6Rioif0FBIE0QM++wMyUTliU5P6EmpahSZ5KjUYDfJ5+AeVCyNV+CYvbgbMNtmwITtQ4Drr
 uq60tweTnDdrBSgC+H2Ry2kZb1EHNmdo6Ykw7HAX
X-Google-Smtp-Source: AGHT+IGOE1pMN1ySffTEj27eei+IGuQX9EcQH4SDrDKnfiOyQvxcLRmIv+kMMaTtB3UrhqiPkEdkeA==
X-Received: by 2002:a17:902:e545:b0:220:bd01:6507 with SMTP id
 d9443c01a7336-223200afaa4mr80921465ad.25.1740611238461; 
 Wed, 26 Feb 2025 15:07:18 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:540a:ff75:2ab7:abda])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223505336ecsm1617305ad.244.2025.02.26.15.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 15:07:18 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: mvebu: Fix typos in Kconfig help text
Date: Thu, 27 Feb 2025 12:07:04 +1300
Message-ID: <20250226230709.730250-1-judge.packham@gmail.com>
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

Fix a couple of typos in mach-mvebu/Kconfig.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 arch/arm/mach-mvebu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index adb816982f87..22180b011559 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -260,7 +260,7 @@ config DDR_LOG_LEVEL
 	  failure, RL, WL errors and other algorithm failure.  At level 1,
 	  provides the D-Unit setup (SPD/Static configuration).  At level 2,
 	  provides the windows margin as a results of DQS centeralization.
-	  At level 3, rovides the windows margin of each DQ as a results of
+	  At level 3, provides the windows margin of each DQ as a results of
 	  DQS centeralization.
 
 config DDR_IMMUTABLE_DEBUG_SETTINGS
@@ -450,7 +450,7 @@ config MVEBU_EFUSE_VHV_GPIO
 	string "VHV_Enable GPIO name for eFuse programming"
 	depends on MVEBU_EFUSE && !ARMADA_3700
 	help
-	  The eFuse programing (burning) phase requires supplying 1.8V to the
+	  The eFuse programming (burning) phase requires supplying 1.8V to the
 	  device on the VHV power pin, while for normal operation the VHV power
 	  rail must be left unconnected. See Marvell AN-389: ARMADA VHV Power
 	  document (Doc. No. MV-S302545-00 Rev. C, August 2, 2016) for details.
-- 
2.48.1

