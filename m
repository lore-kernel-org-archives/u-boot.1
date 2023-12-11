Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D1DC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D286B8772A;
	Mon, 11 Dec 2023 10:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="b55YpO7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F6188769A; Mon, 11 Dec 2023 10:01:48 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A5E87725
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d05e4a94c3so36736045ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285304; x=1702890104;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqZ3uep2ldeSCiMDN9Gnj/VvA2lNl6QWFSy1xAd9IBw=;
 b=b55YpO7eLPpfV/XlSwJ01dwh3XtJs6ofZJ5oRQijITV8N2+6AjavWv3IdfZ1o92bTb
 2DYu1JISRkpdcAIEP1VUty4xoBH77ZarMyUH7hByp9yyzCZgDIfuhxqO7nONPedczBZE
 vdjYUIi8xnZ05ElIuASoNMuy6idAaQu77LCPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285304; x=1702890104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqZ3uep2ldeSCiMDN9Gnj/VvA2lNl6QWFSy1xAd9IBw=;
 b=Xy/liAvK/PbzR+mjnXNc5cyXlEGkm+WgLuaQRRiuLHBs55IE92kVGr9xkUv8SGYeob
 4p0U0DBMssJ28Us3EMjgVh+s+Zy+oiSK+X5PBjyhnoBYYAEnX0nssz37C16rg/aAsNNr
 34bayqlN1a+dC17giIqZh0sL/1+747iT1tnBuBXGdrH9O3d14O9V/SghoACHrxxLINQm
 1cnoEcL6riTZXqeMIKc5Z4tj1PMTw7gF6mk0YNIHk65GWg9D8YaA1IW1+HrzrKNfmAX7
 IuRIp/9HfxS6OaQGmJjqwBqEtFqqVO2wpSOufh68U1LeonGDB1LQ6fVuwZOf9W++5uuV
 z5QA==
X-Gm-Message-State: AOJu0YxvNWQmZdrvbhQAxG92yZk1yEMo7iAZ686/Ypazhb0I07qmgexx
 +2wNJG3iV0MU2vlWNMjXLU7zIQ==
X-Google-Smtp-Source: AGHT+IF1C1IdjCGINskcCsz487eQVQrdCGy6JA6repTkUoA2c1Les5J0/iSFlp0arRxqiiTZg8N7pw==
X-Received: by 2002:a17:902:b7c5:b0:1d0:6ffe:a0f with SMTP id
 v5-20020a170902b7c500b001d06ffe0a0fmr3947253plz.109.1702285304485; 
 Mon, 11 Dec 2023 01:01:44 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:01:44 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 15/17] rockchip: Enable preconsole for rk3328
Date: Mon, 11 Dec 2023 14:29:37 +0530
Message-Id: <20231211085939.5478-16-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211085939.5478-1-jagan@amarulasolutions.com>
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
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
index 0f54819519..093ebfbd1e 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -208,7 +208,7 @@ config PRE_CON_BUF_ADDR
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

