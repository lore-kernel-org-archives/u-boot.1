Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B433FCD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 20:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F998813C;
	Mon,  8 Apr 2024 22:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=loftorbital.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=loftorbital.com header.i=@loftorbital.com header.b="c+IwvwWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A432D88113; Mon,  8 Apr 2024 22:13:29 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C48B8813A
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 22:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=loftorbital.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=charlie.johnston@loftorbital.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e411e339b8so11203855ad.3
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=loftorbital.com; s=google; t=1712607206; x=1713212006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WGaGfXi+L6Xasm/YVsN8PeJyWv14tPjM9kv/gU9Nak=;
 b=c+IwvwWGUp0uHQj8GuY7TxIlgbbAi3Jyw2JhaNHLiNzkDq7T9/Ou9ldiPOrh6sDElf
 n3BFnx0qhOtVdeZVeFl7AAgEQ3ZHwIBcAjBcRSwRR50n/gRnktFUl3ugAcCX/bQegfaw
 RMcWTMoDoxTo3FsG8EBMT0uPY8sZF/k+WueQh3/GyhjXz/TqrvrrjriKYIIinrZRTv+H
 7AzVIgA627vXGAjc4bOvi01FoRMEjK/2MjBPMvN/+WorJjcjsALqBUAWG7JjNtUCGuj6
 9eRYQV45UZfes0JFnTywk3EQejWajnTqYJ+dkj8Vnr9JSy4ypB5uZE4iN+ClcZ56WAPx
 oM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712607206; x=1713212006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WGaGfXi+L6Xasm/YVsN8PeJyWv14tPjM9kv/gU9Nak=;
 b=W5pIpmd00bQYvbcHSHE//x5Eg8Oq9jKIeJcLrhMRwYL6aZEdFjFOAWsVpcG1o786sf
 AChRbmHkEhX/xU6ghjY6Vvhyp17GTjDf0DfPvRFTjc1T6ZnztldGilb2M237Nf0U4T7I
 zQYx9a12MYMLRLDER5YlA0j2/XicqCQA6VLluY8ZKX1O1Msoo4LzafTEDu9/y3+D8z18
 2b2FHCHEQK3wRnkfvu9XIv3wxt7rb1hogKbTNVkAytMKpjYrp3UZr3LL8EpRxaBDqgoS
 S5tXvYk3APSWtE90SMDvUhegBxP41ME5SzJ+noYG1UucQoj0JLh/2oL634rWYZqkJMy6
 u81w==
X-Gm-Message-State: AOJu0YxsVfBYOOg1fj42MzMMbPpnITBryX7y314k+EInfkuX+llSxZGP
 d8ard6Xz+gSQ4nKAIRdeLyxxIuvUe6hmR9qlVgsjMHbbaWPFj2A3Xllh+iITZrAfkGZo6CV0QmJ
 HNE4=
X-Google-Smtp-Source: AGHT+IF3TSh80gc8PR655nAF825DmRc5LUut8Bvzz2mwqXMkOwwIW11dBgtcc+iH3+qNFvSdNPomkA==
X-Received: by 2002:a17:903:41d0:b0:1df:f859:91bd with SMTP id
 u16-20020a17090341d000b001dff85991bdmr12396193ple.4.1712607205839; 
 Mon, 08 Apr 2024 13:13:25 -0700 (PDT)
Received: from cjohnsto-vivado-vm.. ([12.172.216.189])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a17090264c900b001e3dff1cb4bsm5150982pli.19.2024.04.08.13.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 13:13:25 -0700 (PDT)
From: Charlie Johnston <charlie.johnston@loftorbital.com>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, Charlie Johnston <charlie.johnston@loftorbital.com>
Subject: [PATCH 2/2] arch: zynqmp: Move CMD_ZYNQMP Kconfig from board to arch
Date: Mon,  8 Apr 2024 13:13:13 -0700
Message-Id: <20240408201313.10183-3-charlie.johnston@loftorbital.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408201313.10183-1-charlie.johnston@loftorbital.com>
References: <20240408201313.10183-1-charlie.johnston@loftorbital.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Apr 2024 22:22:35 +0200
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

Since the previous commit moved the zynqmp command to cmds and the
command depends on the arch rather than the board, this commit
moves the Kconfig entry into the arch/arm/mach-zynqmp/Kconfig

Signed-off-by: Charlie Johnston <charlie.johnston@loftorbital.com>
---
 arch/arm/mach-zynqmp/Kconfig | 13 ++++++++++++-
 board/xilinx/zynqmp/Kconfig  | 19 -------------------
 2 files changed, 12 insertions(+), 20 deletions(-)
 delete mode 100644 board/xilinx/zynqmp/Kconfig

diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
index 6a7be0b427..ed0aa29c12 100644
--- a/arch/arm/mach-zynqmp/Kconfig
+++ b/arch/arm/mach-zynqmp/Kconfig
@@ -212,7 +212,18 @@ config SD1_LSHFT_MODE
 
 endchoice
 
+config CMD_ZYNQMP
+	bool "Enable ZynqMP specific commands"
+	depends on ZYNQMP_FIRMWARE
+	default y
+	help
+	  Enable ZynqMP specific commands like "zynqmp secure"
+	  which is used for zynqmp secure image verification.
+	  The secure image is a xilinx specific BOOT.BIN with
+	  either authentication or encryption or both encryption
+	  and authentication feature enabled while generating
+	  BOOT.BIN using Xilinx bootgen tool.
+
 source "board/xilinx/Kconfig"
-source "board/xilinx/zynqmp/Kconfig"
 
 endif
diff --git a/board/xilinx/zynqmp/Kconfig b/board/xilinx/zynqmp/Kconfig
deleted file mode 100644
index ffa2f0215d..0000000000
--- a/board/xilinx/zynqmp/Kconfig
+++ /dev/null
@@ -1,19 +0,0 @@
-# Copyright (c) 2018, Xilinx, Inc.
-#
-# SPDX-License-Identifier: GPL-2.0
-
-if ARCH_ZYNQMP
-
-config CMD_ZYNQMP
-	bool "Enable ZynqMP specific commands"
-	depends on ZYNQMP_FIRMWARE
-	default y
-	help
-	  Enable ZynqMP specific commands like "zynqmp secure"
-	  which is used for zynqmp secure image verification.
-	  The secure image is a xilinx specific BOOT.BIN with
-	  either authentication or encryption or both encryption
-	  and authentication feature enabled while generating
-	  BOOT.BIN using Xilinx bootgen tool.
-
-endif
-- 
2.34.1

