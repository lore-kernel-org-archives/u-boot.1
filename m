Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8422DC47DA7
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1685187AC7;
	Wed, 17 Jan 2024 08:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="efSiKTuY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9766987A3D; Wed, 17 Jan 2024 08:53:25 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B67C86F6F
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d5cdb4a444so23668505ad.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477995; x=1706082795;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AU9EH6L2IgBCUTxbdiKJtarFQUmz5no3Pk/HSX1Pa/U=;
 b=efSiKTuYCI5lwaH/6dAyGcvq7M9z6rfCw6q2yKK035egQpw122geWTlLtFrxdJ6KLa
 fr7SgUeNuaqcszsDzqnOmE2F/D0qSv923fPXIuf9FbgeOJKuVx0ZnFLCa2QK4Iowmh8P
 m6i678+hB7XeZznEV9whgMXuDZWvA2bO+T8SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477995; x=1706082795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AU9EH6L2IgBCUTxbdiKJtarFQUmz5no3Pk/HSX1Pa/U=;
 b=MJBdXxBl7fXwBwTAYa/F6Z4uMJ15a2jKEkoZnAs8bHUrSCYBlZROhVcL7a338z6fSC
 0pYRSfiYKxMw/Dm+F8TOvkQ2Sbbp8oIKTMzu7MeSXPRSdF9Pv5WQ+1zdVNG6CI+4CUoC
 J+QGk3hBPVuVYP3O9CqqSUeuUUiHIRZEvvfAhoir/85enSR8k3RZhaAYZbRyDRXPLcOa
 D3sx0bCjKhkjzWifcybN5bFfAM1fskmPSuMK/kXxQAjOb2Sa5lzSzJdVGqASpjjNtsjy
 3hsWOz/riJU/ELERxp0V5Wdg8EUa25RrDSmiBCqdhw2/OR7PF+OqyOvL9jFSaf9GKX1w
 F5eA==
X-Gm-Message-State: AOJu0YxTX0tdU7OM/b4QFZAXum6dPO7mxtYSFIjiKfnkM6V0BrO/vh85
 iHZA0LVkQvfF3ZF2/WbAntlTaGOApkonFw==
X-Google-Smtp-Source: AGHT+IFLU/GG7Yy8a+a12keC9nxYuoYZpQz1bKvxDvpJjmEmyq+mMeECCa42DYRzxdNFrh7uSC0yVA==
X-Received: by 2002:a17:902:9a4c:b0:1d4:638f:4005 with SMTP id
 x12-20020a1709029a4c00b001d4638f4005mr8600548plv.12.1705477995470; 
 Tue, 16 Jan 2024 23:53:15 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:53:15 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 15/17] rockchip: Enable preconsole for rk3328
Date: Wed, 17 Jan 2024 13:21:52 +0530
Message-Id: <20240117075154.58747-16-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117075154.58747-1-jagan@amarulasolutions.com>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
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

Enable and set the start address of pre-console buffer for RK3328.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3, v2:
- none

 arch/arm/mach-rockchip/Kconfig | 1 +
 common/Kconfig                 | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index b577a911e7..60f403fe74 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -179,6 +179,7 @@ config ROCKCHIP_RK3328
 	select SUPPORT_TPL
 	select TPL
 	select TPL_NEEDS_SEPARATE_STACK if TPL
+	imply PRE_CONSOLE_BUFFER
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_SDRAM_COMMON
 	imply SPL_ROCKCHIP_COMMON_BOARD
diff --git a/common/Kconfig b/common/Kconfig
index 0283701f1d..5e3070e925 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -231,7 +231,7 @@ config PRE_CON_BUF_ADDR
 	default 0x2f000000 if ARCH_SUNXI && MACH_SUN9I
 	default 0x4f000000 if ARCH_SUNXI && !MACH_SUN9I
 	default 0x0f000000 if ROCKCHIP_RK3288
-	default 0x0f200000 if ROCKCHIP_RK3399
+	default 0x0f200000 if ROCKCHIP_RK3399 || ROCKCHIP_RK3328
 	help
 	  This sets the start address of the pre-console buffer. This must
 	  be in available memory and is accessed before relocation and
-- 
2.25.1

