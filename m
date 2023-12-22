Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADC0C46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 23:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B17874AC;
	Sat, 23 Dec 2023 00:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="rRHezpBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 399C1874E0; Sat, 23 Dec 2023 00:45:10 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 462E186BA8
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 00:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3368ae75082so1143860f8f.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 15:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1703288707; x=1703893507;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GzRMDFnV0VW56E3zO/ANvr2YDQudg3HncqgBPEhXOQc=;
 b=rRHezpBjIGjGasTjda7Cja8EHKBnqgK0zBsJu6NopTMkrCC0lGlVBnYSWiPPidtkq7
 YdetfgYMNm9TZu6zJqfrT7BYVsA8HdDS/+dvbs/XBCxomjx7HXUUHT0PAwxHjvE0bNt+
 Ho6tbfa+6Ug6gHaumJJwuhOJhx+QaAZ7+B2n8AldHPu22drw6/EbWt5l/CqfADIE1SUT
 JBDeufVv9rP+Av08egPLZ0ZuaNhQigI1nwHONuiwi8/U22IdbPJ13F2lpw/7IRgPz2l8
 TM6573pq1dR0yNm5Y2P/uwlr6UAUlnH8LGuVYNPcjxIRPZfReszn10vb4beczqZjjVnR
 V3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703288707; x=1703893507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GzRMDFnV0VW56E3zO/ANvr2YDQudg3HncqgBPEhXOQc=;
 b=ae+4hOv0TIxaYgMf/9fWyDZ+bdArfWtOIQMB08QkzM0IgbAdgayCSxBg/Q3dUEoAUz
 XjRy2qB0HoC7Sd3VAppBAaRlf0g9fViqmapdJPb7GxfsWvPOsMoj3227pQAYL9a82Qa0
 XhZCVuXuSIjxbCHaSEMoe8AjlnVzs3lV71dPX3Bukc0GhWjyeNVJmtpJwHKiQSA5q+E9
 SycBz4q21FyMwkHqVRAFEpTsLaVgL44dZ8hsoPU32xGRFrZCeGnwf5kTB9zRBcFtdv/P
 5JDZcTz/PtTuI4oG6zGQVcd5Mv3ke8GxSY9Zq+i4GvOg3oAnkWA6r7+Y3N6O8qi0nWa+
 0c/g==
X-Gm-Message-State: AOJu0Yx94y2S6w1DwrSNhwxDJ92/6MhKYiNpmOWIHIDCyF4PXywD3SDV
 1AYvxWoCqeAsi6bF+USuhr9bQK97FEnGVKkPTXwevjN67dg=
X-Google-Smtp-Source: AGHT+IFsDs7hFRh5vWqZEe02a0P1a0mIaJB4l3xdTQfMu9IplOknmlvnSzGi7Ckz92/0Ku9KXym+2Q==
X-Received: by 2002:a05:600c:1f08:b0:40c:48c2:d248 with SMTP id
 bd8-20020a05600c1f0800b0040c48c2d248mr1015758wmb.158.1703288706875; 
 Fri, 22 Dec 2023 15:45:06 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 he3-20020a05600c540300b00405d9a950a2sm15877913wmb.28.2023.12.22.15.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 15:45:06 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, sjg@chromium.org, jagan@amarulasolutions.com,
 jonas@kwiboo.se, trini@konsulko.com, Shantur Rathore <i@shantur.com>,
 Bharat Gooty <bharat.gooty@broadcom.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v4] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip SoCs
Date: Fri, 22 Dec 2023 23:43:58 +0000
Message-Id: <20231222234358.563121-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

Rockchip SoCs can support wide range of bootflows.
Without full bootflow commands, it can be difficult to
figure out issues if any, hence enable by default.

Reviewed-by: Simon Glass <sjg@chromium.org>

Signed-off-by: Shantur Rathore <i@shantur.com>
---

Changes in v4:
- Replace BOOTSTD_DEFAULT with BOOTSTD_FULL as previous version
didn't work on next

 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d812685c98..a0265b36ad 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1985,7 +1985,7 @@ config ARCH_ROCKCHIP
 	imply ADC
 	imply CMD_DM
 	imply DEBUG_UART_BOARD_INIT
-	imply BOOTSTD_DEFAULTS
+	imply BOOTSTD_FULL
 	imply FAT_WRITE
 	imply SARADC_ROCKCHIP
 	imply SPL_SYSRESET
-- 
2.40.1

