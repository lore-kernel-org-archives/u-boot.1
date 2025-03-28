Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A766AC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E4E82102;
	Fri, 28 Mar 2025 16:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eOZL5ASK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3964C82114; Fri, 28 Mar 2025 16:36:50 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1E20820E2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85b4277d0fbso73578139f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176206; x=1743781006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFueD2GYcx7Z86F3jc4M2qJYf8w2KwSL3zivYY+cllI=;
 b=eOZL5ASK8aZDCJeJE5nlkKJVqh7+lZ3sIQQO6HiNUMxvF/iHhPPouvKXHtGXuvAMNR
 5FZhnepHoFfxRPP17FSOiIGuSFAtRLuN6KnqA+3yBE+sjPnAjBgputvwt2co/LnKMcoN
 T6FyVBqbTo1gVJVIB6nb9Bo1r4cZnx9JMpetY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176206; x=1743781006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFueD2GYcx7Z86F3jc4M2qJYf8w2KwSL3zivYY+cllI=;
 b=ZJeoQieQCa5Tjtp6KOMyG+r/U3MChCzD9jHIVORs74M9Y4JUABut3VEaa/RpYFLvjV
 fNa9yhgE1J7hPWKpxmLRB58dsExrCxvjRUsItGExmdh7tjy5pUAJMbxiyegS+nlBeAru
 GZpjOUN6gxmpnihHC9KA0SBcN3Hv0PPbDdxDQwP2Ai18R9f84T1t8/Wtfe+fx7gDdHOw
 jEfMY+2H10fXy4GRdddbuWgYIfvPlc1Pl4r852qk7Z/qThWuGfBCBqLSK9xSyUZc9aGI
 Y9NpW+IB3Q1BmsHz+iSbTuT+uQuMGOtNWZJEVEAqbWHMzoNs1/3NVudO/pBrfnY10ipR
 UjgA==
X-Gm-Message-State: AOJu0YwqxGaiG3zMM62sTFy7zHduuTIi7aV7VHyarV55IT6PyAAd3u1B
 IH/XLwLsQ9g+qzxIvw3A8uM6d4zGV5PKc80YI/N7IFaHWgU1sWtAaqqQ3sq5caw2lDVDAOx0j/o
 =
X-Gm-Gg: ASbGncvWmOzjs9WMg6gx++8uxPtfqxCjwiueIzbwTPe0u7UtQIBs4O91Io+USreMQfC
 I8qId91QIm1Sst9txfIkBmynuiSQsqS38jGwYJ6Z6RmYCrWFSKwN8fs2jBSpmjaj15Kx1MBisrn
 AFtT/6hCfTae+lDROk0n1cau/cxsqxp0K2V/xmBMugOpE661rb9cRaRT3uAaH+OPwCcrB4oAm81
 k1GO9e5+ZLPf972v6YoQtSEHbAbIayV8joAt3kDrOnTXZFrqlrN1/7SYIQgmLIEQF3pPcl0j360
 NsX9UxxZ3abDyVJYrzxcM4JiqgHII7gBxLZ2AGhx/quA6D6wJ5MeGhmrP9pKicSi5ekIJ7ro8TE
 oCfyBog==
X-Google-Smtp-Source: AGHT+IGXUHuhOzWfaqc15+x4BU2j5UFJStP9JRRfYu0X7W0mDN7rndIgObAy/9v1KsXvruGfEywEJw==
X-Received: by 2002:a05:6e02:988:b0:3d3:d965:62c4 with SMTP id
 e9e14a558f8ab-3d5ccdcaa13mr57490385ab.10.1743176206027; 
 Fri, 28 Mar 2025 08:36:46 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 30/31] rockchip: Relocate bloblist at the end of the SPL
 phase
Date: Fri, 28 Mar 2025 09:35:10 -0600
Message-ID: <20250328153522.3555472-31-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

Where the bloblist is located in internal memory and TF-A's BL31 blob
removes access to this memory, the best option seems to be to relocate
the bloblist just before running TF-A.

Do this at the end of SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Raymond Mao <raymond.mao@linaro.org>
---

Changes in v3:
- Add the BLOBLIST_RELOC condition as well

Changes in v2:
- Move this logic into board-specific code

 arch/arm/mach-rockchip/spl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index 305373a161c..a919246c4aa 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -3,6 +3,7 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
+#include <bloblist.h>
 #include <cpu_func.h>
 #include <debug_uart.h>
 #include <dm.h>
@@ -133,6 +134,20 @@ void board_init_f(ulong dummy)
 
 void spl_board_prepare_for_boot(void)
 {
+	/*
+	 * On RK3399, TF-A is executed after SPL and before U-Boot. It removes
+	 * our access to the IRAM. So move the bloblist to RAM.
+	 */
+	if (xpl_phase() == PHASE_SPL && IS_ENABLED(CONFIG_VPL) &&
+	    CONFIG_IS_ENABLED(BLOBLIST_RELOC)) {
+		ulong addr = CONFIG_IF_ENABLED_INT(BLOBLIST_RELOC,
+						   BLOBLIST_RELOC_ADDR);
+
+		log_debug("Relocating bloblist %p to %lx\n", gd_bloblist(),
+			  addr);
+		bloblist_reloc(map_sysmem(addr, 0), bloblist_get_total_size());
+	}
+
 	if (!IS_ENABLED(CONFIG_ARM64) || CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 		return;
 
-- 
2.43.0

