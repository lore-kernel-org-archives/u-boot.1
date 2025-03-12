Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60003C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E4D81CFD;
	Wed, 12 Mar 2025 19:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IZv7NCz2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D1E81BEE; Wed, 12 Mar 2025 19:15:40 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7EBF8192A
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2bfcd2a70so20823666b.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803338; x=1742408138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDg33DoLAIWPlSaA7LXKuVv58UMVDzDFB5l5IuSZmgw=;
 b=IZv7NCz2oILq1k/oNoVJm7kMi4nzzwBcX6PTZMqDjIXu95OtJSn8DXLcSTaV52xdo1
 +uc4/2eg13U/y2F80bEv8P0Y5K+KZVsw3kUD9wsmZ6SVnVFNNtDk4fBx5K7PJU61HR1Y
 6kmtrzW8xFggUxQjgFhAuDkGzy8SK6I6HptLUCh+coTKGtjG7J2/ikI40X1Ny6Q5fyk+
 OzRKboyHq11Aumslr58rRvrpbeeK1Vi2q77lxZTAtFPZEYXKIhzYwLfzL2iSJqTeTKMn
 JA67WJl/ZVlynrjq9QwQ9c9N0zHONYTrPtEZM7Y3GUzJWXRoHZ90kgiGqkPmUfGEg0ie
 2uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803338; x=1742408138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDg33DoLAIWPlSaA7LXKuVv58UMVDzDFB5l5IuSZmgw=;
 b=NW2zytT7QuFGZ5bbIruEbeCB9N0zuFXJseujSVmWzZ+ZudtOt1AKFuXNigDzXtzKm+
 T4fOtkYeZKpWV5oxEHhIC0n6VOaxZSLQNrT2vPlBa5i96D+2lFSYFK3PzGHyhb99KlUy
 e70UioNLcF2e3bCs1rZF45bqGFMgL6LVfg9g+2DmDRIpYPNIt/nfdF5qNfBm1cDpSEru
 6xtWIg50e9KsnpY8UAByzXqd4rqBtfp0dxBb8O0Ckm9QfR+e/yzhpugB8HY2hdVSePTh
 ypxY3nEuztZol1gN1sc74PBEBR+9VxP/832WS/d0eJ18m3hzP4FgFYsnzS492cKyzzxq
 Xp9A==
X-Gm-Message-State: AOJu0YxNR7EkyxJSYb0xC4LAGAyeKST54IB4DP12hmNt3NkqeugN6iWt
 X1Sy/Ja2YS57HS13nr9xMi0/pXSY3oWhnM69RJBdsLLlX3U6b939
X-Gm-Gg: ASbGncuYPq4IldxxKkK60OHI1l7D4nITnaIHoQiR6zsyDuOG4myGhaARMJ0abrPrCku
 o0jCnih/kXffi6hdqWefqeqbEjaVkUA7/y0wVe8TlmjZl9SQKLl4a+sPbjRHc1zFlQpd1R3FgwJ
 Lw7Oswt0mDrG9Xh0fZ7Mf5vIqcXtF07mN/JoRQC5TROJGZ1dXSgOvUIL16z86phhnNkmZPJ2MxQ
 UkwMY1XJ/KCoLQ1kZd6Ploi8EZrKkoNx9rtcygRc7AvrUqd0LQYhkFRQb8YXtv6aWQcuJaejanc
 RZax6e/gSYsN94ASIcl/CzLniAV4xccPP3dG
X-Google-Smtp-Source: AGHT+IHeIph97S46LsDgNM0hJRqZICRWMnrmIsnspY88UHscCq/uTZarX6bLdPlSu1K3DH6xOiecSQ==
X-Received: by 2002:a17:906:ef0a:b0:abf:6ebf:5500 with SMTP id
 a640c23a62f3a-ac25260afefmr690711166b.16.1741803337897; 
 Wed, 12 Mar 2025 11:15:37 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac28c11561dsm641906666b.145.2025.03.12.11.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:15:37 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 04/11] video: renesas-r61307: add missing mode flags
Date: Wed, 12 Mar 2025 20:15:16 +0200
Message-ID: <20250312181523.121313-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312181523.121313-1-clamor95@gmail.com>
References: <20250312181523.121313-1-clamor95@gmail.com>
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

Add missing MIPI DSI mode flags.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/renesas-r61307.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/renesas-r61307.c b/drivers/video/renesas-r61307.c
index a3697bce5ee..e3623d72635 100644
--- a/drivers/video/renesas-r61307.c
+++ b/drivers/video/renesas-r61307.c
@@ -281,7 +281,8 @@ static int renesas_r61307_probe(struct udevice *dev)
 	/* fill characteristics of DSI data link */
 	plat->lanes = 4;
 	plat->format = MIPI_DSI_FMT_RGB888;
-	plat->mode_flags = MIPI_DSI_MODE_VIDEO;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+			   MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM;
 
 	return renesas_r61307_hw_init(dev);
 }
-- 
2.43.0

