Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780BFC25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:19:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C81A8887E3;
	Fri, 31 May 2024 16:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OiyzyeAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B390E887EA; Fri, 31 May 2024 16:19:12 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A03F887C7
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6bce380ebc2so1782274a12.0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165149; x=1717769949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cin9JKFG0fxFovjADZZvQtlw+A+m3bxqoWJeRsLkehw=;
 b=OiyzyeAIlJm/GP15wEtJVw3ztwoJIVqyYIqLjQGAO1lz7h2Z7/8zKrXHfD5J6YOblS
 fofV60UgfSivbz2GKeAUGlJ+C/aE9VfLUAxi6Vd9kG0t2bACDdXSckpVKrE9nX7nJ0ca
 s17ChB0R0Hl6SDBZlDh4XfRLnzdQrETK+zeCvQrAX4tAgiUF++n+T7G96JKWWryXxNEj
 7Q6uSDk9ZOLDRLKuVcVAk5/s+mwy5Jv3KSX3SdLWpHZJOpL5xHtIwERs+i97YG9s4INY
 RB/ItBNzoUsA/FUYESp63XS3WmFl/n3V+Kyuc1RaclCy2/TXsWHBU2gkCDi984ZvL37V
 KySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165149; x=1717769949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cin9JKFG0fxFovjADZZvQtlw+A+m3bxqoWJeRsLkehw=;
 b=fwpnG+FeKmg0JPPRUH7mHA45qKcVCW4HxMfxvLdxceBPUiW2q7mbMDQ4u8gEPKO0l+
 p0My4Aoau4d0Yp27B3gpqxExkkSYijuntnSaXzmZkIFpGvbN4eSIbsd2hcUwebg/bbG9
 N9zv5wQTxge2BBdbnk/sHtqtN93+WXDf3+CLEEkVlDLGl8qq9wBUBxG9NiOy0UulULrl
 eXQc0fZgRTwFKQV3VcBye/0TBdRhThwAkISoH7Rg8pcXpiplxP2/vObOTuO1Y3yPIiN7
 Pmg//vurvx/SBWtEeAkwz2kUGHGFqpCJp47+A4Xd3F0EKw2VhNiPmOylYEctmZabgSQg
 k8Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUURa8xtWsQJNNciOIkM5YYUBM471sJ0PjSrOwKrjagT1Ev4QBmAa9TGNHQhjDp1scXN3+8lrAJ54p1TRGpyz6G/voMGw==
X-Gm-Message-State: AOJu0YzL6UYtSJcwoDkhr+kU3ViwfGN1Lmx6qw/cBeOhIWiCfWzH+Iop
 mF9X+nWPbj+iFTgyfXvSscKkdXk6dQJkswVLV+Hh0/PL2yQaH41z
X-Google-Smtp-Source: AGHT+IFT6tftfkF2X7noMcJKWOPrRH3exWtRkQcjUX1gIY0/1I7hHnsFpvLhoTEHyfg+H3wyL8ftJw==
X-Received: by 2002:a17:90b:2282:b0:2c1:b88a:d5ce with SMTP id
 98e67ed59e1d1-2c1dc58fd41mr1749242a91.28.1717165149015; 
 Fri, 31 May 2024 07:19:09 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:08 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 05/23] arm: rockchip: Enable display cpuinfo to be
 build with SPL_BUILD
Date: Fri, 31 May 2024 19:48:19 +0530
Message-ID: <20240531141837.13189-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531141837.13189-1-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
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

From: Anand Moon <anand@edgeble.ai>

Changes help enable CONFIG_DISPLAY_CPUINFO to build with SPL_BUILD for
SoC RK356x and RK3588.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/mach-rockchip/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index c07bdaee4c..254c26034f 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -23,9 +23,6 @@ ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
 # meaning "turn it off".
 obj-y += boot_mode.o
 obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
-endif
-
-ifeq ($(CONFIG_TPL_BUILD),)
 obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
 endif
 
-- 
2.44.0

