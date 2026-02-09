Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2743BE7E0D2
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B2A283C67;
	Mon,  9 Feb 2026 19:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Odb4i3RM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6AC805D7; Mon,  9 Feb 2026 19:32:29 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8BC68388D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-59e4993e00aso2644104e87.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770661947; x=1771266747; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OB2c80y7fp/IrjABpG7H9/YKuG4tGIJB3nZ7h2hIqZk=;
 b=Odb4i3RMl2d+b5cu/IJPEVF4L8mAJcS8uz9Op4N7Mxefg3SP99U3IU6O4CObJogorC
 qJGZfDUKh74ZPApLCkN6vVod6W/DAqgtpVDGGd+P3lfJbgDwrx6ZxIqJ55DtZ5rwCF/Y
 r7muITAY7WrZe8aNlT5Sat/kb/R5pwb1QoA0Ca+5hN7YZdeDmYWNDWKfDBov3KOaQCyu
 sa98NMyqHBmq2VaMMJ20AUsZ0GGU1ajxpldMHXX359HPOp81KKb7aQh1QuabI7JJFg+7
 pyskIuDubORzoPAJDHpzQ4f5MMba3cvIA3jCnSkDPWud5gKsVhNXdxmi0kEee2k32zA7
 R6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661947; x=1771266747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OB2c80y7fp/IrjABpG7H9/YKuG4tGIJB3nZ7h2hIqZk=;
 b=TPPOJQ56Ldc1oO2CLw63HkPaXdUcmsxfLrteMLGqmUlRbxb/skXxFV0sP2TJIIFaZ1
 /lTH5u/2j0mJXgwd5HUIno+HNxycL2+bDQVooint1SdYf5kN9DlCA+hGnOQVDYF6NVIs
 UxXJARoIEwbth6OuMgtZ6nfneKwI69Oz4rA1+9yU7agrbU8UPkv/1F/vIGNVHKm8GF4w
 uPotJzMznAAvNm9zrPfinz5g9sX9yBCXHGd9qYlQy3krQB1eM/HMTTGYQVqtVeBEkPO6
 Mh8q5rFHGXOrJamhI9WkZ34BDR1AahPlyar7m67FCJs2+m4XUbYvGln4mqBX6GbHaet/
 zPxA==
X-Gm-Message-State: AOJu0YxvJ/oVCkP2er/LItJjtNlmVsOtQA8mLaa0raSJJYNcbFGq/GAa
 niTpRkFdfggfAlq1NghR7p7NySlslfaooTdXVU+W8I4I8ZO7G3pxicZA
X-Gm-Gg: AZuq6aLchAV7aA8sHONVFoIlNef6KEoWvRcuIAcjrqVc9PqE60OKsYDV9euVF5LTzdJ
 eh/f8rY0J+mXYNi8AaBxpjq/rnSLB4MfuEAgoBxCAcmaWStjGjhe0wtYONmIhkQzbysBkWAjD/b
 IxHmECrKpHBVB9++2wj8hQlwxXFDIGL5bkmxby2ewL5v5+QXOi5VGois0PSiTv4NDZUcl2L/Itn
 LwhbGETaBYoClSHzfrA94NoAaSu0NSIQeU+AxSzo/gSszoecxXw57ceprxPP6dnu6acV6IQsplB
 hYPSuR67fhvgG4o7CRj+q/T1e+Jh/FDV9HEZtP9VjfWzhRF14/5I9hCTfLkiOSH4RnmjNN45kUq
 6VAOZYEFnt21hV/GOZC0a3MK3DZDsL+gEbccCQL9NXHAQ3l1MVejaOuLgIK4WBjyTboO9e11k4/
 9F
X-Received: by 2002:a05:6512:22d3:b0:59e:4626:a494 with SMTP id
 2adb3069b0e04-59e4626a625mr3163715e87.42.1770661946762; 
 Mon, 09 Feb 2026 10:32:26 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44d299ffsm2815391e87.55.2026.02.09.10.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:32:26 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peter Geis <pgwipeout@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/6] ARM: tegra: lg-x3: fix panel property
Date: Mon,  9 Feb 2026 20:32:14 +0200
Message-ID: <20260209183219.34250-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209183219.34250-1-clamor95@gmail.com>
References: <20260209183219.34250-1-clamor95@gmail.com>
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

Rename renesas,inversion to renesas,column-inversion according to latest
schema.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-lg-p895.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/tegra30-lg-p895.dts b/arch/arm/dts/tegra30-lg-p895.dts
index 988e772172c..a45d57b3e71 100644
--- a/arch/arm/dts/tegra30-lg-p895.dts
+++ b/arch/arm/dts/tegra30-lg-p895.dts
@@ -120,7 +120,7 @@
 				reset-gpios = <&gpio TEGRA_GPIO(W, 0) GPIO_ACTIVE_LOW>;
 
 				renesas,gamma = <3>;
-				renesas,inversion;
+				renesas,column-inversion;
 				renesas,contrast;
 
 				vcc-supply = <&vcc_3v0_lcd>;
-- 
2.51.0

