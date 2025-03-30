Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FD4C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A9C81E6C;
	Sun, 30 Mar 2025 11:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iIyU4Ds2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9A1B81E06; Sun, 30 Mar 2025 11:36:15 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B293981951
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so464430366b.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743327373; x=1743932173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cilTcFI9J2BfOgiNmr96m38FThE/0U+q4xViFZv3gco=;
 b=iIyU4Ds2DAgjX2ttvEo/7h5SOq81xBvZUkGgtQvO54rhZiIWQDtZ1PKq1H5FWDWsTz
 69m/Du738+LqtOUCA7xNx0T+30fDUjfX1nN+OWhVh3BvuVj8kjb2FCfxmUHQ/KEFmoI1
 jt6ruwKuoPwu0bVAc9tukH+v1CZFc5JgJpdyFkP0B20c/Ofhf2BIslojKfu1NFz7ABKI
 60aFxrUhmelOyHDbsbXDK07B5snCoZ/ZOXiPv0td5TBNR6tTunYAr8JljMPCBLSTT/RI
 jfTEBjOfR0RnvGidQa62mm8a21a55Ysv/JO3eg2ebOMKegBQpuyJyRv+QeW8Utua2fIj
 M3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743327373; x=1743932173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cilTcFI9J2BfOgiNmr96m38FThE/0U+q4xViFZv3gco=;
 b=I6VYrdlOoYTf0UHO1QpP5iZE7qXLxEHTvroMdQACnCfyuHTozdyH6xbOsxLG8rzN42
 YYEadWnerYgf0D2HsOvqx8HruYmKXDkEr8jj7s2qcXicXGXU9LvvE249Wby4RN6nKwBd
 x9d0rXhtJB+RzsZdUrwaq2d1MM3fA4Me5TxbpUe7gAqZTVCOlyozW/kbv2lx7TS7qdA4
 BEmf79XVK39ZZZmeWnP046os4E7QEXyIOjxYZudd1gu4/SyoBn3M8sqa9qDuIyO94wqi
 Ibam0Vi1QdvmOeHfNCXxNx88cGShFAYhuK7uVa+I26P6T7jZ4LUt9Dzg9DZOnAlXDKtt
 X1pw==
X-Gm-Message-State: AOJu0YwJv6JzXReG1kASU6OS5HyFQtJADCnUcoPaO6xC7lqvWquRWIIX
 T1xBYZmJKB3zZsJ25yZeeaJCdW6h7lHTCEJmfOyAQba1s8vCkxFr
X-Gm-Gg: ASbGnctyBUQdf8IHaoouib9vwhqnbAc1eyz6RhOTeknCp+AKikUOLS6ggiJ7FTiWbqR
 EV9cOaCfo3MBNV/9T9eYpWN7bp+wkKlEgQIHAFcu5dQHT/SMT0m+63rr/9ft83WQY9hhCdLmJXH
 4JwbJqodJCnphJih6eVpJg0HwWZBg4hNGr6sHW+BYhP77Uc+5psefEifnqGv2dxlTHP72XtXcOX
 re1h+RZEcsy0Paq11/SbcdHH4Nx3OYmsJaKxghaHwSg+lMoN1sUwau9uc6MSVgNdABX6zsWl7o0
 irqkgYuXUB/FkRI3AvQc2rHjE+Izh4YrxLEAEY3xrINGHdA=
X-Google-Smtp-Source: AGHT+IGQQasZcw0O135ThGAeZeEGyJIKZc8F/MPnD6FnJgOvXQbaUkbZ2yXnrV0KUgocWe5T0Y9bjQ==
X-Received: by 2002:a17:907:7f07:b0:ac2:55f2:f939 with SMTP id
 a640c23a62f3a-ac738975e33mr415349066b.6.1743327372954; 
 Sun, 30 Mar 2025 02:36:12 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71971b7cfsm455273866b.183.2025.03.30.02.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:36:12 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Alban Bedel <alban.bedel@avionic-design.de>,
 Anatolij Gustschin <agust@denx.de>, Thierry Reding <treding@nvidia.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/5] video: tegra20: dsi: add Tegra20 support
Date: Sun, 30 Mar 2025 12:35:56 +0300
Message-ID: <20250330093600.10871-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330093600.10871-1-clamor95@gmail.com>
References: <20250330093600.10871-1-clamor95@gmail.com>
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

Existing Tegra30 DSI configuration is fully compatible with Tegra20.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index a2a22fa0fe2..a96fba01ee4 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -1129,6 +1129,7 @@ static const struct video_bridge_ops tegra_dsi_bridge_ops = {
 };
 
 static const struct udevice_id tegra_dsi_bridge_ids[] = {
+	{ .compatible = "nvidia,tegra20-dsi", .data = DSI_V0 },
 	{ .compatible = "nvidia,tegra30-dsi", .data = DSI_V0 },
 	{ .compatible = "nvidia,tegra114-dsi", .data = DSI_V1 },
 	{ .compatible = "nvidia,tegra124-dsi", .data = DSI_V1 },
-- 
2.43.0

