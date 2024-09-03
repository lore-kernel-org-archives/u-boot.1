Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16BFCD379F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 16:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4488088C1D;
	Tue,  3 Sep 2024 18:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="FV20CAG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11D4888C30; Tue,  3 Sep 2024 18:39:51 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A6F988606
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 18:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c25dd38824so2209163a12.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1725381588; x=1725986388;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTYojGfjLhzV2kZRX/mUuq+HtEaqCMpPF5UgVaZFXWo=;
 b=FV20CAG1eFTxhDXM6nvWGZ/30rsKVIKewwOnj4Y2H68QdCbwkIxRwJ0tDk/74OlSQI
 8LFQARSPFAJA2fBkr1WjJ2Rgl2zV8IOqD6IAeutxpqadhUQgiYP2r2A74JYGIdzMPVFs
 nNv+zFyave4rD7Mwga6sThJ15FqvKPTZAUSBMtxiVJwfuCBFvJ4FB88Sr7CSdPGN5Ssj
 nwB5qFl8r0xuS5wzrJKaG3JihTujQmLATMScfPJeGkpPKUFgvDIq+iet5pUw9bqFWeP6
 EMFnBJnHZNDdgb5DceBFMSbGkzNAt3s9Lc4qxYbGCr3eiRmjsLPOgwq5eDRhs+Ww4UFp
 MnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725381588; x=1725986388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTYojGfjLhzV2kZRX/mUuq+HtEaqCMpPF5UgVaZFXWo=;
 b=G0xMSKajaVxxHq1rce8HA/Z4Wc7S3dZQTdgBg4k0z5ekDj2tO3md3aKKXTX5c+IHNv
 pPlaCK6XTWiX5DZ/897pVpmkeAAcSFa+abi/fPINUBgc964psx+ZGOvVxQnFvZyPgK9X
 MQq/42EFhNXVTAMcws+V6U4mU2zlXxZ3s5gmWZVGMfeQ3RrySsY3GTsuyC2ozvgCfrFU
 lDwnVNy0qdASHdQdk8sgCHh0czZL13eD45cBAaiBu3OorS2QWz6fT2CVnBSCXrjLwQeM
 9mCpWpyIFSLiUG4+7Rxz+sdNq64/CM5pX4KDawrn7e6rO9Jeh+v8BqfaTq5y4+wRqxnj
 URtg==
X-Gm-Message-State: AOJu0YyBqU1ROvb8Xl4IJqIZVjDu4OttgMgmpW8HbWurIeu3NkkDy2DT
 WBKTFugcvUOBnShwsFHfcWhSJw9mJ5xZDDhqe8Jy0C3YH0TJvWT41eRm4dTU+WDdRT/yuxhjCkh
 H
X-Google-Smtp-Source: AGHT+IFc+xY6K6pznelAZWambCj0r/uDLlLGnReqrS287UEN3ZF0w59YHNM+mA7F03WbRGC+jM8ACg==
X-Received: by 2002:a05:6402:5186:b0:5c2:1014:295a with SMTP id
 4fb4d7f45d1cf-5c2200de37dmr18364778a12.2.1725381588162; 
 Tue, 03 Sep 2024 09:39:48 -0700 (PDT)
Received: from localhost.localdomain (178-36-242-203.dynamic.inetia.pl.
 [178.36.242.203]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c24b5ad63dsm4177197a12.80.2024.09.03.09.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:39:48 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v2 2/5] ram: rockchip: Fix dependency of RAM_ROCKCHIP_DEBUG
Date: Tue,  3 Sep 2024 18:38:55 +0200
Message-ID: <20240903163858.1155218-3-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
References: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
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

The RAM_ROCKCHIP_DEBUG can be used only if DEBUG_UART is
available, otherwise it won't have any effect.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 drivers/ram/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index 67c63ecba04..d707d09c1c8 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -15,6 +15,7 @@ if RAM_ROCKCHIP
 
 config RAM_ROCKCHIP_DEBUG
 	bool "Rockchip ram drivers debugging"
+	depends on DEBUG_UART
 	default y
 	help
 	  This enables debugging ram driver API's for the platforms
-- 
2.43.0

