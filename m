Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CCFC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA2FD885DD;
	Mon, 10 Jun 2024 16:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fbJn2kgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16405885DD; Mon, 10 Jun 2024 16:59:45 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3CFA885AD
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3758fdbd2daso10163095ab.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031581; x=1718636381; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJXFsCW6LCl1bXkmZ8sKbXEiUPqgjCbPoT+lGmHDHLY=;
 b=fbJn2kgYTAoqb9MBoJy31yt3F1auJaWpVXmiE+0WxzsXDxCt16v3E6k1+i9Yp4ajhp
 vu/kfXcSiMo/L32mipsSOZAG/+u/t17KDYhp9NPUCaLnFrp6F5aAICn5fOyKUv/XIOMF
 I28kcFf53yhe3OwAzL0pf9YYP4ebNfcO0k4Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031581; x=1718636381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJXFsCW6LCl1bXkmZ8sKbXEiUPqgjCbPoT+lGmHDHLY=;
 b=HNMaxBBxpE1DTyyF4Jn66ugJFiBrgH9LmU+7SmjVarhEzwwIDGCE32Re4+pd5vkCHS
 WUKrtVlMeEfxOT7pq/9VLtYq8AM65QvnWL85vGMgqjENDSGshP6rE/e+YJo+jfXnCz8m
 Omb4Aut8fhsiCrvH74rzHt1/CyhP3PvFY2GISvJRZ1kuvKz7q4X9CopUy3Nl4Ht/VpAk
 06NujGfzzAyrIhN7c/KsSoJAaElJC/gbFT7IaKn5ngfZadrnj/0ycXfCHvrIcR5EjFZz
 TErp9y/VsZzqsp05U7ZQFy/lg3DClD7hbYdJlC55kZy01fbsEvtbDbU3opYrV7nTtavl
 24yw==
X-Gm-Message-State: AOJu0Yz7pODd1xOeupsSmcnZyWqKzaJbvloP1wm73lPyDRCk8LgDzx0a
 w0Ib+G14ukCRHdA/jxHX06z8pFPmv5u7cNkiHHSj0J6K9kK/8ftyb+rk3YAWT0WQih5hfwNQfX4
 sLQ==
X-Google-Smtp-Source: AGHT+IGUsgoY+z28GkxfRfoezDXJ0ZLbqdsxdYK0VwmZjT62XqJ+QbeQg/WdAswW2NuHD085S8JAWQ==
X-Received: by 2002:a92:c54e:0:b0:375:92ed:254a with SMTP id
 e9e14a558f8ab-37592ed4917mr71237755ab.18.1718031580656; 
 Mon, 10 Jun 2024 07:59:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ac6104dasm2526885ab.4.2024.06.10.07.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 07:59:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <l.majewski@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 4/9] power: regulator: Handle autoset in
 regulators_enable_boot_on()
Date: Mon, 10 Jun 2024 08:59:15 -0600
Message-Id: <20240610145920.3302001-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610145920.3302001-1-sjg@chromium.org>
References: <20240610145920.3302001-1-sjg@chromium.org>
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

