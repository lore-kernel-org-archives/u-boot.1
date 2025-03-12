Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53651C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D6781A0E;
	Wed, 12 Mar 2025 19:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J0qBl1Yw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B20DB8198F; Wed, 12 Mar 2025 19:15:38 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B8A38056A
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac2bfcd2a70so20819466b.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803336; x=1742408136; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsukV0sZw08GHx9KKlgyitkJydTX30Hy1BL6NcvcXJk=;
 b=J0qBl1Ywb25G/q1V8Wrm1ddSF1H9H3S5D9owIV2OmQ6GM4z8OUJFo1JySgkqxKAmJa
 KnicUFHhz0PmHXVdW+XtFupSKse2vm4wT541dlJotzGukBmkHWLSOtmEG1tOuX2XA2+u
 AHHtuYXYg9DdUsF+Rc2ptLD0zSJ0lIcgynZ6L9lXQvwd+JTKBJrKGzulAbIcPvqDolPg
 7QVe3J+La8ebVEITIBHApY9XlT6vUltfZ6KbNZn585Jy1QJHBfsibxiAWd5dg1J3O4It
 IK7EtA+OFqPYKHhrB8CmWDCMRXJnvsbTuhgqWJ7UAPscQUWXKYNtiwqcFg/tOf4EF1KW
 a/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803336; x=1742408136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsukV0sZw08GHx9KKlgyitkJydTX30Hy1BL6NcvcXJk=;
 b=L9bsq2BrfQjj7m3o3lP+xggOAjndIh7yBF+FZ8gvhc2/VLgP2T04YDnxXcqPRjpa8B
 Il4zH3jqP7bLGyBKx2YndblirpBfBeis0uWIAtS9U//PYEORvCWn1R7jGrod6vkc9v5s
 YgEceNtPyHfPFle7ygyIEWn/NoyfTb6NkiwvAgjOQmkDeG6gxFD0L9eACYDKrYjaOF9j
 vowNRHsMy48pGCyWXXbxJ4j2yU4FC2eXffjYRsAsobSB0yhjKIsPsYPAjj4hp4HoulDs
 NTw9R6C9QQ4okHLWkfSzul/5iUN3+IgnU0Z2ikaBEcgGVoVko5D/1RKhKACYm47gbRZ8
 8cuw==
X-Gm-Message-State: AOJu0YzQ4Y5GpHJ5VPqjFK6ijdgOOOgBE8nzabieYg3x9iIzyIS+zlpb
 vAgRln8z24CWC2n5snEBRnZILQpHLE7AUKxgUxKWEDmNOQahb9cf
X-Gm-Gg: ASbGnctnK45NRRBLD4k+/6liH0mJvsSh6ahNfejz6KchVIFaO65/YGRxBjYly4sBV74
 rt55Ww3lHoyK/vcKoRWQkjsWrOTdTGbmwmDSjX5IA+W/AL86vjecWD8ANFtyN/NqqFEobkoomCt
 K4M9aIMXAth2i9JgPBC6RfQbaUnfCXVSkmiXEUQPo6uKeSh1cjgdHL8Pluhpj3J9IZnW/wUcRyy
 8qu41zGDJzpbJMrau7+JALMiiArq3TPkw9wEHuRxl9ZteUX80g8/OqpIsWu4W57RB05GsxkpyCg
 Bx2Kw7rKS3zWKpP9qWUzZW49wFzqYTJodmrzESfDjLTdQ08=
X-Google-Smtp-Source: AGHT+IG85q7+XW0XO3J6nI4OZ09HjAiaNNxLzpSSDAvABOHkWxTYKRv5Gu2PMs/lMKl9ndFQQjyuzg==
X-Received: by 2002:a17:907:6d20:b0:abf:68b5:f798 with SMTP id
 a640c23a62f3a-ac2525af698mr626264166b.9.1741803335851; 
 Wed, 12 Mar 2025 11:15:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac28c11561dsm641906666b.145.2025.03.12.11.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:15:35 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 02/11] video: endeavoru-panel: add missing LPM flag
Date: Wed, 12 Mar 2025 20:15:14 +0200
Message-ID: <20250312181523.121313-3-clamor95@gmail.com>
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
 drivers/video/endeavoru-panel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/endeavoru-panel.c b/drivers/video/endeavoru-panel.c
index 90f838ecc20..9950ff8bb05 100644
--- a/drivers/video/endeavoru-panel.c
+++ b/drivers/video/endeavoru-panel.c
@@ -236,7 +236,7 @@ static int endeavoru_panel_probe(struct udevice *dev)
 	/* fill characteristics of DSI data link */
 	plat->lanes = 2;
 	plat->format = MIPI_DSI_FMT_RGB888;
-	plat->mode_flags = MIPI_DSI_MODE_VIDEO;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
 
 	return endeavoru_panel_hw_init(dev);
 }
-- 
2.43.0

