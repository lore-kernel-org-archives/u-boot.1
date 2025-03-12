Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1060C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 946B08198A;
	Wed, 12 Mar 2025 18:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hUxc4L+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F1CB8003E; Wed, 12 Mar 2025 18:59:29 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 965468003E
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 18:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac298c8fa50so28335866b.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802367; x=1742407167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCsPdPtJFYQLghwvgjhY7hcam7Sw9e4v7r8AtYLBTo0=;
 b=hUxc4L+LScjlc/iv4aXlk+AiapGCS0CcuO8WjUnBMdW5/l2Ju3q9Q+6jWIkS/02Mx8
 ZT5sadh8/1XJJ+A97nxT2jD6wf9Xn9UpBl/B6rRm8VF9L9XxFfxD26LH3U5BjG3r6y84
 97yhoWQ0vF7+xPOt5UP0jff5hSkGHUjBONdLYZHDCllYDz7Ss+zFoQMmR053RpKin/Rt
 GOmRIHQzegVPz7HWY4GxBE+Zrez8pmur/YliZGfxS66uTQMMXWp+uxA9pKn21IDlZWcN
 wjKQ1VkNI0JjKXCyfxyCV2CnUkXFESVh4c1vg1335rW+3xhZTeYJOa2yD7hyWmSj2I7N
 BoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802367; x=1742407167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bCsPdPtJFYQLghwvgjhY7hcam7Sw9e4v7r8AtYLBTo0=;
 b=UTPHC7FHGQ6rc/dxDJB8QYZe1eiBuoKnMn+6g/mpQ5CStiUT8gyM/+AS+Z2UoqIYMu
 4RkNFExipE0Ngrt2xlNYcJ/LJmRCki5ChJBL+TUK/el0f+9NWYa3PXO/FkdALvbjkTYw
 NxO1wZ3JEl+oCRqUOIz20y/GBR2anlJD158M16pX4AjEQOxU3m4doJSr1G9lm+BEa7oV
 Pdsz6v4gJ+W8VvoA3xakgY5OiOed7vlF5nYvF6IpDh0/B+ycbkpZ5ebAGOnl7B+MSonA
 xtaTauFQesB8+w4zgL93F/XBY8/WF0DtoFydEXBCY3I/S3cHD8YR+FQKVGeAMvDaFoFk
 s1ig==
X-Gm-Message-State: AOJu0YxYGfTw3WlRuclBl5KF7JW+CmiwYO2WBeZX0kWaOh5q/Eye6Kgh
 EcaPQAh49DRPziv+fuq+nwMlpKNsYw7ZzoVPhD4wPMuUpq8sp+C3
X-Gm-Gg: ASbGncsEanKfav6te94X99FJbX1gZSQreYbjjUT/BO7ymIk6O++l9CT7fiMDdjTH/Ke
 /uLD5J9IV/Gw4Ae1a7jDk4aD3iCcw4enVqtovUGWBbLQeo6BeOEFbxZk8dXirM8Q7Tc3+cEmWRh
 F3waTTrYAx9stYS6GKhyWMLc96GBK1OfxvZOKCId45MU4cibTNSb4MFj+deR1/Mt9OVS81hUgz0
 e3+67GATyqaNhnEObnJNrAzZHdyrki2srq4SonpT1BLDHIUEBlHw86J9es2ftzqhoMVdTx6YxJu
 JCQGs+/qXoHX6ovlD1ItkQkJB0mmNQLIgobb
X-Google-Smtp-Source: AGHT+IFcLFaC0ozdt296VA+sDGqQL3n7qPA7cFfHofwC/i+Bgr5pL6wXXCUdgzpzu9GKGAPoq9ipBw==
X-Received: by 2002:a17:906:c381:b0:ac2:ff66:dd68 with SMTP id
 a640c23a62f3a-ac2ff66e08dmr256279866b.39.1741802366814; 
 Wed, 12 Mar 2025 10:59:26 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2394825adsm1125291166b.56.2025.03.12.10.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 10:59:26 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 06/10] video: tegra20: dc: remove unused video operations
Date: Wed, 12 Mar 2025 19:58:53 +0200
Message-ID: <20250312175857.120313-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312175857.120313-1-clamor95@gmail.com>
References: <20250312175857.120313-1-clamor95@gmail.com>
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

Video operations are not required by the Tegra Display Controller
and should therefore be removed.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 904d0d205f6..516a397872a 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -635,9 +635,6 @@ static int tegra_lcd_bind(struct udevice *dev)
 	return 0;
 }
 
-static const struct video_ops tegra_lcd_ops = {
-};
-
 static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.has_timer = true,
 	.has_rgb = true,
@@ -678,7 +675,6 @@ U_BOOT_DRIVER(tegra_lcd) = {
 	.name		= "tegra_lcd",
 	.id		= UCLASS_VIDEO,
 	.of_match	= tegra_lcd_ids,
-	.ops		= &tegra_lcd_ops,
 	.bind		= tegra_lcd_bind,
 	.probe		= tegra_lcd_probe,
 	.of_to_plat	= tegra_lcd_of_to_plat,
-- 
2.43.0

