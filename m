Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6517DC369CA
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 10:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 986B1889E9;
	Wed, 25 Sep 2024 12:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NhyWvaSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 072C187E30; Wed, 25 Sep 2024 12:45:29 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715A887BF4
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 12:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d2b4a5bf1so917856066b.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727261116; x=1727865916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G+4ReTpOUtmkSQpioPKZIoLjm5DrynoaFyhbzdkJPUE=;
 b=NhyWvaShQPOASfP8C9+zgLnZufXyNQdk10CWXdCGKefUHWBNixGS5KbUbpDSCeHqIf
 V7DF4zNK8Ze0bV0MdhEG/lXuoT58iq2p2hM3VNwXRDKjFk3/vidEVYXBvh8JLJOH+U9x
 azqwn9pRxFL7KBOFpTupjQmuE/qslh/yWaeKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727261116; x=1727865916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G+4ReTpOUtmkSQpioPKZIoLjm5DrynoaFyhbzdkJPUE=;
 b=pBzq5p0DI/mV0QMJaCFdK/E1OqAaaBlM7DIXH1DgQ5ivAPFOYnGuIEDliCb998mIBe
 Qcdcgw2EFDBa3x7DT9B/VQnIsjwINs2YPOZOaYDPFnkk+aWeLgPjHzyNvWsMupuN+k42
 3lLqmbU0VIbbaTOyPzoKuLFH+Tihsn/1Fg/bRyY6Pq3IOTCmK71RKw9PMxXHj6xGZgJr
 d8jjSGUvhFRHZY0aJvgk+bgg9hCDMjV4IFe6inG8nCi+MwqHeyJkI8kSy5rf8SDzwggr
 Y6ZOrc0Jbit4cglzlxc4bE4IYNpYkBSkX5HhUgJF1fsbJX9ZLlbd2K0U1hO2DyhDRCUN
 OyIw==
X-Gm-Message-State: AOJu0YzdSn+FDVsLht1mc8llSgb4yw8DRa+yataZ2WeM7wd/5ELly6uX
 9tLYWB5lqzvidmYXLXa39JJTURIwsh7vwe4HfU6yBM1qdDXwtDjl4Rkxm4ju7akQYkvWZP66lKG
 UMQ==
X-Google-Smtp-Source: AGHT+IEk3kD+uOyPQu8pBp4pxNfVc77oUILcySn2sEhgQ8nT8FyzqI1h2FXlkhbs8jqlrg99L3Hr+Q==
X-Received: by 2002:a17:907:1c1d:b0:a7a:bcbc:f7e1 with SMTP id
 a640c23a62f3a-a93a035ce1emr227603366b.15.1727261116564; 
 Wed, 25 Sep 2024 03:45:16 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f342a7sm195352266b.29.2024.09.25.03.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 03:45:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH] sandbox_spl: Restrict use of UPL when not enabled
Date: Wed, 25 Sep 2024 12:44:53 +0200
Message-ID: <20240925104501.44457-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

With sandbox_spl we want to use the file-based boot in CI, so that this
flow is tested. The recent UPL change enabled booting via that method,
thus overriding the file-based boot.

Correct this by using UPL only when the --upl flag is given.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 91fde8e1764 ("sandbox: Add an SPL loader for UPL")
---

 arch/sandbox/cpu/spl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 1c33a520c64..76638362564 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -55,9 +55,10 @@ void board_init_f(ulong flag)
 
 void board_boot_order(u32 *spl_boot_list)
 {
+	struct sandbox_state *state = state_get_current();
+
 	spl_boot_list[0] = BOOT_DEVICE_VBE;
-	spl_boot_list[1] = BOOT_DEVICE_UPL;
-	spl_boot_list[2] = BOOT_DEVICE_BOARD;
+	spl_boot_list[1] = state->upl ? BOOT_DEVICE_UPL : BOOT_DEVICE_BOARD;
 }
 
 static int spl_board_load_file(struct spl_image_info *spl_image,
-- 
2.43.0

