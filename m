Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01C1C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A1F88578;
	Sun, 23 Jun 2024 19:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oQ/EQ/Mt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B828855F; Sun, 23 Jun 2024 19:53:30 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED40883B1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7eb75c0d0a7so125734339f.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165207; x=1719770007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJXFsCW6LCl1bXkmZ8sKbXEiUPqgjCbPoT+lGmHDHLY=;
 b=oQ/EQ/Mtx5oc38gaxDXEBN61qZ15Thw2KWzh0Tnc4XWJxgbHPdVa7xxDUOt5ulLYiN
 Qz8dftfYUJwpD3rlvX565ZVFNHLqk6SSGKc+SoNQgv7tmOmj45fCyTUHjj/IJxj1sVL7
 sTtLY62UsYVjd5mZCC78hZdKOL7gG/N+4HE+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165207; x=1719770007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJXFsCW6LCl1bXkmZ8sKbXEiUPqgjCbPoT+lGmHDHLY=;
 b=SbLCz9xi/KzwdOG1t2DKhlPQmPkZRDVr7IEXZLo1SRGM6kwQ8m3f7ibEi6nxFt1iGk
 tHjbOi+hgtBwr0hXCrOn9wc6igbwHa9bedSuo874qYERZlvnEuFgu2dkpsG40PO1fPqe
 4YB8DGAOkJ1o6xf+5IJs6oOdMHwQ4s1MyXNm3m1soaqVEf3RuAKo3svsAWTZisZJj4Nv
 3k+ei2kQE2WqhZ7/2KmRRM+XcK86gBL4Ju2VMDn2IiXSrchIoqT03ib2rjUMQYOA5Tpk
 HD2Y0k+4f9fTlQkTUFQ+95AH6UfXT1/Jih3v835ScguGR3KoBMzJrhikvslXBYM+7LhQ
 sWrg==
X-Gm-Message-State: AOJu0Yws7TAsqDkYMfjl6jjKynj/weGlJ3ARZ/vhvWBnjiTXRGSEIucY
 epatNIrldAsdwR+VD+h63jWS5HApH9DK/E9chHfbxVrlv8yInd/yFzphy8AE3+q2Dr6tDYeXuek
 BwA==
X-Google-Smtp-Source: AGHT+IESvqIdE+/Rwc6NH3dG0rb9wjhZxi1JkxuSn7wpf7/6xv5r6bukQ2WE1G2XRX/tpyTks5ZaLA==
X-Received: by 2002:a05:6602:2ccc:b0:7eb:7351:8beb with SMTP id
 ca18e2360f4ac-7f3a4d5d227mr315663539f.0.1719165206751; 
 Sun, 23 Jun 2024 10:53:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v4 10/16] power: regulator: Handle autoset in
 regulators_enable_boot_on()
Date: Sun, 23 Jun 2024 11:52:56 -0600
Message-Id: <20240623175302.1463973-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

With a recent change, regulators_enable_boot_on() returns an error if a
regulator is already set. Check for and handle this situation.

Fixes: d99fb64a98a power: regulator: Only run autoset once for each regulator
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/power/regulator/regulator-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 77d101f262e..d9e1fb68295 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -518,7 +518,7 @@ int regulators_enable_boot_on(bool verbose)
 	     dev;
 	     uclass_next_device(&dev)) {
 		ret = regulator_autoset(dev);
-		if (ret == -EMEDIUMTYPE) {
+		if (ret == -EMEDIUMTYPE || ret == -EALREADY) {
 			ret = 0;
 			continue;
 		}
-- 
2.34.1

