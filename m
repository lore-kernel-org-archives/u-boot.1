Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E4AC001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 17:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BE8E86A0B;
	Wed, 16 Aug 2023 19:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IsLoUAuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 795CC866D0; Wed, 16 Aug 2023 19:34:37 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AACAF86A17
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 19:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bc8a2f71eeso44521435ad.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692207272; x=1692812072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Mmk3DmygeejVRJ/tqY2+tqiVHIUSGcyqGy++3zPgx4=;
 b=IsLoUAuLJROFg4OMqA12FgVeI0hfHLpB9EAHqNyX3GQeU2GUm1Q6Jw5xosw7cz5HE1
 XBEa0YSYoJi8BlSRDHYRmTr03u2jz5YUR4H8pjJVq47LwEs5okj6EoBR4s5d7f8qNZac
 DAPT7XUmY0Z+8+vYleO0htXee0Mgmb7xBb1CNqMXBsppGVmArToDEsycRX3IsdUoaGm1
 iMhWbhqTXpi5GM167neXLyCTclFTP5eZJ9QneyQJ3aZDp63roO95sAp2j8Mi/mZ4eY1u
 RBrSJXJs2yHnHBZYxNhksxFQ+SwuoI+KiRrvAGpMVVyxKULsob/rfsrjPTaYBJV/838E
 AQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692207272; x=1692812072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Mmk3DmygeejVRJ/tqY2+tqiVHIUSGcyqGy++3zPgx4=;
 b=K7zuVPaBhztRwdUKGupNVHcKBf9xIEiNyasirWlZ+zY/ryTddd+zuHbv6PieQq8i0G
 IDtu5JPIt8biMCy4dJJf48oBvAGGJmBc9huVcDwlRMXNaq0WVMFsBTPccO/Gj6AUOg4j
 jxCF6Fca3GjSYWZOKirYUd8u2OWDnds6vmA3ZxrvU1IRtD4R7iUnB46yzwtkLOydoYkg
 bRd6MooRMYWX5RkmC4L7v+yZ8X+/BfBST2TjIreB0NqLGPOYocFvrzcXHhkaYa28TnEn
 cBCUxJS+ifejZK4L0SSFKtsG3hWYoE00l6WgHo0/7pL7CyY1khmUg4gO1JEHAdtZeWzY
 7g3w==
X-Gm-Message-State: AOJu0Yy7Ij3SE9NF/2polCmzQid+EGDY1xzfYNwAGwkjFA+IYqXvqCFS
 Or5XKWcTbz3fH6W86JJshSVhF+TrXUTsyw==
X-Google-Smtp-Source: AGHT+IHEAQCe6FlC6laeiDhk3rKqKdI6tS1HucFyVS+vbHMFHHL4nUgA8ghGmUUV9vhWGQZAJlT4fQ==
X-Received: by 2002:a17:902:eccd:b0:1bf:728:745b with SMTP id
 a13-20020a170902eccd00b001bf0728745bmr1132461plh.49.1692207272523; 
 Wed, 16 Aug 2023 10:34:32 -0700 (PDT)
Received: from celestia.nettie.lan (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 z5-20020a1709028f8500b001b8a7e1b116sm13338631plo.191.2023.08.16.10.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 10:34:32 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 5/5] HACK: sunxi: psci: be compatible with v1 of R528
 patchset
Date: Wed, 16 Aug 2023 10:34:20 -0700
Message-ID: <20230816173420.83232-6-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816173420.83232-1-CFSworks@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
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

This is a hack for reviewer QoL. It is not being submitted for mainline
inclusion.
---
 arch/arm/cpu/armv7/sunxi/psci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
index b4ce4f6def..27bac291d5 100644
--- a/arch/arm/cpu/armv7/sunxi/psci.c
+++ b/arch/arm/cpu/armv7/sunxi/psci.c
@@ -60,6 +60,18 @@
 
 #define SUN8I_R528_C0_STATUS_STANDBYWFI		(16)
 
+/* 3 hacks for compatibility across v1/v2 of Andre's R528 support series */
+#ifndef SUNXI_R_CPUCFG_BASE
+#define SUNXI_R_CPUCFG_BASE			0
+#endif
+#ifndef SUNXI_PRCM_BASE
+#define SUNXI_PRCM_BASE				0
+#endif
+#if defined(SUNXI_CPUX_BASE) && defined(SUNXI_CPUCFG_BASE)
+#undef SUNXI_CPUCFG_BASE
+#define SUNXI_CPUCFG_BASE SUNXI_CPUX_BASE
+#endif
+
 static void __secure cp15_write_cntp_tval(u32 tval)
 {
 	asm volatile ("mcr p15, 0, %0, c14, c2, 0" : : "r" (tval));
-- 
2.41.0

