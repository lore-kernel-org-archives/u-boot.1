Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AD4C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159548767C;
	Mon, 18 Dec 2023 20:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XyZ9jKyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A54787620; Mon, 18 Dec 2023 20:12:29 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFDC0874D5
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5c1f8b0c149so1389271a12.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926745; x=1703531545;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVgNI8wjKPyK287bH1TRnksAFKtF7gB26HFhV75xT9Q=;
 b=XyZ9jKySy15nx9nKx5EITiT6Qf7+6WYgMQJqfJNIEhA7Qw+ze8f81+jyB2A0ANiLoz
 lInLtYgzk7/+uuxIo5w8HOrKz8l3jhuEyisYXFcyIomE9eB/5b1tdRzxUzfxImJvpQER
 pvByjKYdZBdhVPJRDHfQPYh4UgSUBPDvZyi0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926745; x=1703531545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVgNI8wjKPyK287bH1TRnksAFKtF7gB26HFhV75xT9Q=;
 b=GxzEUk5kbiKZ0lCknYqHwb/4XGpFQ9zP3cpxtp0sxlIQnSuXBhFwNLKTagodxmQEV9
 2j7pIBhkdziEXxwlQ+dOIW1qAOPECRhKcj75NEKXuMYfrwwXl1XkVarZPDmbo6eA749T
 7hlMIOQhsm5x3n0IZy0Ydg5oa7SUJTj354P1kbakG6fe35Ixy6i8n/z17XxMk60Pc/Qq
 kcapiPmlYvA1V/gB0N8k+tTdTZrFhW/ZjhP/Dx/nYDsCgmXGNvCIOUBu2jJKtKij3BEq
 WxFPRxMwU/duGmyzekWBBM5dn6uy400LAYWmTGrQM0sO4kU9QYxhwuKuQ3taGRaQUT12
 ZxAA==
X-Gm-Message-State: AOJu0YwV5xbvHp/YNNlDdPX1t91McwsU6jcj6kAudd53CvwOc9n2d7z8
 Yd+JhDrofIjDIrs7sy2+bQ2GY04G2Q5gb6YhHpuqAw==
X-Google-Smtp-Source: AGHT+IE5gaLKzuYKt91sUL+67E1hADntz7YWog6KSvxaIr8xyRdEVvPcHHe3CxRz7w64rDXwUp1DaQ==
X-Received: by 2002:a17:90a:e545:b0:28b:7710:d525 with SMTP id
 ei5-20020a17090ae54500b0028b7710d525mr1018417pjb.46.1702926745290; 
 Mon, 18 Dec 2023 11:12:25 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:12:25 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 15/17] rockchip: Enable preconsole for rk3328
Date: Tue, 19 Dec 2023 00:41:12 +0530
Message-Id: <20231218191114.129329-16-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218191114.129329-1-jagan@amarulasolutions.com>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
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
Changes for v2:
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

