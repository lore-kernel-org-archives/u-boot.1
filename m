Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C73EE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F8CB8025C;
	Thu, 12 Dec 2024 11:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y0ae+1Vn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EADC08021F; Thu, 12 Dec 2024 11:21:39 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C3AD80285
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa66ead88b3so74575966b.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998896; x=1734603696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUbWsHOFXiRRECSzK+NtK1EsU2JRDh0ZCZDMfk1s7Gg=;
 b=Y0ae+1VnHotgv4ezeL8TEWkqETHYI599jCLI5mSR/qbA1n8+Rg/68G766Y16iwm/C2
 lqYRRhYWApau23rHZa3BmATrc6ZiKf1n0Z264g5gKA6a+Epgm88hjBqeRcJBJiS4Nx3f
 GNkCm9qzaIQR6/+ALczE8roNBOSO0nJCPqEZcskx/9BBp/ali3JXHAl1LbkS9Bt28dxO
 psv3gKYAfpCIkJJOb9zjf1YV4p341On2imINDURq48RrUB8u/CE37I2ODGjTRYriekAr
 cy8bC/rPrvQQ3+cFrLlzCjSBi+PtEKl4eFDghqdGzB95tN1jjRuZjkO5I/igTBZEo2Z+
 nM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998896; x=1734603696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUbWsHOFXiRRECSzK+NtK1EsU2JRDh0ZCZDMfk1s7Gg=;
 b=EMNyTNjj2icaxtxm4OUTKEnpE8ZABvsGg/N/6XZunZt7uO4Slu9KrncEaC2NiDkWx2
 4ueRwAAyhCAwgfGQJfjakaZYy5AmWOkXdbWHcrqGzvoSeNkAejf7OfSyInBszYM7WeA+
 ZrePpe70pCsdrJ0BnmcXUlu1LVU8VROdsapQOI3iBzLVZCrOlmATQGNPZGNJjnfrIVUI
 rhwhXf5AoDiD5aKRxD1uwtR70/Q/ayzN752QUMF1i0lg8mMdH4/SwgT50M6ImCPr+R/N
 K+dRToENSaiLMSCUNyWRezo+l1HeUyXR/6FQEIwVH4hiCy8XYr1+oHkMh4BDEs1cld8v
 6eHQ==
X-Gm-Message-State: AOJu0Yw8auwVazViDqhdH35M3kwLGVCemYqxQnm2QPx0r4/p4NlG0L9x
 hnN2kJtwKVR7q30Q8yQeS0KJ9DLUYD5cFMqNEuKQk9wuBtHqqZZc
X-Gm-Gg: ASbGncuqEmgYWIzn6yjIDIudXMBZYJe6FWJBoCABqFEI5yb8B26DU1uR8KDiDj2PseZ
 2DpwCrLnArIVLqUlh24XJe+wQ240Q2IQuYPkKg1XSqttwxRiOcPk/GukAaYOEnwqbWM/Q8J41/y
 mPRwCZ286LZf7tBXBUZPyc6bVuBmkJpTBemATMJqCnLd53by4s2jbqT8PUDfAhn1Q+RpNZqSM3Z
 Kz/wfB5mi5TIBchFAPcKQfbt8WXsy7/zp3Iq1cGxcf1F/ZV
X-Google-Smtp-Source: AGHT+IEhChtLHKxaKczc/eBkOs3cQq0yUTkTB+QezA5r2P1FsPCPSNfX3qw5cnr9v/21VVPyDmlrIQ==
X-Received: by 2002:a17:906:319a:b0:aa6:800a:1291 with SMTP id
 a640c23a62f3a-aa6b10f5969mr644751566b.7.1733998896456; 
 Thu, 12 Dec 2024 02:21:36 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:36 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 09/12] video: tegra20: dsi: calculate packet parameters for
 video mode
Date: Thu, 12 Dec 2024 12:21:16 +0200
Message-ID: <20241212102119.6466-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212102119.6466-1-clamor95@gmail.com>
References: <20241212102119.6466-1-clamor95@gmail.com>
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

Calculate packet parameters for video mode same way it is done or
command mode, by halving timings plugged into equations.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index b65d2118de9..6cf6cffc0e4 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -683,12 +683,19 @@ static void tegra_dsi_configure(struct udevice *dev,
 		/* horizontal back porch */
 		hbp = timing->hback_porch.typ * mul / div;
 
-		if ((mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE) == 0)
-			hbp += hsw;
-
 		/* horizontal front porch */
 		hfp = timing->hfront_porch.typ * mul / div;
 
+		if (priv->master || priv->slave) {
+			hact /= 2;
+			hsw /= 2;
+			hbp /= 2;
+			hfp /= 2;
+		}
+
+		if ((mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE) == 0)
+			hbp += hsw;
+
 		/* subtract packet overhead */
 		hsw -= 10;
 		hbp -= 14;
-- 
2.43.0

