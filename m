Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAC4D3E77B
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 21:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636F183CB1;
	Wed, 10 Dec 2025 22:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M/41Gy/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E658183CDF; Wed, 10 Dec 2025 22:24:31 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B84683CB5
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 22:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42e2d52c24dso106279f8f.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765401869; x=1766006669;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=13C105P1DiGJyacizPlfjDr4phSEU7PuKjEWdcYSyks=;
 b=M/41Gy/+v3fzCTqoVbMjhGYUuH8aKdzVs6LugUd32hsxIVpFDeTcGse4jwEBAkSmUC
 MEn3TduRmRI7NSOAO8TG2vJ+tPfHeOS0OwBGPUYWQOjxW9CHvqKxrWyAxXhA0cf6v+It
 gpi7vtU1bYByumTCGQC1NgS5tXQ/xQ1gdvu9y6UWmt3mDPgLjD3HOcvAEcEqxJ22F2G+
 aVM7sjI4VPE0mCop0PANqLqCPRxItCIuxgm5IEljfG1Hx/yOKFBUmoHTNNvKKoOK4d0p
 rTGYwK39bDcwMf1UX1rcWth3h7r/1eErfh8hf29YgJ6RFOeFylu0aOU72T1jo0k53Lxa
 uLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765401869; x=1766006669;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=13C105P1DiGJyacizPlfjDr4phSEU7PuKjEWdcYSyks=;
 b=VA5ROikH+Kbet9YoJLpzZfaY6Et34sAvJ8K1+nyFgqbTLfIhCDFtBwv4s/Tr6rWrn1
 bWRAY0kgWQM+b+EV32fVRybVuxhjYpsW8OhWHrIbkOuqBs9oqQfPXcrHaXKwi9+NMLF0
 9J3/XuAvbo8fRLaCuL5w7ETznCfzfjl7HpzHMUHyvkN1iyy4gwOJD28flK6zuInkeFVe
 JMkPI3vD2C8T7UXRNtk8EjvqusUcdevRKzIlejldA/SADoO/dqONVTuQOszZIY5dO28q
 34U0nNwYk20dQxpUlQFObC2cXrd4EtqCa+8slriIPCruDobSinzrlECF8xzr8rkenQjb
 f2YA==
X-Gm-Message-State: AOJu0YzTIf2BUVFh4yU9h/9YUfL6Q5247nBqbA5f4T84r6SDCSQ4KE4Q
 eTHtFQvTPLddgcPQHBqibqFo4TAUoY10Ke0zoYYh9oIY7NIm2XLcjUpaX/ShWHz9yL8=
X-Gm-Gg: AY/fxX622adEDeF2oJlgTI67YVYzcIr/zZrClXcFjZVmmBt6ed21prTM2jmJc8LvIqr
 gy8n5GbQhxtvZsSHexrfLR4i4nRWiudZfwbSUWHZiPTUhs307rsUzWDl8zQ7COamNZdidFvKdr9
 nxGV7rfLj0qIZojCi9MojOUoeI+cyjygzmG/1hvD5FvlK3LXszybhEJqTAIWJQmqmP6sWZBWx+q
 p4FtpYbEBzQSr5KiOLLfOHpTCTuwfDmwmcpNezoHHTElMZYlTxnHwX03dcmalD90fcWnXYk1wZK
 xy2by3sR27xVnEXN6a/zHEiIbuXqjgFHdm9T9cdUhINxgToR22uXmDVQ7QJBgScQsY7o1IJRh4A
 WinzsbyvhOGZAFgKnBpGPaT+0csKTx/JnexkJB61NM7+GdGkI1icK9IQ7OJL3MqfYGT4qTyooit
 KwSd/PXkqneCDMYlHMhbDFtg8p7D6B7D/WRar5PElO9+N0O8Lii5Fl7zG5kVXBu6YjzD21GiE8d
 qswnC8+bA==
X-Google-Smtp-Source: AGHT+IFIH8371pz2f5zI0x9l0Qn2kVr91E8j7j8BzhAN7OkpAFbdJ55xwXFWFy3i6Lr2P0L30MZmIw==
X-Received: by 2002:a05:6000:22c8:b0:42b:3e60:18e9 with SMTP id
 ffacd0b85a97d-42fa39d9366mr3420404f8f.10.1765401869440; 
 Wed, 10 Dec 2025 13:24:29 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-f92a-5586-f2e9-b313.rev.sfr.net.
 [2a02:842a:d52e:6101:f92a:5586:f2e9:b313])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b96c70sm1122254f8f.37.2025.12.10.13.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 13:24:29 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 10 Dec 2025 22:24:22 +0100
Subject: [PATCH 1/3] power: regulator: common: remove unnecessary debug trace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-power-regulator-fix-compilation-v1-1-c58f01e0a5c3@baylibre.com>
References: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
In-Reply-To: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>, 
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 David Lechner <dlechner@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
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

Drop the ftrace like debug() that checkpatch --strict complains about:

  WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/regulator/regulator_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index 685d8735fa5c9a6f98cb6154cd13afcabaeab1ac..ce3d80670de045dde7e263c5301bccd744abd2f5 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -98,7 +98,6 @@ int regulator_common_set_enable(const struct udevice *dev,
 
 	if (enable && plat->startup_delay_us)
 		udelay(plat->startup_delay_us);
-	debug("%s: done\n", __func__);
 
 	if (!enable && plat->off_on_delay_us)
 		udelay(plat->off_on_delay_us);

-- 
2.50.1

