Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06744C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA3081C67;
	Wed, 12 Mar 2025 19:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nenvyO8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B11581BC0; Wed, 12 Mar 2025 19:15:39 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF3581782
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so23873866b.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803337; x=1742408137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OSP0jbK/yeZFW+kc0kA6VkVxbs5MpALplE0poVCEuc=;
 b=nenvyO8lSRMJ6Nyc3MIKKR5zMeOR8Ps8iCEl0dKS5iFQDgKWDoYk8IiAdbZz22uIbl
 g2/S3ZWmjp663SZ6bL0ZOq4JiUjru5lx21r9cqAJMpkDcdsGL+X/E/Bg2MT2zyFinlHn
 SB/qH5qFE252okjWV2Uw2IskawC9o7stq8lY6WKTiBBOA+ftpDVwRtZuO1Wc9xZXKx2U
 OPsZAKjrw2l/EQd26Dg2kmZCYy4+hdTF6So+OH7Xczklb7Z+SOEnoyurjDk+Sn+7yCEe
 zMK2foFgud3IFMJG0ECirFn1h3nj6m9QaNN8PC6XmLiIv9JQgYbWYiGMFMpmIxzbVMwr
 siMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803337; x=1742408137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OSP0jbK/yeZFW+kc0kA6VkVxbs5MpALplE0poVCEuc=;
 b=fEb9Xx7Jfa1Yv7fGhFl+GZ7qG9YIDqkPBd2m1L9nn69hq4NsvoTUydvZ83Tvj1jjwG
 Y4CtjL9R4aNo3YujWDoAiq72ycxxx7cl9ADrCFmEo1pas2VLUVW7PqPoDASdHWXzar3F
 9ABzGOqs2MivRvkCPrNJpqdjAGDUpV3ejEJiZ0eVDSP0QmhDF8P4HevR338xjmoxPoqH
 7khni6dBiRsK3VQu2Fn1S0op0p8kNi+6WyBojVVHDa19CHxvoLTVsGFJ9HDXfUs9YzO0
 8VC5Zbrb0Cdikg5t+KNAj9EFp2NXxR5vzoPZwt2mDk3gacmBhzTBzsVo/1FUBxARoc9T
 nPRw==
X-Gm-Message-State: AOJu0YwXX8c5wn0/KgkzN8l2Kofx/u5eL01tKD4nLpHQEz3VkIEaId7n
 QKztAFBO8DXtiep44jcqeXYAqUPGFSYVsoIcyjER6oNwg+7yP9WeXu6e1Q==
X-Gm-Gg: ASbGnctRTngVUch/5ZGqWd5luniH7GSOwin4TnXGQRMsFCOJToiGUS6BP37Xom8xRlG
 Efcq0153nojnYQExWux3hJ2GbebBjs2WWhZjdPiggHwMNRKBV8kDJVKrku4KmEp+1ujiLZ6ZDZ5
 H2B6+pbIYmCI6zUcTBYZh7tvSjs525VAyo2iW1uZJ3NRJbN42Mp+rEwCCiMW+ILY4EXKGJAwNhE
 hDsdTL4DCfOoRpVwSjGCO6LY5qSY7M5cLn4zvTRL8UAd1Er+N3jfbdi+N7qdi0zf1A2ZkeshNjE
 Nj/Ceg0kPX35eJPJ8BbELf1Si48oye8TTEKz
X-Google-Smtp-Source: AGHT+IHjCiLgxXg8+1IsxtRxOeBm3I9LWV+P64Yerp4tG2H1YRlwvk52B0xzL0rXQwj1UYz7xFsTUw==
X-Received: by 2002:a17:907:3f9b:b0:ac1:e332:b1f6 with SMTP id
 a640c23a62f3a-ac252102b70mr2857692766b.0.1741803336865; 
 Wed, 12 Mar 2025 11:15:36 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac28c11561dsm641906666b.145.2025.03.12.11.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:15:36 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 03/11] video: lg-ld070wx3: add missing LPM flag
Date: Wed, 12 Mar 2025 20:15:15 +0200
Message-ID: <20250312181523.121313-4-clamor95@gmail.com>
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

Add missing MIPI_DSI_MODE_LPM mode flag.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/lg-ld070wx3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/lg-ld070wx3.c b/drivers/video/lg-ld070wx3.c
index 610a06ffe7b..3676e45bc65 100644
--- a/drivers/video/lg-ld070wx3.c
+++ b/drivers/video/lg-ld070wx3.c
@@ -158,7 +158,7 @@ static int lg_ld070wx3_probe(struct udevice *dev)
 	/* fill characteristics of DSI data link */
 	plat->lanes = 4;
 	plat->format = MIPI_DSI_FMT_RGB888;
-	plat->mode_flags = MIPI_DSI_MODE_VIDEO;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
 
 	return lg_ld070wx3_hw_init(dev);
 }
-- 
2.43.0

