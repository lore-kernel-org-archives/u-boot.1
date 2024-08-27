Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FEBC54734
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 14:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFFA68641C;
	Tue, 27 Aug 2024 16:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="muEoxukf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 896C085B66; Tue, 27 Aug 2024 16:21:59 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 789DC8641C
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f3f163e379so86769271fa.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1724768516; x=1725373316;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKsx+WTjyVwiAjtDIJ8QzDhDuuHLb9yswm8yz/4TU84=;
 b=muEoxukf/5vIw46bNarcuaWHTUO8V5zmk2bzUgnskCSU5OlGlrqHCH6/n5IEqc28tz
 PdKG9JPLVITXI+osecnxZ2fu3Jvy+phLP94gK5EeAKNnYBJbIDIoZSgHMLwU9Xa9kTJZ
 MmYbl4TLoz9SsakUMcHLzd/Pgt7UavGFhO+qP9tsPgNUIBGaDTMFucj9U6NDjqOOfvB4
 PpQvF3oDBp7EiKVHcTYBUP9tHn7SDsdYzfIES3LLr2a2dEw42t2hmpwGfzyAWvQRbVYU
 RbWSuopYnJp9TBT6NNCBZKSfg+JXIF/uBJzzJzQSz70VT5O3Szch0/AJbErNDDO/7lwC
 DIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724768516; x=1725373316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKsx+WTjyVwiAjtDIJ8QzDhDuuHLb9yswm8yz/4TU84=;
 b=cbcGduLrrdocV9MFf09IEvmxU3vHkjLbeyAgxWPJIBgDvht3krm+aT6eJy6Xv9bFfB
 CSP7IC6B//2gbMcdBF7hZ0KYTbqR8wvSqtPbx+Nlz7w/00R7wUT0NeotiFz7i+ryiOPp
 r8oVKF4Tp+ChXsautce2r3RzAV2wUiMv6jGzYBA+f8t2hJiKeRkr3jpBbnp5YHDc/ONI
 fLMqOIWSKNENqLpPpDJ6J2A/EV4fHR8XmHDnw/d+GCkhJLSOFOuKfegGJMd8ZITu3BSv
 Ysz4EjjEZ+ZMagQkzkOYiyVMQdfi5SVOmOSUogbFGt3ILc8BT7QlK9I/wIbvdpfuPLcV
 j2Rw==
X-Gm-Message-State: AOJu0YwFeknbTrvTizGwB0jT1mCMFX+gO16pgkN+MBgIoolgyHYDW5Ri
 eg0Pk8ZKFmwxoklMsTxaYm1PKoON49Nv4QrjqDzGdIMcaEFPRIyonXNYG8ZsK0drHpiA32V5cLX
 8
X-Google-Smtp-Source: AGHT+IFV6WhYZHcGaLs2S1cilFb23LhFB6/1OMbzPgVU4X6ynkBcL8b58eCp3jev46snoJqVTS7aUg==
X-Received: by 2002:a05:6512:10d6:b0:533:483f:9562 with SMTP id
 2adb3069b0e04-5343887e18fmr11155627e87.42.1724768516209; 
 Tue, 27 Aug 2024 07:21:56 -0700 (PDT)
Received: from localhost.localdomain ([91.90.172.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594e809sm114854366b.219.2024.08.27.07.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 07:21:56 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH 2/4] ram: rockchip: Kconfig: Fix dependency of
 RAM_ROCKCHIP_DEBUG
Date: Tue, 27 Aug 2024 16:20:56 +0200
Message-ID: <20240827142058.594556-3-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
References: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
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
Add negative dependency to TPL_SILENT_CONSOLE.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 drivers/ram/rockchip/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index 67c63ecba04..4a6a6328676 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -15,6 +15,8 @@ if RAM_ROCKCHIP
 
 config RAM_ROCKCHIP_DEBUG
 	bool "Rockchip ram drivers debugging"
+	depends on DEBUG_UART
+	depends on !TPL_SILENT_CONSOLE
 	default y
 	help
 	  This enables debugging ram driver API's for the platforms
-- 
2.43.0

