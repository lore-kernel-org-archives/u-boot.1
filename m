Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260A0C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 05:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 954F882928;
	Fri,  4 Apr 2025 07:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TslYMNdd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48EC882937; Fri,  4 Apr 2025 07:30:54 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46869828BC
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 07:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac25520a289so274554566b.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 22:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743744649; x=1744349449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUCGpSjh+GjwTGbGOxuGt4ZOQwLW6ctLVGpLUDHzMVw=;
 b=TslYMNddKLQQ785lhmY3flA7Alj370L++2ze2Fs1lyNV0V8HP7d475qtXQ+iAgiH5V
 llwvOwm1DbsfCM9yNb20hfrysN1WVCWYm+Hm8u8N+f6fjpw449nzEe9oZORfqWawZ7lH
 b3pCLfqa6K99MCu0FlMcUHyuejoB7/2SqroTn81ByGqaIUQH6bAUnW7kFTv06zCUxUal
 MU1ISVNaIgAGn3yCJuE1XzIqeJj46GkpVFvh/C6d0+Z7bXa2VKjt5kBNq+3wRgl5y5Jx
 3D2sOS71XHJWL1f2MW0sCDgn7PYy1fCErPEHWQwKSdIh1Cw84aIgwyQYJRq2Yp4U9exM
 PLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743744649; x=1744349449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUCGpSjh+GjwTGbGOxuGt4ZOQwLW6ctLVGpLUDHzMVw=;
 b=Qeb603Eolv5f9epE0VEiPU5P9vRcOUyuNZRoQ4/nK5abvePnTzceq2wC2fhvbcLxwo
 IbkXkc5yyD34+fIEXcoUDEYDapyq9dAu9eKvPQxaV35uaUyvHOn4EyjF+v/keTxBmO4W
 zkI9Y1GP0M2fA1FOMUL7FgwvNTqJyWc8MIK6wWMrAOgszaXhuhlF7vlsSH/HUY4AMBMQ
 kbWyXFGmJUcNOdU7W0o2gz/kP1L9hpu4x1Wrtx9+4QIdegiBCu46BKslld5cokpbgoH5
 0+4ek4xN+ivA5FHxobZ2lyzfHBiIv4P/4hC1ursmT0mpqcXSpU+R6Gi5IqO35LpojEff
 H5NA==
X-Gm-Message-State: AOJu0YyzBt29vJjk7WCr/kn4/LDf9ZF0rw91sddaHiRXo25y6ITtwCCn
 oWO76NQ+MlE75FyZmN7IGdMsgKBCKTragrrRJCm9JIQbOFyh8VRJ
X-Gm-Gg: ASbGncsTuqnErvcmbNGnmrye8zV+u7hzZpsU5P2bP4HiM9vQRee6rhBllp7oTz6WQi3
 3yfWES8kdjEUtJMAxS1jh/Z3P2lgxdgMwPxqNSxM2GjEepB1qmegPcLyGoaKy4jK3GftsuFiJzW
 PZOp+27q7O95K18kYTrFff+fYNa7Xi01Kv4vDdrp9e81wCQip32HBUxCJGXceEBydzAQ1hLYiZE
 ISuJB/axYQvO3k3/N02luX9+1I6+Lu3tgCUDwqmQatBGQApSVmq02+86W8FWXkmFhGjWixWoBZb
 tTTYsxP+SuhK9Q17aZVqsOoxqrvpD3p1dLjR
X-Google-Smtp-Source: AGHT+IErSM9Kc8o9ahUGrqBfFSgZ4W+ZRH/pTI25GWrmRrYVJz9/pfVPb0t8/7fFelYVi61U7CQ5Yg==
X-Received: by 2002:a17:907:968d:b0:ac7:9817:60aa with SMTP id
 a640c23a62f3a-ac7d6c9fefamr88394566b.2.1743744648432; 
 Thu, 03 Apr 2025 22:30:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea0d72sm197214666b.69.2025.04.03.22.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 22:30:48 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/3] ARM: tegra114: clock: avoid touching DISP clocks on
 init
Date: Fri,  4 Apr 2025 08:30:20 +0300
Message-ID: <20250404053022.6564-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404053022.6564-1-clamor95@gmail.com>
References: <20250404053022.6564-1-clamor95@gmail.com>
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

The clock initialization routine sets the DISP* clock parent to PLLC,
resulting in DC failure in the case when PLLD was previously configured.
This issue disrupts chainloading and to prevent failures caused by DISP*
clock parent conflicts, clock initialization should not modify DISP*. The
DC driver handles DISP* configuration.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/tegra114/clock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-tegra/tegra114/clock.c b/arch/arm/mach-tegra/tegra114/clock.c
index d5cc8ac44dd..d67d808b724 100644
--- a/arch/arm/mach-tegra/tegra114/clock.c
+++ b/arch/arm/mach-tegra/tegra114/clock.c
@@ -796,7 +796,6 @@ struct periph_clk_init periph_clk_init_table[] = {
 	{ PERIPH_ID_SBC5, CLOCK_ID_PERIPH },
 	{ PERIPH_ID_SBC6, CLOCK_ID_PERIPH },
 	{ PERIPH_ID_HOST1X, CLOCK_ID_PERIPH },
-	{ PERIPH_ID_DISP1, CLOCK_ID_CGENERAL },
 	{ PERIPH_ID_NDFLASH, CLOCK_ID_PERIPH },
 	{ PERIPH_ID_SDMMC1, CLOCK_ID_PERIPH },
 	{ PERIPH_ID_SDMMC2, CLOCK_ID_PERIPH },
-- 
2.43.0

