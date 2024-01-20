Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC79DC47DAF
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A8F87ED3;
	Sat, 20 Jan 2024 17:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G4F9FGT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63A4D87EC8; Sat, 20 Jan 2024 17:56:19 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B2887E1D
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so166828466b.0
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705769776; x=1706374576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPHHlg9FdQ90XVd55iFRYgLj7sgCzPVYVcdb591IuIs=;
 b=G4F9FGT4QDTdqSd28oV5w6LlcRoMosGiZRn3jer/fQoiaOhLKMp9huyEx31mBxpZ3+
 006QbkHp5gKRNx+hhWVNw0kmcQQ2BIrTH6b1V5mtFXaxJMtzceF5RGkz0dCSKyTSKChV
 RsGOIOrr5/dmz0X9DexvcvRSkb6IpMnfnYIFT7PKT6Amzyd+ZdA2iiKApl4r6PXpEAvO
 kuZMZB4AobjqS9EEyBQrQyI+u75grErz6jVSTdnI41C7SZnOasJ4WLr8jNlYDBt/Zqnn
 kCsJxwxRr/3pX2GkeoEMJDDQNXGI6luPbJjvugG3oM5VJ/fuG8nuFTbXwe7DPAbc0uHV
 rjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705769776; x=1706374576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPHHlg9FdQ90XVd55iFRYgLj7sgCzPVYVcdb591IuIs=;
 b=cbMQivpUolQ8f4v8P8Xyz5aG+RoMRuFhED/ZWpNORm+npqyyg+2VkH7n3knIdWzMHz
 HYrllCkTkFsF7rQbQJWqvIV9SYfPUdZH5ca9vR3Vep6dOteIfGE/eBwyoNvW7o5HPrF0
 tipKWaGhMf40h0F8gquqyZRnzglEcsRItORYE634o3AmEeKx2FlvKqVS5H4h7+tkATU3
 16Pkc2BPSX2IbSLQuLcPwkLcgVCOLGXNuh/SaI7A9xOJZ4ZFkkCIfMXrV4rd8MqOtJnP
 vPWBLoJyIBM5KW2aXoSEzAQPjMWISVyPOIpI9Plh6ScXtcao8za64zWGOgosLwtDJk/o
 lfHg==
X-Gm-Message-State: AOJu0Yyl6/TZD3qUwQU48gAqGbFyiFNqi9t61wVX8c7UX70kYOCGnPe/
 k6dPeV2FqFeUOEugKaNh7K9+IP1m8NyTGOMHN0UQsUoPoq8D04/iRQu91xEFX43OMQ==
X-Google-Smtp-Source: AGHT+IGNdQ4qDPA88SasR76b+g0fWTNkR3wmpuoHKZi4lJ6OjJOsmRiiqUYjlKBhpr87QK3N7pLSRA==
X-Received: by 2002:a17:906:7848:b0:a28:fa55:3597 with SMTP id
 p8-20020a170906784800b00a28fa553597mr788681ejm.98.1705769776114; 
 Sat, 20 Jan 2024 08:56:16 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 ca13-20020a170906a3cd00b00a2c869be22dsm11311548ejb.143.2024.01.20.08.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:56:15 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 02/13] video: tegra20: dc: fix image shift on rotated panels
Date: Sat, 20 Jan 2024 18:55:32 +0200
Message-Id: <20240120165543.10226-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120165543.10226-1-clamor95@gmail.com>
References: <20240120165543.10226-1-clamor95@gmail.com>
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

Subtracting 1 from x and y fixes image shifting on rotated
panels.

Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS Grouper E1565
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 7605e77bc1..bcc2748623 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -242,8 +242,8 @@ static int setup_window(struct tegra_lcd_priv *priv,
 			struct disp_ctl_win *win)
 {
 	if (priv->rotation) {
-		win->x = priv->width * 2;
-		win->y = priv->height;
+		win->x = priv->width * 2 - 1;
+		win->y = priv->height - 1;
 	} else {
 		win->x = 0;
 		win->y = 0;
-- 
2.40.1

