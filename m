Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE67C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 11:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA4E87D60;
	Tue, 13 Feb 2024 12:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NeI+ovdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2760787D78; Tue, 13 Feb 2024 12:44:01 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544D387D65
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 12:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d7517fe9d4so2327505ad.0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 03:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707824634; x=1708429434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6UqOYbvg+36qgj4QzYS01H99PvO+g6RpS5naGpHSSw=;
 b=NeI+ovdr/ZUa7CFjac8kjakpg8OO7fRQooAnZazXxVJ8a5VYayXMZVETkg7EZRd5cx
 /OOWONh/O7PnQjv5EKi+qPEjRQKFzlNVgXsptOQDVaqcW5V1iKgTmWGXmNqJ9RBchNms
 fVSFAFV9Z5Kfblh1frrfLJVAwEDWECAUEbJsmj18TQiLaEnFCzP53wdk5/fc6ssz5th/
 P5afozJgUbEzehXlXy9tsy1+0FR/Fh3q2aVKeGVKIdkd01AKjpxhE5SABTEq8IQspvNb
 jM3dbgS2mz1ENQKbG51eQKM6uEXd75Q3njTGVRbK9srdY+MtCjfmvC/zLgbWqwdxc/aF
 Dgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707824634; x=1708429434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6UqOYbvg+36qgj4QzYS01H99PvO+g6RpS5naGpHSSw=;
 b=BA1p/1TFjTcGp1IEux1moq2C9A6MGk1NjookFAaoHnhzvbzmCtnfT06uaIaICZYX2/
 WbxL5T8oVjJG2F8Y7XOPmNy4xSxDBapBwSAsd6tU1bj2kNkERRfYJH6YkXKzt5SxieTw
 4o2Os6PjASmsyeq7bl1a5SZ8SZPD8/wtw+CV1uLDtwhzOlqKZwUkfSx22kU9o40Dn6qT
 79nRJVnkt+c8eKNk7y6ZFuau+Uh/DwHTFCxXyaRwwcehoTe+HT0YiH2T+jP36OwF3nd2
 LTFCPkex/MSrN44BYaVRGPipKvZ98HdJNYaSkTvRFVtUs0VsCFWhKBMUwn/tUO/Copvk
 tqCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuxnZCncVBDd9pK5Yx+zl4gAMHwzEjGlf8wjK1FTn/ZTfRZGju0jZF0JWqEIdmh7zR8cUAeZ8xCwHsggkjDPrr8GkkWA==
X-Gm-Message-State: AOJu0YxvHDM9tF1U49M8pb8wfFk3HXe/jF7TWL7fbHNjQA1LzZV4f4o+
 eAtPGFgNWsO3IarojtXaLpkaYmwnrnDS5FGkrP2AON1v/Zl9/wOZ
X-Google-Smtp-Source: AGHT+IEZRXkhrUXXL2NzlPhm0qO0nDDJy81OKVuo79CFFqlnO+uL7zMKB2MULWG0poHpLQpAyW4NlQ==
X-Received: by 2002:a17:902:e903:b0:1db:403c:68ba with SMTP id
 k3-20020a170902e90300b001db403c68bamr757308pld.0.1707824634603; 
 Tue, 13 Feb 2024 03:43:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU17/9ziz5CjcrVdL5QntWDPtvCl5SxETA5GW1IE+ACpB4HcuQwazZzlqQ3vJfZZrBcYS50zbBtXtZQMYMxWQdsegw045iUA/v9jROrB0JUZ3HbKmaQliLENJltFILB6TJR2gklmq+SjnzC2EXgcDpeCo8=
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c0bb:2b3:6958:833])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a170902f28500b001d8f0e4bc32sm350795plc.144.2024.02.13.03.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 03:43:54 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: ian.ray@ge.com, martyn.welch@collabora.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/5] imx8mp-msc-sm2s: Add mmc aliases
Date: Tue, 13 Feb 2024 08:43:40 -0300
Message-Id: <20240213114342.2728075-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213114342.2728075-1-festevam@gmail.com>
References: <20240213114342.2728075-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Add mmc alias so that the eMMC is mmc0 and the SD card
is mmc1 to have a well defined device numbering scheme.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi b/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
index 1a7b530d9f..ce61ca6671 100644
--- a/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
@@ -9,6 +9,11 @@
 	model = "MSC SM2S-IMX8MPLUS";
 	compatible = "avnet,sm2s-imx8mp", "fsl,imx8mp";
 
+	aliases {
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc2;
+	};
+
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		wdt = <&wdog1>;
-- 
2.34.1

