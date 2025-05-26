Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128F5C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E76C8380F;
	Mon, 26 May 2025 12:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gGv0vmbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58394837FC; Mon, 26 May 2025 12:16:34 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41393836AB
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3da831c17faso6913985ab.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254590; x=1748859390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fgd32Z8mAOjhMyiw79E5c3BGMC1fSVpg93TqXfz0Tc=;
 b=gGv0vmbHVSTmyaxTZqtYx0pjsWbqKgPGjZ8m0x/RpM6MF38dJFs6q0fv2EXQCF14wF
 zAJj/X0pErY2YuXZx2aMkCLsT5bUxgnZKku4F/pi6bJntgtFBzishW7D5dXC+wow2U0z
 m8CcpwzvGOChd+FGjdiUC6qXW7H8RS9tMzx0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254590; x=1748859390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fgd32Z8mAOjhMyiw79E5c3BGMC1fSVpg93TqXfz0Tc=;
 b=k/RROOkr0DsxL7JsAfjADUMNNcFBylf//lZ+P5JG9Z65MUWy4ycHKV8GlGeeZgCcoB
 oKFt25+2q54p9ivxyUPr9rvgaX/E5ENoXf9bKR93nMlPA6+NOo8HVgBug/eao35yWCA3
 cBO0egIjJUA4nuw+dEvxd8xKFV+mx2aKlF4/2Io2ZWE4/AgjjnVlGFy7P/PROJdBNkxl
 gdQ7kchTIi1O8Gs9ycynjtcWdViFICCMywdKZTs3RlwdDDPvNCe+wwGwLl1WPoDnEKPR
 89h8SYTb9EwaBkj7mbE6YLruR2iwQG8njZshliM/UuAdtZV4j8qgdfRQWfX5ue1PzkQ0
 zREA==
X-Gm-Message-State: AOJu0YzoFU0zQhEW0D3V7pxCnorNlSpb8Xr1bfazoiFuQsChqSVj+Drj
 ymJyn8mpfdREqMEG1kzjnt6krgfsyIwuCs6SfbWVdJIQB4ta0et5QU9/1TMLc7i1XQJD+b97Ewk
 Xon4a8erk
X-Gm-Gg: ASbGncthJlEe8FtAGDJyrszeUhlkstIAB5rdNXGBy0hPfoPLNpZx6WeXNFGdJpTgfoF
 d2lxFfKwpVd2BCi6im/w9UGZkuO1s2mUBvmSyFP7X2aJDR2HmbEiNbqLp92sGK4iktgFmeRz64G
 lU7KbSvTJxT3qCJELC1gkZCLCGaoSLrBAUx+2enEZ5kzT6rPkOXn7uLsSl53FlaMcOfqI8Ur3zD
 oLBJ/3h+X16KaCosVoZEDfZRH2jBszEkGRo+rq3QRnFmkSS06/7jMvXs4ejgNI9GCHFb1G+wOsJ
 vmPJjNQ+uMI85/CZtLajkiQ20SoN8n4n5vZD5szptt9UDVtZnsgL1D09C7noCDf0vIB6ADLGz/l
 P+hSJGBhgWMPw
X-Google-Smtp-Source: AGHT+IHfAjtwdWt26MqLUws7A7fbzvf6EHTX9mhXZDeXGCAsC1lGkm9JOcFEyYWsTUxxXA13+euN6g==
X-Received: by 2002:a05:6e02:4410:20b0:3dd:752f:53c3 with SMTP id
 e9e14a558f8ab-3dd752f5827mr21748945ab.6.1748254590465; 
 Mon, 26 May 2025 03:16:30 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 16/25] rockchip: Allow SPL to set up SDRAM
Date: Mon, 26 May 2025 04:15:02 -0600
Message-ID: <20250526101541.3254628-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

The current logic assumes that if TPL exists then it must be setting up
the SDRAM. This is not true with VBE, so allow this to be controlled by
whether CONFIG_TPL_RAM is enabled, or not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-rockchip/tpl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index a350ba56da7..a2d6079d1d6 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -60,10 +60,12 @@ void board_init_f(ulong dummy)
 
 	tpl_board_init();
 
-	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
-	if (ret) {
-		printf("DRAM init failed: %d\n", ret);
-		return;
+	if (CONFIG_IS_ENABLED(RAM)) {
+		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret) {
+			printf("DRAM init failed: %d\n", ret);
+			return;
+		}
 	}
 }
 
-- 
2.43.0

