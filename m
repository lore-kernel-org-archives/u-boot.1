Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48C8C25B77
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 12:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98E3D882E0;
	Thu, 16 May 2024 14:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="MVatdVPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 073648824A; Thu, 16 May 2024 11:03:21 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1EE688256
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=anand@edgeble.ai
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5b290669b0fso3812384eaf.2
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1715850195; x=1716454995;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJ28Uic4umYxkCaD34TP81d06UdII5lnJq1avN2/U0E=;
 b=MVatdVPcdmWN+Hf12wVTRmpfH0tiUTBxgqUXNwJ2s7sOAMMCaTIFavEwt7tLhZdfVB
 4UDFXSQ5raxDhPTwByaXDTTcsNNbOpEvjstRCWLkAtFLFGUrD7yocMxn1gKKjyoVXzSl
 5dUI8BrZAmPxLAxmyH05FjpmTaHG8+fs0fgNeuAvGOKGqgcIW9V5OrJbq43MW12vh1At
 SYM6Tc3WXfkXEUYsWLBLA/K91UK+NT8avN8eH+SneIdsYj1YkzKsLNWOg++mK4/YAIs5
 r6xcG26D2Iax7dza2G6wDBeLyF2EvwZCSOiJTz8n7uCnlFauKhGZ7+rDYYLmiLv2X/01
 aF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715850195; x=1716454995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJ28Uic4umYxkCaD34TP81d06UdII5lnJq1avN2/U0E=;
 b=aerp9Ba8/qLvWjnSA3P4O9o1HQnnr8yK48+vBI3PuXWqdGwxpLIRCuD94rYqqEnFC9
 4GrJ1h1+RMqFhva6tGcGAOYeJbbhdx9woRZ8NTPJ6OJUGMqHvCLllhjeS/f1Hgtw9wy6
 OKT5ziTv/V9g18dqpk61mifO2xlxRE3ivIqp6nxMU+6y9YdCT0BJWx3Klr/MW6Jlbauv
 Ig2h8HC/wOpmCsHqp52f6zT9HkbdzRYxtWLQtuvCgCk3llgayz94Wn3snIdd/XPHAfsC
 zChgx4ktAIRDViaCi0sUh9mTwkLNdl2rFJEjmrFQFmNO10wxZe0R7Z/R6QHGjyweRFSp
 3CmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWea6YA27XEy3el7Mg90Wyruk2EZvBRb+EnPQB9RAy0QgaqWtrYcLMHb+patiFDF6z2G9bHTO/e5MQvpn4gdhwZlPOQ3Q==
X-Gm-Message-State: AOJu0Yxvl0lKN004eHKzWB5EJEltdFxSuGZOtCMbkHrvodiUg6WLb1JJ
 cf6I+FX+mTaPWEBvMKxk7F1B9karxpEZa29GRhPqGuUg3xLmd2/DfpKNJlPF3yw=
X-Google-Smtp-Source: AGHT+IHZlwCJyCUzm+0xH7ac3UOKLB6pEZX1Rw30AbuzcRc1/sV/bwhRoKTvAlct7ByRF/h7KloZLA==
X-Received: by 2002:a05:6870:84c5:b0:239:4a86:bbcd with SMTP id
 586e51a60fabf-2417291d986mr21017550fac.3.1715850195666; 
 Thu, 16 May 2024 02:03:15 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6584e7897bdsm1325189a12.21.2024.05.16.02.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:03:15 -0700 (PDT)
From: Anand Moon <anand@edgeble.ai>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Anand Moon <anand@edgeble.ai>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
Subject: [PATCH v1 3/9] rockchip: RK3399: Read the reset cause from clock
 reset unit for RK3399 SoC
Date: Thu, 16 May 2024 08:59:03 +0000
Message-ID: <20240516090031.2373-4-anand@edgeble.ai>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516090031.2373-1-anand@edgeble.ai>
References: <20240516090031.2373-1-anand@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 May 2024 14:50:16 +0200
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

Read the reset cause from clock reset unit for RK3399 SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
 arch/arm/mach-rockchip/cpu-info.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index fce4bd7541..77833c8fce 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -10,6 +10,8 @@
 #include <asm/arch-rockchip/cru.h>
 #if IS_ENABLED(CONFIG_ROCKCHIP_RK3328)
 #include <asm/arch-rockchip/cru_rk3328.h>
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3399)
+#include <asm/arch-rockchip/cru_rk3399.h>
 #endif
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/err.h>
@@ -18,6 +20,8 @@ char *get_reset_cause(void)
 {
 #if IS_ENABLED(CONFIG_ROCKCHIP_RK3328)
 	struct rk3328_cru *cru = rockchip_get_cru();
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3399)
+	struct rockchip_cru *cru = rockchip_get_cru();
 #endif
 	char *cause = NULL;
 
-- 
2.45.0

