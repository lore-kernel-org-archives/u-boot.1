Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E28DC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 549A481FC0;
	Fri, 28 Mar 2025 16:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cx3uxDX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A9781F0B; Fri, 28 Mar 2025 16:36:07 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F36081EC0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d03d2bd7d2so24033095ab.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176161; x=1743780961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDPrq9Kq/Wz4GyoNWgrbCKU9ENo7H4aSflocEL8+QXk=;
 b=Cx3uxDX+5nmXRKsdWf/xfwIlniHmiMEf3g4X6BV9Qa+rypCe9T+NuSEG9g89YRgidD
 j0EHrCLVK4PqyJmQhypOrS8DMI4WNYJNjLaVtIAFTJz6mXbkbeo64WFNfi10Kchxr9pb
 ckoERTy5PVuMcYJ1nq/a+t3F/n0v85Rh3DJrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176161; x=1743780961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDPrq9Kq/Wz4GyoNWgrbCKU9ENo7H4aSflocEL8+QXk=;
 b=JGjciTk4d8IhtdL+D/zXqc53F3KRV3jsITmo+oPpfgMWX0bR5fBCaU1kPpq1QBFeL2
 i/xIPwwUKdRY//5d3+cu/LhWRgHwK53wBnDBxC0cLuvnP4zTYSp2GkB1+kr4/zpvmPei
 2yHvRVXtpdS3C6D3huuTBbQ6orqFvm7tjENTCaVWV9xWXY0PVh7BVA28wBoQNcpSUWxI
 uMbTTRxCSo7VbTZArRAFttfBUiYMz/C8GmfRiRlKcUBW+f+msaUeVwuWwnXkI9ZoGBmC
 lAEfAd0MWtawNNx5SYtc5+i9MSM50X7lctbQCQFC12i59FqaoqkaGFN1ozWn5SmY7GEK
 Ap+A==
X-Gm-Message-State: AOJu0YwmUxipBXq6gEOC+YJvzm/q1QfKk/e3dD3vvkJTz1ds48NvN0ps
 12Ib1XsJ63HH3ButXqAQEFsD2URg7cJP6hA/cfBsOImmnp6+7A4TIZy81o2Rw3VbOYUlm4BJSwQ
 =
X-Gm-Gg: ASbGncs9M/mmAvjcHX6mYvgO9mIwr4yyyaZFxyE1FxdZWD6fWEt8EacO8uChFCawUkZ
 4o1r2RZOQCmATKtqU/KYGZ1xxozc8Q997xVxgcw79VvhLHC2iwa1Enu8BgPtqkxLpNCYhBETo8s
 nCAgKdzLw8claDJNAcAprNsMwZS0gG+CkHKQts1PB0XJu6bxJDjJ8V5Y9ERCcykaOU8jIfxpgyA
 CzEeHVtyqpwkneBkj/OpW3T5t4uWkrcCElLMZ4yAdkxl93FF35Cc4Hv1mHBFi2oRX2nvRWR6ih6
 W/8tR7Wh3GytleVdAtYM9rrh9ffIOaeRXh7ooxopZqxOGp6c2UCUV+/iei+M0V1Ml08QFIWmn2+
 a20AfIg==
X-Google-Smtp-Source: AGHT+IElYVviiE1oE6rFS05EtxvQ90H/P1n6MyFYeQcgcGUBKy4Zl9jPagg07bvUu5ip234NyeThMQ==
X-Received: by 2002:a05:6e02:1d83:b0:3d0:237e:c29c with SMTP id
 e9e14a558f8ab-3d5ccddfa31mr96395035ab.12.1743176161087; 
 Fri, 28 Mar 2025 08:36:01 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 10/31] rockchip: dts: Use the new binman template for the
 SPI image too
Date: Fri, 28 Mar 2025 09:34:50 -0600
Message-ID: <20250328153522.3555472-11-sjg@chromium.org>
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

At present simple-bin-spi relies on the u-boot.itb file created by the
simple-bin image. Use the template to avoid this, since Binman may
change to process images in parallel in the future.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
---

Changes in v3:
- Keep the filename for the SPI FIT

 arch/arm/dts/rockchip-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 1e4d6f71123..fb304540787 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -207,8 +207,8 @@
 
 #ifdef HAS_FIT
 		fit {
-			type = "blob";
 			filename = "u-boot.itb";
+			insert-template = <&common_part>;
 #else
 		u-boot-img {
 #endif
-- 
2.43.0

